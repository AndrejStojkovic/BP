-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Muzej(shifra, ime_muzej, opis, grad, tip, rabotno_vreme), PK: shifra
-- Izlozba(ime_i, opis, sprat, prostorija, datum_od, datum_do, shifra_muzej*), PK: ime_i
-- Izlozba_TD(ime_i*), PK: ime_i
-- Izlozba_TD_ime(ime_i*, ime_td), PK: ime_i, ime_td
-- Izlozba_UD(ime_i*), PK: ime_i
-- Umetnicko_delo(shifra, ime, godina, umetnik), PK: shifra
-- Izlozeni(shifra_d*, ime_i*, datum_pocetok, datum_kraj), PK: shifra_d, ime_i


-- 1.Да се напишат соодветните DDL изрази за ентитетните множества „МУЗЕЈ“, „УМЕТНИЧКО_ДЕЛО“ и „ИЗЛОЖЕНИ“,
-- како и за евентуалните релации кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:
-- * Не сакаме да водиме информации за делата кои биле изложени на изложби кои се избришани од системот.
-- * Типот на музејот може да има една од двете вредности, „otvoreno“ или „zatvoreno“.
-- * Шифрата на музеите на отворено секогаш почнува со „о“.


CREATE TABLE IF NOT EXISTS Muzej (
    shifra INT PRIMARY KEY,
    ime_muzej VARCHAR(100),
    opis VARCHAR(200),
    grad VARCHAR(100),
    tip VARCHAR(100),
    rabotno_vreme VARCHAR(100),
    CHECK (tip IN ('otvoreno', 'zatvoreno')),
    CHECK (tip != 'otvoreno' OR shifra LIKE 'o%')
);

CREATE TABLE IF NOT EXISTS Umetnicko_delo (
    shifra INT PRIMARY KEY,
    ime VARCHAR(100),
    godina INT,
    umetnik VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Izlozeni (
    shifra_d INT,
    ime_i VARCHAR(50),
    datum_pocetok VARCHAR(10),
    datum_kraj VARCHAR(10),
    PRIMARY KEY (shifra_d, ime_i),
    FOREIGN KEY (shifra_d)
        REFERENCES Umetnicko_delo (shifra)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ime_i)
        REFERENCES Izlozba_UD(ime_i)
        ON DELETE CASCADE ON UPDATE CASCADE
);


-- 2. Да се напише DML израз со кој ќе се вратат имињата на уметничките дела заедно со нивните креатори (уметници)
-- кои биле изложени на барем една изложба во целото времетраење на истата подредени според името на уметничкото дело.


SELECT DISTINCT ud.ime, ud.umetnik FROM Umetnicko_delo ud
JOIN Izlozeni izlozeni ON izlozeni.shifra_d = ud.shifra
JOIN Izlozba izlozba ON izlozba.ime_i = izlozeni.ime_i
WHERE izlozeni.datum_pocetok = izlozba.datum_od AND izlozeni.datum_kraj = izlozba.datum_do
ORDER BY ud.ime ASC;


-- 3. Да се напише DML израз со кој ќе се вратат сите уметници кои немале ниту едно уметничко дело изложено во музеј
-- на затворено подредени според името на уметникот.


WITH Izlozeni_Umetnici AS (
    SELECT DISTINCT ud.umetnik AS umetnik FROM Umetnicko_delo ud
    JOIN Izlozeni i ON i.shifra_d = ud.shifra
    JOIN Izlozba iz ON iz.ime_i = i.ime_i
    JOIN Muzej m ON m.shifra = iz.shifra_muzej
    WHERE m.tip = 'zatvoreno'
)

SELECT DISTINCT ud.umetnik FROM Umetnicko_delo ud
WHERE NOT EXISTS (
    SELECT * FROM Izlozeni_Umetnici iu WHERE iu.umetnik = ud.umetnik
)
ORDER BY ud.umetnik ASC;


-- 4. Да се напише DML израз со кој ќе се врати името на музејот кој имал најмногу изложени различни уметнички дела во 2023 година
-- (уметничките дела кај кои почетниот датум на изложување на некоја изложба на уметнички дела е во 2023 година).


WITH Izlozeni_Muzej AS (
    SELECT COUNT(DISTINCT izlozeni.shifra_d) AS broj
    FROM Muzej m
    JOIN Izlozba i ON m.shifra = i.shifra_muzej
    JOIN Izlozeni izlozeni ON izlozeni.ime_i = i.ime_i
    WHERE izlozeni.datum_pocetok LIKE '2023%'
    GROUP BY m.shifra
)

SELECT m.ime_muzej FROM Muzej m
JOIN Izlozba i ON i.shifra_muzej = m.shifra
JOIN Izlozeni izlozeni ON izlozeni.ime_i = i.ime_i
WHERE izlozeni.datum_pocetok LIKE '2023%'
GROUP BY m.shifra, m.ime_muzej
HAVING COUNT(DISTINCT izlozeni.shifra_d) = (
    SELECT MAX(broj) FROM Izlozeni_Muzej
);


-- 5. За секое уметничко дело се чуваат изведените атрибути „br_izlozbi_otvoreno“ и „br_izlozbi_zatvoreno“ кои го означуваат бројот
-- на изложби одржани во музеи на отворено и бројот на изложби одржани во музеи на затворено на кои било изложено делото.
-- Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутите „br_izlozbi_otvoreno“ и „br_izlozbi_zatvoreno“ при додавање на записите од кои зависи нивната вредност.


CREATE TRIGGER Trigger_Otvoreni
AFTER INSERT ON Izlozeni
FOR EACH ROW
WHEN (
    SELECT m.tip FROM Izlozba i
    JOIN Muzej m ON i.shifra_muzej = m.shifra
    WHERE i.ime_i = NEW.ime_i
) = 'otvoreno'
BEGIN
    UPDATE Umetnicko_delo
    SET br_izlozbi_otvoreno = br_izlozbi_otvoreno + 1
    WHERE shifra = NEW.shifra_d;
END;

CREATE TRIGGER Trigger_Zatvoreni
AFTER INSERT ON Izlozeni
FOR EACH ROW
WHEN (
    SELECT m.tip FROM Izlozba i
    JOIN Muzej m ON i.shifra_muzej = m.shifra
    WHERE i.ime_i = NEW.ime_i
) = 'zatvoreno'
BEGIN
    UPDATE Umetnicko_delo
    SET br_izlozbi_zatvoreno = br_izlozbi_zatvoreno + 1
    WHERE shifra = NEW.shifra_d;
END;
