USE P201_05_challange2_music_festival;

--1)
DROP VIEW IF EXISTS query_01;
CREATE VIEW query_01 AS
SELECT p.name, p.description
FROM product p
JOIN food f ON p.id_product = f.id_food
WHERE f.is_spicy = 0 AND f.is_veggie_friendly = 1 AND p.description LIKE '%rice%';

-- Total : 1 row (SELECT * FROM P201_05_challange2_music_festival.query_01;)

--2)
DROP VIEW IF EXISTS query_02;
CREATE VIEW query_02 AS
SELECT 
COUNT(CASE WHEN is_armed = 1 THEN 1 END) AS armed_count,
COUNT(CASE WHEN knows_martial_arts = 1 THEN 1 END) AS martial_arts_count
FROM `security`;

-- Total : 1 row (SELECT * FROM P201_05_challange2_music_festival.query_02;)

--3)
DROP VIEW IF EXISTS query_03;
CREATE VIEW query_03 AS
SELECT v.name
FROM vendor v
JOIN ticket t ON t.id_vendor = v.id_vendor
JOIN festivalgoer fg ON fg.id_festivalgoer = t.id_festivalgoer
JOIN person p ON p.id_person = fg.id_festivalgoer
JOIN festival f ON f.name = t.festival_name AND f.edition = t.festival_edition
WHERE f.name = "Primavera Sound" AND f.edition = 2018 AND p.name = "Jan" AND p.surname = "Laporta";

-- Total : 1 row (SELECT * FROM P201_05_challange2_music_festival.query_03;)

--4)
DROP VIEW IF EXISTS query_04;
CREATE VIEW query_04 AS
SELECT f.name, COUNT(f.edition) AS editions
FROM festival f
GROUP BY f.name
ORDER BY editions DESC;

-- Total : 12 rows (SELECT * FROM P201_05_challange2_music_festival.query_04;)


--5)
DROP VIEW IF EXISTS query_05;
CREATE VIEW query_05 AS
SELECT f.name, f.edition, COUNT(t.id_ticket) AS total_tickets
FROM festival f
JOIN ticket t ON f.name = t.festival_name AND f.edition = t.festival_edition
GROUP BY f.name, f.edition
ORDER BY total_tickets DESC
LIMIT 1;

-- Total : 1 row (SELECT * FROM P201_05_challange2_music_festival.query_05;)

--5extra)
DROP VIEW IF EXISTS query_05_extra;
CREATE VIEW query_05_extra AS
SELECT f.name, f.edition, COUNT(t.id_ticket) AS total_tickets
FROM festival f
JOIN ticket t ON f.name = t.festival_name AND f.edition = t.festival_edition 
GROUP BY f.name, f.edition
ORDER BY f.name ASC, f.edition ASC;

-- Total : 54 rows (SELECT * FROM P201_05_challange2_music_festival.query_05_extra;)

--6)
DROP VIEW IF EXISTS query_06;
CREATE VIEW query_06 AS
SELECT a.prefered_instrument, COUNT(a.prefered_instrument) AS num_musicians
FROM artist a
GROUP BY a.prefered_instrument
ORDER BY num_musicians DESC;

-- Total: 6 rows (SELECT * FROM P201_05_challange2_music_festival.query_06;)

--7)
DROP VIEW IF EXISTS query_07;
CREATE VIEW query_07 AS
SELECT p.id_person, p.name, p.surname, p.nationality, p.birth_date, DATEDIFF(s.contract_expiration_date, s.hire_date) AS days_of_contract
FROM person p
JOIN staff s ON s.id_staff = p.id_person
WHERE DATEDIFF(s.contract_expiration_date, s.hire_date) < 730
ORDER BY days_of_contract ASC;

-- Total: 47 row (SELECT * FROM P201_05_challange2_music_festival.query_07;)

