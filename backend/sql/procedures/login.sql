--login procedure 
ALTER PROCEDURE LoginUser
@email NVARCHAR (50), @password NVARCHAR (50)
AS
BEGIN
    SELECT u.id_user,
           u.username,
           u.first_name,
           u.last_name,
           u.category,
           c.name AS city_name,
           u.pass,
           u.img,
           u.email,
           u.bio,
           u.id_role,
           u.way,
           s.name_subject AS subject_name
    FROM   User_tutorsLeb AS u
           LEFT OUTER JOIN
           City AS c
           ON u.id_city = c.id_city
           LEFT OUTER JOIN
           Tutor AS t
           ON u.id_user = t.id_user
           LEFT OUTER JOIN
           TutorSubject AS ts
           ON t.id_tutor = ts.id_tutor
           LEFT OUTER JOIN
           Subject_ AS s
           ON ts.id_subject = s.id_subject
    WHERE  u.email = @email
           AND u.pass = @password;
END

