-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Muzicar(id, ime, prezime, datum_ragjanje), PK: id
-- Muzicar_instrument(id_muzicar*, instrument), PK: id_muzicar, instrument
-- Bend(id, ime, godina_osnovanje), PK: id
-- Bend_zanr(id_bend*, zanr), PK: id_bend, zanr
-- Nastan(id, cena, kapacitet), PK: id
-- Koncert(id*, datum, vreme), PK: id
-- Festival(id*, ime), PK: id
-- Festival_odrzuvanje(id*, datum_od, datum_do), PK: id, datum_od
-- Muzicar_bend(id_muzicar*, id_bend*, datum_napustanje), PK: id_muzicar, id_bend
-- Festival_bend(id_festival*, datum_od*, id_bend*), PK: id_festival, datum_od, id_bend
-- Koncert_muzicar_bend(id_koncert*, id_muzicar*, id_bend*), PK: id_koncert, id_muzicar, id_bend


-- За секој музичар се чува изведен атрибут „br_bendovi“ кој го означува бројот на бендови во кои свири тој музичар.

-- Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутот „br_bendovi“ при зачленување во бенд.

CREATE TRIGGER Trigger_broj_bendovi
AFTER INSERT ON Muzicar_bend
FOR EACH ROW
BEGIN
    UPDATE Muzicar
    SET br_bendovi = (
        SELECT COUNT(*) FROM Muzicar_bend
        WHERE id_muzicar = id
    )
    WHERE id = NEW.id_muzicar;
END;
