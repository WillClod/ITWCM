/******************************************************************************
**	File: cmtranbatch_trgins.sql
**	Name: cmtranbatch_trgins
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
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'cmtranbatch_trgins' )
	DROP TRIGGER cmtranbatch_trgins
GO                                                 
CREATE TRIGGER cmtranbatch_trgins ON cmtranbatch WITH ENCRYPTION 
FOR INSERT AS 
BEGIN
SET NOCOUNT ON
SET ROWCOUNT 0


-- Variable declaration.
DECLARE 
@tran_id INT,
@del_post_flag BIT,
@ins_post_flag BIT

DECLARE @Result INT

-- Cycle each record efacted. 
SELECT @tran_id = MIN(tran_id) FROM inserted 
WHILE @tran_id IS NOT NULL
BEGIN

	-- Post transaction.
	/*		
	EXEC @Result = CMTranBatchPost_sp @tran_id
	IF @Result <> 0 
	BEGIN
		RAISERROR ('Error al crear la transaccion de Bancos.', 16, 1, @tran_id) WITH LOG
		ROLLBACK TRAN
		RETURN
	END
	*/
	UPDATE cmtranbatch SET post_flag = 1 where tran_id = @tran_id
	IF @Result <> 0 
	BEGIN
		RAISERROR ('Error al procesar para crear la transaccion de Bancos.', 16, 1, @tran_id) WITH LOG
		ROLLBACK TRAN
		RETURN
	END

	-- Get next tran id
	SELECT @tran_id = MIN(tran_id) FROM inserted where tran_id > @tran_id
END


SET NOCOUNT OFF
END
GO
