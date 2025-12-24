-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email), PK: k_ime
-- Premium_korisnik(k_ime*, datum, procent_popust), PK: k_ime
-- Profil(k_ime*, ime, datum), PK: k_ime, ime
-- Video_zapis(naslov, jazik, vremetraenje, datum_d, datum_p), PK: naslov
-- Video_zapis_zanr(naslov*, zanr), PK: naslov, zanr
-- Lista_zelbi(ID, naslov*, k_ime*, ime*), PK: ID
-- Preporaka(ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena), PK: ID

-- Additional requirements:
-- 1. If there is no percentage entered for a Premium user (Premium_korisnik), then set the default value to 10.
-- 2. We want to keep track of all the wish lists (Lista_zelbi) that have delete Video entries (Video_zapis).
-- 3. Users (Korisnik) registered before 01.01.2015 cannot have a subscription (pretplata) "pretplata 3".


CREATE TABLE IF NOT EXISTS Korisnik (
    k_ime VARCHAR(100) PRIMARY KEY,
    ime VARCHAR(100),
    prezime VARCHAR(100),
    tip VARCHAR(100),
    pretplata VARCHAR(100),
    datum_reg VARCHAR(10),
    tel_broj VARCHAR(16),
    email VARCHAR(50),
    CHECK (datum_reg > '2015-01-01' OR pretplata NOT LIKE "pretplata 3")
);

CREATE TABLE IF NOT EXISTS Premium_korisnik (
    k_ime VARCHAR(100) PRIMARY KEY,
    datum VARCHAR(10),
    procent_popust INT DEFAULT 10,
    FOREIGN KEY (k_ime)
        REFERENCES Korisnik(k_ime)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Profil (
    k_ime VARCHAR(100),
    ime VARCHAR(100),
    datum VARCHAR(10),
    PRIMARY KEY (k_ime, ime),
    FOREIGN KEY (k_ime)
        REFERENCES Korisnik (k_ime)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Video_zapis (
    naslov VARCHAR(100) PRIMARY KEY,
    jazik VARCHAR(100),
    vremetraenje INT,
    datum_d VARCHAR(10),
    datum_p VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Video_zapis_zanr (
    naslov VARCHAR(100),
    zanr VARCHAR(100),
    PRIMARY KEY (naslov, zanr),
    FOREIGN KEY (naslov)
        REFERENCES Video_zapis(naslov)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Lista_zelbi (
    ID INT PRIMARY KEY,
    naslov VARCHAR(100),
    k_ime VARCHAR(100),
    ime VARCHAR(100),
    FOREIGN KEY (naslov)
        REFERENCES Video_zapis(naslov)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (k_ime, ime)
        REFERENCES Profil(k_ime, ime)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Preporaka (
    ID INT PRIMARY KEY,
    k_ime_od VARCHAR(100),
    k_ime_na VARCHAR(100),
    naslov VARCHAR(100),
    datum VARCHAR(10),
    komentar VARCHAR(128),
    ocena INT,
    FOREIGN KEY (k_ime_od)
        REFERENCES Korisnik(k_ime)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (k_ime_na)
        REFERENCES Korisnik(k_ime)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (naslov)
        REFERENCES Video_zapis(naslov)
        ON DELETE CASCADE ON UPDATE CASCADE
);
