/**
 * Created by Asel on 3/31/20.
 */

trigger HomeImprovementSumTrigger on Home_Improvement__c (after insert, after update, after delete, after undelete) {

    if (Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate) {
        HomeImprovementRollUpSum.newHandler(Trigger.new);

    } else if (Trigger.isDelete) {
        HomeImprovementRollUpSum.newHandler(Trigger.old);
    }
}