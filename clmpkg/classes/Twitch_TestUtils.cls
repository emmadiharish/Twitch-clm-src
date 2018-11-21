//
// (c) 2018 Appirio, Inc.
//
// Class Name: Twitch_TestUtils.cls
// Description: This apex class utility class.
//
// 15th Mar 2018  Abhimanyu Tanwar   Original (Task # T-XXXXX) - Please see the task description for more details.
//
public class Twitch_TestUtils {
  //======================================================================================
  // Method to create the Account Records and return the list of those records if inserted 
  //====================================================================================== 
  public static List<Account> createAccountRecords(String name, Integer count, Boolean isInsert){

      
      List<Account> listOfAccounts=new List<Account>();
      for(integer i=0;i<count;i++){
          Account accountToBeInserted=new Account();
          accountToBeInserted.name=name +' '+ String.valueOf(i);
          listOfAccounts.add(accountToBeInserted);
      }
      if(listOfAccounts.size()>0 && isInsert){
      insert listOfAccounts;
      }
      return listOfAccounts;
  }
  
  //===============================================================================================================
  // Method to create the Opportunity Records and return the list of those records if inserted 
  //====================================================================================== =========================
  public static List<Opportunity> createOpportunityRecords(String name, String type, Date closeDate,Id AccountId, Integer count, Boolean isInsert){
     
      List<Opportunity> listOfOpportunity=new List<Opportunity>();
      for(integer i=0;i<count;i++){
       Opportunity opportunityToBeInserted=new Opportunity();
          opportunityToBeInserted.name=name +' '+String.valueOf(i);
          opportunityToBeInserted.type=type;
          opportunityToBeInserted.closedate=closeDate;
          opportunityToBeInserted.StageName='Idea';
          opportunityToBeInserted.AccountId=AccountId;
          
          listOfOpportunity.add(opportunityToBeInserted);
      }
      
      if(listOfOpportunity.size()>0 && isInsert){
      insert listOfOpportunity;
      }
      
      return listOfOpportunity;
  }
  
  //========================================================================================================
  // Method to create the Agreement Records and return the list of those records if inserted 
  //======================================================================================================== 
  public static List<Apttus__APTS_Agreement__c> createAgreementRecords(String name,Id OpportunityId, Integer count, Boolean isInsert){
      
      List<Apttus__APTS_Agreement__c> agreements = new List<Apttus__APTS_Agreement__c>();
      for( integer i = 0; i<count; i++ ){
          Apttus__APTS_Agreement__c agreement = new Apttus__APTS_Agreement__c();
          agreement.name = name + String.valueOf(i);
          agreement.Apttus__Related_Opportunity__c = OpportunityId;
          agreement.Apttus__Version_Number__c = 0;
          agreements.add(agreement);
      }
      
      if(agreements.size()>0 && isInsert){
      insert agreements;
      }
      return agreements;
  }
}