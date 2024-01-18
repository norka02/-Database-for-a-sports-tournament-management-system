
DO $$
declare
  should_rollback boolean := false;
BEGIN
  RAISE NOTICE '---------';
  RAISE NOTICE 'Attempt to insert data that should be dependant on foreign keys';

  RAISE NOTICE '- Test trainers';
  
  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  raise notice 'Test personal_data_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test personal_data_id success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  raise notice 'Test address_data_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test address_data_id success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  raise notice 'Test contact_details_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test contact_details_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test teams';

  begin
  insert into teams (name, trainer_id, team_id) values ('test', 1,1);
  raise notice 'Test trainer_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test trainer_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test team_results';

  begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into team_results (tournament_id, team_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test team_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test team_id success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into team_results (tournament_id, team_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test tournament_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test tournament_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test system_logs';

  begin
  insert into system_logs (user_id, log_content, log_id) values (1, 'test', 1);
  raise notice 'Test user_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test user_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test competitors';

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,1,1);
  raise notice 'Test team_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test team_id success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,1,2,1);
  raise notice 'Test personal_data_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test personal_data_id success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  insert into competitors (is_individual_player, birth_date, nationality, team_id, contact_details_id, personal_data_id, competitor_id) values (true,'2004-10-19','1',1,2,1,1);
  raise notice 'Test contact_details_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test contact_details_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test solo_results';

  begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  insert into solo_results (tournament_id, competitor_id, point_score, result_id) values (1,1,111,1);
  raise notice 'Test competitor_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test competitor_id success';
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
  raise notice 'Test tournament_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test tournament_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test users';

  begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test contact_details_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test contact_details_id success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test address_data_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test address_data_id success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test personal_data_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test personal_data_id success';
  end;
  if should_rollback then rollback; end if;

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into users (name, role_id, contact_details_id, address_data_id, personal_data_id, user_id) values ('1',1,1,1,1,1);
  raise notice 'Test role_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test role_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test organizers';

  begin
  insert into organizers (name, user_id, organizer_id) values ('test',1,1);
  raise notice 'Test user_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test user_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test tournaments';

  begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  raise notice 'Test tournament_type_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test tournament_type_id success';
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
  raise notice 'Test location_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test location_id success';
  end; 
  if should_rollback then rollback; end if;

  begin
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into tournaments (tournament_type_id, name, location_id, start_datetime, end_datetime,organizer_id,tournament_id) values (1,'1',1, '2004-10-19 10:23:54+02','2004-10-19 10:23:54+02',1,1);
  raise notice 'Test organizer_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test organizer_id success';
  end; 
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test participation';

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
  raise notice 'Test competitor_status_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test competitor_status_id success';
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
  raise notice 'Test tournament_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test tournament_id success';
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
  raise notice 'Test competitor_id fail';
  should_rollback := true;
  exception when foreign_key_violation then RAISE notice 'Test competitor_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Attempt to violate uniqueness';

  RAISE NOTICE '- Test address_data';

  Begin
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  raise notice 'Test address_data_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test address_data_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test personal_data';

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',1);
  raise notice 'Test personal_data_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test personal_data_id success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',2);
  raise notice 'Test pesel_number fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test pesel_number success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test roles';

  Begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('2','1',1);
  raise notice 'Test role_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test role_id success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into roles (name, rights, role_id) values ('1','1',2);
  raise notice 'Test name fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test name success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test contact_details';

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111112',2);
  raise notice 'Test phone_number fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test phone_number success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111111',2);
  raise notice 'Test email fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test email success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',1);
  raise notice 'Test contact_details_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test contact_details_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test trainers';

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111112','111','11111111112',2);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',2);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111112',2);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (2,2,2,1);
  raise notice 'Test trainer_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test trainer_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test users';

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
  raise notice 'Test user_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test user_id success';
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
  raise notice 'Test name fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test name success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test payment_statuses';

  Begin
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into payment_statuses (status, status_id) values ('2',1);
  raise notice 'Test status_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test status_id success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into payment_statuses (status, status_id) values ('1',1);
  insert into payment_statuses (status, status_id) values ('1',2);
  raise notice 'Test status fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test status success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test locations';

  Begin
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('1','1',2);
  raise notice 'Test location fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test location success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into locations (location, extra_info, location_id) values ('1','1',1);
  insert into locations (location, extra_info, location_id) values ('2','1',1);
  raise notice 'Test location_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test location_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test organizers';

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
  raise notice 'Test organizer_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test organizer_id success';
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
  raise notice 'Test name fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test name success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test teams';

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
  raise notice 'Test name fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test name success';
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
  raise notice 'Test team_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test team_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test system_logs';

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
  raise notice 'Test log_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test log_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test payments';

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
  raise notice 'Test payment_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test payment_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test tournament_types';

  Begin
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111112',1);
  raise notice 'Test type_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test type_id success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into tournament_types (name, type_id) values ('111111111',1);
  insert into tournament_types (name, type_id) values ('111111111',2);
  raise notice 'Test name fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test name success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test tournaments';

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
  raise notice 'Test tournament_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test tournament_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test competitors';

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
  raise notice 'Test competitor_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test competitor_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test competitor_statuses';

  Begin
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into competitor_statuses (status, status_id) values ('2',1);
  raise notice 'Test status_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test status_id success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into competitor_statuses (status, status_id) values ('1',1);
  insert into competitor_statuses (status, status_id) values ('1',2);
  raise notice 'Test status fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test status success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test team_results';

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
  raise notice 'Test result_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test result_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test solo_results';

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
  raise notice 'Test result_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test result_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test participation';

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
  raise notice 'Test participation_id fail';
  should_rollback := true;
  exception when unique_violation then RAISE notice 'Test participation_id success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  raise notice 'Test functions';

  RAISE NOTICE '- Test add_tournament';

  Begin
  perform add_tournament('1','1','1','1','2004-10-19 10:23:54+02','2004-10-19 10:23:54+02','1');
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into roles (name, rights, role_id) values ('1','1',1);
  insert into users (name, role_id, contact_details_id, address_data_id, user_id) values ('1',1,1,1,1);
  insert into organizers (name, user_id, organizer_id) values ('1',1,1);
  perform add_tournament('1','1','1','1','2004-10-19 10:23:54+02','2004-10-19 10:23:54+02','1');
  raise notice 'Test proper usage success';
  should_rollback := true;
  exception when others then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test add_competitor';

  Begin
  perform add_competitor('1','1','11111111111',True,1,'111111111','2004-10-19','1','111','1','1',1,'1');
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_competitor('1','1','11111111111',True,1,'11111112','2004-10-19','1','111','2','1',1,'1');
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_competitor('1','1','11111111112',True,1,'111111111','2004-10-19','1','111','2','1',1,'1');
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_competitor('1','1','11111111112',True,1,'111111112','2004-10-19','1','111','11111111111','1',1,'1');
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test add_trainer';

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  perform add_trainer('1','1','11111111111','111111111','111','1','1',1,'1');
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  perform add_trainer('1','1','11111111111','111111111','111','1','1',1,'1');
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test add_team';

  Begin
  perform add_team('1',1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test add_solo_result';

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
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test add_team_result';

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
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  insert into teams (name, trainer_id, team_id) values ('1',1,1);
  perform add_team_result(1,1,1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test delete_competitor';

  Begin
  perform delete_competitor(1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  perform competitor_id from competitors;
  if found then
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test delete_tournament';

  Begin
  perform delete_tournament(1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  perform tournament_id from tournaments;
  if found then
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test delete_solo_result';

  Begin
  perform delete_solo_result(1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  perform result_id from solo_results;
  if found then
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test delete_team_result';

  Begin
  perform delete_team_result(1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  perform result_id from team_results;
  if found then
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test delete_participation';

  Begin
  perform delete_participation(1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
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
  perform participation_id from participation;
  if found then
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test delete_trainer';

  Begin
  perform delete_trainer(1);
  raise notice 'Test exception handling fail';
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test exception handling success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('111111111','111','11111111111',1);
  insert into address_data (city, house_number, zip_code, address_data_id) values ('1',1,'1',1);
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1','1','11111111111',1);
  insert into trainers (contact_details_id, address_data_id, personal_data_id, trainer_id) values (1,1,1,1);
  perform delete_trainer(1);
  perform trainer_id from trainers;
  if found then
  raise notice 'Test proper usage fail';
  else
  raise notice 'Test proper usage success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test triggers';

  RAISE NOTICE '- Test insert_new_payment_trigger';

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
  raise notice 'Test run trigger properly fail';
  else
  raise notice 'Test run trigger properly success';
  end if;
  should_rollback := true;
  exception when raise_exception then RAISE notice 'Test run trigger properly fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test check constraints';

  RAISE NOTICE '- Test personal_data pesel_number';

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1', '1', '1234567890', 1);
  raise notice 'Test check #1 fail';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test check #1 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1', '1', '123456789012', 1);
  raise notice 'Test check #2 fail';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test check #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into personal_data (first_name, last_name, pesel_number, personal_data_id) values ('1', '1', '12345678901', 1);
  raise notice 'Test proper usage success';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;
  
  RAISE NOTICE '- Test contact_details area_code';

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('123456789', '12', '111', 1);
  raise notice 'Test check #1 fail';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test check #1 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('123456789', '1234', '111', 1);
  raise notice 'Test check #2 fail';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test check #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('123456789', '123', '111', 1);
  raise notice 'Test proper usage success';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '- Test contact_details phone_number';

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('12345678', '123', '111', 1);
  raise notice 'Test check #1 fail';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test check #1 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('1234567890', '123', '111', 1);
  raise notice 'Test check #2 fail';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test check #2 success';
  end;
  if should_rollback then rollback; end if;

  Begin
  insert into contact_details (phone_number, area_code, email, contact_details_id) values ('123456789', '123', '111', 1);
  raise notice 'Test proper usage success';
  should_rollback := true;
  exception when check_violation then RAISE notice 'Test proper usage fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test minimum non-null entry creation';

  raise notice '- Test address_data';

  begin
  insert into address_data (city) values ('1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test personal_data';

  begin
  insert into personal_data (first_name, last_name) values ('1','1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test contact_details';

  begin
  insert into contact_details (phone_number, email) values ('123456789','1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test roles';

  begin
  insert into roles default values;
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test trainers';

  begin
  insert into trainers default values;
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test users';

  begin
  insert into users (name) values ('1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test payment_statuses';

  begin
  insert into payment_statuses (status) values ('1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test locations';

  begin
  insert into locations (location) values ('1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test organizers';

  begin
  insert into organizers (name) values ('1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test teams';

  begin
  insert into teams (name) values ('1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test system_logs';

  begin
  insert into system_logs default values;
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test payments';

  begin
  insert into payments (amount) values (11);
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test tournament_types';

  begin
  insert into tournament_types default values;
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test tournaments';

  begin
  insert into tournaments (name, start_datetime, end_datetime) values ('1','2004-10-19 10:23:54+02','2004-10-19 10:23:54+02');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test competitors';

  begin
  insert into competitors (is_individual_player, birth_date, nationality) values (True,'2004-10-19','111');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test competitor_statuses';

  begin
  insert into competitor_statuses (status) values ('1');
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test team_results';

  begin
  insert into team_results default values;
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test solo_results';

  begin
  insert into solo_results default values;
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test participation';

  begin
  insert into payment_statuses (status,status_id) values ('1',1); -- necessary for trigger
  insert into participation default values;
  raise notice 'Test success';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test null entry creation prevention (where applicabble)';

  raise notice '- Test address_data';

  begin
  insert into address_data default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test personal_data';

  begin
  insert into personal_data default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test contact_details';

  begin
  insert into contact_details default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test users';

  begin
  insert into users default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test payment_statuses';

  begin
  insert into payment_statuses default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test locations';

  begin
  insert into locations default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test organizers';

  begin
  insert into organizers default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test teams';

  begin
  insert into teams default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test payments';

  begin
  insert into payments default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test tournaments';

  begin
  insert into tournaments default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test competitors';

  begin
  insert into competitors default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test competitor_statuses';

  begin
  insert into competitor_statuses default values;
  raise notice 'Test fail';
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test success';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test that default (non-key) values are created';

  raise notice '- Test contact_details';

  declare temp text;
  begin
  insert into contact_details (phone_number, email, contact_details_id) values ('123456789','1', 1);
  SELECT area_code from contact_details where contact_details_id=1 into temp;
  if temp is not null then
  raise notice 'Test success';
  else
  raise notice 'Test fail';
  end if;
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test roles';

  declare temp text;
  begin
  insert into roles (role_id) values (1);
  SELECT name from roles where role_id=1 into temp;
  if temp is not null then
  raise notice 'Test success';
  else
  raise notice 'Test fail';
  end if;
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test locations';

  declare temp text;
  begin
  insert into locations (location_id, location) values (1,'1');
  SELECT extra_info from locations where location_id=1 into temp;
  if temp is not null then
  raise notice 'Test success';
  else
  raise notice 'Test fail';
  end if;
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test payments';

  declare temp text;
  begin
  insert into payments (amount, payment_id) values (1,1);
  SELECT payment_date from payments where payment_id=1 into temp;
  if temp is not null then
  raise notice 'Test success';
  else
  raise notice 'Test fail';
  end if;
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  raise notice '- Test tournament_types';

  declare temp text;
  begin
  insert into tournament_types (type_id) values (1);
  SELECT name from tournament_types where type_id=1 into temp;
  if temp is not null then
  raise notice 'Test success';
  else
  raise notice 'Test fail';
  end if;
  should_rollback := true;
  exception when not_null_violation then raise notice 'Test fail';
  end;
  if should_rollback then rollback; end if;

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test restricts/cascades on key updates';

  RAISE NOTICE '---------';

  RAISE NOTICE 'Test restricts/cascades on key deletes';

END$$;