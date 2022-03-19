/******************************************************************************
**	File: cmtranbatch_trgdel.sql
**	Name: cmtranbatch_trgdel
**	Desc: 
**
**              
**
**	Auth: David Galván Leal
**	Date: 03/Jul/01
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:		Description:
**	--------	--------	---------------------------------------
**    
*******************************************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'cmtranbatch_trgdel' )
	DROP TRIGGER cmtranbatch_trgdel
GO                                                 
CREATE TRIGGER cmtranbatch_trgdel ON cmtranbatch WITH ENCRYPTION 
FOR DELETE AS 
BEGIN
SET NOCOUNT ON
SET ROWCOUNT 0


-- Variable declaration.
DECLARE 
@tran_id INT,
@del_post_flag BIT,
@ins_post_flag BIT

DECLARE 
@Result INT,
@comp_id INT,
@tran_num saCNum,
@message VARCHAR(MAX)

-- Cycle each record efacted. 
SELECT @tran_id = MIN(tran_id) FROM deleted 
WHILE @tran_id IS NOT NULL
BEGIN

	-- Get data of transaction.
	SELECT 
	@comp_id = comp_id,
	@tran_num = tran_num,
	@del_post_flag = post_flag 
	FROM deleted 
	WHERE tran_id = @tran_id 

	-- Exit if any transaction is posted.
	IF @del_post_flag = 1 
	BEGIN
			SET @message = 'No se puede eliminar la transaccion ' + @tran_num + ' porque se encuentra procesada.' 
			RAISERROR (@message, 16, 1, @tran_id) --WITH LOG
			ROLLBACK TRAN
			RETURN
	END

	-- Unpost transaction.
	/*
	IF @tran_num IS NOT NULL
	BEGIN	
		EXEC @Result = CMTranBatchUnpost_sp @comp_id, @tran_num
		IF @Result <> 0 
		BEGIN
			RAISERROR ('Error al eliminar la transaccion de Bancos.', 16, 1, @tran_id) WITH LOG
			ROLLBACK TRAN
			RETURN
		END
	END
	*/


	-- Get next tran id
	SELECT @tran_id = MIN(tran_id) FROM deleted where tran_id > @tran_id
END


SET NOCOUNT OFF
END
GO
