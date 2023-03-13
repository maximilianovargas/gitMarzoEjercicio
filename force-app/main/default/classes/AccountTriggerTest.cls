@isTest
private with sharing class AccountTriggerTest {
    @TestSetup
    static void makeData(){
        Account anAccount = new Account(
            Name = 'Globant',
            Document_number__c = '33333333',
            Identification_type__c = 'NIT'
        );
        insert anAccount;
    }

    @IsTest
    static void methodName(){
        Account anAccount = new Account(
            Name = 'Globant',
            Document_number__c = '33333333',
            Identification_type__c = 'NIT'
        );
        Test.startTest();
        Database.SaveResult result = Database.insert(anAccount, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess(), 'se inserto la cuenta');
        System.assertEquals(
            'No se puede insertar una cuenta con document number e identification type iguales', 
            result.getErrors()[0].getMessage(), 
            'el mensaje de error no coincide'
        );
    }
}