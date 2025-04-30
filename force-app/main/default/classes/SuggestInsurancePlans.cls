public with sharing class SuggestInsurancePlans {
     	
    
    @InvocableMethod(label='Suggest Insurance Plans' description='Suggest insurance plans to user')
    public static List<Response> triggerPdfData(List<String> key){
        List<SuggestInsurancePlans.Response> resp = new List<SuggestInsurancePlans.Response>();
        ResponseObj res;
        List<Responseobj> resList = new List<ResponseObj>();
        Response resObj = new Response();
        List<Competitor__c> objList = new List<Competitor__c>();
        if(!key.isEmpty() && key[0] !=null && (key[0].containsIgnoreCase('health') || key[0].containsIgnoreCase('Group') || key[0].containsIgnoreCase('Individual'))){
            String initKey = key[0]+'%';
            objList = [SELECT Id,Name,Company__c, Insurance_Type__c FROM Competitor__c WHERE Insurance_Type__c  Like : initKey LIMIT 5];
        }
        else
          objList = [SELECT Id,Name,Company__c,Insurance_Type__c  FROM Competitor__c LIMIT 5];  
        if(objList.size()>0){
            for(Competitor__c obj : objList){
                res = new ResponseObj();
                res.planName = obj.Name;res.company = obj.Company__c;res.insuranceType =obj.Insurance_Type__c ;
                resList.add(res);
            }
            resObj.results =resList;
            
        }
        System.debug(resObj);
        return new list<Response>{resObj};
    }
    
    public class Response{
        @InvocableVariable(description='Insurance Plan Name for users')
        public List<ResponseObj> results;
    }
    
    public class ResponseObj{
        public String planName;
        public String company;
        public String insuranceType;
    }
    
	
}