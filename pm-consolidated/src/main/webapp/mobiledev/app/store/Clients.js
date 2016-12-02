Ext.define('PM.store.Clients', {
	extend  : 'Ext.data.Store',
	requires: ['PM.model.Client'],
	id: 'clients',
	 config  : {
	    model : 'PM.model.Client',
	    autoLoad :true,
	    sorters :'name',
	    grouper : function(record){
	    	return record.get('name')[0];
	    } ,
	    proxy:{
	    	type:'ajax',
	    	 url: '../client/mobileClientAjaxList.do',
	    	  reader: {
                  type: 'json',
                  rootProperty: 'results',
                  totalProperty: 'totalCount',
                  successProperty: 'success'
              }
	            }

/*listeners: {
    refresh: function() {
        console.log(Ext.StoreManager.get('Clients').getAt(0));
    }
}*/
	}
	});


/*Ext.define('Sample.store.Clients', {
extend  : 'Ext.data.Store',
requires: ['Sample.model.Client'],
id: 'clients',
 config  : {
    model : 'Sample.model.Client',
    //storeId: 'stationsStore',
    autoLoad : true,
    //sorters: 'stop',
    proxy: {
    	type:'ajax',
        url:'http://localhost:7865/pm-new/client/mobileClientAjaxList.do',
        extraParams: {
        	            format: 'json'
      
        	        },

        reader:{
         rootProperty:'responseData.feed.entries'
        }
    }*/
   /* data: [
        { "id": "129", "stop": "NY Station" },
        { "id": "13", "stop": "Newark Station" }
    ]*/
/*}
});*/

