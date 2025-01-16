-- Задание 2
-- Название и продолжительность самого длительного трека
select title, duration 
from tracks t 
ORDER BY duration desc 
LIMIT 1;

-- Название треков, продолжительность которых не менее 3,5 минут
select title, duration 
from tracks t 
where duration >= 210;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно
select title, year
from collections c 
where year >= 2018 and year <= 2020;

-- Исполнители, чьё имя состоит из одного слова
select name
from performers p 
where name not like '% %'

/*Доработка запроса*/
-- Название треков, которые содержат слово «мой» или «my»
-- Способ 1
select title 
from tracks t 
where 
(title) ilike 'my %'
or (title) ilike '% my'
or (title) ilike '% my %'
or (title) ilike 'my'

-- Название треков, которые содержат слово «мой» или «my»
-- Способ 2
select title 
from tracks t 
where 
string_to_array(lower(title), ' ') && ARRAY['my'];

-- Название треков, которые содержат слово «мой» или «my»
-- Способ 3
select title 
from tracks t 
where 
lower(title) ILIKE ANY(ARRAY['my %', '% my', '% my %', 'my']);

-- Название треков, которые содержат слово «мой» или «my»
-- Способ 4
select title 
from tracks t 
where 
title ~* '(^| )my( |$)'

-- Задание 3
-- Количество исполнителей в каждом жанре
select g.name as genre_name, count(p.id) as performer_count
from genres g
join performers_genres pg on g.id = pg.genre_id
join performers p on pg.performers_id = p.id
group by g.name;

/*Доработка запроса*/
-- Количество треков, вошедших в альбомы 2019–2020 годов, меняем на имеющиеся 2003-2017
select count(a.id) as track_count
from albums a 
join tracks t on t.album_id = a.id
where a.year between 2003 and 2017

-- Средняя продолжительность треков по каждому альбому
select a.title as album_name, avg(t.duration) as average_duration
from albums a 
join tracks t on t.album_id = a.id
group by a.title;

/*Доработка запроса*/
-- Все исполнители, которые не выпустили альбомы в 2020 году, меняем на 2010
SELECT distinct name as performer_name /* Получаем имена исполнителей */
FROM performers p  /* Из таблицы исполнителей */
WHERE name NOT IN ( /* Где имя исполнителя не входит в вложенную выборку */
    SELECT name /* Получаем имена исполнителей */
    FROM performers /* Из таблицы исполнителей */
    join performers_albums pa on pa.performers_id = p.id /* Объединяем с промежуточной таблицей */
    JOIN albums a ON a.id = pa.album_id /* Объединяем с таблицей альбомов */
    WHERE a.year = 2010 /* Где год альбома равен 2020 */
);

-- Названия сборников, в которых присутствует конкретный исполнитель
select c.title as collection_name, p.name as perfomer_name
from collections c 
join collections_tracks ct on ct.collections_id = c.id
join tracks t on t.id = ct.track_id
join albums a on a.id = t.album_id 
join performers_albums pa on pa.album_id = a.id 
join performers p on p.id = pa.performers_id 
where p.name = 'Linkin Park'
group by c.title, p.name;

-- Задание 4

/*Доработка запроса*/
-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра
select a.title as album_name
from albums a
join performers_albums pa on a.id = pa.album_id
join performers p on p.id = pa.performers_id 
join performers_genres pg on p.id = pg.performers_id
join genres g on g.id = pg.performers_id 
group by a.title, p.id
having count(pg.genre_id) > 1;

/*Доработка запроса*/
-- Наименования треков, которые не входят в сборники
select t.title as track_name
from tracks t
left join collections_tracks ct on t.id = ct.track_id
where ct.track_id is null;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек
with min_duration as (
    select min(duration) as min_duration
    from tracks
)
select p.name as performer_name
from performers p
join performers_albums pa on p.id = pa.performers_id
join albums a on pa.album_id = a.id
join tracks t on a.id = t.album_id
where t.duration = (select min_duration from min_duration);

--Названия альбомов, содержащих наименьшее количество треков
with track_counts as (
    select a.title, count(t.id) as track_count
    from albums a
    join tracks t on a.id = t.album_id
    group by a.title
)
select title as album
from track_counts
where track_count = (select min(track_count) from track_counts);
