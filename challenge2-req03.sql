DROP PROCEDURE IF EXISTS validate_date_currency;
DELIMITER //
CREATE PROCEDURE validate_date_currency(
    IN check_date DATE,
    IN currency_code VARCHAR(3),
    OUT is_valid BOOLEAN
)
BEGIN
    DECLARE count INT;
    DECLARE query VARCHAR(1024);
    SET is_valid = FALSE;
    SET currency_code = UPPER(currency_code);
    
    SET query = CONCAT(
        "SELECT COUNT(*) FROM fx_from_usd WHERE date = '", check_date, "' AND `", currency_code, "` > 0 AND `", currency_code, "` IS NOT NULL"
    );
    PREPARE stmt FROM query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
	SELECT COUNT(*) INTO count FROM fx_from_usd WHERE date = check_date AND 
	(CASE WHEN `", currency_code, "` > 0 THEN 1 ELSE NULL END) IS NOT NULL;

    IF count > 0 THEN
        SET is_valid = TRUE;
    ELSE
        SET query = CONCAT(
            "SELECT COUNT(*) FROM fx_to_usd WHERE date = '", check_date, "' AND `", currency_code, "` > 0 AND `", currency_code, "` IS NOT NULL"
        );
        PREPARE stmt FROM query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
		SELECT COUNT(*) INTO count FROM fx_to_usd WHERE date = check_date AND 
		(CASE WHEN `", currency_code, "` > 0 THEN 1 ELSE NULL END) IS NOT NULL;
        
        IF count > 0 THEN
            SET is_valid = TRUE;
        END IF;
    END IF;
END //
