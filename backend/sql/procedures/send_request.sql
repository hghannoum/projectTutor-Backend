--send request (like add friend)
create PROCEDURE SendRequest
@fromEmail NVARCHAR (50), @toId NVARCHAR (50)
AS
BEGIN
    DECLARE @fromId AS INT;
    SELECT @fromId = id_user
    FROM   User_tutorsLeb
    WHERE  email = @fromEmail;
    INSERT  INTO Request (id_student, id_tutor, approved)
    VALUES              (@fromId, @toId, 0);
END

