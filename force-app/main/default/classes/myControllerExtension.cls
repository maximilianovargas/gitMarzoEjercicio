public with sharing class myControllerExtension {
    private final Account acct;
    public List<Opportunity> opportunities {get;set;}
    public List<OpportunityWrapper> opportunitiesWrapp {get;set;}

    // The extension constructor initializes the private member
   // variable acct by using the getRecord method from the standard
  // controller.
 public myControllerExtension(ApexPages.StandardController stdController) {
    this.opportunitiesWrapp = new List<OpportunityWrapper>();
     this.acct = (Account)stdController.getRecord();
     this.opportunities = [
        SELECT Id, Name, StageName, Amount
        FROM Opportunity
        WHERE AccountId = :this.acct.id
     ];

     for (Opportunity anOpportunity : this.opportunities) {
        this.opportunitiesWrapp.add(
            new OpportunityWrapper(anOpportunity)
        );
     }
 }
 public String getGreeting() {
     return 'Hello ' + acct.name + ' (' + acct.id + ')';
 }

 public void saveCustom(){
    update this.acct;
 }

 public class OpportunityWrapper {
    public Opportunity anOpportunity {get; set;}
    public boolean isSelected {get; set;}
    public OpportunityWrapper(Opportunity anOpportunity){
        this.anOpportunity = anOpportunity;
        this.isSelected = false;
    }
 }

}