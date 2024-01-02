CREATE TABLE payment_statuses (
    status_id SERIAL PRIMARY KEY,
    status text UNIQUE NOT NULL
);

CREATE TABLE tournament_types (
  type_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL DEFAULT 'Other' UNIQUE
);

CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    location text NOT NULL UNIQUE,
    extra_info text DEFAULT ''
);

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    name text NOT NULL DEFAULT 'Normal user' UNIQUE,
    rights text DEFAULT NULL
);

CREATE TABLE contact_details (
    contact_details_id SERIAL PRIMARY KEY,
    phone_number text NOT NULL UNIQUE,
    area_code text DEFAULT '+48',
    email text NOT NULL UNIQUE,
    CHECK ( char_length(area_code) = 3 ),
    CHECK ( char_length(phone_number) = 9 )
);

CREATE TABLE address_data (
    address_data_id SERIAL PRIMARY KEY,
    city text NOT NULL,
    house_number int4,
    zip_code text
);

CREATE TABLE personal_data (
    personal_data_id SERIAL PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    pesel_number text UNIQUE,
    CHECK (char_length(pesel_number) = 11)
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name text NOT NULL UNIQUE,
    role_id int4,
    contact_details_id int4,
    address_data_id int4,
    personal_data_id int4,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
        ON UPDATE CASCADE ON DELETE SET NULL DEFERRABLE,
    FOREIGN KEY (contact_details_id) REFERENCES contact_details(contact_details_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (address_data_id) REFERENCES address_data(address_data_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);

CREATE TABLE system_logs (
    log_id SERIAL PRIMARY KEY,
    user_id int4,
    log_content text,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE SET NULL DEFERRABLE
);


CREATE TABLE organizers (
    organizer_id SERIAL PRIMARY KEY,
    name text NOT NULL UNIQUE,
    user_id int4,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);



CREATE TABLE tournaments (
    tournament_id SERIAL PRIMARY KEY,
    tournament_type_id int4,
    name TEXT NOT NULL,
    location_id int4,
    start_datetime TIMESTAMP WITH TIME ZONE NOT NULL,
    end_datetime TIMESTAMP WITH TIME ZONE NOT NULL,
    organizer_id int4,
    FOREIGN KEY (tournament_type_id) REFERENCES tournament_types(type_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (organizer_id) REFERENCES organizers(organizer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);



CREATE TABLE trainers (
    trainer_id SERIAL PRIMARY KEY,
    contact_details_id int4,
    address_data_id int4,
    personal_data_id int4,
    FOREIGN KEY (contact_details_id) REFERENCES contact_details(contact_details_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (address_data_id) REFERENCES address_data(address_data_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);

CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    name text NOT NULL UNIQUE,
    trainer_id int4,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);

CREATE TABLE team_results (
    result_id SERIAL PRIMARY KEY,
    tournament_id int4,
    team_id int4,
    point_score NUMERIC(7, 3),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);

CREATE TABLE competitor_statuses (
    status_id SERIAL PRIMARY KEY,
    status text NOT NULL UNIQUE
);

CREATE TABLE competitors (
    competitor_id SERIAL PRIMARY KEY,
    is_individual_player boolean NOT NULL,
    birth_date date NOT NULL ,
    nationality text NOT NULL ,
    team_id int4,
    contact_details_id int4,
    address_data_id int4,
    personal_data_id int4,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
        ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE,
    FOREIGN KEY (contact_details_id) REFERENCES contact_details(contact_details_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (address_data_id) REFERENCES address_data(address_data_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (personal_data_id) REFERENCES personal_data(personal_data_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);

CREATE TABLE solo_results (
    result_id SERIAL PRIMARY KEY,
    tournament_id int4,
    competitor_id int4,
    point_score NUMERIC(7, 3),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (competitor_id) REFERENCES competitors(competitor_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);

CREATE TABLE participation (
    participation_id SERIAL PRIMARY KEY,
    tournament_id int4,
    competitor_id int4,
    competitor_status_id int4,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (competitor_id) REFERENCES competitors(competitor_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (competitor_status_id) REFERENCES competitor_statuses(status_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    user_id int4,
    amount NUMERIC(8, 2) NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT current_timestamp,
    status_id int4,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE,
    FOREIGN KEY (status_id) REFERENCES payment_statuses(status_id)
        ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE
);



