-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email), PK: k_ime
-- Premium_korisnik(k_ime*, datum, procent_popust), PK: k_Ime
-- Profil(k_ime*, ime, datum), PK: k_ime, ime
-- Video_zapis(naslov, jazik, vremetraenje, datum_d, datum_p), PK:
-- Video_zapis_zanr(naslov*, zanr)
-- Lista_zelbi(naslov*, k_ime*, ime*)
-- Preporaka(ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


WITH Korisnik_preporaki AS (
    SELECT k_ime_od AS k_ime FROM Preporaka
    GROUP BY k_ime_od
    HAVING COUNT(*) = (
        SELECT MAX(max_preporaki) FROM (
            SELECT COUNT(*) AS max_preporaki FROM Preporaka
            GROUP BY k_ime_od
        )
    )
)

SELECT kp.k_ime, COUNT(preporaka.naslov) AS dobieni_preporaki FROM Korisnik_preporaki kp
JOIN Preporaka preporaka ON preporaka.k_ime_na = kp.k_ime
GROUP BY preporaka.k_ime_na
