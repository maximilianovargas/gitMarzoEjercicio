@isTest
private with sharing class GetCommentsBatchTest {
    @testSetup
    static void makeData(){
        Post__c aPost = new Post__c(
            External_Id__c = '5',
            Title__c = 'Fake post',
            Body__c = 'a body of post'
        );
        insert aPost;
    }

    @isTest
    static void getPostAndInsertIntoDB(){
        Test.setMock(HttpCalloutMock.class, new CommentsServiceCalloutMock());
        GetCommentsBatch batch = new GetCommentsBatch();

        Test.startTest();
        String jobID = Database.executeBatch(batch,5);
        Test.stopTest();

        AsyncApexJob job = [
            SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :jobID
        ];

        System.assertEquals('Completed', job.Status);
    }
}