public with sharing class DealGenerator {
    private static List<Account> hotColdList = new List<Account>();
    private static List<Opportunity> oppsToUpsert = new List<Opportunity>();

    public List<Opportunity> createOpportunities() {
        // create list to store valid opps we find in our related records
        //List<Opportunity> foundOppsList = new List<Opportunity>();

        hotColdList = [SELECT Rating,
                            (SELECT Stage, CloseDate, StageName, CreatedDate 
                             FROM Opportunities) 
                       FROM Account
                       WHERE Rating = 'Hot' OR Rating = 'Warm'];

        for (Account acct : hotcoldList) {
            // check to see if the acct has any related Opps
            if (!acct.Opportunities.isEmpty()) {

                // temp list of Opps in case we find multiple
                List<Opportunity> tempOpps = new List<Opportunity>();

                // loop over related opps
                for (Opportunity opp : acct.Opportunities) {
                    // check accts for existing opps
                    if ((opp.StageName != 'Closed Won' || opp.StageName != 'Closed Lost') && opp.CloseDate > Date.today() ) {
                        // add found opps to temp list
                        tempOpps.add(opp);
                    }
                }
                // initialize the primary opp we want to work with
                Opportunity mainOpp;
                for (Opportunity opp2 : tempOpps) {
                    if (mainOpp == null) {
                        // set mainOpp to be first value of tempOpps
                        mainOpp = opp2;
                    } else if (opp2.CreatedDate > mainOpp.CreatedDate) {
                        // if another opp has a more recent start date, use it instead
                        mainOpp = opp2;
                    }
                }
                // update found Opportunity
                mainOpp.CloseDate = date.Today().addDays(30);

                if (acct.Rating = 'Warm') {
                    mainOpp.StageName = 'Prospecting';
                } else if (acct.Rating = 'Hot') {
                    mainOpp.StageName = 'Qualification';
                }

                // add our opp to our upsert list
                oppsToUpsert.add(mainOpp);

            } else { // need to create a new Opp for the acct
                // first, get current month returned as a string value
                Integer monthNumber = date.today().month();
                String monthString = GetMonthAsString.returnMonthAsString(monthNumber);

                Opportunity newOpp = new Opportunity();
                newOpp.Name = acct.Name + ' - ' + monthString + ' Opportunity';
                newOpp.AccountId = acct.Id;
                if (acct.Rating = 'Warm') {
                    mainOpp.StageName = 'Prospecting';
                } else if (acct.Rating = 'Hot') {
                    mainOpp.StageName = 'Qualification';
                }

                oppsToUpsert.add(newOpp);
            }
        }
        // TODO: return the opportunity value from the method???
    }
}