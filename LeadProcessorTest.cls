@isTest
private class LeadProcessorTest {
    private static final Integer RECORDS_NUMBER = 200;
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i < RECORDS_NUMBER; i++) {
            leads.add(new Lead(Company='TestCompany'+i, LastName='LastName'+i));
        }
        insert leads;
    }

    @isTest static void test() {
        Test.startTest();
        LeadProcessor leads = new LeadProcessor();
        Id batchId = Database.executeBatch(leads);
        Test.stopTest();
        Integer testLeadsNumber = [SELECT Count() FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, testLeadsNumber);
    }

}
