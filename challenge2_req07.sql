DROP FUNCTION IF EXISTS get_preferred_currency;
DELIMITER //
CREATE FUNCTION get_preferred_currency (id INT)
RETURNS VARCHAR(3)

BEGIN
    DECLARE country VARCHAR(50);
    DECLARE eurozones TEXT DEFAULT 'Austria,Belgium,Croatia,Cyprus,Estonia,Finland,France,Germany,Greece,Ireland,Italy,Latvia,Lithuania,Luxembourg,Malta,Netherlands,Portugal,Slovakia,Slovenia,Spain';

    SELECT nationality INTO country
    FROM person WHERE id_person = id;

    IF country = 'United States' THEN
        RETURN 'USD';
    ELSEIF country = 'Canada' THEN
        RETURN 'CAD';
    ELSEIF country = 'United Kingdom' THEN
        RETURN 'GBP';
    ELSEIF country = 'Japan' THEN
        RETURN 'JPY';
    ELSEIF FIND_IN_SET(country, eurozones) <> 0 THEN 
        RETURN 'EUR';
    ELSEIF country IS NULL THEN
        RETURN 0;
    ELSE
        RETURN NULL;
    END IF;
END //

DELIMITER ;
