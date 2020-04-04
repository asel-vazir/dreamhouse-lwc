/**
 * Created by Asel on 4/3/20.
 */
global class FOBCalloutsSchedulable implements Schedulable{
    // for tenants whose move out date is today
    global Database.QueryLocator start(SchedulableContext SC) {

        return Database.getQueryLocator([SELECT Name, Move_Out_Date__c, Property__c FROM Tenant__c WHERE Move_Out_Date__c = TODAY]);
    }

    global void execute(SchedulableContext SC) {

        List<Tenant__c> tenants = new List<Tenant__c>();
            for (Tenant__c ten : tenants){

                if(ten.Move_Out_Date__c == System.today()){

                    FOBCallouts.makePostCallout();
            }
        }
    }

    global void finish (SchedulableContext ctx){

    }
}