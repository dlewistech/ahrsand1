public class DynamicSearchBController {
    public List<Opportunity> allOpps {get;set;}
    
    public DynamicSearchBController() {
        allOpps = [SELECT id, name, createdDate, Owner.Name, RecordType.Name, Account.Name FROM Opportunity];
    }

}