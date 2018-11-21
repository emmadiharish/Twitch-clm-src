@isTest
public class PNR_TestDataFactory {

  public static Integer count = 0;

  public static final String PROFILE_PARTNERSHIPS = 'Partnerships';
  public static final String ROLE_PARTNERSHIPS = 'Partnerships';

  public static Profile getStandardProfile() {
    return [SELECT Id FROM Profile WHERE Name =: 'Standard User' LIMIT 1];
  }

  public static User initUser() {
    // Sets up the basic User information, but does not set Role or Profile
    User myUser = new User();
    myUser.Alias = 'tw' + count;
    myUser.LastName = 'Test' + count;
    myUser.Email = 'test' + count + '@twitch.tv.testxyz';
    myUser.Username = 'test' + count + '@twitch.tv.testxyz';
    myUser.IsActive = true;
    myUser.EmailEncodingKey = 'UTF-8';
    myUser.LanguageLocaleKey = 'en_US';
    myUser.LocaleSidKey = 'en_US';
    myUser.TimeZoneSidKey = 'America/Los_Angeles';
    count++;

    return myUser;
  }

  public static void createPartnershipsUsers(Integer numUsers) {
    Profile partnershipsProfile = [SELECT Id FROM Profile WHERE Name =: PROFILE_PARTNERSHIPS LIMIT 1];
    UserRole partnershipsRole = [SELECT Id FROM UserRole WHERE DeveloperName =: ROLE_PARTNERSHIPS LIMIT 1];

    List<User> users = new List<User>();
    for (Integer i = 0; i < numUsers; i++) {
      User myUser = initUser();
      myUser.ProfileId = partnershipsProfile.Id;
      myUser.UserRoleId = partnershipsRole.Id;
      users.add(myUser);

      if (users.size() == 1000) {
        insert users;
        users.clear();
      }
    }
    insert users;
  }

  public static List<User> createChatterExternalUsers(Integer numUsers) {
    if (numUsers > 1000) {
      throw new TestDataFactoryException('Limit number Chatter External Users created to 1000 per invocation.');
    }

    Profile chatterExternalProfile = [SELECT Id FROM Profile WHERE UserLicense.Name = 'Chatter External' LIMIT 1];

    List<User> users = new List<User>();
    for (Integer i = 0; i < numUsers; i++) {
      User myUser = initUser();
      myUser.ProfileId = chatterExternalProfile.Id;
      users.add(myUser);
    }
    insert users;
    return users;
  }

  public static User getUnassignedOwnerUser() {
    return [SELECT Id FROM User WHERE Alias = 'welburnm' AND IsActive = TRUE LIMIT 1];
  }

  public static User getAssignedOwnerUser() {
    return [SELECT Id FROM User WHERE Alias != 'welburnm' AND IsActive = TRUE AND Profile.Name =: PROFILE_PARTNERSHIPS LIMIT 1];
  }

  public static List<Account> createPartners(Integer numAccounts) {
    List<Account> partners = createStreamers(numAccounts);

    for (Account acct : partners) {
      acct.External_Account_Id__c = acct.Id;
      acct.PayoutEntityId__c = acct.Id;
      acct.PartnerProgramJoinDate__c = Date.today().addDays(-1);
    }

    update partners;

    return partners;
  }

  public static List<Account> createStreamers(Integer numAccounts) {
    return createStreamers(numAccounts, true);
  }

  public static List<Account> createStreamers(Integer numAccounts, Boolean createContentCreator) {
    if (numAccounts > 1000) {
      throw new TestDataFactoryException('Limit number of Accounts created to 1000 due to complexity.');
    }

    List<Account> accounts = new List<Account>();
    List<Contact> contacts = new List<Contact>();

    for (Integer i = 0; i < numAccounts; i++) {
      Account myAccount = new Account();
      myAccount.Name = 'Test' + count;
      myAccount.TwitchUsername__c = 'Test' + count;
      myAccount.RecordTypeId = RT_ACCOUNT_STREAMER.Id;
      myAccount.External_Account_Id__c = 'Test' + count;
      accounts.add(myAccount);

      count++;
    }
    insert accounts;

    if (createContentCreator) {
      Set<Id> accountIds = (new Map<Id, Account>(accounts)).keySet();

      Map<String, Contact> contactsByAccountIdMap = new Map<String, Contact>();
      for (Contact myContact : createContacts(accountIds)) {
        contactsByAccountIdMap.put(myContact.AccountId, myContact);
      }

      accounts = new PNR_AccountsSelector().selectById(accountIds);
      for (Account myAccount : accounts) {
        if (String.isBlank(myAccount.ContentCreator__c) && contactsByAccountIdMap.containsKey(myAccount.Id)) {
          myAccount.ContentCreator__c = contactsByAccountIdMap.get(myAccount.Id).Id;
        }
      }
      update accounts;
    }

    return accounts;
  }

