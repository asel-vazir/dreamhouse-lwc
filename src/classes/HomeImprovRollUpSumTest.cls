/**
 * Created by Asel on 4/1/20.
 */

@IsTest
private class HomeImprovRollUpSumTest {

    @IsTest
    static void testRollUpSum() {

        Property__c property = new Property__c();
        property.Name = 'Prop1';
        property.Business__c = 'Gov';
        property.SUM_of_Improvements__c = 0;
        insert property;

        List<Home_Improvement__c> homeImprovements = new List<Home_Improvement__c>();
        Home_Improvement__c homeImprovement = new Home_Improvement__c();
        homeImprovement.Name = 'HomeImpr';
        homeImprovement.Amount__c = 1000;
        homeImprovement.Property__c = property.Id;

        Home_Improvement__c homeImprovement2 = new Home_Improvement__c();
        homeImprovement2.Name = 'HomeImpr2';
        homeImprovement2.Amount__c = 1000;
        homeImprovement2.Property__c = property.Id;

        homeImprovements.add(homeImprovement);
        homeImprovements.add(homeImprovement2);

        Test.startTest();

        insert homeImprovement;
        delete homeImprovement;

        Test.stopTest();


        Property__c propAfterInsert = [SELECT SUM_of_Improvements__c FROM Property__c WHERE Id =: property.Id];
        System.assertEquals(0, propAfterInsert.SUM_of_Improvements__c);

    }
}