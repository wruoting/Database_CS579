CREATE TABLE CARDS (
    uuid varchar2(36) NOT NULL PRIMARY KEY,
    name varchar2(100),
    color varchar2(100),
    loyalty varchar2(10),
    mana_cost varchar2(100),
    text varchar2(100),
    type varchar2(100),
    power varchar2(3),
    toughness varchar2(3)
);

CREATE TABLE DECK (
    uuid varchar2(24) NOT NULL,
    username varchar2(100) NOT NULL,
    copies INT,
    PRIMARY KEY (uuid, username)
);

CREATE TABLE USERS (
    username varchar2(100) NOT NULL PRIMARY KEY,
    password varchar2(100),
    name varchar2(100),
    email varchar2(100)
);

CREATE TABLE PRICE (
    uuid varchar2(24) NOT NULL PRIMARY KEY,
    price float,
    listing_date date
);
