#!flask/bin/python
from flask import Flask, render_template, request, url_for, redirect, make_response, jsonify, session
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text
import models

app = Flask(__name__)
# conn = psycopg2.connect("dbname=artbay user=postgres")
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:fuckwin8@localhost/artbay'
db = SQLAlchemy(app)
connection = db.session.connection()

# set the secret key.  keep this really secret:
app.secret_key = 'password'

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/loginverify', methods = ['POST'])
def verify():
    user = request.form['username']
    pword = request.form['password']
    verification = db.engine.execute("SELECT passwrd, uid, unickname FROM artuser WHERE unickname = %s", (user))
    array = []
    for row in verification:
        array.append({"passw":row[0]})
        uid = row[1]
        # print(array)
    if (len(array)==0):
        return make_response('username does not exist', 200)
    elif (array[0] == {"passw":pword}):
        session['userinfo'] = {"username":user, "uid":uid}
        return redirect(url_for('index'))
    else: 
        return make_response('password invalid', 200)


@app.route('/index')
def index():
    #splash page
    print (session['userinfo'])
    return render_template('ArtBay_HomePage.html')

@app.route('/register')
def register():
    return render_template('NewUser.html')

#generic user
@app.route('/user/<string:uid>')
def get_generic_user(uid):
    return render_template('UserProfile.html')#, UserID = uid)
#specific user page
@app.route('/getuser/<string:uid>', methods = ['GET'])
def get_user(uid):
    users = db.engine.execute("SELECT uid, ufirst, ulast, unickname, uemail, upicture FROM artuser WHERE uid = %s", (uid))
    user = []
    for row in users:
        user.append({"uname":row[1], "lastname":row[2], "nick":row[3], "email":row[4], "upicture":row[5]})
    items = db.engine.execute("SELECT iname, imageurl, iid FROM item WHERE uid = %s", (uid))
    for row in items:
        user.append({"iname":row[0], "imageurl":row[1], "iid":row[2]})
    print (user)
    return jsonify({"userinfo":user})

@app.route('/user_edit')
def user_edit():
    return render_template('EditInfo.html')

@app.route('/create_user', methods = ['POST'])
def user_creation():
    username = request.form['username']
    duplicate_check = db.engine.execute("SELECT unickname FROM artuser WHERE unickname = %s", (username))
    dupe = []
    for row in duplicate_check:
        dupe.append({"nick":row[0]})

    if (len(dupe)==0):
        fname = request.form['fname']
        lname = request.form['lname']
        email = request.form['email']
        pword = request.form['pword']
        # phone = request.form['pnumber']
        state = request.form['state']
        city = request.form['city']
        zipc = int(request.form['zipc'])
        street = request.form['street']
        db.engine.execute("INSERT INTO artuser (ufirst, ulast, unickname, uemail, passwrd, ustate, ucity, uzip, ustreet) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', %d, '%s')" % (fname, lname, username, email, pword, state, city, zipc, street))
        return make_response("done", 200)
    else:
        return make_response('username taken', 200)

@app.route('/newItem', methods=['POST'])
def sale_posting():
    itemurl = request.form['imageurl']
    iname = request.form['itemname']
    itype = request.form['itemtype']
    price = float(request.form['price'])
    color = request.form['itemcolor']
    featFlag = request.form['featuredRadio']
    auctionFlag = request.form['auctionRadio']
    description = request.form['desc']
    deadline = request.form['deadline']
    db.engine.execute("INSERT INTO item (uid, iname, price, itype, icolor, featured, imageurl, idescription) VALUES ('%s', '%s', %f, '%s', '%s', '%s', '%s', '%s')" % (session['userinfo']['uid'], iname, price, itype, color, featFlag, itemurl, description))
    if (auctionFlag == 't'):
        auctionedItemID = []
        itemquery = db.engine.execute("SELECT I.iid FROM item AS I WHERE I.iname = '%s' AND I.uid = %s" % (iname, session['userinfo']['uid']))
        for row in itemquery:
            auctionedItemID.append({"iid":row[0]})
            print (auctionedItemID)
        db.engine.execute("INSERT INTO auctions (iid, startingbid, adeadline) VALUES ('%s', %f, '%s')" % (auctionedItemID[0]['iid'], price, deadline))
    return redirect(url_for('index'))

# @app.route('/user/<string:uid>/reviews')
# def get_reviews(uid):
#     return render_template('genericReviewList.html')

@app.route('/search')
def get_listings():
    #get latest entries from listings table
    return render_template('ArtBay_Search.html')

