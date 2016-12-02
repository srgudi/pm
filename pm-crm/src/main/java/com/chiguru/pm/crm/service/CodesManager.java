package com.chiguru.pm.crm.service;

import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.KeyValue;

import java.util.List;
import java.util.Map;
import java.util.Set;


public interface CodesManager {
    public Map<CodeType, Set<Code>> getApplicationLevelCodeMap();

    public Map<CodeType, List<Code>> getPartyLevelCodeMap(Long partyId);

    public Code getCodeById(Long id);

    public List<CodeType> getApplicationLevelCodeType();

    public CodeType getCodeTypeById(Long id);

    public List<Code> getCodesByCodeType(Long codeTypeId);

    public void createCode(Code code);

    // sagar
    public Long getParentCodeTypeIdById(Long codeTypeId);

    public List<Code> getRelatedCodeByCodeTypeId(Long parentCodeTypeId);

    public List<Code> getRelatedCodeByCodeTypeIdWhereAppFalse(
    		Long parentCodeTypeId);

    public List<PartyCode> getPartyCodeByFirmId(Long integer, Long firmId);

    public List getCodesByCodeTypeForAdminStaff(Long id);

	public List<CodeDTO> getCodeDTOListForCodeType(Long codeType);
	
	public List<KeyValue> getCodeDropdownListForCodeTypeAndParty(Long codeType, Long partyId, Long parentCodeTypeId);

	public List<Code> getListOfAdminCodes();

	public List getCodeDropdownListForCodeType(Long codeType);
}
