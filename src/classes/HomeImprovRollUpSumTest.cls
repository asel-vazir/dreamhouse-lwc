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
        property.SUM_of_Improvements__c = null;
        insert property;


        Home_Improvement__c homeImprovement = new Home_Improvement__c();
        homeImprovement.Name = 'HomeImpr';
        homeImprovement.Amount__c = 1000;
        homeImprovement.Property__c = property.Id;


        Test.startTest();

        insert homeImprovement;
        delete homeImprovement;

        Test.stopTest();


        Property__c propAfterInsert = [SELECT SUM_of_Improvements__c FROM Property__c WHERE Id =: property.Id];
        System.assertEquals(0, propAfterInsert.SUM_of_Improvements__c);

    }
}