-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Korisnik(kor_ime, ime, prezime, pol, data_rag, data_reg), PK: kor_ime
-- Korisnik_email(kor_ime*, email), PK: kor_ime, email
-- Mesto(id, ime), PK: id
-- Poseta(kor_ime*, id_mesto*, datum), PK: kor_ime, id_mesto, datum
-- Grad(id_mesto*, drzava), PK: id_mesto
-- Objekt(id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*), PK: id_mesto
-- Sosedi(grad1*, grad2*, rastojanie), PK: grad1, grad2


SELECT DISTINCT korisnik.ime, korisnik.prezime FROM Korisnik korisnik
JOIN Poseta p1 ON p1.kor_ime = korisnik.kor_ime
JOIN Poseta p2 ON p2.kor_ime = korisnik.kor_ime
    AND p1.datum = p2.datum
    AND p1.id_mesto != p2.id_mesto
JOIN Objekt o1 ON o1.id_mesto = p1.id_mesto
JOIN Objekt o2 ON o2.id_mesto = p2.id_mesto
JOIN Sosedi sosedi ON (
    (sosedi.grad1 = o1.id_grad AND sosedi.grad2 = o2.id_grad) OR
    (sosedi.grad1 = o2.id_grad AND sosedi.grad2 = o1.id_grad)
);
