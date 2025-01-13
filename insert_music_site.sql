-- Добавляем жанры
INSERT INTO genres (name) VALUES
('Рок'),
('Поп'),
('Хип-хоп'),
('Электронная музыка');

-- Добавляем исполнителей
INSERT INTO performers (name) VALUES
('Linkin Park'),
('Bruno Mars'),
('Eminem'),
('The Chemical Brothers');

-- Добавляем альбомы
INSERT INTO albums (title, year) VALUES
('Meteora', 2003),
('Unorthodox Jukebox', 2012),
('Revival', 2017),
('Born in the Echoes', 2015);

-- Добавляем треки
INSERT INTO tracks (title, duration, album_id) VALUES
('Faint', 180, 1),
('Somewhere I Belong', 240, 1),
('Locked Out of Heaven', 300, 2),
('Treasure', 270, 2),
('Walk on Water', 360, 3),
('River', 390, 3),
('Go', 480, 4),
('Under Neon Lights', 420, 4);

-- Добавляем сборники
INSERT INTO collections (title, year) VALUES
('Best Rock Hits', 2020),
('Pop Party Mix', 2021),
('Hip-Hop Anthems', 2022),
('Electronic Beats', 2023);

-- Связываем исполнителей с жанрами
INSERT INTO performers_genres (performers_id, genre_id) VALUES
(1, 1), -- Linkin Park - Рок
(2, 2), -- Bruno Mars - Поп
(3, 3), -- Eminem - Хип-хоп
(4, 4); -- The Chemical Brothers - Электронная музыка

-- Связываем исполнителей с альбомами
INSERT INTO performers_albums (performers_id, album_id) VALUES
(1, 1), -- Linkin Park - Meteora
(2, 2), -- Bruno Mars - Unorthodox Jukebox
(3, 3), -- Eminem - Revival
(4, 4); -- The Chemical Brothers - Born in the Echoes

-- Связываем сборники с треками
INSERT INTO collections_tracks (collections_id, track_id) VALUES
(1, 1), -- Best Rock Hits - Faint
(1, 5), -- Best Rock Hits - Walk on Water
(2, 3), -- Pop Party Mix - Locked Out of Heaven
(2, 4), -- Pop Party Mix - Treasure
(3, 6), -- Hip-Hop Anthems - River
(4, 7); -- Electronic Beats - Go
