
DO
$$
DECLARE   final_statement text;
  DECLARE script_name     TEXT;
  DECLARE schema          TEXT;
  DECLARE returnValue     integer;
BEGIN
  FOR schema IN SELECT nspname AS schema_name FROM pg_catalog.pg_namespace WHERE nspname LIKE 's_%' ORDER BY nspname
  LOOP
    IF EXISTS(SELECT 1 FROM pg_tables WHERE schemaname = schema)
    THEN
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.columns
                WHERE table_name='bank_transaction' and lower(column_name)=lower('account_service_reference') and table_schema = schema)
      THEN
            raise notice 'from the schema: %', schema;
            final_statement :=
            'ALTER TABLE ' || schema || '.bank_transaction' || ' DROP ' || 'account_service_reference';
            EXECUTE final_statement;
      END IF;
    END IF;
  END LOOP;
END;
$$
