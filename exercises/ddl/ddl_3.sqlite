-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Muzicar(id, ime, prezime, datum_ragjanje), PK: id
-- Muzicar_instrument(id_muzicar*, instrument), PK: id_muzicar, instrument
-- Bend(id, ime, godina_osnovanje), PK: id
-- Bend_zanr(id_bend*, zanr), PK: id_bend, zanr
-- Nastan(id, cena, kapacitet), PK: id
-- Koncert(id*, datum, vreme), PK: id
-- Festival(id*, ime), PK: id
-- Festival_odrzuvanje(id*, datum_od, datum_do), PK: id
-- Muzicar_bend(id_muzicar*, id_bend*, datum_napustanje), PK: id_muzicar, id_bend
-- Festival_bend(id_festival*, datum_od*, id_bend*), PK: id_festival, datum_od, id_bend
-- Koncert_muzicar_bend(id_koncert*, id_muzicar*, id_bend*), PK: id_koncert, id_muzicar, id_bend

-- Additional requirements:
-- 1. The Band (Bend) with an id of 5 can't participate in the Festival with an id of 2.
-- 2. We want to keep track of the Festival bands (Festival_bend) that are deleted from the database.
-- 3. Only keep track of entries about bands formed in 1970 or after.


CREATE TABLE IF NOT EXISTS Muzicar (
    id INT PRIMARY KEY,
    ime VARCHAR(100),
    prezime VARCHAR(100),
    datum_ragjanje VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Muzicar_Instrument (
    id_muzicar INT PRIMARY KEY,
    instrument VARCHAR(100),
    FOREIGN KEY (id_muzicar)
        REFERENCES Muzicar(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Bend (
    id INT PRIMARY KEY,
    ime VARCHAR(100),
    godina_osnovanje INT,
    CHECK (godina_osnovanje >= 1970)
);

CREATE TABLE IF NOT EXISTS Bend_zanr (
    id_bend INT,
    zanr VARCHAR(100),
    PRIMARY KEY (id_bend, zanr)
    FOREIGN KEY (id_bend)
        REFERENCES Bend(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Nastan (
    id INT PRIMARY KEY,
    cena INT,
    kapacitet INT
);

CREATE TABLE IF NOT EXISTS Koncert (
    id INT PRIMARY KEY,
    datum VARCHAR(10),
    vreme INT,
    FOREIGN KEY (id)
        REFERENCES Nastan (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Festival (
    id INT PRIMARY KEY,
    ime VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Festival_odrzuvanje (
    id INT,
    datum_od VARCHAR(10),
    datum_do VARCHAR(10),
    PRIMARY KEY (id, datum_od),
    FOREIGN KEY (id)
        REFERENCES Festival(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Muzicar_bend (
    id_muzicar INT,
    id_bend INT,
    datum_napustanje VARCHAR(10),
    PRIMARY KEY (id_muzicar, id_bend),
    FOREIGN KEY (id_muzicar)
        REFERENCES Muzicar(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_bend)
        REFERENCES Bend(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Festival_bend (
    id_festival INT,
    datum_od VARCHAR(10),
    id_bend INT,
    PRIMARY KEY (id_festival, datum_od, id_bend),
    FOREIGN KEY (id_festival, datum_od)
        REFERENCES Festival_odrzuvanje(id, datum_od)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_bend)
        REFERENCES Bend(id)
        ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CHECK (id_bend != 5 AND id_festival != 2)
);

CREATE TABLE IF NOT EXISTS Koncert_muzicar_bend (
    id_koncert INT,
    id_muzicar INT,
    id_bend INT,
    PRIMARY KEY (id_koncert, id_muzicar, id_bend),
    FOREIGN KEY (id_koncert)
        REFERENCES Koncert(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_muzicar)
        REFERENCES Muzicar(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_bend)
        REFERENCES Bend(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
