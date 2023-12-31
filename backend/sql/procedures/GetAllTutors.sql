--it gives all the tutors that the user havent send request before 
ALTER PROCEDURE GetAllTutors
@email NVARCHAR (50)
AS
BEGIN
    SELECT u.id_user,
           u.username,
           u.first_name,
           u.last_name,
           u.way,
           u.category,
           c.name AS city_name,
           u.img,
           u.bio,
           v.id,
           s.name_subject AS subject_name
    FROM   User_tutorsLeb AS u
           INNER JOIN
           City AS c
           ON u.id_city = c.id_city
           INNER JOIN
           Tutor AS t
           ON u.id_user = t.id_user
           INNER JOIN
           TutorSubject AS ts
           ON t.id_tutor = ts.id_tutor
           INNER JOIN
           Subject_ AS s
           ON ts.id_subject = s.id_subject
           INNER JOIN
           id_email AS v
           ON v.email = @email
           FULL OUTER JOIN
           request AS r
           ON r.id_student = v.id
              AND r.id_tutor = t.id_tutor
    WHERE  r.id_student IS NULL
           AND u.email != @email;
END

