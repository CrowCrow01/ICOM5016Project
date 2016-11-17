# coding: utf-8
from sqlalchemy import Column, Float, ForeignKey, Integer, String, Table, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata


class Advertisement(Base):
    __tablename__ = 'advertisement'

    aid = Column(Integer, primary_key=True, server_default=text("nextval('advertisement_aid_seq'::regclass)"))
    adprice = Column(Float(53))
    duration = Column(Integer)
    addimage = Column(String(250))
    link = Column(String(250))
    adddescription = Column(String(500))


class Artuser(Base):
    __tablename__ = 'artuser'

    uid = Column(Integer, primary_key=True, server_default=text("nextval('artuser_uid_seq'::regclass)"))
    ufirst = Column(String(15))
    ulast = Column(String(15))
    unickname = Column(String(15))
    uemail = Column(String(50))
    passwrd = Column(String(50))
    ustreet = Column(String(100))
    ucity = Column(String(20))
    ustate = Column(String(2))
    uzip = Column(Integer)


class Uphone(Artuser):
    __tablename__ = 'uphone'

    uid = Column(ForeignKey('artuser.uid'), primary_key=True)
    phonenum = Column(String(10))


# class Commission(Artuser):
#     __tablename__ = 'commission'

#     petitioner = Column(ForeignKey('artuser.uid'), primary_key=True)
#     artist = Column(ForeignKey('artuser.uid'))
#     price = Column(Float(53))
#     cdeadline = Column(String(8))
#     ctype = Column(String(15))
#     cdescription = Column(String(250))

#     artuser = relationship('Artuser', primaryjoin='Commission.artist == Artuser.uid')


# class Userreview(Artuser):
#     __tablename__ = 'userreview'

#     uid = Column(ForeignKey('artuser.uid'), primary_key=True)
#     reviewer = Column(ForeignKey('artuser.uid'))
#     comment = Column(String(500))
#     rating = Column(Integer)

#     artuser = relationship('Artuser', primaryjoin='Userreview.reviewer == Artuser.uid')


class Auction(Base):
    __tablename__ = 'auctions'

    aid = Column(Integer, primary_key=True, server_default=text("nextval('auctions_aid_seq'::regclass)"))
    iid = Column(ForeignKey('item.iid'))
    startingbid = Column(Float(53))
    adeadline = Column(String(8))

    item = relationship('Item')


t_bids = Table(
    'bids', metadata,
    Column('aid', ForeignKey('auctions.aid')),
    Column('uid', ForeignKey('artuser.uid')),
    Column('bid', Float(53))
)


class Creditcard(Base):
    __tablename__ = 'creditcard'

    cid = Column(Integer, primary_key=True, server_default=text("nextval('creditcard_cid_seq'::regclass)"))
    uid = Column(ForeignKey('artuser.uid'))
    cname = Column(String(15))
    cnumber = Column(Integer)
    ctype = Column(String(15))
    expdate = Column(String(8))

    artuser = relationship('Artuser')


class Item(Base):
    __tablename__ = 'item'

    iid = Column(Integer, primary_key=True, server_default=text("nextval('item_iid_seq'::regclass)"))
    uid = Column(ForeignKey('artuser.uid'))
    iname = Column(String(15))
    price = Column(Float(53))
    itype = Column(String(15))
    icolor = Column(String(15))
    featured = Column(String(1))
    imageurl = Column(String(250))
    dimensions = Column(String(15))
    idescription = Column(String(250))

    artuser = relationship('Artuser')
    artuser1 = relationship('Artuser', secondary='shoppingcart')


class Itemreview(Item):
    __tablename__ = 'itemreview'

    iid = Column(ForeignKey('item.iid'), primary_key=True)
    reviewer = Column(ForeignKey('artuser.uid'))
    comment = Column(String(500))
    rating = Column(Integer)

    artuser = relationship('Artuser')


t_purchases = Table(
    'purchases', metadata,
    Column('iid', ForeignKey('item.iid')),
    Column('uid', ForeignKey('artuser.uid')),
    Column('qty', Integer),
    Column('shprice', Float(53)),
    Column('shcompany', String(15)),
    Column('totalprice', Float(53)),
    Column('date', String(8))
)


t_shoppingcart = Table(
    'shoppingcart', metadata,
    Column('uid', ForeignKey('artuser.uid')),
    Column('iid', ForeignKey('item.iid'))
)
