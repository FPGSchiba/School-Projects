-- -------------------------------------------------------------------
-- postgres_air.sql
-- ----------------
--
-- Tupel zählen in der Datenbank postgres_air
-- -------------------------------------------------------------------

SELECT 'account' AS "Tabelle", COUNT(*) AS "Anzahl Tupel" FROM postgres_air.account 
UNION
SELECT 'aircraft', COUNT(*) FROM postgres_air.aircraft 
UNION
SELECT 'airport', COUNT(*) FROM postgres_air.airport 
UNION
SELECT 'boarding_pass', COUNT(*) FROM postgres_air.boarding_pass 
UNION
SELECT 'booking', COUNT(*) FROM postgres_air.booking 
UNION
SELECT 'booking_leg', COUNT(*) FROM postgres_air.booking_leg
UNION
SELECT 'flight', COUNT(*) FROM postgres_air.flight 
UNION
SELECT 'frequent_flyer', COUNT(*) FROM postgres_air.frequent_flyer 
UNION
SELECT 'passenger', COUNT(*) FROM postgres_air.passenger 
UNION
SELECT 'phone', COUNT(*) FROM postgres_air.phone 
ORDER BY "Tabelle";
