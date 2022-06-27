/**
 * @author @milremmirror
 */

trigger OpportunityTrigger on Opportunity (after update) {

    new OpportunityTH().run();
}