-- Create Schema
CREATE SCHEMA prakt9;

-- Aufagbe 1
SELECT name, vorname FROM besucher WHERE strasse = 'Dorfstrasse';

-- Aufgabe 2
SELECT bname FROM lieblingsbier WHERE bewertung >= 3 AND bsorte = 'Malzdrink';

-- Aufgabe 3
SELECT name, vorname FROM besucher WHERE strasse = 'Dorfstrasse' ORDER BY name, vorname;

-- Aufgabe 4
SELECT restaurant.name, suppenpreis FROM restaurant join (
    SELECT * FROM biersorte join prakt9.sortiment s2 on biersorte.name = s2.bsorte
    WHERE biersorte.grundstoff = 'Hopfen')
s on restaurant.name = s.rname;

-- Aufgabe 5
SELECT besucher.name, besucher.gebtag FROM besucher join (
    SELECT * FROM gast join prakt9.restaurant r on r.name = gast.rname WHERE r.eroeffnungsdatum < '2010-01-01')
    gast2 on gast2.bname = besucher.name AND gast2.bvorname = besucher.vorname;

-- Aufgabe 6
SELECT name, vorname from besucher EXCEPT ALL (SELECT bname, bvorname from gast UNION ALL SELECT bname, bvorname from lieblingsbier);

-- Aufgabe 7
SELECT besucher.name, besucher.vorname FROM besucher join
    (gast join restaurant on gast.rname = restaurant.name)
on besucher.vorname = gast.bvorname AND besucher.name = gast.bvorname
WHERE besucher.strasse != restaurant.strasse;

-- Aufgabe 8
SELECT besucher.name, besucher.vorname FROM besucher join
    (lieblingsbier join
        (biersorte join sortiment on biersorte.name = sortiment.bsorte)
    on biersorte.name = lieblingsbier.bsorte)
on besucher.name = lieblingsbier.bname AND besucher.vorname = lieblingsbier.bvorname
WHERE sortiment.bsorte = lieblingsbier.bsorte;

-- Aufgabe 9
SELECT bsorte from lieblingsbier join
    (besucher join gast on vorname = bvorname and name = bname) on name = lieblingsbier.bname and vorname = lieblingsbier.bvorname
WHERE starts_with(name, 'P') and rname = 'Löwen';

-- Aufgabe 10
SELECT strasse from (SELECT count(strasse) as amount, strasse from restaurant GROUP BY strasse) WHERE amount >= 3;
