DROP FUNCTION IF EXISTS currency_exists;
DELIMITER //
CREATE FUNCTION currency_exists (currency_code VARCHAR(3))
RETURNS BOOLEAN

BEGIN
    DECLARE currency_exists BOOLEAN;
    DECLARE currency_code_uppercase VARCHAR(3);
    SET currency_code_uppercase = UPPER(currency_code);
    IF currency_code_uppercase = 'USD' THEN
        SET currency_exists = TRUE;
    ELSE
        SELECT COUNT(*) > 0 INTO currency_exists
        FROM information_schema.COLUMNS
        WHERE TABLE_NAME = 'fx_from_usd' AND COLUMN_NAME = currency_code_uppercase
        OR TABLE_NAME = 'fx_to_usd' AND COLUMN_NAME = currency_code_uppercase;
    END IF;
    RETURN currency_exists;
END
//
