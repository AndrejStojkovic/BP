-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Lice(id, mbr, ime, prezime, data_r, vozrast, pol), PK: id
-- Med_lice(id*, staz), PK: id
-- Test(id*, shifra, tip, datum, rezultat, laboratorija), PK: id, shifra
-- Vakcina(shifra, ime, proizvoditel), PK: shifra
-- Vakcinacija(id_lice*, id_med_lice*, shifra_vakcina*), PK: id_lice, id_med_lice, shifra_vakcina
-- Vakcinacija_datum(id_lice*, id_med_lice*, shifra_vakcina*, datum), PK: id_lice, id_med_lice, shifra_vakcina, datum

-- Во табелата Lice е креиран изведен атрибут „celosno_imuniziran“ кој прима вредности 0 и 1 и кажува дали лицето е
-- целосно имунизирано (вакцинирано со барем две дози вакцина). Дополнително, пресметана е моменталната вредност на овој атрибут за секое лице.

-- Да се напише/ат тригер/и за одржување на вредноста на атрибутот „celosno_imuniziran“ при додавање на записите од кои зависи неговата вредност.

CREATE TRIGGER Trigger_Celosno_Imuniziran
AFTER INSERT ON Vakcinacija_datum
FOR EACH ROW
BEGIN
    UPDATE Lice
    SET celosno_imuniziran = 1
    WHERE id = NEW.id_lice AND (
        SELECT COUNT(*) FROM Vakcinacija_datum
        WHERE id_lice = NEW.id_lice AND shifra_vakcina = NEW.shifra_vakcina
    ) >= 2;
END;
