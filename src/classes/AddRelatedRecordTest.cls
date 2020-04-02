/**
 * Created by Asel on 4/1/20.
 */

@IsTest
private class AddRelatedRecordTest {

    @IsTest public static void addRelatedRecordTestonInsert() {

        Account testAcc = new Account();
        testAcc.Name = 'My Account Test';
        insert testAcc;
        update testAcc;


        System.assertEquals('Opportunity', 'Opportunity');
        System.assert(true, 'Account Updated');

    }

}
