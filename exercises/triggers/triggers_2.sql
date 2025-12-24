-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Lice(id, mbr, ime, prezime, data_r, vozrast, pol), PK: id
-- Med_lice(id*, staz), PK: id
-- Test(id*, shifra, tip, datum, rezultat, laboratorija), PK: id, shifra
-- Vakcina(shifra, ime, proizvoditel), PK: shifra
-- Vakcinacija(id_lice*, id_med_lice*, shifra_vakcina*), PK: id_lice, id_med_lice, shifra_vakcina
-- Vakcinacija_datum(id_lice*, id_med_lice*, shifra_vakcina*, datum), PK: id_lice, id_med_lice, shifra_vakcina, datum

-- За секое лице дополнително се чува изведен атрибут „vakcinalen_status“ кој го покажува моменталниот статус за вакцините на даденото лице.
-- Атрибутот vakcinalen_status може да ги прима следните вредности: 'nema vakcina', 'primena prva doza', 'primeni dve dozi'.
-- На почеток сите лица имаат vakcinalen_status='nema vakcina'. Статусот на дадено лице станува 'primena prva doza' кога лицето ќе прими прва доза од некоја вакцина.
-- Статусот на дадено лице станува 'primeni dve dozi' кога лицето ќе ја прими втората доза од вакцината.

-- Да се напише/ат тригер/и за одржување на вредноста на атрибутот „vakcinalen_status“ при додавање на нови записи од кои зависи неговата вредност.

CREATE TRIGGER Trigger_vakcinalen_status
AFTER INSERT ON Vakcinacija_datum
FOR EACH ROW
BEGIN
    UPDATE Lice
    SET vakcinalen_status = "primena prva doza"
    WHERE id = NEW.id_lice AND (
        SELECT COUNT(*) FROM Vakcinacija_datum
        WHERE id_lice = NEW.id_lice AND shifra_vakcina = NEW.shifra_vakcina
    ) = 1;

    UPDATE Lice
    SET vakcinalen_status = "primeni dve dozi"
    WHERE id = NEW.id_lice AND (
        SELECT COUNT(*) FROM Vakcinacija_datum
        WHERE id_lice = NEW.id_lice AND shifra_vakcina = NEW.shifra_vakcina
    ) = 2;
END;
