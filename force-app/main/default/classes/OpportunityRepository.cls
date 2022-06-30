/**
 * @author @milremmirror
 */

public class OpportunityRepository extends AbstractRepository {
    
    public List<Opportunity> findByStage (String stage){
        return  [SELECT Id FROM Opportunity WHERE StageName = :stage];
    }

    public List<Opportunity> findAll (){
        return  [SELECT Id, Name FROM Opportunity];
    }

    public Opportunity findOpportunityById (String opportunityId){
        return  [SELECT FIELDS(STANDARD) FROM Opportunity WHERE Id = :opportunityId];
    }


    
    public List<OpportunityLineItem> findAllOpportunityProducts (){
        return [SELECT Name, Product2Id, Quantity, OpportunityId FROM OpportunityLineItem ];
    }
    
    
    public List<OpportunityLineItem> findOpportunityLineItemByOpportunityId(String opportunity){
        return [SELECT Name, Product2Id, Quantity, ProductCode, OpportunityId, TotalPrice  FROM OpportunityLineItem WHERE OpportunityId = :opportunity];
    }
    
    
    
    

    
    public Account findAccountById (String accountId){
        return  [SELECT Id, Name FROM Account WHERE Id = :accountId];
    }


    
    public List<Painel_Entry__c> findAllPainelEntries (){
        return [SELECT Id, Name, Account__c, Product__c, Total_Sold__c, Total_Quantity_Sold__c, Medium_Price__c FROM Painel_Entry__c];
    }

}

