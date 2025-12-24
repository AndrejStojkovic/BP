-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email), PK: k_ime
-- Premium_korisnik(k_ime*, datum, procent_popust), PK: k_Ime
-- Profil(k_ime*, ime, datum), PK: k_ime, ime
-- Video_zapis(naslov, jazik, vremetraenje, datum_d, datum_p), PK:
-- Video_zapis_zanr(naslov*, zanr)
-- Lista_zelbi(naslov*, k_ime*, ime*)
-- Preporaka(ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


SELECT DISTINCT k.k_ime, preporaka.naslov FROM Korisnik k
JOIN Premium_korisnik pm ON pm.k_ime = k.k_ime
JOIN Preporaka preporaka ON preporaka.k_ime_na = pm.k_ime
JOIN Lista_zelbi lz ON lz.k_ime = pm.k_ime AND lz.naslov = preporaka.naslov
WHERE preporaka.ocena > 3 AND preporaka.datum LIKE '2021%'
ORDER BY k.k_ime ASC;
