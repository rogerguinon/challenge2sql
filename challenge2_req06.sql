--Requirement 6: Executing every day the currency conversions for the next day by hand is hard, easy to forget and prone to errors. Schedule the execution of the procedure in requirement 5 every day until the end of the year using this timetable:
--Class-Group/Hour/Minute
--P101/20h/Group number
--P102/21h/Group number
--P201/22h/Group number
--P202/23h/Group number
--For example, group P201_07 should do the execution at 22:07h, as 22h is their specified hour, and minute 7 is their group number.

DROP EVENT IF EXISTS req06_schedule_daily_conversion;
DELIMITER //

CREATE EVENT req06_schedule_daily_conversion
ON SCHEDULE EVERY 1 DAY
STARTS '2024-10-25 22:12:00' --(P201/22h/Group 12)
DO
CALL req05_insert_new_conversion_data();

DELIMITER ;

--Example usage:
--SHOW EVENTS;
--ALTER EVENT req06_schedule_daily_conversion ENABLE;