delete from party_code;
insert party_code(code_id, party_id, active_flag, create_date, create_user_id)
select code.id,  organization.party_id, code.active_flag, curdate(), 'system' from organization, code, code_type 
where code.code_type_id = code_type.id and code_type.application_level_indicator =0 and code_type.active_flag = 1 
and organization.organization_type =1 and code.active_flag = 1 and code.application_level_indicator = 1
--and organization.party_id = 343



