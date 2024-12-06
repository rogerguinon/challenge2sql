DROP PROCEDURE IF EXISTS fix_underage_consumption;

DELIMITER //

CREATE PROCEDURE fix_underage_consumption(
    OUT error_message VARCHAR(255)
)

BEGIN
    UPDATE beerman_sells
    SET id_festivalgoer = 998192
    WHERE id_festivalgoer IN (
        SELECT p.id_person
        FROM person p
        JOIN beerman_sells bs ON p.id_person = bs.id_festivalgoer
        WHERE p.birth_date <= DATE_SUB(CURDATE(), INTERVAL 18 YEAR)
    );
    SET error_message = 'Underage consumption fixed';
END//