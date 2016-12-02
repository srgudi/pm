Ext.define("PM.model.Client", {
    extend: "Ext.data.Model",
    config: {
    	fields: [
                 { name: 'partyId', type: 'long' },
                 { name: 'name', type: 'string' },
                 { name: 'inChargePerson', type: 'string' },
                 { name: 'officeNumber', type: 'string' },
                 { name: 'emailAddress', type: 'string' }  
       ]
    }
    });