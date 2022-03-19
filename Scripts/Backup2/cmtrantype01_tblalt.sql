

IF (SELECT COUNT(*) FROM sysobjects O INNER JOIN syscolumns C ON C.id = O.id WHERE O.type = 'U' AND O.name = 'cmtrantype' AND C.name = 'severity_class') = 0
BEGIN

	ALTER TABLE cmtrantype ADD severity_class saClass NOT NULL DEFAULT 2; -- 1.High 2.Medium 3.Low
	ALTER TABLE cmtrantype ADD sequence saInum NOT NULL DEFAULT 0;

END
