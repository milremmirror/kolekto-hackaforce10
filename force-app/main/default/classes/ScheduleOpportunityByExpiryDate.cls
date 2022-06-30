/**
 * @milremmirror
 */
public  class ScheduleOpportunityByExpiryDate implements Schedulable {

    public  void execute (SchedulableContext context) {

        scheduler();
    }

    public static void scheduler() {

        ProductionRepository productionRepository = new ProductionRepository();
        ProductRepository productRepository = new ProductRepository();
        OpportunityRepository opportunityRepository = new OpportunityRepository();
        
        List<Production__c> productions = productionRepository.findAll();

        for (Production__c production : productions) {
            
            if (production.ExpiryDate__c < System.today().addDays(30)){

                Product2 product = productRepository.findProductById(production.Product__c);

                opportunityRepository.save(buildOpportunity(product, production));
            }
        }
    }

    public static Opportunity buildOpportunity (Product2 product, Production__c production) {
        return new Opportunity (  Name = 'Near expiration production of ' + product.Name
                                , CloseDate = Date.today() + 1
                                , StageName = 'Prospecting'
                                , Description = 'There are ' + production.Stock__c + ' of ' + product.Name + ' that is near expiration date: ' + production.ExpiryDate__c);
    }

    public static void start(){

        String cronExpression = '0 0 0 * * ?';
        
        System.schedule('ScheduleOpportunityByExpiryDate', cronExpression, new ScheduleOpportunityByExpiryDate());
    }
}
