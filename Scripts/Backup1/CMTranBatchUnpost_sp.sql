IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'CMTranBatchUnpost_sp' )                     
	DROP PROC CMTranBatchUnpost_sp
GO                                                
CREATE PROCEDURE CMTranBatchUnpost_sp(
--@tran_id INT)  
@comp_id INT,
@tran_num saCNum)
AS
BEGIN 
SET NOCOUNT ON

-- Variable declaration.
/*
DECLARE 
@comp_id	INT,
@tran_num	saCNum
*/

-- Exist tran validation.
/*
IF (SELECT COUNT(*) FROM cmtranbatch WHERE tran_id = @tran_id) = 0
	RETURN 10
*/

-- Unpost tran validation.
/*
IF (SELECT COUNT(*) FROM cmtranbatch WHERE tran_id = @tran_id AND post_flag = 0) >= 1
	RETURN 20
*/

-- Get transaction data.
/*
SELECT 
@comp_id = comp_id,
@tran_num = tran_num
FROM cmtranbatch
WHERE tran_id = @tran_id
*/


-- Begin tran
BEGIN TRAN

-- Unpost CM Transaction.
UPDATE cmtranhd
SET post_flag = 0
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 30
END


-- Delete CM Detail.
DELETE cmtrandt
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 40
END

-- Delete CM Header.
DELETE cmtranhd
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 50
END



-- Set Transaction Batch as unposted.
UPDATE cmtranbatch SET 
post_flag = 0,
post_date = NULL,
tran_num = NULL
--WHERE tran_id = @tran_id
WHERE comp_id = @comp_id
AND tran_num = @tran_num
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 60
END


-- Commit tran
COMMIT TRAN

                                             
SET NOCOUNT OFF
END