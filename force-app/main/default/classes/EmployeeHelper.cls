public class EmployeeHelper {
    private static List<Account> acctList = new List<Account>();
    private static List<Account> acctsToUpdate = new List<Account>();

    public static void addEmployees() {
        acctList = [SELECT NumberOfEmployees, Rating FROM Account];

        for (Account acct : acctList) {
            // if NumEmployees is null or 0
            if (acct.NumberOfEmployees == null || acct.NumberOfEmployees == 0) {
                // generate a random number 0-1000
                Integer randomNumber = Integer.valueof((Math.random() * 1000));
                // set # of employees to new number
                acct.NumberOfEmployees = randomNumber;

                // set rating based on number of new employees
                if (randomNumber>=0 && randomNumber<=100) {
                    acct.Rating = 'Cold';
                } else if (randomNumber>=101 && randomNumber<=500) {
                    acct.Rating = 'Warm';
                } else if (randomNumber>=501 && randomNumber<=1000) {
                    acct.Rating = 'Hot';
                }
                // add account to update list
                acctsToUpdate.add(acct);
            }
        }
        update acctsToUpdate;
    }// end addEmployees method
} // end class