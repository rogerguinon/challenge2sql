--Requirement 5: As you may have detected, the conversion tables only have data until 2024-10-24, we need a procedure to insert new data as needed.
--In the action of inserting new conversion data for every currency, two situations can be found:
--1. The last conversion rate has value 0: then we will keep a 0 for further days.
--2. The last conversion is a value >0: then we will pick a random currency conversion value bigger than 0 from some day of the last year.
--Keep in mind that from and to USD conversions should be consistent (it must be the consistent changing from USD to EUR than to EUR to USD). For each currency, the random pick should be different.
--At the moment of execution, this procedure will create conversion entries (new rows) from the next missing day in the conversion tables and until the next day after the execution of the procedure.
--Hint: Try first to populate the next missing day in conversion tables and then automate this action with a LOOP for the rest of the days in the past.
--Hint: Use RAND() and DATE_ADD functions.

DROP PROCEDURE IF EXISTS req05_insert_new_conversion_data;
DELIMITER //

CREATE PROCEDURE req05_insert_new_conversion_data()
BEGIN
    DECLARE current_date DATE;
    DECLARE end_date DATE;
    DECLARE currency_code VARCHAR(3);
    DECLARE last_conversion FLOAT;
    DECLARE random_conversion FLOAT;
    DECLARE done BOOLEAN DEFAULT FALSE;

    SET current_date = (SELECT DATE_ADD(MAX(date), INTERVAL 1 DAY) FROM fx_from_usd);
    SET end_date = (SELECT DATE_ADD(CURDATE(), INTERVAL 1 DAY));

    WHILE current_date <= end_date DO
        DECLARE currency_cursor CURSOR FOR
        SELECT COLUMN_NAME
        FROM information_schema.COLUMNS
        WHERE TABLE_NAME = 'fx_from_usd' AND COLUMN_NAME != 'date';
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

        OPEN currency_cursor;

        currency_loop: LOOP
            FETCH currency_cursor INTO currency_code;
            IF done THEN
                LEAVE currency_loop;
            END IF;

            SELECT MAX(currency_code) INTO last_conversion
            FROM fx_from_usd
            WHERE date = (SELECT DATE_SUB(current_date, INTERVAL 1 DAY));

            IF last_conversion = 0 THEN
                INSERT INTO fx_from_usd (date, currency_code, conversion_rate)
                VALUES (current_date, currency_code, 0);
                INSERT INTO fx_to_usd (date, currency_code, conversion_rate)
                VALUES (current_date, currency_code, 0);
            ELSE
                SELECT conversion_rate INTO random_conversion
                FROM fx_from_usd
                WHERE date = (SELECT DATE_SUB(current_date, INTERVAL 1 YEAR))
                ORDER BY RAND()
                LIMIT 1;

                INSERT INTO fx_from_usd (date, currency_code, conversion_rate)
                VALUES (current_date, currency_code, random_conversion);
                INSERT INTO fx_to_usd (date, currency_code, conversion_rate)
                VALUES (current_date, currency_code, 1 / random_conversion);
            END IF;
        END LOOP;

        CLOSE currency_cursor;
        SET current_date = (SELECT DATE_ADD(current_date, INTERVAL 1 DAY));
    END WHILE;
END //

DELIMITER ;

--Example usage:
--CALL req05_insert_new_conversion_data();