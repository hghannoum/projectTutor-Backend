use tutorsLebanon
CREATE TABLE UserRole (
    id_role INT PRIMARY KEY,
    name_ NVARCHAR(20)
);


CREATE TABLE City (
    id_city INT  PRIMARY KEY,
    name NVARCHAR(20)
);


CREATE TABLE User_tutorsLeb (
    id_user INT  PRIMARY KEY,
    username NVARCHAR(20),
    email NVARCHAR(50),
    first_name NVARCHAR(15),
    last_name NVARCHAR(15),
    pass NVARCHAR(50),
    img TEXT,
    id_city INT,
    FOREIGN KEY (id_city) REFERENCES City(id_city),
    id_role INT ,
    FOREIGN KEY (id_role) REFERENCES UserRole(id_role)
);

CREATE TABLE Tutor (
    id_tutor INT  PRIMARY KEY,
    id_user INT,
    FOREIGN KEY (id_user) REFERENCES User_tutorsLeb(id_user)
);

CREATE TABLE Student (
    id_student INT PRIMARY KEY,
    id_user INT ,
    FOREIGN KEY (id_user) REFERENCES User_tutorsLeb(id_user)
);


CREATE TABLE Subject_ (
    id_subject INT NOT NULL PRIMARY KEY,
    name_subject NVARCHAR(20)
);

CREATE TABLE TutorSubject (
    id_tutor INT,
    id_subject INt,
    PRIMARY KEY (id_tutor, id_subject),
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_subject) REFERENCES Subject_(id_subject)
);


CREATE TABLE Request (
    id_request INT  PRIMARY KEY,
    id_tutor INT ,
    id_student INT ,
    approved BIT,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_student) REFERENCES Student(id_student)
);

CREATE TABLE Session_ (
    id_session INT  PRIMARY KEY,
    id_tutor INT ,
    id_student INT ,
    start_date DATETIME,
    end_date DATETIME,
    title NVARCHAR(20),
    desc_session TEXT,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_student) REFERENCES Student(id_student)
);

CREATE TABLE Schedule (
    id_schedule INT  PRIMARY KEY,
    id_session INT ,
    approved BIT,
    FOREIGN KEY (id_session) REFERENCES Session_(id_session)
);
CREATE PROCEDURE CheckEmailAvailability
    @email NVARCHAR(50),
    @is_available BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [User_tutorsLeb] WHERE email = @email)
        SET @is_available = 0;
    ELSE
        SET @is_available = 1;
	
END;