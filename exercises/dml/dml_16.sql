-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Muzej(shifra, ime_muzej, opis, grad, tip, rabotno_vreme)
-- Izlozba(ime_i, opis, sprat, prostorija, datum_od, datum_do, shifra_muzej*)
-- Izlozba_TD(ime_i*)
-- Izlozba_TD_ime(ime_i*, ime_td)
-- Izlozba_UD(ime_i*)
-- Umetnicko_delo(shifra, ime, godina, umetnik)
-- Izlozeni(shifra_d*, ime_i*, datum_pocetok, datum_kraj)

-- Return all artists who did not have any artwork exhibited in a closed museum,
-- ordered by the artist name.


SELECT DISTINCT ud.umetnik 
FROM Umetnicko_delo ud
WHERE NOT EXISTS (
    SELECT 1 
    FROM Izlozeni iz
    INNER JOIN Izlozba i ON i.ime_i = iz.ime_i
    INNER JOIN Muzej m ON m.shifra = i.shifra_muzej
    WHERE iz.shifra_d = ud.shifra 
        AND m.tip = 'zatvoreno'
)
ORDER BY ud.umetnik ASC;

