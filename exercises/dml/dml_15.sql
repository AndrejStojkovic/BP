-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Muzej(shifra, ime_muzej, opis, grad, tip, rabotno_vreme)
-- Izlozba(ime_i, opis, sprat, prostorija, datum_od, datum_do, shifra_muzej*)
-- Izlozba_TD(ime_i*)
-- Izlozba_TD_ime(ime_i*, ime_td)
-- Izlozba_UD(ime_i*)
-- Umetnicko_delo(shifra, ime, godina, umetnik)
-- Izlozeni(shifra_d*, ime_i*, datum_pocetok, datum_kraj)

-- Return the names of artworks together with their creators (artists) 
-- that were exhibited on at least one exhibition for the entire duration of that exhibition,
-- ordered by the artwork name.


SELECT DISTINCT ud.ime, ud.umetnik 
FROM Umetnicko_delo ud
JOIN Izlozeni iz ON iz.shifra_d = ud.shifra
JOIN Izlozba i ON i.ime_i = iz.ime_i
WHERE iz.datum_pocetok = i.datum_od 
    AND iz.datum_kraj = i.datum_do
ORDER BY ud.ime ASC;