--7extra)
DROP VIEW IF EXISTS query_07_extra;
CREATE VIEW query_07_extra AS
SELECT p.id_person, p.name, p.surname, p.nationality, p.birth_date, DATEDIFF(s.contract_expiration_date, s.hire_date) AS contract_duration,
CASE
    WHEN s.id_staff IN (SELECT id_beerman FROM beerman) THEN "beerman"
    WHEN s.id_staff IN (SELECT id_bartender FROM bartender) THEN "bartender"
    WHEN s.id_staff IN (SELECT id_security FROM security) THEN "security"
    WHEN s.id_staff IN (SELECT id_community_manager FROM community_manager) THEN "community_manager"
END AS worker_type
FROM person p
JOIN staff s ON s.id_staff = p.id_person
WHERE DATEDIFF(s.contract_expiration_date, s.hire_date) < 730
ORDER BY contract_duration ASC;

-- Total: 47 row (SELECT * FROM P201_05_challange2_music_festival.query_07_extra;)

--8)
DROP VIEW IF EXISTS query_08;
CREATE VIEW query_08 AS
SELECT p.name, p.surname, p.nationality, p.birth_date, b.country
FROM person p 
JOIN artist a ON a.id_artist = p.id_person
JOIN band b ON b.name = a.band_name AND b.country = a.band_country
WHERE b.name = "Coldplay";

-- Total: 10 rows (SELECT * FROM P201_05_challange2_music_festival.query_08;)

--9)
DROP VIEW IF EXISTS query_09;
CREATE VIEW query_09 AS
SELECT p.name, p.description 
FROM product p 
JOIN beverage b ON b.id_beverage = p.id_product
JOIN bar_product bp ON bp.id_product = p.id_product
JOIN product_provider_bar ppb ON ppb.id_product = bp.id_product
JOIN `provider` pr ON pr.id_provider = ppb.id_provider
WHERE pr.name = "Spirits Source" AND b.is_alcoholic = 0
GROUP BY p.name, p.description;

-- Total: 5 rows (SELECT * FROM P201_05_challange2_music_festival.query_09;)

--10) 
DROP VIEW IF EXISTS query_10;
CREATE VIEW query_10 AS
SELECT p.name, p.surname, p.nationality, p.birth_date
FROM person p
JOIN festivalgoer fg ON fg.id_festivalgoer = p.id_person
JOIN festivalgoer_consumes fc ON fc.id_festivalgoer = fg.id_festivalgoer
JOIN product pr ON pr.id_product = fc.id_product
JOIN beverage b ON b.id_beverage = pr.id_product
JOIN ticket t ON t.id_festivalgoer = fg.id_festivalgoer
JOIN festival f ON f.name = t.festival_name AND f.edition = t.festival_edition
WHERE b.is_alcoholic = 1 AND DATEDIFF(f.start_time, p.birth_date) < 6570;

-- Total: +1000 rows (SELECT * FROM P201_05_challange2_music_festival.query_10;)

--11)
DROP VIEW IF EXISTS query_11;
CREATE VIEW query_11 AS
SELECT p.id_person, p.name, p.surname, p.nationality, p.birth_date, COUNT(bes.id_beerman_sells) AS sells 
FROM person p
JOIN staff s ON s.id_staff = p.id_person
JOIN beerman be ON be.id_beerman = s.id_staff
JOIN beerman_sells bes ON bes.id_beerman = be.id_beerman
JOIN `show` sh ON sh.festival_name = bes.festival_name AND sh.festival_edition = bes.festival_edition AND sh.id_stage = bes.id_stage 
JOIN band b ON b.name = sh.band_name AND b.country = sh.band_country
WHERE b.name = "The Beatles" AND sh.festival_name = "Hellfest"
GROUP BY p.id_person, p.name, p.surname, p.nationality, p.birth_date 
HAVING COUNT(bes.id_beerman_sells) = (SELECT MAX(COUNT(bes.id_beerman_sells)) FROM beerman_sells bes);

-- Total: ?? rows (SELECT * FROM P201_05_challange2_music_festival.query_11;)

