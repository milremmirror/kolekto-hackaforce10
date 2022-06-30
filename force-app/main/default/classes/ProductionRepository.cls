/**
 * @milremmirror
 */
public class ProductionRepository extends AbstractRepository {
    
    public List<Production__c> findAll() {
        return [SELECT Batch__c, Name, Product__c, FabricationDate__c, ExpiryDate__c, Yeld__c, Stock__c FROM Production__c];

    }

    public List<Production__c> findByName(String name) {
        return [SELECT Batch__c, Name, Product__c, FabricationDate__c, ExpiryDate__c, Yeld__c, Stock__c FROM Production__c WHERE Name = :name];

    }
}
