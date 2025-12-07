CREATE TABLE DEPARTMENT (
    dept_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE DOCTOR (
    doctor_id INT PRIMARY KEY,
    dept_id INT,
    full_name VARCHAR(100),
    contact VARCHAR(100)
    FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENT(dept_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SURGEON (
    doctor_id INT PRIMARY KEY,
    speciality VARCHAR(100) NOT NULL,
    surgical_license VARCHAR(100) NOT NULL UNIQUE,
    FOREIGN KEY (doctor_id)
        REFERENCES DOCTOR(doctor_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE NURSE (
    doctor_id INT PRIMARY KEY,
    shift VARCHAR(50) DEFAULT 'DAY',
    FOREIGN KEY (doctor_id)
        REFERENCES DOCTOR(doctor_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (shift == 'DAY' OR shift == "NIGHT" OR shift == "ROTATION")
);

CREATE TABLE PATIENT (
    patient_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    contact VARCHAR(100),
    address VARCHAR(100) DEFAULT 'Not provided'
);

CREATE TABLE EMERGENCY_CONTACT (
    patient_id INT,
    em_contact_id INT,
    full_name VARCHAR(100),
    contact VARCHAR(100),
    relation VARCHAR(100),
    PRIMARY KEY (patient_id, em_contact_id),
    FOREIGN KEY (patient_id)
        REFERENCES PATIENT(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (relation IN ('PARENT', 'SIBLING', 'FRIEND', 'SPOUSE', 'OTHER'))
);

CREATE TABLE SURGERY (
    surgeon_id INT,
    nurse_id INT,
    patient_id INT,
    time VARCHAR(100),
    procedure nvarchar(500) NOT NULL,
    PRIMARY KEY (surgeon_id, nurse_id, patient_id),
    FOREIGN KEY (surgeon_id)
        REFERENCES SURGEON(doctor_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (nurse_id)
        REFERENCES NURSE(doctor_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (patient_id)
        REFERENCES PATIENT(patient_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE CHECK_UP (
    nurse_id INT NOT NULL,
    patient_id INT,
    check_date VARCHAR(100),
    diagnosis VARCHAR(100),
    PRIMARY KEY(nurse_id, patient_id, check_date),
    FOREIGN KEY(nurse_id)
        REFERENCES NURSE(doctor_id)
        ON DELETE SET DEFAULT ON UPDATE CASCADE
    FOREIGN KEY(patient_id)
        REFERENCES PATIENT(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE
    CHECK (check_date LIKE "2025%")
);

CREATE TABLE PRESCRIPTIONS (
    nurse_id INT,
    patient_id INT,
    check_date VARCHAR(100),
    prescription VARCHAR(100),
    dosage TEXT,
    PRIMARY KEY (nurse_id, patient_id, check_date, prescription),
    FOREIGN KEY (nurse_id, patient_id, check_date)
        REFERENCES CHECK_UP(nurse_id, patient_id, check_date)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (
        (LOWER(prescription) LIKE '%fluid%' AND LOWER(dosage) LIKE '%ml') OR
        (LOWER(prescription) LIKE '%tablet%' AND LOWER(dosage) LIKE '%mg')
    )
);
