IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'CMTranBatchUnpost_sp' )                     
	DROP PROC CMTranBatchUnpost_sp
GO                                                
CREATE PROCEDURE CMTranBatchUnpost_sp(
@comp_id INT,
@tran_num saCNum)
AS
BEGIN 
SET NOCOUNT ON


--PRINT 'Exist tran validation.'
IF (SELECT COUNT(*) FROM cmtranbatch WHERE comp_id = @comp_id AND tran_num = @tran_num) = 0
BEGIN
	RAISERROR ('La transacción NO existe.', 16, 1) --WITH LOG
	RETURN 10
END



--PRINT 'Unpost tran validation.'
/*
IF (SELECT COUNT(*) FROM cmtranbatch WHERE comp_id = @comp_id AND tran_num = @tran_num AND post_flag = 0) >= 1
BEGIN
	RAISERROR ('La transacción NO se encuentra procesada.', 16, 1) --WITH LOG
	RETURN 20
END
*/


--PRINT 'Begin tran.'
BEGIN TRAN


--PRINT 'Unpost CM Transaction.'
UPDATE cmtranhd
SET post_flag = 0
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 30
END


--PRINT 'Delete CM Detail.'
DELETE cmtrandt
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 40
END

--PRINT 'Delete CM Header.'
DELETE cmtranhd
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 50
END



--PRINT 'Set Transaction Batch as unposted.'
UPDATE cmtranbatch SET 
post_flag = 0,
post_date = NULL,
tran_num = NULL
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 60
END


--PRINT 'Commit tran.'
COMMIT TRAN

              
--PRINT 'Return Process OK result.'
RETURN 0
			  

SET NOCOUNT OFF
END