--12)
DROP VIEW IF EXISTS query_12;
CREATE VIEW query_12 AS
SELECT p.id_person, p.name, p.surname, p.nationality, a.band_name, a.band_country
FROM person p
JOIN artist a ON a.id_artist = p.id_person
JOIN band b ON b.name = a.band_name AND b.country = a.band_country
JOIN band_collab bc ON bc.band_name = b.name AND bc.band_country = b.country
WHERE bc.band_name = "Ebri Knight" AND p.id_person NOT IN (SELECT id_artist FROM artist WHERE band_name = "Ebri Knight")
ORDER BY a.band_name ASC, a.band_country ASC;

-- Total: ?? row (SELECT * FROM P201_05_challange2_music_festival.query_12;)

--13)
DROP VIEW IF EXISTS query_13;
CREATE VIEW query_13 AS
SELECT s.title, s.version, s.written_by, s.duration, s.release_date, s.type_of_music, s.album
FROM song s
JOIN show_song ss ON ss.title = s.title
JOIN `show` sh ON sh.id_show = ss.id_show
JOIN band b ON b.name = sh.band_name AND b.country = sh.band_country
JOIN artist a ON a.band_name = b.name AND a.band_country = b.country
JOIN person p ON p.id_person = a.id_artist
WHERE p.name = "Cordie" AND p.surname = "Paucek";

-- Total: 48 rows (SELECT * FROM P201_05_challange2_music_festival.query_13;)

--13extra)
DROP VIEW IF EXISTS query_13_extra;
CREATE VIEW query_13_extra AS
SELECT SUM(s.duration) AS total_duration
FROM song s
JOIN show_song ss ON ss.title = s.title
JOIN `show` sh ON sh.id_show = ss.id_show
JOIN band b ON b.name = sh.band_name AND b.country = sh.band_country
JOIN artist a ON a.band_name = b.name AND a.band_country = b.country
JOIN person p ON p.id_person = a.id_artist
WHERE p.name = "Cordie" AND p.surname = "Paucek";

-- Total: 1 row (SELECT * FROM P201_05_challange2_music_festival.query_13_extra;)

--14)
DROP VIEW IF EXISTS query_14;
CREATE VIEW query_14 AS
SELECT p.id_person, p.name, p.surname
FROM person p
JOIN staff s ON s.id_staff = p.id_person
JOIN bartender b ON b.id_bartender = s.id_staff
JOIN beerman be ON be.id_beerman = s.id_staff
JOIN security se ON se.id_security = s.id_staff
JOIN community_manager cm ON cm.id_community_manager = s.id_staff
GROUP BY p.id_person, p.name, p.surname
HAVING COUNT(DISTINCT s.id_staff) > 1;

-- Total: ?? rows (SELECT * FROM P201_05_challange2_music_festival.query_14;)

--14extra)
DROP VIEW IF EXISTS query_14_extra;
CREATE VIEW query_14_extra AS
SELECT p.id_person, p.name, p.surname, COUNT(DISTINCT s.id_staff) AS num_roles
FROM person p
JOIN staff s ON s.id_staff = p.id_person
JOIN bartender b ON b.id_bartender = s.id_staff
JOIN beerman be ON be.id_beerman = s.id_staff
JOIN security se ON se.id_security = s.id_staff
JOIN community_manager cm ON cm.id_community_manager = s.id_staff
GROUP BY p.id_person, p.name, p.surname
HAVING COUNT(DISTINCT s.id_staff) > 1;

-- Total: ?? rows (SELECT * FROM P201_05_challange2_music_festival.query_14_extra;)

--15)
DROP VIEW IF EXISTS query_15;
CREATE VIEW query_15 AS
SELECT p.id_person, p.name, p.surname, p.nationality, p.birth_date, s.hire_date, s.contract_expiration_date
FROM person p
JOIN staff s ON s.id_staff = p.id_person
JOIN community_manager cm ON cm.id_community_manager = s.id_staff
JOIN cm_account_festival caf ON caf.id_community_manager = cm.id_community_manager
JOIN festival f ON f.name = caf.festival_name AND f.edition = caf.festival_edition
WHERE f.name = "Primavera Sound" AND f.edition = 2023;

