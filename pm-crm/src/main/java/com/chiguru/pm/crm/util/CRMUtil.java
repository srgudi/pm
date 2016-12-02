package com.chiguru.pm.crm.util;

import com.chiguru.pm.crm.domain.Organization;
import com.chiguru.pm.crm.domain.Party;
import com.chiguru.pm.crm.dto.PartyDTO;


public class CRMUtil {
    // Added by Savitri
    public static PartyDTO getFirmDTO(Party party) {
        PartyDTO dto = new PartyDTO();
        dto.setId(party.getId());
        dto.setPartyId(party.getId());
        dto.setName(party.getName());

        if (party.getOrganization() != null) {
            Organization org = party.getOrganization();
            org.setLegalName(party.getName());

            /*if(party.getPartySites().size()>0){
                    PartySite partySite=party.getPartySites().get(0);
                    CommunicationDTO commDTO = populateCommunciationDTO (partySite );
                    dto.setCommunicationDTO(commDTO);
            }*/
        }

        return dto;
    }
}
