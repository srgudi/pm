alter table person 
add column username varchar(255);

update person pers, party_relationship rel, users usr set pers.username = usr.username   
where rel.subject = pers.party_id
and usr.party_relationship_id = rel.id;

commit;