/**
 * Created by Asel on 4/1/20.
 */

@IsTest
private class AddRelatedRecordTest {

    @IsTest public static void addRelatedRecordTestonInsert() {

        Account testAcc = new Account(Name = 'My Account Test');
        insert testAcc;
        //delete the Opp created by the Account insert

        delete [SELECT Id FROM Opportunity];
        testAcc.Name = 'My Account Test';

        Test.startTest();
        update testAcc;
        Test.stopTest();

        List<Opportunity> oppsAfterUpdate = new List<Opportunity>([
                SELECT Id
                FROM Opportunity
                WHERE Account.Name = 'My Account Test'
        ]);

        System.assertEquals(2, oppsAfterUpdate.size());

    }

}
//        Account testAcc = new Account(Name = 'My Account Test');
//        insert testAcc;
//
//        delete [SELECT Id FROM Opportunity WHERE Account.Name = 'My Account Test'];
//
//        System.assert([SELECT Id FROM Opportunity WHERE AccountId = : testAcc.Id].size() == 1);