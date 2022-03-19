IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'CMTranBatchYearSumGet' )                     
	DROP PROC CMTranBatchYearSumGet
GO                                                
CREATE PROCEDURE CMTranBatchYearSumGet(
@year INT,
@tran_type saCode,
@post_flag saFlag,
@start_amt saAmt)
AS
BEGIN 
SET NOCOUNT ON

-- Variable declarations.
DECLARE 
	@start_day DATETIME,
	@end_day DATETIME,
	@revenue_qty INT,
	@expense_qty INT,
	@revenue_amt DECIMAL(18,2),
	@expense_amt DECIMAL(18,2),
	@end_amt saAmt

	
-- Creation temp table.
CREATE TABLE #CMTranBatchSumYear(
sum_type VARCHAR(10),
sum_desc VARCHAR(60),
severity_class SMALLINT,
sequence SMALLINT,
M01D01 DECIMAL(18,2), 
M01D16 DECIMAL(18,2),
M02D01 DECIMAL(18,2), 
M02D16 DECIMAL(18,2),
M03D01 DECIMAL(18,2), 
M03D16 DECIMAL(18,2),
M04D01 DECIMAL(18,2), 
M04D16 DECIMAL(18,2),
M05D01 DECIMAL(18,2), 
M05D16 DECIMAL(18,2),
M06D01 DECIMAL(18,2), 
M06D16 DECIMAL(18,2),
M07D01 DECIMAL(18,2), 
M07D16 DECIMAL(18,2),
M08D01 DECIMAL(18,2), 
M08D16 DECIMAL(18,2),
M09D01 DECIMAL(18,2), 
M09D16 DECIMAL(18,2),
M10D01 DECIMAL(18,2), 
M10D16 DECIMAL(18,2),
M11D01 DECIMAL(18,2), 
M11D16 DECIMAL(18,2),
M12D01 DECIMAL(18,2), 
M12D16 DECIMAL(18,2)
)

-- Insert base records.
INSERT #CMTranBatchSumYear
SELECT 
'COUNT' AS sum_type,
'CONTIDAD' AS sum_desc,
0 AS severity_class, 
0 AS sequence,
0 AS M01D01, 0 AS M01D16,
0 AS M02D01, 0 AS M02D16,
0 AS M03D01, 0 AS M03D16,
0 AS M04D01, 0 AS M04D16,
0 AS M05D01, 0 AS M05D16,
0 AS M06D01, 0 AS M06D16,
0 AS M07D01, 0 AS M07D16,
0 AS M08D01, 0 AS M08D16,
0 AS M09D01, 0 AS M09D16,
0 AS M10D01, 0 AS M10D16,
0 AS M11D01, 0 AS M11D16,
0 AS M12D01, 0 AS M12D16


INSERT #CMTranBatchSumYear
SELECT 
'START' AS sum_type,
'SALDO INICIAL' AS sum_desc,
0 AS severity_class,  
1 AS sequence,
M01D01, M01D16,
M02D01, M02D16,
M03D01, M03D16,
M04D01, M04D16,
M05D01, M05D16,
M06D01, M06D16,
M07D01, M07D16,
M08D01, M08D16,
M09D01, M09D16,
M10D01, M10D16,
M11D01, M11D16,
M12D01, M12D16
FROM #CMTranBatchSumYear WHERE sum_type = 'COUNT'



INSERT #CMTranBatchSumYear
SELECT 
'REVENUE' AS sum_type,
'INGRESOS' AS sum_desc,
0 AS severity_class,  
2 AS sequence,
M01D01, M01D16,
M02D01, M02D16,
M03D01, M03D16,
M04D01, M04D16,
M05D01, M05D16,
M06D01, M06D16,
M07D01, M07D16,
M08D01, M08D16,
M09D01, M09D16,
M10D01, M10D16,
M11D01, M11D16,
M12D01, M12D16
FROM #CMTranBatchSumYear WHERE sum_type = 'COUNT'


INSERT #CMTranBatchSumYear
SELECT 
'EXPENSE' AS sum_type,
'EGRESOS' AS sum_desc,
0 AS severity_class,  
3 AS sequence,
M01D01, M01D16,
M02D01, M02D16,
M03D01, M03D16,
M04D01, M04D16,
M05D01, M05D16,
M06D01, M06D16,
M07D01, M07D16,
M08D01, M08D16,
M09D01, M09D16,
M10D01, M10D16,
M11D01, M11D16,
M12D01, M12D16
FROM #CMTranBatchSumYear WHERE sum_type = 'COUNT'


