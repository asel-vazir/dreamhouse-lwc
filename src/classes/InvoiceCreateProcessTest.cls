/**
 * Created by Asel on 3/27/20.
 */

@IsTest
private class InvoiceCreateProcessTest {

    public static String CRON_EXP = '0 0 19 28 3 ?';

    @IsTest
    static void testScheduledJob(){

        List<Tenant__c> tenants = new List<Tenant__c>();
        Date dueDate = Date.today();

        for (Integer i = 1; i < 10; i++);{

            try {
                Tenant__c t = new Tenant__c();
                t.Name = 'TenOne';
                t.Property__c = [SELECT Id
                                 FROM Property__c
                                 WHERE Name = '48 Brattle st'
                                 LIMIT 10].Id;
                tenants.add(t);
            }
            catch (Exception e){

                insert tenants;

                Map<Id, Tenant__c> tenMap = new Map<Id, Tenant__c> (tenants);
                List<Id> tenIds = new List<Id>(tenMap.keySet());

                Test.startTest();
                String jobId = System.schedule('ScheduleApexTest', CRON_EXP, new InvoiceCreateProcessSchedulable());
                List<Invoice__c> invoices = [SELECT Id FROM Invoice__c WHERE Name IN:tenIds];
                System.assertEquals(0, tenants.size());
                Test.stopTest();

                invoices = [SELECT Id FROM Invoice__c WHERE Name IN :tenIds LIMIT 10];
                System.assertEquals(tenIds.size(), invoices.size(), 'Bills were not created');
            }
        }
    }
}