create database tutors
CREATE TABLE UserRole (
    id_role INT NOT NULL PRIMARY KEY,
    name_ NVARCHAR(20)
);

ALTER TABLE tutorsLeb.Subject_
ADD CONSTRAINT chk_id_tutor_not_zero
CHECK (id_subject > 0);
CREATE TABLE City (
    id_city INT NOT NULL PRIMARY KEY,
    name NVARCHAR(20)
);

CREATE TABLE User_tutorsLeb (
    id_user INT NOT NULL PRIMARY KEY,
    username NVARCHAR(20),
    email NVARCHAR(50),
    first_name NVARCHAR(15),
    last_name NVARCHAR(15),
    pass NVARCHAR(50),
    img TEXT,
    id_city INT,
    FOREIGN KEY (id_city) REFERENCES City(id_city),
    id_role INT NOT NULL,
    FOREIGN KEY (id_role) REFERENCES UserRole(id_role)
);

CREATE TABLE Tutor (
    id_tutor INT NOT NULL PRIMARY KEY,
    id_user INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES User_tutorsLeb(id_user)
);

CREATE TABLE Student (
    id_student INT NOT NULL PRIMARY KEY,
    id_user INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES User_tutorsLeb(id_user)
);


CREATE TABLE Subject_ (
    id_subject INT NOT NULL PRIMARY KEY,
    name_subject NVARCHAR(20)
);

CREATE TABLE TutorSubject (
    id_tutor INT NOT NULL,
    id_subject INT NOT NULL,
    PRIMARY KEY (id_tutor, id_subject),
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_subject) REFERENCES Subject_(id_subject)
);


CREATE TABLE Request (
    id_request INT NOT NULL PRIMARY KEY,
    id_tutor INT NOT NULL,
    id_student INT NOT NULL,
    approved BIT,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_student) REFERENCES Student(id_student)
);

CREATE TABLE Session_ (
    id_session INT NOT NULL PRIMARY KEY,
    id_tutor INT NOT NULL,
    id_student INT NOT NULL,
    start_date DATETIME,
    end_date DATETIME,
    title NVARCHAR(20),
    desc_session TEXT,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_student) REFERENCES Student(id_student)
);

CREATE TABLE Schedule (
    id_schedule INT NOT NULL PRIMARY KEY,
    id_session INT NOT NULL,
    approved BIT,
    FOREIGN KEY (id_session) REFERENCES Session_(id_session)
);
