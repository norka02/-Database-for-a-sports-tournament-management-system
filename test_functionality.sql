-- one transaction for easy rollback
DO $$
BEGIN
  RAISE NOTICE '---------';
  RAISE NOTICE 'Create fake records (with utility functions)';
  RAISE NOTICE '---------';
  declare temp_key int;
  temp_key_2 int;
  begin
  insert into organizers (name) values ('Jon Arbuckle');
  insert into organizers (name) values ('CIA');
  insert into organizers (name) values ('Queen Elizabeth');
  insert into organizers (name) values ('John Cena');
  insert into organizers (name) values ('FIFA');
  perform add_tournament('tennis','Wimbledon Open 2015','Manchester National Stadium','UK','2004-10-19 10:23:54+02','2004-10-21 10:23:54+02','Jon Arbuckle');
  perform add_tournament('tennis','Wimbledon Open 2016','Manchester National Stadium','UK','2005-10-19 10:23:54+02','2005-10-21 10:23:54+02','CIA');
  perform add_tournament('soccer','North Korean Championship','Shenzen Stadium','Australia, 3rd prefecture','2006-10-19 10:23:54+02','2006-10-21 10:23:54+02','Queen Elizabeth');
  perform add_tournament('football','Antarctica National Cup','Rio De Janeiro El Casa Stadium','Paris, France','2007-10-19 10:23:54+02','2007-10-21 10:23:54+02','John Cena');
  perform add_tournament('handball','SuperBowl 2013','Ontario Stadium','East Kazachstan','2008-10-19 10:23:54+02','2008-10-21 10:23:54+02','CIA');
  perform add_trainer('Diana','Marianna','12345678901','123456789','+48','di.ma@mail.com','London','15','14-144');
  perform add_trainer('Dieter','Jooa','23456789012','234567891','+48','di.jo@mail.com','London','16','14-144');
  
  insert into payment_statuses (status, status_id) values ('default', 1);

  select res.trainer_id from (select trainer_id, first_name from trainers inner join personal_data on trainers.personal_data_id = personal_data.personal_data_id) as res where res.first_name = 'Diana' into temp_key;
  perform add_team('High Aces',temp_key);
  
  select team_id from teams where name = 'High Aces' into temp_key;
  select tournament_id from tournaments where name = 'Wimbledon Open 2015' into temp_key_2;
  perform add_team_result(temp_key_2,temp_key,'15');
  select tournament_id from tournaments where name = 'Wimbledon Open 2016' into temp_key_2;
  perform add_team_result(temp_key_2,temp_key,'21');
  
  perform add_competitor('Aline','Linde','34567890123',false,temp_key,'345678901','2000-10-19','NA','+48','al.li@mail.com','London','17','14-144');
  select res.competitor_id from (select competitor_id, first_name from competitors inner join personal_data on competitors.personal_data_id = personal_data.personal_data_id) as res where res.first_name = 'Aline' into temp_key;
  select tournament_id from tournaments where name = 'Wimbledon Open 2015' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'11');
  perform add_participant(temp_key_2,temp_key,'Active');
  select tournament_id from tournaments where name = 'Wimbledon Open 2016' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'12');
  perform add_participant(temp_key_2,temp_key,'Active');

  select team_id from teams where name = 'High Aces' into temp_key;
  perform add_competitor('Corrado','Joakim','45678901234',false,temp_key,'456789012','2000-10-19','NA','+48','co.jo@mail.com','London','18','14-144');
  select res.competitor_id from (select competitor_id, first_name from competitors inner join personal_data on competitors.personal_data_id = personal_data.personal_data_id) as res where res.first_name = 'Corrado' into temp_key;
  select tournament_id from tournaments where name = 'Wimbledon Open 2015' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'81');
  perform add_participant(temp_key_2,temp_key,'Active');
  select tournament_id from tournaments where name = 'Wimbledon Open 2016' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'73');
  perform add_participant(temp_key_2,temp_key,'Active');
  
  
  select res.trainer_id from (select trainer_id, first_name from trainers inner join personal_data on trainers.personal_data_id = personal_data.personal_data_id) as res where res.first_name = 'Dieter' into temp_key;
  perform add_team('Low Fives',temp_key);
  
  select team_id from teams where name = 'Low Fives' into temp_key;
  select tournament_id from tournaments where name = 'Wimbledon Open 2015' into temp_key_2;
  perform add_team_result(temp_key_2,temp_key,'41');
  select tournament_id from tournaments where name = 'Wimbledon Open 2016' into temp_key_2;
  perform add_team_result(temp_key_2,temp_key,'19');
  
  perform add_competitor('Ganedr','Mahendra','56789012345',false,temp_key,'567890123','2000-10-19','NA','+48','ga.ma@mail.com','London','19','14-144');
  select res.competitor_id from (select competitor_id, first_name from competitors inner join personal_data on competitors.personal_data_id = personal_data.personal_data_id) as res where res.first_name = 'Ganedr' into temp_key;
  select tournament_id from tournaments where name = 'Wimbledon Open 2015' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'89');
  perform add_participant(temp_key_2,temp_key,'Active');
  select tournament_id from tournaments where name = 'Wimbledon Open 2016' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'88');
  perform add_participant(temp_key_2,temp_key,'Active');

  select team_id from teams where name = 'Low Fives' into temp_key;
  perform add_competitor('Lazaro','Janne','67890123456',false,temp_key,'678901234','2000-10-19','NA','+48','la.ja@mail.com','London','20','14-144');
  select res.competitor_id from (select competitor_id, first_name from competitors inner join personal_data on competitors.personal_data_id = personal_data.personal_data_id) as res where res.first_name = 'Lazaro' into temp_key;
  select tournament_id from tournaments where name = 'Wimbledon Open 2015' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'19');
  perform add_participant(temp_key_2,temp_key,'Active');
  select tournament_id from tournaments where name = 'Wimbledon Open 2016' into temp_key_2;
  perform add_solo_result(temp_key_2,temp_key,'27');
  perform add_participant(temp_key_2,temp_key,'Active');
  
  
  end;
  RAISE NOTICE '---------';
  RAISE NOTICE 'Query views/database';
  RAISE NOTICE '---------';
  declare result_row record;
  begin
  RAISE NOTICE '- public_tournament_info';
  FOR result_row IN SELECT * FROM public_tournament_info LOOP
  -- Print each row to the output
  RAISE NOTICE '%',  result_row;
  END LOOP;
  RAISE NOTICE '---------';
  RAISE NOTICE '- public_competitors_info';
  FOR result_row IN SELECT * FROM public_competitors_info LOOP
  -- Print each row to the output
  RAISE NOTICE '%',  result_row;
  END LOOP;
  RAISE NOTICE '---------';
  RAISE NOTICE '- public_teams_info';
  FOR result_row IN SELECT * FROM public_teams_info LOOP
  -- Print each row to the output
  RAISE NOTICE '%',  result_row;
  END LOOP;
  RAISE NOTICE '---------';
  RAISE NOTICE '- solo_results_info';
  FOR result_row IN SELECT * FROM solo_results_info LOOP
  -- Print each row to the output
  RAISE NOTICE '%',  result_row;
  END LOOP;
  RAISE NOTICE '---------';
  RAISE NOTICE '- team_results_info';
  FOR result_row IN SELECT * FROM team_results_info LOOP
  -- Print each row to the output
  RAISE NOTICE '%',  result_row;
  END LOOP;
  RAISE NOTICE '---------';
  end;
  
  RAISE NOTICE 'Delete fake records (with utility functions)';



  rollback;
END$$;