CREATE TABLE USER_table(
id_user int not null   constraint PK_userTable primary key,
username nvarchar(20), email nvarchar(50),
first_name nvarchar(15), last_name nvarchar(15), city nvarchar(20),
passw nvarchar(50), way int, img text

)

CREATE TABLE Tutor(
id_tutor int  constraint PK_Tutor primary key,
constraint FK_tutor foreign key (id_tutor) references USER_table (id_user)

)

CREATE TABLE Student(
id_Student int  constraint PK_Student primary key,
constraint FK_student foreign key (id_Student) references USER_table (id_user)

)




CREATE TABLE REQUEST(
id_tutor int  constraint FK_tutor_req foreign key (id_tutor) references Tutor (id_tutor),
id_Student int  constraint FK_student_req foreign key (id_Student) references Student (id_Student),
id_Request int  constraint PK_Request primary key,
approved bit
) 

CREATE Table Schedule(
id_tutor int  constraint FK_tutor_sec foreign key (id_tutor) references Tutor (id_tutor),
id_Student int  constraint FK_student_sec foreign key (id_Student) references Student (id_Student),
id_Schedule int  constraint PK_Schedule primary key,
approved bit,
startDate smalldatetime,
endDate smalldatetime,
title nvarchar(20),
desc_session text

)