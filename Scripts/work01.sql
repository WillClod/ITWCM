

select * from cmtranhd
SELECT max(tran_num) FROM cmtranhd; -- BA003712

select * from cmtranhd where tran_num = 'BA003709'
select * from cmtranhd where tran_desc like '%PRUEBA%'

UPDATE cmtranhd
SET post_flag = 0
WHERE comp_id = 1 
AND tran_num tran_num = 'BA003709'

sp_help cmtranbatch

select * from cmtranbatch where tran_desc like '%PRUEBA%'

select max(tran_id) from cmtranbatch -- 3162



/*
INSERT cmtranhd( tran_num,  tran_desc,                        apply_date,   comp_id, hold_flag, hold_reason, auto_recon_flag, entry_date, post_date, post_flag, dist_class, user_id, gl_tran_num)
VALUES(         'BA003567', 'Sueldo Carrier 1a Quincena DIC', '2019/12/15', 1,       0,         '',          0,               GETDATE(),  NULL,      0,         0,          1,       NULL);
INSERT cmtrandt( tran_num,	tran_type, doc_num, cash_acct_code,  acct_code,	  doc_date,     tran_amt,  home_amt, oper_amt, comp_id, line_id,    ref_code,  			sign,  home_rate_type, oper_rate_type, home_rate, oper_rate, cur_code)
VALUES(         'BA003567', 'CARRIER', '0',    '110207000',     '410201000', '2019/12/15',  21500,	   21500,	 21500,    1,	    1,  		 NULL,	  			-1, 	   'COMPRA',       'COMPRA',       1,	      1,		'MXP');
*/

iINSERT cmtranbatch (comp_id,	tran_desc,	entry_date,		apply_date,		doc_date,		post_flag, user_id, tran_type, cash_acct_code,  tran_amt,	tran_class, trsf_tran_type, trsf_cash_acct_code)
VALUES				(1,			'PRUEBA4',	GETDATE(),		NULL,	'2019/10/19',   0,		   1,		'CARRIER', '110207000',		100,		13010,		NULL,			NULL);
SELECT * FROM cmtranbatch WHERE tran_id = @@IDENTITY; -- 3163

UPDATE cmtranbatch SET
tran_desc = 'PRUEBA6',
--doc_date = '2019/10/18',
post_flag = 0
WHERE tran_id = 3164

rollback tran

dDELETE cmtranbatch 
WHERE tran_id = 3164

ddelete cmtranbatch where tran_num = 'BA003712'

SELECT * FROM cmtranhd WHERE tran_num BETWEEN 'BA003712' AND 'BA003712';
SELECT * FROM cmtrandt WHERE tran_num BETWEEN 'BA003712' AND 'BA003712';


--


select * from glperiod where fyear_id = 2019

select * from glconfig

select * from cmconfig

select * from soordhd

select * from sopriority 

select * from arconfig

--


select * from cmtranbatch where post_flag = 0
--delete cmtranbatch where post_flag = 0
ddelete cmtranbatch where tran_id = 3164


iINSERT cmtranbatch (comp_id,	tran_desc,		entry_date,		apply_date,		doc_date,		post_flag,  user_id, tran_type,		cash_acct_code,		tran_amt,	tran_class,		trsf_tran_type, trsf_cash_acct_code)
SELECT				1,			H.tran_desc,	H.entry_date,	H.apply_date,   D.doc_date,		0,			1,		 D.tran_type,	D.cash_acct_code,	D.tran_amt,	T.tran_class,	NULL,			NULL 					
--SELECT H.post_flag, H.hold_flag, H.tran_num, H.tran_desc, H.apply_date, D.doc_date, D.line_id, D.tran_type, T.tran_type_desc, D.cash_acct_code, D.acct_code, D.tran_amt * D.sign
FROM cmtranhd H
LEFT JOIN cmtrandt D ON H.comp_id = D.comp_id AND H.tran_num = D.tran_num  
LEFT JOIN cmtrantype T ON D.comp_id = T.comp_id AND D.tran_type = T.tran_type
WHERE 1 = 1 
AND H.post_flag = 0
ORDER BY H.apply_date;


dDELETE D
FROM cmtranhd H
LEFT JOIN cmtrandt D ON H.comp_id = D.comp_id AND H.tran_num = D.tran_num  
LEFT JOIN cmtrantype T ON D.comp_id = T.comp_id AND D.tran_type = T.tran_type
WHERE 1 = 1 
AND H.post_flag = 0

dDELETE H
FROM cmtranhd H
LEFT JOIN cmtrandt D ON H.comp_id = D.comp_id AND H.tran_num = D.tran_num  
LEFT JOIN cmtrantype T ON D.comp_id = T.comp_id AND D.tran_type = T.tran_type
WHERE 1 = 1 
AND H.post_flag = 0


--- Posted.

select * from cmtranbatch where post_flag = 0

