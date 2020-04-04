/**
 * Created by Asel on 4/3/20.
 */

@IsTest
private class FOBCalloutSchedulableTest {

    public static String CRON_EXP = '0 0 20 3 4 ?';
    Date dueDate = Date.today();

    @IsTest
    static void testScheduledJob() {

        Property__c property = new Property__c();
        property.Name = '48 Brattle st';
        property.Business__c = 'Gov';
        insert property;

        List<Tenant__c> tenants = new List<Tenant__c>();
        Tenant__c tenant = new Tenant__c();
        tenant.Name = 'TenOne';
        tenant.Property__c = property.Id;
        tenant.Move_Out_Date__c = System.today();
        tenants.add(tenant);
        insert tenants;

        Map<Id, Tenant__c> tenMap = new Map<Id, Tenant__c> (tenants);
        List<Id> tenIds = new List<Id>(tenMap.keySet());

        Test.startTest();
        String jobId = System.schedule('ScheduledFOBTest', CRON_EXP, new FOBCalloutsSchedulable());
        List<Tenant__c> tenants2 = [SELECT Name, Move_Out_Date__c, Property__c FROM Tenant__c WHERE Move_Out_Date__c = TODAY];
        System.assertEquals(1, tenants2.size());
        Test.stopTest();

    }
}
