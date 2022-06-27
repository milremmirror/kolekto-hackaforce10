/**
 * @author @milremmirror
 */

public class PainelEntryTH extends TriggerHandler {
    
    List<Painel_Entry__c> newPainelEntries;
    Map<Id, Painel_Entry__c> oldPainelEntries;
    CreateOpportunity creator;

    
    public PainelEntryTH() {
        this ((List<Painel_Entry__c>) Trigger.new, (Map<Id, Painel_Entry__c>) Trigger.oldMap);
    }

    public PainelEntryTH(List<Painel_Entry__c> newPainelEntries,  Map<Id, Painel_Entry__c> oldPainelEntries) {
        this.newPainelEntries = new List<Painel_Entry__c>();
        this.oldPainelEntries = new Map<Id, Painel_Entry__c>();
        this.creator = new CreateOpportunity();
    }

    override
    public void afterUpdate() {

        //createOpportunityBasedOnAvaragePrices();
    
    }

    public void createOpportunityBasedOnAvaragePrices(){

        creator.createOpportunityByPricesComparing();
        
    }

}
