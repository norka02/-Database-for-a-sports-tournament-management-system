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
       -- set transaction isolation level serializable;
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



-- ADD COMPETITOR FUNCTION
CREATE OR REPLACE FUNCTION add_competitor(
        _first_name TEXT,
        _last_name TEXT,
        _pesel TEXT,
        _is_individual bool,
        _team_id INT,
        _phone_number TEXT,
        _birth_date DATE,
        _nationality TEXT,
        _area_code TEXT,
        _email TEXT,
        _city TEXT,
        _house_number int,
        _zip_code text
) RETURNS void AS $$
    DECLARE
        _address_data_id INT;
        _contact_details_id INT;
        _personal_data_id INT;
        _team_id INT;
    BEGIN
    -- check if team exists or this value is null
        SELECT t.team_id from teams t WHERE t.name = _team_id;
        IF FOUND THEN
            RAISE EXCEPTION 'Team with tha ID does not exist';
        end if;


    -- check if current user exists in DB
        SELECT pd.personal_data_id _personal_data_id FROM personal_data pd WHERE
            pd.pesel_number = _pesel FOR UPDATE LIMIT 1;
        IF FOUND THEN
            RAISE EXCEPTION 'User with this PESEL number already exists.';
        end if;

        SELECT cd.phone_number, cd.email FROM contact_details cd WHERE cd.phone_number = _phone_number OR
            cd.email = _email LIMIT 1 FOR UPDATE;
         IF FOUND THEN
            RAISE EXCEPTION 'User with this email or phone number already exists.';
        end if;


    -- insert competitor
        INSERT INTO contact_details (
                                     phone_number,
                                     area_code,
                                     email)
        VALUES (
                _phone_number,
                _area_code,
                _email
               );

        INSERT INTO personal_data (
                                   first_name,
                                   last_name,
                                   pesel_number)
        VALUES (
            _first_name,
            _last_name,
            _pesel
           );

        SELECT ad.address_data_id INTO _address_data_id FROM address_data ad WHERE ad.city = _city
                                                                               AND ad.house_number = _house_number
                                                                               AND ad.zip_code = _zip_code;

        IF NOT FOUND THEN
            INSERT INTO address_data (
                                      city,
                                      house_number,
                                      zip_code
            ) VALUES (
                    _city,
                    _house_number,
                    _zip_code
                             );
            SELECT ad.address_data_id INTO _address_data_id FROM address_data ad WHERE ad.city = _city
                                                                               AND ad.house_number = _house_number
                                                                               AND ad.zip_code = _zip_code;
        end if;



        SELECT pd.personal_data_id INTO _personal_data_id FROM personal_data pd WHERE
            pd.pesel_number = _pesel;

        SELECT cd.contact_details_id INTO _contact_details_id FROM contact_details cd WHERE cd.email = _email
                                                                                    AND cd.phone_number = _phone_number;


        INSERT INTO competitors (
                                 is_individual_player,
                                 birth_date,
                                 nationality,
                                 team_id,
                                 contact_details_id,
                                 address_data_id,
                                 personal_data_id
        ) VALUES (
                  _is_individual,
                  _birth_date,
                  _nationality,
                  _team_id,
                  _contact_details_id,
                  _address_data_id,
                  _personal_data_id
        );

        RAISE NOTICE 'Competitor has been added properly';

    end;
    $$ LANGUAGE plpgsql;




