
--SELECT * from xlinedta002_nonPAC.dbo.ARCKREP --9898
SELECT COUNT(*) as Default_Environment from xlinedta002_nonPAC.dbo.ARCKREP --9898
SELECT COUNT(*) as Dev002_Environment from xlinedta002.dbo.ARCKREP -- 100

select * from [5Star_HRC].dbo.framework_eventlog 
where (businessEventName= 'EMAIL_DOCUMENT' or businessEventName= 'EMAIL_VERSION') and [timeStamp] > '2019-04-01 10:09:48'


select * FROM [5Star_HRC].dbo.framework_eventlog 
where (businessEventName= 'EMAIL_DOCUMENT' or businessEventName= 'EMAIL_VERSION') and --[timeStamp] > '2019-04-01 10:09:48'
objectId='BY2DMDWA.PDF'

select * FROM xlinedta001_GroupeT2i.dbo.framework_eventlog 
where (businessEventName= 'EMAIL_DOCUMENT' or businessEventName= 'EMAIL_VERSION') AND  [timeStamp] > '2019-04-01 10:09:48'  --1572

select * from xlinedta001_GroupeT2i.dbo.framework_eventlog  where objectId='6BIL2EHR.PDF'

-- delete FROM [5Star_HRC].dbo.framework_eventlog where (businessEventName= 'EMAIL_DOCUMENT' or businessEventName= 'EMAIL_VERSION') and [timeStamp] > '2019-04-01 10:09:48'
-- delete FROM xlinedta001_GroupeT2i.dbo.framework_eventlog where (businessEventName= 'EMAIL_DOCUMENT' or businessEventName= 'EMAIL_VERSION') and [timeStamp] > '2019-04-01 10:09:48'
select * from [xlinedta002].dbo.ARAJREP 


SELECT top 100 id, eventDate, businessEventName, environment, eventCategory, eventType, eventSubType, objectId, status, eventData, isBusinessEvent, userName, [source] 
FROM [xlinedta001_GroupeT2i].dbo.FRAMEWORK_EVENTLOG 
where objectId='6BIL2EHR.PDF' and isBusinessEvent=1

select count(*)
FROM DDrhvT COMMENT
    LEFT JOIN ARAPREP ON ARAPREP.APASVN = COMMENT.DD1rA
    LEFT JOIN ARBMREP DOC_VERSION ON DD1rA = DOC_VERSION.BMASVN AND APBBST = 'V',
    DDCLOB
WHERE COMMENT.DDPP7A = DDCLOB.TSCID 
AND DD40A = 'MAI' AND((APBBST = 'V' AND DOC_VERSION.BMG7NA is not null) or APBBST != 'V')


SELECT * FROM xlinedta002_nonPAC.dbo.AREZCPP WHERE EZF8TX = 'vnhau-review-06'
select * from xlinedta002_nonPAC.dbo.ECM_FL where folderid='11148652'
select * from xlinedta002_nonPAC.dbo.ecm_fldtyp where typeid='010'


SELECT MAX(AHAFCD) from ARAHREP WHERE ISNUMERIC(AHAFCD) <> 0 and AHAHNA like (CONCAT(RTRIM(AHAFCD),'/%')) -- 13 technical doc type
SELECT   COUNT(DISTINCT kindId) from dbo.ecm_kitydo -- 757

/*
DELETE ARAHREP WHERE AHAFCD in(
SELECT AHAFCD from ARAHREP WHERE ISNUMERIC(AHAFCD) <> 0 and AHAHNA like (CONCAT(RTRIM(AHAFCD),'/%'))) and AHAFCD not in (SELECT  DISTINCT docTyid from dbo.ecm_kitydo)
*/

SELECT  COUNT (DISTINCT kindId) from dbo.ecm_kitydo  -- before 756 natures
SELECT * from ARAHREP WHERE ISNUMERIC(AHAFCD) <> 0 -- before 11 technical doc types + 756 = 767

select DISTINCT doctyid,kindId, baseid from ecm_kitydo

SELECT  COUNT(AHAWCD) FROM ARAHREP WHERE AHAWCD= 'BD701' AND ISNUMERIC(AHAFCD) <> 0 AND AHAHNA = (CONCAT(RTRIM(AHAFCD),'/PERPRV01'))

SELECT  COUNT(AHAWCD) FROM ARAHREP WHERE AHAWCD= '' AND ISNUMERIC(AHAFCD) <> 0 AND AHAHNA = (CONCAT(RTRIM(AHAFCD),'/PERPRV01'))


