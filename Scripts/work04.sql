


select * from cmtranbatch where tran_desc = 'CARRIER DEC.Q2'


SELECT *
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code 
LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code 
WHERE (TR.apply_date BETWEEN @from_apply_date AND @to_apply_date) AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
ORDER BY TY.severity_class, TY.sequence, TR.apply_date


SELECT *
FROM cmtranbatch AS TR 
INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code 
LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code 
WHERE (TR.apply_date BETWEEN '2019/12/16' AND '2020/12/31') 
AND (TR.post_flag = 0) 
--AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
ORDER BY TY.severity_class, TY.sequence, TR.apply_date
