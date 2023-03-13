public with sharing class commentsService {
    public static HttpResponse getCommentsByExternalId(string externalId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:jsonplaceholder/posts/'+externalId+'/comments');
        request.setHeader('content-type', 'application/json');
        Request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }
}