-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(kor_ime, ime, prezime, pol, data_rag, data_reg), PK: kor_ime
-- Korisnik_email(kor_ime*, email), PK: kor_ime, email
-- Mesto(id, ime), PK: id
-- Poseta(kor_ime*, id_mesto*, datum), PK: kor_ime, id_mesto, datum
-- Grad(id_mesto*, drzava), PK: id_mesto
-- Objekt(id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*), PK: id_mesto
-- Sosedi(grad1*, grad2*, rastojanie), PK: grad1, grad2


-- За секое место се чува изведен атрибут „broj_poseti“ кој го означува бројот на различни корисници кои го посетиле.

-- Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутот „broj_poseti“ при додавање на записите од кои зависи нивната вредност.

CREATE TRIGGER Trigger_Mesto_Insert
AFTER INSERT ON Poseta
FOR EACH ROW
BEGIN
    UPDATE Mesto
    SET broj_poseti = (
        SELECT COUNT(DISTINCT kor_ime) FROM Poseta
        WHERE id_mesto = NEW.id_mesto
    )
    WHERE id = NEW.id_mesto;
END;
