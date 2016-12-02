package com.chiguru.pm.crm.service;

import com.chiguru.pm.crm.dao.CRMDao;
import com.chiguru.pm.crm.domain.Code;
import com.chiguru.pm.crm.domain.CodeType;
import com.chiguru.pm.crm.domain.PartyCode;
import com.chiguru.pm.crm.dto.CodeDTO;
import com.chiguru.pm.crm.dto.KeyValue;

import org.hibernate.SessionFactory;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import java.io.Serializable;

import java.util.List;
import java.util.Map;
import java.util.Set;


@Service
public class CodesManagerImpl implements CodesManager, Serializable {
    /**
     *
     */
    private static final long serialVersionUID = -4682379883603464048L;
    @Autowired
    CRMDao crmDao;
    @Autowired
    SessionFactory sessionFactory;

    @Override
    public Map<CodeType, Set<Code>> getApplicationLevelCodeMap() {
        return crmDao.getApplicationLevelCodeMap();
    }

    @Override
    public Code getCodeById(Long id) {
        // TODO Auto-generated method stub
        return crmDao.getCodeById(id);
    }

    @Override
    public Map<CodeType, List<Code>> getPartyLevelCodeMap(Long partyId) {
        // TODO Auto-generated method stub
        return null;
    }

    public List<CodeType> getApplicationLevelCodeType() {
        return crmDao.getApplicationLevelCodeType();
    }

    public CodeType getCodeTypeById(Long id) {
        return crmDao.getCodeTypeById(id);
    }

    public List<Code> getCodesByCodeType(Long codeTypeId) {
        return crmDao.getCodesByCodeType(codeTypeId);

        //Session session = sessionFactory.openSession();

        //return session.createQuery("from Code code where code.codeType.id=?").setInteger(0, codeTypeId).list();
    }

    public void createCode(Code code) {
        crmDao.createCode(code);
    }

    @Override
    public Long getParentCodeTypeIdById(Long codeTypeId) {
        return crmDao.getParentCodeTypeIdById(codeTypeId);
    }

    @Override
    public List<Code> getRelatedCodeByCodeTypeId(Long parentCodeTypeId) {
        return crmDao.getRelatedCodeByCodeTypeId(parentCodeTypeId);
    }

    @Override
    public List<Code> getRelatedCodeByCodeTypeIdWhereAppFalse(
    		Long parentCodeTypeId) {
        return crmDao.getRelatedCodeByCodeTypeIdWhereAppFalse(parentCodeTypeId);
    }

    @Override
    public List<PartyCode> getPartyCodeByFirmId(Long integer, Long firmId) {
        return crmDao.getPartyCodeByFirmId(integer, firmId);
    }

    @Override
    public List getCodesByCodeTypeForAdminStaff(Long id) {
        return crmDao.getCodesByCodeTypeForAdminStaff(id);
    }
    
    @Override
	public List<CodeDTO> getCodeDTOListForCodeType(Long codeType) {
    	return crmDao.getCodeDTOListForCodeType(codeType);
    }
    
    @Override
    public List<KeyValue> getCodeDropdownListForCodeTypeAndParty(Long codeType, Long partyId, Long parentCodeTypeId){
    	return crmDao.getCodeDropdownListForCodeTypeAndParty(codeType, partyId, parentCodeTypeId);
    }

	@Override
	public List<Code> getListOfAdminCodes() {
		return crmDao.getListOfAdminCodes();
	}

	@Override
	public List getCodeDropdownListForCodeType(Long codeType) {
		return crmDao.getCodeDropdownListForCodeType(codeType);
	}
}
