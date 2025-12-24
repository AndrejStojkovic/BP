-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email), PK: k_ime
-- Premium_korisnik(k_ime*, datum, procent_popust), PK: k_Ime
-- Profil(k_ime*, ime, datum), PK: k_ime, ime
-- Video_zapis(naslov, jazik, vremetraenje, datum_d, datum_p), PK:
-- Video_zapis_zanr(naslov*, zanr)
-- Lista_zelbi(naslov*, k_ime*, ime*)
-- Preporaka(ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


--  За секој видео запис се чува изведен атрибут „prosechna_ocena“ кој ја означува просечната оцена добиена од препораки.
-- Дополнително, пресметана е моменталната вредност на овој атрибут за секој видео запис.

-- Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутот „prosechna_ocena“ при
-- додавање на записите од кои зависи неговата вредност.

CREATE TRIGGER Trigger_video_zapis
AFTER INSERT ON Preporaka
FOR EACH ROW
BEGIN
    UPDATE Video_zapis
    SET prosechna_ocena = (
        SELECT AVG(ocena) FROM Preporaka preporaka
        WHERE naslov = NEW.naslov
    )
    WHERE naslov = NEW.naslov;
END;
