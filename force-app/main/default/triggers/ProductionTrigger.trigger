/**
 * @milremmirror
 */
trigger ProductionTrigger on Production__c (after insert, after update) {

    new ProductionTH().run();

}