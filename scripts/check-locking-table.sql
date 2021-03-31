
--kill process lock
DECLARE @kill varchar(max); SET @kill = '';
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), spid) + ';'
from sys.sysprocesses
where
--       blocked > 0 and
  spid > 50 and
dbid = 11;
SELECT @kill
EXEC(@kill);

--user process
SELECT *
FROM sys.dm_exec_sessions
WHERE
    is_user_process = 1
SELECT SPID
FROM master..sysprocesses (NOLOCK)
WHERE spid>50
AND status='sleeping'
AND DATEDIFF(mi,last_batch,GETDATE())>=60
AND spid<>@@spid
-- create trigger
DROP TRIGGER IF EXISTS idx_f_update_tgx;
GO
CREATE TRIGGER idx_f_update_tgx
ON ecm_idx_f
AFTER UPDATE NOT FOR REPLICATION

AS
BEGIN
    DECLARE @newObject varchar(255);
	DECLARE @oldObject varchar(255);
    SET @newObject = '';
    SET @oldObject = '';
    insert into ecm_trace_deadlock(oldValue, newValue)
    SELECT CAST(deleted.folderId as varchar(255)) + '_' + deleted.busnsFldId + '_' + deleted.status,
            CAST(inserted.folderId as varchar(255)) + '_' + inserted.busnsFldId + '_' + inserted.status from DELETED,INSERTED
    where deleted.folderId = inserted.folderId
END


select * from master..sysprocesses where dbid = db_id('_xlinedta_xecm_unitTests_01')

-- find all foreign key of a table
EXEC sp_fkeys 'framework_eventlog';


SELECT OBJECT_NAME (72057594077708288);
select DB_NAME(22)

-- check current locks
select dbid, DB_NAME(dbid) as databaseName, cmd,* from sys.sysprocesses
where dbid = 11;
--find all open transaction
DBCC OPENTRAN
SELECT DB_NAME(dbid) as databaseName, dbid, * FROM sys.sysprocesses WHERE open_tran > 0
                                                                      and dbid = 11;

kill 5018;
--find all open transaction
SELECT
trans.session_id AS [SESSION ID],
ESes.host_name AS [HOST NAME],login_name AS [Login NAME],
trans.transaction_id AS [TRANSACTION ID],
tas.name AS [TRANSACTION NAME],tas.transaction_begin_time AS [TRANSACTION
BEGIN TIME],
tds.database_id AS [DATABASE ID],DBs.name AS [DATABASE NAME]
FROM sys.dm_tran_active_transactions tas
JOIN sys.dm_tran_session_transactions trans
ON (trans.transaction_id=tas.transaction_id)
LEFT OUTER JOIN sys.dm_tran_database_transactions tds
ON (tas.transaction_id = tds.transaction_id )
LEFT OUTER JOIN sys.databases AS DBs
ON tds.database_id = DBs.database_id
LEFT OUTER JOIN sys.dm_exec_sessions AS ESes
ON trans.session_id = ESes.session_id
WHERE ESes.session_id IS NOT NULL

select
    P.spid
,   right(convert(varchar,
            dateadd(ms, datediff(ms, P.last_batch, getdate()), '1900-01-01'),
            121), 12) as 'batch_duration'
,   P.program_name
,   P.hostname
,   P.loginame
from master.dbo.sysprocesses P
where P.spid > 50
and      P.status not in ('background', 'sleeping')
and      P.cmd not in ('AWAITING COMMAND'
                    ,'MIRROR HANDLER'
                    ,'LAZY WRITER'
                    ,'CHECKPOINT SLEEP'
                    ,'RA MANAGER')
order by batch_duration desc


-- find query of spid ----------
declare
    @spid int
,   @stmt_start int
,   @stmt_end int
,   @sql_handle binary(20)
set @spid = 1513 -- Fill this in
select  top 1
    @sql_handle = sql_handle
,   @stmt_start = case stmt_start when 0 then 0 else stmt_start / 2 end
,   @stmt_end = case stmt_end when -1 then -1 else stmt_end / 2 end
from    sys.sysprocesses
where   spid = @spid
order by ecid
SELECT
    SUBSTRING(  text,
            COALESCE(NULLIF(@stmt_start, 0), 1),
            CASE @stmt_end
                WHEN -1
                    THEN DATALENGTH(text)
                ELSE
                    (@stmt_end - @stmt_start)
                END
        )
FROM ::fn_get_sql(@sql_handle)
-------------------------------
-- identify object id
SELECT hobt_id, object_name(p.[object_id]) as name, index_id
FROM sys.partitions p
WHERE hobt_id = 72057594077708288
-- find objectlock by hobtid
SELECT %%LOCKRES%%,*
FROM [_xlinedta_xecm_5star_kh].[dbo].[ARGHREP] WITH(NOLOCK INDEX([ARGHREL0_IX]))
WHERE %%lockres%% = '(ef6796b4b67c)';

select * from ARBMREP;

    BEGIN
            BEGIN TRAN
            DECLARE @Semaphore_keyword INT
            SELECT @Semaphore_keyword = id FROM semaphore_keyword WITH ( HOLDLOCK, TABLOCKX )
            WAITFOR DELAY '00:00:12'
            COMMIT
    END
    WAITFOR DELAY '00:00:20'
