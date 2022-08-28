public class DynamicSearchAController {

    public List<Account> allAccounts {get;set;}
    public List<Contact> allContacts {get;set;}
    
    public DynamicSearchAController() {
        allAccounts = [SELECT id, name FROM Account WHERE Id NOT IN (SELECT AccountId FROM Contact)];
        allContacts = [SELECT id, firstname, lastname, Account.Name FROM Contact];
    }
}