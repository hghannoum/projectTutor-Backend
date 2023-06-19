
create VIEW id_email (
    id,
    email,
    name
)
AS
SELECT id_user,
       email,
       username
FROM   user_tutorsleb;

GO


