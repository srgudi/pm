package com.chiguru.pm.crm.dto;

import java.io.Serializable;


public class PartyRelationShipDTO implements Serializable {
    private PartyDTO partyBySubject;
    private PartyDTO partyByObject;

    /**
     * @return the partyBySubject
     */
    public PartyDTO getPartyBySubject() {
        return partyBySubject;
    }

    /**
     * @param partyBySubject the partyBySubject to set
     */
    public void setPartyBySubject(PartyDTO partyBySubject) {
        this.partyBySubject = partyBySubject;
    }

    /**
     * @return the partyByObject
     */
    public PartyDTO getPartyByObject() {
        return partyByObject;
    }

    /**
     * @param partyByObject the partyByObject to set
     */
    public void setPartyByObject(PartyDTO partyByObject) {
        this.partyByObject = partyByObject;
    }
}
