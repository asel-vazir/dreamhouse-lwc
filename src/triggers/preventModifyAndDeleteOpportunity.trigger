/**
 * Created by Asel on 5/7/20.
 */

trigger preventModifyAndDeleteOpportunity on Opportunity (before update, before delete, after update) {
    switch on Trigger.operationType {
        when AFTER_UPDATE {
            PreventModifyDeleteOpportunity.preventUsersToModifyOpportunity(Trigger.new);
        }
        when BEFORE_DELETE {
            PreventModifyDeleteOpportunity.preventUsersToDeleteOpportunity(Trigger.old);
        }
    }
}