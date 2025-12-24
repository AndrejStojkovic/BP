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


SELECT b1.ime AS B1, b2.ime AS B2 FROM Bend b1
JOIN Bend b2 ON b1.ime > b2.ime AND b1.godina_osnovanje = b2.godina_osnovanje
ORDER BY b1.id, b2.id
