/**
 * @author @milremmirror
 */
trigger PainelEntryTrigger on Painel_Entry__c (after update) {
    
    new PainelEntryTH().run();

}