DROP FUNCTION IF EXISTS req07_get_preferred_currency;
DELIMITER //
CREATE FUNCTION req07_get_preferred_currency (id_person INT)
RETURNS VARCHAR(3)

BEGIN
    DECLARE nationality VARCHAR(50);
    DECLARE eurozones TEXT DEFAULT 'Austria, Belgium, Croatia, Cyprus, Estonia, Finland, France, Germany, Greece, Ireland, Italy, Latvia, Lithuania, Luxembourg, Malta, Netherlands, Portugal, Slovakia, Slovenia, Spain'; --Check the data if the countries are written in the same way

    SELECT nationality INTO nationality
    FROM festivalgoer
    WHERE id_festilvalgoer = id_person

    IF nationality = 'United States' THEN
        RETURN 'USD';
    ELSEIF nationality = 'Canada' THEN
        RETURN 'CAD';
    ELSEIF nationality = 'United Kingdom' THEN --Maybe it is better to use 'U.K.' instead of 'United Kingdom' (check the data)
        RETURN 'GBP';
    ELSEIF nationality = 'Japan' THEN
        RETURN 'JPY';
    ELSEIF FIND_IN_SET(nationality, eurozones) <> 0 THEN 
        RETURN 'EUR';
    ELSEIF nationality IS NULL THEN
        RETURN 0;
    ELSE
        RETURN NULL;
    END IF;
END //

DELIMITER ;

--Example usage:
--SELECT req07_get_preferred_currency(1); -- Example with id_person = 1