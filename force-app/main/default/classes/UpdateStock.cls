/**
 * @author @milmremmirror
 */
public class UpdateStock {

    OpportunityRepository repository; 
    ProductRepository productRepository;
    ProductionRepository productionRepository;
    ProductionFilter productionFilter;

    public UpdateStock(){
        this.repository = new OpportunityRepository();
        this.productRepository = new ProductRepository();
        this.productionRepository = new ProductionRepository();
        this.productionFilter = new ProductionFilter();
    }
     

    public void updateStockByClosedOpportunity(List<Opportunity> opportunities) {

        for (Opportunity opportunity : opportunities){
            
            List<OpportunityLineItem> opportunityProduct = productRepository.findProductsByOpportunityId(opportunity.Id);

            for (OpportunityLineItem product : opportunityProduct){

                subtractProductToStock(product.Product2Id, product.Quantity);
            }
        }
    }
    
    
    public void subtractProductToStock (String productId, Decimal quantity){
        
        List<Production__c> filteredProductions = productionFilter.byValidExpiryDate(productionFilter.byNotEmptyStock(productionRepository.findAll()));
    
        filteredProductions.sort();

        for(Integer i = 0; i < filteredProductions.size(); i++){

            Decimal difference = quantity;

            while (difference > 0 ){

                difference = compareAndSubtract(filteredProductions[i], productId, quantity);

                i++;
            }

            while (difference < 0) {
                
                quantity = difference;
                
                try {

                    difference = compareAndSubtract(filteredProductions[i], productId, quantity);

                    i++;

                } catch (Exception e) {

                    throw new EmptyStockException('There is not enought beer in stock for this sale', e);
                }
            }

            if (difference == 0 ){
                    
                break;
            }
        }
        repository.save(filteredProductions);
    }

    public Decimal compareAndSubtract (Production__c production, String productId, Decimal quantity){
    
        if (production.Product__c == productId){
            
            return subtract(quantity, production);
        }

        return quantity;
    }
    
    public Decimal subtract (Decimal quantity, Production__c production) {

        Decimal difference = 0;

        production.Stock__c -= quantity.abs();

        if (production.Stock__c < 0){

            difference = production.Stock__c;

            production.Stock__c = 0;

            return difference;
        }

        return difference;
    }

    public void updateStockByNewProduction(Production__c production) {

        addProductToStock(production.Product__c, production.Yeld__c);    
    }   

    public void addProductToStock (String productId, Decimal quantity){

        Product2 product = productRepository.findProductById(productId);
        
        product.Stock__c += quantity;

        repository.save(product);
    }


    public class EmptyStockException extends Exception {

    }
}
