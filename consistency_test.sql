
DO $$
declare
  should_rollback boolean := false;
BEGIN
  RAISE NOTICE 'Attempt to insert data that should be dependant on foreign keys';
  
  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  raise notice 'Test #1 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #1 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  raise notice 'Test #1 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #1 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  raise notice 'Test #1 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #1 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into teams (name, trainer_id, team_id) values ('test', 1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into team_results (tournament_id, team_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test #3 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #3 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into team_results (tournament_id, team_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test #3 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #3 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into system_logs (user_id, log_content, log_id) values (1, 'test', 1);
  raise notice 'Test #4 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #4 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  raise notice 'Test #5 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #5 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  raise notice 'Test #5 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #5 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  raise notice 'Test #5 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #5 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  raise notice 'Test #5 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #5 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into solo_results (tournament_id, competitor_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test #6 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #6 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  insert into solo_results (tournament_id, competitor_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test #6 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #6 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test #7 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #7 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test #7 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #7 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test #7 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #7 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test #7 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #7 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into organizers (name, user_id, organizer_id) values ('test',1,1);
  raise notice 'Test #8 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #8 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  raise notice 'Test #9 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #9 success';
  end; 
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  raise notice 'Test #9 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #9 success';
  end; 
  if should_rollback then rollback; end if;

  begin
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  raise notice 'Test #9 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #9 success';
  end; 
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into participation (tournament_id, competitor_id, competitor_status_id, participation_id) values (1,1,1,1);
  raise notice 'Test #10 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #10 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into participation (tournament_id, competitor_id, competitor_status_id, participation_id) values (1,1,1,1);
  raise notice 'Test #10 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #10 success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into participation (tournament_id, competitor_id, competitor_status_id, participation_id) values (1,1,1,1);
  raise notice 'Test #10 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #10 success';
  end;
  if should_rollback then rollback; end if;


  RAISE NOTICE 'Attempt to override uniqueness';

  Begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  raise notice 'Test #1 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #1 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',2);
  raise notice 'Test #3 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #3 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',1);
  raise notice 'Test #4 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #4 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('1','1',2);
  raise notice 'Test #5 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #5 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111112',2);
  raise notice 'Test #6 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #6 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111111',2);
  raise notice 'Test #6 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #6 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',1);
  raise notice 'Test #6 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #6 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('2',1,1,1,1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,2);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;


  Begin
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into payment_statuses (status, status_id) values ('2',1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into payment_statuses (status, status_id) values ('1',2);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('1','1',2);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('2','1',1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into organizers (name, user_id, organizer_id) values ('2',2,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;
  
  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',2,2);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,2);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into teams (name, trainer_id, team_id) values ('1',2,2);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,2);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into teams (name, trainer_id, team_id) values ('2',2,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into system_logs (user_id, log_content, log_id) values (1,'1',1);
  insert into system_logs (user_id, log_content, log_id) values (2,'1',1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into payment_statuses (status, status_id) values ('2',2);
  insert into payments (user_id, amount, payment_date, status_id, payment_id) values (1,100.1,'2004-10-19 10:23:54+02',1,1);
  insert into payments (user_id, amount, payment_date, status_id, payment_id) values (2,100.1,'2004-10-19 10:23:54+02',2,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111112',1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111111',2);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into organizers (name, user_id, organizer_id) values ('2',2,2);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111112',2);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('2','1',2);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',2, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,2);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into teams (name, trainer_id, team_id) values ('2',2,2);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into competitor_statuses (status, status_id) values ('2',1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into competitor_statuses (status, status_id) values ('1',2);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,2);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into teams (name, trainer_id, team_id) values ('2',2,2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into organizers (name, user_id, organizer_id) values ('2',2,2);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111112',2);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('2','1',2);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',2, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,2);
  insert into team_results (tournament_id, team_id, point_score, result_id) values (1,1,111,1);
  insert into team_results (tournament_id, team_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,2);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into teams (name, trainer_id, team_id) values ('2',2,2);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into organizers (name, user_id, organizer_id) values ('2',2,2);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111112',2);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('2','1',2);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',2, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,2);
  insert into solo_results (tournament_id, competitor_id, point_score, result_id) values (1,1,111,1);
  insert into solo_results (tournament_id, competitor_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,2);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into teams (name, trainer_id, team_id) values ('2',2,2);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,2);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',2);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('2',1,1,1,2);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into organizers (name, user_id, organizer_id) values ('2',2,2);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111112',2);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('2','1',2);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',2, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,2);
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into competitor_statuses (status, status_id) values ('2',2);
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into participation (tournament_id, competitor_id, competitor_status_id, participation_id) values (1,1,1,1);
  insert into participation (tournament_id, competitor_id, competitor_status_id, participation_id) values (2,2,2,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

END$$;