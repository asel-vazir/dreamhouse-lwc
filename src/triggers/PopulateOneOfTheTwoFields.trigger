/**
 * Created by Asel on 3/21/20.
 */

trigger PopulateOneOfTheTwoFields on Property__c (before insert, before update, after insert, after update) {

    for (Property__c p : Trigger.new) {

        if (p.Business__c != null && p.Contact__c != null) {

            p.addError('Cannot use two fields at the same time. Please choose only one field Business or Contact');

        }
    }
}