/**
 * Created by Asel on 4/3/20.
 */

@IsTest
private class FOBCalloutSchedulableTest {

    @IsTest
    static void setupData() {

        List<Property__c> prop = new List<Property__c>();
        Property__c property = new Property__c();
        property.Name = '48 Brattle st';
        property.Business__c = 'Gov';
        prop.add(property);
        insert prop;

        List<Tenant__c> tenants = new List<Tenant__c>();
        Tenant__c tenant = new Tenant__c();
        tenant.Name = 'TenOne';
        tenant.Move_Out_Date__c = System.today();
        tenant.Property__c = property.Id;
        tenants.add(tenant);
        insert tenants;
    }

    @IsTest
    static void testFOBCalloutBatch(){

        String CRON_EXP = '0 0 20 3 4 ?';
        Date dueDate = Date.today();

        Test.startTest();
        String jobId = System.schedule('ScheduledFOBTest', CRON_EXP, new FOBCalloutScheduled());
        Database.executeBatch(new FOBCalloutBatchJob());
        Test.stopTest();

        System.assertEquals(0, [SELECT Id, Name, Move_Out_Date__c, Property__c FROM Tenant__c WHERE Move_Out_Date__c = TODAY].size());
    }
}
