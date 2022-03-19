/******************************************************************************
**	File: cmtranbatch_tblcre.sql
**	Name: cmtranbatch
**	Desc: CM Transaction Batch
**
**	Auth: 
**	Date: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:		Description:
**	--------	--------	---------------------------------------
**    
*******************************************************************************/

IF EXISTS ( SELECT name FROM sysobjects WHERE name = 'cmtranbatch' )                     
	DROP TABLE cmtranbatch                           
GO                                                 
CREATE TABLE cmtranbatch
(
	tran_id				saId IDENTITY,
	CONSTRAINT 			cmtranbatch_pk PRIMARY KEY (tran_id) ,
	comp_id				saId NULL,
	tran_num			saCNum NULL,
	tran_desc			saDesc,
	entry_date 			saDate,
	doc_date 			saDate,
	post_date			saDate NULL,
	post_flag			saFlag,	
	user_id				saId,
	CONSTRAINT			cmtranbatch_userid_fk FOREIGN KEY (user_id) REFERENCES  sauser(user_id),
	tran_type			saCode,
	CONSTRAINT			cmtranbatch_trantype_fk FOREIGN KEY (comp_id, tran_type) REFERENCES  cmtrantype(comp_id, tran_type),
	cash_acct_code 		saAcct,	
	CONSTRAINT			cmtranbatch_cashacctcode_fk FOREIGN KEY (comp_id, cash_acct_code) REFERENCES  cmcash(comp_id, cash_acct_code),
	tran_amt 			saAmt,
	tran_class			saClass, --13010:Cash Increase, 13110:Cash Decrease, 13210: Cash Transfer
	trsf_tran_type		saCode NULL,
	CONSTRAINT			cmtranbatch_trftrantype_fk FOREIGN KEY (comp_id, trsf_tran_type) REFERENCES  cmtrantype(comp_id, tran_type),
	trsf_cash_acct_code saAcct NULL,	
	CONSTRAINT			cmtranbatch_trfcashacctcode_fk FOREIGN KEY (comp_id, trsf_cash_acct_code) REFERENCES  cmcash(comp_id, cash_acct_code),

)
GO
GRANT ALL ON cmtranbatch TO PUBLIC               
GO                                                 
