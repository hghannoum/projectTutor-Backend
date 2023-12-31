--procedure for delete request in the explorer
create PROCEDURE deleteRequest
@fromEmail NVARCHAR (50), @toId NVARCHAR (50)
AS
BEGIN
    DECLARE @fromId AS INT;
    SELECT @fromId = id_user
    FROM   User_tutorsLeb
    WHERE  email = @fromEmail;
    DELETE Request
    WHERE  id_student = @fromId
           AND id_tutor = @toId;
END

