-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(kor_ime, ime, prezime, pol, data_rag, data_reg), PK: kor_ime
-- Korisnik_email(kor_ime*, email), PK: kor_ime, email
-- Mesto(id, ime), PK: id
-- Poseta(kor_ime*, id_mesto*, datum), PK: kor_ime, id_mesto, datum
-- Grad(id_mesto*, drzava), PK: id_mesto
-- Objekt(id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*), PK: id_mesto
-- Sosedi(grad1*, grad2*, rastojanie), PK: grad1, grad2


-- Да се напише/ат соодветниот/те тригер/и за одржување на референцијалниот интегритет на релациите „СОСЕДИ“ и „ПОСЕТА“
-- доколку треба да се исполнети следните барања:
-- * Сакаме да водиме евиденција за соседните градови на град кој е избришан од системот.
-- * Не сакаме да водиме евиденција за посетите на места на корисници кои се избришани од системот.

CREATE TRIGGER Trigger_Delete_Sosedi
AFTER DELETE ON Grad
FOR EACH ROW
BEGIN
    UPDATE Sosedi
    SET grad1 = NULL
    WHERE grad1 = OLD.id_mesto;

    UPDATE Sosedi
    SET grad2 = NULL
    WHERE grad2 = OLD.id_mesto;
END;

CREATE TRIGGER Trigger_Delete_Korisnik
AFTER DELETE ON Korisnik
FOR EACH ROW
BEGIN
    DELETE FROM Poseta
    WHERE kor_ime = OLD.kor_ime;
END;
