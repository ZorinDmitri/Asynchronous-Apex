public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        List <Account> accountList = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id in :accountIds];
        for (Account account : accountList) {
            List<Contact> contactList = account.Contacts;
            account.Number_of_Contacts__c = contactList.size();
        }
        update accountList;
    }
}
