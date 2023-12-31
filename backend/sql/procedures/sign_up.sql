--sign up procedure
create PROCEDURE SignUpUser
@username NVARCHAR (50), @fullname NVARCHAR (100), @first_name NVARCHAR (20), @last_name NVARCHAR (20), @category NVARCHAR (50), @material NVARCHAR (50), @city NVARCHAR (50), @password NVARCHAR (50), @img NVARCHAR (200), @email NVARCHAR (50), @bio NVARCHAR (200), @is_tutor BIT, @way NVARCHAR (50), @subject NVARCHAR (50)
AS
BEGIN
    DECLARE @city_id AS INT;
    DECLARE @subject_id AS INT;
    DECLARE @role_id AS INT;
    DECLARE @user_id AS INT;
    IF EXISTS (SELECT 1
               FROM   City
               WHERE  name = @city)
        SELECT @city_id = id_city
        FROM   City
        WHERE  name = @city;
    ELSE
        BEGIN
            INSERT  INTO City (name)
            VALUES           (@city);
            SET @city_id = SCOPE_IDENTITY();
        END
    IF EXISTS (SELECT 1
               FROM   Subject_
               WHERE  REPLACE(name_subject, ' ', '') = REPLACE(@subject, ' ', ''))
        SELECT @subject_id = id_subject
        FROM   Subject_
        WHERE  REPLACE(name_subject, ' ', '') = REPLACE(@subject, ' ', '');
    ELSE
        BEGIN
            INSERT  INTO Subject_ (name_subject)
            VALUES               (@subject);
            SET @subject_id = SCOPE_IDENTITY();
        END
    SELECT @role_id = CASE WHEN @is_tutor = 1 THEN 2 ELSE 1 END
    FROM   UserRole;
    INSERT  INTO [User_tutorsLeb] (username, first_name, last_name, category, id_city, pass, img, email, bio, id_role, way)
    VALUES                       (@username, @first_name, @last_name, @category, @city_id, @password, @img, @email, @bio, @role_id, @way);
    SET @user_id = SCOPE_IDENTITY();
    IF @is_tutor = 1
        BEGIN
            INSERT  INTO Tutor (id_user, id_tutor)
            VALUES            (@user_id, @user_id);
            INSERT  INTO TutorSubject (id_tutor, id_subject)
            VALUES                   (@user_id, @subject_id);
        END
    ELSE
        BEGIN
            INSERT  INTO Student (id_user, id_student)
            VALUES              (@user_id, @user_id);
        END
END

