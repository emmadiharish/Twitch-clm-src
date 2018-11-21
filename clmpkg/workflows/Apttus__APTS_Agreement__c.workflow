<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Agreement_120_Day_Renewal</fullName>
        <description>Agreement - 120 Day Renewal</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Apttus__Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>no-response@twitch.tv</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Apttus__ApttusEmailTemplates/Agreement_Renewal_Notification</template>
    </alerts>
    <alerts>
        <fullName>Agreement_Approved_Request</fullName>
        <description>Agreement - Approved Request</description>
        <protected>false</protected>
        <recipients>
            <field>Apttus__Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>no-response@twitch.tv</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Apttus__ApttusEmailTemplates/Approval_Request_Approved_Notification</template>
    </alerts>
    <alerts>
        <fullName>Agreement_Effective_vs_Signature_Date_Day_Count</fullName>
        <description>Agreement - Effective vs Signature Date - Day Count</description>
        <protected>false</protected>
        <recipients>
            <field>Apttus__Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>no-response@twitch.tv</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Apttus__ApttusEmailTemplates/Agreement_Effective_vs_Signature_Date_Day_Count</template>
    </alerts>
    <alerts>
        <fullName>Agreement_Fully_Executed</fullName>
        <ccEmails>robertboyd9@yahoo.com</ccEmails>
        <description>Agreement - Fully-Executed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Apttus__Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>no-response@twitch.tv</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Apttus__ApttusEmailTemplates/Agreement_Fully_Executed_Notification</template>
    </alerts>
    <alerts>
        <fullName>Agreement_Rejected_Request</fullName>
        <description>Agreement - Rejected Request</description>
        <protected>false</protected>
        <recipients>
            <field>Apttus__Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>no-response@twitch.tv</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Apttus__ApttusEmailTemplates/Approval_Request_Rejected_Notification</template>
    </alerts>
    <alerts>
        <fullName>Agreement_Submitted_Request_Legal_Queue</fullName>
        <description>Agreement - Submitted Request Legal Queue</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>no-response@twitch.tv</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Apttus__ApttusEmailTemplates/Apttus__Agreement_Review_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Agreement_Approval_Status_Approval_Re</fullName>
        <field>Apttus_Approval__Approval_Status__c</field>
        <literalValue>Approval Required</literalValue>
        <name>Agreement - Approval Status &apos;Approval Re</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Approval_Status_Approved</fullName>
        <field>Apttus_Approval__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Agreement - Approval Status &apos;Approved&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Auto_Renew_Checked</fullName>
        <field>Apttus__Auto_Renewal__c</field>
        <literalValue>1</literalValue>
        <name>Agreement - Auto-Renew &apos;Checked&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Fields_Needed_For_Approval</fullName>
        <field>FieldsForApprovalComplete__c</field>
        <literalValue>1</literalValue>
        <name>Agreement - Fields Needed For Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Fully_Signed_Status</fullName>
        <field>Apttus__Status__c</field>
        <literalValue>Activated</literalValue>
        <name>Agreement - Fully-Signed Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Fully_Signed_Status_Category</fullName>
        <field>Apttus__Status_Category__c</field>
        <literalValue>In Effect</literalValue>
        <name>Agreement - Fully-Signed Status Category</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Int_Renewal_Notice_120_Days</fullName>
        <description>Notification period prior to Renewal Notice Date when notification is sent out internally that renewal is approaching.  Business has asked for 120 days, which means 90 days (Renewal Notice Date) + 30 days with this field equals 120 days.</description>
        <field>Apttus__Internal_Renewal_Notification_Days__c</field>
        <formula>30</formula>
        <name>Agreement - Int Renewal Notice 120 Days</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Internal_Signatures_Status</fullName>
        <field>Apttus__Status__c</field>
        <literalValue>Internal Signatures</literalValue>
        <name>Agreement - Internal Signatures Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Internal_Signatures_Status_C</fullName>
        <field>Apttus__Status_Category__c</field>
        <literalValue>In Signatures</literalValue>
        <name>Agreement - Internal Signatures Status C</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Non_Standard_Terms_Checked</fullName>
        <field>Apttus__Non_Standard_Legal_Language__c</field>
        <literalValue>1</literalValue>
        <name>Agreement - Non Standard Terms &apos;Checked&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Other_Party_Sign_Status</fullName>
        <field>Apttus__Status_Category__c</field>
        <literalValue>In Signatures</literalValue>
        <name>Agreement - Other Party Sign Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Other_Party_Sign_Status_Cate</fullName>
        <field>Apttus__Status__c</field>
        <literalValue>Other Party Signatures</literalValue>
        <name>Agreement - Other Party Sign Status Cate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Renewal_Notice_90_Days</fullName>
        <field>Apttus__Renewal_Notice_Days__c</field>
        <formula>90</formula>
        <name>Agreement - Renewal Notice 90 Days</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Twitch_Counter_Signer</fullName>
        <field>Twitch_Signatory__c</field>
        <formula>IF(TotalEstimatedCost__c &gt; 2500000,&quot;aragonmi@twitch.tv.test&quot;, 
IF(TotalEstimatedCost__c &lt;= 2500000,&quot;jeh@justin.tv.test&quot;, 
NULL))</formula>
        <name>Agreement - Twitch Counter-Signer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Update_Agreement_End_Date</fullName>
        <description>Update the Agreement End Date to reflect the appropriate end date, per the values in the Agreement Start Date and Term (Months) fields.</description>
        <field>Apttus__Contract_End_Date__c</field>
        <formula>DATE( 
YEAR(Apttus__Contract_Start_Date__c) + 
FLOOR((Apttus__Term_Months__c + MONTH(Apttus__Contract_Start_Date__c)) / 12) - 
IF (MOD(MONTH(Apttus__Contract_Start_Date__c) + Apttus__Term_Months__c, 12) = 0, 1, 0), 
MOD((Apttus__Term_Months__c + MONTH(Apttus__Contract_Start_Date__c) - 1), 12) + 1, 
DAY(Apttus__Contract_Start_Date__c) 
)-1</formula>
        <name>Agreement - Update Agreement End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Agreement_Version_Aware_Checked</fullName>
        <field>Apttus__VersionAware__c</field>
        <literalValue>1</literalValue>
        <name>Agreement - Version Aware &apos;Checked&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Author_Contract</fullName>
        <field>Apttus__Status__c</field>
        <literalValue>Author Contract</literalValue>
        <name>Status &apos;Author Contract&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Category_In_Authoring</fullName>
        <field>Apttus__Status_Category__c</field>
        <literalValue>In Authoring</literalValue>
        <name>Status Category &apos;In Authoring&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Agreement - 120 Day Renewal</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Status_Category__c</field>
            <operation>equals</operation>
            <value>In Effect</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Status__c</field>
            <operation>equals</operation>
            <value>Activated</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Contract_End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email notification to Requestor &amp; Owner field values when a fully-executed Agreement record is 120 days from its end date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Agreement_120_Day_Renewal</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Apttus__APTS_Agreement__c.Apttus__Contract_End_Date__c</offsetFromField>
            <timeLength>-120</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Agreement - Amended%2FRenewed Agreement</fullName>
        <actions>
            <name>Agreement_Approval_Status_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.LatestAgreementCycle__c</field>
            <operation>equals</operation>
            <value>Renewed</value>
        </criteriaItems>
        <description>Update the Approval Status field to &apos;Approved&apos;, if an Agreement record has just been amended or renewed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Approval Status %27Approval Required%27</fullName>
        <actions>
            <name>Agreement_Approval_Status_Approval_Re</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update the Approval Status field to &apos;Approval Required&apos;, if the Non Standard Terms field is &apos;checked&apos; and the Approval Status field is &apos;Not Submitted&apos;.</description>
        <formula>AND(
Apttus__Non_Standard_Legal_Language__c = TRUE,
LatestAgreementCycle__c = &apos;Original&apos;,
OR(
ISPICKVAL(Apttus_Approval__Approval_Status__c,&apos;Not Submitted&apos;), ISPICKVAL(Apttus_Approval__Approval_Status__c,&apos;Rejected&apos;), ISPICKVAL(Apttus_Approval__Approval_Status__c,&apos;Cancelled&apos;), ISPICKVAL(Apttus_Approval__Approval_Status__c,&apos;&apos;)
)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Approved Finance Fields Changed</fullName>
        <actions>
            <name>Agreement_Approval_Status_Approval_Re</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update the Approval Status field to &apos;Approval Required&apos;, if any Finance-based fields are changed after the Agreement record has been &apos;approved&apos;.</description>
        <formula>AND(
NOT(ISPICKVAL(Apttus__Status_Category__c,&quot;In Effect&quot;)), NOT(ISPICKVAL(Apttus__Status__c,&quot;Activated&quot;)), ISPICKVAL(Apttus_Approval__Approval_Status__c,&quot;Approved&quot;), LatestAgreementCycle__c &lt;&gt; &quot;Renewed&quot;, 
OR( 
ISCHANGED(X2018TotalContentCost__c),
ISCHANGED(X2019TotalContentCost__c),
ISCHANGED(AdDensityRequirementMinHr__c), ISCHANGED(AdvertisingRevenueTerms__c), ISCHANGED(BitsRevenueTerms__c), 
ISCHANGED(BudgetedCCVsAverage__c),
ISCHANGED(BudgetedLiveHWCumulative__c),
ISCHANGED(BudgetedVODHWCumulative__c),
ISCHANGED(CumulativeOperatingIncome__c), ISCHANGED(CustomAdDensityRequirement__c), ISCHANGED(CustomAdvertisingRevenueTerms__c), ISCHANGED(CustomLiveExclusivity__c), ISCHANGED(CustomSubscriptionRevenueTerms__c), ISCHANGED(CustomVODExclusivity__c), 
ISCHANGED(DealMemoURL__c),
ISCHANGED(DealModelUploaded__c),
ISCHANGED(FuelRevenueTerms__c),
ISCHANGED(GrossRevenueCumulative__c),
ISCHANGED(Incentives__c),
ISCHANGED(InvoiceFrequency__c), ISCHANGED(LicenseFeeAmount__c), ISCHANGED(LiveExclusivity__c), ISCHANGED(MinimumGuaranteeAmount__c), 
ISCHANGED(NetRevenueCumulative__c),
ISCHANGED(PartnerTier__c),
ISCHANGED(OneTimeBonusPayment__c), ISCHANGED(OtherCustomTermsRequirements__c), ISCHANGED(SubscriptionRevenueTerms__c),
ISCHANGED(TotalContentCostkMW__c),
ISCHANGED(TotalEstimatedCost__c), ISCHANGED(VODExclusivity__c)
)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Approved Request</fullName>
        <actions>
            <name>Agreement_Approved_Request</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.ApprovalApproved__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Email notification to Requestor field value when an Agreement record has been &apos;approved&apos;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Effective vs Signature Date - Day Count</fullName>
        <actions>
            <name>Agreement_Effective_vs_Signature_Date_Day_Count</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.EffectivevsSignatureDateDayCount__c</field>
            <operation>greaterOrEqual</operation>
            <value>60</value>
        </criteriaItems>
        <description>Email notification to Requestor &amp; Owner field values when an Agreement record has a greater than or equal to 60 day period when the effective date is different than the signed date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Fields Needed For Approval - Content License</fullName>
        <actions>
            <name>Agreement_Fields_Needed_For_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update the Fields For Approval Complete field to &apos;checked&apos;, if all the Finance based fields have a value in a &apos;Content License&apos; Agreement record.</description>
        <formula>AND(
RecordType.Name = &quot;Twitch - Content License&quot;,
NOT(ISBLANK(TEXT(AdDensityRequirementMinHr__c))), NOT(ISBLANK(TEXT(AdvertisingRevenueTerms__c))), NOT(ISBLANK(TEXT(BitsRevenueTerms__c))), 
NOT(ISBLANK(BudgetedCCVsAverage__c)), 
NOT(ISBLANK(BudgetedLiveHWCumulative__c)), 
NOT(ISBLANK(BudgetedVODHWCumulative__c)), 
NOT(ISBLANK(CumulativeOperatingIncome__c)),
NOT(ISBLANK(DealMemoURL__c)), 
NOT(ISBLANK(TEXT(DealModelUploaded__c))), 
NOT(ISBLANK(TEXT(FuelRevenueTerms__c))), 
NOT(ISBLANK(GrossRevenueCumulative__c)), 
NOT(ISBLANK(Incentives__c)),
NOT(ISBLANK(LicenseFeeAmount__c)), NOT(ISBLANK(TEXT(LiveExclusivity__c))), NOT(ISBLANK(MinimumGuaranteeAmount__c)), 
NOT(ISBLANK(NetRevenueCumulative__c)), 
NOT(ISBLANK(TEXT(SubscriptionRevenueTerms__c))), 
NOT(ISBLANK(TotalContentCostkMW__c)), 
NOT(ISBLANK(TotalEstimatedCost__c)), NOT(ISBLANK(TEXT(VODExclusivity__c))),
NOT(ISBLANK(X2018TotalContentCost__c)),
NOT(ISBLANK(X2019TotalContentCost__c))
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Fully-Executed</fullName>
        <actions>
            <name>Agreement_Fully_Executed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Status_Category__c</field>
            <operation>equals</operation>
            <value>In Effect</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Status__c</field>
            <operation>equals</operation>
            <value>Activated</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus_Approval__Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Email notification to Requestor &amp; Owner field values when an Agreement record has been fully-executed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Fully-Signed</fullName>
        <actions>
            <name>Agreement_Fully_Signed_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Agreement_Fully_Signed_Status_Category</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7</booleanFilter>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.TwitchSignedBy__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Company_Signed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Twitch_Signed_Title__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.OtherPartySignedBy__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Other_Party_Signed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Other_Party_Signed_Title__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus_Approval__Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Update two fields after an agreement document is fully-signed in the Agreement record.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Internal Signatures</fullName>
        <actions>
            <name>Agreement_Internal_Signatures_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Agreement_Internal_Signatures_Status_C</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.OtherPartySignedBy__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Other_Party_Signed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Other_Party_Signed_Title__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.TwitchSignedBy__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Company_Signed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Twitch_Signed_Title__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Update two fields after a team/user signs an agreement document in the Agreement record.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - NST - Content License</fullName>
        <actions>
            <name>Agreement_Auto_Renew_Checked</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Agreement_Int_Renewal_Notice_120_Days</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Agreement_Non_Standard_Terms_Checked</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Agreement_Renewal_Notice_90_Days</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Agreement_Version_Aware_Checked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Twitch - Content License</value>
        </criteriaItems>
        <description>Update five fields, only if the newly created Agreement record has a Record Type field value containing Content License.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Other Party Signatures</fullName>
        <actions>
            <name>Agreement_Other_Party_Sign_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Agreement_Other_Party_Sign_Status_Cate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.OtherPartySignedBy__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Other_Party_Signed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Other_Party_Signed_Title__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.TwitchSignedBy__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Company_Signed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Twitch_Signed_Title__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update two fields after a user clicks the &apos;Send for DocuSign&apos; button on the Agreement record.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Rejected Request</fullName>
        <actions>
            <name>Agreement_Rejected_Request</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.ApprovalRejected__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Email notification to Requestor field value when an Agreement record has been &apos;rejected&apos;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Submitted Request Legal Queue</fullName>
        <actions>
            <name>Agreement_Submitted_Request_Legal_Queue</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Twitch - Content License</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Status_Category__c</field>
            <operation>equals</operation>
            <value>Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Status__c</field>
            <operation>equals</operation>
            <value>Submitted Request</value>
        </criteriaItems>
        <description>Email notification to Owner field value after a Partnership Team user clicks the &quot;Submit Request&quot; button.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Twitch Counter-Signer</fullName>
        <actions>
            <name>Agreement_Twitch_Counter_Signer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.TotalEstimatedCost__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update the Twitch Counter-Signer field to the appropriate email address, based on the signer matrix provided by Twitch Legal.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Update Agreement End Date</fullName>
        <actions>
            <name>Agreement_Update_Agreement_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Twitch - Content License</value>
        </criteriaItems>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Term_Months__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update the Agreement End Date to reflect the appropriate end date, per the values in the Agreement Start Date and Term (Months) fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Agreement - Workflow Trigger Generated Agreement</fullName>
        <actions>
            <name>Status_Author_Contract</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Status_Category_In_Authoring</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Apttus__APTS_Agreement__c.Apttus__Workflow_Trigger_Viewed_Final__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Update two fields, only if the Agreement Document record has been generated.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
