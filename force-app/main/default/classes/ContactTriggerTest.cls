@isTest
private with sharing class ContactTriggerTest {
    
    @TestSetup
    static void makeData(){
        Account newAccount = new Account(
            Name = 'Globant'
        );
        insert newAccount;
    }

    @IsTest
    static void seInsertanRegistrosSinCuentaYSeRecibeElMensajeDeError(){
        
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 20; i++) {
            contacts.add(
                new Contact(
                    LastName = 'Test' + i
                )
            );
        }

        Test.startTest();
        Database.SaveResult[] results = Database.insert(contacts, false);
        Test.stopTest();
        
        for (Database.SaveResult result : results) {
            System.assertEquals(false, result.isSuccess(), 'Se insertaron los registros');
            System.assertEquals(
                System.Label.mensajeError, 
                result.getErrors()[0].getMessage(), 
                'los mensajes de error no coinciden'
            );
        }
    }

    @IsTest
    static void methodName(){

        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Globant'
            LIMIT 1
        ];
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 20; i++) {
            contacts.add(
                new Contact(
                    LastName = 'Test' + i,
                    AccountId = anAccount.Id
                )
            );
        }
        Test.startTest();
        insert contacts;
        Test.stopTest();

        list<Contact> contactsToCompare = [
            SELECT Description
            FROM Contact
        ];

        for (Contact aContact : contactsToCompare) {
            System.assertEquals('Nueva descripcion', aContact.Description, 'La descripcion no coincide');
        }
        
    }

    @IsTest
    static void methodNameUpdate(){
        
        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Globant'
            LIMIT 1
        ];
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 20; i++) {
            contacts.add(
                new Contact(
                    LastName = 'Test' + i,
                    AccountId = anAccount.Id,
                    Description = 'Valor Actual'
                )
            );
        }
        
        insert contacts;
        Test.startTest();
        for (Contact aContact : contacts) {
            aContact.Description = 'Nuevo valor';
        }
        update contacts;
        Test.stopTest();

        list<Contact> contactsToCompare = [
            SELECT Description
            FROM Contact
        ];

        for (Contact aContact : contactsToCompare) {
            System.assertEquals('Valor Actual', aContact.Description, 'La descripcion no coincide');
        }
        
    }
}