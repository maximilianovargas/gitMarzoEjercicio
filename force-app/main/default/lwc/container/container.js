import { LightningElement, wire, api } from 'lwc';
import getOpportunities from '@salesforce/apex/MyFirstComponentController.getOpportunities';
import getOpportunitiesOpen from '@salesforce/apex/MyFirstComponentController.getOpportunitiesOpen';
import saveOpportunities from '@salesforce/apex/MyFirstComponentController.saveOpportunities';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Container extends LightningElement {
    @api recordId;
    opportunitiesContainerOpen = [];
    opportunitiesContainerClosed = [];
    opportunitiesFromTable = []

    error;
    @wire(getOpportunitiesOpen, {accountId: '$recordId'})
    wiredOpportunitiesOpen({error,data}){
        if(data){
            console.log()
            this.opportunitiesContainerOpen = data;
            error = null
        }else{
            console.log(error);
        }
    }

    @wire(getOpportunities, {accountId: '$recordId'})
    wiredOpportunities({error,data}){
        if(data){
            console.log()
            this.opportunitiesContainerClosed = data;
            error = null
        }else{
            console.log(error);
        }
    }

    handleEvent(event){
       this.opportunitiesFromTable = event.detail;

       saveOpportunities({opportunities: this.opportunitiesFromTable}).then(
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