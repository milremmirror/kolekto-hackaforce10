/**
 * @author @milremmirror
 */

public class CreateOpportunity {
    
    OpportunityRepository repository;
    ProductRepository productRepository;
    
    public CreateOpportunity() {
        this.repository = new OpportunityRepository();
        this.productRepository = new ProductRepository();
    }

    public void createOpportunityByPricesComparing() {
        
        List<Painel_Entry__c> entries = repository.findAllPainelEntries();
        List<Product2> products = productRepository.findAllProducts();
        List<Opportunity> newOpportunities = new List<Opportunity>();

        for (Product2 product : products){
            
            for (Painel_Entry__c entry : entries){

                compareAvaragePrices(entry,  product);
            }
        }        
    }
    
    private void compareAvaragePrices(Painel_Entry__c entry, Product2 product){
        
        if(entry.Product__c == product.Id){
            
            if(product.Current_Stock_Price__c < entry.Medium_Price__c){
                
                repository.save( buildOpportunity(repository.findAccountById(entry.Account__c), product, entry) );
            }
        }
    }


    private Opportunity buildOpportunity (Account account, Product2 product, Painel_Entry__c entry) {
        return new Opportunity (  Name = 'New Opportunity with ' + product.Name
                                , AccountId = account.Id
                                , CloseDate = Date.today() + 1
                                , StageName = 'Prospecting'
                                , Description = 'The product ' + product.Name + ' costs $' + product.Current_Stock_Price__c + ' and the avarage sale price for this Account is $' + entry.Medium_Price__c);

    }
} 
