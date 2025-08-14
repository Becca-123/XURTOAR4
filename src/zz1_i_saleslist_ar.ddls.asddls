//@AbapCatalog.sqlViewName: 'ZZ1_SALESLIST'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck:#CHECK
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@EndUserText.label: '銷售交易明細表-AR'
define root view entity ZZ1_I_SALESLIST_AR
  as select from    I_BillingDocumentBasic        as I_BillingDocument
    left outer join I_BillingDocumentItemBasic    as i_BillingDocumentItem    on I_BillingDocument.BillingDocument = i_BillingDocumentItem.BillingDocument
    left outer join I_BillingDocumentPartnerBasic                             on  I_BillingDocument.BillingDocument             = I_BillingDocumentPartnerBasic.BillingDocument
                                                                              and I_BillingDocumentPartnerBasic.PartnerFunction = 'ZM'
  // left outer join I_KR_BusinessPlace on I_BillingDocument.CompanyCode = I_KR_BusinessPlace.CompanyCode
    left outer join I_OutboundDeliveryItem                                    on  i_BillingDocumentItem.ReferenceSDDocument     = I_OutboundDeliveryItem.OutboundDelivery
                                                                              and i_BillingDocumentItem.ReferenceSDDocumentItem = I_OutboundDeliveryItem.OutboundDeliveryItem
    left outer join ZZ1_I_XBLNR                  as zz1_i_xblnr             on  i_BillingDocumentItem.BillingDocument     = ZZ1_I_XBLNR.BillingDocument
                                                                              and i_BillingDocumentItem.BillingDocumentItem = ZZ1_I_XBLNR.BillingDocumentItem
    left outer join I_BusinessPartner                                         on I_BillingDocumentPartnerBasic.ReferenceBusinessPartner = I_BusinessPartner.BusinessPartner
  //left outer join I_JournalEntryItem on I_JournalEntryItem.ReferenceDocumentType = 'VBRK' and I_JournalEntryItem.ReferenceDocument = I_BillingDocument.BillingDocument
  //and I_JournalEntryItem.ReferenceDocumentItem = i_BillingDocumentItem.BillingDocumentItem and I_JournalEntryItem.Ledger = '0L'
    left outer join I_BillingDocumentItemBasic    as i_BillingDocumentItem2   on  I_BillingDocument.BillingDocument          = i_BillingDocumentItem2.BillingDocument
                                                                              and i_BillingDocumentItem2.BillingDocumentItem = '000010'
    left outer join I_BillingDocument             as I_BillingDocument2       on I_BillingDocument.BillingDocument = I_BillingDocument2.BillingDocument
    left outer join I_BillingDocumentPartnerBasic as i_billingkunnr           on  I_BillingDocument.BillingDocument = i_billingkunnr.BillingDocument
                                                                              and i_billingkunnr.PartnerFunction    = 'AG'
    left outer join I_Customer                    as address_ag               on address_ag.AddressID = i_billingkunnr.AddressID
    left outer join I_BillingDocumentPartnerBasic as i_billingkunre           on  I_BillingDocument.BillingDocument = i_billingkunre.BillingDocument
                                                                              and i_billingkunre.PartnerFunction    = 'RE'
    left outer join I_Customer                    as address_re               on address_re.AddressID = i_billingkunre.AddressID
    left outer join ZZ1_I_JOURNALENTRY2           as ZZ1_I_JOURNALENTRY2      on  ZZ1_I_JOURNALENTRY2.CompanyCode               = I_BillingDocument.CompanyCode
                                                                              and ZZ1_I_JOURNALENTRY2.FiscalYear                = I_BillingDocument.FiscalYear
                                                                              and ZZ1_I_JOURNALENTRY2.AccountingDocument                = I_BillingDocument.AccountingDocument
                                                                              and ZZ1_I_JOURNALENTRY2.ReferenceDocumentType     = 'VBRK'
                                                                              and ZZ1_I_JOURNALENTRY2.OriginalReferenceDocument = I_BillingDocument.BillingDocument
  //1.貸項通知單來源訂單類型若不為GA2 則直接為標準退貨; 貸項通知單來源訂單類型為GA2 則為貸項通知請求退貨單
    left outer join I_SalesDocumentItem           as i_salesdocumentitem_1    on  i_BillingDocumentItem.SalesDocument     = i_salesdocumentitem_1.SalesDocument
                                                                              and i_BillingDocumentItem.SalesDocumentItem = i_salesdocumentitem_1.SalesDocumentItem

  //1.1標準退貨來源為標準訂單
    left outer join I_SalesDocumentItem           as i_salesdocumentitem_2a   on  i_salesdocumentitem_1.ReferenceSDDocument     = i_salesdocumentitem_2a.SalesDocument
                                                                              and i_salesdocumentitem_1.ReferenceSDDocumentItem = i_salesdocumentitem_2a.SalesDocumentItem
  //1.2標準退貨來源為請款文件
    left outer join I_BillingDocumentItemBasic    as i_BillingDocumentItem_2a on  i_salesdocumentitem_1.ReferenceSDDocument     = i_BillingDocumentItem_2a.BillingDocument
                                                                              and i_salesdocumentitem_1.ReferenceSDDocumentItem = i_BillingDocumentItem_2a.BillingDocumentItem


  //2.1 貸項通知請求退貨單來源為標準退貨
    left outer join I_SalesDocumentItem           as i_salesdocumentitem_2b   on  i_salesdocumentitem_1.ReferenceSDDocument     = i_salesdocumentitem_2b.SalesDocument
                                                                              and i_salesdocumentitem_1.ReferenceSDDocumentItem = i_salesdocumentitem_2b.SalesDocumentItem
  //2.2標準退貨來源為標準訂單
    left outer join I_SalesDocumentItem           as i_salesdocumentitem_3b   on  i_salesdocumentitem_2b.ReferenceSDDocument     = i_salesdocumentitem_3b.SalesDocument
                                                                              and i_salesdocumentitem_2b.ReferenceSDDocumentItem = i_salesdocumentitem_3b.SalesDocumentItem
  //2.3標準退貨來源為請款文件
    left outer join I_BillingDocumentItemBasic    as i_BillingDocumentItem_3b on  i_salesdocumentitem_2b.ReferenceSDDocument     = i_BillingDocumentItem_3b.BillingDocument
                                                                              and i_salesdocumentitem_2b.ReferenceSDDocumentItem = i_BillingDocumentItem_3b.BillingDocumentItem                                                     
{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillingDocumentStdVH' , element: 'BillingDocument' }
                                          } ]
      @Consumption.semanticObject: 'BillingDocument'
      @UI.lineItem: [ { type: #FOR_INTENT_BASED_NAVIGATION, semanticObjectAction: 'displayBillingDocument'} ]
      key I_BillingDocument.BillingDocument,
      key i_BillingDocumentItem.BillingDocumentItem,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnSalesOrganizationVH', element: 'SalesOrganization' } } ]
      @ObjectModel.text.element: ['SalesOrganizationName']
      I_BillingDocument.SalesOrganization,
      I_BillingDocument._SalesOrganization._Text[Language = $session.system_language].SalesOrganizationName,
      I_BillingDocument.BillingDocumentDate,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnDistributionChannelVH', element: 'DistributionChannel' } } ]
      @ObjectModel.text.element: ['DistributionChannelName']
      I_BillingDocument.DistributionChannel,
      I_BillingDocument._DistributionChannel._Text[Language = $session.system_language].DistributionChannelName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnDivisionVH', element: 'Division' } } ]
      @ObjectModel.text.element: ['DivisionName']
      I_BillingDocument.Division,
      I_BillingDocument._Division._Text[Language = $session.system_language].DivisionName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillingDocumentTypeStdVH', element: 'BillingDocumentType' }  } ]
      @ObjectModel.text.element: ['BillingDocumentTypeName']
      //@UI.textArrangement: #TEXT_ONLY
      I_BillingDocument.BillingDocumentType,
      I_BillingDocument._BillingDocumentType._Text[Language = $session.system_language].BillingDocumentTypeName,
      i_BillingDocumentItem.BillingPlanRule,
      I_BillingDocument.BillingDocumentIsCancelled, //是否迴轉

      case
       when ZZ1_I_XBLNR.xblnr01 between 'A' and 'Z' and ZZ1_I_XBLNR.xblnr02 between 'A' and 'Z' then I_BillingDocument.DocumentReferenceID
       when ZZ1_I_XBLNR.yy1_xblnr01 between 'A' and 'Z' and ZZ1_I_XBLNR.yy1_xblnr02 between 'A' and 'Z' then I_BillingDocument.YY1_XBLNR_BDH
        else I_BillingDocument.DocumentReferenceID
      end                                                                                                        as BillingDocumentXblnr,

      case
       when substring( ZZ1_I_JOURNALENTRY2.AssignmentReference , 1 , 1 ) between 'A' and 'Z'
        and substring( ZZ1_I_JOURNALENTRY2.AssignmentReference , 2 , 1 ) between 'A' and 'Z'
        then left( ZZ1_I_JOURNALENTRY2.AssignmentReference,10 )
       when substring( ZZ1_I_JOURNALENTRY2.DocumentReferenceID , 1 , 1 ) between 'A' and 'Z'
        and substring( ZZ1_I_JOURNALENTRY2.DocumentReferenceID , 2 , 1 ) between 'A' and 'Z'
        then ZZ1_I_JOURNALENTRY2.DocumentReferenceID
       else ''         
      end                                                                                                        as BillingDocumentXblnrnew,

      cast (
      case
        when substring( ZZ1_I_JOURNALENTRY2.AssignmentReference , 1 , 1 ) between 'A' and 'Z'
          and substring( ZZ1_I_JOURNALENTRY2.AssignmentReference , 2 , 1 ) between 'A' and 'Z'
          and ZZ1_I_JOURNALENTRY2.Reference3IDByBusinessPartner is not null
          and ZZ1_I_JOURNALENTRY2.Reference3IDByBusinessPartner <> ''
          then ZZ1_I_JOURNALENTRY2.Reference3IDByBusinessPartner
        else
          case
            when substring( ZZ1_I_JOURNALENTRY2.DocumentReferenceID , 1 , 1 ) between 'A' and 'Z'
             and substring( ZZ1_I_JOURNALENTRY2.DocumentReferenceID , 2 , 1 ) between 'A' and 'Z'
             then ZZ1_I_JOURNALENTRY2.PostingDate
            else '00000000'
          end
      end as abap.dats )                                                                                         as invoicedate,



      i_BillingDocumentItem.SalesOffice                                                                          as BusinessPlace, //營業處
      I_BillingDocument.TransactionCurrency, //幣別
      I_BillingDocument.AccountingExchangeRate, //匯率
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CUSTOMER_VH', element: 'Customer' } } ]
      @ObjectModel.text.element: [ 'PayerParty' ]
      I_BillingDocument.PayerParty,
      I_BillingDocument._PayerParty.CustomerName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PersonWorkAgreement_1', element: 'PersonWorkAgreement' } } ]
      I_BillingDocument._PartnerBasic[ PartnerFunction = 'ZM' ].Personnel                                        as PersonWorkAgreement,
      I_BusinessPartner.BusinessPartnerFullName                                                                  as CustomerName_ZM,
      //@ObjectModel.text.element: ['ProductName']
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductSTDVH', element: 'Product' } } ]
      i_BillingDocumentItem._ProductText[Language = 'M'].Product,
      @Semantics.text: true
      i_BillingDocumentItem._Product._Text[Language = $session.system_language].ProductName,
      case
      when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
      //@Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      then  cast( (i_BillingDocumentItem.BillingQuantity * -1 )  as abap.dec(13,3))
      else cast( i_BillingDocumentItem.BillingQuantity  as abap.dec(13,3))
      end                                                                                                        as zzqty,

      //@ObjectModel.text.element: ['BaseUnitName']
      i_BillingDocumentItem.BillingQuantityUnit,
      i_BillingDocumentItem._BaseUnit._Text[Language = $session.system_language].UnitOfMeasureName               as BaseUnitName,
      case
       when I_BillingDocument.TransactionCurrency = 'TWD'
          then ZZ1_I_XBLNR.unit_price * 100
       else ZZ1_I_XBLNR.unit_price
      end                                                                                                        as unit_price,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case
      when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
       then  i_BillingDocumentItem.NetAmount * -1
       else  i_BillingDocumentItem.NetAmount
      end                                                                                                        as NetAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case
      when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
       then  i_BillingDocumentItem.TaxAmount * -1
       else  i_BillingDocumentItem.TaxAmount
      end                                                                                                        as TaxAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case
      when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
       then  (i_BillingDocumentItem.NetAmount + i_BillingDocumentItem.TaxAmount ) * -1
       else  (i_BillingDocumentItem.NetAmount + i_BillingDocumentItem.TaxAmount )
      end                                                                                                        as TotalAmount,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CNSLDTNPRODUCTGROUPVH', element: 'ProductGroup' } } ]
      i_BillingDocumentItem.ProductGroup,
      i_BillingDocumentItem._ProductGroup._ProductGroupText[Language = $session.system_language].ProductGroupText,
      i_BillingDocumentItem.SalesDocument,
      i_BillingDocumentItem.SalesDocumentItem,

      case
        when I_BillingDocument.BillingDocumentType = 'G2' or I_BillingDocument.BillingDocumentType = 'GBRE'
          then
            case
              when i_salesdocumentitem_1._SalesDocument.SalesDocumentType = 'GA2'
                then
                    case
                      when i_salesdocumentitem_3b.SalesDocument <> '' and i_salesdocumentitem_3b.SalesDocument is not null
                        then i_salesdocumentitem_3b.SalesDocument
                      when i_BillingDocumentItem_3b.BillingDocument <> '' and i_BillingDocumentItem_3b.BillingDocument is not null
                        then i_BillingDocumentItem_3b.SalesDocument
                      when i_salesdocumentitem_2b.SalesDocument <> '' and i_salesdocumentitem_2b.SalesDocument is not null
                        then i_salesdocumentitem_2b.SalesDocument
                      else
                        i_BillingDocumentItem.SalesDocument
                    end
                else
                    case
                      when i_salesdocumentitem_2a.SalesDocument <> '' and i_salesdocumentitem_2a.SalesDocument is not null
                        then i_salesdocumentitem_2a.SalesDocument
                      when i_BillingDocumentItem_2a.BillingDocument <> '' and i_BillingDocumentItem_2a.BillingDocument is not null
                        then i_BillingDocumentItem_2a.SalesDocument
                      else
                        i_BillingDocumentItem.SalesDocument
                    end
            end
          else i_BillingDocumentItem.SalesDocument
      end                                                                                                        as originalSalesDocument,

      case
        when I_BillingDocument.BillingDocumentType = 'G2' or I_BillingDocument.BillingDocumentType = 'GBRE'
          then
            case
              when i_salesdocumentitem_1._SalesDocument.SalesDocumentType = 'GA2'
                then
                    case
                      when i_salesdocumentitem_3b.SalesDocument <> '' and i_salesdocumentitem_3b.SalesDocument is not null
                        then i_salesdocumentitem_3b.SalesDocumentItem
                      when i_BillingDocumentItem_3b.BillingDocument <> '' and i_BillingDocumentItem_3b.BillingDocument is not null
                        then i_BillingDocumentItem_3b.SalesDocumentItem
                      when i_salesdocumentitem_2b.SalesDocument <> '' and i_salesdocumentitem_2b.SalesDocument is not null
                        then i_salesdocumentitem_2b.SalesDocumentItem
                      else
                        i_BillingDocumentItem.SalesDocumentItem
                    end
                else
                    case
                      when i_salesdocumentitem_2a.SalesDocument <> '' and i_salesdocumentitem_2a.SalesDocument is not null
                        then i_salesdocumentitem_2a.SalesDocumentItem
                      when i_BillingDocumentItem_2a.BillingDocument <> '' and i_BillingDocumentItem_2a.BillingDocument is not null
                        then i_BillingDocumentItem_2a.SalesDocumentItem
                      else
                        i_BillingDocumentItem.SalesDocumentItem
                    end
            end
        else i_BillingDocumentItem.SalesDocumentItem
      end                                                                                                        as originalSalesDocumentitem,

      i_BillingDocumentItem._SalesDocument.CustomerGroup,
      i_BillingDocumentItem._SalesDocument._CustomerGroup._Text[Language = $session.system_language].CustomerGroupName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesDocumentTypeText', element: 'SalesDocumentType' },
      additionalBinding: [{ localConstant: 'ZF' ,element: 'Language', usage: #FILTER } ] } ]
      i_BillingDocumentItem._SalesDocument.SalesDocumentType,
      i_BillingDocumentItem._SalesDocument._SalesDocumentType._Text[Language = $session.system_language].SalesDocumentTypeName,
      case
       when i_BillingDocumentItem.ReferenceSDDocumentCategory = 'T' or i_BillingDocumentItem.ReferenceSDDocumentCategory = 'J'
       then i_BillingDocumentItem.ReferenceSDDocument  end                                                       as Delivery,
      case
      when i_BillingDocumentItem.ReferenceSDDocumentCategory = 'T' or i_BillingDocumentItem.ReferenceSDDocumentCategory = 'J'
      then i_BillingDocumentItem.ReferenceSDDocumentItem end                                                     as DeliveryItem,

      i_BillingDocumentItem._SalesDocument.AdditionalCustomerGroup1,
      i_BillingDocumentItem._SalesDocument._AdditionalCustomerGroup1._Text[Language = $session.system_language].AdditionalCustomerGroup1Name,
      i_BillingDocumentItem._SalesDocument.AdditionalCustomerGroup2,
      i_BillingDocumentItem._SalesDocument._AdditionalCustomerGroup2._Text[Language = $session.system_language].AdditionalCustomerGroup2Name,
      i_BillingDocumentItem._SalesDocument.AdditionalCustomerGroup3,
      i_BillingDocumentItem._SalesDocument._AdditionalCustomerGroup3._Text[Language = $session.system_language].AdditionalCustomerGroup3Name,
      i_BillingDocumentItem._SalesDocument.AdditionalCustomerGroup4,
      i_BillingDocumentItem._SalesDocument._AdditionalCustomerGroup4._Text[Language = $session.system_language].AdditionalCustomerGroup4Name,
      i_BillingDocumentItem._SalesDocument.AdditionalCustomerGroup5,
      i_BillingDocumentItem._SalesDocument._AdditionalCustomerGroup5._Text[Language = $session.system_language].AdditionalCustomerGroup5Name,
      i_BillingDocumentItem._SalesDocument.YY1_Vatno_SDH,
      i_BillingDocumentItem._SalesDocument.YY1_ECKUNNR_SDH,
      I_BillingDocument.YY1_date_BDH,
      i_BillingDocumentItem._SalesDocument.PurchaseOrderByCustomer,
      I_BillingDocument._PartnerBasic[ PartnerFunction = 'AG' ].ReferenceBusinessPartner                         as Customer_ag,
      concat( I_BillingDocument._PartnerBasic[ PartnerFunction = 'AG']._DfltAddrRprstn.OrganizationName1,
                I_BillingDocument._PartnerBasic[ PartnerFunction = 'AG']._DfltAddrRprstn.OrganizationName2 )     as CustomerName_ag,
      address_ag.TaxNumber1                                                                                      as TaxNumber1_ag,
      address_re.TaxNumber1                                                                                      as TaxNumber1_re,
      i_BillingDocumentItem._PartnerBasic[ PartnerFunction = 'WE' ].ReferenceBusinessPartner                     as Customer_WE,
      concat( i_BillingDocumentItem._PartnerBasic[ PartnerFunction = 'WE']._DfltAddrRprstn.OrganizationName1,
                i_BillingDocumentItem._PartnerBasic[ PartnerFunction = 'WE']._DfltAddrRprstn.OrganizationName2 ) as CustomerName_WE,
      I_BillingDocument._PartnerBasic[ PartnerFunction = 'RE' ].ReferenceBusinessPartner                         as Customer_RE,
      concat( I_BillingDocument._PartnerBasic[ PartnerFunction = 'RE']._DfltAddrRprstn.OrganizationName1,
                I_BillingDocument._PartnerBasic[ PartnerFunction = 'RE']._DfltAddrRprstn.OrganizationName2 )     as CustomerName_RE,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CUSTOMER_VH', element: 'Customer' } } ]
      @ObjectModel.text.element: [ 'Customer_AA' ]
      I_BillingDocument._PartnerBasic[ PartnerFunction = 'AA' ].ReferenceBusinessPartner                         as Customer_AA,
      concat( I_BillingDocument._PartnerBasic[ PartnerFunction = 'AA']._DfltAddrRprstn.OrganizationName1,
                I_BillingDocument._PartnerBasic[ PartnerFunction = 'AA']._DfltAddrRprstn.OrganizationName2 )     as CustomerName_AA,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_TaxCodeValueHelp',element: 'TaxCode' },
      additionalBinding: [{ localConstant: '0TXTW' ,element: 'TaxCalculationProcedure', usage: #FILTER } ] } ]
      case
       when i_BillingDocumentItem.TaxCode <> '' then i_BillingDocumentItem.TaxCode
        else i_BillingDocumentItem2.TaxCode
      end                                                                                                        as TaxCode,
      I_BillingDocument.CustomerTaxClassification1,
      I_BillingDocument.CancelledBillingDocument,
      I_BillingDocument.BillingDocumentIsCancelled                                                               as BillingDocumentItemIsCancelled, //項目取消
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_OverallBillingStatus', element: 'OverallBillingStatus' } } ]
      I_BillingDocument.OverallBillingStatus, //狀態
      I_BillingDocument.CompanyCode,
      I_BillingDocument.FiscalYear,
      @Consumption.semanticObject: 'AccountingDocument'
      I_BillingDocument.AccountingDocument,
      case
        when ZZ1_I_XBLNR.CompanyCodeCurrency != ''
         then ZZ1_I_XBLNR.CompanyCodeCurrency
        else I_BillingDocument.TransactionCurrency
      end as  CompanyCodeCurrency,
        
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case 
       when ZZ1_I_XBLNR.AmountInCompanyCodeCurrency != 0 or ZZ1_I_XBLNR.CompanyCodeCurrency != I_BillingDocument.TransactionCurrency
        then ZZ1_I_XBLNR.AmountInCompanyCodeCurrency
        else
         case
          when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
           then  i_BillingDocumentItem.NetAmount * -1
           else  i_BillingDocumentItem.NetAmount
           end   
        end as AmountInCompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
         cast ( ZZ1_I_XBLNR.TaxAmountInCompanyCodeCurrency as abap.curr( 13, 2 ) )  as TaxAmountInCompanyCodeCurrency,
      
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case 
       when ZZ1_I_XBLNR.AllAmountInCompanyCodeCurrency != 0 or ZZ1_I_XBLNR.CompanyCodeCurrency != I_BillingDocument.TransactionCurrency
        then cast (ZZ1_I_XBLNR.AllAmountInCompanyCodeCurrency as abap.curr( 13, 2 ) )
       else 
        case
         when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
          then  (i_BillingDocumentItem.NetAmount + i_BillingDocumentItem.TaxAmount ) * -1
         else  (i_BillingDocumentItem.NetAmount + i_BillingDocumentItem.TaxAmount )
         end
        end as AllAmountInCompanyCodeCurrency,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZZ1_I_COMBINATION2', element: 'value_low' } } ]
      case 
       when i_BillingDocumentItem.SalesDocumentItemCategory = 'CBLI'
         or i_BillingDocumentItem.SalesDocumentItemCategory = 'CF3I'
         or i_BillingDocumentItem.SalesDocumentItemCategory = 'CI3L'
         or i_BillingDocumentItem.SalesDocumentItemCategory = 'RENI'
       then cast ('Y' as zz1_combination) 
       when i_BillingDocumentItem.SalesDocumentItemCategory = 'CPHD'
         or i_BillingDocumentItem.SalesDocumentItemCategory = 'CFHD'
         or i_BillingDocumentItem.SalesDocumentItemCategory = 'CNHD'
         or i_BillingDocumentItem.SalesDocumentItemCategory = 'CMHD'
       then cast('' as zz1_combination) 
       else cast ('C' as zz1_combination) 
      end as combination
}
where
          substring(i_BillingDocumentItem.ReferenceSDDocumentItem,1,1) != '9'
  and     i_BillingDocumentItem.BillingQuantity                        <> 0
  and     I_BillingDocument.BillingDocumentIsTemporary                 =  ''
  and     not(
        (
          I_BillingDocument.BillingDocumentType                        <> 'FAZ'
          and I_BillingDocument.BillingDocumentType                    <> 'FAS'
        )
        and(
              i_BillingDocumentItem.BillingPlanRule                    =  '5'
        )
      )
