public with sharing class ConsumeRest {
    public static HttpResponse getCharactersByHouse(String house) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://hp-api.onrender.com/api/characters/house/'+house);
        request.setHeader('content-type', 'application/json');
        Request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }
}