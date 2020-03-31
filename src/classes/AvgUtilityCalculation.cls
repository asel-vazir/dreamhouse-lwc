/**
 * Created by Asel on 3/25/20.
 */

public with sharing class AvgUtilityCalculation {
    public static void avgUtility(List<Utility__c> utilities) {

        Set<Id> propertyIds          = new Set<Id>();
        List<Property__c> properties = new List<Property__c>();

        //List<Utility__c> utilities   = Trigger.isInsert || Trigger.isUpdate ? Trigger.new : Trigger.old;

        for (Utility__c utl : utilities) {
            propertyIds.add(utl.Property__c);
        }

        for (AggregateResult agr : [
                SELECT Property__c, AVG(Amount_Paid__c) avg1
                FROM Utility__c
                GROUP BY Property__c
        ]) {

            properties.add(new Property__c(Id = (Id) agr.get('Property__c'),
                    Average_Utilities__c = (Decimal) agr.get('avg1')));

        }

        if (properties.size() > 0) {
            update properties;

        }
    }

}