import { LightningElement, api } from 'lwc';
import OPPORTUNITY_NAME from '@salesforce/schema/Opportunity.Name';
import OPPORTUNITY_STAGE_NAME from '@salesforce/schema/Opportunity.StageName';
import OPPORTUNITY_CLOSE_DATE from '@salesforce/schema/Opportunity.CloseDate';
import OPPORTUNITY_AMOUNT from '@salesforce/schema/Opportunity.Amount';

const COLUMNS = [
    { label: 'Name', fieldName: OPPORTUNITY_NAME.fieldApiName, type:'text', editable: false },
    { label: 'Stage Name', fieldName: OPPORTUNITY_STAGE_NAME.fieldApiName, type:'text', editable: false },
    { label: 'Close Date', fieldName: OPPORTUNITY_CLOSE_DATE.fieldApiName, type:'Date', editable: false },
    { label: 'Amount', fieldName: OPPORTUNITY_AMOUNT.fieldApiName, type:'Number', editable: true },
]
export default class OpportunitiesTable extends LightningElement {
    @api opportunities = []
    columns = COLUMNS

    handleSave(event){
        const recordEdited = JSON.parse(JSON.stringify(event.detail.draftValues));
        const eventToSend = new CustomEvent(
            'sendopportunities',
            {
                detail:recordEdited
            }
        )
        this.dispatchEvent(eventToSend);
    }
}