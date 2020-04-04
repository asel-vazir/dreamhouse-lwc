/**
 * Created by Asel on 4/3/20.
 */

global class FOBCallouts implements Schedulable{

    global void execute(SchedulableContext SC) {

        List<Tenant__c> tenants = new List<Tenant__c>();
        for(Tenant__c ten : tenants){
            if(ten.Move_Out_Date__c == System.today()){

                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://fobworks.herokuapp.com/');
                request.setMethod('POST');
                request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                request.setBody('{"name" : "Tenant Name"}');
                HttpResponse response = http.send(request);

                if(response.getStatusCode() != 201){
                    System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());

                    else{
                    System.debug(response.getBody());
                }
            }
        }
    }
}
