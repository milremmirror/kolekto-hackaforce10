/**
 * @milremmirror
 */

public class ProductRepository extends AbstractRepository{
    
    public List<OpportunityLineItem> findProductsByOpportunityId (String opportunityId){
        return  [SELECT Name, Product2Id, Quantity, OpportunityId FROM OpportunityLineItem WHERE OpportunityId = :opportunityId];
    }
    
    public Product2 findProductByCode(String code){
        return [SELECT Name, Id, Stock__c, ProductCode FROM Product2 WHERE ProductCode  = :code];
    }
    
    public Product2 findProductById(String productId){
        return [SELECT Name, Id, Stock__c, Current_Stock_Price__c FROM Product2 WHERE Id = :productId];
    }
    
    public List<Product2> findAllProducts(){ 
        return [SELECT Name, Id, Stock__c, Current_Stock_Price__c, Total_earned__c FROM Product2];
    }
    
    
}