  public static List<Account> createCompanies(Integer numAccounts) {
    List<Account> accounts = new List<Account>();

    for (Integer i = 0; i < numAccounts; i++) {
      Account myAccount = new Account();
      myAccount.Name = 'Test' + count;
      myAccount.RecordTypeId = RT_ACCOUNT_COMPANY.Id;
      accounts.add(myAccount);

      count++;
    }

    insert accounts;
    return accounts;
  }

  public static List<Contact> createContacts(Set<Id> accountIds) {
    List<Contact> contacts = new List<Contact>();

    for (Id accountId : accountIds) {
      Contact myContact = new Contact();
      myContact.AccountId = accountId;
      myContact.LastName = 'Test';
      myContact.TwitterUsername__c = accountId;
      myContact.RecordTypeId = RT_CONTACT_STREAMER.Id;
      contacts.add(myContact);
    }

    insert contacts;

    return contacts;
  }

  public static void createContacts(Set<Id> accountIds, Integer numContacts) {
    List<Contact> contacts = new List<Contact>();

    for (Id accountId : accountIds) {
      for (Integer i = 0; i < numContacts; i++) {
        Contact myContact = new Contact();
        myContact.AccountId = accountId;
        myContact.LastName = 'Test' + count++;
        myContact.TwitterUsername__c = String.valueOf(accountId).right(10) + count++;
        contacts.add(myContact);

        if (contacts.size() == 1000) {
          insert contacts;
          contacts.clear();
        }
      }
    }

    insert contacts;
  }

  public static void createPartnerContentAcquisitionOpportunities(Set<Id> accountIds, Integer numOpptys) {
    List<Opportunity> opptys = new List<Opportunity>();

    for (Id accountId : accountIds) {
      for (Integer i = 0; i < numOpptys; i++) {
        Opportunity myOppty = initContentAcquisitionOpportunity(accountId);
        myOppty.Name = 'Test' + count++;
        opptys.add(myOppty);

        if (opptys.size() == 1000) {
          insert opptys;
          opptys.clear();
        }
      }
    }

    insert opptys;
  }

  public static void createPartnerAcquisitionOpportunities(Set<Id> accountIds, Integer numOpptys) {
    List<Opportunity> opptys = new List<Opportunity>();

    for (Id accountId : accountIds) {
      for (Integer i = 0; i < numOpptys; i++) {
        Opportunity myOppty = initPartnerAcquisitionOpportunity(accountId);
        myOppty.Name = 'Test' + count++;
        opptys.add(myOppty);

        if (opptys.size() == 1000) {
          insert opptys;
          opptys.clear();
        }
      }
    }

    insert opptys;
  }

  public static Opportunity initPartnerAcquisitionOpportunity(Id accountId) {
    Opportunity myOppty = new Opportunity();
    myOppty.AccountId = accountId;
    myOppty.Name = 'Test';
    myOppty.CloseDate = Date.today().addDays(30);
    myOppty.StageName = 'Awareness';
    myOppty.RecordTypeId = RT_OPPTY_PARTNERACQUISITION.Id;
    myOppty.EstimatedMinutesWatched__c = 1200000;
    myOppty.RetainedMinutesWatched__c = 12000;
    myOppty.Category__c = 'Gaming';
    myOppty.Region__c = 'APAC';
    myOppty.EstimatedCost__c = 0;
    myOppty.PrimaryContentType__c = 'Live';
    myOppty.Country__c = 'JP';

    return myOppty;
  }

