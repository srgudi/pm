Ext.define('PM.view.ClientDetails', {
	 extend: "Ext.form.Panel",
     requires: "Ext.form.FieldSet",
	 xtype: 'clientdetails',
	 config: {
	        items: [
	            {
	                xtype: 'fieldset',
	                title: 'Client Details',
	                items: [
	                    {
	                        xtype: 'textfield',
	                        name: 'name',
	                        label: 'Legal Name'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'Operating Name'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'Form Of Business'
	                    }, 
	                    {
	                        xtype: 'textfield',
	                        label: 'Business Number'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'Incorporation Number'
	                    },
	                    {
	                        xtype: 'textfield',
	                        name: 'inChargePerson',
	                        label: 'Partner Incharge'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'Year End Date'
	                    }, 
	                    {
	                        xtype: 'textfield',
	                        label: 'Industry'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'Country'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'State'
	                    },
	                    {
	                        xtype: 'textfield',
	                        name: 'emailAddress',
	                        label: 'Email'
	                    },
	                    {
	                        xtype: 'textfield',
	                        name: 'officeNumber',
	                        label: 'Contact Number'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'Issued Capital'
	                    },
	                    {
	                        xtype: 'textfield',
	                        label: 'Authorized Capital'
	                    },
	                ]
	            },
	            {
	                xtype: 'toolbar',
	                docked: 'bottom',
	                items: [{
	                	 xtype: "button",
	                     iconCls: "trash",
	                     iconMask: true
	                },
	                {xtype: 'spacer'},
	                    {
	                        xtype: 'button',
	                        itemId: 'saveClient',
	                        align: 'right',
	                        text: 'Save'
	                    }	                   
	                ]
	            }
	        ]
	    }
});
