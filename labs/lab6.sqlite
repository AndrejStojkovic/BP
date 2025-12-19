-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Location(location_id, name, address, capacity, type), PK: location_id
-- Fair(fair_id, name, duration, location_id*), PK: fair_id
-- Held_Fair(fair_id*, date), PK: fair_id, date
-- Author(author_id, artistic_name, nationality), PK: author_id
-- Publisher(publisher_id, name), PK: publisher_id
-- Publisher_Sponsor(publisher_id*, sponsor), PK: publisher_id, sponsor
-- Publisher_Promotion(author_id*, publisher_id*, start_date, end_date), PK: author_id, publisher_id, start_date
-- Book_Promotion(fair_id*, date*, publisher_id*, author_id*, book_title, rating), PK: fair_id, date, publisher_id, author_id

-- Solutions:

-- 1. Да се напише DML израз со кој за авторите што имаат презентирано книги на барем 2 саеми ќе се излистаат индексот на авторот,
-- името на авторот и бројот на саеми на кои авторот има презентирано книги кои се карактеризираат со рејтинг помал од 6.

SELECT DISTINCT author.author_id, author.artistic_name, COUNT(*) AS number_of_fairs
FROM Author author
JOIN Book_Promotion bp ON bp.author_id = author.author_id AND hf.date = bp.date
JOIN Held_Fair hf ON hf.fair_id = bp.fair_id
WHERE bp.rating < 6
GROUP BY author.author_id, author.artistic_name
HAVING COUNT(*) >= 2

-- 2. Да се напише DML израз со кој ќе се излистаат информациита за сите саеми кои се одржувале на локации со капацитет поголем од 1000.
-- Притоа треба да се прикаќат информациите за името на саемот, локацијата на која е одрќан саемот, како и бројот на книги кои биле промовирани/презентирани на тој саем.
-- Резултатот треба да биде потреден според бројот на презентирани книги во растечки редослед.

SELECT fair.name AS fiar_name, location.name AS location_name, COUNT(bp.book_title) AS book_count
FROM Fair fair
JOIN Location location ON location.location_id = fair.location_id
JOIN Book_Promotion bp ON bp.fair_id = fair.fair_id
WHERE capacity > 1000
GROUP BY fair.name, location.name
ORDER BY book_count ASC;

-- 3. Да се напише DML израз со кој ќе се излистаат насловите на книгите кои се изложени на саеми чии што издавач има повеќе од 3 спонзори.
-- Насловите на книгите потребно е да бидат сортирани во растечки редослед.

SELECT DISTINCT bp.book_title FROM Book_Promotion bp
JOIN Publisher publisher ON publisher.publisher_id = bp.publisher_id
JOIN Publisher_Sponsor ps ON ps.publisher_id = publisher.publisher_id
GROUP BY bp.book_title, publisher.publisher_id
HAVING COUNT(ps.sponsor) > 3
ORDER BY bp.book_title ASC;

-- 4. Да се напише DML израз со кој ќе се излистаат индексите на авторите и имињата на авторите кои се поддржани од издавачи со најголем број на спонзори.

SELECT author.author_id, author.artistic_name FROM Author author
JOIN Publisher_Promotion pp ON pp.author_id = author.author_id
JOIN Publisher_Sponsor ps ON ps.publisher_id = pp.publisher_id
GROUP BY author.author_id, author.artistic_name, pp.publisher_id
HAVING COUNT(ps.sponsor) = (
    SELECT MAX(sponsor_count) FROM (
        SELECT COUNT(sponsor) AS sponsor_count
        FROM Publisher_Sponsor
        GROUP BY publisher_id
    )
);

-- 5. Да се напише DML израз со кој ќе се излистаат имињата на сите книги кои се презентирани на саем кој што се изведува на затворена локација (INDOOR)
-- која има најголем капацитет за гости.Имињата на книгите треба да бидат сортирани во растечки редослед.

SELECT DISTINCT bp.book_title FROM Book_Promotion bp
JOIN Fair fair ON fair.fair_id = bp.fair_id
JOIN Location location ON fair.location_id = location.location_id
WHERE location.type = 'INDOOR'
  AND location.capacity = (
      SELECT MAX(capacity)
      FROM Held_Fair hf
      JOIN Fair fair ON fair.fair_id = hf.fair_id
      JOIN Location location ON location.location_id = fair.location_id
      WHERE type = 'INDOOR'
  )