  //Insert Agreements
  public static Apttus__APTS_Agreement__c initTwitchContentLicenseAgrmnt(Id opptyId){
    Apttus__APTS_Agreement__c agrmnt=new Apttus__APTS_Agreement__c();
    agrmnt.Name='Twitch - Content License';
    agrmnt.RecordTypeId=RT_AGRMNT_TWITCHCONTENTLICENSE.Id;
    agrmnt.Apttus__Related_Opportunity__c =opptyId;
    agrmnt.Apttus__Status__c='In Amendment';
    agrmnt.Apttus__Status_Category__c='Request';

    return agrmnt;
  }
  
  //insert multiple agreements
 
  public static List<Apttus__APTS_Agreement__c> insertTwitchContentLicenseAgrmnts(List<Id> opptyId, Integer numofAgg){
  List<Apttus__APTS_Agreement__c> aggList=new List<Apttus__APTS_Agreement__c>();
    for(integer i=0;i<numofAgg;i++){
        Apttus__APTS_Agreement__c agrmnt=new Apttus__APTS_Agreement__c();
        agrmnt.Name='Twitch - Content License';
        agrmnt.RecordTypeId=RT_AGRMNT_TWITCHCONTENTLICENSE.Id;
        agrmnt.Apttus__Related_Opportunity__c =opptyId[i];
        agrmnt.Apttus__Status__c='In Amendment';
        agrmnt.Apttus__Status_Category__c='Request';
        agrmnt.CustomAdDensityRequirement__c=6;
        agrmnt.VODExclusivity__c='24 Hours';
        
        aggList.add(agrmnt);
    }
    return aggList;
  }
  
  //Insert AgreementChannels
  public static AgreementChannel__c insertAgrmntChannel(Id agrmntId, Id accId){
    AgreementChannel__c agrmntchannel=new AgreementChannel__c();
    agrmntchannel.Agreement__c=agrmntId;
    agrmntchannel.ChannelID__c='12345';
    system.debug('TESTDATACLASS' +agrmntId);
    
    if(accId!=null){
        agrmntchannel.ChannelName__c=accId;
     }
     else agrmntchannel.ChannelName__c=null;
         
   insert agrmntchannel; 
   return agrmntchannel;
  }
  
  //update channels
  public static void updateAgrmntChannel(AgreementChannel__c updateChannel,Id agrmntId, Id accId){
      updateChannel.ChannelID__c='67890';
      updateChannel.ChannelName__c=accId;
      
      update updateChannel;
  }
  //update channels-2
  public static AgreementChannel__c updateAgrmntChannel(AgreementChannel__c updateChannel, Id accId){
      updateChannel.ChannelID__c='67890';
      updateChannel.ChannelName__c=accId;
      
      update updateChannel;
      return updateChannel;
  }
  
  //update agreement
  public static void updateagreement(Apttus__APTS_Agreement__c agreement){
      agreement.CustomAdDensityRequirement__c=12;
      agreement.VODExclusivity__c='12 Hours';
      
       update agreement;
  }
  
  
  //insert agreement revision history
  public static List<Agreement_Revision_History__c> insertAgreementRevisions(Id agIds,Integer numofrevs){
  List<Agreement_Revision_History__c> agrevList=new List<Agreement_Revision_History__c >();
  AgreementChannel__c agrmntchannel =insertAgrmntChannel(agIds,null);
  List<Schema.FieldSetMember> fsMember=createFieldSet();
    for(Integer i=0;i<numofrevs;i++){
        Agreement_Revision_History__c revisionChannelHistory=new Agreement_Revision_History__c();
        revisionChannelHistory.To__c='12';
        revisionChannelHistory.Type__c='Agreement';
        revisionChannelHistory.Channel_Action__c='Create';
        
        revisionChannelHistory.Agreement__c=agIds;
        revisionChannelHistory.FieldLabel__c=fsMember[i].getLabel();
        revisionChannelHistory.FieldAPI__c=fsMember[i].getFieldPath();
        revisionChannelHistory.Channel_SF_ID__c=agrmntchannel.Id; 
    
        agrevList.add(revisionChannelHistory);
    }
    return agrevList;
  }
  
  
  
  
  public static Opportunity initBusinessDevelopmentOpportunity(Id accountId) {
    Opportunity myOppty = new Opportunity();
    myOppty.AccountId = accountId;
    myOppty.Name = 'Test';
    myOppty.CloseDate = Date.today().addDays(30);
    myOppty.StageName = 'Exploratory';
    myOppty.RecordTypeId = RT_OPPTY_BD.Id;

    return myOppty;
  }

