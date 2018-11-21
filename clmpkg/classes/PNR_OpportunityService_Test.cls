@isTest
private class PNR_OpportunityService_Test {

    @testSetup
    private static void setupData() {
        Account acct = PNR_TestDataFactory.createStreamers(1)[0];
        insert PNR_TestDataFactory.initPartnerAcquisitionOpportunity( acct.Id );
        insert PNR_TestDataFactory.initPartnerAcquisitionOpportunity( acct.Id );
    }

    @isTest
    private static void test_getOpportunityChannels() {
        List<Opportunity> opptys = [SELECT Id FROM Opportunity];

        System.assertEquals(0, PNR_OpportunityService.getOpportunityChannels(opptys[0].Id).size());
        System.assertEquals(0, PNR_OpportunityService.getOpportunityChannels(opptys[1].Id).size());

        PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername1');
        PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername2');

        PNR_OpportunityService.addOpportunityChannel(opptys[1].Id, 'testusername3');

        Test.startTest();

        System.assertEquals(2, PNR_OpportunityService.getOpportunityChannels(opptys[0].Id).size());
        System.assertEquals(1, PNR_OpportunityService.getOpportunityChannels(opptys[1].Id).size());

        Test.stopTest();
    }

    @isTest
    private static void test_addOpportunityChannel() {
        List<Opportunity> opptys = [SELECT Id FROM Opportunity];

        PNR_TestDataFactory.count = 100;
        Account newAcct = PNR_TestDataFactory.createStreamers(1)[0];
        newAcct.TwitchUsername__c = 'testusername';
        update newAcct;

        Test.startTest();

        OpportunityChannel__c channel1 = PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername');
        OpportunityChannel__c channel2 = PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername2');

        OpportunityChannel__c channel3 = PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername');

        Test.stopTest();

        System.assertEquals(0, [SELECT COUNT() FROM OpportunityChannel__c WHERE Streamer__c =: newAcct.Id]);
        System.assertEquals(1, [SELECT COUNT() FROM OpportunityChannel__c WHERE Opportunity__c =: opptys[0].Id AND TwitchUsernameManualEntry__c =: 'testusername']);

        System.assertEquals(0, [SELECT COUNT() FROM Account WHERE TwitchUsername__c = 'testusername2']);
        System.assertEquals(1, [SELECT COUNT() FROM OpportunityChannel__c WHERE Id =: channel2.Id AND Opportunity__c =: opptys[0].Id AND TwitchUsernameManualEntry__c =: 'testusername2']);

        System.assertEquals(channel1.Id, channel3.Id);
    }

