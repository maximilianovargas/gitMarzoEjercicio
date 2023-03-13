public with sharing class MyBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    private String filter;
    
    public MyBatch() {
        this.filter = 'NEXT_MONTH';
    }

    public MyBatch(String filter){
        this.filter = filter;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
            'SELECT id, StageName, CloseDate FROM Opportunity WHERE IsClosed = false and CloseDate < ' + filter
        );
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> opportunities){
        system.debug(opportunities);
        for (Opportunity anOpportunity : opportunities) {
            anOpportunity.StageName = 'Closed Lost';
        }

        Update opportunities;
    }
    public void finish(Database.BatchableContext bc){
    }
}