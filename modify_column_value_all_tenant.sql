
DO
$$
DECLARE   final_statement text;
  DECLARE script_name     TEXT;
  DECLARE schema          TEXT;
  DECLARE returnValue     integer;
  DECLARE pTableName       TEXT DEFAULT 'booking_header';
  DECLARE pColumnName      TEXT DEFAULT 'business_case';
  DECLARE pSearch      TEXT DEFAULT '30V_REVENUE';
  DECLARE pUpdateValue      TEXT DEFAULT '30V_REVENUE2';

BEGIN
  FOR schema IN SELECT nspname AS schema_name FROM pg_catalog.pg_namespace WHERE nspname LIKE 's_%' ORDER BY nspname
  LOOP
    IF EXISTS(SELECT 1 FROM pg_tables WHERE schemaname = schema)
    THEN
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.columns
                WHERE table_name=pTableName and lower(column_name)=lower(pColumnName) and table_schema = schema)
      THEN
            returnValue := NULL;
            final_statement := 'UPDATE ' || schema || '.' || pTableName || ' SET ' || pColumnName || ' = ''' || pUpdateValue || ''' WHERE ' || pColumnName || '=''' || pSearch || ''' RETURNING id' ;
            EXECUTE final_statement INTO returnValue;
            if(returnValue IS NOT NULL) THEN
              raise notice 'from the schema: %, row id: %', schema, returnValue;
            END IF;
      END IF;
    END IF;
  END LOOP;
END;
$$