declare @OBJECT_DESCRIPTOR VARCHAR(MAX)
EXEC xlinedta002.dbo.exportFolder @OBJECT_DESCRIPTOR = @OBJECT_DESCRIPTOR output,@DATABASEID = '_ALL_',	@FOLDERID='_ALL_', @SEC_ENVIRONMENT='',@ENVIRONMENT='Dev002',@LANG='fr',@ACTION='PROCESSOR',@SESSION_ID='vncud-test'
select @OBJECT_DESCRIPTOR

declare @OBJECT_DESCRIPTOR VARCHAR(MAX)
EXEC xlinedta002_nonPAC.dbo.exportFolder @OBJECT_DESCRIPTOR = @OBJECT_DESCRIPTOR output,@DATABASEID = 'ADRES',	@FOLDERID='1706201905', @ENVIRONMENT='Dev002',@LANG='fr',@ACTION='PROCESSOR'
select @OBJECT_DESCRIPTOR

SELECT DISTINCT BATCH_ID FROM TOBJDESC
SELECT * FROM xlinedta002.dbo.indexation_batch
delete TOBJDESC WHERE indexation_id='XECM-DOCUMENT--DEV002-6BIKU1KI.PDF'

SELECT * from arg0cpp where ddr68a = 'E'
SELECT COUNT(*) FROM TOBJDESC
select * from indexation_batch

--TRUNCATE TABLE indexation_batch DEBUG
--TRUNCATE table TOBJDESC


declare @OBJECT_DESCRIPTOR VARCHAR(MAX)
EXEC exportdoc @OBJECT_DESCRIPTOR = @OBJECT_DESCRIPTOR output,@DOCUMENTID = '_ALL_',@SEC_ENVIRONMENT='Dev002',@ENVIRONMENT='Dev002', @LANG='en', @ACTION='RESTART',@SESSION_ID='VNCUD_SESSION'
select @OBJECT_DESCRIPTOR

select apasvn from araprep where apactx like '%05072019_review_default_2%'

SELECT * from xlinedta002.dbo.arg0cpp where  DDr68A = 'R'
-- update arg0cpp SET DDr68A = 'R' WHERE dd1ra in(select top 10 dd1ra from arg0cpp)

select * from dbo.ecm_fldtyp where typeID='HPG'
select * from dbo.ecm_fldkw where fldTyId='10'

select * from dbo.ecm_fldtyp where base='DBC2'
select count(*) from dbo.ecm_fldkw
select * from ecm_pacref where baseid='bd102'

SELECT op5pa storageClassId, op68a primaryServer, op69a backupServer,op64a relativePath FROM OP9ET
select * from TEVTOBJDESC where event like '%MAIL%'

-- +ARGHREP - FolderLink(GHAWCD:parent db,GHIUNA:parent folder)
select * from ARGHREP


--TRUNCATE table ECM_EXTMG
--TRUNCATE table ECM_EXTIX
select COUNT(*) from ECM_EXTIX where processed = 0

-- createionUser/modificationUser
SELECT DISTINCT(dut5na) FROM ARDUCPP 
SELECT DISTINCT(dut4na) from ARDUCPP --20207
-- new table
select DISTINCT(creationUser) from ECM_EXTIX
select DISTINCT(modificationUser) from ECM_EXTIX --2007-02-16 06:01:04

SELECT DUZONB,DUAYTM FROM ARDUCPP where DUTZNA='OF0030940' 
SELECT DISTINCT(dut4na) from ARDUCPP --20207
SELECT COUNT(DISTINCT(dwtzna)) FROM ARDWCPP --ExternalIndexKeywords
SELECT COUNT(DISTINCT(dvtzna)) FROM ARDVCPP --ExternalIndexFolders
 
 delete xlinedta002_nonPAC.dbo.ECM_EXTIX
 
 select * from arezcpp WHERE ezawcd='ADRES' AND ezf8tx='0020676'
 update xlinedta002_nonPAC.dbo.ecm_idx_f set status='R' where DATABASEid='ADRES' AND busnsFldId='0020676'
 select * from xlinedta002_nonPAC.dbo.ecm_idx_f where DATABASEid='ADRES' AND busnsFldId='0020676'
 
 SELECT * from [xlinedta002_nonPAC].dbo.ecm_idx_f where status='R'

select * from [xlinedta002_nonPAC].dbo.arezcpp where ezf8tx ='1706201910'
 
declare @OBJECT_DESCRIPTOR VARCHAR(MAX)
EXEC xlinedta002_nonPAC.dbo.exportFolder @OBJECT_DESCRIPTOR = @OBJECT_DESCRIPTOR output,@DATABASEID = '_ALL_',	@FOLDERID='_ALL_', @ENVIRONMENT='Dev002',@LANG='fr',@ACTION='PROCESSOR',@SESSION_ID='vncud-test'
select @OBJECT_DESCRIPTOR

