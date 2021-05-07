public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String state;
    private final static Integer MAXACCOUNTNUMBER = 200;

    public AddPrimaryContact(Contact incContact, String stateAbb){
    	this.contact = incContact;
        this.state = stateAbb;
    }

    public void execute(QueueableContext context) {
        List<Contact> contactList = new List<Contact>();
        List<Account> accountList = [SELECT Id FROM Account WHERE BillingState = :state LIMIT :MAXACCOUNTNUMBER];
        for (Account account : accountList) {
            Contact newContact = contact.clone(false,true);
            newContact.AccountId = account.Id;
            contactList.add(newContact);
        }
        insert contactList;
    }

}
