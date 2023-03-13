import { LightningElement, track, api, wire } from 'lwc';
import getAccount from '@salesforce/apex/MyFirstComponentController.getAccount';
import getOpportunities from '@salesforce/apex/MyFirstComponentController.getOpportunities';
import saveOpportunities from '@salesforce/apex/MyFirstComponentController.saveOpportunities';
import OPPORTUNITY_NAME from '@salesforce/schema/Opportunity.Name';
import OPPORTUNITY_STAGE_NAME from '@salesforce/schema/Opportunity.StageName';
import OPPORTUNITY_CLOSE_DATE from '@salesforce/schema/Opportunity.CloseDate';
import OPPORTUNITY_AMOUNT from '@salesforce/schema/Opportunity.Amount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [
    { label: 'Name', fieldName: OPPORTUNITY_NAME.fieldApiName, type:'text', editable: false },
    { label: 'Stage Name', fieldName: OPPORTUNITY_STAGE_NAME.fieldApiName, type:'text', editable: false },
    { label: 'Close Date', fieldName: OPPORTUNITY_CLOSE_DATE.fieldApiName, type:'Date', editable: false },
    { label: 'Amount', fieldName: OPPORTUNITY_AMOUNT.fieldApiName, type:'Number', editable: true },
]

export default class MyFirstComponent extends LightningElement {
    @api recordId;
    title = 'Titulo';
    @track input;
    opportunities = [];
    columns = COLUMNS;
    error;

    @wire(getOpportunities, {accountId: '$recordId'})
    wiredOpportunities({error,data}){
        if(data){
            this.opportunities = data;
            error = null
        }else{
            console.log(error);
        }
    }
    buttonFunction() {
        console.log('se presiono el boton');
        getOpportunities({accountId: this.input}).then(
            response => {
                this.opportunities = response;
                console.log(this.opportunities);
            }
        ).catch(
            err => {
                console.log(err);
            }
        );
    }

    handleInput(event){
        this.input = event.target.value;
        console.log(event.target.value);
    }

    handleSave(event){
        const recordEdited = JSON.parse(JSON.stringify(event.detail.draftValues));
        saveOpportunities({opportunities: recordEdited}).then(
            response =>{
                this.showToast('actualizadas', 'se han actualizado las oportunidades', 'success')
            }
        ).catch(
            err => {
                this.showToast('ocurrio un error', err, 'error')
            }
        )
    }

    showToast(titile,message,variant){
        const event = new ShowToastEvent({
            title: titile,
            message:message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

   
}