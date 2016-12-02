ALTER TABLE users
DROP COLUMN resetPassword


ALTER TABLE users
ADD users_key varchar(255)



ALTER TABLE users
ADD users_expiry_date timestamp



select password,users_key,users_expiry_date from users where username = "apoorvada@yahoo.com"