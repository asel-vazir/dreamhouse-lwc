/**
 * Created by Asel on 4/29/20.
 */
public with sharing class PrimaryContactOnAccount {
    public static void createFirstPrimaryContactAsPrimaryContact(List<Contact> conList) {
        // New Account Ids and Account Ids already marked with a primary contact
        Set<Id> accountIds = new Set<Id>();
        Set<Id> existingIds = new Set<Id>();
        // Get account ids
        for (Contact contact : conList) {
            accountIds.add(contact.AccountId);
        }
        // Get all account Ids that have a primary contact
        existingIds.addAll(new Map<Id, AggregateResult>([
                SELECT AccountId Id
                FROM Contact
                WHERE AccountId IN :accountIds AND Primary_Contact__c = TRUE
                GROUP BY AccountId
        ]).keySet());

        for (Contact cont : conList) {
            // If existingIds.add() returns true, there was no previous primary contact
            cont.Primary_Contact__c = existingIds.add(cont.AccountId);
        }

    }
    //prevent user for having multiple primary contacts under an account in update
    public static void preventPimaryContactOnUpdate(Map<Id, Contact> contactNewMap, Map<Id, Contact> contactOldMap) {
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Contact> accountIdContactMap = new Map<Id, Contact>();

        for (Contact c : contactNewMap.values()) {
            if (contactNewMap.get(c.Id).Primary_Contact__c != contactOldMap.get(c.Id).Primary_Contact__c
                    && contactNewMap.get(c.Id).Primary_Contact__c == true && contactNewMap.get(c.Id).AccountId != null) {
                accountIds.add(contactNewMap.get(c.Id).AccountId);
            }
        }
        if (accountIds != null && accountIds.size() > 0) {
            List<Contact> existingContList = [
                    SELECT Id, AccountId, Primary_Contact__c
                    FROM Contact
                    WHERE AccountId IN :accountIds AND Primary_Contact__c = TRUE
            ];
            for (Contact con : existingContList) {
                accountIdContactMap.put(con.AccountId, con);
            }
            //Validation
            for (Contact c : contactNewMap.values()) {
                if (contactNewMap.get(c.Id).Primary_Contact__c != contactOldMap.get(c.Id).Primary_Contact__c
                        && contactNewMap.get(c.Id).Primary_Contact__c == true
                        && contactNewMap.get(c.Id).AccountId != null
                        && accountIdContactMap.get(contactNewMap.get(c.Id).AccountId) != null) {
                    c.addError('You can\'t create more than one Contact as primary');
                }
            }
        }
    }
}
