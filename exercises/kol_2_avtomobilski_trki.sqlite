-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Pateka(ime, grad, drzava, dolzina, tip), PK: ime
-- Trka(ime, krugovi, pateka*), PK: ime
-- Odrzana_trka(ime*, datum, vreme), PK: ime, datum
-- Vozac(vozacki_broj, ime, prezime, nacionalnost, datum_r), PK: vozacki_broj
-- Tim(ime, direktor), PK: ime
-- Sponzori(ime*, sponzor), PK: ime, sponzor
-- Vozi_za(vozacki_broj*, ime_tim*, datum_pocetok, datum_kraj), PK: vozacki_broj, ime_time, datum_pocetok
-- Ucestvuva(ID, vozacki_broj*, ime_tim*, ime_trka*, datum_trka*, pocetna_p, krajna_p, poeni), PK: ID


-- 1. Да се напишат соодветните DDL изрази за ентитетните множества „TРКА“, „ОДРЖАНА_ТРКА“ и „УЧЕСТВУВА“,
-- како и за евентуалните релации кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:

-- * Сакаме да водиме евиденција за учествата на трки од возачи кои се избришани од системот,
--   но не сакаме да водиме евиденција за учествата на трки од тимови кои се избришани од системот.
-- * Само возачите кои ја завршиле трката на првите 10 позиции добиваат поени (останатите добиваат 0 поени).
-- * Трката не смее да има повеќе од 80 кругови.

CREATE TABLE Trka (
    ime VARCHAR(100) PRIMARY KEY,
    krugovi INT,
    pateka VARCHAR(100),
    FOREIGN KEY(pateka)
        REFERENCES Pateka(ime)
        ON DELETE CASCADE ON UPDATE CASCADE
    CHECK (krugovi <= 80)
);

CREATE TABLE Odrzana_trka (
    ime VARCHAR(100),
    datum VARCHAR(10),
    vreme INT,
    PRIMARY KEY(ime, datum),
    FOREIGN KEY(ime)
        REFERENCES Trka(ime)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ucestvuva (
    ID INT PRIMARY KEY,
    vozacki_broj INT,
    ime_tim VARCHAR(100),
    ime_trka VARCHAR(100),
    datum_trka VARCHAR(10),
    pocetna_p INT,
    krajna_p INT,
    poeni REAL,
    FOREIGN KEY(vozacki_broj)
        REFERENCES Vozac(vozacki_broj)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(ime_tim)
        REFERENCES Tim(ime)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(ime_trka, datum_trka)
        REFERENCES Odrzana_trka(ime, datum)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK ((krajna_p <= 10 AND poeni > 0) OR (krajna_p > 10 AND poeni = 0))
);

-- 2. Да се напише DML израз со кој ќе се вратат информациите за возачите кои во 2023 година освоиле (еден или повеќе) поени
-- на одржани трки со помалку од 70 кругови подредени според датумот на раѓање по опаѓачки редослед.

SELECT DISTINCT vozac.* FROM Vozac vozac
JOIN Vozi_za vz ON vz.vozacki_broj = vozac.vozacki_broj
JOIN Ucestvuva ucestvuva ON ucestvuva.vozacki_broj = vozac.vozacki_broj AND ucestvuva.ime_tim = vz.ime_tim
JOIN Trka trka ON trka.ime = ucestvuva.ime_trka
WHERE ucestvuva.datum_trka LIKE '2023%' AND trka.krugovi < 70 AND ucestvuva.poeni > 0
ORDER BY vozac.datum_r DESC;


-- 3. Да се напише DML израз со кој за секоја трка ќе се врати возачот кој има најмногу победи на таа трка.

SELECT ucestvuva.ime_trka AS race, ucestvuva.vozacki_broj AS driver FROM Odrzana_trka ot
JOIN Ucestvuva ucestvuva ON ucestvuva.ime_trka = ot.ime AND ucestvuva.datum_trka = ot.datum
WHERE ucestvuva.krajna_p = 1
GROUP BY ot.ime, ucestvuva.vozacki_broj
HAVING COUNT(*) = (
    SELECT MAX(pobedi) FROM (
        SELECT COUNT(*) AS pobedi FROM Ucestvuva ucestuva2
        WHERE ucestuva2.krajna_p = 1 AND ucestuva2.ime_trka = ucestvuva.ime_trka
        GROUP BY ucestuva2.vozacki_broj
    )
)


-- 4. Да се напише/ат соодветниот/те тригер/и за одржување на референцијалниот интегритет на релацијата „УЧЕСТВУВА“
--    доколку треба да се исполнети следните барања:
-- * Сакаме да водиме евиденција за учествата на трки од возачи кои се избришани од системот.
-- * Не сакаме да водиме евиденција за учествата на трки од тимови кои се избришани од системот.

CREATE TRIGGER Trigger_Vozaci_Delete
BEFORE DELETE ON Vozac
FOR EACH ROW
BEGIN
    UPDATE Ucestvuva
    SET vozacki_broj = NULL
    WHERE vozacki_broj = OLD.vozacki_broj;
END;

CREATE TRIGGER Trigger_Tim_Delete
BEFORE DELETE ON Tim
FOR EACH ROW
BEGIN
    DELETE FROM Ucestvuva
    WHERE ime_tim = OLD.ime;
END;
