
-->> now, login password is getting encrypted (using ONE-WAY-HASHING, MD5PasswordEncoder). Value for "password" is 
UPDATE chiguru2.users SET password = '5f4dcc3b5aa765d61d8327deb882cf99';

// run this code to obtain the two coloumns below

ALTER TABLE chiguru2.users
 ADD users_key VARCHAR(255);



ALTER TABLE chiguru2.users
 ADD users_expiry_date TIMESTAMP NOT NULL;