-- REMOVE ALL
-- DROP SCHEMA prakt12 CASCADE;

----------
-- A1
----------
CREATE SCHEMA IF NOT EXISTS prakt12;

CREATE TABLE IF NOT EXISTS sammelstelle (
    sid serial PRIMARY KEY,
    sort text NOT NULL,
    sland text NOT NULL
);

CREATE TABLE IF NOT EXISTS fabrik (
    fid serial PRIMARY KEY,
    fort text NOT NULL,
    fland text
);

CREATE TABLE IF NOT EXISTS kafeesorte (
    kid serial PRIMARY KEY,
    kname text NOT NULL
);

-- Beziehungstypen
CREATE TABLE IF NOT EXISTS abgabemoeglich (
    sid serial REFERENCES sammelstelle,
    kid serial REFERENCES kafeesorte,
    PRIMARY KEY (sid, kid)
);

CREATE TABLE IF NOT EXISTS lieferungmoeglich (
    sid serial REFERENCES sammelstelle,
    fid serial REFERENCES fabrik,
    kid serial REFERENCES kafeesorte,
    PRIMARY KEY (sid, fid, kid)
);

-- ID Relationstabellen
CREATE TABLE IF NOT EXISTS lieferung (
    sid serial,
    fid serial,
    kid serial,
    lid serial NOT NULL,
    lanzkg int NOT NULL,
    ldatum date NOT NULL,
    CONSTRAINT fk FOREIGN KEY (sid, fid, kid) REFERENCES lieferungmoeglich,
    PRIMARY KEY (sid, fid, kid, lid)
);

CREATE TABLE IF NOT EXISTS abgabe (
    sid serial,
    kid serial,
    aid serial NOT NULL,
    aanzkg int NOT NULL,
    adatum date NOT NULL,
    CONSTRAINT fk FOREIGN KEY (sid, kid) REFERENCES abgabemoeglich,
    PRIMARY KEY (sid, kid, aid)
);

-- Daten
INSERT INTO sammelstelle (sort, sland) VALUES
    ('Schwabenstadt', 'Deutschland'),
    ('Zürich', 'Schweiz'),
    ('Neuchatel', 'Schweiz');

INSERT INTO fabrik (fort, fland) VALUES
    ('Bangkok', 'Thailand'),
    ('Phuket', 'Thailand'),
    ('Hong Kong', 'China');

INSERT INTO kafeesorte (kname) VALUES
    ('Arabica'),
    ('Arabusta'),
    ('Bourbon');

INSERT INTO lieferungmoeglich (sid, fid, kid) VALUES
    (1, 1, 1),
    (2, 1, 1),
    (1, 2, 2);

INSERT INTO abgabemoeglich (sid, kid) VALUES
    (1, 1),
    (2, 1),
    (1, 2);

INSERT INTO abgabe (kid, sid, aanzkg, adatum) VALUES
    (1, 1, 1, '2023-06-14'),
    (1, 1, 2, '2023-08-10'),
    (1, 1, 3, '2023-12-24');

INSERT INTO lieferung (fid, kid, sid, lanzkg, ldatum) VALUES
    (1, 1, 1, 10, '2023-01-20'),
    (1, 1, 1, 20, '2023-09-12'),
    (1, 1, 1, 30, '2023-11-30');

----------
-- A2
----------

SELECT kafeesorte.kid, kafeesorte.kname from
    kafeesorte JOIN abgabe ON kafeesorte.kid = abgabe.kid
WHERE NOT EXISTS (
    SELECT 1 FROM lieferung WHERE lieferung.kid = kafeesorte.kid
) AND abgabe.kid = kafeesorte.kid;

----------
-- A3
----------

SELECT k.kid, k.kname from kafeesorte as k join lieferung as l
    on k.kid = l.kid
group by k.kid, k.kname
having count(distinct l.fid) = (SELECT count(*) from fabrik);

----------
-- A4
----------

SELECT s.sid, abgaben, lieferungen from (
    SELECT a.sid, count(a.sid) as abgaben
    from abgabe as a
    group by a.sid
) as s
join (
    SELECT l.sid, count(l.sid) as lieferungen
    from lieferung as l
    group by l.sid
) as l
    on s.sid = l.sid
WHERE s.abgaben > 5 and l.lieferungen > 3;