  public static Opportunity initContentAcquisitionOpportunity(Id accountId) {
    Opportunity myOppty = new Opportunity();
    myOppty.AccountId = accountId;
    myOppty.Name = 'Test';
    myOppty.CloseDate = Date.today().addDays(30);
    myOppty.StageName = 'Awareness'; // TODO - automatically set to first stage
    myOppty.RecordTypeId = RT_OPPTY_CONTENTACQUISITION.Id;

    return myOppty;
  }

  public static void createOpportunityChannels(Set<Id> opptyIds, Set<String> channelNames) {
    List<OpportunityChannel__c> channels = new List<OpportunityChannel__c>();

    for (Id opptyId : opptyIds) {
      for (String channelName : channelNames) {
        OpportunityChannel__c channel = new OpportunityChannel__c();
        channel.Opportunity__c = opptyId;
        channel.TwitchUsernameManualEntry__c = channelName;

        channels.add(channel);

        if (channels.size() >= 900) {
          insert channels;
          channel.clear();
        }
      }
    }
    insert channels;
  }

  public static void createOpportunityYearYearlyEstimate(Set<Id> opptyIds, Integer num) {
    List<OpportunityYear__c> years = new List<OpportunityYear__c>();

    for (Id opptyId : opptyIds) {
      for (Integer i = 0; i < num; i++) {
        OpportunityYear__c year = new OpportunityYear__c();
        year.Year__c = String.valueOf(i + 1);
        year.Opportunity__c = opptyId;
        year.RecordTypeId = RT_OPPTYYEAR_YEARLY.Id;
        year.TotalMinutesWatched__c = 12000000;

        years.add(year);

        if (years.size() >= 900) {
          insert years;
          year.clear();
        }
      }
    }
    insert years;
  }

  public static void createOpportunityYearMonthlyEstimate(Set<Id> opptyIds, Integer num) {
    List<OpportunityYear__c> years = new List<OpportunityYear__c>();

    for (Id opptyId : opptyIds) {
      for (Integer i = 0; i < num; i++) {
        OpportunityYear__c year = new OpportunityYear__c();
        year.Year__c = String.valueOf(i + 1);
        year.Opportunity__c = opptyId;
        year.RecordTypeId = RT_OPPTYYEAR_MONTHLY.Id;
        year.JanuaryMinutesWatched__c = 1000000;
        year.FebruaryMinutesWatched__c = 1000000;
        year.MarchMinutesWatched__c = 1000000;
        year.AprilMinutesWatched__c = 1000000;
        year.MayMinutesWatched__c = 1000000;
        year.JuneMinutesWatched__c = 1000000;
        year.JulyMinutesWatched__c = 1000000;
        year.AugustMinutesWatched__c = 1000000;
        year.SeptemberMinutesWatched__c = 1000000;
        year.OctoberMinutesWatched__c = 1000000;
        year.NovemberMinutesWatched__c = 1000000;
        year.DecemberMinutesWatched__c = 1000000;

        years.add(year);

        if (years.size() >= 900) {
          insert years;
          year.clear();
        }
      }
    }
    insert years;
  }

  public static void createForecastedMonths(Set<Id> opptyIds, Integer numMonths) {
    List<ForecastedMonth__c> months = new List<ForecastedMonth__c>();

    for (Id opptyId : opptyIds) {
      Date theDate = Date.newInstance(2018,1,1);
      for (Integer i = 0; i < numMonths; i++) {
        ForecastedMonth__c month = new ForecastedMonth__c();
        month.Opportunity__c = opptyId;
        month.EstimatedMinutesWatched__c = 1000;
        month.Date__c = theDate.addMonths(i);

        months.add(month);

        if (months.size() >= 900) {
          insert months;
          months.clear();
        }
      }
    }
    insert months;
  }

  public static void createTeams(Integer numAccounts) {
    List<Account> accounts = new List<Account>();

    for (Integer i = 0; i < numAccounts; i++) {
      Account myAccount = new Account();
      myAccount.Name = 'Test' + count++;
      myAccount.RecordTypeId = RT_ACCOUNT_TEAM.Id;
      accounts.add(myAccount);

      if (accounts.size() == 1000) {
        insert accounts;
        accounts.clear();
      }
    }
    insert accounts;
  }

