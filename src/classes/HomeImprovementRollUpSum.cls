/**
 * Created by Asel on 3/31/20.
 */
public class HomeImprovementRollUpSum {

    public static void newHandler(List<Home_Improvement__c> homeImprovements) {

        List<Id> ids = new List<Id>();
        List<Property__c> properties = new List<Property__c>();

        for (Home_Improvement__c homeimp : homeImprovements) {
            ids.add(homeimp.Property__c);
        }
        for (Property__c prop : [SELECT Id,SUM_of_Improvements__c, (SELECT Id, Amount__c FROM Home_Improvements__r) FROM Property__c WHERE Id = :ids]) {
            Decimal Sum = 0;
            for (Home_Improvement__c p : prop.Home_Improvements__r) {
                Sum = Sum + p.Amount__c ;
            }
            prop.SUM_of_Improvements__c = Sum;
            properties.add(prop);
        }
        try {
            update properties ;
        } catch (Exception e) {
            System.debug('Exception :' + e.getMessage());
        }
    }
}
