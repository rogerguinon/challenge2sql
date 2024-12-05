DROP PROCEDURE IF EXISTS convert_currency;
DELIMITER //

CREATE PROCEDURE convert_currency(
    IN origin_currency VARCHAR(3),
    IN destination_currency VARCHAR(3),
    IN conversion_date DATE,
    INOUT amount DOUBLE,
    OUT error_message VARCHAR(255)
)
main: BEGIN
    DECLARE origin_rate DOUBLE DEFAULT 0;
    DECLARE destination_rate DOUBLE DEFAULT 0;

    SET error_message = NULL;
    SET origin_currency = UPPER(origin_currency);
    SET destination_currency = UPPER(destination_currency);

    -- Check if amount is greater than 0
    IF amount <= 0 THEN
        SET error_message = 'Amount must be greater than 0';
        SET amount = 0;
        LEAVE main;
    END IF;

    -- Ensure date is not in the future
    IF conversion_date > CURDATE() THEN
        SET error_message = 'Conversion date cannot be in the future';
        SET amount = 0;
        LEAVE main;
    END IF;

    -- Check if origin and destination currencies exist
    IF NOT currency_exists(origin_currency) THEN
        SET error_message = 'Origin currency not supported';
        SET amount = 0;
        LEAVE main;
    END IF;

    IF NOT currency_exists(destination_currency) THEN
        SET error_message = 'Destination currency not supported';
        SET amount = 0;
        LEAVE main;
    END IF;

    -- Check if origin and destination are not the same
    IF origin_currency = destination_currency THEN
        SET error_message = 'Origin and destination currencies cannot be the same';
        SET amount = 0;
        LEAVE main;
    END IF;

    IF origin_currency = 'USD' THEN
        SET @query = CONCAT('SELECT ', destination_currency, ' INTO @destination_rate FROM fx_from_usd WHERE date = ?');
        PREPARE stmt FROM @query;
        EXECUTE stmt USING @conversion_date;
        DEALLOCATE PREPARE stmt;

        SELECT @destination_rate INTO destination_rate;

        IF destination_rate IS NULL OR destination_rate = 0 THEN
            SET error_message = 'Conversion rate not found or invalid for destination currency.';
            SET amount = 0;
            LEAVE main;
        END IF;

        SET amount = ROUND(amount * destination_rate, 2);

    ELSEIF destination_currency = 'USD' THEN
        SET @query = CONCAT('SELECT ', origin_currency, ' INTO @origin_rate FROM fx_to_usd WHERE date = ?');
        PREPARE stmt FROM @query;
        EXECUTE stmt USING @conversion_date;
        DEALLOCATE PREPARE stmt;

        SELECT @origin_rate INTO origin_rate;

        IF origin_rate IS NULL OR origin_rate = 0 THEN
            SET error_message = 'Conversion rate not found or invalid for origin currency.';
            SET amount = 0;
            LEAVE main;
        END IF;

        SET amount = ROUND(amount * origin_rate, 2);

    ELSE
        SET error_message = 'Currently, only USD as base or target currency is supported.';
        SET amount = 0;
        LEAVE main;
    END IF;

    SET error_message = NULL;
END//
