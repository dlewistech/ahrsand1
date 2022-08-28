trigger ClientSpaceOpportunitySync on Opportunity (after update, after insert) {
    if(CheckRecursive.isFirstRun()){
        List<Work_Queue__c> insertList = new List<Work_Queue__c>();
        List<RecordType> recordType = new List<RecordType>([Select Id From RecordType Where Name = 'HR' AND SObjectType = 'Opportunity']);
        String recordTypeId;
        if(recordType.size() == 0) {
            recordTypeId = '01241000000awdA';
        } else {
            recordTypeId = recordType[0].Id;
        }
        
        for(Opportunity opportunity : Trigger.New) {
        System.Debug(opportunity);
            if(!opportunity.ClientSpace_Update__c && opportunity.RecordTypeId == recordTypeId && opportunity.StageName == 'Discovery'){
                Work_Queue__c workQueue = new Work_Queue__c(OpportunityID__c = opportunity.Id);
                insertList.add(workQueue);
                System.Debug('added workqueue');
            }
        }
        if(insertList.size() > 0){
            insert insertList;
        }
    }
}