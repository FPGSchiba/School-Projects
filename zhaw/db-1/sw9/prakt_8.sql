CREATE SCHEMA prakt8;

/* Aufgabe 1 */
CREATE TABLE mitarbeiter (
    id serial unique not null PRIMARY KEY,
    firstName varchar,
    lastName varchar
);

CREATE TABLE firma (
    id serial UNIQUE NOT NULL PRIMARY KEY,
    name varchar,
    type varchar,
    logo bytea
);

CREATE TABLE arbeitet (
    firma_id int REFERENCES firma,
    mitarbeiter_id int REFERENCES mitarbeiter,
    CONSTRAINT arbeitet_key UNIQUE (firma_id, mitarbeiter_id)
);

/* Aufgabe 2 */
ALTER TABLE firma ADD COLUMN gruendungsJahr date;
ALTER TABLE arbeitet ADD COLUMN jahresLohn int NOT NULL DEFAULT 0;

/* Aufgabe 3 */
ALTER TABLE mitarbeiter ADD COLUMN plz int NOT NULL DEFAULT 0 CONSTRAINT plz_length CHECK ( length(plz::text) = 4 );
ALTER TABLE  mitarbeiter ADD COLUMN ort varchar;
ALTER TABLE mitarbeiter ADD COLUMN strasse varchar NOT NULL DEFAULT 'null';
ALTER TABLE mitarbeiter ADD COLUMN strassen_nummer int NOT NULL DEFAULT 0;

/* Aufgabe 4 */
INSERT INTO firma (name, type, logo, gruendungsJahr) VALUES
('Max', 'AG', null, '2000-04-15'),
('Müller', 'GMBH', null, '1998-07-10'),
('Meister', 'AG', null, '2017-12-07');

INSERT INTO mitarbeiter (firstName, lastName, plz, ort, strasse, strassen_nummer) VALUES
('Hans', 'Meister', 2837, 'Waalburg', 'Spassstasse', 7),
('Joseph', 'Torento', 1623, 'Mülliswil', 'Hamburgstrasse', 12),
('Peter', 'König', 7351, 'Müllershausen', 'Zwiebelstrasse', 8),
('Ulrich', 'Wädler', 5123, 'Inhausen', 'Turbenstrasse', 189),
('Norbert', 'Diktator', 3153, 'Räbgraten', 'Fränkerstrasse', 87);

INSERT INTO arbeitet (firma_id, mitarbeiter_id, jahresLohn) VALUES
(4, 1, 100000),
(2, 2, 50000),
(3, 3, 40000),
(3, 4, 60000),
(4, 5, 90000);

/* Aufgabe 5 */
ALTER TABLE mitarbeiter ADD COLUMN tel_number int NOT NULL DEFAULT 0;
/* Ein Fehler, da es schon Einträge ohne Telefon nummer in der Datenbank hat. */

/* Aufgabe 6 */
UPDATE mitarbeiter SET
    firstName = 'Peter',
    lastName = 'König',
    plz = 7351,
    ort = 'Müllershausen',
    strasse = 'Zwiebelstrasse',
    strassen_nummer = 0
WHERE id = 3;

/* Aufgabe 7 */
UPDATE firma SET
    name = 'Andere Firma'
WHERE id = 2;

/* Aufgabe 8 */
DROP TABLE mitarbeiter CASCADE;
DROP TABLE firma CASCADE;
DROP TABLE arbeitet CASCADE;
