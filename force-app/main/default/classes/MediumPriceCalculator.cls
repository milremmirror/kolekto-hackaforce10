/**
 * @author @milremmirror
 */
public  class MediumPriceCalculator {
    
    OpportunityRepository repository;
    ProductRepository productRepository;

    public MediumPriceCalculator() {
        this.repository = new OpportunityRepository();
        this.productRepository = new ProductRepository();
    }

    public void calculate (List<OpportunityLineItem> opportunitiesProductItemList) {

        for (OpportunityLineItem opportunityProduct : opportunitiesProductItemList){
            
            updateFields(productRepository.findProductByCode(opportunityProduct.ProductCode), opportunityProduct);
        }
    
    }
    
    public void updateFields (Product2 product, OpportunityLineItem opportunityProduct){
        
        List<Painel_Entry__c> entries = repository.findAllPainelEntries();
        Opportunity opportunity = repository.findOpportunityById(opportunityProduct.OpportunityId);
        Account account = repository.findAccountById(opportunity.AccountId);
     
        for (Painel_Entry__c entry : entries){

            if (account.Id == entry.Account__c && product.Id == entry.Product__c){    
        
                Decimal aux = 0;

                aux = entry.Total_Sold__c;
                entry.Total_Sold__c = opportunityProduct.TotalPrice + aux;

                aux = entry.Total_Quantity_Sold__c;
                entry.Total_Quantity_Sold__c =+ opportunityProduct.Quantity + aux;
            }
        }    
        repository.save(entries);
    }


    public void calculateTotalEarned (List<Painel_Entry__c> entries, List<Product2> products){

        for (Product2 product : products){
            product.Total_earned__c = 0;
        }

        for (Painel_Entry__c entry : entries){
   
            for (Product2 product : products){
                
                updateFields(entry, product);
            }
        }
    }
    
    public void updateFields(Painel_Entry__c entry, Product2 product){
        
        if(product.Id == entry.Product__c){

            if (entry.Total_Sold__c != null){
                
                product.Total_earned__c += entry.Total_Sold__c;
            }
        }

        repository.save(product);
    }
}
  