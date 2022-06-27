/**
 * @milremmirror
 */

public class ProductionFilter {
    
    public List<Production__c> byProductId(List<Production__c> productionsList, String productId){

        List<Production__c> filteredProductions = new List<Production__c>();

        for (Production__c production : productionsList) {

            if (productId == production.Product__c) {

                filteredProductions.add(production);
            }
        }
        return filteredProductions;
    }

    public List<Production__c> byNotEmptyStock(List<Production__c> productionList){
        
        List<Production__c> filteredProductions = new List<Production__c>();

        for (Production__c production : productionList){
            
            if (production.Stock__c > 0){
                
                filteredProductions.add(production);
            }
        }
        return filteredProductions;
    }

    public List<Production__c> byValidExpiryDate(List<Production__c> productionList){

        List<Production__c> filteredProductions = new List<Production__c>();
        
        for (Production__c production : productionList){
            
            if (production.ExpiryDate__c > System.today()){

                filteredProductions.add(production);
            }
        }
        return filteredProductions;
    }

    
}
