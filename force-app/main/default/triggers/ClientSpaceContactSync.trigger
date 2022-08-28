trigger ClientSpaceContactSync on Contact (after update, after insert) {
    if(CheckRecursive.isFirstRun()){
        List<Opportunity> relatedOpportunity = new List<Opportunity>();
        relatedOpportunity.addAll([SELECT Id, Name  From Opportunity]);
        Set<Id> accountIds = new Set<Id>();
        List<RecordType> recordType = new List<RecordType>([Select Id From RecordType Where Name = 'HR' AND SObjectType = 'Opportunity']);
        String recordTypeId;
        if(recordType.size() == 0) {
            recordTypeId = '01241000000awdA';
        } else {
            recordTypeId = recordType[0].Id;
        }

        for(Contact contact : Trigger.new) {
            if(!contact.ClientSpace_Update__c) {
                if(contact.AccountId != null) {
                    accountIds.add(contact.AccountId);
                }
            }
        }
        if(accountIds.size() >0 ){
            List<Account> relatedAccounts = new List<Account>();
            List<Work_Queue__c> workQueueInserts = new List<Work_Queue__c>();
            relatedAccounts.addAll([Select Name, Id, (Select Name, Id From Opportunities WHERE RecordTypeId =: recordTypeId AND StageName = 'Discovery' Limit 1) From Account Where Id IN :accountIds]);
            if(relatedAccounts.size() > 0){
                for(Account account : relatedAccounts) {
                    for(Opportunity opportunity : account.Opportunities) {
                        workQueueInserts.add(new Work_Queue__c(OpportunityID__c = opportunity.Id));
                    }
                }
                insert workQueueInserts;
            }
        }
    }
}