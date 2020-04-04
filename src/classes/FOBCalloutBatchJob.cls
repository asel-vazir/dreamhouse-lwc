/**
 * Created by Asel on 4/3/20.
 */
global class FOBCalloutBatchJob implements Database.Batchable<SObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){

    return Database.getQueryLocator([
            SELECT Name, Id, Move_Out_Date__c, Property__c
            FROM Tenant__c
            WHERE Move_Out_Date__c = TODAY
    ]);

    }

    global void execute(Database.BatchableContext BC, List<Tenant__c> tenants) {

        for (Tenant__c ten : tenants){
                if(ten.Move_Out_Date__c == System.today()) {
                    FOBCallouts.makePostCallout();
           }
        }
    }

    global void finish(Database.BatchableContext BC) {
    }

}