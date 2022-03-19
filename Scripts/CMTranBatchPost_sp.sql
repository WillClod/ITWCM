IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'CMTranBatchPost_sp' )                     
	DROP PROC CMTranBatchPost_sp
GO                                                
CREATE PROCEDURE CMTranBatchPost_sp(
@tran_id INT)  
AS
BEGIN 
SET NOCOUNT ON


--PRINT 'Variable declaration.'
DECLARE 
@comp_id	INT,
@tran_class	INT,
@tran_type  saCode,
@acct_code	saAcct,
@trsf_tran_type	saCode,
@trsf_acct_code	saAcct,
@sign		INT,
@post_flag  INT,
@apply_date	saDate


--PRINT 'Exist tran validation.'
IF (SELECT COUNT(*) FROM cmtranbatch WHERE tran_id = @tran_id) = 0
BEGIN
	RAISERROR ('La transacción no existe.', 16, 1) --WITH LOG
	RETURN 10
END


--PRINT 'Get transaction data.'
SELECT 
@comp_id = comp_id,
@tran_class = tran_class,
@tran_type = tran_type,
@trsf_tran_type = trsf_tran_type,
@post_flag = post_flag,
@apply_date = apply_date
FROM cmtranbatch
WHERE tran_id = @tran_id


--PRINT 'Post tran validation.'
/*
IF @post_flag = 1 
BEGIN
	RAISERROR ('La transacción ya se encuentra procesada.', 16, 1, @tran_id) --WITH LOG
	RETURN 20
END
*/


--PRINT 'Null Apply Date validation.'
IF @apply_date IS NULL
BEGIN
	RAISERROR ('La fecha de aplicacion no puede ser nula.', 16, 1, @tran_id) --WITH LOG
	RETURN 30
END


--PRINT 'Set value.'
IF @tran_class = 13010 -- Revenue
	SET @sign = 1
ELSE -- Expense or Transfer
	SET @sign = -1


--PRINT 'Begin transaction.'
BEGIN TRAN


--PRINT 'Get next CM transaction.'
DECLARE @next_tn saCnum, @result saSnum
EXEC @result = cmnexttran_sp @comp_id, 13910, @next_tn OUTPUT
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 40
END


--PRINT 'Insert CM Header.'
INSERT cmtranhd(
comp_id,			tran_num,	tran_desc,		hold_flag,	hold_reason,
auto_recon_flag,	entry_date,	apply_date,		post_date,	post_flag,
dist_class,			user_id,	gl_tran_num)
SELECT 
@comp_id,			@next_tn,	tran_desc,		hold_flag,	hold_reason,
0,					GETDATE(),	@apply_date,	NULL,		0,
0,					user_id,	NULL
FROM cmtranbatch
WHERE tran_id = @tran_id
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 50
END


--PRINT 'Get acct code.'
SELECT @acct_code = acct_code 
FROM cmtrantype
WHERE tran_type = @tran_type

IF @trsf_tran_type IS NOT NULL
	SELECT @trsf_acct_code = acct_code 
	FROM cmtrantype
	WHERE tran_type = @trsf_tran_type


--PRINT 'Insert CM Detail.'
INSERT cmtrandt(
comp_id,			tran_num,	line_id,	tran_type,		cash_acct_code,
acct_code,			ref_code,	doc_num,	doc_date,		sign,
tran_amt,			home_amt,	oper_amt,	home_rate_type,	oper_rate_type,
home_rate,			oper_rate,	cur_code)
SELECT
@comp_id,			@next_tn,	1,			tran_type,		cash_acct_code,
@acct_code,			NULL,		0,			doc_date,		@sign,
tran_amt,			tran_amt,	tran_amt,	'COMPRA',		'COMPRA',
1,					1,			'MXP'
FROM cmtranbatch
WHERE tran_id = @tran_id
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 60
END


IF @tran_class = 13210 -- Transfer
BEGIN
	--PRINT 'Insert CM Detail Transfer.'
	INSERT cmtrandt(
	comp_id,			tran_num,	line_id,	tran_type,		cash_acct_code,
	acct_code,			ref_code,	doc_num,	doc_date,		sign,
	tran_amt,			home_amt,	oper_amt,	home_rate_type,	oper_rate_type,
	home_rate,			oper_rate,	cur_code)
	SELECT
	@comp_id,			@next_tn,	2,			trsf_tran_type,	trsf_cash_acct_code,
	@trsf_acct_code,	NULL,		0,			doc_date,		1,
	tran_amt,			tran_amt,	tran_amt,	'COMPRA',		'COMPRA',
	1,					1,			'MXP'
	FROM cmtranbatch
	WHERE tran_id = @tran_id
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN 70
	END
END


--PRINT 'Post CM Transaction.'
UPDATE cmtranhd
SET post_flag = 1
WHERE comp_id = @comp_id
AND tran_num = @next_tn
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 80
END


--PRINT 'Set Transaction Batch as posted.'
UPDATE cmtranbatch SET 
post_flag = 1,
post_date = GETDATE(),
tran_num = @next_tn
WHERE tran_id = @tran_id
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 90
END


--PRINT 'Commit tran.'
COMMIT TRAN


--PRINT 'Return Process OK result.'
RETURN 0

                                             
SET NOCOUNT OFF
END