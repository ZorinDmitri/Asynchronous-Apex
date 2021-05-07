@isTest
public class AddPrimaryContactTest {
    private static final Integer MAXACCOUNTNUMBER = 50;
    @testSetup
    static void setup() {
        List<Account> accountsNY = new List<Account>();
        for (Integer i = 0; i < MAXACCOUNTNUMBER; i++) {
			Account newAccount = new Account(Name='TestAccount'+i, BillingState = 'NY');
			accountsNY.add(newAccount);
        }
        insert accountsNY;

        List<Account> accountsCA = new List<Account>();
        for (Integer i = 0; i < MAXACCOUNTNUMBER; i++) {
			Account newAccount = new Account(Name='TestAccount'+i, BillingState = 'CA');
			accountsCA.add(newAccount);
        }
        insert accountsCA;


    }

    static testmethod void testQueueable() {
        Contact newContact = new Contact();
        newContact.FirstName = 'TestFirstName';
        newContact.LastName = 'TestLastName';

        AddPrimaryContact contactAdder = new AddPrimaryContact(newContact, 'CA');
        Test.startTest();
        System.enqueueJob(contactAdder);
        Test.stopTest();
        Integer addedContacts = [SELECT Count() FROM Contact WHERE AccountId In (SELECT Id FROM Account WHERE BillingState = 'CA')];
		System.AssertEquals(50, addedContacts);
    }

}
