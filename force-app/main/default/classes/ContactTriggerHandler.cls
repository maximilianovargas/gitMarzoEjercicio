public with sharing class ContactTriggerHandler {


    public static void completeDescriptionWithIsNull(List<Contact> contacts) {
        for (Contact aContact : contacts) {
            aContact.Description = 'Nueva descripcion';
        }
    }

    public static void addErrorIfTheAccountIsNull(List<Contact> contacts) {
        for (Contact aContact : contacts) {
            aContact.addError(System.Label.mensajeError);
        }
    }

    public static void updateDescription(List<Contact> contacts, Map<Id,Contact> oldContactsById) {
        for (Contact aContact : contacts) {
            Contact oldContact = oldContactsById.get(aContact.Id);
            if (aContact.Description != oldContact.Description) {
                aContact.Description = oldContact.Description;
            }
        }
    }
}