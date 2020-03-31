public with sharing class FieldnotEmptycontrl {
    public static void fieldNotEmpty(List<Property__c> prop) {

        for (Property__c property : prop) {
            //if both fields are empty the error message shows up
            if (property.Business__c == null && property.Contact__c == null) {

                property.Business__c.addError('Please enter a value in Business or Contact!');
                property.Contact__c.addError('Please enter a value in Business or Contact!');
            }
            //if both fields are not empty the error message shows up
            if (property.Business__c != null && property.Contact__c != null) {

                property.Business__c.addError('Cannot use two fields at the same time. Please choose only one field Business or Contact');
                property.Contact__c.addError('Cannot use two fields at the same time. Please choose only one field Business or Contact');
            }
        }
    }
}