# @app.route('/search/<string:term>', methods=['GET'])
# def searchresult(term):
        # likeness = '%' + term + "%"
#     searchlist = db.engine.execute("SELECT I.imageurl, U.unickname, I.itype, I.idescription, I.iname FROM artuser AS U, item AS I WHERE U.uid = I.uid")#, (term))
#     images = []
#     for row in results:
#         images.append({"url":row[0], "artist":row[1], "type":row[2], "descr":row[3], "title":row[4]})
#     print (images)
#     return jsonify({"images":images})

@app.route('/auction_house/<string:word>', methods=['GET'])
def get_auctions(word):
    images = []
    results = db.engine.execute("SELECT I.imageurl, U.unickname, I.itype, I.idescription, I.iname, I.iid, A.aid, A.startingbid, FROM artuser AS U, item AS i, auctions AS A WHERE U.uid = I.uid AND I.iid = A.iid and I.iname LIKE '%%" + word + "%%'")
    for row in results:
        images.append({"url":row[0], "artist":row[1], "type":row[2], "descr":row[3], "title":row[4], "itemid":row[5], "auctionid":row[6], "initialbid":row[7]})
    return jsonify({"images":images})

@app.route('/searchResults/<string:word>', methods=['GET'])
def get_results(word):
                                                                                                                                                #TODO BREAKING
    term = "SELECT I.imageurl, U.unickname, I.itype, I.idescription, I.iname, I.iid FROM artuser AS U, item AS I WHERE U.uid = I.uid AND I.iname LIKE '%%" + word + "%%'"
    # print ("%s", term)
    results = db.engine.execute(term)
    # for row in results:
        # print (row)
    images = []
    for row in results:
        images.append({"url":row[0], "artist":row[1], "type":row[2], "descr":row[3], "title":row[4], "itemid":row[5]})
    # print (images)
    return jsonify({"images":images})
@app.route('/searchResults/', methods=['GET'])
def empty_search():
    images = []
    images.append({"url":"http://i.imgur.com/ZuE8EYG.jpg"})
    return jsonify({"images":images})

@app.route('/item/<string:iid>')
def get_generic_item(iid):
    return render_template('ItemProfile.html', itemID = iid)

@app.route('/getitem/<string:iid>', methods = ['GET'])
def get_item(iid):
    itemlist = db.engine.execute("SELECT I.iname, I.price, U.unickname, I.itype, I.imageurl, I.uid, I.idescription FROM item AS I, artuser AS U WHERE iid = %s AND I.uid = U.uid", (iid))
    item = []
    for row in itemlist:
        item.append({"title":row[0], "artist":row[2], "price":row[1], "type":row[3], "imageurl":row[4], "artistID":row[5], "description":row[6]})
    return jsonify({"item":item[0]})

@app.route('/create_listing')
def listing_form():
    return render_template('ArtBay_NewItem.html')

#payment confirmation page test
@app.route('/conf')
def confirmation():
    return render_template('PaymentConfirmation.html')

@app.route('/orderinfo/<string:itemid>')
def saleinfo(itemid):
    orderlist = db.engine.execute("SELECT I.iname, I.price FROM item AS I WHERE iid = %s ", (itemid))
    for row in orderlist:
        order = {"title":row[0], "orderID":10324, "shipdate":"December 25, 2016", "buyer":"StephenVC", "address":"Mayaguez", "itemprice":row[1], "shipprice":25.00, "totalprice":row[1]+25.00}
    print (order)
    return jsonify(order)

@app.route('/open_requests')
def commissions_list():
    return render_template('CommissionsList.html')

@app.route('/commission')
def commission():
    return render_template('Commissions.html')

@app.route('/orders')
def getOrders():
    return render_template('MyOrders.html')

@app.route('/cart')
def getCart():
    return render_template('cart.html')

@app.route('/newCard')
def add_credit_card():
    return render_template('AddCreditCard.html')

@app.route('/featuredList', methods=['GET'])
def get_featured():
    featured = db.engine.execute("SELECT iname, imageurl, iid FROM item WHERE featured = 't' ORDER BY RANDOM() LIMIT 9") 
    featlist = []
    for row in featured:
        featlist.append({"title":row[0], "url":row[1], "iid":row[2]})
    return jsonify({"featlist":featlist})

@app.route('/plsno')
def facebook():
    return make_response(jsonify("Please don't make me actually implement this."))

@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)

from app import app
app.run(debug=True)