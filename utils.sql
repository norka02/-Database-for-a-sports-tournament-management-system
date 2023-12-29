-- PROCEDURES AND FUNCTIONS DEFINITIONS

CREATE OR REPLACE PROCEDURE show_tables()
LANGUAGE plpgsql
AS $$
DECLARE
    r RECORD;
    i int := 1;
BEGIN
    FOR r IN SELECT tablename FROM pg_tables WHERE schemaname = 'public'
    LOOP
        RAISE NOTICE '%: %',  i, r.tablename;
        i := i + 1;
    END LOOP;
END $$;

-- PROCEDURES AND FUNCTIONS CALLS

CALL show_tables();