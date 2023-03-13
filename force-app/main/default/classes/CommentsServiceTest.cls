@isTest
private with sharing class CommentsServiceTest {
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
    static void getCommentsWithPostId(){

        CommentsServiceCalloutMock aMock = new CommentsServiceCalloutMock();

        Test.setMock(HttpCalloutMock.class, aMock);        

        Post__c aPost = [
            SELECT External_Id__c
            FROM Post__c
            WHERE External_Id__c = '5'
            LIMIT 1
        ];

        Test.startTest();
        HttpResponse response = commentsService.getCommentsByExternalId(aPost.External_Id__c);
        Test.stopTest();

        System.assertEquals(
            200, 
            response.getStatusCode(), 
            'El codigo de respuesta no es el mismo'
        );
        System.assertEquals(
            aMock.body, 
            response.getBody(), 
            'El llamado al servicio no retorno lo correcto'
        );
    }
}