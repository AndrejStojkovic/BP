-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email), PK: k_ime
-- Premium_korisnik(k_ime*, datum, procent_popust), PK: k_Ime
-- Profil(k_ime*, ime, datum), PK: k_ime, ime
-- Video_zapis(naslov, jazik, vremetraenje, datum_d, datum_p), PK:
-- Video_zapis_zanr(naslov*, zanr)
-- Lista_zelbi(naslov*, k_ime*, ime*)
-- Preporaka(ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


WITH Video_zapis_ocena AS (
    SELECT vz.naslov, AVG(ocena) AS po_profil FROM Video_zapis vz
    JOIN Preporaka preporaka ON preporaka.naslov = vz.naslov
    GROUP BY vz.naslov
)

SELECT DISTINCT profil.ime, AVG(vzo.po_profil) AS po_profil FROM Profil profil
JOIN Lista_zelbi lz ON lz.k_ime = profil.k_ime AND lz.ime = profil.ime
JOIN Video_zapis_ocena vzo ON vzo.naslov = lz.naslov
GROUP BY profil.ime
ORDER BY profil.ime ASC;
