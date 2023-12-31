--procedure for checking if email already registred while signing up
ALTER PROCEDURE [dbo].[CheckEmailAvailability]
@email NVARCHAR (50), @is_available BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1
               FROM   [User_tutorsLeb]
               WHERE  email = @email)
        SET @is_available = 0;
    ELSE
        SET @is_available = 1;
END

