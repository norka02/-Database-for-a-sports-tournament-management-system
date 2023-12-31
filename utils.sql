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
CREATE OR REPLACE PROCEDURE grant_select_views_to_user_role()
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF EXISTS(SELECT FROM pg_roles WHERE rolname='external_user') THEN
            GRANT SELECT ON public_competitors_info TO external_user;
            RAISE NOTICE 'GRANT SELECT ON public_competitors_info TO external_user';
            GRANT SELECT ON public_teams_info TO external_user;
            RAISE NOTICE 'GRANT SELECT ON public_teams_info TO external_user';
            GRANT SELECT ON public_tournament_info TO external_user;
            RAISE NOTICE 'GRANT SELECT ON public_tournament_info TO external_user';
            GRANT SELECT ON solo_results TO external_user;
            RAISE NOTICE 'GRANT SELECT ON solo_results TO external_user';
            GRANT SELECT ON team_results TO external_user;
            RAISE NOTICE 'GRANT SELECT ON team_results TO external_user';
        ELSE
            RAISE NOTICE 'user role does not exist';
        end if;
    END;
    $$;


-- PROCEDURES AND FUNCTIONS CALLS

CALL show_tables();

CALL grant_select_views_to_user_role();