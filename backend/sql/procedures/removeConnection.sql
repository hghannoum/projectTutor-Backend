--remove  connection in the request page
create PROCEDURE removeConnection
@id_request INT
AS
BEGIN
    DELETE Request
    WHERE  Request.id_request = @id_request;
END

