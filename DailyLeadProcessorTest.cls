@isTest
public class DailyLeadProcessorTest {
	private static final Integer NUMBER_OF_LEADS=200;
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    @isTest
    public static void testDailyLeadProcessorJob(){
        List<Lead> testLeads = new List<Lead>();
        for (Integer i=0; i<NUMBEROFLEADS; i++) {
            testLeads.add(new Lead(LastName='TestLead'+i, LeadSource='', Company='TestLead'+i));
        }
       	insert testLeads;

        Map<Id, Lead> leadMap = new Map<Id, Lead>(testLeads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());

        Test.startTest();
		String jobId = System.schedule('DailyLeadProcessorTest',CRON_EXP,new DailyLeadProcessor());
        List<Lead> leadsBefore = [SELECT Id from Lead where LeadSource = null and id in :leadIds];
    	System.assertEquals(200,leadsBefore.size());
        Test.stopTest();

        List<Lead> leadsAfter = [SELECT Id from Lead where LeadSource = null and id in :leadIds];
 		System.assertEquals(0,leadsAfter.size());
    }
}
