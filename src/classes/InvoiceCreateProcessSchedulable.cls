global class InvoiceCreateProcessSchedulable implements Schedulable{                                               // this class will generate invoices
                                                                                                        // for tenants whose payment date is today
    global Database.QueryLocator start(SchedulableContext ctx) {

        return Database.getQueryLocator([SELECT Name, Rent_Due_Date__c, Property__c, Monthly_Rate__c    // query for all tenants whose rent is due today
        FROM Tenant__c
        WHERE Rent_Due_Date__c = TODAY]);
    }

    global void execute(SchedulableContext ctx, List<Tenant__c> tenants) {                              // generate an invoice for each tenant
                                                                                                        // whose rent is due today
        List<Invoice__c> newInvoices = new List<Invoice__c>();                                          //create a List for Invoices.

        for (Tenant__c tenant : tenants) {
            Invoice__c inv          = new Invoice__c();
            inv.Bill_To_Tenant__c   = tenant.Name;
            inv.Bill_To_Tenant__c   = tenant.Id;

            insert inv;
        }
    }

    global void finish (SchedulableContext ctx){

    }

    global void execute(SchedulableContext param1) {

    }
}