-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Muzej(shifra, ime_muzej, opis, grad, tip, rabotno_vreme)
-- Izlozba(ime_i, opis, sprat, prostorija, datum_od, datum_do, shifra_muzej*)
-- Izlozba_TD(ime_i*)
-- Izlozba_TD_ime(ime_i*, ime_td)
-- Izlozba_UD(ime_i*)
-- Umetnicko_delo(shifra, ime, godina, umetnik)
-- Izlozeni(shifra_d*, ime_i*, datum_pocetok, datum_kraj)

-- Additional requirements:
-- 1. We do not want to keep information about artworks that were exhibited at exhibitions that have been deleted from the system.
-- 2. The museum type (tip) can have one of two values: "otvoreno" or "zatvoreno".
-- 3. Museum codes (shifra) for open museums always start with "o".

-- Note: For already created tables, assume primary keys are of type TEXT.
-- For foreign keys without specified referential integrity constraints, assume cascade update/delete.
-- Date values should be defined as strings (e.g., "2022-06-14").

CREATE TABLE IF NOT EXISTS Muzej (
    shifra TEXT PRIMARY KEY,
    ime_muzej VARCHAR(100),
    opis VARCHAR(500),
    grad VARCHAR(100),
    tip VARCHAR(20),
    rabotno_vreme VARCHAR(100),
    CHECK (tip IN ('otvoreno', 'zatvoreno')),
    CHECK (tip != 'otvoreno' OR shifra LIKE 'o%')
);

CREATE TABLE IF NOT EXISTS Umetnicko_delo (
    shifra TEXT PRIMARY KEY,
    ime VARCHAR(100),
    godina INT,
    umetnik VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Izlozeni (
    shifra_d TEXT,
    ime_i TEXT,
    datum_pocetok VARCHAR(10),
    datum_kraj VARCHAR(10),
    PRIMARY KEY (shifra_d, ime_i),
    FOREIGN KEY (shifra_d)
        REFERENCES Umetnicko_delo(shifra)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ime_i)
        REFERENCES Izlozba(ime_i)
        ON DELETE CASCADE ON UPDATE CASCADE
);


