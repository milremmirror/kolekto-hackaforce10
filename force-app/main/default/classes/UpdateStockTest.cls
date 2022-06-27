/**
 * @milremmirror
 */

@IsTest
public class UpdateStockTest {

    @IsTest
    public static void givenOpportunityWhenCloseWonThenUpdateProductionStock() {
        
        OpportunityRepository repository = new OpportunityRepository();
        ProductRepository productRepository = new ProductRepository();
        UpdateStock updateStock = new UpdateStock();
        List<Opportunity> opportunityList = new List<Opportunity>();
        
        Opportunity testOpportunity = new Opportunity(
            Name = 'Opportunidade teste',
            CloseDate = System.today(),
            StageName = 'Closed Won'
        );
        
        repository.save(testOpportunity);
            
        Product2 product = new Product2(
            Name = 'New Beer'
        );
        
        repository.save(product);

        Production__c firstProduction = new Production__c(
            Name = 'Teste production',
            Yeld__c = 40,
            ExpiryDate__c = System.today().addDays(1),
            Product__c = product.Id
        );
        
        repository.save(firstProduction);

        Production__c secondProduction = new Production__c(
            Name = 'Teste production',
            Yeld__c = 30,
            ExpiryDate__c = System.today().addDays(1),
            Product__c = product.Id
        );
        
        repository.save(secondProduction);
            
        OpportunityLineItem itens = new OpportunityLineItem(
            Opportunity = testOpportunity,
            Product2 = product,
            Quantity = 50
        );
    
        repository.save(itens);
        
        Decimal stock = firstProduction.Yeld__c;
        Decimal expectedStock = 0;
        
        Test.startTest();
        
        
        Test.stopTest();
        
        
        System.assertEquals(expectedStock, stock);

    }
}
