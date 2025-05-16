DO $$
BEGIN
   -- Grant privileges on all tables in all schemas
   EXECUTE (
     SELECT string_agg('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ' || quote_ident(schemaname) || ' TO vulcan_owner_role;', ' ')
     FROM pg_catalog.pg_tables
     WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
   );
END $$;
