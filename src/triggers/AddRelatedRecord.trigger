/**
 * Created by Asel on 4/1/20.
 */

trigger AddRelatedRecord on Account (after insert, after update) {
    if (Trigger.isInsert) {
        for (Account a : Trigger.new) {
            Opportunity opp = new Opportunity();
            opp.Name = a.Name + ' Opportunity';
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today().addMonths(1);
            opp.AccountId = a.Id;
            insert opp;

        }
    }

    if (Trigger.isUpdate) {
        List<Opportunity> oppList = new List<Opportunity>();

        List<Account> accountsWithoutOppsAndGotUpdated = [
                SELECT Id, Name
                FROM Account
                WHERE Id NOT IN (SELECT AccountId FROM Opportunity) AND Id IN :Trigger.new];


        for (Account a : accountsWithoutOppsAndGotUpdated) {
            oppList.add(new Opportunity(Name = a.Name + ' Opportunity',
                    StageName = 'Prospecting',
                    CloseDate = System.today().addMonths(1),
                    AccountId = a.Id));
        }
        insert oppList;
    }
}

//    List<Opportunity> oppList = new List<Opportunity>();
//
//    for (Account a : Trigger.new) {
//
//        Opportunity opp = new Opportunity();
//        opp.Name = a.Name + ' Opportunity';
//        opp.StageName = 'Prospecting';
//        opp.CloseDate = System.today().addMonths(1);
//        opp.AccountId = a.Id;
//        oppList.add(opp);
//
//    }
//    if (Trigger.isInsert) {
//            insert oppList;
//        }
//
//    if (Trigger.isUpdate) {
//            update oppList;
//        }
//    }