SELECT * from debug
TRUNCATE table debug

SELECT * from indexation_batch
SELECT * from  xlinedta002_nonPAC.dbo.TFLDDESC
SELECT * from ECM_FLDIDX
TRUNCATE TABLE ECM_FLDIDX

declare @OBJECT_DESCRIPTOR VARCHAR(MAX)
EXEC xlinedta002_nonPAC.dbo.exportFolder @OBJECT_DESCRIPTOR = @OBJECT_DESCRIPTOR output,@DATABASEID = '_ALL_',	@FOLDERID='_ALL_', @ENVIRONMENT='Dev002',@LANG='fr',@ACTION='PROCESSOR',@SESSION_ID='vncud-test'
select @OBJECT_DESCRIPTOR


declare @OBJECT_DESCRIPTOR VARCHAR(MAX)
EXEC xlinedta002_nonPAC.dbo.exportFolder @OBJECT_DESCRIPTOR = @OBJECT_DESCRIPTOR output,@DATABASEID = 'ADRES',	@FOLDERID='VNFOLDER_PA', @ENVIRONMENT='Dev002',@LANG='fr',@ACTION='PROCESSOR',@SESSION_ID='vncud-test'
select @OBJECT_DESCRIPTOR

SELECT * FROM ARGHREP FETCH FIRST 20 ROWs only--GHAWCD:parent db,GHIUNA:parent folder

SELECT * FROM AREZCPP where EZAWCD='ADRES' --11261730
SELECT * FROM XDOCDTA30A.AREZCPP WHERE EZF8TX LIKE 'VNFOLDER%'
-- FOLDER LINKS
SELECT * FROM ARGHREP FETCH FIRST 20 ROWs only--GHAWCD:parent db,GHIUNA:parent folder  ADRES	VNFOLDER_PA
SELECT * FROM TFLDDESC-- WHERE SESSION_UNIQUE = 'vnkit'
SELECT * FROM INDEXATION_BATCH
--TRUNCATE XDOCDTA30A.INDEXATION_BATCH
SELECT * FROM ECM_IDX_F WHERE BUSNSFLDID LIKE 'VNFOLDE%'
SELECT * FROM ARG0CPP WHERE dd1ra in('5ZWOXYDA.PDF','5ZWOXYDB.PDF','5ZWOXYDC.PDF','5ZWOXYDD.PDF','5ZWOXYDE.PDF','5ZWOXYDF.PDF') 

update ARG0CPP SET ddr68a='E' WHERE dd1ra in('5ZWOXYDA.PDF','5ZWOXYDB.PDF','5ZWOXYDC.PDF','5ZWOXYDD.PDF','5ZWOXYDE.PDF','5ZWOXYDF.PDF') 
UPDATE ECM_IDX_F SET STATUS ='R' WHERE BUSNSFLDID = 'VNFOLDER_PA'


declare @OBJECT_DESCRIPTOR VARCHAR(MAX)
EXEC exportdoc @OBJECT_DESCRIPTOR = @OBJECT_DESCRIPTOR output,@DOCUMENTID = '6BIMR24V.PDF',@SEC_ENVIRONMENT='Dev004',@ENVIRONMENT='Dev002', @LANG='en', @ACTION='RESTART',@SESSION_ID='VNCUD_SESSION'
select @OBJECT_DESCRIPTOR


SELECT *  from TOBJDESC
SELECT * from indexation_batch
select * from xlinedtaecm_5star_pac.dbo.OP8wT where OP5pA='DOCU001' AND( OP64A =''  or OP64A is null)


SELECT id, [system], businessEventName, environment, eventCategory,objectType, eventData, securityObjectData, eventType, eventSubType, initiator, isBusinessEvent, objectId, source, userName, status, message
From [xlinedtaecm_5star_pac].dbo.framework_eventlog
where objectId = '596197'


SELECT * FROM framework_security_permission
where id in(select permission_id 
			from framework_security_class_permission 
			where class_id in(select id from framework_security_class where name ='NOT_SECURED_DOCUMENT')) /*NOT_SECURED_DOCUMENT:16 permissions - NOT_SECURED_FOLDER:11 */
			
-- Count remainning permissions
SELECT * FROM framework_security_permission where id not in (SELECT id FROM framework_security_permission
where id in(select permission_id 
			from framework_security_class_permission 
			where class_id in(select id from framework_security_class where name ='NOT_SECURED_DOCUMENT' or name ='NOT_SECURED_FOLDER'))) /*NOT_SECURED_DOCUMENT:15 permissions - NOT_SECURED_FOLDER:11 */


DELETE framework_security_class_permission
DELETE framework_security_class
DELETE framework_security_permission
