

SELECT 
'' AS tran_type,
'' AS tran_desc,
1 AS severity_class, 
0 AS sequence,
'M01D01' AS M01D01, 'M01D16' AS M01D16,
'M02D01' AS M02D01, 'M02D16' AS M02D16,
'M03D01' AS M03D01, 'M03D16' AS M03D16,
'M04D01' AS M04D01, 'M04D16' AS M04D16,
'M05D01' AS M05D01, 'M05D16' AS M05D16,
'M06D01' AS M06D01, 'M06D16' AS M06D16,
'M07D01' AS M07D01, 'M07D16' AS M07D16,
'M08D01' AS M08D01, 'M08D16' AS M08D16,
'M09D01' AS M09D01, 'M09D16' AS M09D16,
'M10D01' AS M10D01, 'M10D16' AS M10D16,
'M11D01' AS M11D01, 'M11D16' AS M11D16,
'M12D01' AS M12D01, 'M12D16' AS M12D16


---



SELECT 
TR.tran_type,
MIN(TR.tran_desc) AS tran_desc,
TY.severity_class, 
TY.sequence,
'M01D01' AS M01D01, 'M01D16' AS M01D16,
'M02D01' AS M02D01, 'M02D16' AS M02D16,
'M03D01' AS M03D01, 'M03D16' AS M03D16,
'M04D01' AS M04D01, 'M04D16' AS M04D16,
'M05D01' AS M05D01, 'M05D16' AS M05D16,
'M06D01' AS M06D01, 'M06D16' AS M06D16,
'M07D01' AS M07D01, 'M07D16' AS M07D16,
'M08D01' AS M08D01, 'M08D16' AS M08D16,
'M09D01' AS M09D01, 'M09D16' AS M09D16,
'M10D01' AS M10D01, 'M10D16' AS M10D16,
'M11D01' AS M11D01, 'M11D16' AS M11D16,
'M12D01' AS M12D01, 'M12D16' AS M12D16
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code 
LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code 
WHERE (TR.apply_date BETWEEN @from_apply_date AND @to_apply_date) 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
GROUP BY TR.tran_type, TY.severity_class, TY.sequence
ORDER BY TY.severity_class, TY.sequence, TR.tran_type


DROP TABLE #CMTranYear

SELECT 
'' AS tran_type,
'' AS tran_desc,
1 AS severity_class, 
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
INTO #CMTranYear

SELECT * FROM #CMTranYear

UPDATE #CMTranYear
SET M01D01 = COUNT(*)
FROM #CMTranYear A
INNER JOIN 

SELECT COUNT(*)
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code 
LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code 
WHERE (TR.apply_date BETWEEN '2019/01/01' AND '2019/01/15') 
AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
GROUP BY TR.tran_type, TY.severity_class, TY.sequence


EXEC CMTranBatchYearSumGet 2019, '*', 0, 100.0

/*
COUNT
START
REVENUE
EXPENSE
END
*/

select * from cmtranclass

-- 13010 +
-- 13110 -

-- CASE TY.tran_class WHEN 13110 THEN TR.tran_amt * - 1 ELSE TR.tran_amt END AS tran_amt, 

--CASE TY.tran_class WHEN 13110 THEN TR.tran_amt * - 1 ELSE TR.tran_amt END
