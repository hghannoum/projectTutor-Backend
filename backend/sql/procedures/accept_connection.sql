
--procedure for tutor accepting connection from a student
create PROCEDURE [dbo].[acceptConnection]
@id_request INT
AS
BEGIN
    UPDATE Request
    SET    approved = 1
    WHERE  Request.id_request = @id_request;
END

