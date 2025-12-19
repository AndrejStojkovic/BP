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


WITH Festival_podatoci AS (
    SELECT fo.id AS id, COUNT(DISTINCT fo.datum_od) AS broj_odrzuvanja, COUNT(DISTINCT fb.id_bend) AS broj_bendovi
    FROM Festival_odrzuvanje fo
    JOIN Festival_bend fb ON fo.id = fb.id_festival AND fo.datum_od = fb.datum_od
    GROUP BY fo.id
)

SELECT festival.ime, nastan.cena, nastan.kapacitet, fp.broj_odrzuvanja, fp.broj_bendovi
FROM Festival festival
JOIN Nastan nastan ON nastan.id = festival.id
JOIN Festival_podatoci fp ON fp.id = festival.id
