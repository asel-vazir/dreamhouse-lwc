/**
 * Created by Asel on 3/28/20.
 */

@IsTest
private class InvoiceGenerateBatchTest {

    @TestSetup
    static void setupData() {

        List<Property__c> prop = new List<Property__c>();
        Property__c property = new Property__c();
        property.Name = 'Prop1';
        property.Business__c = 'Gov';
        prop.add(property);
        insert prop;

        List<Tenant__c> ten = new List<Tenant__c>();
        Tenant__c tenant = new Tenant__c();
        tenant.Name = 'TenOne';
        tenant.Rent_Due_Date__c = System.today();
        tenant.Property__c = property.Id;
        ten.add(tenant);
        insert ten;

        }

    @IsTest
     static void testInvoiceGenerateBatch() {

     String CRON_EXP = '0 0 23 30 3 ?';
     Date dueDate = Date.today();

     Test.startTest();

     String jobId = System.schedule('CreateInvoice', CRON_EXP, new InvoiceGenerateBatchScheduled());
     Database.executeBatch(new InvoiceGenerateBatchJob());

     Test.stopTest();

     System.assertEquals(1, [SELECT Id FROM Invoice__c WHERE Bill_To_Tenant__r.Name = 'TenOne'].size());

        }
    }