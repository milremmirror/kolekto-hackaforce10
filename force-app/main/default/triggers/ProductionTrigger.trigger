/**
 * @milremmirror
 */
trigger ProductionTrigger on Production__c (after insert) {

    new ProductionTH().run();

}