    @isTest
    private static void test_addOpportunityChannel_linkAccount() {
        List<Opportunity> opptys = [SELECT Id FROM Opportunity];

        PNR_TestDataFactory.count = 100;
        Account newAcct = PNR_TestDataFactory.createStreamers(1)[0];
        newAcct.TwitchUsername__c = 'testusername';
        update newAcct;

        Test.startTest();

        OpportunityChannel__c channel1 = PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername', true);
        OpportunityChannel__c channel2 = PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername2', true);

        OpportunityChannel__c channel3 = PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername', true);

        Test.stopTest();

        System.assertEquals(channel1.Id, [SELECT Id FROM OpportunityChannel__c WHERE Id =: channel1.Id AND Opportunity__c =: opptys[0].Id AND Streamer__c =: newAcct.Id].Id);

        System.assertEquals(newAcct.Id, channel1.Streamer__c);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE TwitchUsername__c = 'testusername2']);
        System.assertEquals(channel1.Id, channel3.Id);
    }

    @isTest
    private static void test_removeOpportunityChannel() {
        List<Opportunity> opptys = [SELECT Id FROM Opportunity];
        OpportunityChannel__c channel = PNR_OpportunityService.addOpportunityChannel(opptys[0].Id, 'testusername');

        Test.startTest();

        PNR_OpportunityService.removeOpportunityChannel(channel.Id);

        Test.stopTest();

        System.assertEquals(0, [SELECT COUNT() FROM OpportunityChannel__c WHERE Id =: channel.Id]);
    }

    @isTest
    private static void test_calculateMonthlyEstimatedMinutesWatched_fullMonth1() {
        Date broadcastStartDate = Date.newInstance(2017,1,1);
        Date startOfMonth = Date.newInstance(2017,1,1);
        Decimal opptyMinutes = 120;

        System.assertEquals(5, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth, opptyMinutes, false));
        System.assertEquals(7.5, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(1), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(2), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(3), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(4), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(5), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(6), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(7), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(8), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(9), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(10), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(11), opptyMinutes, false));
    }

    @isTest
    private static void test_calculateMonthlyEstimatedMinutesWatched_partialMonth() {
        Date broadcastStartDate = Date.newInstance(2017,4,16);
        Date startOfMonth = Date.newInstance(2017,4,1);
        Decimal opptyMinutes = 120;

        System.assertEquals(2.5, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth, opptyMinutes, false));
        System.assertEquals(2.5 + 3.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(1), opptyMinutes, false));
        System.assertEquals(3.75 + 5.375, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(2), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(3), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(4), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(5), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(6), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(7), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(8), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(9), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(10), opptyMinutes, false));
        System.assertEquals(10.75, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(11), opptyMinutes, false));
        System.assertEquals(5.375, PNR_OpportunityService.calculateMonthlyEstimatedMinutesWatched(broadcastStartDate, startOfMonth.addMonths(12), opptyMinutes, false));
    }


    @isTest
    private static void test_calculateForecastedMonths_partnerships_fullMonth1_asPartnershipsUser() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;

        PNR_TestDataFactory.createPartnershipsUsers(1);
        List<User> users = new PNR_UsersSelector().selectActivePartnershipsUsers();

        Opportunity oppty;
        System.runAs(users[0]) {
            Account partnerAcct = PNR_TestDataFactory.createPartners(1)[0];
            oppty = PNR_TestDataFactory.initPartnerAcquisitionOpportunity(partnerAcct.Id);
            oppty.CloseDate = Date.newInstance(Date.today().year() + 1, 1, 1);
            oppty.BroadcastStartDate__c = Date.newInstance(Date.today().year() + 1, 1, 1);
            insert oppty;
        }

        Test.startTest();

        System.runAs(users[0]) {
            PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });
        }

        Test.stopTest();

        System.assertEquals(12, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
    }

    @isTest
    private static void test_calculateForecastedMonths_partnerships_fullMonth1() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;

        Account partnerAcct = PNR_TestDataFactory.createPartners(1)[0];
        Opportunity oppty = PNR_TestDataFactory.initPartnerAcquisitionOpportunity(partnerAcct.Id);
        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,1,1);
        oppty.BroadcastStartDate__c = Date.newInstance(Date.today().year() + 1,1,1);
        insert oppty;

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        Test.stopTest();

        System.assertEquals(12, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
    }

    @isTest
    private static void test_calculateForecastedMonths_partnerships_fullMonth2() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;

        Account partnerAcct = PNR_TestDataFactory.createPartners(1)[0];
        Opportunity oppty = PNR_TestDataFactory.initPartnerAcquisitionOpportunity(partnerAcct.Id);
        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,1,31);
        oppty.BroadcastStartDate__c = Date.newInstance(Date.today().year() + 1,1,31);
        insert oppty;

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        Test.stopTest();

        System.assertEquals(13, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
    }

    @isTest
    private static void test_calculateForecastedMonths_partnerships_partialMonth() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;

        Account partnerAcct = PNR_TestDataFactory.createPartners(1)[0];
        Opportunity oppty = PNR_TestDataFactory.initPartnerAcquisitionOpportunity(partnerAcct.Id);
        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,1,3);
        oppty.BroadcastStartDate__c = Date.newInstance(Date.today().year() + 1,1,3);
        insert oppty;

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        Test.stopTest();

        System.assertEquals(13, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
    }

    @isTest
    private static void test_calculateForecastedMonths_partnerships_bulk1() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;

        Account partnerAcct = PNR_TestDataFactory.createPartners(1)[0];
        PNR_TestDataFactory.createPartnerAcquisitionOpportunities(new Set<Id>{ partnerAcct.Id }, 200);
        List<Opportunity> insertedOpptys = new PNR_OpportunitiesSelector().selectByAccountId( new Set<Id>{ partnerAcct.Id });

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths( new Map<Id, Opportunity>(insertedOpptys).keySet() );

        Test.stopTest();

        System.assertEquals(13 * 200, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: insertedOpptys]);
    }

    @isTest
    private static void test_calculateForecastedMonths_partnerships_update() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;

        Account partnerAcct = PNR_TestDataFactory.createPartners(1)[0];
        Opportunity oppty = PNR_TestDataFactory.initPartnerAcquisitionOpportunity(partnerAcct.Id);
        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,1,3);
        oppty.BroadcastStartDate__c = Date.newInstance(Date.today().year() + 1,1,3);
        insert oppty;

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        System.assertEquals(13, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
        System.assertEquals(Date.newInstance(Date.today().year() + 1,1,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c ASC LIMIT 1][0].Date__c);
        System.assertEquals(Date.newInstance(Date.today().year() + 2,1,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c DESC LIMIT 1][0].Date__c);

        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,4,1);
        oppty.BroadcastStartDate__c = Date.newInstance(Date.today().year() + 1,4,1);
        update oppty;

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        Test.stopTest();

        System.assertEquals(12, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
        System.assertEquals(Date.newInstance(Date.today().year() + 1,4,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c ASC LIMIT 1][0].Date__c);
        System.assertEquals(Date.newInstance(Date.today().year() + 2,3,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c DESC LIMIT 1][0].Date__c);
    }

    @isTest
    private static void test_calculateForecastedMonths_bd_monthly_insert() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;
        PNR_OpportunityYears.triggerDisabled = true;

        Account acct = PNR_TestDataFactory.createCompanies(1)[0];
        Opportunity oppty = PNR_TestDataFactory.initBusinessDevelopmentOpportunity(acct.Id);
        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,1,1);
        oppty.ProgramStartDate__c = Date.newInstance(Date.today().year() + 1,1,1);
        insert oppty;

        PNR_TestDataFactory.createOpportunityYearMonthlyEstimate(new Set<Id>{ oppty.Id }, 1);
        List<OpportunityYear__c> theYears = new PNR_OpportunityYearsSelector().selectByOpportunityId(new Set<Id>{ oppty.Id });
        theYears[0].AugustMinutesWatched__c = 0;
        theYears[0].SeptemberMinutesWatched__c = null;
        update theYears;

        PNR_OpportunityYears years = new PNR_OpportunityYears(theYears);
        // Need to setup the data to have monthly estimates
        years.setMonthlyEstimatesForYearlyForecast(null);
        update years.getRecords();

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        Test.stopTest();

        System.assertEquals(10, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
    }

    @isTest
    private static void test_calculateForecastedMonths_bd_yearly_insert() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;
        PNR_OpportunityYears.triggerDisabled = true;

        Account acct = PNR_TestDataFactory.createCompanies(1)[0];
        Opportunity oppty = PNR_TestDataFactory.initBusinessDevelopmentOpportunity(acct.Id);
        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,1,1);
        oppty.ProgramStartDate__c = Date.newInstance(Date.today().year() + 1,1,1);
        insert oppty;

        PNR_TestDataFactory.createOpportunityYearYearlyEstimate(new Set<Id>{ oppty.Id }, 1);

        PNR_OpportunityYears years = new PNR_OpportunityYears(new PNR_OpportunityYearsSelector().selectByOpportunityId(new Set<Id>{ oppty.Id }));
        // Need to setup the data to have monthly estimates
        years.setMonthlyEstimatesForYearlyForecast(null);
        update years.getRecords();

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        Test.stopTest();

        System.assertEquals(12, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
    }

    @isTest
    private static void test_calculateForecastedMonths_bd_yearly_update() {
        PNR_TestDataFactory.count = 1000;

        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;
        PNR_OpportunityYears.triggerDisabled = true;

        Account acct = PNR_TestDataFactory.createCompanies(1)[0];
        Opportunity oppty = PNR_TestDataFactory.initBusinessDevelopmentOpportunity(acct.Id);
        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,1,3);
        oppty.ProgramStartDate__c = Date.newInstance(Date.today().year() + 1,1,3);
        insert oppty;

        PNR_TestDataFactory.createOpportunityYearYearlyEstimate(new Set<Id>{ oppty.Id }, 1);

        PNR_OpportunityYears years = new PNR_OpportunityYears(new PNR_OpportunityYearsSelector().selectByOpportunityId(new Set<Id>{ oppty.Id }));
        // Need to setup the data to have monthly estimates
        years.setMonthlyEstimatesForYearlyForecast(null);
        update years.getRecords();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        System.assertEquals(12, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
        System.assertEquals(Date.newInstance(Date.today().year() + 1,1,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c ASC LIMIT 1][0].Date__c);
        System.assertEquals(Date.newInstance(Date.today().year() + 1,12,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c DESC LIMIT 1][0].Date__c);

        oppty.CloseDate = Date.newInstance(Date.today().year() + 1,4,1);
        oppty.ProgramStartDate__c = Date.newInstance(Date.today().year() + 1,4,1);
        update oppty;

        years = new PNR_OpportunityYears(new PNR_OpportunityYearsSelector().selectByOpportunityId(new Set<Id>{ oppty.Id }));
        // Need to setup the data to have monthly estimates
        years.setMonthlyEstimatesForYearlyForecast(null);
        update years.getRecords();

        Test.startTest();

        PNR_OpportunityService.calculateForecastedMonths(new Set<Id>{ oppty.Id });

        Test.stopTest();

        System.assertEquals(12, [SELECT COUNT() FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id]);
        System.assertEquals(Date.newInstance(Date.today().year() + 1,4,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c ASC LIMIT 1][0].Date__c);
        System.assertEquals(Date.newInstance(Date.today().year() + 2,3,1), [SELECT Date__c FROM ForecastedMonth__c WHERE Opportunity__c =: oppty.Id ORDER BY Date__c DESC LIMIT 1][0].Date__c);
    }

    @isTest
    private static void test_addContractRequests() {
        PNR_Accounts.triggerDisabled = true;
        PNR_Opportunities.triggerDisabled = true;
        PNR_ContractRequests.triggerDisabled = true;

        Account acct = PNR_TestDataFactory.createCompanies(1)[0];
        PNR_TestDataFactory.createPartnerAcquisitionOpportunities(new Set<Id>{acct.Id}, 5);

        Set<Id> opptyIds = new Map<Id, Opportunity>([SELECT Id FROM Opportunity WHERE AccountId =: acct.Id]).keySet();
        System.assertEquals(5, opptyIds.size());

        Test.startTest();

        PNR_OpportunityService.addContractRequests(opptyIds);

        Test.stopTest();

        Set<Id> contractRequestIds = new Set<Id>();
        for (Opportunity oppty : new PNR_OpportunitiesSelector().selectById(opptyIds)) {
            System.assertNotEquals(null, oppty.ContractRequest__c);

            if (oppty.ContractRequest__c != null) {
                contractRequestIds.add(oppty.ContractRequest__c);
            }
        }
        System.assertEquals(5, contractRequestIds.size());
    }
}