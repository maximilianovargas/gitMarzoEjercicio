@isTest
private with sharing class CommentsQueueableTest {
    @testSetup
    static void makeData(){
        List<Post__c> posts = new List<Post__c>();
        Post__c aPost = new Post__c(
            External_Id__c = '5',
            Title__c = 'Fake post',
            Body__c = 'a body of post'
        );
        posts.add(aPost);
        insert posts;
    }

    @isTest
    static void callToServiceAndInsertPosts(){

        Test.setMock(HttpCalloutMock.class, new CommentsServiceCalloutMock());
        List<Post__c> posts = [
            SELECT External_Id__c
            FROM Post__c
        ];
        CommentsQueueable queueable = new CommentsQueueable(posts);
        Test.startTest();
        String jobID = System.enqueueJob(queueable);
        Test.stopTest();
        
        AsyncApexJob job = [
            SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobID
        ];

        System.assertEquals('Completed', job.Status, 'el estado no coincide correctamente');

        List<Comment__c> comments = new List<Comment__c>();
        
        comments = [
            SELECT Id, Post__r.External_Id__c
            FROM Comment__c
        ];

        System.assertEquals(5, comments.size(), 'el tamaño de comentarios no es el mismo');
    }
}