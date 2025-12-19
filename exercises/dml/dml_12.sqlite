-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email), PK: k_ime
-- Premium_korisnik(k_ime*, datum, procent_popust), PK: k_Ime
-- Profil(k_ime*, ime, datum), PK: k_ime, ime
-- Video_zapis(naslov, jazik, vremetraenje, datum_d, datum_p), PK:
-- Video_zapis_zanr(naslov*, zanr)
-- Lista_zelbi(naslov*, k_ime*, ime*)
-- Preporaka(ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


SELECT korisnik.k_ime, preporaka.naslov, COUNT(preporaka.naslov) AS broj FROM Korisnik korisnik
JOIN Preporaka preporaka ON preporaka.k_ime_od = korisnik.k_ime
GROUP BY korisnik.k_ime, preporaka.naslov
HAVING COUNT(*) = (
    SELECT MAX(broj_preporaki) FROM (
        SELECT COUNT(*) AS broj_preporaki FROM Preporaka p2
        WHERE p2.k_ime_od = korisnik.k_ime
        GROUP BY p2.naslov
    )
)
ORDER BY korisnik.k_ime;
