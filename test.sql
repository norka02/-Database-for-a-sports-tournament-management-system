
DO $$
declare
  should_rollback boolean := false;
BEGIN
  RAISE NOTICE '---------';
  RAISE NOTICE 'Attempt to insert data that should be dependant on foreign keys';

  RAISE NOTICE 'Test trainers';
  
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

  RAISE NOTICE 'Test teams';

  begin
  insert into teams (name, trainer_id, team_id) values ('test', 1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test team_results';

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

  RAISE NOTICE 'Test system_logs';

  begin
  insert into system_logs (user_id, log_content, log_id) values (1, 'test', 1);
  raise notice 'Test #4 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #4 success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test competitors';

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

  RAISE NOTICE 'Test solo_results';

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

  RAISE NOTICE 'Test users';

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

  RAISE NOTICE 'Test organizers';

  begin
  insert into organizers (name, user_id, organizer_id) values ('test',1,1);
  raise notice 'Test #8 fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test #8 success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test tournaments';

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

  RAISE NOTICE 'Test participation';

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

  RAISE NOTICE '---------';

  RAISE NOTICE 'Attempt to violate uniqueness';

  RAISE NOTICE 'Test address_data';

  Begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  raise notice 'Test #1 fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test #1 success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test personal_data';

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

  RAISE NOTICE 'Test roles';

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

  RAISE NOTICE 'Test contact_details';

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

  RAISE NOTICE 'Test trainers';

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

  RAISE NOTICE 'Test users';

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

  RAISE NOTICE 'Test payment_statuses';


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

  RAISE NOTICE 'Test locations';

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

  RAISE NOTICE 'Test organizers';

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

  RAISE NOTICE 'Test teams';

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

  RAISE NOTICE 'Test system_logs';

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

  RAISE NOTICE 'Test payments';

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

  RAISE NOTICE 'Test tournament_types';

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

  RAISE NOTICE 'Test tournaments';

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

  RAISE NOTICE 'Test competitors';

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

  RAISE NOTICE 'Test competitor statuses';

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

  RAISE NOTICE 'Test team_results';

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

  RAISE NOTICE 'Test solo_results';

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

  RAISE NOTICE 'Test participation';

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

  RAISE NOTICE '---------';

  raise notice 'Test functions';

  RAISE NOTICE 'Test add_tournament';

  Begin
  perform add_tournament('1','1','1','1','2004-10-19 10:23:54+02','2004-10-19 10:23:54+02','1');
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  perform add_tournament('1','1','1','1','2004-10-19 10:23:54+02','2004-10-19 10:23:54+02','1');
  raise notice 'Test #2 success';
  should_rollback := true;
  exception when others then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test add_competitor';

  Begin
  perform add_competitor('1','1','11111111111',True,1,'111111111','2004-10-19','1','111','1','1',1,'1');
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_competitor('1','1','11111111111',True,1,'11111112','2004-10-19','1','111','2','1',1,'1');
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_competitor('1','1','11111111112',True,1,'111111111','2004-10-19','1','111','2','1',1,'1');
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_competitor('1','1','11111111112',True,1,'111111112','2004-10-19','1','111','11111111111','1',1,'1');
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_competitor('1','1','11111111112',True,1,'111111112','2004-10-19','1','111','11111111112','2',2,'2');
  perform c.competitor_id from competitors c where c.is_individual_player = True and c.birth_date = '2004-10-19' and c.nationality = '1' and team_id = 1;
  if not found then
  raise notice 'Test #2 fail';
  else
  raise notice 'Test #2 success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test add_trainer';

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  perform add_trainer('1','1','11111111111','111111111','111','1','1',1,'1');
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  perform add_trainer('1','1','11111111111','111111111','111','1','1',1,'1');
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  DECLARE
        _address_data_id INT;
        _contact_details_id INT;
        _personal_data_id INT;
  Begin
  perform add_trainer('1','1','11111111111','111111111','111','1','1',1,'1');
  SELECT ad.address_data_id INTO _address_data_id FROM address_data ad WHERE ad.city = '1'
                                                                               AND ad.house_number = 1
                                                                               AND ad.zip_code = '1';
  SELECT pd.personal_data_id INTO _personal_data_id FROM personal_data pd WHERE
            pd.pesel_number = '11111111111';
  SELECT cd.contact_details_id INTO _contact_details_id FROM contact_details cd WHERE cd.email = '1'
                                                                                    AND cd.phone_number = '111111111';
  perform t.trainer_id from trainers t where t.contact_details_id = _contact_details_id and t.address_data_id = _address_data_id and t.personal_data_id = _personal_data_id;
  if not found then
  raise notice 'Test #2 fail';
  else
  raise notice 'Test #2 success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test add_team';

  Begin
  perform add_team('1',1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  perform add_team('1',1);
  perform t.team_id from teams t where t.name = '1';
  if not found then
  raise notice 'Test #2 fail';
  else
  raise notice 'Test #2 success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test add_solo_result';

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  perform add_solo_result(1,1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  perform add_solo_result(1,1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  perform add_solo_result(1,1,1);
  perform t.result_id from solo_results t where t.tournament_id = 1 and t.competitor_id = 1;
  if not found then
  raise notice 'Test #2 fail';
  else
  raise notice 'Test #2 success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test add_team_result';

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  perform add_team_result(1,1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_team_result(1,1,1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_team_result(1,1,1);
  perform t.result_id from team_results t where t.tournament_id = 1 and t.team_id = 1;
  if not found then
  raise notice 'Test #2 fail';
  else
  raise notice 'Test #2 success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test delete_competitor';

  Begin
  perform delete_competitor(1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  perform delete_competitor(1);
  raise notice 'Test #2 success';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test delete_tournament';

  Begin
  perform delete_tournament(1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  perform delete_tournament(1);
  raise notice 'Test #2 success';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test delete_solo_result';

  Begin
  perform delete_solo_result(1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
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
  insert into solo_results (tournament_id, competitor_id, point_score, result_id) values (1,1,111,1);
  perform delete_solo_result(1);
  raise notice 'Test #2 success';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test delete_team_result';

  Begin
  perform delete_team_result(1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into team_results (tournament_id, team_id, point_score, result_id) values (1,1,111,1);
  perform delete_team_result(1);
  raise notice 'Test #2 success';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test delete_participation';

  Begin
  perform delete_participation(1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
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
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into participation (tournament_id, competitor_id, competitor_status_id, participation_id) values (1,1,1,1);
  perform delete_participation(1);
  raise notice 'Test #2 success';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE 'Test delete_trainer';

  Begin
  perform delete_trainer(1);
  raise notice 'Test #2 fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  perform delete_trainer(1);
  raise notice 'Test #2 success';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test triggers';

  RAISE NOTICE 'Test insert_new_payment_trigger';

  Begin
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
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into participation (tournament_id, competitor_id, competitor_status_id, participation_id) values (1,1,1,1);
  perform t.payment_id from payments t;
  if not found then
  raise notice 'Test #2 fail';
  else
  raise notice 'Test #2 success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test #2 fail';
  end;
  if should_rollback then rollback; end if;

END$$;