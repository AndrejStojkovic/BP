-- The relational database is defined by these relations:
-- PK = Primary Key, * = Foreign Key

-- Location(location_id, name, address, capacity, type), PK: location_id
-- Fair(fair_id, name, duration, location_id*), PK: fair_id
-- Held_Fair(fair_id*, date), PK: fair_date, date
-- Author(author_id, artistic_name, nationality), PK: author_id
-- Publisher(publisher_id, name), PK: publisher_id
-- Publisher_Sponsor(publisher_id*, sponsor), PK: publisher_id, sponsor
-- Publisher_Promotion(author_id*, publisher_id*, start_date, end_date), PK: author_id, publisher_id, start_date
-- Book_Promotion(fair_id*, date*, publisher_id*, author_id*, book_title, rating), PK: fair_date, date, publisher_id, author_id


-- 1. Да се напише/ат соодветниот/те тригер/и за одржување на референцијалниот интегритет на релацијата „Book_Promotion“ доколку треба да се исполнети следните барања:
-- * Не сакаме да водиме евиденција за учествата на саеми (и соодветните извадачи) на автори кои се избришани од системот.
-- * Сакаме да водиме евиденција за саемите (и соодветните автори) на кои учествувале издавачи кои се избришани од системот. На место на избришаниот издавач треба да се постави вредност -1.

CREATE TRIGGER Trigger_Author_Delete
AFTER DELETE ON Author
FOR EACH ROW
BEGIN
    DELETE FROM Book_Promotion
    WHERE author_id = OLD.author_id;
END;

CREATE TRIGGER Trigger_Publisher_Delete
AFTER DELETE ON Publisher
FOR EACH ROW
BEGIN
    UPDATE Book_Promotion
    SET publisher_id = -1
    WHERE publisher_id = OLD.publisher_id;
END;

-- 2. Да се напише/ат соодветниот/те тригер/и за одржување на референцијалниот интегритет на релацијата „Book_Promotion“ доколку треба да се исполнети следните барања:
-- * Не сакаме да водиме евиденција за промоциите на автори и нивните издавачи на одржани саеми (Held_Fair) кои се избришани од системот.
-- * Сакаме да водиме евиденција за саемите (и соодветните издавачи) на кои учествувале автори кои се избришани од системот. На место на избришаниот автор треба да се постави вредност -1.

CREATE TRIGGER Trigger_Held_Fair_Delete
AFTER DELETE ON Held_Fair
FOR EACH ROW
BEGIN
    DELETE FROM Book_Promotion
    WHERE fair_id = OLD.fair_id AND date = OLD.date;
END;

CREATE TRIGGER Trigger_Author_Delete
AFTER DELETE ON Author
FOR EACH ROW
BEGIN
    UPDATE Book_Promotion
    SET author_id = -1
    WHERE author_id = OLD.author_id;
END;

-- 3. За секој автор се чува изведен атрибут „num_fairs“ кој го означува бројот на саеми на кои имал промоција на книга.
-- Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутот „num_fairs“ при додавање и отстранување промоции на книги.

CREATE TRIGGER On_Added
AFTER INSERT ON Book_Promotion
FOR EACH ROW
BEGIN
    UPDATE Author
    SET num_fairs = num_fairs + 1
    WHERE author_id = NEW.author_id;
END;

CREATE TRIGGER On_Removed
AFTER DELETE ON Book_Promotion
FOR EACH ROW
BEGIN
    UPDATE Author
    SET num_fairs = num_fairs - 1
    WHERE author_id = OLD.author_id;
END;

-- 4. За секој автор се чува изведен атрибут „num_publishers“ кој го означува бројот на различни издавачи со кои имал промоција во 2025 година.
-- Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутот „num_publishers“ при додавање промоции.

CREATE TRIGGER On_Added
AFTER INSERT ON Publisher_Promotion
FOR EACH ROW
BEGIN
    UPDATE Author
    SET num_publishers = (
        SELECT COUNT(DISTINCT publisher_id) FROM Publisher_Promotion
        WHERE author_id = NEW.author_id AND start_date LIKE '2025%' AND end_date LIKE '2025%'
    )
    WHERE author_id = NEW.author_id;
END;
