--get all sessions for current user to see on the calendar
create PROCEDURE getSchedule
@email NVARCHAR (50)
AS
BEGIN
    SELECT LEFT(CONVERT (VARCHAR, start_date, 126), 19) AS [start],
           LEFT(CONVERT (VARCHAR, end_date, 126), 19) AS [end],
           title,
           desc_session AS description
    FROM   session_
           INNER JOIN
           id_email AS vw
           ON vw.email = @email
           INNER JOIN
           schedule AS s
           ON session_.id_session = s.id_session
    WHERE  s.id_tutor = vw.id
           OR s.id_student = vw.id;
END