  public static void createStreamerLeads(Integer numLeads) {
    List<Lead> leads = new List<Lead>();

    for (Integer i = 0; i < numLeads; i++) {
      Lead myLead = initLead();
      myLead.RecordTypeId = RT_LEAD_STREAMER.Id;
      leads.add(myLead);

      if (leads.size() == 1000) {
        insert leads;
        leads.clear();
      }
    }
    insert leads;
  }

  public static Lead initLead() {
    Lead myLead = new Lead();
    myLead.LastName = 'Test' + count;
    myLead.Company = 'Test' + count;
    count++;

    return myLead;
  }

  public static void createEmailToSalesforceTasks(Set<Id> contactIds, Integer numTasksForAccount) {
    List<Task> tasks = new List<Task>();

    for (Id contactId : contactIds) {
      for (Integer i = 0; i < numTasksForAccount; i++) {
        Task myTask = initAccountTask(null, contactId, 'Email: Task' + count++, Date.today());
        myTask.Status = 'Completed';
        tasks.add(myTask);

        if (tasks.size() == 1000) {
          insert tasks;
          tasks.clear();
        }
      }
    }

    insert tasks;
  }

  public static void createAccountTasks(Set<Id> accountIds, Integer numTasksForAccount) {
    createAccountTasks(accountIds, numTasksForAccount, Date.today());
  }

  public static void createAccountTasks(Set<Id> accountIds, Integer numTasksForAccount, Date activityDate) {
    List<Task> tasks = new List<Task>();

    for (Id accountId : accountIds) {
      for (Integer i = 0; i < numTasksForAccount; i++) {
        Task myTask = initAccountTask(accountId, null, 'Task' + count++, activityDate);
        tasks.add(myTask);

        if (tasks.size() == 1000) {
          insert tasks;
          tasks.clear();
        }
      }
    }

    insert tasks;
  }

  public static Task initAccountTask(Id whatId, Id whoId, String subject, Date activityDate) {
    Task myTask = new Task();
    myTask.WhatId = whatId;
    myTask.WhoId = whoId;
    myTask.Subject = subject;
    myTask.ActivityDate = (activityDate != null ? activityDate : Date.today());
    return myTask;
  }

  public static void createInfractions(Set<Id> accountIds, Integer numInfractionsForAccount) {
    createInfractions(accountIds, numInfractionsForAccount, Date.today());
  }

  public static void createInfractions(Set<Id> accountIds, Integer numInfractionsForAccount, DateTime infractionDate) {
    List<Infraction__c> infractions = new List<Infraction__c>();

    for (Id accountId : accountIds) {
      for (Integer i = 0; i < numInfractionsForAccount; i++) {
        Infraction__c myInfraction = new Infraction__c();
        myInfraction.Name = 'Test Infraction ' + count++;
        myInfraction.Streamer__c = accountId;
        myInfraction.Date__c = infractionDate;
        infractions.add(myInfraction);

        if (infractions.size() == 1000) {
          insert infractions;
          infractions.clear();
        }
      }
    }

    insert infractions;
  }

  public static void createAccountTeamMembers(Id accountId, Set<Id> userIds) {
    List<AccountTeamMember> membersToInsert = new List<AccountTeamMember>();

    for (Id userId : userIds) {
      AccountTeamMember member = new AccountTeamMember();
      member.AccountId = accountId;
      member.UserId = userId;
      membersToInsert.add(member);

      if (membersToInsert.size() == 1000) {
        insert membersToInsert;
        membersToInsert.clear();
      }
    }

    insert membersToInsert;
  }

  public static Promotion__c initPromotion(Id accountId) {
    Promotion__c promotion = new Promotion__c();
    promotion.Streamer__c = accountId;
    return promotion;
  }

  public static void createSocialMediaPromotions(List<Id> accountIds, Integer numPromotionsForAccount) {
    List<Promotion__c> promotions = new List<Promotion__c>();

    for (Id accountId : accountIds) {
      for (Integer i = 0; i < numPromotionsForAccount; i++) {
        Promotion__c myPromotion = initPromotion(accountId);
        myPromotion.Notes__c = 'Test Promotion ' + count++;
        myPromotion.StartDate__c = Date.today();
        myPromotion.EndDate__c = Date.today();
        promotions.add(myPromotion);

        if (promotions.size() == 1000) {
          insert promotions;
          promotions.clear();
        }
      }
    }

    insert promotions;
  }

