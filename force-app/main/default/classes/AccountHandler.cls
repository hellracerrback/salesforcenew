public inherited sharing class AccountHandler {
    public AccountHandler() {

        trigger AccountTrigger on Account (after update) {
    if(Trigger.isUpdate==true && Trigger.isAfter==true){
 		
        List<Account> toUpdateAccount = new List<Account>();
        for(Account act : Trigger.new){
            if(act.SLAExpirationDate__c != Trigger.oldMap.get(act.id).SLAExpirationDate__c) 
            toUpdateAccount.add(act);
        } 
		
		List<Opportunity> toupdateOp= [select id, name, closeDate, AccountID from opportunity where accountId in :toUpdateAccount];
		List<Opportunity> upOp = new List<Opportunity>();
        for(Opportunity op: toupdateOp){
				            
            op.CloseDate= trigger.newMap.get(op.AccountId).SLAExpirationDate__c;
       		upOp.add(op);
            
        }
        update upOp;
        
    }
   
}

    }
}
