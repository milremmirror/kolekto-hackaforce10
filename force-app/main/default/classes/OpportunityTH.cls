/**
 * @author @milremmirror
 */

public with sharing class OpportunityTH extends TriggerHandler {
    
    public List<Opportunity> newOpportunities;
    public Map<Id, Opportunity> oldOpportunities;
    public OpportunityRepository repository;
    public OpportunityFilter filter;
    public UpdateStock updater;
    public MediumPriceCalculator calculator;
    public ProductRepository productRepository; 
    public ProductionRepository productionRepository;
    

    public OpportunityTH() {
        this ((List<Opportunity>) Trigger.new, (Map<Id, Opportunity>) Trigger.oldMap);
    }

    public OpportunityTH( List<Opportunity> newOpportunities,  Map<Id, Opportunity> oldOpportunities){
        this.newOpportunities = newOpportunities;
        this.oldOpportunities = oldOpportunities;
        this.repository = new OpportunityRepository();
        this.filter = new OpportunityFilter();
        this.updater = new UpdateStock();
        this.calculator = new MediumPriceCalculator();
        this.productRepository = new ProductRepository();
        this.productionRepository = new ProductionRepository();
    }

    override
    public void afterUpdate() {

        updateProductStock();

        calculateOpportunityProductsAmountAndQuantity();

        calculateMediumPriceToProduct();

    }

    public void updateProductStock(){
       
        List<Opportunity> filteredOpportunities = filter.byStage(filter.ByChangedStage(newOpportunities, oldOpportunities), 'Closed Won');
        
        System.debug('UPDATE PRODUDUCT ------------>' + filteredOpportunities);

        if(filteredOpportunities.size()>0){ 
    
            updater.updateStockByClosedOpportunity(filteredOpportunities);
        }
    }
    
    public void calculateMediumPriceToProduct(){
        
        List<Painel_Entry__c> entries = repository.findAllPainelEntries();

        List<Product2> products = productRepository.findAllProducts();

        calculator.calculateTotalEarned(entries, products);
    }

    public void calculateOpportunityProductsAmountAndQuantity(){
        
        List<Opportunity> filteredOpportunities = filter.byStage(filter.ByChangedStage(newOpportunities, oldOpportunities), 'Closed Won');
        
        if (filteredOpportunities.size()>0){

            for (Opportunity opportunity : filteredOpportunities){

                List<OpportunityLineItem> opportunityProducts = new List<OpportunityLineItem>();
                
                opportunityProducts = repository.findOpportunityLineItemByOpportunityId(opportunity.Id);

                calculator.calculate(opportunityProducts);
            }
        }
    }
}