  public static void createGamingEvents(Integer numEvents) {
    List<GamingEvent__c> events = new List<GamingEvent__c>();

    for (Integer i = 0; i < numEvents; i++) {
      GamingEvent__c event = initGamingEvent(Date.today().addDays(-7), Date.today().addDays(7));
      events.add(event);

      if (events.size() == 1000) {
        insert events;
        events.clear();
      }
    }

    insert events;
  }

  public static GamingEvent__c initGamingEvent(Date startDate, Date endDate) {
    GamingEvent__c event = new GamingEvent__c();
    event.Name = 'Test ' + count++;
    event.StartDate__c = startDate;
    event.EndDate__c = endDate;

    return event;
  }

  public static List<StreamerSubcategory__c> initSubcategories(Id accountId, Id leadId, Id opportunityId, Integer num) {
    if (num > 1000) {
      System.assert(false, 'Maximum limit of 1000');
    }

    List<String> subcategoryValues = new List<String>();
    for (Schema.PicklistEntry f : StreamerSubcategory__c.Subcategory__c.getDescribe().getPicklistValues()) {
      subcategoryValues.add(f.getValue());
    }

    List<StreamerSubcategory__c> subcategoryList = new List<StreamerSubcategory__c>();
    for (Integer i = 0; i < num; i++) {
      StreamerSubcategory__c subcat = new StreamerSubcategory__c();
      subcat.Streamer__c = accountId;
      subcat.Lead__c = leadId;
      subcat.Opportunity__c = opportunityId;
      subcat.Subcategory__c = subcategoryValues[Math.mod(i, subcategoryValues.size())];

      subcategoryList.add(subcat);
    }
    return subcategoryList;
  }

  public static List<ContractRequest__c> initContractRequests(List<Id> opptyIds) {
    List<ContractRequest__c> requests = new List<ContractRequest__c>();
    for (Id opptyId : opptyIds) {
      requests.add( initContractRequest(opptyId) );
    }
    return requests;
  }

  public static ContractRequest__c initContractRequest(Id opptyId) {
    ContractRequest__c request = new ContractRequest__c();
    request.Opportunity__c = opptyId;

    return setContractRequest(request);
  }

  public static ContractRequest__c setContractRequest(ContractRequest__c request) {
    request.TotalEstimatedCost__c = 100;
    request.SubscriptionRevenueTerms__c = 'None';
    request.AdDensityRequirement__c = 'None';
    request.AdvertisingRevenueTerms__c = 'None';
    request.BitsRevenueTerms__c = 'None';
    request.FuelRevenueTerms__c = 'None';
    request.LiveExclusivity__c = 'No';
    request.VODExclusivity__c = 'None';
    request.AdDensityRequirement__c = 'Standard';
    request.LicenseFee__c = 0;
    request.ProRatedLicenseFee__c = 'No';
    request.MinimumGuarantee__c = 0;
    request.ProRatedMinimumGuarantee__c = 'No';
    request.Sponsorship__c = 0;
    request.ProRatedSponsorship__c = 'No';
    request.PreMigration__c = true;

    return request;
  }

