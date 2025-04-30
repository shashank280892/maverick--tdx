public with sharing class ClaimAssessmentData {
    
    @InvocableMethod(label='Suggest Claim Assessment Plans' description='Suggest Claim Assessment plans to user')
    public static List<ClaimAssesmentResponse> mainMethondToFetchPolicies(List<String> inputParams){
        //List<ClaimAssesmentResponse> assessmentResponse = new List<ClaimAssesmentResponse>();
        ClaimAssesmentResponse assResp = new ClaimAssesmentResponse();
        List<ClaimData> datalist = new List<ClaimData>();
        ClaimData data = new ClaimData();
        if(inputParams.isEmpty()) {
            data.isClaimfound = false;
            data.status = 'ERROR';
            data.reason = 'Not able to find Email id';
            datalist.add(data);
            assResp.datalist = datalist;
            return new List<ClaimAssesmentResponse> {assResp};
            
        }
        if(!inputParams[0].containsIgnoreCase('@gmail.com')) {
            data.isClaimfound = false;
            data.status = 'ERROR';
            data.reason = 'Please provide valid mail Id';
            datalist.add(data);
            assResp.datalist = datalist;
            return new List<ClaimAssesmentResponse> {assResp};
        }
        String likeClause = '%'+inputParams[0]+'%';
        List<Contact> conList = [Select Id, Email From Contact Where Email LIKE :likeClause];
        if(conList.isEmpty()) {
            data.isClaimfound = false;
            data.status = 'ERROR';
            data.reason = 'Not able to find user details related to mail id';
            datalist.add(data);
            assResp.datalist = datalist;
            return new List<ClaimAssesmentResponse> {assResp};
        }
        Contact userCon = new Contact();
        userCon = conList[0];
        List<Opted_Policy__dlm> policyList = [Select Id, Policy_Name__c FROM Opted_Policy__dlm WHERE Email__c =:userCon.Email ];
        if(policyList.isEmpty()) {
            data.isClaimfound = false;
            data.status = 'ERROR';
            data.reason = 'No policy found related to mail id';
            datalist.add(data);
            assResp.datalist = datalist;
            return new List<ClaimAssesmentResponse> {assResp};
        }
        set<String> policyNameSet = new set<String>();
        for(Opted_Policy__dlm plcy : policyList) {
            policyNameSet.add(plcy.Policy_Name__c);
        }
        
        List<Policy__dlm> policydlmList = [Select Id, Additional_Cover_INR__c,Annual_Health_Check__c,Base_Cover_Amount_INR__c,
                                           Claim_Ratio__c,Claims_Consumable__c,Co_pay__c,Company_Name__c,DataSource__c,DataSourceObject__c,
                                           Disease_Sublimit__c,InternalOrganization__c,Jump_Rider__c,KQ_Policy_Name__c,No_Claim_Bonus_INR__c,
                                           No_Claims_Bonus_Add_on__c,No_of_Network_Hospitals__c,Policy_Name__c,Post_Hospitalization__c,Power_Booster__c,
                                           Pre_Hospitalization__c,Restoration_Amount_INR__c,Room_Modifier__c,Room_Rent_Allowance__c,Waiting_Period__c 
                                           FROM Policy__dlm WHERE Policy_Name__c IN :policyNameSet ] ;
        for(Policy__dlm plc : policydlmList) {
            data.isClaimfound = true;
            data.status = 'SUCCESS';
            data.reason = 'Policy as per user access';
            data.additionalCover = String.valueOf(plc.Additional_Cover_INR__c);
            data.annhealthCheck = String.valueOf(plc.Annual_Health_Check__c);
            data.baseCoverAmt = String.valueOf(plc.Base_Cover_Amount_INR__c);
            data.claimRatio = String.valueOf(plc.Claim_Ratio__c);
            data.claimCons = String.valueOf(plc.Claims_Consumable__c);
            data.copAy = String.valueOf(plc.Co_pay__c);
            data.cmpnyName = String.valueOf(plc.Company_Name__c);
            data.dataSource = String.valueOf(plc.DataSource__c);
            data.datasourceObj = String.valueOf(plc.DataSourceObject__c);
            data.diseaseSubLimit = String.valueOf(plc.Disease_Sublimit__c);
            data.internalorg = String.valueOf(plc.InternalOrganization__c);
            data.jumpRider = String.valueOf(plc.Jump_Rider__c);
            data.NoClaimBonus = String.valueOf(plc.No_Claim_Bonus_INR__c);
            data.NoClaimAddOn = String.valueOf(plc.No_Claims_Bonus_Add_on__c);
            data.NoOfNetworkHsptl = String.valueOf(plc.No_of_Network_Hospitals__c);
            data.plcyName = String.valueOf(plc.Policy_Name__c);
            data.pstHospitalization = String.valueOf(plc.Post_Hospitalization__c);
            data.powerbooster = String.valueOf(plc.Power_Booster__c);
            data.PreHospital = String.valueOf(plc.Pre_Hospitalization__c);
            data.restorationAMT = String.valueOf(plc.Restoration_Amount_INR__c);
            data.roomModifier =String.valueOf( plc.Room_Modifier__c);
            data.roomrentAllwnce = String.valueOf(plc.Room_Rent_Allowance__c);
            data.waitingPeriod = String.valueOf(plc.Waiting_Period__c);
            
            datalist.add(data);
            
        }
        assResp.datalist = datalist;
        return new List<ClaimAssesmentResponse> {assResp};
        
        
         
       // return assessmentResponse;
    }
    public class ClaimAssesmentResponse {
        @InvocableVariable (description='Insurance Claim details Name for users')
        public List<ClaimData> datalist;
    }
    public class ClaimData{
        public String claimType;
        public String maxClaimAmount;
        public String riderOpted;
        public Boolean isClaimfound;
        public String status;
        public String reason;
        public String additionalCover ;
        public String annhealthCheck ;
        public String baseCoverAmt;
        public String claimRatio ;
        public String claimCons ;
        public String copAy ;
        public string cmpnyName ;
        public string dataSource ;
        public string datasourceObj ;
        public String diseaseSubLimit ;
        public string internalorg ;
        public String jumpRider ;
        public String NoClaimBonus ;
        public String NoClaimAddOn ;
        public String NoOfNetworkHsptl ;
        public string plcyName ;
        public String pstHospitalization ;
        public String powerbooster ;
        public String PreHospital ;
        public String restorationAMT ;
        public String roomModifier ;
        public String roomrentAllwnce ;
        public String waitingPeriod ;
    }

}