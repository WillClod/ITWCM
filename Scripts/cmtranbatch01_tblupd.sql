
IF (SELECT COUNT(*) FROM sysobjects O INNER JOIN syscolumns C ON C.id = O.id WHERE O.type = 'U' AND O.name = 'cmtranbatch' AND C.name = 'apply_date') = 0
BEGIN

	ALTER TABLE cmtranbatch ADD apply_date saDate NULL;

	IF (SELECT COUNT(*) from sysobjects where name = 'cmtranbatch_trgupd') >= 1	
		DISABLE TRIGGER cmtranbatch_trgupd ON cmtranbatch;
	
	EXEC('
	UPDATE cmtranbatch SET apply_date = doc_date
	');
	
	IF (SELECT COUNT(*) from sysobjects where name = 'cmtranbatch_trgupd') >= 1	
		ENABLE TRIGGER cmtranbatch_trgupd ON cmtranbatch;


	ALTER TABLE cmtranbatch ADD severity_class saClass NOT NULL DEFAULT 2; -- 1.High 2.Medium 3.Low
	ALTER TABLE cmtranbatch ADD star_flag saFlag NOT NULL DEFAULT 0;
	ALTER TABLE cmtranbatch ADD hold_flag saFlag NOT NULL DEFAULT 0;

	ALTER TABLE cmtranbatch ADD hold_reason saDesc NULL;

END
