/*Create a new procedure that given two parameters (date to be checked, and currency code)
returns in another parameter FALSE if the given date is not present in conversion tables (check
both tables) or the value for our specified currency and date is 0 or null. Return TRUE otherwise.
Hint: you may need to use a prepared statement.*/

DELIMITER //

DROP PROCEDURE IF EXISTS validate_date_currency;

CREATE PROCEDURE validate_date_currency(
    IN check_date DATE,
    IN currency_code VARCHAR(3),
    OUT is_valid BOOLEAN
)
BEGIN
    DECLARE count_entries INT;
    SET is_valid = FALSE;

    -- Prepared statement to dynamically query both conversion tables
    SET @query = CONCAT(
        "SELECT COUNT(*) INTO @count_entries FROM conversion_table_1 WHERE date_field = ? AND `",
        currency_code, "` > 0 AND `", currency_code, "` IS NOT NULL"
    );

    PREPARE stmt FROM @query;
    EXECUTE stmt USING check_date;

    IF @count_entries > 0 THEN
        SET is_valid = TRUE;
    ELSE
        -- Repeat for second conversion table
        SET @query = CONCAT(
            "SELECT COUNT(*) INTO @count_entries FROM conversion_table_2 WHERE date_field = ? AND `",
            currency_code, "` > 0 AND `", currency_code, "` IS NOT NULL"
        );

        PREPARE stmt FROM @query;
        EXECUTE stmt USING check_date;

        IF @count_entries > 0 THEN
            SET is_valid = TRUE;
        END IF;
    END IF;

    DEALLOCATE PREPARE stmt;
END //
