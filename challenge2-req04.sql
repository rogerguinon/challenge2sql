DELIMITER $$

CREATE PROCEDURE convert_currency(
    IN origin_currency VARCHAR(3),
    IN destination_currency VARCHAR(3),
    IN conversion_date DATE,
    INOUT amount DOUBLE,
    OUT error_message VARCHAR(255)
)

BEGIN
    DECLARE origin_rate DOUBLE DEFAULT 0;
    DECLARE destination_rate DOUBLE DEFAULT 0;

    -- Covert to uppercase and set error message to NULL
    SET error_message = NULL;
    SET origin_currency = UPPER(origin_currency);
    SET destination_currency = UPPER(destination_currency);

    -- Check if amount is greater than 0
    IF amount < 0 THEN
        SET error_message = 'Amount must be greater than 0';
        SET amount = 0;
        LEAVE convert_currency;
    END IF;

    -- Ensure date is not in the future
    IF conversion_date > CURDATE() THEN
        SET error_message = 'Conversion date cannot be in the future';
        SET amount = 0;
        LEAVE convert_currency;
    END IF;

    -- Check if origin currency exists in the database
    IF NOT currency_exists(origin_currency) THEN
        SET error_message = 'Origin currency not supported';
        SET amount = 0;
        LEAVE convert_currency;
    END IF;

    -- Check if destination currency exists in the database
    IF NOT currency_exists(destination_currency) THEN
        SET error_message = 'Destination currency not supported';
        SET amount = 0;
        LEAVE convert_currency;
    END IF;

    -- Check if origin and destination are not the same
    IF origin_currency = destination_currency THEN
        SET error_message = 'Origin and destination currencies cannot be the same';
        SET amount = 0;
        LEAVE convert_currency;
    END IF;

    -- Get rates and calculate converted amount
    -- USD to other currency
    IF origin_currency = 'USD' THEN
        SET @query = CONCAT('SELECT ', destination_currency, ' INTO @destination_rate FROM fx_from_usd WHERE date = ?');
        PREPARE stmt FROM @query;
        EXECUTE stmt USING conversion_date;
        DEALLOCATE PREPARE stmt;

        -- Check rate existence
        IF @destination_rate IS NULL OR @destination_rate = 0 THEN
            SET error_message = 'Conversion rate not found or invalid for destination currency.';
            SET amount = 0;
            LEAVE convert_currency;
        END IF;

        SET amount = round_float(amount * @destination_rate);

    -- Another currency to USD
    ELSEIF destination_currency = 'USD' THEN
        SET @query = CONCAT('SELECT ', origin_currency, ' INTO @origin_rate FROM fx_to_usd WHERE date = ?');
        PREPARE stmt FROM @query;
        EXECUTE stmt USING conversion_date;
        DEALLOCATE PREPARE stmt;

        -- Check rate existence
        IF @origin_rate IS NULL OR @origin_rate = 0 THEN
            SET error_message = 'Conversion rate not found or invalid for origin currency.';
            SET amount = 0;
            LEAVE convert_currency;
        END IF;

        SET amount = round_float(amount / @origin_rate);

    -- Final success message
    SET error_message = NULL;
END$$

DELIMITER ;