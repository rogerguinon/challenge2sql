-- Create a new function that, given a float number, if its value has more than 2 decimals returns it rounded with two decimals at max. If the number does not have more than 2 decimals return the number as is.

DROP FUNCTION IF EXISTS round_float;
CREATE FUNCTION round_float (number FLOAT)
RETURNS FLOAT
BEGIN
    IF number - ROUND(number, 2) = 0 THEN
        RETURN `number`;
    ELSE
        RETURN ROUND(number, 2);
    END IF;
END;