-- ADD TRAINER FUNCTION
CREATE OR REPLACE FUNCTION add_trainer(
        _first_name TEXT,
        _last_name TEXT,
        _pesel TEXT,
        _phone_number TEXT,
        _area_code TEXT,
        _email TEXT,
        _city TEXT,
        _house_number int,
        _zip_code text
    ) RETURNS void AS $$
    DECLARE
        _address_data_id INT;
        _contact_details_id INT;
        _personal_data_id INT;
    BEGIN
    -- check if current trainer exists in DB
        SELECT pd.personal_data_id _personal_data_id FROM personal_data pd WHERE
            pd.pesel_number = _pesel FOR UPDATE LIMIT 1;
        IF FOUND THEN
            RAISE EXCEPTION 'User with this PESEL number already exists.';
        end if;

        SELECT cd.phone_number, cd.email FROM contact_details cd WHERE cd.phone_number = _phone_number OR
            cd.email = _email LIMIT 1 FOR UPDATE;
         IF FOUND THEN
            RAISE EXCEPTION 'User with this email or phone number already exists.';
        end if;


    -- insert trainer
        INSERT INTO contact_details (
                                     phone_number,
                                     area_code,
                                     email)
        VALUES (
                _phone_number,
                _area_code,
                _email
               );

        INSERT INTO personal_data (
                                   first_name,
                                   last_name,
                                   pesel_number)
        VALUES (
            _first_name,
            _last_name,
            _pesel
           );

        SELECT ad.address_data_id INTO _address_data_id FROM address_data ad WHERE ad.city = _city
                                                                               AND ad.house_number = _house_number
                                                                               AND ad.zip_code = _zip_code;

        IF NOT FOUND THEN
            INSERT INTO address_data (
                                      city,
                                      house_number,
                                      zip_code
            ) VALUES (
                    _city,
                    _house_number,
                    _zip_code
                             );
            SELECT ad.address_data_id INTO _address_data_id FROM address_data ad WHERE ad.city = _city
                                                                               AND ad.house_number = _house_number
                                                                               AND ad.zip_code = _zip_code;
        end if;



        SELECT pd.personal_data_id INTO _personal_data_id FROM personal_data pd WHERE
            pd.pesel_number = _pesel;

        SELECT cd.contact_details_id INTO _contact_details_id FROM contact_details cd WHERE cd.email = _email
                                                                                    AND cd.phone_number = _phone_number;


        INSERT INTO trainers (
                                 contact_details_id,
                                 address_data_id,
                                 personal_data_id
        ) VALUES (
                  _contact_details_id,
                  _address_data_id,
                  _personal_data_id
        );

        RAISE NOTICE 'Trainer has been added properly';
    end;
    $$ LANGUAGE plpgsql;


-- ADD TEAM FUNCTION
CREATE OR REPLACE FUNCTION add_team(
    _name TEXT,
    _trainer_id INT
    ) RETURNS void AS $$
    BEGIN
    -- check if trainer exists
        SELECT trainers.trainer_id FROM trainers WHERE _trainer_id = trainers.trainer_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Trainer with that ID does not exist';
        end if;

    -- insert team
        INSERT INTO teams (
                           name,
                           trainer_id
        ) VALUES (
                  _name,
                  _trainer_id
                         );
    end;
    $$ LANGUAGE plpgsql;



-- ADD SOLO RESULTS FUNCTION
CREATE OR REPLACE FUNCTION add_solo_result(
    _tournament_id INT,
    _competitor_id INT,
    _solo_result NUMERIC
    ) RETURNS void AS $$
    BEGIN
    -- check if tournament id exists
        SELECT tournaments.tournament_id FROM tournaments WHERE tournaments.tournament_id = _tournament_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Tournament with that ID does not exist';
        end if;

    -- check if copetitor id exists
        SELECT competitors.competitor_id FROM competitors WHERE competitors.competitor_id = _competitor_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Competitor with that ID does not exist';
        end if;

    -- insert solo result
        INSERT INTO solo_results (
                                  tournament_id,
                                  competitor_id,
                                  point_score
        ) VALUES (
                  _tournament_id,
                  _competitor_id,
                  _solo_result
                         );

        RAISE NOTICE 'Solo resul has been added successfully';
    end;
    $$ LANGUAGE plpgsql;


-- ADD TEAM RESULTS FUNCTION
CREATE OR REPLACE FUNCTION add_solo_result(
    _tournament_id INT,
    _team_id INT,
    _team_result NUMERIC
    ) RETURNS void AS $$
    BEGIN
    -- check if tournament id exists
        SELECT tournaments.tournament_id FROM tournaments WHERE tournaments.tournament_id = _tournament_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Tournament with that ID does not exist';
        end if;

    -- check if team id exists
        SELECT team_id FROM teams WHERE team_id= _team_id;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Team with that ID does not exist';
        end if;

    -- insert solo result
        INSERT INTO team_results (
                                  tournament_id,
                                  team_id,
                                  point_score
        ) VALUES (
                  _tournament_id,
                  _team_id,
                  _team_result
                         );

        RAISE NOTICE 'Team resul has been added successfully';
    end;
    $$ LANGUAGE plpgsql;



-- FUNCTION CALLS
