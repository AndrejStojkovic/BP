-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(kor_ime, ime, prezime, pol, data_rag, data_reg), PK: kor_ime
-- Korisnik_email(kor_ime*, email), PK: kor_ime, email
-- Mesto(id, ime), PK: id
-- Poseta(kor_ime*, id_mesto*, datum), PK: kor_ime, id_mesto, datum
-- Grad(id_mesto*, drzava), PK: id_mesto
-- Objekt(id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*), PK: id_mesto
-- Sosedi(grad1*, grad2*, rastojanie), PK: grad1, grad2


SELECT m.ime FROM Mesto m
JOIN Grad g ON g.id_mesto = m.id
JOIN Objekt o ON o.id_grad = g.id_mesto
JOIN Poseta p ON p.id_mesto = o.id_mesto
GROUP BY m.id, m.ime
HAVING COUNT(*) = (
    SELECT MAX(broj_poseti) FROM (
        SELECT COUNT(*) AS broj_poseti FROM Poseta p2
        JOIN Objekt o2 ON o2.id_mesto = p2.id_mesto
        GROUP BY o2.id_grad
    )
);
