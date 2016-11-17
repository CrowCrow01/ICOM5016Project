#!flask/bin/python
from flask import Flask, render_template, request, url_for, redirect, make_response, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text
import models

app = Flask(__name__)
# conn = psycopg2.connect("dbname=artbay user=postgres")
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:fuckwin8@localhost/artbay'
db = SQLAlchemy(app)
connection = db.session.connection()

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/index')
def index():
    #splash page
    return render_template('ArtBay_HomePage.html')

#generic user
@app.route('/user')
def get_generic_user():
    return render_template('UserProfile.html')
#specific user page
@app.route('/user/<string:uid>', methods = ['GET'])
def get_user(uid):
    #when user tables are implemented the user page will be a template to be
    #filled with the information from the table
    return render_template('genericUserPage.html')
@app.route('/user_edit')
def user_edit():
    return render_template('EditInfo.html')

# @app.route('/user/<string:uid>/reviews')
# def get_reviews(uid):
#     return render_template('genericReviewList.html')

@app.route('/search')
def get_listings():
    #get latest entries from listings table
    return render_template('ArtBay_Search.html')

@app.route('/item')
def get_item():
    return render_template('ItemProfile.html')
@app.route('/create_listing')
def listing_form():
    return render_template('ArtBay_NewItem.html')

#payment confirmation page test
@app.route('/conf')
def confirmation():
    return render_template('PaymentConfirmation.html')

@app.route('/open_requests')
def commissions_list():
    return render_template('CommissionsList.html')

@app.route('/commission')
def commission():
    return render_template('Commissions.html')

@app.route('/cart')
def cart():
    return render_template('MyOrders.html')

@app.route('/newCard')
def add_credit_card():
    return render_template('AddCreditCard.html')

@app.route('/featuredList', methods=['GET'])
def get_featured():
    featured = db.engine.execute("SELECT iname, imageurl FROM item WHERE featured = 't' ORDER BY RANDOM() LIMIT 9") 
    featlist = []
    for row in featured:
        featlist.append({"title":row[0], "url":row[1]})
    return jsonify({"featlist":featlist})
    # return app.send_static_file('homepageRequest.txt')


@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)

from app import app
app.run(debug=True)