-- Total: 6 rows (SELECT * FROM P201_05_challange2_music_festival.query_15;)

--16)
DROP VIEW IF EXISTS query_16;
CREATE VIEW query_16 AS
SELECT p.id_person, p.name, p.surname, p.nationality, p.birth_date
FROM person p
JOIN festivalgoer fg ON fg.id_festivalgoer = p.id_person
LEFT JOIN ticket t ON t.id_festivalgoer = fg.id_festivalgoer
WHERE t.id_ticket IS NULL
ORDER BY p.id_person ASC;

-- Total: 1000+ rows (SELECT * FROM P201_05_challange2_music_festival.query_16;)

--17)
DROP VIEW IF EXISTS query_17;
CREATE VIEW query_17 AS
SELECT p.id_person, p.name, p.surname, SUM(t.price) + SUM(3 * COUNT(bes.id_beerman_sells)) + SUM(ppb.price * fc.quantity) AS total_spent
FROM person p
JOIN festivalgoer fg ON fg.id_festivalgoer = p.id_person
JOIN ticket t ON t.id_festivalgoer = fg.id_festivalgoer
JOIN festivalgoer_consumes fc ON fc.id_festivalgoer = fg.id_festivalgoer
JOIN bar b ON b.id_bar = fc.id_bar
JOIN bar_product bp ON bp.id_bar = b.id_bar
JOIN product_provider_bar ppb ON ppb.id_product = bp.id_product AND ppb.id_bar = bp.id_bar
JOIN beerman_sells bes ON bes.id_beerman_sells = fg.id_festivalgoer
WHERE p.id_person = 1 -- Change this value to the desired festivalgoer id.
GROUP BY p.id_person, p.name, p.surname;

-- Total: 1 row (SELECT * FROM P201_05_challange2_music_festival.query_17;)

--18)
DROP VIEW IF EXISTS query_18;
CREATE VIEW query_18 AS
WITH RepeatedNames AS (
    SELECT name FROM band
    GROUP BY name
    HAVING COUNT(*) > 1
)
SELECT b.* FROM band b
WHERE b.name IN (SELECT name FROM RepeatedNames);

-- Total: 69 rows (SELECT * FROM P201_05_challange2_music_festival.query_18;)

--19)
DROP VIEW IF EXISTS query_19;
CREATE VIEW query_19 AS
SELECT p.*, caf.platform_name, acc.followers
FROM person p
JOIN staff s ON s.id_staff = p.id_person
JOIN community_manager cm ON cm.id_community_manager = s.id_staff
JOIN cm_account_festival caf ON caf.id_community_manager = cm.id_community_manager
JOIN account acc ON acc.account_name = caf.account_name AND acc.platform_name = caf.platform_name
WHERE cm.is_freelance = 1 AND caf.festival_name = "Creamfields" AND acc.followers >= 500000 AND acc.followers <= 700000
ORDER BY p.id_person ASC;

-- Total: 6 rows (SELECT * FROM P201_05_challange2_music_festival.query_19;)

--20)
DROP VIEW IF EXISTS query_20;
CREATE VIEW query_20 AS
SELECT p.name, p.surname
FROM person p
JOIN festivalgoer fg ON fg.id_festivalgoer = p.id_person
JOIN ticket t ON t.id_festivalgoer = fg.id_festivalgoer
JOIN festival f ON f.name = t.festival_name AND f.edition = t.festival_edition
WHERE f.name = "Primavera Sound"
AND NOT EXISTS (
    SELECT f2.name, f2.edition
    FROM festival f2
    WHERE f2.name = "Primavera Sound"
    AND NOT EXISTS (
        SELECT t2.id_ticket
        FROM ticket t2
        WHERE t2.festival_name = f2.name AND t2.festival_edition = f2.edition AND t2.id_festivalgoer = fg.id_festivalgoer
    )
)

-- Total: ?? rows (SELECT * FROM P201_05_challange2_music_festival.query_20;)