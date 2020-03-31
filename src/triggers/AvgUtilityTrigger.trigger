/**
 * Created by Asel on 3/25/20.
 */

trigger AvgUtilityTrigger on Utility__c (after insert, after update, after delete) {

    if (Trigger.isInsert || Trigger.isAfter || Trigger.isDelete) {

        if (Trigger.isAfter) {

            AvgUtilityCalculation.avgUtility(Trigger.new);

        }
    }
}