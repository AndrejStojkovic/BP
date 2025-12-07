CREATE TABLE IF NOT EXISTS University (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    founding_year INT,
    country VARCHAR(100),
    city VARCHAR(100),
    address VARCHAR(100),
    CHECK (city IN ('Skopje', 'Shtip', 'Tetovo', 'Bitola', 'Struga'))
);

CREATE TABLE IF NOT EXISTS Institute (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    university_id INT,
    FOREIGN KEY (university_id)
        REFERENCES University(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Institute_Location (
    institute_id INT PRIMARY KEY,
    location VARCHAR(100),
    FOREIGN KEY (institute_id)
        REFERENCES Institute(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Natural_Science_Institute (
    institute_id INT PRIMARY KEY,
    budget INT,
    research_focus VARCHAR(100),
    FOREIGN KEY (institute_id)
        REFERENCES Institute(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS NSI_Laboratory (
    institute_id INT,
    laboratory VARCHAR(100),
    PRIMARY KEY (institute_id, laboratory),
    FOREIGN KEY (institute_id)
        REFERENCES Institute(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Social_Science_Institute (
    institute_id INT PRIMARY KEY,
    number_of_events INT,
    FOREIGN KEY (institute_id)
        REFERENCES Institute(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Staff_Member (
    id INT PRIMARY KEY NOT NULL DEFAULT -1,
    academic_title VARCHAR(100),
    salary INT,
    working_hours INT,
    institute_id INT,
    FOREIGN KEY (institute_id)
        REFERENCES Institute(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Assistant (
    sm_id INT PRIMARY KEY,
    graduation_date DATE,
    FOREIGN KEY (sm_id)
        REFERENCES Staff_Member(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Professor (
    sm_id INT PRIMARY KEY NOT NULL,
    number_of_projects INT,
    FOREIGN KEY (sm_id)
        REFERENCES Staff_Member(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Professor_Thesis (
    sm_id INT NOT NULL DEFAULT -1,
    thesis VARCHAR(100),
    PRIMARY KEY (sm_id, thesis),
    FOREIGN KEY (sm_id)
        REFERENCES Professor(sm_id)
        ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CHECK (thesis LIKE "Abstract:%")
);


CREATE TABLE IF NOT EXISTS Course (
    id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    CHECK (start_date >= '2025-10-01' AND end_date <= '2026-09-15')
);

CREATE TABLE IF NOT EXISTS Teach (
    professor_id INT,
    assistant_id INT,
    course_id INT NOT NULL DEFAULT -1,
    PRIMARY KEY (professor_id, assistant_id, course_id),
    FOREIGN KEY (professor_id)
        REFERENCES Professor(sm_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (assistant_id)
        REFERENCES Assistant(sm_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (course_id)
        REFERENCES Course(id)
        ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Student (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(100),
    university_id INT,
    FOREIGN KEY (university_id)
        REFERENCES University(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Mobility_Network (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

CREATE TABLE IF NOT EXISTS Representative (
    staff_id INT,
    network_id INT,
    PRIMARY KEY (staff_id, network_id),
    FOREIGN KEY (staff_id)
        REFERENCES Staff_Member(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (network_id)
        REFERENCES Mobility_Network(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Head (
    staff_id INT,
    network_id INT,
    PRIMARY KEY (staff_id, network_id),
    FOREIGN KEY (staff_id)
        REFERENCES Staff_Member(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (network_id)
        REFERENCES Mobility_Network(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Grant (
    staff_id INT,
    network_id INT,
    institute_id INT,
    amount INT,
    duration INT,
    PRIMARY KEY (staff_id, network_id, institute_id),
    FOREIGN KEY (staff_id)
        REFERENCES Staff_Member(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (network_id)
        REFERENCES Mobility_Network(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (institute_id)
        REFERENCES Institute(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Part_of (
    university_id INT,
    network_id INT,
    PRIMARY KEY (university_id, network_id),
    FOREIGN KEY (university_id)
        REFERENCES University(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (network_id)
        REFERENCES Mobility_Network(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Mobility_Project(
    network_id INT,
    student_id INT,
    university_id INT,
    name VARCHAR(100),
    duration INT,
    PRIMARY KEY (network_id, student_id, university_id),
    FOREIGN KEY (network_id)
        REFERENCES Mobility_Network (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (student_id)
        REFERENCES Student(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (university_id)
        REFERENCES University(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
