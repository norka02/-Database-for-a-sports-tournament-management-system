-- PROCEDURES AND FUNCTIONS DEFINITIONS

CREATE OR REPLACE PROCEDURE create_user(user_name VARCHAR, user_password VARCHAR)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = user_name) THEN
            EXECUTE 'CREATE ROLE ' || user_name || ' WITH LOGIN PASSWORD ''' || user_password || '''';
            RAISE NOTICE 'User % has been created', user_name;
        ELSE
            RAISE NOTICE 'User % is already exists', user_name;
        END IF;
    END;
    $$;

CREATE OR REPLACE PROCEDURE create_role(role_name VARCHAR)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NOT exists(SELECT FROM pg_roles WHERE rolname = role_name) THEN
            EXECUTE 'CREATE ROLE ' || role_name;
            RAISE NOTICE 'Role % has been created', role_name;
        ELSE
            RAISE NOTICE 'Role % is already exists', role_name;
        end if;
    end;
    $$;

CREATE OR REPLACE PROCEDURE grant_role_to_user(role VARCHAR, user_name VARCHAR)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NOT pg_has_role(user_name, role, role) AND
           exists(SELECT FROM pg_roles WHERE user_name = rolname ) THEN
            EXECUTE 'GRANT ' || role || ' TO ' || user_name;
            RAISE NOTICE  'Role % has been granted to user %', role, user_name;
        ELSE
            RAISE NOTICE 'User % arleady has role %', user_name, role;
        END IF;
    end;
    $$;

-- CALLING PROCEDURES AND FUNCTIONS

CALL create_role('external_user');
CALL create_role('organizer');
CALL create_role('referee');









