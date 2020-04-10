/**
 * Created by Asel on 4/7/20.
 */

import { LightningElement, api,wire } from 'lwc';
// imports a getFieldValue helper function to retrieve field values
import {getRecord, getFieldDisplayValue} from 'lightning/uiRecordApi';
//imports the Property__c.Broker__c field via a schema import instead of using a hard-coded string
//like we did previously in the property location component
//The major benefit of this approach is that it ensures referential integrity.
import BROKER_FIELD from '@salesforce/schema/Property__c.Broker__c';
const propertyFields = [BROKER_FIELD];
export default class PropertyBroker extends LightningElement {
    @api recordId; //Property Id
    //We retrieve the Property record using the @wire decorator and the getRecord adapter.
    @wire(getRecord, {recordId:'$recordId', fields: propertyFields})
    property;
    //We expose a brokerId expression. The expression uses the getFieldValue function to retrieve the value of the br field.
    get brokerId(){
        return getFieldDisplayValue(this.property.data, BROKER_FIELD);
    }

}