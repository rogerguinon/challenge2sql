DROP TABLE IF EXISTS payments;
DROP PROCEDURE IF EXISTS handle_payment;

CREATE TABLE payments (
    id_transaction INT AUTO_INCREMENT PRIMARY KEY,
    transaction_source ENUM('beerman', 'bar') NOT NULL,
    transaction_datetime DATETIME NOT NULL,
    price_usd DECIMAL(10, 2) NOT NULL,
    id_buyer INT NOT NULL,
    default_currency VARCHAR(3) NOT NULL,
    converted_price DECIMAL(10, 2) NOT NULL,
    payment_status BOOLEAN NOT NULL,
    error_message VARCHAR(255) DEFAULT NULL
);

DELIMITER //

CREATE PROCEDURE handle_payment(
    IN transaction_source ENUM('beerman', 'bar'),
    IN id_buyer INT,
    IN price_usd DECIMAL(10, 2),
    IN transaction_datetime DATETIME,
    OUT error_message VARCHAR(255)
)
BEGIN
    DECLARE default_currency VARCHAR(3);
    DECLARE price_temp DECIMAL(10,2);
    DECLARE converted_price DECIMAL(10, 2);
    DECLARE payment_status BOOLEAN;
    DECLARE conversion_error VARCHAR(255);

    SET error_message = NULL;

    -- Determine default currency using get_preferred_currency funtion
    SET default_currency = get_preferred_currency(id_buyer);

    -- If default currency is NULL, pick a random currency that does not default to 0 in conversion tables
    IF default_currency IS NULL THEN
        SELECT COLUMN_NAME INTO default_currency
        FROM information_schema.COLUMNS
        WHERE TABLE_NAME = 'fx_from_usd' AND COLUMN_NAME NOT IN ('date') AND COLUMN_NAME <> 'USD' AND COLUMN_NAME IS NOT NULL
        ORDER BY RAND()
        LIMIT 1;
    END IF;

    -- Assume a price of 3 USD if the transaction is from the beerman team
    IF transaction_source = 'beerman' THEN
        SET price_usd = 3;
    END IF;
    
    SET price_temp = price_usd; -- We use the price_temp variable as the INOUT parameter for the convert_currency procedure, because it will change and we need the price_usd variable value later

    -- Convert price to default currency
    SET default_currency = UPPER(default_currency);
    CALL convert_currency('USD', default_currency, transaction_datetime, price_temp, conversion_error);
    
    SET converted_price = price_temp; -- Assign the converted value to converted_price

    -- Set payment status and error message
    IF conversion_error IS NULL THEN
        SET payment_status = TRUE;
    ELSE
        SET payment_status = FALSE;
        SET error_message = conversion_error;
        SET converted_price = 0;
    END IF;

    -- Insert the payment record into the payments table
    INSERT INTO payments (
        transaction_source,
        transaction_datetime,
        price_usd,
        id_buyer,
        default_currency,
        converted_price,
        payment_status,
        error_message
    ) VALUES (
        transaction_source,
        transaction_datetime,
        price_usd,
        id_buyer,
        default_currency,
        converted_price,
        payment_status,
        error_message
    );
END //

DELIMITER ;
