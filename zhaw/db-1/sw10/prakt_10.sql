-- Create Schema
CREATE SCHEMA prakt10;

-- Aufagbe 1
SELECT avg(anlager) from sortiment;

-- Aufgabe 2
SELECT name, vorname, strasse from besucher where strasse ~ '(B|b)ach';

-- Aufgabe 3
SELECT strasse from (SELECT count(strasse) as amount, strasse from restaurant GROUP BY strasse) WHERE amount >= 3;

-- Aufgabe 4
SELECT count(*) from restaurant CROSS JOIN besucher;

-- Aufgabe 5
SELECT name, vorname, sum(frequenz) from besucher RIGHT OUTER JOIN gast on vorname = bvorname and name = bname GROUP BY vorname, name;

-- Aufgabe 6
SELECT count(name) as BsCount, count(DISTINCT grundstoff) GsCount, hersteller from biersorte GROUP BY hersteller;

-- Aufgabe 7
SELECT bsorte from (SELECT max(bewertung) as max, min(bewertung) as min, bsorte from lieblingsbier GROUP BY bsorte) as mmb WHERE mmb.max = mmb.min;

-- Aufgabe 8
SELECT suppenpreis, average from (SELECT avg(rest1.suppenpreis) as average, rest1.suppenpreis from restaurant as rest1, restaurant as rest2 where rest1.strasse = rest2.strasse GROUP BY rest1.suppenpreis);

-- Aufgabe 9
SELECT rname, max from (SELECT max(sort1.anlager) as max, sort1.rname from sortiment as sort1, sortiment as sort2 where sort1.rname = sort2.rname GROUP BY sort1.rname);

-- Aufgabe 10
SELECT strasse from
    (SELECT DISTINCT rest.strasse from
        (SELECT count(strasse) as count, strasse from besucher GROUP BY strasse) as bes,
        (SELECT count(strasse) as count, strasse from restaurant GROUP BY strasse) as rest
    WHERE bes.count < rest.count)

-- Aufgabe 11
SELECT DISTINCT besucher.strasse from besucher join (gast join restaurant on rname = name) on besucher.name = bname and vorname = bvorname WHERE vorname ~ '(p|P)' and suppenpreis BETWEEN 3 and 5;

-- Aufgabe 12
SELECT count(DISTINCT (bvorname, bname)) from gast WHERE rname = 'Löwen';