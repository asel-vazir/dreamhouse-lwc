/**
 * Created by Asel on 4/7/20.
 */

import { LightningElement, api, wire } from 'lwc';
//We import a getRecord adapter that allow us to use the Lightning Data Service to retrieve records without having to write Apex
import {getRecord} from 'lightning/uiRecordApi'
//We assemble a list of hard-coded field names from the Property__c object in the fields constant.
const fields = [
    'Property__c.Name',
    'Property__c.Location__Latitude__s',
    'Property__c.Location__Longitude__s'
];
export default class PropertyLocation extends LightningElement {
    //The recordId property decorated with @api automatically receives the current record id.
    @api recordId;
    name;
    mapMarkers = [];
    //A @wire decorator on the loadProperty function fetches data and errors then pass them to the function
    @wire(getRecord, {recordId: '$recordId', fields})
    loadProperty({error, data}) {
        if (error){
            	// TODO: handle error
        }
        else if (data) {
            //Get Property data
            this.name = data.fields.Name.value;
            const Latitude = data.fields.Location__Latitude__s.value;
            const Longitude = data.fields.Location__Longitude__s.value;
            //Transform property data into map markers
            this.mapMarkers = [{
                location: {Latitude, Longitude},
                title: this.name,
                description: `Coords: ${Latitude}, ${Longitude}`
            }];
        }
    }
    get cardTitle(){
        return (this.name) ? `${this.name}'s location` : 'Property location';
    }
}