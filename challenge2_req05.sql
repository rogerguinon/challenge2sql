USE P201_05_challange2_music_festival;

DROP PROCEDURE IF EXISTS req05_populate_conversion_data;
DROP PROCEDURE IF EXISTS insert_new_data;

DELIMITER //
CREATE PROCEDURE insert_new_data()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE curr_date DATE;
    DECLARE next_day DATE;
    DECLARE currency_column VARCHAR(64);
    DECLARE last_rate DECIMAL(10, 6);
    DECLARE random_rate DECIMAL(10, 6);
    DECLARE max_date DATE;
    
    -- Cursor to iterate over currencies
    DECLARE currency_cursor CURSOR FOR
        SELECT COLUMN_NAME
        FROM information_schema.COLUMNS
        WHERE TABLE_NAME = 'fx_from_usd'
        AND TABLE_SCHEMA = 'your_database_name'
        AND COLUMN_NAME != 'DATE';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Determine the maximum date in the table and the next day to populate
    SELECT MAX(DATE) INTO max_date FROM fx_from_usd;
    SET curr_date = max_date + INTERVAL 1 DAY;
    SET next_day = CURRENT_DATE + INTERVAL 1 DAY;

    -- Cursor loop for each currency
    OPEN currency_cursor;
    currency_loop: LOOP
        FETCH currency_cursor INTO currency_column;
        IF done THEN
            LEAVE currency_loop;
        END IF;

        -- Get the last rate for this currency
        SET @query = CONCAT('SELECT `', currency_column, '` INTO @last_rate FROM fx_from_usd WHERE DATE = "', max_date, '"');
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        -- Populate data for missing days
        WHILE curr_date <= next_day DO
            IF @last_rate = 0 THEN
                -- Keep rate as 0 if the last rate was 0
                SET @query = CONCAT('INSERT INTO fx_from_usd (DATE, `', currency_column, '`) VALUES ("', curr_date, '", 0)');
                PREPARE stmt FROM @query;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;

                SET @query = CONCAT('INSERT INTO fx_to_usd (DATE, `', currency_column, '`) VALUES ("', curr_date, '", 0)');
                PREPARE stmt FROM @query;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;

            ELSE
                -- Generate a random rate from the past year's data
                SET @query = CONCAT(
                    'SELECT `', currency_column, '` INTO @random_rate ',
                    'FROM fx_from_usd ',
                    'WHERE `', currency_column, '` > 0 ',
                    'AND DATE >= DATE_SUB("', max_date, '", INTERVAL 1 YEAR) ',
                    'ORDER BY RAND() LIMIT 1'
                );
                PREPARE stmt FROM @query;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;

                -- Insert the generated rate
                SET @query = CONCAT('INSERT INTO fx_from_usd (DATE, `', currency_column, '`) VALUES ("', curr_date, '", ', @random_rate, ')');
                PREPARE stmt FROM @query;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;

                -- Insert the reciprocal rate into fx_to_usd
                SET @query = CONCAT('INSERT INTO fx_to_usd (DATE, `', currency_column, '`) VALUES ("', curr_date, '", ', 1 / @random_rate, ')');
                PREPARE stmt FROM @query;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
            END IF;

            SET curr_date = curr_date + INTERVAL 1 DAY;
        END WHILE;

        -- Reset curr_date for the next currency
        SET curr_date = max_date + INTERVAL 1 DAY;
    END LOOP;

    CLOSE currency_cursor;
END//