  public static PNR_TwitterOAuth.Twitter_Status initTwitterStatus(List<String> mentionedUsernames, String retweetedUsername, List<String> mentionedInRetweetUsernames, String quotedUsername, List<String> mentionedInQuoteUsernames) {
    PNR_TwitterOAuth.Twitter_Status status = new PNR_TwitterOAuth.Twitter_Status();
    status.id_str = String.valueOf(count++);
    status.created_at = 'Tue Nov 22 20:13:47 +0000 2016';
    status.entities = new PNR_TwitterOAuth.Twitter_Entity();
    status.entities.user_mentions = new List<PNR_TwitterOAuth.Twitter_UserMention>();
    status.is_quote_status = false;

    if (mentionedUsernames != null && !mentionedUsernames.isEmpty()) {
      for (String username : mentionedUsernames) {
        PNR_TwitterOAuth.Twitter_UserMention mention = new PNR_TwitterOAuth.Twitter_UserMention();
        mention.screen_name = username;
        status.entities.user_mentions.add( mention );
      }
    }

    if ((mentionedInRetweetUsernames != null && !mentionedInRetweetUsernames.isEmpty()) || String.isNotBlank(retweetedUsername)) {
      status.retweeted_status = new PNR_TwitterOAuth.Twitter_Status();
      status.retweeted_status.user = new PNR_TwitterOAuth.Twitter_User();
      status.retweeted_status.entities = new PNR_TwitterOAuth.Twitter_Entity();
      status.retweeted_status.entities.user_mentions = new List<PNR_TwitterOAuth.Twitter_UserMention>();

      if (String.isNotBlank(retweetedUsername)) {
        status.retweeted_status.user.screen_name = retweetedUsername;
      }
      if (mentionedInRetweetUsernames != null && !mentionedInRetweetUsernames.isEmpty()) {
        for (String username : mentionedInRetweetUsernames) {
          PNR_TwitterOAuth.Twitter_UserMention mention = new PNR_TwitterOAuth.Twitter_UserMention();
          mention.screen_name = username;
          status.retweeted_status.entities.user_mentions.add( mention );
        }
      }
    }

    if ((mentionedInQuoteUsernames != null && !mentionedInQuoteUsernames.isEmpty()) || String.isNotBlank(quotedUsername)) {
      status.is_quote_status = true;
      status.quoted_status = new PNR_TwitterOAuth.Twitter_Status();
      status.quoted_status.user = new PNR_TwitterOAuth.Twitter_User();
      status.quoted_status.entities = new PNR_TwitterOAuth.Twitter_Entity();
      status.quoted_status.entities.user_mentions = new List<PNR_TwitterOAuth.Twitter_UserMention>();

      if (String.isNotBlank(quotedUsername)) {
        status.quoted_status.user.screen_name = quotedUsername;
      }
      if (mentionedInQuoteUsernames != null && !mentionedInQuoteUsernames.isEmpty()) {
        for (String username : mentionedInQuoteUsernames) {
          PNR_TwitterOAuth.Twitter_UserMention mention = new PNR_TwitterOAuth.Twitter_UserMention();
          mention.screen_name = username;
          status.quoted_status.entities.user_mentions.add( mention );
        }
      }
    }

    return status;
  }

  public static void createPartnerSupportRequests(Integer num) {
    List<ProductSupportRequest__c> requests = new List<ProductSupportRequest__c>();

    for (Integer i = 0; i < num; i++) {
      ProductSupportRequest__c psr = new ProductSupportRequest__c();
      psr.Name = 'Test PSR ' + i;
      psr.RecordTypeId = RT_PSR_PRODUCTSUPPORT.Id;

      requests.add(psr);
    }

    insert requests;
  }

  public static PSRParticipant__c initPSRParticipant(String psrId, String accountManagerId, String partnerId) {
    PSRParticipant__c participant = new PSRParticipant__c();
    participant.ProductSupportRequest__c = psrId;
    participant.AccountManager__c = accountManagerId;
    participant.Partner__c = partnerId;
    return participant;
  }

  public static PartnerFeedback__c initPartnerFeedback(String accountId, String productSupportRequestId, String gamingEventId) {
    PartnerFeedback__c feedback = new PartnerFeedback__c();
    feedback.Partner__c = accountId;
    feedback.ProductSupportRequest__c = productSupportRequestId;
    feedback.GamingEvent__c = gamingEventId;
    feedback.Feedback__c = 'test';
    return feedback;
  }

  public static void createOrgDefaultTwitterOAuthToken() {
    TwitterOAuthToken__c token = TwitterOAuthToken__c.getOrgDefaults();
    token.IsAccess__c = true;
    token.Secret__c = '123';
    token.Token__c = '456';
    upsert token;
  }

  public static void createTwitterOAuthToken() {
    PNR_TwitterOAuth oauth = new PNR_TwitterOAuth();
    Map<String, String> oauthParams = new Map<String, String>();
    oauthParams.put('oauth_token', 'token1');
    oauthParams.put('oauth_token_secret', 'token2');
    oauth.saveToken(oauthParams, true);
  }

