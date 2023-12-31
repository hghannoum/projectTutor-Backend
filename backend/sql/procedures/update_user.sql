--update user personnal details
ALTER PROCEDURE UpdateUserTutorLeb
@email NVARCHAR (50), @username NVARCHAR (50), @category NVARCHAR (50), @city NVARCHAR (50), @img NVARCHAR (255), @bio NVARCHAR (MAX)
AS
BEGIN
    DECLARE @id_city AS INT;
    SELECT @id_city = id_city
    FROM   vw_city
    WHERE  name = @city;
    IF @id_city IS NULL
        BEGIN
            INSERT  INTO City (name)
            VALUES           (@city);
            SET @id_city = SCOPE_IDENTITY();
        END
    UPDATE User_tutorsLeb
    SET    username = @username,
           category = @category,
           id_city  = @id_city,
           img      = @img,
           bio      = @bio
    WHERE  email = @email;
END

