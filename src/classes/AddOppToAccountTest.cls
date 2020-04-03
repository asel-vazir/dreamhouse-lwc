/**
 * Created by Asel on 4/2/20.
 */

@IsTest
private class AddOppToAccountTest {

    @IsTest
    public static void addOpptoAccTest() {

        Account testAcc = new Account(Name = 'My Account Test');
        insert testAcc;

        update [SELECT Id FROM Opportunity WHERE Account.Name = 'My Account Test'];

        System.assert([SELECT Id FROM Opportunity WHERE AccountId = : testAcc.Id].size() == 1);

    }
}