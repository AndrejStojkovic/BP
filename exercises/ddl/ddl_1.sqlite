-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Vraboten(ID, ime, prezime, datum_r, datum_v, obrazovanie, plata), PK: ID
-- Shalterski_rabotnik(ID*), PK: ID
-- Klient(MBR_k, ime, prezime, adresa, datum), PK: MBR_k
-- Smetka(MBR_k_s*, broj, valuta, saldo), PK: MBR_k_s, broj
-- Transakcija_shalter(ID, ID_v*, MBR_k*, MBR_k_s*, broj*, datum, suma, tip), PK: ID
-- Bankomat(ID, lokacija, datum_p, zaliha), PK: ID
-- Transakcija_bankomat(ID, MBR_k_s*, broj*, ID_b*, datum, suma), PK:ID

-- Additional requirements
-- 1. If a certain employee is deleted, the information about the transactions they performed must remain stored in the database.
-- 2. The date of the transaction must not be in the period from 30.12.2020 to 14.01.2021.
-- 3. The 'tip' in the transaction must be either "uplata" or "isplata".
-- 4. The date of birth (datum_r) for each "Vraboten" must be before the date of hiring (datum_v).


CREATE TABLE IF NOT EXISTS Vraboten (
    ID INT PRIMARY KEY,
    ime VARCHAR(100),
    prezime VARCHAR(100),
    datum_r VARCHAR(10),
    datum_v VARCHAR(10),
    obrazovanie VARCHAR(100),
    plata INT,
    CHECK (datum_r < datum_v)
);

CREATE TABLE IF NOT EXISTS Shalterski_rabotnik (
    ID INT PRIMARY KEY,
    FOREIGN KEY (ID)
        REFERENCES Vraboten(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Klient (
    MBR_k INT PRIMARY KEY,
    ime VARCHAR(100),
    prezime VARCHAR(100),
    adresa VARCHAR(100),
    datum VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Smetka (
    MBR_k_s INT,
    broj INT,
    valuta VARCHAR(100),
    datum VARCHAR(10),
    PRIMARY KEY (MBR_k_s, broj),
    FOREIGN KEY (MBR_k_s)
        REFERENCES Klient(MBR_k)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Transakcija_shalter (
    ID INT PRIMARY KEY,
    ID_v INT,
    MBR_k INT,
    MBR_k_s INT,
    broj INT,
    datum VARCHAR(10),
    suma INT,
    tip VARCHAR(100),
    FOREIGN KEY (ID_v)
        REFERENCES Shalterski_rabotnik(ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (MBR_k)
        REFERENCES Klient(MBR_k)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MBR_k_s, broj)
        REFERENCES Smetka(MBR_k_s, broj)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK ((datum < '2020-12-30' OR datum > '2021-01-14') AND tip IN ('uplata', 'isplata'))
);

CREATE TABLE IF NOT EXISTS Bankomat (
    ID INT PRIMARY KEY,
    lokacija VARCHAR(100),
    datum_p VARCHAR(10),
    zaliha INT
);

CREATE TABLE IF NOT EXISTS Transakcija_bankomat (
    ID INT PRIMARY KEY,
    MBR_k_s INT,
    broj INT,
    ID_b INT,
    datum VARCHAR(10),
    suma INT,
    FOREIGN KEY (MBR_k_s)
        REFERENCES Smetka(MBR_k_s, broj)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_b)
        REFERENCES Bankomat(ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
