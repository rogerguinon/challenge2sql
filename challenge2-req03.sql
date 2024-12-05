/*Create a new procedure that given two parameters (date to be checked, and currency code)
returns in another parameter FALSE if the given date is not present in conversion tables (check
both tables) or the value for our specified currency and date is 0 or null. Return TRUE otherwise.
Hint: you may need to use a prepared statement.*/

DROP PROCEDURE IF EXISTS validate_date_currency;
DELIMITER //
CREATE PROCEDURE validate_date_currency(
    IN check_date DATE,
    IN currency_code VARCHAR(3),
    OUT is_valid BOOLEAN
)
BEGIN
    DECLARE count INT;
    SET is_valid = FALSE;
    SET @query = CONCAT(
        "SELECT COUNT(*) INTO @count FROM fx_from_usd WHERE date = ? AND `", currency_code, "` > 0 AND `", currency_code, "` IS NOT NULL"
    );

    PREPARE stmt FROM @query;
    EXECUTE stmt USING @check_date;
	SELECT count;
    IF @count > 0 THEN
        SET is_valid = TRUE;
    ELSE
        SET @query = CONCAT(
            "SELECT COUNT(*) INTO @count FROM fx_to_usd WHERE date = ? AND `", currency_code, "` > 0 AND `", currency_code, "` IS NOT NULL"
        );

        PREPARE stmt FROM @query;
        EXECUTE stmt USING @check_date;

        IF @count > 0 THEN
            SET is_valid = TRUE;
        END IF;
    END IF;

    DEALLOCATE PREPARE stmt;
END //
