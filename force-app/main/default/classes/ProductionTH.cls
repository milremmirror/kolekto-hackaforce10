/**
 * @milremmirror
 */

public class ProductionTH extends TriggerHandler {
    
    List<Production__c> newProductions;
    Map<Id, Production__c> oldProductions;
    ProductionFilter filter;
    UpdateStock stock;
    ProductionRepository repository;
    UpdateProductFields productFields;

    
    public ProductionTH() {
        this ((List<Production__c>) Trigger.new, (Map<Id, Production__c>) Trigger.oldMap);
    }

    public ProductionTH( List<Production__c> newProductions, Map<Id, Production__c> oldProductions){
        this.newProductions = newProductions;
        this.oldProductions = oldProductions;
        this.filter = new ProductionFilter();
        this.stock = new UpdateStock();
        this.repository = new ProductionRepository();
        this.productFields = new UpdateProductFields();
    }

    override
    public void afterInsert() {

        updateStockByNewProduction();

        updateProductStockFieldByProduction();
    }

    override
    public void afterUpdate() {

        updateStockByNewProduction();

        updateProductStockFieldByProduction();
    }

    public void updateStockByNewProduction() {
    
        for (Production__c production : newProductions){

            stock.updateStockByNewProduction(production);
        }
    }

    public void updateProductStockFieldByProduction(){

        List<Production__c> productions = repository.findAll();

        productFields.UpdateFieldsByProduction(productions);
    }
}
