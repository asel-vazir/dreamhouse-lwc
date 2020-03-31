/**
 * Created by Asel on 3/27/20.
 */

@IsTest
private class AvgUtilityCalculationTest {

    @IsTest
    static void avgUtilityCalcTest() {

        Property__c prop = new Property__c();
        prop.Name        = '48 Brattle st';
        prop.Business__c = 'Gov';

        insert prop;

        Utility__c ut1     = new Utility__c();
        ut1.Name           = 'Gas';
        ut1.Property__c    = prop.Id;
        ut1.Amount_Paid__c = 150;

        insert ut1;

        Utility__c ut2     = new Utility__c();
        ut2.Name           = 'Water';
        ut2.Property__c    = prop.Id;
        ut2.Amount_Paid__c = 200;

        insert ut2;

        List<Property__c> properties = [
                SELECT Name, Average_Utilities__c
                FROM Property__c
                WHERE Name = '48 Brattle st'
        ];
        for (Property__c p : properties) {

            System.assertEquals(175, p.Average_Utilities__c);

        }

    }

}