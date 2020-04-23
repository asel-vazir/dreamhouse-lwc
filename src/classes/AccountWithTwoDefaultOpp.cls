/**
 * Created by Asel on 4/10/20.
 */

public with sharing class AccountWithTwoDefaultOpp {
    public static void addTwoDefaultOpptToAcct(List<Account> acctList) {

        List<Opportunity> oppList = new List<Opportunity>();

        for (Account acct : acctList) {
            Opportunity opp = new Opportunity();
            opp.Name = acct.Name + ' Default Residential Opp';
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today().addMonths(1);
            opp.AccountId = acct.Id;
            oppList.add(opp);

            Opportunity opp2 = new Opportunity();
            opp2.Name = acct.Name + 'Default Commercial Opp';
            opp2.StageName = 'Prospecting';
            opp2.CloseDate = System.today().addMonths(1);
            opp2.AccountId = acct.Id;
            oppList.add(opp2);
        }
        insert oppList;
    }
    public static void checkIfOppsMissing(List<Account> acctList2) {

        List<Opportunity> oppList2 = new List<Opportunity>();
        List<Opportunity> opportunities = [SELECT Id FROM Opportunity WHERE AccountId = :acctList2];

        if (opportunities.size() == 0) {
            for (Account act : acctList2) {
                Opportunity opp1 = new Opportunity();
                opp1.Name = 'Default Residential Opp';
                opp1.AccountId = act.Id;
                opp1.CloseDate = System.today().addMonths(1);
                opp1.StageName = 'Prospecting';
                oppList2.add(opp1);

                Opportunity opp2 = new Opportunity();
                opp2.Name = 'Default Commercial Opp';
                opp2.AccountId = act.Id;
                opp2.CloseDate = System.today().addMonths(1);
                opp2.StageName = 'Prospecting';
                oppList2.add(opp2);

            }
            insert oppList2;
        }
        if (opportunities.size() == 1) {
            List<Account> acctsTypeProspect = new List<Account>([
                    SELECT Id, Name, OwnerId, Type, (SELECT Id, Name FROM Opportunities)
                    FROM Account
                    WHERE Type = 'Prospect'
                    AND Id IN (SELECT AccountId FROM Opportunity)
                    AND Id IN :acctList2
            ]);
            for (Account acct : acctsTypeProspect) {
                for (Opportunity oppt : acct.Opportunities) {
                    if (oppt.Name == 'Default Residential Opp') {
                        Opportunity opp1 = new Opportunity();
                        opp1.Name = 'Default Commercial Opp';
                        opp1.AccountId = acct.Id;
                        opp1.CloseDate = System.today().addMonths(1);
                        opp1.StageName = 'Prospecting';
                        insert opp1;

                    } else if (oppt.Name == 'Default Commercial Opp') {
                        Opportunity opp2 = new Opportunity();
                        opp2.Name = 'Default Residential Opp';
                        opp2.AccountId = acct.Id;
                        opp2.CloseDate = System.today().addMonths(1);
                        opp2.StageName = 'Prospecting';
                        insert opp2;
                    }
                }
            }
        }
    }

    public static void SendMail(List<Account> listAccounts) {

        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<String> sendTo = new List<String>();

        for (Account account : listAccounts) {
            if (account.Opportunities.isEmpty()) {

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSenderDisplayName('Email Alert');
                mail.setSubject('OPP deleted/altered');
                String body = 'Dear ' + account.OwnerId + ', ';
                body += 'Please be informed that the Opp was deleted/altered.';
                body += 'Regards, Developer';
                mail.setToAddresses(sendTo);
                mail.setHtmlBody(body);
                mail.setReplyTo('asel.vazirova@gmail.com');
                sendTo.add(account.OwnerId);
                mails.add(mail);
                try {
                    Messaging.sendEmail(mails);
                } catch (Exception e) {

                }
            }
        }
    }
}



