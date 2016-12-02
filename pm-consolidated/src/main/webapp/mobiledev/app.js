Ext.application({
    name: 'PM',
    views: ['Login','MainMenu','ClientList'],   
    model: ['Client'],
    store: ['Clients'],
    controllers:['Login','Client'],
    launch: function () {

        Ext.Viewport.add([
            { xtype: 'loginview' },
            { xtype: 'mainmenuview' },
            { xtype: 'clientlist' }
        ]);
        //Ext.create('PM.store.Clients');
        
     //   Ext.getStore('Clients').getProxy();
    //    Ext.getStore('Clients').load();
    }
   
});
