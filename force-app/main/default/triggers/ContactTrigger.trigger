trigger ContactTrigger on Contact (before insert, before update) {

    //Trigger.new List<Contact> con los nuevos valores 
    //Trigger.old List<Contact> con los valores anteriores
    //Trigger.newMap y Trigger.oldMap Map<Id,Contact>
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            List<Contact> contactsWithOutAccounts = new List<Contact>();
            List<Contact> contactsWithOutDescription = new List<Contact>();
            for (Contact aContact : Trigger.new) {
                if (aContact.AccountId == null) {
                    contactsWithOutAccounts.add(aContact);
                }
                if (aContact.description == null) {
                    contactsWithOutDescription.add(aContact);
                }
            }

            ContactTriggerHandler.addErrorIfTheAccountIsNull(contactsWithOutAccounts);
            ContactTriggerHandler.completeDescriptionWithIsNull(contactsWithOutDescription);
        }
    } else if(Trigger.isUpdate){
        if (Trigger.isBefore) {
            /*for (Contact aContact : Trigger.new) {
                for (Contact oldContact : Trigger.old) {
                    if (aContact.id == oldCOntact.Id) {
                        if (aContact.Description != oldContact.Description) {
                            aContact.Description = oldContact.Description;
                        }
                    }
                }
            } no es optimo */
            ContactTriggerHandler.updateDescription(Trigger.new, Trigger.oldMap);
            
            }
            
        }
}