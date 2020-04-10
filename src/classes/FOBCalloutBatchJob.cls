/**
 * Created by Asel on 4/3/20.
 */
global class FOBCalloutBatchJob implements Database.Batchable<SObject>, Database.AllowsCallouts{

    global Database.QueryLocator start(Database.BatchableContext BC){

    return Database.getQueryLocator([
            SELECT Name, Id, Move_Out_Date__c, Property__c
            FROM Tenant__c
            WHERE Move_Out_Date__c = TODAY
    ]);

    }

    global void execute(Database.BatchableContext BC, List<Tenant__c> tenants) {

        for (Tenant__c ten : tenants){
                if(ten.Move_Out_Date__c == System.today()) {

                    Http http = new Http();
                    HttpRequest request = new HttpRequest();
                    request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
                    request.setMethod('POST');
                    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    request.setBody('{"name" : "Tenant"}');
                    HttpResponse response = http.send(request);

                    if (response.getStatusCode() != 201) {
                        System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
                    } else {
                        System.debug(response.getBody());
                    }
           }
        }
    }

    global void finish(Database.BatchableContext BC) {
    }

}