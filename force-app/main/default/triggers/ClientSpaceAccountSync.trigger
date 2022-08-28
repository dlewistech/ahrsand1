trigger ClientSpaceAccountSync on Account (after update) {
    if(CheckRecursive.isFirstRun()){
        List<Id> accountIds = new List<Id>();
        List<RecordType> recordType = new List<RecordType>([Select Id From RecordType Where Name = 'HR' AND SObjectType = 'Opportunity']);
        String recordTypeId;
        if(recordType.size() == 0) {
            recordTypeId = '01241000000awdA';
        } else {
            recordTypeId = recordType[0].Id;
        }

        for(Account account : Trigger.new) {
            if(!account.ClientSpace_Update__c){
                accountIds.add(account.Id);
            }
        }
        List<Account> relatedAccounts = new List<Account>();
        List<Work_Queue__c> workQueueInserts = new List<Work_Queue__c>();
        relatedAccounts.addAll([Select Name, Id, (Select Name, Id From Opportunities Where StageName = 'Discovery' AND RecordTypeId =: recordTypeId Limit 1) From Account Where Id IN :accountIds]);
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