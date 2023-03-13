@RestResource(urlmapping='/myrest/*')
global with sharing class RestService {

    @HttpGet
   global static responseWrapper getAccountWithContacts() {
    RestRequest request = RestContext.request;
    String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

    Account anAccount = [
        SELECT Name, (
            SELECT FirstName, LastName, Email 
            FROM Contacts LIMIT 1)
        FROM Account
        WHERE Id = :accountId
        LIMIT 1
    ];
    ResponseWrapper response = new ResponseWrapper(anAccount);
    return response;
   }

   global with sharing class ResponseWrapper {
        public String accountName {get; set;}
        public String contactName {get; set;}
        public String contactEmail {get; set;}
        Public ResponseWrapper(Account anAccount){
            this.accountName = anAccount.Name;
            this.contactName = anAccount.contacts[0].FirstName 
                + ' ' + anAccount.contacts[0].LastName;
            this.contactEmail = anAccount.contacts[0].Email;
        }
   }
}