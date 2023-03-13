trigger AccountTrigger on Account (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            //Trigger.new lista
            Set<String> documentNumbers = new Set<String>();
            Set<String> identificationType = new Set<String>();
            Map<String, Account> accountsByDocumentNumberAndIdentificationType = new Map<String, Account>();
            for (Account anAccount : Trigger.new) {
                documentNumbers.add(anAccount.Document_number__c);
                identificationType.add(anAccount.Identification_type__c);
                accountsByDocumentNumberAndIdentificationType.put(
                    anAccount.Document_number__c+anAccount.Identification_type__c, anAccount
                    );
            }

            List<Account> accountsInDB = [
                SELECT Id, Document_number__c, Identification_type__c FROM Account
                WHERE document_number__c IN :documentNumbers 
                AND Identification_type__c IN :identificationType
            ];

            for (Account anAccount : accountsInDB) {
                if (
                    accountsByDocumentNumberAndIdentificationType.containsKey(
                        anAccount.Document_number__c+anAccount.Identification_type__c
                    )
                ) {
                  Account newAccount = accountsByDocumentNumberAndIdentificationType.get(
                    anAccount.Document_number__c+anAccount.Identification_type__c
                    );
                    newAccount.addError('No se puede insertar una cuenta con document number e identification type iguales');  
                }
                
            }
            /*for (Account accountInDB : accountsInDB) {
                for (Account newAccount : Trigger.new) {
                    if (accountInDB.Document_number__c == newAccount.Document_number__c &&
                        accountInDB.Identification_type__c ==  newAccount.Identification_type__c
                    ) {
                        newAccount.addError('No se puede insertar una cuenta con document number e identification type iguales');
                    }
                }
            }*/

        }
    }
}