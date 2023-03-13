public with sharing class MyClass implements Queueable {

    Private List<Opportunity> opportunities;

    public MyClass(List<Opportunity> opportunities){
        this.opportunities = opportunities;
    }

    public void execute(QueueableContext context) {
        for (Opportunity anOpportunity : opportunities) {
            anOpportunity.StageName = 'Closed Won';
        }

        update opportunities;
    }

    @future
    public static void futureMethod(List<Id> opportunitiesIds) {
        List<Opportunity> opportunities = [
            SELECT Id
            FROM Opportunity
            WHERE Id IN :opportunitiesIds
        ];

        for (Opportunity anOpportunity : opportunities) {
            anOpportunity.StageName = 'Value Proposition';
        }

        update opportunities;
    }
}