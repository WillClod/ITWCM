

SELECT TR.tran_id, TR.comp_id, TR.tran_num, TR.tran_desc, TR.entry_date, TR.doc_date, TR.post_date, TR.post_flag, TR.user_id, 
CASE WHEN TR.tran_class <> 13210 THEN TR.tran_type ELSE TR.tran_type + '-' + TR.trsf_tran_type END AS tran_type, TY.tran_type_desc, TR.cash_acct_code, C.cash_acct_desc, 
CASE WHEN TR.tran_class <> 13210 THEN SUBSTRING(C.cash_acct_desc , 1 , 4) ELSE SUBSTRING(C.cash_acct_desc , 1 , 4) + '-' + SUBSTRING(CT.cash_acct_desc , 1 , 4) END AS cash_acct_descr, 
CASE TY.tran_class WHEN 13110 THEN TR.tran_amt * - 1 ELSE TR.tran_amt END AS tran_amt, TR.tran_class, TR.apply_date, TY.severity_class, TR.star_flag, TR.hold_reason 
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code 
LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code 
WHERE  (TR.apply_date BETWEEN '2019/01/01' AND '2019/01/01')
AND post_flag = 0
--WHERE (TR.apply_date BETWEEN @from_apply_date AND @to_apply_date) 
--AND (TR.post_flag = @post_flag) 
--AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
ORDER BY TY.severity_class, TY.sequence, TR.apply_date


SELECT 
TR.tran_type,
MIN(TR.tran_desc) AS tran_desc,
TY.severity_class, 
TY.sequence,
'M01Q1' AS M01Q1, 'M01Q2' AS M01Q2,
'M02Q1' AS M02Q1, 'M02Q2' AS M02Q2,
'M03Q1' AS M03Q1, 'M03Q2' AS M03Q2,
'M04Q1' AS M04Q1, 'M04Q2' AS M04Q2,
'M05Q1' AS M05Q1, 'M05Q2' AS M05Q2,
'M06Q1' AS M06Q1, 'M06Q2' AS M06Q2,
'M07Q1' AS M07Q1, 'M07Q2' AS M07Q2,
'M08Q1' AS M08Q1, 'M08Q2' AS M08Q2,
'M09Q1' AS M09Q1, 'M09Q2' AS M09Q2,
'M10Q1' AS M10Q1, 'M10Q2' AS M10Q2,
'M11Q1' AS M11Q1, 'M11Q2' AS M11Q2,
'M12Q1' AS M12Q1, 'M12Q2' AS M12Q2
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code 
LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code 
WHERE  (TR.apply_date BETWEEN '2019/01/01' AND '2019/12/01')
AND post_flag = 0
--WHERE (TR.apply_date BETWEEN @from_apply_date AND @to_apply_date) 
--AND (TR.post_flag = @post_flag) 
--AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
GROUP BY TR.tran_type, TY.severity_class, TY.sequence
ORDER BY TY.severity_class, TY.sequence


select * from cmtranbatch

