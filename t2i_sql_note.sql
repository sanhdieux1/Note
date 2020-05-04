select t2.name, count(*) from framework_security_class_permission t1
inner join framework_security_class t2 ON t2.id = t1.class_id
inner join framework_security_permission t3 ON t3.id = t1.permission_id
group by t2.id

-- grant permission on group

INSERT INTO framework_security_class_group(group_name, class_id)
(SELECT 'SAASAdministrator', id
 from framework_security_class
 where
     name IN ('ECM_CLASS_ADMIN', 'NOT_SECURED_FOLDER', 'NOT_SECURED_DOCUMENT', 'SERVICE_USERS_CLASS', 'KhoaClass', 'KietClass')
        AND id NOT IN (SELECT class_id from framework_security_class_group where group_name = 'SAASAdministrator'))
;

--SuperECMGroup - VNCUDGroup - ECMFunctionGroup - Users - SaaSGroupAdmin - KietGroup - ThaoGroup - ECMHangGrroup - KhoaGroup - SuperECMGroup

-- Select group and class

select t1.*, t2.name from framework_security_class_group t1
inner join framework_security_class t2 on t1.class_id = t2.id;


--insert permission for class
INSERT INTO framework_security_class_permission(class_id, permission_id)
          (SELECT
                  (SELECT id FROM framework_security_class where name = 'KhoaClass') as class_id,
                  id as permission_id
          from framework_security_permission
          where model_id = 1 AND
                id NOT IN (SELECT t1.permission_id from framework_security_class_permission t1
                          INNER JOIN framework_security_permission t2 ON t2.id = t1.permission_id
                          INNER JOIN framework_security_class t3 ON t3.id = t1.class_id
                          WHERE t3.name = 'KhoaClass'))

select t2.name, t3.code as code from framework_security_class_permission t1
inner join framework_security_class t2 ON t1.class_id = t2.id
inner join framework_security_permission t3 ON t1.permission_id = t3.id
where t2.name = 'ECM_CLASS_ADMIN'
;

--insert permission into class
INSERT INTO framework_security_class_permission(class_id, permission_id)
SELECT (SELECT id FROM framework_security_class WHERE name = 'NOT_SECURED_DOCUMENT') as class_id,
       (SELECT id FROM framework_security_permission WHERE code = 'TECHNICAL_SUPPORT') as permission_id


-- delete from solr
https://vntils06:8984/solr/NonPac/update?stream.body=%3Cdelete%3E%3Cquery%3Eid:%22XECM-DOCUMENT--NONPAC-BY2IMUT8.XML%22%3C/query%3E%3C/delete%3E&commit=true
https://vntils06:8984/solr/Dev004/update?stream.body=%3Cdelete%3E%3Cquery%3EsoftwareCode:XCWF/query%3E%3C/delete%3E&commit=true

https://vntils06:8984/solr/NonPac/update?stream.body=%3Cdelete%3E%3Cquery%3Eid:%22XECM-FOLDER--NONPAC-11446651%22%3C/query%3E%3C/delete%3E&commit=true

---Event logs
https://localhost:8443/xframework-event-web/rest/eventlog/test/12290832/NonPac/en/BusinessOperation?serviceContext=%7B%22environmentName%22:%22NonPac%22,%22regionalSettings%22:%22en%22,%22userId%22:%22hang.uy@dev002%22%7D
xline-service-user@dev002/xl4Jee@ChangeIt1

--- change user from SASS
 >can not login -> check LDAP principal name
 
 
 --- Batch mode follow:
 XECMProcessJMSConsumer -> send to ObjectStore XOSTProcessJMSConsumer -> handle file, PDF... -> reply ECM XECMReplyXOSTProcessQueueConsumer -> push to Queue 
 -> BatchIndexProcessServices/XECMBatchIndexProcessQueueConsumer auto scan every 30s -> 
 refer -> xecm-doc\src\main\resources\doc\raw\XECM Schema\ecm_fulltext_index_batchmode.png
 --Button on folder 
 folder-tile-directive -> 'unit-toolbar-button-clicked'
 
 --Remove rule:
delete from framework_security_business_data_rule_class;
delete from framework_security_business_data_rule_name;
delete from framework_security_business_data_expression;
-- delete from framework_security_business_data_name;
-- delete from framework_security_business_data;
delete from framework_security_business_data_rule;

update ECM_KWLST set br_id_folder = null, br_id =null;
update ecm_param set br_id_document = null, br_id_folder = null;

-------------------


----- kill connections on database

DECLARE @kill varchar(8000); SET @kill = '';
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), spid) + ';'
FROM master..sysprocesses
WHERE dbid = db_id('xlinedta001UnitTests_02')
--SELECT @kill
EXEC(@kill);

---create database
create database xlinedtaxecmUnitTests_05 COLLATE French_CI_AI;


--- Clone table

--SQL Server: 
SELECT * INTO _xlinedta_xecm_5star_nonpac.dbo.ecm_param_bk1 FROM _xlinedta_xecm_5star_nonpac.dbo.ecm_param
--iSeries: 
XDOCDTA001 ->XDOCDTA30A
XDOCDFX001 -> XDOCDFX30A
XSECDTA001 -> XSECDTA30A
XCXXDTASM,XDOCDFXSM,XDOCDTASM,XSECDFXSM,XSECDTASM
XDOCDFX30A,XDOCDTA30A,XSECDTA30A

CREATE TABLE XDOCDTA30A.OP8WT_BK LIKE XDOCDTA30A.OP8WT;
INSERT INTO XDOCDTA30A.OP8WT_BK (SELECT * FROM XDOCDTA30A.OP8WT);

--- DLQ retry
  max-delivery-attempts=10
  https://wildscribe.github.io/WildFly/10.0/subsystem/messaging-activemq/server/address-setting/index.html#attr-max-delivery-attempts

---jenskin

URL: http://vntils10:8080/
credentials: members/pa$$w0rd


find asssign task:
{"efolder_steps.efolder_step_tasks.eFolder_step_assignments.assignee_user_id":"khoa.pham@dev002"}

find sub:
