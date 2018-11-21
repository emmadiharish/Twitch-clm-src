({
    setContextVariables: function(component) {
        this.setEligibleForApproval(component);
        this.setValidForApproval(component);
        this.setInApprovalProcess(component);
        this.setEligibleForContract(component);
        this.setValidForContract(component);
        this.setInContractProcess(component);
    },

    setEligibleForApproval: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        component.set("v.eligibleForApproval", (simpleRecord !== null &&
                                                simpleRecord.Id !== null &&
                                                simpleRecord.ContentApprovalSubmitted__c === false &&
                                                simpleRecord.ContentApprovalDate__c === null &&
                                                simpleRecord.ContractType__c !== "EULA" ));
    },

    setValidForApproval: function(component) {
        component.set("v.validForApproval", this.validForApprovalHelper_EULA(component) ||
                                            this.validForApprovalHelper_CLA(component) ||
                                            this.validForApprovalHelper_Amendment(component) );
    },

    validForApprovalHelper_EULA: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        return (simpleRecord !== null &&
                simpleRecord.Id !== null &&
                simpleRecord.ContractType__c == "EULA" &&
                false); // EULA should not enter Approval
    },

    validForApprovalHelper_CLA: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        return (simpleRecord !== null &&
                simpleRecord.Id !== null &&
                (
                    simpleRecord.ContractType__c == "CLA" ||
                    simpleRecord.ContractType__c == "CLBNA"
                ) &&
                simpleRecord.TotalEstimatedCost__c !== null &&
                (
                    (
                        simpleRecord.TotalEstimatedCost__c < simpleRecord.Apttus__Related_Opportunity__r.Owner.DealMemoMinimumRequirement__c ||
                        simpleRecord.DealMemoURL__c !== null
                    ) &&
                    (
                        simpleRecord.TotalEstimatedCost__c < simpleRecord.Apttus__Related_Opportunity__r.Owner.DealModelMinimumRequirement__c ||
                        simpleRecord.DealModelUploaded__c == "Yes"
                    )
                ) &&
                simpleRecord.CumulativeOperatingIncome__c !== null &&
                simpleRecord.TotalContentCostkMW__c !== null &&
                simpleRecord.AdvertisingRevenueTerms__c !== null &&
                (
                    simpleRecord.AdvertisingRevenueTerms__c !== "Custom" ||
                    simpleRecord.CustomAdvertisingRevenueTerms__c !== null
                ) &&
                simpleRecord.SubscriptionRevenueTerms__c !== null &&
                (
                    simpleRecord.SubscriptionRevenueTerms__c !== "Custom" ||
                    simpleRecord.CustomSubscriptionRevenueTerms__c !== null
                ) &&
                simpleRecord.BitsRevenueTerms__c !== null &&
                (
                    simpleRecord.BitsRevenueTerms__c !== "Custom" ||
                    simpleRecord.CustomBitsRevenueTerms__c !== null
                ) &&
                simpleRecord.FuelRevenueTerms__c !== null &&
                (
                    simpleRecord.FuelRevenueTerms__c !== "Custom" ||
                    simpleRecord.CustomFuelRevenueTerms__c !== null
                ) &&
                simpleRecord.LiveExclusivity__c !== null &&
                (
                    simpleRecord.LiveExclusivity__c !== "Custom" ||
                    simpleRecord.CustomLiveExclusivity__c !== null
                ) &&
                simpleRecord.VODExclusivity__c !== null &&
                (
                    simpleRecord.VODExclusivity__c !== "Custom" ||
                    simpleRecord.CustomVODExclusivity__c !== null
                ) &&
                simpleRecord.AdDensityRequirementMinHr__c !== null &&
                (
                    simpleRecord.AdDensityRequirementMinHr__c !== "Custom" ||
                    simpleRecord.CustomAdDensityRequirement__c !== null
                ) &&
                simpleRecord.SponsorshipAmount__c !== null &&
                simpleRecord.ProRatedSponsorship__c !== null &&
                simpleRecord.MinimumGuaranteeAmount__c !== null &&
                simpleRecord.ProRatedMinimumGuarantee__c !== null &&
                simpleRecord.LicenseFeeAmount__c !== null &&
                simpleRecord.ProRatedLicenseFee__c !== null &&
                simpleRecord.ContentApprovalDate__c === null);
    },

    validForApprovalHelper_Amendment: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        return (simpleRecord !== null &&
                simpleRecord.Id !== null &&
                simpleRecord.ContractType__c == "Amendment" &&
                simpleRecord.TotalEstimatedCost__c !== null &&
                (
                    (
                        simpleRecord.TotalEstimatedCost__c < simpleRecord.Apttus__Related_Opportunity__r.Owner.DealMemoMinimumRequirement__c ||
                        simpleRecord.DealMemoURL__c !== null
                    ) &&
                    (
                        simpleRecord.TotalEstimatedCost__c < simpleRecord.Apttus__Related_Opportunity__r.Owner.DealModelMinimumRequirement__c ||
                        simpleRecord.DealModelUploaded__c == "Yes"
                    )
                ) &&
                simpleRecord.CumulativeOperatingIncome__c !== null &&
                simpleRecord.ContentApprovalDate__c === null);
    },

    setInApprovalProcess: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        component.set("v.inApprovalProcess", (simpleRecord !== null &&
                                              simpleRecord.Id !== null &&
                                              simpleRecord.ContentApprovalSubmitted__c &&
                                              simpleRecord.ContentApprovalDate__c === null &&
                                              simpleRecord.ContractType__c !== "EULA" ));
    },

    setEligibleForContract: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        component.set("v.eligibleForContract", (simpleRecord !== null &&
                                                simpleRecord.Id !== null &&
                                                simpleRecord.ContentApprovalDate__c !== null &&
                                                simpleRecord.RequestSubmissionDate__c === null &&
                                                simpleRecord.ContractType__c !== "EULA" ));
    },

    setValidForContract: function(component) {
        component.set("v.validForContract", this.validForContractHelper_EULA(component) ||
                                            this.validForContractHelper_CLA(component) ||
                                            this.validForContractHelper_Amendment(component) );
    },

    validForContractHelper_EULA: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        return (simpleRecord !== null &&
                simpleRecord.Id !== null &&
                simpleRecord.ContractType__c == "EULA" &&
                false); // EULA should not enter Contract
    },

    validForContractHelper_CLA: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        return (simpleRecord !== null &&
                simpleRecord.Id !== null &&
                (simpleRecord.Apttus__Related_Opportunity__c != null &&
                simpleRecord.Apttus__Related_Opportunity__r.NumberChannels__c > 0) &&
                (
                    simpleRecord.ContractType__c == "CLA" ||
                    simpleRecord.ContractType__c == "CLBNA"
                ) &&
                simpleRecord.LegalEntityType__c !== null &&
                (
                    simpleRecord.LegalEntityType__c == "Individual" ||
                    simpleRecord.CompanyName__c !== null
                ) &&
                simpleRecord.SignatoryName__c !== null &&
                simpleRecord.SignatoryEmail__c !== null &&
                simpleRecord.MailingStreet__c !== null &&
                simpleRecord.MailingCity__c !== null &&
                simpleRecord.MailingState__c !== null &&
                simpleRecord.MailingPostalCode__c !== null &&
                simpleRecord.MailingCountry__c !== null &&
                simpleRecord.EffectiveDate__c !== null &&
                simpleRecord.CustomTermLength__c !== null &&
                simpleRecord.Apttus__Auto_Renewal__c !== null &&
                (
                    simpleRecord.NetOfInvoice__c !== "Custom" ||
                    simpleRecord.CustomNetOfInvoice__c !== null
                ) && simpleRecord.ContentApprovalDate__c !== null);
    },

    validForContractHelper_Amendment: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        return (simpleRecord !== null &&
                simpleRecord.Id !== null &&
                simpleRecord.ContractType__c == "Amendment" &&
                simpleRecord.LegalEntityType__c !== null &&
                (
                    simpleRecord.LegalEntityType__c == "Individual" ||
                    simpleRecord.CompanyName__c !== null
                ) &&
                simpleRecord.SignatoryName__c !== null &&
                simpleRecord.SignatoryEmail__c !== null &&
                simpleRecord.EffectiveDate__c !== null &&
                simpleRecord.OtherCustomTermsRequirements__c !== null &&
                simpleRecord.ContentApprovalDate__c !== null);
    },

    setInContractProcess: function(component) {
        var simpleRecord = component.get("v.simpleRecord");
        component.set("v.inContractProcess", (simpleRecord !== null &&
                                              simpleRecord.Id !== null &&
                                              simpleRecord.RequestSubmissionDate__c !== null &&
                                              simpleRecord.ContractType__c !== "EULA" ));
    }
})