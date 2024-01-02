-- ADD TOURNAMENT FUNCTION
CREATE OR REPLACE FUNCTION add_tournament(
    _tournament_type_name TEXT,
    _name TEXT,
    _location_name TEXT,
    _extra_location_info TEXT,
    _start_datetime TIMESTAMP WITH TIME ZONE,
    _end_datetime TIMESTAMP WITH TIME ZONE,
    _organizer_name TEXT
    ) RETURNS void AS $$
    DECLARE
        _location_id INT;
        _tournament_type_id INT;
        _organizer_id INT;
    BEGIN
    -- lock tables
        EXECUTE ' LOCK TABLE tournaments IN ACCESS EXCLUSIVE MODE';
        EXECUTE 'LOCK TABLE locations IN ACCESS EXCLUSIVE MODE';
        EXECUTE 'LOCK TABLE tournament_types IN ACCESS EXCLUSIVE MODE';
        EXECUTE 'LOCK TABLE participation IN SHARE ROW EXCLUSIVE MODE';
        EXECUTE 'LOCK TABLE solo_results IN SHARE ROW EXCLUSIVE MODE';
        EXECUTE ' LOCK TABLE team_results IN SHARE ROW EXCLUSIVE MODE';
        RAISE NOTICE 'TABLES WAS LOCKED PROPERLY. ADDING NEW DATA TO TABLE IS SAFE NOW';

    -- check if tournament type exists
        SELECT tt.type_id INTO _tournament_type_id FROM tournament_types tt WHERE UPPER(tt.name) = UPPER(_tournament_type_name) LIMIT 1;
        IF NOT FOUND THEN
            INSERT INTO tournament_types (name) VALUES (UPPER(_tournament_type_name));
            SELECT tt.type_id INTO _tournament_type_id FROM tournament_types tt WHERE UPPER(tt.name) = UPPER(_tournament_type_name) LIMIT 1;
            RAISE NOTICE 'ADDING NEW TOURNAMENT TYPE';
        end if;

    -- check if location exists
        SELECT l.location_id  INTO _location_id FROM locations l WHERE upper(l.location) = upper(_location_name) LIMIT 1;
        IF NOT FOUND THEN
            INSERT INTO locations (location, extra_info) VALUES (_location_name, _extra_location_info);
            SELECT l.location_id  INTO _location_id FROM locations l WHERE upper(l.location) = upper(_location_name) LIMIT 1;
            RAISE NOTICE 'ADDING NEW LOCATION';
        end if;

    -- check if organizer exists
        SELECT o.organizer_id  INTO _organizer_id FROM organizers o WHERE upper(o.name) = upper(_organizer_name) LIMIT 1;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'This organizer does not exist in database';
        end if;

    -- insert tournaments table
        INSERT INTO tournaments (
            tournament_type_id,
            name,
            location_id,
            start_datetime,
            end_datetime,
            organizer_id
        ) VALUES (
            _tournament_type_id,
            _name,
            _location_id,
            _start_datetime,
            _end_datetime,
            _organizer_id
        );
        RAISE NOTICE 'ADDING NEW TOURNAMENT';
    end;
    $$ LANGUAGE plpgsql;



-- FUNCTION CALLS
