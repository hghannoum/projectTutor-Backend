--insert new meeting into the calendar of the tutor(the session manager) and the students he has chosen
ALTER PROCEDURE insert_meeting
@tutor_email VARCHAR (50), @student_emails VARCHAR (200), @start DATETIME, @end DATETIME, @description NVARCHAR (200), @title NVARCHAR (50)
AS
BEGIN
    DECLARE @student_email AS VARCHAR (50);
    DECLARE @student_id AS INT;
    DECLARE @tutor_id AS INT;
    DECLARE @session_id AS INT;
    SELECT @tutor_id = id_user
    FROM   User_tutorsLeb
    WHERE  email = @tutor_email;
    INSERT  INTO Session_ (start_date, end_date, title, desc_session)
    VALUES               (@start, @end, @title, @description);
    SET @session_id = SCOPE_IDENTITY();
    WHILE LEN(@student_emails) > 0
        BEGIN
            SET @student_email = LEFT(@student_emails, CHARINDEX(',', @student_emails + ', ') - 1);
            SET @student_emails = STUFF(@student_emails, 1, CHARINDEX(',', @student_emails + ', '), '');
            SELECT @student_id = id_user
            FROM   User_tutorsLeb
            WHERE  email = @student_email;
            INSERT  INTO schedule (id_tutor, id_student, id_session)
            VALUES               (@tutor_id, @student_id, @session_id);
        END
END

