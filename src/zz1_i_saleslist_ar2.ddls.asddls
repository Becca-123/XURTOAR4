//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: '銷售交易明細表-AR groupby'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.resultSet.sizeCategory: #XS
//@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
//@Metadata.allowExtensions: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@EndUserText.label: '銷售交易明細表-AR groupby'
define root view entity ZZ1_I_SALESLIST_AR2 as select from ZZ1_I_SALESLIST_AR
{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillingDocumentStdVH' , element: 'BillingDocument' }
                                          } ]
      @Consumption.semanticObject: 'BillingDocument'
      @UI.lineItem: [ { type: #FOR_INTENT_BASED_NAVIGATION, semanticObjectAction: 'displayBillingDocument'} ]
      key BillingDocument,
      key BillingDocumentItem,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnSalesOrganizationVH', element: 'SalesOrganization' } } ]
      @ObjectModel.text.element: ['SalesOrganizationName']
      SalesOrganization,
      SalesOrganizationName,
      BillingDocumentDate,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnDistributionChannelVH', element: 'DistributionChannel' } } ]
      @ObjectModel.text.element: ['DistributionChannelName']
      DistributionChannel,
      DistributionChannelName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnDivisionVH', element: 'Division' } } ]
      @ObjectModel.text.element: ['DivisionName']
      Division,
      DivisionName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillingDocumentTypeStdVH', element: 'BillingDocumentType' }  } ]
      @ObjectModel.text.element: ['BillingDocumentTypeName']
      BillingDocumentType,
      BillingDocumentTypeName,
      BillingPlanRule,
      BillingDocumentIsCancelled, //是否迴轉
      BillingDocumentXblnr,
      BillingDocumentXblnrnew,
      invoicedate,
      BusinessPlace, //營業處
      TransactionCurrency, //幣別
      AccountingExchangeRate, //匯率
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CUSTOMER_VH', element: 'Customer' } } ]
      @ObjectModel.text.element: [ 'PayerParty' ]
      PayerParty,
      CustomerName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PersonWorkAgreement_1', element: 'PersonWorkAgreement' } } ]
      PersonWorkAgreement,
      CustomerName_ZM,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductSTDVH', element: 'Product' } } ]
      Product,
      @Semantics.text: true
      ProductName,
      zzqty,
      BillingQuantityUnit,
      BaseUnitName,
      unit_price,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      NetAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TaxAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TotalAmount,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CNSLDTNPRODUCTGROUPVH', element: 'ProductGroup' } } ]
      ProductGroup,
      ProductGroupText,
      SalesDocument,
      SalesDocumentItem,
      originalSalesDocument,
      originalSalesDocumentitem,
      CustomerGroup,
      CustomerGroupName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesDocumentTypeText', element: 'SalesDocumentType' },
      additionalBinding: [{ localConstant: 'ZF' ,element: 'Language', usage: #FILTER } ] } ]
      SalesDocumentType,
      SalesDocumentTypeName,
      Delivery,
      DeliveryItem,
      AdditionalCustomerGroup1,
      AdditionalCustomerGroup1Name,
      AdditionalCustomerGroup2,
      AdditionalCustomerGroup2Name,
      AdditionalCustomerGroup3,
      AdditionalCustomerGroup3Name,
      AdditionalCustomerGroup4,
      AdditionalCustomerGroup4Name,
      AdditionalCustomerGroup5,
      AdditionalCustomerGroup5Name,
      YY1_Vatno_SDH,
      YY1_ECKUNNR_SDH,
      YY1_date_BDH,
      PurchaseOrderByCustomer,
      Customer_ag,
      CustomerName_ag,
      TaxNumber1_ag,
      TaxNumber1_re,
      Customer_WE,
      CustomerName_WE,
      Customer_RE,
      CustomerName_RE,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CUSTOMER_VH', element: 'Customer' } } ]
      @ObjectModel.text.element: [ 'Customer_AA' ]
      Customer_AA,
      CustomerName_AA,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_TaxCodeValueHelp',element: 'TaxCode' },
      additionalBinding: [{ localConstant: '0TXTW' ,element: 'TaxCalculationProcedure', usage: #FILTER } ] } ]
      TaxCode,
      CustomerTaxClassification1,
      CancelledBillingDocument,
      BillingDocumentItemIsCancelled, //項目取消
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_OverallBillingStatus', element: 'OverallBillingStatus' } } ]
      OverallBillingStatus, //狀態
      CompanyCode,
      FiscalYear,
      @Consumption.semanticObject: 'AccountingDocument'
      AccountingDocument,
      CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      AmountInCompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      TaxAmountInCompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      AllAmountInCompanyCodeCurrency,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZZ1_I_COMBINATION2', element: 'value_low' } } ]
      combination
} group by BillingDocument, BillingDocumentItem, SalesOrganization, SalesOrganizationName, BillingDocumentDate, DistributionChannel, DistributionChannelName,
           Division, DivisionName, BillingDocumentType, BillingDocumentTypeName, BillingPlanRule, BillingDocumentIsCancelled, BillingDocumentXblnr, BillingDocumentXblnrnew,
           invoicedate, BusinessPlace, TransactionCurrency, AccountingExchangeRate, PayerParty, CustomerName, PersonWorkAgreement, CustomerName_ZM, Product, ProductName,
           zzqty, BillingQuantityUnit, BaseUnitName, unit_price, NetAmount, TaxAmount, TotalAmount, ProductGroup, ProductGroupText, SalesDocument, SalesDocumentItem,
           originalSalesDocument, originalSalesDocumentitem, CustomerGroup, CustomerGroupName, SalesDocumentType, SalesDocumentTypeName, Delivery, DeliveryItem,
           AdditionalCustomerGroup1, AdditionalCustomerGroup1Name, AdditionalCustomerGroup2, AdditionalCustomerGroup2Name, AdditionalCustomerGroup3, AdditionalCustomerGroup3Name,
           AdditionalCustomerGroup4, AdditionalCustomerGroup4Name, AdditionalCustomerGroup5, AdditionalCustomerGroup5Name, YY1_Vatno_SDH, YY1_ECKUNNR_SDH, YY1_date_BDH,
           PurchaseOrderByCustomer, Customer_ag, CustomerName_ag, TaxNumber1_ag, TaxNumber1_re, Customer_WE, CustomerName_WE, Customer_RE, CustomerName_RE, Customer_AA,
           CustomerName_AA, TaxCode, CustomerTaxClassification1, CancelledBillingDocument, BillingDocumentItemIsCancelled, OverallBillingStatus, CompanyCode, FiscalYear,
           AccountingDocument, CompanyCodeCurrency, AmountInCompanyCodeCurrency, TaxAmountInCompanyCodeCurrency, AllAmountInCompanyCodeCurrency, combination
