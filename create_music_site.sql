CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);
CREATE TABLE performers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(250) NOT NULL
);
CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    year SMALLINT CHECK(year >= 1900 AND year <= 2100)
);
CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    duration INT CHECK(duration > 0),
    album_id INT REFERENCES albums(id)
);
CREATE TABLE collections (
    id SERIAL PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    year SMALLINT CHECK(year >= 1900 AND year <= 2100)
);
CREATE TABLE performers_genres (
    performers_id INT REFERENCES performers(id),
    genre_id INT REFERENCES genres(id),
    PRIMARY KEY (performers_id, genre_id)
);
CREATE TABLE performers_albums (
    performers_id INT REFERENCES performers(id),
    album_id INT REFERENCES albums(id),
    PRIMARY KEY (performers_id, album_id)
);
CREATE TABLE collections_tracks (
    collections_id INT REFERENCES collections(id),
    track_id INT REFERENCES tracks(id),
    PRIMARY KEY (collections_id, track_id)
);
