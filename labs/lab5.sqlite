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


-- Solutions
-- 1. Да се напише DML израз со кој ќе се излистаат  името и националноста (без дупликати, односно само уникатни вредности) на сите автори кои
-- презентирале книга која што добила оценка поголема од 6 и во чија промоција учествувал издавач чије што име започнува со „New“,
-- подредени според добиената оценка во растечки редослед.

SELECT DISTINCT artistic_name, nationality FROM Author author
JOIN Book_Promotion bp ON bp.author_id == author.author_id
JOIN Publisher publisher ON publisher.publisher_id = bp.publisher_id
WHERE bp.rating > 6 AND publisher.name LIKE 'New%'
ORDER BY bp.rating ASC;

-- 2. Да се напише DML израз со кој ќе се излистаат  информациите за авторите кои НЕМААТ издадено ниту една книга на одржан саем.

SELECT * FROM Author author WHERE NOT EXISTS (SELECT * FROM Book_Promotion bp WHERE bp.author_id == author.author_id);

-- 3. Да се напише DML израз со кој ќе се излистаат информациита за сите саеми кои се одржувале на локации со капацитет поголем од 1000.
-- Притоа треба да се прикажат информациите за името на саемот и локацијата на која е одржан саемот. Резултатот треба да биде подреден според името на саемот.

SELECT fair.name AS fiar_name, location.name AS location_name FROM Fair fair
JOIN Location location ON fair.location_id = location.location_id
WHERE location.capacity > 1000;

-- 4. Да се напише DML израз со кој ќе се излистаат информациите за авторите кои се промовирани од издавачи кои немаат ниту еден спонзор.

SELECT author.* FROM Author author
JOIN Publisher_Promotion pp ON pp.author_id = author.author_id
WHERE NOT EXISTS (SELECT * FROM Publisher_Sponsor ps WHERE ps.publisher_id == pp.publisher_id);

-- 5. Да се напише DML израз со кој ќе се излистаат имињата на авторите и на издавачите, такашто:
-- * Прикажи ги имињата на авторите вклучени во промоциите на книги со оценка над 4.
-- * Прикажи ги имињата на издавачи вклучени во промоциите  во текот на 2024 година.
-- Резултатот треба да вклучува име на автор/издавач, како и тип (кој може да има две вредности Author/Publisher)

SELECT DISTINCT author.artistic_name AS name, 'Author' AS type
FROM Author author
JOIN Book_Promotion bp ON bp.author_id = author.author_id
WHERE bp.rating > 4
UNION ALL
SELECT DISTINCT publisher.name AS name, 'Publisher' AS type
FROM Publisher publisher
JOIN Publisher_Promotion pp ON publisher.publisher_id = pp.publisher_id
WHERE start_date LIKE '2024%'
ORDER BY name ASC;

-- 6. Да се напише DML израз со кој ќе се прикажат датумите на одржување и името на саемот, за сите одржани саеми кои
-- се случиле на локација од тип „OUTDOOR“ и каде што самата локација има капацитет помал од 500 посетители.

SELECT hf.date, fair.name FROM Held_Fair hf
JOIN Fair fair ON fair.fair_id = hf.fair_id
JOIN Location location ON location.location_id = fair.location_id
WHERE location.type = 'OUTDOOR' AND location.capacity < 500

-- Additional requirements.

-- 7. Да се напише DML израз со кој ќе се излистаат имиња на сите мрежи на мобилност за кои не е доделен ниту еден грант.

SELECT name FROM Mobility_Network network
WHERE NOT EXISTS (SELECT * FROM Grant grant WHERE network.id = grant.network_id);

-- 8. Да се напише DML израз со кој ќе се излистаат имиња на универзитети кои се партнери (part_of) мрежата „Erasmus+ Digital“, кои ниту еднаш не биле домаќини на студентска размена (mobility_project) во рамки на истата таа мрежа.

SELECT university.name FROM University university
JOIN Part_of part ON university.id = part.university_id
JOIN Mobility_Network network ON network.id = part.network_id
WHERE network.name = 'Erasmus+ Digital' AND NOT EXISTS (
    SELECT * FROM Mobility_Project project
    WHERE project.network_id = network.id AND project.university_id = university.id
);
