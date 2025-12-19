-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Lice(id, mbr, ime, prezime, data_r, vozrast, pol), PK: id
-- Med_lice(id*, staz), PK: id
-- Test(id*, shifra, tip, datum, rezultat, laboratorija), PK: id, shifra
-- Vakcina(shifra, ime, proizvoditel), PK: shifra
-- Vakcinacija(id_lice*, id_med_lice*, shifra_vakcina*), PK: id_lice, id_med_lice, shifra_vakcina
-- Vakcinacija_datum(id_lice*, id_med_lice*, shifra_vakcina*, datum), PK: id_lice, id_med_lice, shifra_vakcina, datum


SELECT DISTINCT lice.id FROM Lice lice
JOIN Test test ON test.id = lice.id
JOIN Vakcinacija_datum vd ON vd.id_lice = lice.id
WHERE test.rezultat = 'pozitiven' AND vd.datum > test.datum
ORDER BY lice.id ASC;
