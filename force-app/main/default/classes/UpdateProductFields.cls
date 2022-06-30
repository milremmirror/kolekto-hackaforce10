/**
 * @milremmirror
 */
public class UpdateProductFields {
    
    public void UpdateFieldsByProduction(List<Production__c> productions) {

        List<Product2> products = new List<Product2>();
        ProductRepository productRepository = new ProductRepository();
        ProductionFilter filter = new ProductionFilter();

        products = productRepository.findAllProducts();
        
        for(Product2 product : products) {

            List<Production__c> filteredProductions = filter.byProductId(productions, product.Id);

            updateFields(filteredProductions, product);

            productRepository.save(product);
        }
    }

    public void updateFields (List<Production__c> productions, Product2 product){

        product.Inicial_Stock__c = 0;
        product.Stock__c = 0;
        
        for(Production__c production : productions){

            product.Inicial_Stock__c += production.Yeld__c;

            if (production.ExpiryDate__c > System.today() ){

                product.Stock__c += production.Stock__c;
            }
        }
    }
}
