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


-- Variable declaration.
DECLARE 
@tran_id INT,
@del_post_flag BIT,
@ins_post_flag BIT

DECLARE 
@Result INT,
@comp_id INT,
@tran_num saCNum

-- Cycle each record efacted. 
SELECT @tran_id = MIN(tran_id) FROM inserted 
WHILE @tran_id IS NOT NULL
BEGIN

	-- Get data of transaction.
	SELECT 
	@del_post_flag = post_flag,
	@comp_id = comp_id,
	@tran_num = tran_num
	FROM deleted 
	WHERE tran_id = @tran_id 

	SELECT @ins_post_flag = post_flag
	FROM inserted 
	WHERE tran_id = @tran_id 


	-- Unpost CM transaction.
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


	-- Post transaction.		
	EXEC @Result = CMTranBatchPost_sp @tran_id
	IF @Result <> 0 
	BEGIN
		RAISERROR ('Error al crear la transaccion de Bancos.', 16, 1, @tran_id) WITH LOG
		ROLLBACK TRAN
		RETURN
	END


	-- Get next tran id
	SELECT @tran_id = MIN(tran_id) FROM inserted where tran_id > @tran_id
END


SET NOCOUNT OFF
END
GO