  private static Map<String, Map<String, RecordType>> recordTypeBySObjectAndDeveloperName;
  private static RecordType getRecordTypeByDeveloperName(Schema.SObjectType sObjectType, String developerName) {
    if (recordTypeBySObjectAndDeveloperName == null) {
      recordTypeBySObjectAndDeveloperName = new Map<String, Map<String, RecordType>>();
      for (RecordType rt : [SELECT Id, SObjectType, DeveloperName FROM RecordType]) {
        Map<String, RecordType> recordTypesBySObject = new Map<String, RecordType>();

        if (recordTypeBySObjectAndDeveloperName.containsKey(rt.SObjectType)) {
          recordTypesBySObject = recordTypeBySObjectAndDeveloperName.get(rt.SObjectType);
        }
        recordTypesBySObject.put(rt.DeveloperName, rt);

        recordTypeBySObjectAndDeveloperName.put(rt.SObjectType, recordTypesBySObject);
      }
    }
    return recordTypeBySObjectAndDeveloperName.get(sObjectType.getDescribe().getName()).get(developerName);
  }

  public static RecordType RT_CONTACT_STREAMER {
    get {
      return getRecordTypeByDeveloperName(Contact.sObjectType, 'Streamer');
    }
  }
  public static RecordType RT_ACCOUNT_STREAMER {
    get {
      return getRecordTypeByDeveloperName(Account.sObjectType, 'Streamer');
    }
  }
  public static RecordType RT_ACCOUNT_TEAM {
    get {
      return getRecordTypeByDeveloperName(Account.sObjectType, 'Team');
    }
  }
  public static RecordType RT_ACCOUNT_COMPANY {
    get {
      return getRecordTypeByDeveloperName(Account.sObjectType, 'Company');
    }
  }
  public static RecordType RT_LEAD_STREAMER {
    get {
      return getRecordTypeByDeveloperName(Lead.sObjectType, 'Streamer');
    }
  }
  public static RecordType RT_OPPTY_CONTENTACQUISITION {
    get {
      return getRecordTypeByDeveloperName(Opportunity.sObjectType, 'Partner_Content_Acquisition');
    }
  }
  public static RecordType RT_OPPTY_PARTNERACQUISITION {
    get {
      return getRecordTypeByDeveloperName(Opportunity.sObjectType, 'Premium_Partner_Content_Acquisition');
    }
  }
  public static RecordType RT_OPPTY_BD {
    get {
      return getRecordTypeByDeveloperName(Opportunity.sObjectType, 'BD_Content_Generic');
    }
  }
  public static RecordType RT_OPPTYYEAR_YEARLY {
    get {
      return getRecordTypeByDeveloperName(OpportunityYear__c.sObjectType, 'YearlyEstimate');
    }
  }
  public static RecordType RT_OPPTYYEAR_MONTHLY {
    get {
      return getRecordTypeByDeveloperName(OpportunityYear__c.sObjectType, 'MonthlyEstimate');
    }
  }
  public static RecordType RT_PSR_PRODUCTSUPPORT {
    get {
      return getRecordTypeByDeveloperName(ProductSupportRequest__c.sObjectType, 'ProductSupportRequest');
    }
  }
  public static RecordType RT_PSR_PARTNERCOMMUNICATION {
    get {
      return getRecordTypeByDeveloperName(ProductSupportRequest__c.sObjectType, 'PartnerCommunicationRequest');
    }
  }

  //Agreement RecordType
  public static RecordType RT_AGRMNT_TWITCHCONTENTLICENSE {
    get {
      return getRecordTypeByDeveloperName(Apttus__APTS_Agreement__c.sObjectType, 'Twitch_Content_License');
    }
  }
  
  //create field set for agreement
  public static List<Schema.FieldSetMember> createFieldSet(){
   Schema.FieldSet fieldSetObj = Schema.SObjectType.Apttus__APTS_Agreement__c.fieldSets.Agreement_Revisions_History;
 // Apttus__APTS_Agreement__c agFieldSet = new Apttus__APTS_Agreement__c(Name = 'Test', ColumnFieldSet__c = 'AccountColumns', FilterFieldSet__c = 'AccountFilters', SobjectName__c = 'Account');
 List<Schema.FieldSetMember> fsMemberlist=fieldSetObj.getFields();
  return fsMemberlist;
  }


  public class TestDataFactoryException extends Exception {}
}