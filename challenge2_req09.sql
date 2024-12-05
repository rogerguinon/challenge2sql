--Requirement 9: Eventhough we already provided all music festivals with food dishes that include rice and vegetables, the artist Lew Sid is now angry because Hanumandkind and Kalmi are generating more Youtube views with their new song ‘Big Dawgs’.
--So he hired a hacker in order to manipulate the played songs in the festivals. The hacker inserted the data of Lew Sid’s song called ‘Fried rice’ in the database and he also created a programmed virus that, for each song played in a show, it will create fake data inserting a new row for Lew’s song as if it were also played in the same show.
--The goal of Lew Sid is to make his song the most played one and it seems that you are the hacker. Help him or pay the consequences.

--Two solutions are provided: a trigger and a procedure.
--Trigger:
DROP TRIGGER IF EXISTS req09_fake_data_lew_sid;
DELIMITER //

CREATE TRIGGER req09_fake_data_lew_sid
AFTER INSERT ON show_song
FOR EACH ROW
BEGIN 
    IF NEW.title != 'Fried rice' THEN
        INSERT INTO show_song (id_show, title, version, written_by, ordinality) 
        VALUES (NEW.id_show, 'Fried rice', 'Original', 'Lew Sid', NEW.ordinality + 1); --Check the name of the artist, song and version.
    END IF;
END //

DELIMITER ;

--Example usage:
--INSERT INTO show_song (id_show, title, version, written_by, ordinality) VALUES (1, 'Fried rice', 'Original', 'Lew Sid', 1); -- Example with show_id = 1, song_title = 'Fried rice', song_version = 'Original', song_written_by = 'Lew Sid', song_ordinality = 1

--Procedure:
DROP PROCEDURE IF EXISTS req09_fake_data_lew_sid;
DELIMITER //

CREATE PROCEDURE req09_fake_data_lew_sid(IN show_id INT, IN song_title VARCHAR(50), IN song_version VARCHAR(50), IN song_written_by VARCHAR(50), IN song_ordinality INT)
BEGIN
    INSERT INTO show_song (id_show, title, version, written_by, ordinality) 
    INSERT INTO show_song (id_show, song_title, song_version, song_written_by, song_ordinality);

    IF song_title != 'Fried rice' THEN
        INSERT INTO show_song (id_show, title, version, written_by, ordinality) 
        VALUES (show_id, 'Fried rice', 'Original', 'Lew Sid', song_ordinality + 1); --Check the name of the artist, song and version.
    END IF;
END //

DELIMITER ;

--Example usage:
--CALL req09_fake_data_lew_sid(1, 'Fried rice', 'Original', 'Lew Sid', 1); -- Example with show_id = 1, song_title = 'Fried rice', song_version = 'Original', song_written_by = 'Lew Sid', song_ordinality = 1

