--Create a new function that given a currency code returns TRUE if the currency code exists or FALSE if it does not exist. Input should always be capitalised once we receive the parameter.
-- Hint: For a currency code to exist, it should be USD or appear in any of the two conversion tables where you import your CSV as a column name.
-- Hint: use information_schema.COLUMNS
DROP FUNCTION IF EXISTS currency_exists;
DELIMITER //
CREATE FUNCTION currency_exists (currency_code VARCHAR(3))
RETURNS BOOLEAN

BEGIN
    DECLARE currency_exists BOOLEAN;
    DECLARE currency_code_uppercase VARCHAR(3);
    SET currency_code_uppercase = UPPER(currency_code);
    SELECT COUNT(*) > 0 INTO currency_exists
    FROM information_schema.COLUMNS
    WHERE TABLE_NAME = 'fx_from_usd' AND COLUMN_NAME = currency_code_uppercase
    OR TABLE_NAME = 'fx_to_usd' AND COLUMN_NAME = currency_code_uppercase;
    RETURN currency_exists;
END
//