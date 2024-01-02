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

-- GRANT ACCESS USER ROLE TO SELECT VIEW
CREATE OR REPLACE PROCEDURE grant_DML_type_views_to_role(DML_type varchar, role varchar)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        proper_DML_type bool := upper(DML_type) = 'SELECT'
        OR upper(DML_type) = 'INSERT' OR upper(DML_type) = 'SELECT';
    BEGIN
        IF EXISTS(SELECT FROM pg_roles WHERE rolname=role) AND proper_DML_type THEN
            EXECUTE 'GRANT ' || DML_type || ' ON public_competitors_info TO ' || role;
            RAISE NOTICE 'GRANT % ON public_competitors_info TO %', DML_type, role;
            EXECUTE 'GRANT ' || DML_type || ' ON public_teams_info TO ' || role;
            RAISE NOTICE 'GRANT % ON public_teams_info TO %', DML_type, role;
            EXECUTE 'GRANT ' || DML_type || ' ON public_tournament_info TO ' || role;
            RAISE NOTICE 'GRANT % ON public_tournament_info TO %', DML_type, role;
            EXECUTE 'GRANT ' || DML_type || ' ON solo_results TO ' || role;
            RAISE NOTICE 'GRANT % ON solo_results TO %', DML_type, role;
            EXECUTE 'GRANT ' || DML_type || ' ON team_results TO ' || role;
            RAISE NOTICE 'GRANT % ON team_results TO %', DML_type, role;
        ELSE
            RAISE NOTICE '% role does not exist', role;
        end if;
    END
    $$;


-- PROCEDURES AND FUNCTIONS CALLS

CALL show_tables();
