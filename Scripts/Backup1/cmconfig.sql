

IF (SELECT COUNT(*) FROM sysobjects O INNER JOIN syscolumns C ON C.id = O.id WHERE O.type = 'U' AND O.name = 'cmconfig' AND C.name = 'trfout_tran_type') = 0
BEGIN

	ALTER TABLE cmconfig ADD trfout_tran_type saCode NULL 
	ALTER TABLE cmconfig ADD trfin_tran_type saCode NULL 

END
