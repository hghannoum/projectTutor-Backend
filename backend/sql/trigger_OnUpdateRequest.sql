/*trigger to take the id of tutor and student and add to their calendar a new meeting 
after two days from the accept connection(update request table column approved) */

CREATE TRIGGER meet_onAccept  
ON request     
FOR UPDATE      
AS IF UPDATE (approved)       
DECLARE @st AS INT, @t AS INT;        
SELECT @st = id_student,              
@t = id_tutor    
FROM   inserted               
INNER JOIN               
User_tutorsLeb AS u          
ON u.id_user = id_student               
INNER JOIN             
id_email AS vw             
ON vw.id = id_tutor;      
DECLARE @session_id AS INT;    
DECLARE @date AS DATE = GETDATE();      
DECLARE @datetime AS DATETIME = CAST (@date AS DATETIME);
DECLARE @start_datetime AS DATETIME = DATEADD(hour, 16, DATEADD(day, 2, @datetime));    
DECLARE @end_datetime AS DATETIME = DATEADD(hour, 18, DATEADD(day, 2, @datetime));      
INSERT  INTO Session_ (start_date, end_date, title, desc_session)     
VALUES             
(@start_datetime, @end_datetime, 'first meeting', 'meet each other for the first time');   
SET @session_id = SCOPE_IDENTITY();    
INSERT 
INTO 
schedule (id_tutor, id_student, id_session)   
VALUES            
(@t, @st, @session_id);    