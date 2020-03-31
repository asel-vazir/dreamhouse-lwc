/**
 * Created by Asel on 3/21/20.
 */

public with sharing class classFieldnotEmptycontrl {

    public Property__c field {get; set;}
    public classFieldnotEmptycontrl(){

        field = new Property__c();
    }
    public void save(){
        if(field.Business__c == null || field.Contact__c == null){

            field.Business__c.addError('You must enter a value!');
            field.Contact__c.addError('You must enter a value!');

        if(field.Business__c != null && field.Contact__c != null){

            field.Business__c.addError('Cannot use two fields at the same time. Please choose only one field Business or Contact');
            field.Contact__c.addError('Cannot use two fields at the same time. Please choose only one field Business or Contact');
        }
        }
    }
}