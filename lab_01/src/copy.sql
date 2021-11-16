copy footballer(first_name, last_name, country, age, salary, phone_number, average_rating) from '/Users/Shared/footballer.csv' delimiter ',' csv;
copy coach(first_name, last_name, country, age, salary, work_experience, phone_number, email) from '/Users/Shared/coach.csv' delimiter ',' csv;
copy club(name, country, city, email, foundation_date) from '/Users/Shared/club.csv' delimiter ',' csv;
copy footballer_coach_club(footballer_id, coach_id, club_id, number_goals) from '/Users/Shared/footballer_coach_club.csv' delimiter ',' csv;