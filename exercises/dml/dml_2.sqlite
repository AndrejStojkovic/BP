-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Muzicar(id, ime, prezime, datum_ragjanje), PK: id
-- Muzicar_instrument(id_muzicar*, instrument), PK: id_muzicar, instrument
-- Bend(id, ime, godina_osnovanje), PK: id
-- Bend_zanr(id_bend*, zanr), PK: id_bend, zanr
-- Nastan(id, cena, kapacitet), PK: id
-- Koncert(id*, datum, vreme), PK: id
-- Festival(id*, ime), PK: id
-- Festival_odrzuvanje(id*, datum_od, datum_do), PK: id, datum_od
-- Muzicar_bend(id_muzicar*, id_bend*, datum_napustanje), PK: id_muzicar, id_bend
-- Festival_bend(id_festival*, datum_od*, id_bend*), PK: id_festival, datum_od, id_bend
-- Koncert_muzicar_bend(id_koncert*, id_muzicar*, id_bend*), PK: id_koncert, id_muzicar, id_bend


SELECT muzicar.ime, muzicar.prezime FROM Muzicar muzicar
JOIN Muzicar_instrument mi ON mi.id_muzicar = muzicar.id
JOIN Koncert_muzicar_bend kmb ON kmb.id_muzicar = muzicar.id
JOIN Muzicar_bend mb ON mb.id_muzicar = muzicar.id AND mb.id_bend = kmb.id_bend
JOIN Koncert koncert ON koncert.id = kmb.id_koncert
WHERE mi.instrument = 'gitara'
    AND mb.datum_napustanje IS NOT NULL
    AND koncert.datum > mb.datum_napustanje
