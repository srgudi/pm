var clients = Ext.create("PM.store.Clients");
Ext.define("PM.view.ClientList", {
    extend: "Ext.List",
    xtype: 'clientlist',
    requires:[
	          'PM.store.Clients'
	          ],
    config: {
    	  itemTpl: '<div class="list-item-line-main" style ="font-size:90%;"><b>Name: {name}</b></div>' +
          '<div class="list-item-line-detail" style ="font-size:80%;">Partner in Charge: {inChargePerson}</div>' +
          '<div class="list-item-line-detail" style ="font-size:80%;">Office Contact: {officeNumber} &nbsp;&nbsp;&nbsp;&nbsp; Email: {emailAddress}</div>',
    	  store: 'clients',
    	  title: 'Client List',
    	  onItemDisclosure:true,
    	  grouped: true,
          // pinHeaders :false,
           indexBar: true,
           plugins: [{
               xclass: 'Ext.plugin.ListPaging',
              autoPaging: true
      }],
      items:[{  
          xtype:'toolbar',                                       //  bottom toolbar  
          docked:'bottom',  
          items:[{  
              xtype: 'searchfield',                          //  here is the searchfield  
              itemId:'searchBox',  
             // id:'contact_search',                         //   we will be using this id in the controller  
              placeHolder: 'Search...'  
          }]  
      }]  
    }
});