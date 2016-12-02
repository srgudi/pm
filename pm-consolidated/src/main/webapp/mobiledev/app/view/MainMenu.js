Ext.define("PM.view.MainMenu", {
	 alias: "widget.mainmenuview",
	extend:'Ext.navigation.View',
	xtype:'mainpanel',
	requires:[
	          'PM.view.ClientList',
	          'PM.view.ClientDetails',
	          'PM.view.NewPage'
	          ],
	          config: {
	        	  items: [
	        	          
{
	docked: 'top',
	 xtype: 'toolbar',
     title: 'Main Menu',
    	 items: [{
             xtype: 'button',
             itemId: 'addClient',
             text: 'New Client',
             align: 'left'
         },
         {
             xtype: 'button',
             itemId: 'addNew',
             text: 'New',
             align: 'left'
         },
                 {xtype: 'spacer'},
    	         {    	
    		 xtype: 'button',
             text: 'Log Off',
             itemId: 'logOffButton',
             align: 'right'
    	 }
    	 ]
},  
	        	          {
	        		  xtype: 'clientlist'  
	        	  }],
	        	  listeners: [{
	                  delegate: '#logOffButton',
	                  event: 'tap',
	                  fn: 'onLogOffButtonTap'
	              }]
	              
	},
onLogOffButtonTap: function () {
	console.log("log off");
    this.fireEvent('onSignOffCommand');
}

});