/*Create a new procedure that given two parameters (date to be checked, and currency code)
returns in another parameter FALSE if the given date is not present in conversion tables (check
both tables) or the value for our specified currency and date is 0 or null. Return TRUE otherwise.
Hint: you may need to use a prepared statement.*/

DELIMITER //

CREATE PROCEDURE CheckDateCurrency(
    IN check_date DATE,
    IN currency_code VARCHAR(3),
    OUT is_valid BOOLEAN
)
BEGIN
    DECLARE row_count INT;

    SET is_valid = FALSE;

    IF currency_exists(currency_code) THEN
    
        SELECT COUNT(*)
        INTO row_count
        FROM (
            SELECT value
            FROM fx_from_usd
            WHERE date = check_date AND COLUMN_NAME = UPPER(currency_code) AND IFNULL(value, 0) <> 0
            UNION ALL
            SELECT value
            FROM fx_to_usd
            WHERE date = check_date AND COLUMN_NAME = UPPER(currency_code) AND IFNULL(value, 0) <> 0
        ) AS valid_rows;

        SET is_valid = (row_count > 0);
    END IF;
END//