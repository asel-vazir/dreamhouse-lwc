/**
 * Created by Asel on 3/28/20.
 */

global class InvoiceGenerateBatchJob implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {


        return Database.getQueryLocator([
                SELECT Name, Id, Rent_Due_Date__c, Monthly_Rate__c, Property__c
                FROM Tenant__c
                WHERE Rent_Due_Date__c = TODAY
        ]);
    }

    global void execute(Database.BatchableContext BC, List<Tenant__c> tenants) {

        for (Tenant__c tenant : tenants) {
            Invoice__c invoice = new Invoice__c();
            invoice.Bill_To_Tenant__c = tenant.Id;
            invoice.Due_Date__c = tenant.Rent_Due_Date__c;
            insert invoice;
        }
    }


    global void finish(Database.BatchableContext BC) {


    }

}