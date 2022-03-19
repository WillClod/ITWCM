/******************************************************************************
**	File: cmtranbatch_trgupd.sql
**	Name: cmtranbatch_trgupd
**	Desc: 
**
**              
**
**	Auth: Claudio Gomez
**	Date: 27/Dic/12
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:		Description:
**	--------	--------	---------------------------------------
**    
*******************************************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'cmtranbatch_trgupd' )
	DROP TRIGGER cmtranbatch_trgupd
GO                                                 
CREATE TRIGGER cmtranbatch_trgupd ON cmtranbatch WITH ENCRYPTION 
FOR UPDATE AS 
BEGIN
SET NOCOUNT ON
SET ROWCOUNT 0


--PRINT 'Variable declaration.'
DECLARE 
@tran_id INT,
@del_post_flag BIT,
@ins_post_flag BIT

DECLARE 
@Result INT,
@comp_id INT,
@tran_num saCNum,
@message VARCHAR(MAX)

--PRINT 'Cycle each record efected.'
SELECT @tran_id = MIN(tran_id) FROM inserted 
WHILE @tran_id IS NOT NULL
BEGIN

	--PRINT 'Get data of transaction.'
	SELECT 
	@del_post_flag = post_flag,
	@comp_id = comp_id,
	@tran_num = tran_num
	FROM deleted 
	WHERE tran_id = @tran_id 

	SELECT @ins_post_flag = post_flag
	FROM inserted 
	WHERE tran_id = @tran_id 


	--PRINT 'Exit if any transaction is posted.'
	IF (@del_post_flag = 1) AND (@ins_post_flag = 1)
	BEGIN
			SET @message = 'No se puede modificar la transacción ' + ISNULL(@tran_num, '???') + ' porque se encuentra procesada.' 
			RAISERROR (@message, 16, 1, @tran_id) --WITH LOG
			ROLLBACK TRAN
			RETURN
	END


	--PRINT 'Post transaction if set post_flag = 1.'
	IF (@del_post_flag = 0) AND (@ins_post_flag = 1)
	BEGIN
		EXEC @Result = CMTranBatchPost_sp @tran_id
		IF (@@ERROR <> 0) OR ( @Result <> 0) 
		BEGIN
			RAISERROR ('Error al crear la transacción de Bancos.', 16, 1, @tran_id) --WITH LOG
			ROLLBACK TRAN
			RETURN
		END
	END


	--PRINT 'UnPost transaction if set post_flag = 0.'		
	IF (@del_post_flag = 1) AND (@ins_post_flag = 0) AND (@tran_num IS NOT NULL)
	BEGIN
		EXEC @Result = CMTranBatchUnpost_sp @comp_id, @tran_num
		IF (@@ERROR <> 0) OR ( @Result <> 0)
		BEGIN
			SET @message = 'Error al desprocesar la transacción de Bancos: ' + @tran_num + ' .'
			RAISERROR (@message, 16, 1, @tran_id) --WITH LOG
			ROLLBACK TRAN
			RETURN
		END
	END


	--PRINT 'Get next tran id.'
	SELECT @tran_id = MIN(tran_id) FROM inserted where tran_id > @tran_id
END


SET NOCOUNT OFF
END
GO
