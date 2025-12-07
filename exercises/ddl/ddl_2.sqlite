-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Lice(id, mbr, ime, prezime, data_r, vozrast, pol), PK: id
-- Med_lice(id*, staz), PK: id
-- Test(id*, shifra, tip, datum, rezultat, laboratorija), PK: id
-- Vakcina(shifra, ime, proizvoditel), PK: shifra
-- Vakcinacija(id_lice*, id_med_lice*, shifra_vakcina*), PK: id_lice, id_med_lice, shifra_vakcina
-- Vakcinacija_datum(id_lice*, id_med_lice*, shifra_vakcina*, datum), PK: id_lice, id_med_lice, shifra_vakcina, datum

-- Additional requirements
-- 1. "Med_lice" cannot give themselves a vaccine.
-- 2. Laboratory (laboratorija) "lab-abc" can only do "seroloshki" test (tip).
-- 3. We do not want to keep information about the test from people (lice) that have been deleted from the database.


CREATE TABLE IF NOT EXISTS Lice (
    id INT PRIMARY KEY,
    mbr INT,
    ime VARCHAR(100),
    prezime VARCHAR(100),
    data_r VARCHAR(10),
    vozrast INT,
    pol VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Med_lice (
    id INT PRIMARY KEY,
    staz INT,
    FOREIGN KEY (id)
        REFERENCES Lice(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Test (
    id INT,
    shifra INT,
    tip VARCHAR(100),
    datum VARCHAR(10),
    rezultat VARCHAR(100),
    laboratorija VARCHAR(100),
    PRIMARY KEY (id, shifra),
    FOREIGN KEY (id)
        REFERENCES Lice(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (laboratorija NOT LIKE 'lab-abc' OR tip = 'seroloshki')
);

CREATE TABLE IF NOT EXISTS Vakcina (
    shifra INT PRIMARY KEY,
    ime VARCHAR(100),
    proizvoditel VARCHAR(100),
    FOREIGN KEY (shifra)
        REFERENCES Test(shifra)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Vakcinacija (
    id_lice INT,
    id_med_lice INT,
    shifra_vakcina INT,
    PRIMARY KEY (id_lice, id_med_lice, shifra_vakcina),
    FOREIGN KEY (id_lice)
        REFERENCES Lice(id)
        ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (id_med_lice)
        REFERENCES Med_lice(id)
        ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (shifra_vakcina)
        REFERENCES Vakcina(shifra)
        ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CHECK (id_lice != id_med_lice)
);

CREATE TABLE IF NOT EXISTS Vakcinacija_datum (
    id_lice INT,
    id_med_lice INT,
    shifra_vakcina INT,
    datum VARCHAR(10),
    PRIMARY KEY (id_lice, id_med_lice, shifra_vakcina, datum),
    FOREIGN KEY (id_lice, id_med_lice, shifra_vakcina)
        REFERENCES Vakcinacija(id_lice, id_med_lice, shifra_vakcina)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK (id_lice != id_med_lice)
);
