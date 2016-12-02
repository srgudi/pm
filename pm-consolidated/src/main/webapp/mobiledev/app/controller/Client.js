Ext.define('PM.controller.Client', {
	  extend: 'Ext.app.Controller',
	  config: {
		  refs:{
			  main: 'mainpanel',
				  clientDetail: 'clientdetails',
				  addnewDetail: 'newdetails'
		  },
		  control: {
			  'clientlist':{
				  disclose: 'showDetails'
			  },
			   'clientlist searchfield[itemId=searchBox]' : {
				    clearicontap : 'onClearSearch',
				    keyup: 'onSearchKeyUp'
				   },
				   'mainmenuview button[itemId=addClient]' : {
					    tap : 'onAddClient'
				   },
				   'mainmenuview button[itemId=addNew]' : {
					    tap : 'onAddNew'
				   },
				   'clientdetails button[itemId=saveClient]' : {
					    tap : 'onSaveClient'
					   }
		  }
},
  showDetails: function(list, record){
    	 console.log(list);
    	 console.log(record);
    	 console.log(record.data);
    	 console.log(record.data.name);
    	this.getMain().push({
    		xtype:'clientdetails',
    		record: record
    	});
     },


     onClearSearch: function() {
		console.log("onClearSearch");
		var store = Ext.getStore('clients');
	    store.clearFilter();
		
	},
	onSearchKeyUp: function(searchField) {
		console.log("onSearchKeyUp");
		 queryString = searchField.getValue();
		  console.log(this,'Please search by: ' + queryString);
		 
		  var store = Ext.getStore('clients');
	      store.clearFilter();
		 
		  if(queryString){
		   var thisRegEx = new RegExp(queryString, "i");
		    store.filterBy(function(record) {
		    if (thisRegEx.test(record.get('name')) ||
		      thisRegEx.test(record.get('inChargePerson')) ||
		      thisRegEx.test(record.get('officeNumber'))) {
		     return true;
		    };
		    return false;
		   });
		  }
	},

	onAddClient: function(button) {
		console.log("onAddClient");
		this.getMain().push({
    		xtype:'clientdetails'
    	});
	},
	onAddNew: function(button) {
		console.log("onAddNew");
		this.getMain().push({
    		xtype:'newdetails'
    	});
	},
	
	onSaveClient: function() {
		console.log("onSaveClient");
		var values = this.getValues();
		 console.log(values);
		 var form = this.getClientDetail;
		   console.log(form);
		 var record = form.getRecord();
			console.log(record);
		 var values = form.getValues();
		 console.log(values);
	}
	
});