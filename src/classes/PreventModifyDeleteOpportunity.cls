/**
 * Created by Asel on 5/7/20.
 */

public with sharing class PreventModifyDeleteOpportunity {
    public static void preventUsersToModifyOpportunity(List <Opportunity> opportList) {

        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Id =:UserInfo.getProfileId()];
        String profileName = null;
        if (!profiles.isEmpty()) {
            profileName = profiles[0].Name;
        }

        //Prevent modifying the Opportunity Name once Probability is greater than 50%
        for (Opportunity opp : opportList) {
            if (profileName != 'System Administrator' && opp.Probability > 50) {
                opp.Name.addError('Non Admin user can not modify Opportunity if Probability greater than 50%');
            }
        }
    }
    public static void preventUsersToDeleteOpportunity(List <Opportunity> oppList) {
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Id =:UserInfo.getProfileId()];
        String profileName = null;
        if (!profiles.isEmpty()) {
            profileName = profiles[0].Name;
        }

        //Prevent Opportunity from being deleted if Probability greater than or equal to 75%
        for (Opportunity opt : oppList) {
            if (profileName != 'System Administrator' && opt.Probability >= 75) {
                opt.addError('Non Admin user can not delete Opportunity if Probability greater or equals to 75%');

            }
        }
    }
}

