/**
 * Created by Asel on 4/29/20.
 */
trigger ContactTrigger on Contact (after update,before insert, before update){
    if (Trigger.isBefore && Trigger.isInsert) {
        PrimaryContactOnAccount.createFirstPrimaryContactAsPrimaryContact(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isUpdate){
        PrimaryContactOnAccount.preventPimaryContactOnUpdate(Trigger.newMap, Trigger.oldMap);
    }
}