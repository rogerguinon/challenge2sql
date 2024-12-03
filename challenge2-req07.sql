/*Make a function to identify default or preferred currency for a given person/festivalgoer. Given an
id as input, it will return:
1. USD if the person/festivalgoer has United States nationality.
2. CAD if the person/festivalgoer has Canada nationality.
3. GBP id the person has U.K. nationality.
4. JPY if the person/festivalgoer has Japanese nationality.
5. EUR if the person/festivalgoer is an Eurozone member.
6. 0 if the id is not found.
7. null in any other case.*/

DELIMITER //

DROP FUNCTION IF EXISTS req07_default_currency;

CREATE FUNCTION req07_default_currency(person_id INT) 
RETURNS VARCHAR(3)
BEGIN
    DECLARE nationality VARCHAR(50);
    
    SELECT nationality INTO nationality FROM person
    JOIN festivalgoer ON person.id_person = festivalgoer.id_festivalgoer
    WHERE person.id_person = person_id

    RETURN (
        CASE 
            WHEN nationality = 'United States' THEN 'USD'
            WHEN nationality = 'Canada' THEN 'CAD'
            WHEN nationality = 'United Kingdom' THEN 'GBP'
            WHEN nationality = 'Japan' THEN 'JPY'
            WHEN nationality IN ('Germany', 'France', 'Italy', 'Spain', 'Netherlands', 'Portugal') THEN 'EUR'
            WHEN nationality IS NULL THEN NULL
            ELSE '0'
        END
    );