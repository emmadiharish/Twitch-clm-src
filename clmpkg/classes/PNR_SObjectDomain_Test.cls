@isTest
private class PNR_SObjectDomain_Test {

  private static String lastMethodCalled;

  @isTest
  private static void testGetterMethods() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    System.assertEquals(Account.SObjectType, testDomain.getSObjectType());

    System.assertEquals(0, testDomain.getRecords().size());
  }

  @isTest
  private static void test_isTriggerDisabled() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());

    System.assertEquals(false, testDomain.isTriggerDisabled());
  }

  @isTest
  private static void test_handleBeforeInsert() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleBeforeInsert();
  }

  @isTest
  private static void test_handleBeforeUpdate() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleBeforeUpdate(new Map<Id, Account>());
  }

  @isTest
  private static void test_handleBeforeDelete() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleBeforeDelete();
  }

  @isTest
  private static void test_handleAfterInsert() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleAfterInsert();
  }

  @isTest
  private static void test_handleAfterUpdate() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleAfterUpdate(new Map<Id, Account>());
  }

  @isTest
  private static void test_handleAfterDeleteNew() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleAfterDeleteNew(new Map<Id, Account>());
  }
  
  @isTest
  private static void test_handleAfterDelete() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleAfterDelete();
  }

  @isTest
  private static void test_handleAfterUndelete() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());
    testDomain.handleAfterUndelete();
  }

  @isTest
  private static void test_triggerHandler() {
    PNR_SObjectDomain.triggerHandler(TestConstructor.class, true, false, true, false, false, false, new List<Account>(), new Map<Id, Account>());
    System.assertEquals('onBeforeInsert', PNR_SObjectDomain_Test.lastMethodCalled);

    PNR_SObjectDomain.triggerHandler(TestConstructor.class, true, false, false, true, false, false, new List<Account>(), new Map<Id, Account>());
    System.assertEquals('onBeforeUpdate', PNR_SObjectDomain_Test.lastMethodCalled);

    PNR_SObjectDomain.triggerHandler(TestConstructor.class, true, false, false, false, true, false, new List<Account>(), new Map<Id, Account>());
    System.assertEquals('onBeforeDelete', PNR_SObjectDomain_Test.lastMethodCalled);

    PNR_SObjectDomain.triggerHandler(TestConstructor.class, false, true, true, false, false, false, new List<Account>(), new Map<Id, Account>());
    System.assertEquals('onAfterInsert', PNR_SObjectDomain_Test.lastMethodCalled);

    PNR_SObjectDomain.triggerHandler(TestConstructor.class, false, true, false, true, false, false, new List<Account>(), new Map<Id, Account>());
    System.assertEquals('onAfterUpdate', PNR_SObjectDomain_Test.lastMethodCalled);
    
    PNR_SObjectDomain.triggerHandler(TestConstructor.class, false, true, false, false, true, false, new List<Account>(), new Map<Id, Account>());
    System.assertNotEquals('onAfterDeleteNew', PNR_SObjectDomain_Test.lastMethodCalled);

    PNR_SObjectDomain.triggerHandler(TestConstructor.class, false, true, false, false, true, false, new List<Account>(), new Map<Id, Account>());
    System.assertEquals('onAfterDelete', PNR_SObjectDomain_Test.lastMethodCalled);
    
    
    //PNR_SObjectDomain.triggerHandler(TestConstructor.class, false, true, false, false, true, false, new List<Account>(), new Map<Id, Account>());
    //System.assertEquals('onAfterDeleteNew', PNR_SObjectDomain_Test.lastMethodCalled);

    PNR_SObjectDomain.triggerHandler(TestConstructor.class, false, true, false, false, false, true, new List<Account>(), new Map<Id, Account>());
    System.assertEquals('onAfterUndelete', PNR_SObjectDomain_Test.lastMethodCalled);

    // The following should trigger no methods as it is non-trigger execution
    PNR_SObjectDomain_Test.lastMethodCalled = null;

    PNR_SObjectDomain.triggerHandler(TestConstructor.class);
    System.assert(String.isBlank(PNR_SObjectDomain_Test.lastMethodCalled));
  }

  @isTest
  private static void testVirtualMethods() {
    TestAccounts testDomain = new TestAccounts(new List<Account>());

    testDomain.onApplyDefaults();
    testDomain.onValidate();
    testDomain.onValidate(new Map<Id, Account>());
    testDomain.onBeforeInsert();
    testDomain.onBeforeUpdate(new Map<Id, Account>());
    testDomain.onBeforeDelete();
    testDomain.onAfterInsert();
    testDomain.onAfterUpdate(new Map<Id, Account>());
    testDomain.onAfterDelete();
    testDomain.onAfterDeleteNew(new Map<Id, Account>());
    testDomain.onAfterUndelete();
  }

  public class TestAccounts extends PNR_SObjectDomain {

    public TestAccounts(List<Account> sObjectList) {
      super(SObjectList);
    }

    public override void onBeforeInsert() {
      super.onBeforeInsert();
      PNR_SObjectDomain_Test.lastMethodCalled = 'onBeforeInsert';
    }

    public override void onBeforeUpdate(Map<Id, SObject> existingRecords) {
      super.onBeforeUpdate(existingRecords);
      PNR_SObjectDomain_Test.lastMethodCalled = 'onBeforeUpdate';
    }

    public override void onBeforeDelete() {
      super.onBeforeDelete();
      PNR_SObjectDomain_Test.lastMethodCalled = 'onBeforeDelete';
    }

    public override void onAfterInsert() {
      super.onAfterInsert();
      PNR_SObjectDomain_Test.lastMethodCalled = 'onAfterInsert';
    }

    public override void onAfterUpdate(Map<Id, SObject> existingRecords) {
      super.onAfterUpdate(existingRecords);
      PNR_SObjectDomain_Test.lastMethodCalled = 'onAfterUpdate';
    }

    public override void onAfterDeleteNew(Map<Id, SObject> existingRecords) {
      super.onAfterDeleteNew(existingRecords);
      PNR_SObjectDomain_Test.lastMethodCalled = 'onAfterDeleteNew';
    }
    
    public override void onAfterDelete() {
      super.onAfterDelete();
      PNR_SObjectDomain_Test.lastMethodCalled = 'onAfterDelete';
    }
    
    

    public override void onAfterUndelete() {
      super.onAfterUndelete();
      PNR_SObjectDomain_Test.lastMethodCalled = 'onAfterUndelete';
    }
  }

  @IsTest
  private static void testErrorLogging() {
    // Test static helpers for raise none domain object instance errors
    Opportunity opp = new Opportunity ( Name = 'Test', Type = 'Existing Account' );
    PNR_SObjectDomain.Errors.error('Error', opp);
    PNR_SObjectDomain.Errors.error('Error', opp, Opportunity.Type);
    System.assertEquals(2, PNR_SObjectDomain.Errors.getAll().size());
    System.assertEquals('Error', PNR_SObjectDomain.Errors.getAll()[0].message);
    System.assertEquals('Error', PNR_SObjectDomain.Errors.getAll()[1].message);
    System.assertEquals(Opportunity.Type, ((PNR_SObjectDomain.FieldError)PNR_SObjectDomain.Errors.getAll()[1]).field);
    PNR_SObjectDomain.Errors.clearAll();
    System.assertEquals(0, PNR_SObjectDomain.Errors.getAll().size());
  }

  public class TestConstructor implements PNR_SObjectDomain.IConstructable {

    public PNR_SObjectDomain construct(List<SObject> sObjectList) {
      return new TestAccounts(sObjectList);
    }
  }
}