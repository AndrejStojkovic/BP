-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(kor_ime, ime, prezime, pol, data_rag, data_reg), PK: kor_ime
-- Korisnik_email(kor_ime*, email), PK: kor_ime, email
-- Mesto(id, ime), PK: id
-- Poseta(id, kor_ime*, id_mesto*, datum), PK: id
-- Grad(id_mesto*, drzava), PK: id_mesto
-- Objekt(id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*), PK: id_mesto
-- Sosedi(grad1*, grad2*, rastojanie), PK: grad1, grad2

-- Additional requirements:
-- 1. We want to keep track of the visits (poseta) from the deleted users (korisnik).
-- 2. E-mail addresses should end in ".com" and have a minimum of 10 characters.
-- 3. The date of the visit can't be after the current DATE().


CREATE TABLE IF NOT EXISTS Korisnik (
    kor_ime VARCHAR(100) PRIMARY KEY,
    ime VARCHAR(100),
    prezime VARCHAR(100),
    pol VARCHAR(10),
    data_rag VARCHAR(10),
    data_reg VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Korisnik_email (
    kor_ime VARCHAR(100),
    email VARCHAR(50),
    PRIMARY KEY (kor_ime, email),
    FOREIGN KEY (kor_ime)
        REFERENCES Korisnik(kor_ime)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (email LIKE '%.com' AND LENGTH(email) >= 10)
);

CREATE TABLE IF NOT EXISTS Mesto (
    id INT PRIMARY KEY,
    ime VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Poseta (
    id INT PRIMARY KEY,
    kor_ime VARCHAR(100),
    id_mesto INT,
    datum VARCHAR(10),
    FOREIGN KEY (kor_ime)
        REFERENCES Korisnik(kor_ime)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_mesto)
        REFERENCES Mesto(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (datum <= DATE())
);

CREATE TABLE IF NOT EXISTS Grad (
    id_mesto INT PRIMARY KEY,
    drzava VARCHAR(100),
    FOREIGN KEY (id_mesto)
        REFERENCES Mesto(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Objekt (
    id_mesto INT PRIMARY KEY,
    adresa VARCHAR(100),
    geo_shirina INT,
    goe_dolzina INT,
    id_grad INT,
    FOREIGN KEY (id_mesto)
        REFERENCES Mesto(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_grad)
        REFERENCES Grad(id_mesto)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Sosed (
    grad1 INT,
    grad2 INT,
    rastojanie INT,
    PRIMARY KEY (grad1, grad2),
    FOREIGN KEY (grad1)
        REFERENCES Grad(id_mesto)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (grad2)
        REFERENCES Grad(id_mesto)
        ON DELETE CASCADE ON UPDATE CASCADE
);