xINSERT cmtranbatch (comp_id,	tran_num,		tran_desc,		entry_date,		apply_date,		doc_date,		post_flag,  user_id, tran_type,		cash_acct_code,		tran_amt,	tran_class,		trsf_tran_type, trsf_cash_acct_code)
SELECT				1,			H.tran_num, H.tran_desc,	H.entry_date,	H.apply_date,   D.doc_date,		0,			1,		 D.tran_type,	D.cash_acct_code,	D.tran_amt,	T.tran_class,	NULL,			NULL 					
--SELECT H.post_flag, H.hold_flag, H.tran_num, H.tran_desc, H.apply_date, D.doc_date, D.line_id, D.tran_type, T.tran_type_desc, D.cash_acct_code, D.acct_code, D.tran_amt * D.sign
FROM cmtranhd H
LEFT JOIN cmtrandt D ON H.comp_id = D.comp_id AND H.tran_num = D.tran_num  
LEFT JOIN cmtrantype T ON D.comp_id = T.comp_id AND D.tran_type = T.tran_type
LEFT JOIN cmtranbatch B ON B.comp_id = H.comp_id AND B.tran_num = H.tran_num
WHERE 1 = 1 
AND H.post_flag = 1
AND B.tran_num IS NULL
AND H.entry_date >= '2019/10/01'
ORDER BY H.apply_date;


dDISABLE TRIGGER cmtranbatch_trgupd ON cmtranbatch;
uUPDATE cmtranbatch SET 
post_flag = 1,
post_date = apply_date
WHERE post_flag = 0;
eENABLE TRIGGER cmtranbatch_trgupd ON cmtranbatch;


---


SELECT        
TR.tran_id, 
TR.comp_id, 
TR.tran_num, 
TR.tran_desc, 
TR.entry_date, 
TR.doc_date, 
TR.apply_date, 
TR.post_date, 
TR.post_flag, 
TR.user_id, 
tran_type = CASE WHEN TR.tran_class <> 13210 THEN TR.tran_type ELSE TR.tran_type + '-' + TR.trsf_tran_type END, 
TY.tran_type_desc, 
TR.cash_acct_code,
C.cash_acct_desc,
cash_acct_descr = CASE WHEN TR.tran_class <> 13210 THEN SUBSTRING(C.cash_acct_desc, 1, 4) ELSE SUBSTRING(C.cash_acct_desc, 1, 4) + '-' + SUBSTRING(CT.cash_acct_desc, 1, 4) END,
TR.tran_amt,
TR.tran_class,
TY.severity_class
FROM   cmtranbatch TR
INNER JOIN cmtrantype TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type
INNER JOIN cmcash C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code
LEFT JOIN cmcash CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code
--WHERE TR.apply_date <= '2019/10/31' 
WHERE TR.apply_date BETWEEN '2019/10/16' AND '2019/10/31'
AND TR.post_flag = 0
ORDER BY TY.severity_class, TY.sequence, TR.apply_date

select * from cmtrantype


UPDATE cmtrantype SET severity_class = 1 WHERE tran_type = 'DESPENSA'


UPDATE cmtrantype SET severity_class = 3 WHERE tran_type = 'PAGOCAE'








--


SELECT        
TR.tran_id, 
TR.comp_id, 
TR.tran_num, 
TR.tran_desc, 
TR.entry_date, 
TR.doc_date, 
TR.post_date, 
TR.post_flag, 
TR.user_id, 
tran_type = CASE WHEN TR.tran_class <> 13210 THEN TR.tran_type ELSE TR.tran_type + '-' + TR.trsf_tran_type END, 
TY.tran_type_desc, 
TR.cash_acct_code,
C.cash_acct_desc,
cash_acct_descr = CASE WHEN TR.tran_class <> 13210 THEN SUBSTRING(C.cash_acct_desc, 1, 4) ELSE SUBSTRING(C.cash_acct_desc, 1, 4) + '-' + SUBSTRING(CT.cash_acct_desc, 1, 4) END,
tran_amt = CASE TY.tran_class WHEN 13110 THEN TR.tran_amt * -1 ELSE TR.tran_amt END,
TR.tran_class,
TR.apply_date
FROM   cmtranbatch TR
INNER JOIN cmtrantype TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type
INNER JOIN cmcash C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code
LEFT JOIN cmcash CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code
--WHERE TR.apply_date = @apply_date 
WHERE TR.apply_date BETWEEN @from_apply_date AND @to_apply_date
AND TR.post_flag = 1


select * from cmtranbatch


--



SELECT        
TR.tran_id, 
TR.comp_id, 
TR.tran_num, 
TR.tran_desc, 
TR.entry_date, 
TR.doc_date, 
TR.post_date, 
TR.post_flag, 
TR.user_id, 
tran_type = CASE WHEN TR.tran_class <> 13210 THEN TR.tran_type ELSE TR.tran_type + '-' + TR.trsf_tran_type END, 
TY.tran_type_desc, 
TR.cash_acct_code,
C.cash_acct_desc,
cash_acct_descr = CASE WHEN TR.tran_class <> 13210 THEN SUBSTRING(C.cash_acct_desc, 1, 4) ELSE SUBSTRING(C.cash_acct_desc, 1, 4) + '-' + SUBSTRING(CT.cash_acct_desc, 1, 4) END,
tran_amt = CASE TY.tran_class WHEN 13110 THEN TR.tran_amt * -1 ELSE TR.tran_amt END,
TR.tran_class,
TR.apply_date
FROM   cmtranbatch TR
INNER JOIN cmtrantype TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type
INNER JOIN cmcash C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code
LEFT JOIN cmcash CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code
WHERE TR.apply_date BETWEEN @from_apply_date AND @to_apply_date
AND TR.post_flag = 1
ORDER BY TY.severity_class, TY.sequence, TR.apply_date


select * from cmtranbatch where apply_date = '2019/10/21'

update cmtranbatch
set star_flag = 1, hold_reason = 'Hola'
where tran_id = 3181