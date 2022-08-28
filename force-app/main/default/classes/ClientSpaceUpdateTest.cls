@isTest
private class ClientSpaceUpdateTest {
    static testMethod void createWorkQueueTest() {
        Account testAccount = new Account(Name = 'TestAccount');
        insert testAccount;
        
        Contact testContact = new Contact(LastName = 'TestContact', AccountId = testAccount.Id);
        insert testContact;
        
        List<RecordType> recordType = new List<RecordType>([Select Id From RecordType Where Name = 'HR' AND SObjectType = 'Opportunity']);
        String recordTypeId;
        if(recordType.size() == 0) {
            recordTypeId = '01241000000awdA';
        } else {
            recordTypeId = recordType[0].Id;
        }
        
        CheckRecursive.reset();
        Opportunity testOpportunity = new Opportunity(Name = 'TestOpportunity', StageName = 'Discovery', AccountId = testAccount.Id, CloseDate = System.today(), RecordTypeId = recordTypeId);
        insert testOpportunity;
        System.Debug (testOpportunity);
        
        List<Work_Queue__c> queueList = new List<Work_Queue__c>([Select Name From Work_Queue__c]);
        System.Debug(queueList);
        System.assertEquals(queueList.size(),1);
        CheckRecursive.reset();
        
        testAccount.Name = 'ModifiedName';
        update testAccount;    
        queueList = [Select Name From Work_Queue__c];
        System.assertEquals(queueList.size(),2);
        CheckRecursive.reset();
        
        testContact.LastName = 'ModifiedName';
        update testContact;
        queueList = [Select Name From Work_Queue__c];
        System.assertEquals(queueList.size(),3);
        CheckRecursive.reset();
    }
}