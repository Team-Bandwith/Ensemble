DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS friend;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS song_user;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS invite;

CREATE TABLE member (
  id serial PRIMARY KEY,
  username VARCHAR (50) UNIQUE NOT NULL,
  url_avatar VARCHAR (255),
  email VARCHAR (50) NOT NULL,
  password VARCHAR (255) NOT NULL
);

CREATE TABLE friend (
  id serial PRIMARY KEY,
  id_user_to int NOT NULL,
  id_user_from int NOT NULL,
  created_at timestamp
);

CREATE TABLE message (
  id serial PRIMARY KEY,
  id_user_to int NOT NULL,
  id_user_from int NOT NULL,
  text VARCHAR (255),
  type VARCHAR (50),
  created_at timestamp
);

CREATE TABLE invite (
  id serial PRIMARY KEY,
  id_user_to int NOT NULL,
  id_user_from int NOT NULL,
  link VARCHAR (255),
  created_at timestamp
);

CREATE TABLE comment (
  id serial PRIMARY KEY,
  id_user int NOT NULL,
  id_song int NOT NULL,
  text VARCHAR (255),
  created_at timestamp
);

CREATE TABLE song_user (
  id serial PRIMARY KEY,
  id_user int NOT NULL,
  id_song int NOT NULL,
  type VARCHAR (50) NOT NULL
);

CREATE TABLE song (
  id serial PRIMARY KEY,
  id_author int NOT NULL,
  name VARCHAR (50) NOT NULL,
  url VARCHAR (255) NOT NULL,
  count_likes int DEFAULT 0,
  public BOOLEAN NOT NULL,
  created_at timestamp
);

-- dummy data

INSERT INTO member (username, email, url_avatar, password)
VALUES ('Ensemble', 'ensemble@ensemble.com', 'https://res.cloudinary.com/my-ensemble/image/upload/v1589993902/ynga4emqrtetmrcxjhiw.png', 'none');
