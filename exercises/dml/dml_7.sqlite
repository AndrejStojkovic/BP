-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Lice(id, mbr, ime, prezime, data_r, vozrast, pol), PK: id
-- Med_lice(id*, staz), PK: id
-- Test(id*, shifra, tip, datum, rezultat, laboratorija), PK: id, shifra
-- Vakcina(shifra, ime, proizvoditel), PK: shifra
-- Vakcinacija(id_lice*, id_med_lice*, shifra_vakcina*), PK: id_lice, id_med_lice, shifra_vakcina
-- Vakcinacija_datum(id_lice*, id_med_lice*, shifra_vakcina*, datum), PK: id_lice, id_med_lice, shifra_vakcina, datum


WITH Pozitivni_Avgust AS (
    SELECT DISTINCT test.id FROM Test test
    WHERE test.rezultat = 'pozitiven' AND test.datum >= '2021-08-01' AND test.datum <= '2021-08-31'
),
Dozi_po_lice AS (
    SELECT pa.id, COUNT(vd.datum) AS broj_dozi FROM Pozitivni_Avgust pa
    LEFT JOIN Vakcinacija_datum vd ON vd.id_lice = pa.id
    GROUP BY pa.id
)

SELECT
    (SUM(CASE WHEN broj_dozi < 2 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS procent
FROM Dozi_po_lice
