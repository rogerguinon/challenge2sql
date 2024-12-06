DROP TRIGGER IF EXISTS req09_fake_data_lew_sid;
DELIMITER //

CREATE TRIGGER req09_fake_data_lew_sid
AFTER INSERT ON show_song
FOR EACH ROW
BEGIN 
    IF NEW.title != 'Fried rice' THEN
        INSERT INTO show_song (id_show, title, version, written_by, ordinality) 
        VALUES (NEW.id_show, 'Fried rice', 'Original', 'Lew Sid', NEW.ordinality + 1);
    END IF;
END //
DELIMITER ;
