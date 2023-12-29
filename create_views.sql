-- CREATING VIEWS


-- SHOW TOURNAMENTS INFO FOR DEFAULT USER
CREATE OR REPLACE VIEW public_tournament_info AS
    SELECT
        t.tournament_id AS "Tournament ID",
        tt.name AS "Tournament type",
        t.name AS "Tournament name",
        l.location AS "Tournament location",
        l.extra_info AS "Additional location info",
        t.start_datetime AS "Tournament starts",
        t.end_datetime AS "Tournament ends",
        o.name AS "Organizer name"
    FROM public.tournaments t
    INNER JOIN public.tournament_types tt on tt.type_id = t.tournament_type_id
    INNER JOIN public.locations l on t.location_id = l.location_id
    INNER JOIN public.organizers o on o.organizer_id = t.organizer_id;


-- SHOW COMPETITORS AND TOURNAMENTS FOR DEFAULT USER
CREATE OR REPLACE VIEW public_competitors_info AS
    SELECT
        p.participation_id,
        c.competitor_id AS "Competitor ID",
        pd.first_name,
        pd.last_name,
        ad.city,
        cs.status,
        t2.tournament_id,
        t2.name AS "Tournament name",
        c.is_individual_player AS "IS individual player",
        c.team_id AS "Team ID",
        t.name AS "Team name",
        c.birth_date AS "Birth date",
        c.nationality AS "Nationality"
    FROM participation p
    INNER JOIN public.competitors c on c.competitor_id = p.competitor_id
    INNER JOIN public.competitor_statuses cs on cs.status_id = p.competitor_status_id
    INNER JOIN public.personal_data pd on pd.personal_data_id = c.personal_data_id
    INNER JOIN public.address_data ad on ad.address_data_id = c.address_data_id
    LEFT JOIN public.teams t on t.team_id = c.team_id
    INNER JOIN public.tournaments t2 on t2.tournament_id = p.tournament_id;



-- SHOW TEAMS FOR DEFAULT USER
CREATE OR REPLACE VIEW public_teams_info AS
    SELECT
        t.team_id,
        t.name AS "Team name",
        t2.trainer_id,
        pd.first_name,
        pd.last_name,
        ad.city
    FROM teams t
    INNER JOIN public.trainers t2 on t2.trainer_id = t.trainer_id
    INNER JOIN public.personal_data pd on pd.personal_data_id = t2.personal_data_id
    INNER JOIN public.address_data ad on ad.address_data_id = t2.address_data_id;


-- SHOW SOLO RESULTS FOR DEFAULT USER
CREATE OR REPLACE VIEW solo_results_info AS
    SELECT
        sr.result_id,
        sr.competitor_id,
        pd.first_name,
        pd.last_name,
        sr.tournament_id,
        t.name AS "Tournament name",
        sr.point_score
    FROM solo_results sr
    INNER JOIN public.competitors c on c.competitor_id = sr.competitor_id
    INNER JOIN public.personal_data pd on pd.personal_data_id = c.personal_data_id
    INNER JOIN public.tournaments t on t.tournament_id = sr.tournament_id;


-- SHOW TEAM RESULTS FOR DEFAULT USER
CREATE OR REPLACE VIEW team_results_info AS
    SELECT
        tr.result_id,
        tr.tournament_id,
        t.name AS "Tournament name",
        tr.team_id,
        t2.name AS "Team name",
        tr.point_score
    FROM team_results tr
    INNER JOIN public.tournaments t on t.tournament_id = tr.tournament_id
    INNER JOIN public.teams t2 on t2.team_id = tr.team_id;


