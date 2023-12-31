--view all requests include the ones the user has sent(if student), received(if tutor), and accepted  
create PROCEDURE view_request
@email NVARCHAR (50)
AS
BEGIN
    SELECT Request.id_request,
           Request.id_tutor,
           Request.id_student,
           Request.approved AS approved,
           User_tutorsLeb_1.email AS email_from,
           User_tutorsLeb.email AS email_to,
           User_tutorsLeb_1.username AS name_from,
           User_tutorsLeb.username AS name_to,
           User_tutorsLeb.way AS way_to,
           User_tutorsLeb.category AS category_to,
           User_tutorsLeb_1.way AS way_from,
           User_tutorsLeb_1.category AS category_from,
           User_tutorsLeb_1.img AS img_from,
           User_tutorsLeb.img AS img_to,
           c.name AS city_to,
           c1.name AS city_from
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
           User_tutorsLeb AS User_tutorsLeb_1
           ON Student.id_user = User_tutorsLeb_1.id_user
           INNER JOIN
           city AS c
           ON c.id_city = User_tutorsLeb.id_city
           INNER JOIN
           vw_city AS c1
           ON c1.id_city = User_tutorsLeb_1.id_city
    WHERE  User_tutorsLeb.email = @email
           OR User_tutorsLeb_1.email = @email;
END

