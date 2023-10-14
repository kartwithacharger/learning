/* 1) How many songs made it to the Top 2023 Spotify songs? */
SELECT COUNT(track_name) FROM spotify_2023; 

/* 2) Match the songs to the artists and show year of release */
SELECT track_name, 'artist(s)_name' FROM spotify_2023; 

/* 3) What year was Taylor Swift's most streamed song in? */
CREATE TABLE streamed_songs AS
SELECT track_name, 'artist(s)_name', streams
FROM spotify_2023;
DROP TABLE streamed_songs; --used to delete previously created table
CREATE TABLE streamed_songs AS
SELECT track_name, [artist(s)_name], streams
FROM spotify_2023;
SELECT track_name, MAX(streams) FROM streamed_songs
WHERE [artist(s)_name] in('Taylor Swift');

/* 4) Which artist had the highest number of songs in the Top 2023 and what was the name of the highest streamed song? */
SELECT [artist(s)_name]
    , COUNT([artist(s)_name]) AS 'count'
    , track_name FROM streamed_songs
GROUP BY [artist(s)_name]
ORDER BY count DESC; 

/* 5) Which was the most streamed song?*/
SELECT track_name, streams FROM streamed_songs
ORDER BY streams DESC; 
-- this resulted in track name Love Grows (Where My Rosemary Goes) being top result with streams as 'BPM110KeyAModeMajorDanceability53Valence75Energy69Acousticness7Instrumentalness0Liveness17Speechiness3'
--Aim is fix the value of this column to, e.g. 683909487
UPDATE spotify_2023
SET streams = (SELECT 683909487 FROM streamed_songs WHERE track_name = 'Love Grows (Where My Rosemary Goes)')
WHERE track_name = 'Love Grows (Where My Rosemary Goes)'; --this only fixed relevant column in table spotify_2023

UPDATE streamed_songs 
SET streams = 683909487
WHERE track_name = 'Love Grows (Where My Rosemary Goes)'; -- additional query to individually changed second table 'streamed_songs'

SELECT track_name, streams FROM streamed_songs
ORDER BY streams DESC; -- answer to Question 5) Which was the most streamed song?

/* 6) Is there a positive correlation between most streamed song vs release year? */
SELECT track_name, streams FROM streamed_songs
ORDER BY streams DESC; -- query to find most stream song. 

ALTER TABLE release_date
DROP COLUMN track_name; -- to delete a column (stuffed up my last add)

ALTER TABlE release_date
ADD COLUMN track_name text; -- to add new column to table 'release_date'

UPDATE release_date
SET track_name = (SELECT track_name FROM spotify_2023); -- to put in values from original column from spotify_2023 table to the new 'release_date' table

------ERROR ABOVE RESULT REPLACES TRACK NAME W ITH THE SAME TRACK NAME?!?!?! continue working on this ---