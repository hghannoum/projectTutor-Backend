--view for multiple use of city table
ALTER VIEW [dbo].[vw_city]
AS
SELECT id_city,
       name
FROM   City;

GO


