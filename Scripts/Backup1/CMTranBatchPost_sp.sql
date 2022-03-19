IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'CMTranBatchPost_sp' )                     
	DROP PROC CMTranBatchPost_sp
GO                                                
CREATE PROCEDURE CMTranBatchPost_sp(
@tran_id INT)  
AS
BEGIN 
SET NOCOUNT ON

-- Variable declaration.
DECLARE 
@comp_id	INT,
@tran_class	INT,
@tran_type  saCode,
@acct_code	saAcct,
@trsf_tran_type	saCode,
@trsf_acct_code	saAcct,
@sign		INT


-- Exist tran validation.
/*
IF (SELECT COUNT(*) FROM cmtranbatch WHERE tran_id = @tran_id) = 0
	RETURN 10
*/

-- Post tran validation.
/*
IF (SELECT COUNT(*) FROM cmtranbatch WHERE tran_id = @tran_id AND post_flag = 1) >= 1
	RETURN 20
*/

-- Get transaction data.
SELECT 
@comp_id = comp_id,
@tran_class = tran_class,
@tran_type = tran_type,
@trsf_tran_type = trsf_tran_type
FROM cmtranbatch
WHERE tran_id = @tran_id

IF @tran_class = 13010 -- Revenue
	SET @sign = 1
ELSE -- Expense or Transfer
	SET @sign = -1


-- Begin tran
BEGIN TRAN

-- Get next CM transaction.
DECLARE @next_tn saCnum, @result saSnum
EXEC @result = cmnexttran_sp @comp_id, 13910, @next_tn OUTPUT

--select result = @result, next_tran_num = @next_tn

-- Insert CM Header.
INSERT cmtranhd(
comp_id,			tran_num,	tran_desc,	hold_flag,	hold_reason,
auto_recon_flag,	entry_date,	apply_date,	post_date,	post_flag,
dist_class,			user_id,	gl_tran_num)
SELECT 
@comp_id,			@next_tn,	tran_desc,	0,			NULL,
0,					GETDATE(),	doc_date,	NULL,		0,
0,					user_id,	NULL
FROM cmtranbatch
WHERE tran_id = @tran_id
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 30
END


-- Get acct code.
SELECT @acct_code = acct_code 
FROM cmtrantype
WHERE tran_type = @tran_type

IF @trsf_tran_type IS NOT NULL
	SELECT @trsf_acct_code = acct_code 
	FROM cmtrantype
	WHERE tran_type = @trsf_tran_type


-- Insert CM Detail.
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
	RETURN 40
END


IF @tran_class = 13210 -- Transfer
BEGIN
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
		RETURN 50
	END
END

-- Post CM Transaction.
UPDATE cmtranhd
SET post_flag = 1
WHERE comp_id = @comp_id
AND tran_num = @next_tn
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 60
END

-- Set Transaction Batch as posted.
UPDATE cmtranbatch SET 
post_flag = 1,
post_date = GETDATE(),
tran_num = @next_tn
WHERE tran_id = @tran_id
IF @@ERROR <> 0 
BEGIN
	ROLLBACK TRAN
	RETURN 70
END

-- Commit tran
COMMIT TRAN

                                             
SET NOCOUNT OFF
END