@IsTest
public class AccountProcessorTest {
	@IsTest
    public static void AccountProcessorTest() {
        Account testAccount = new Account();
        testAccount.Name = 'TestAccount';
        Insert testAccount;

        Contact testContact = new Contact();
        testContact.FirstName = 'TestName';
        testContact.LastName = 'TestSurname';
        testContact.AccountId = testAccount.Id;

		Insert testContact;

        List<Id> accountIds = new List<Id>();
        accountIds.add(testAccount.Id);

        Test.startTest();
        	AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        Account resultingAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id LIMIT 1];
        System.assertEquals(1, resultingAccount.Number_Of_Contacts__c);
    }

}
