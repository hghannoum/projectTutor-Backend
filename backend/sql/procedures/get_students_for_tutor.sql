--get all students to choose the ones iuncluded in the session when scheduling
ALTER PROCEDURE get_students_for_tutor
@email NVARCHAR (50)
AS
BEGIN
    SELECT vw.email AS student_email,
           User_tutorsLeb.id_user AS tutor_id,
           vw.name AS student_name
    FROM   Request
           INNER JOIN
           Tutor
           ON Request.id_tutor = Tutor.id_tutor
           INNER JOIN
           User_tutorsLeb
           ON Tutor.id_user = User_tutorsLeb.id_user
           INNER JOIN
           Student
           ON Request.id_student = Student.id_student
           INNER JOIN
           id_email AS vw
           ON vw.id = Student.id_student
    WHERE  Request.approved = 1
           AND User_tutorsLeb.email = @email;
END

