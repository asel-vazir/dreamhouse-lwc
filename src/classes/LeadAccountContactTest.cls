/**
 * Created by Asel on 4/22/20.
 */

@IsTest
private class LeadAccountContactTest {
    @IsTest
    static void createAccountContactFromLead() {

        Lead l = new Lead();
        l.LastName = 'Thomas';
        l.Company = 'Thomas1';
        insert l;

    }
}