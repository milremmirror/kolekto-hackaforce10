/**
 * @milremmirror
 */

@IsTest
public class UpdateStockTest {
    
    @TestSetup
    static void makeData(){

        OpportunityRepository repository = new OpportunityRepository();
        
        Product2 product = new Product2(
            Name = 'New Beer',
            Stock__c = 100,
            IsActive =  true
        );

        repository.save(product);

        Production__c firstProduction = new Production__c(
            Name = 'Test production',
            Yeld__c = 40,
            ExpiryDate__c = System.today().addDays(1),
            Stock__c = 40,
            Product__c = product.Id
        );

        repository.save(firstProduction);

        Production__c secondProduction = new Production__c(
            Name = 'New Test production',
            Yeld__c = 30,
            ExpiryDate__c = System.today().addDays(1),
            Stock__c = 30,
            Product__c = product.Id
        );
        
        repository.save(secondProduction);
            
        Id standardPricebookId = Test.getStandardPricebookId();

        PricebookEntry pricebookEntry = new PricebookEntry(
        Pricebook2Id = standardPricebookId,
        Product2Id = product.Id,
        UnitPrice = 10,
        IsActive = true
        );
        
        repository.save(pricebookEntry);

        Pricebook2 customPricebook = new Pricebook2(
            Name = 'Custom Pricebook',
            IsActive = true
        );

        repository.save(customPricebook);

        PricebookEntry customPrice = new PricebookEntry(
            Pricebook2Id = customPricebook.Id,
            Product2Id = product.Id,
            UnitPrice = 50,
            IsActive = true
        );
        
        repository.save(customPrice);

        Opportunity testOpportunity = new Opportunity(
            Name = 'Opportunidade teste',
            CloseDate = System.today().addDays(1),
            StageName = 'Closed Won',
            Pricebook2 = customPricebook
        );

        repository.save(testOpportunity);

        OpportunityLineItem itens = new OpportunityLineItem(
            OpportunityId = testOpportunity.Id,
            Product2Id = product.Id,
            Quantity = 50,
            UnitPrice = 50.00,
            PricebookEntryId = customPrice.Id
        );

        repository.save(itens);
    }

    @IsTest
    public static void givenOpportunityWhenCloseWonThenUpdateProductionStock() {
        
        UpdateStock updateStock = new UpdateStock();

        OpportunityRepository opportunityRepository = new OpportunityRepository();
        ProductionRepository productionRepository = new ProductionRepository();

        List<Opportunity> opportunityList = new List<Opportunity>();
        
        opportunityList = opportunityRepository.findByStage('Closed Won');
        
        updateStock.updateStockByClosedOpportunity(opportunityList);

        List<Production__c> productions = productionRepository.findByName('Test production');

        Decimal actualStock = productions[0].Stock__c;
        Decimal expectedStock = 0;

        System.assertEquals(expectedStock, actualStock);
    }
} 
