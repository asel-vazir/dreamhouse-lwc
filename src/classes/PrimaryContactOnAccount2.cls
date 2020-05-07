/**
 * Created by Asel on 5/7/20.
 */

public with sharing class PrimaryContactOnAccount2 {
    public static void createFirstContactAsPrimaryContact(List<Contact> conList) {
        Set<String> accountIds = new Set<String>();
        for (Contact contact : conList) {
            accountIds.add(contact.AccountId);
        }

        Map<String, Account> accountsByIds = new Map<String, Account>([
                SELECT Id, Name, (SELECT Id FROM Contacts LIMIT 1)
                FROM Account
                WHERE Id =: accountIds
        ]);

        for (Contact con : conList) {
            if (accountsByIds.containsKey(con.AccountId) && accountsByIds.get(con.AccountId).Contacts.isEmpty()) {
                con.Primary_Contact__c = true;
            }
        }
    }
}