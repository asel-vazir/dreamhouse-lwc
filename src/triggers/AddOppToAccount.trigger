/**
 * Created by Asel on 4/2/20.
 */

trigger AddOppToAccount on Account (after insert, after update) {

    List<Opportunity> oppList = new List<Opportunity>();

    for (Account a : Trigger.new) {
        Opportunity opp = new Opportunity();
        opp.Name = a.Name + ' Opportunity';
        opp.StageName = 'Prospecting';
        opp.CloseDate = System.today().addMonths(1);
        opp.AccountId = a.Id;
        oppList.add(opp);

        if (Trigger.isInsert) {
            insert oppList;
        }

        if (Trigger.isUpdate) {
            insert oppList;
        }
    }
}