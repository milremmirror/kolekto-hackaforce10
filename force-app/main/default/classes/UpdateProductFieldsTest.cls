/**
 * @milremmirror
 */

@IsTest
public class UpdateProductFieldsTest {
    
    @TestSetup
    static void makeData(){

        ProductionRepository repository = new ProductionRepository();

        Product2 product = new Product2(
            Name = 'New Beer',
            Stock__c = 0,
            Inicial_Stock__c = 0,
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

    }

    @IsTest
    public static void shouldUpdateProductStockAndInitialStockFields() {

        UpdateProductFields updater = new UpdateProductFields();
        ProductRepository productRepository = new ProductRepository();
        ProductionRepository productionRepository = new ProductionRepository();

        List<Production__c> productions = productionRepository.findAll();

        updater.UpdateFieldsByProduction(productions);

        Product2 product = productRepository.findProductById(productions[0].Product__c);

        Decimal actualStock = product.Stock__c;
        Decimal expectedStock = productions[0].Stock__c;

        System.assertEquals(actualStock, expectedStock);
    }
}
