public with sharing class Build {
    public class AccountBuilder {
        private Account obj = new Account(
            Name = 'STRING',
            Document_number__c = '33333333'
        );
        
        public AccountBuilder withName(String value) {
            obj.Name = value;
            return this;
        }

        public AccountBuilder withDocumentNumber(String value) {
            obj.Document_number__c = value;
            return this;
        }
        

        public Account build() {
            return obj;
        }
    }

    public static AccountBuilder anAccount() {
        return new AccountBuilder();
    }
    
}