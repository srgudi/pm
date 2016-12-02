Ext.define('PM.view.NewPage', {
	 extend: "Ext.form.Panel",
	
     requires: ["Ext.form.FieldSet",'Ext.ux.Fileup'],
     alias:'newForm',
	 xtype: 'newdetails',
	 config: {
	        items: [
	            {
	                xtype: 'fieldset',
	                items: [
	                    {
	                        xtype: 'textfield',
	                        name: 'firstName',
	                        label: 'First Name',
	                        itemId: 'firstName'
	                    },
	                    
	                    
	                    {
	                        xtype: 'textfield',
	                        label: 'Last Name',
	                        itemId: 'lastName',
	                        name: 'lastName'	
	                    },
	                    {
	                    	
	                        xtype: 'fileupload',
	                        label:'File',
	                        itemId: 'fileupload',
	                        fileUpload:true,
	                        
	                       url: '../mobiledev/app/view/uploadFile.do'
	                    }
	                   
	                   
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
	                        itemId: 'saveNewPage',
	                        align: 'right',
	                        text: 'Save'
	                        
	                    },
	                    {
	                        xtype: 'button',
	                        itemId: 'sendmail',
	                        align: 'left',
	                        text: 'SendMail',
	                        handler:function () {
	                        	 Ext.Ajax.request({
	                                	method:'POST',
	                                    url    : '../mobiledev/app/view/sendmail.do'
	                                });
	                        }
	                        
	                    }	
	                ]
	            }
	        ],
	        listeners: [{
	            delegate: '#saveNewPage',
	            event: 'tap',
	            fn: 'onSaveNewButtonTap'
	        }]/*,
	        listeners: [{
	            delegate: '#sendmail',
	            event: 'tap',
	            fn: 'sendmailButton'
	        }]*/
	    },
	    onSaveNewButtonTap: function () {
	        var me = this,
	            firstnameField = me.down('#firstName'),
	            lastnameField = me.down('#lastName')
	            firstname = firstnameField.getValue(),
	            lastname = lastnameField.getValue();
                   Ext.Ajax.request({
                   	method:'POST',
                       url    : '../mobiledev/app/view/NewPage.do',
                       params:{
                    	   firstName: firstname,
                    	   lastName : lastname
                    	   
                       }
                   });
             

	    }
	    /*sendmailButton: function () {
                   Ext.Ajax.request({
                   	method:'POST',
                       url    : '../mobiledev/app/view/sendmail.do'
                   });
             

	    }*/
});
