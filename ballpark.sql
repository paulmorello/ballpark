CREATE DATABASE ballpark;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(400),
  username VARCHAR (300),
  password_digest VARCHAR (300),
  favorite_id INTEGER,
  video_id INTEGER,
  photo_id INTEGER
);

CREATE TABLE videos (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(400),
  description TEXT,
  video_url TEXT,
  sport_id INTEGER,
  user_id INTEGER
);

CREATE TABLE photos (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(400),
  description TEXT,
  photo_url TEXT,
  sport_id INTEGER,
  user_id INTEGER
);

CREATE TABLE sports (
  id SERIAL4 PRIMARY KEY,
  name TEXT
);

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  body TEXT,
  video_id INTEGER,
  photo_id INTEGER,
  user_id INTEGER
);

CREATE TABLE favorites (
  id SERIAL4 PRIMARY KEY,
  video_id INTEGER,
  photo_id INTEGER,
  user_id INTEGER
);

ALTER TABLE photos ADD image TEXT;

ALTER TABLE videos ADD video TEXT;
