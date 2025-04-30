public with sharing class HealthInsuranceController {
    
    public class PolicyWrapper {
        @AuraEnabled public String Name;
        @AuraEnabled public String Policy_Number;
        @AuraEnabled public Decimal Coverage_Amount;
        @AuraEnabled public String Company;
    }

    @AuraEnabled(cacheable=true)
    public static List<PolicyWrapper> getHealthPolicies(String insuranceType) {
        List<PolicyWrapper> result = new List<PolicyWrapper>();
        
        /*for (Health_Insurance__c policy : [
            SELECT Name, Policy_Number__c, Coverage_Amount__c, Company__c
            FROM Health_Insurance__c
            WHERE Type__c = :insuranceType
            LIMIT 10
        ]) {*/
            PolicyWrapper pw = new PolicyWrapper();
            pw.Name = 'test policy';
            pw.Policy_Number = 'qwerty';
            pw.Coverage_Amount= 34566;
            pw.Company = 'BVGT';
            result.add(pw);
        //}
        
        return result;
    }
}