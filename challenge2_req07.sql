DROP FUNCTION IF EXISTS get_preferred_currency;
DELIMITER //
CREATE FUNCTION get_preferred_currency (id_person INT)
RETURNS VARCHAR(3)

BEGIN
    DECLARE nationality VARCHAR(50);
    DECLARE eurozones TEXT DEFAULT 'Austria, Belgium, Croatia, Cyprus, Estonia, Finland, France, Germany, Greece, Ireland, Italy, Latvia, Lithuania, Luxembourg, Malta, Netherlands, Portugal, Slovakia, Slovenia, Spain';

    SELECT nationality INTO nationality
    FROM festivalgoer
    WHERE id_festivalgoer = id_person;

    IF nationality = 'United States' THEN
        RETURN 'USD';
    ELSEIF nationality = 'Canada' THEN
        RETURN 'CAD';
    ELSEIF nationality = 'United Kingdom' THEN
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
