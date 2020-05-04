DO
$$
DECLARE   final_statement text;
  DECLARE script_name     TEXT;
  DECLARE schema          TEXT;
  DECLARE returnValue     integer;
  DECLARE pTableName       TEXT DEFAULT 'company_bank_account';
  DECLARE pColumnName      TEXT DEFAULT 'iban_number';
  DECLARE pSearch      TEXT DEFAULT 'CH5809000000120000033';

BEGIN
  FOR schema IN SELECT nspname AS schema_name FROM pg_catalog.pg_namespace WHERE nspname LIKE 's_%' ORDER BY nspname
  LOOP
    IF EXISTS(SELECT 1 FROM pg_tables WHERE schemaname = schema)
    THEN
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.columns
                WHERE table_name=pTableName and lower(column_name)=lower(pColumnName) and table_schema = schema)
      THEN
            returnValue := 0;
--            final_statement := 'SELECT 1 FROM ' || schema || '.' || pTableName || ' WHERE ' || pColumnName || ' LIKE ''%' || pSearch || '%''';
            final_statement := 'SELECT 1 FROM ' || schema || '.' || pTableName || ' WHERE ' || pColumnName || ' = ''' || pSearch || '''';
            EXECUTE final_statement INTO returnValue;
            IF returnValue THEN
              raise notice 'from the schema: %', schema;
            end if;
      END IF;
    END IF;
  END LOOP;
END;
$$