INSERT #CMTranBatchSumYear
SELECT 
'END' AS sum_type,
'SALDO FINAL' AS sum_desc,
severity_class, 
4 AS sequence,
M01D01, M01D16,
M02D01, M02D16,
M03D01, M03D16,
M04D01, M04D16,
M05D01, M05D16,
M06D01, M06D16,
M07D01, M07D16,
M08D01, M08D16,
M09D01, M09D16,
M10D01, M10D16,
M11D01, M11D16,
M12D01, M12D16
FROM #CMTranBatchSumYear WHERE sum_type = 'COUNT'


-- JANAURY.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/01/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/01/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 

UPDATE #CMTranBatchSumYear
SET M01D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M01D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M01D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M01D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M01D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


--

SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/02/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M01D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M01D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M01D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M01D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M01D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt




-- FEBBRUARY. 
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/02/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/02/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 

UPDATE #CMTranBatchSumYear
SET M02D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M02D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M02D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M02D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M02D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt

SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/03/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 

UPDATE #CMTranBatchSumYear
SET M02D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M02D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M02D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M02D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M02D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt

-- MARCH.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/03/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/03/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M03D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M03D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M03D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M03D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M03D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt

SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/04/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M03D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M03D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M03D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M03D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M03D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt

-- APRIL.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/04/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/04/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M04D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M04D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M04D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M04D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M04D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/05/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M04D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M04D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M04D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M04D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M04D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt

-- MAY.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/05/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/05/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 

UPDATE #CMTranBatchSumYear
SET M05D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M05D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M05D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M05D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M05D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/06/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M05D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M05D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M05D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M05D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M05D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


-- JUN.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/06/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/06/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M06D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M06D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M06D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M06D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M06D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/07/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 

UPDATE #CMTranBatchSumYear
SET M06D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M06D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M06D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M06D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M06D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt

-- JUL.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/07/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/07/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M07D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M07D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M07D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M07D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M07D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/08/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M07D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M07D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M07D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M07D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M07D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt

-- AGO.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/08/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/08/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M08D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M08D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M08D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M08D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M08D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/09/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M08D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M08D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M08D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M08D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M08D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


-- SEP.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/09/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/09/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M09D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M09D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M09D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M09D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M09D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/10/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M09D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M09D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M09D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M09D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M09D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


-- OCT.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/10/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/10/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M10D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M10D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M10D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M10D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M10D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/11/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M10D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M10D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M10D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M10D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M10D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


-- NOV.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/11/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/11/15')

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M11D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M11D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M11D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M11D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M11D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/12/01')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M11D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M11D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M11D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M11D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M11D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


-- DIC.
SET @start_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/12/01')
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year) + '/12/15')


SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M12D01 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M12D01 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M12D01 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M12D01 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M12D01 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


SET @start_day = DATEADD(DAY, 1, @end_day)
SET @end_day = CONVERT(DATETIME, CONVERT(VARCHAR, @year + 1) + '/12/31')
SET @end_day = DATEADD(DAY, -1, @end_day)

SELECT @revenue_amt = SUM(TR.tran_amt), @revenue_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13010 

SELECT @expense_amt = SUM(TR.tran_amt * - 1), @expense_qty = COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
WHERE (TR.apply_date BETWEEN @start_day AND @end_day) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
AND TY.tran_class = 13110 


UPDATE #CMTranBatchSumYear
SET M12D16 = @revenue_qty + @expense_qty
WHERE sum_type = 'COUNT'

UPDATE #CMTranBatchSumYear
SET M12D16 = @start_amt
WHERE sum_type = 'START'

UPDATE #CMTranBatchSumYear
SET M12D16 = ISNULL(@revenue_amt, 0)
WHERE sum_type = 'REVENUE'

UPDATE #CMTranBatchSumYear
SET M12D16 = ISNULL(@expense_amt, 0)
WHERE sum_type = 'EXPENSE'

SET @end_amt =  @start_amt + ISNULL(@revenue_amt, 0) + ISNULL(@expense_amt, 0)
UPDATE #CMTranBatchSumYear
SET M12D16 = @end_amt
WHERE sum_type = 'END'
SET @start_amt = @end_amt


-- Return data.
SELECT * FROM #CMTranBatchSumYear


SET NOCOUNT OFF
END