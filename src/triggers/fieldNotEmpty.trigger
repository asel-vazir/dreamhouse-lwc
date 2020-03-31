/**
 * Created by Asel on 3/21/20.
 */

trigger fieldNotEmpty on Property__c (before insert, before update, after insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        FieldnotEmptycontrl.fieldNotEmpty(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        FieldnotEmptycontrl.fieldNotEmpty(Trigger.new);

    }
}