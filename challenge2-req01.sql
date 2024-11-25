DROP FUNCTION IF EXISTS round_float;
DELIMITER //
CREATE FUNCTION round_float (number FLOAT)
RETURNS FLOAT
BEGIN
    IF number - ROUND(number, 2) = 0 THEN
        RETURN `number`;
    ELSE
        RETURN ROUND(number, 2);
    END IF;
END
//