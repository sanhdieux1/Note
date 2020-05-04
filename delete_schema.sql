
DO
$$
DECLARE   final_statement text;
  DECLARE script_name     TEXT;
  DECLARE schema          TEXT;
  DECLARE returnValue     integer;
BEGIN
  script_name := '''V2019.03.06.00000__ADD_COLUMN_ACCOUNT_SERVICE_REFERENCE_TO_BANK_TRANSACTION_TABLE.sql''';
  FOR schema IN SELECT nspname AS schema_name FROM pg_catalog.pg_namespace WHERE nspname LIKE 's_%' ORDER BY nspname
  LOOP
    IF EXISTS(SELECT 1 FROM pg_tables WHERE schemaname = schema)
    THEN
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'schema_version')
      THEN
        final_statement := 'SELECT COUNT(*)
FROM ' || schema || '.schema_version' || ' WHERE ' || schema || '.schema_version.script = ' || script_name;
        EXECUTE final_statement
        into returnValue;
        IF returnValue >= 1
        THEN
          final_statement :=
          'DELETE FROM ' || schema || '.schema_version' || ' WHERE ' || schema || '.schema_version.script = ' ||
          script_name;
          EXECUTE final_statement;
          raise notice 'Remove the script: %', script_name;
          raise notice 'from the schema: %', schema;
        END IF;
      END IF;
    END IF;
  END LOOP;
END;
$$