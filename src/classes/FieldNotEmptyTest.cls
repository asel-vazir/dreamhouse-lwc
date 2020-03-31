/**
 * Created by Asel on 3/23/20.
 */

@IsTest
private class FieldNotEmptyTest {

    @TestSetup static void fieldNotEmptyTest() {
        Property__c testProp = new Property__c();
        testProp.Name = 'MyPropertyTest';
        testProp.Business__c = 'Abc';
        testProp.Contact__c = null;
        insert testProp;
        System.debug('Property field for Business is ' + testProp.Business__c);
        System.assertEquals('Abc', testProp.Business__c);

    }


    @IsTest static void testEmptyContactBusinessFieldsOnProperty() {
        Property__c prop = [SELECT Id FROM Property__c WHERE Name = 'MyPropertyTest' LIMIT 1];
        prop.Business__c = null;
        prop.Contact__c = null;

        try {
            update prop;
        } catch (DmlException e) {

            System.debug('DML Exception' + e);
        }

        System.assertEquals(null, prop.Business__c);
        System.assertEquals(null, prop.Contact__c);

    }

    @IsTest static void testPopulatedContactBusinessFieldsOnProperty() {
        Property__c prop = [SELECT Id FROM Property__c WHERE Name = 'MyPropertyTest' LIMIT 1];
        prop.Business__c = 'Abc';
        prop.Contact__c = 'ContactName';

        try {
            update prop;
        } catch (DmlException e) {

            System.debug('DML Exception' + e);

        }

        System.assertEquals('Abc', prop.Business__c);
        System.assertEquals('ContactName', prop.Contact__c);

    }

}