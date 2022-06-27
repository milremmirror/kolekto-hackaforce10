/**
 * 
 */
public class OpportunityFilter {
    
    
    public List<Opportunity> byChangedStage(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities) {

        List<Opportunity> filteredOpportunities = new List<Opportunity>();

        for (Opportunity opportunity: newOpportunities){
         
            Opportunity oldOpportunity = oldOpportunities.get(opportunity.Id);
            
            if (oldOpportunity.StageName != opportunity.StageName ){

                filteredOpportunities.add(opportunity);
            }
        }
        
        return filteredOpportunities;  
    }

    public List<Opportunity> byStage(List<Opportunity> opportunityList, String stage){
        
        List<Opportunity> filteredOpportunities = new List<Opportunity>();

        for (Opportunity opportunity: opportunityList){
         
            if (opportunity.StageName == stage ){

                filteredOpportunities.add(opportunity);
            }
        }
        
        return filteredOpportunities;  
    }

    


}
