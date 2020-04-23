/**
 * Created by Asel on 4/10/20.
 */

trigger AddTwoOppToNewAccount on Account (after insert, after update) {
    if (Trigger.isAfter && Trigger.isInsert){
        AccountWithTwoDefaultOpp.addTwoDefaultOpptToAcct(Trigger.new);
    }

    if  (Trigger.isAfter && Trigger.isUpdate) {
        AccountWithTwoDefaultOpp.checkIfOppsMissing(Trigger.new);
        AccountWithTwoDefaultOpp.SendMail(Trigger.new);

    }
}