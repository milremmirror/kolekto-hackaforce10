/**
 * @milremmirror
 */
@IsTest
public  class ScheduleOpportunityByExpiryDateTest {
    
    @TestSetup
    static void makeData(){

        Product2 product = new Product2(
            Name = 'New Beer',
            Stock__c = 100,
            IsActive =  true
        );

        insert product;

        Production__c firstProduction = new Production__c(
            Name = 'Test production',
            Yeld__c = 40,
            ExpiryDate__c = System.today().addDays(1),
            Stock__c = 40,
            Product__c = product.Id
        );

        insert firstProduction; 
    }
    
    @IsTest
    public static void GivenProductionWhenNearToExpirationThenCreateOpportunity() {

        OpportunityRepository repository = new OpportunityRepository();
        
        String cronExpression = '0 0 0 * * ?';

        Test.startTest();
        
        System.schedule('ScheduleOpportunityByExpiryDate', cronExpression, new ScheduleOpportunityByExpiryDate());

        Test.stopTest();

        List<Opportunity> opportunities = repository.findAll();

        System.assert(!opportunities.isEmpty());

    }
}
