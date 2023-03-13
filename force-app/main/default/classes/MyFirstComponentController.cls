public with sharing class MyFirstComponentController {
    @AuraEnabled(cacheable=true)
    public static Account getAccount(Id accountId){
        return [
            SELECT Id, Name
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId){
        return [
            SELECT Id, Name, StageName, Amount
            FROM Opportunity
            WHERE AccountId = :accountId
            AND isClosed = true
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunitiesOpen(Id accountId){
        return [
            SELECT Id, Name, StageName, Amount
            FROM Opportunity
            WHERE AccountId = :accountId
            AND isClosed = false
        ];
    }

    @AuraEnabled
    public static void saveOpportunities(List<Opportunity> opportunities){
        Update opportunities;
    }
}