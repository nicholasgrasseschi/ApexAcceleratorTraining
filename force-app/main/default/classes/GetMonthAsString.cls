public class GetMonthAsString {

    public string returnMonthAsString(Integer int) {
        String returnStr;

        switch on int {
            when 1 {
                returnStr = 'Janurary';
            } when 2 {
                returnStr = 'Feburary';
            } when 3 {
                returnStr = 'March';
            } when 4 {
                returnStr = 'April';
            } when 5 {
                returnStr = 'May';
            } when 6 {
                returnStr = 'June';
            } when 7 {
                returnStr = 'July';
            } when 8 {
                returnStr = 'August';
            } when 9 {
                returnStr = 'September';
            } when 10 {
                returnStr = 'October';
            } when 11 {
                returnStr = 'November';
            } when 12 {
                returnStr = 'December';
            }
        }
        return returnStr;
    }
}