ORDER BY bp.book_title ASC;

-- 6. Да се напише DML израз со кој ќе се излистаат за секоја локација, вратете ги првите 3 автори според просечната оценка од промоција,
-- сметајќи ги само промоциите што се случиле на датумот на одржаниот саем. Прикажете го името на авторот, бројот на промовирани книги и просечната оценка.
-- Резултатот да биде сортиран според името на локацијата и просечната оценка.

WITH Data AS (
    SELECT
        location.location_id AS id,
        location.name AS location_name,
        author.artistic_name AS author_name,
        COUNT(bp.book_title) AS number_of_books,
        AVG(bp.rating) AS average_rating
    FROM Location location
    JOIN Fair fair ON fair.location_id = location.location_id
    JOIN Held_Fair hf ON hf.fair_id = fair.fair_id
    JOIN Book_Promotion bp ON bp.fair_id = hf.fair_id AND bp.date = hf.date
    JOIN Author author ON author.author_id = bp.author_id
    GROUP BY location.location_id, location.name, author.author_id, author.artistic_name
)

SELECT location_name, author_name, number_of_books, average_rating FROM Data d1
WHERE (SELECT COUNT(*) FROM Data d2 WHERE d2.id = d1.id AND d2.average_rating > d1.average_rating) < 3
ORDER BY location_name, average_rating DESC;

-- 7. Да се напише DML израз со кој ќе се најде мрежата на мобилност чии проекти имаат најниско просечно траење.

SELECT mn.id, mn.name, mn.start_date, mn.end_date FROM Mobility_Network mn
JOIN Mobility_Project mp ON mp.network_id = mn.id
GROUP BY mn.id
HAVING AVG(mp.duration) = (
    SELECT MIN(average) FROM (
        SELECT AVG(duration) AS average FROM Mobility_Network
        JOIN Mobility_Project ON network_id = id
        GROUP BY id
    )
)

-- 8. Да се напише DML израз со кој за секој универзитет ќе се претстави со колкав удел на студенти учествува во неговите мрежи на мобилност
-- (број на различни студенти од универзитетот што учествувале во барем еден проект на мобилност во неговите мрежи на мобилност /
-- број на различни студенти учесниви на проекти на мобилност во неговите мрежи на мобилност).
-- Резултатите да се прикажат подредени според ID на универзитет.

WITH Student_data AS (
    SELECT u.id, COUNT(DISTINCT s.id) AS ct FROM University u
    JOIN Student s ON s.university_id = u.id
    JOIN Mobility_Project mp ON mp.student_id = s.id
    JOIN Part_of po ON po.university_id = u.id AND po.network_id = mp.network_id
    GROUP BY u.id
),
Project_data AS (
    SELECT u.id, COUNT(DISTINCT mp.student_id) AS ct FROM University u
    JOIN Part_of po ON po.university_id = u.id
    JOIN Mobility_Network mn ON mn.id = po.network_id
    JOIN Mobility_Project mp ON mp.network_id = mn.id
    GROUP BY u.id
)

SELECT sd.id AS university_id, (sd.ct * 1.0 / pd.ct) AS percentage FROM Student_data sd
JOIN Project_data pd ON pd.id = sd.id

-- 9. Да се напише DML израз со кој за секој универзитет ќе се најде институтот со најмногу вработени.
-- Резултатите да бидат подредени прво според името на универзитетот, а потоа според името на институтот.

WITH Institute_Data AS (
    SELECT
        u.id AS university_id,
        u.name AS university_name,
        i.id AS institute_id,
        i.name AS institute_name,
        COUNT(sm.id) AS broj_vraboteni
    FROM University u
    JOIN Institute i ON i.university_id = u.id
    JOIN Staff_Member sm ON sm.institute_id = i.id
    GROUP BY u.id, i.id
)

SELECT
    id.university_id,
    id.university_name AS name,
    id.institute_id,
    id.institute_name AS name
FROM Institute_Data id
GROUP BY id.institute_name
HAVING MAX(id.broj_vraboteni) = (
    SELECT MAX(id2.broj_vraboteni) FROM Institute_Data id2
    WHERE id.university_id = id2.university_id
)
ORDER BY id.university_id, id.institute_id
