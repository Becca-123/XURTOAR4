//************************************************************************
//Copyright     : Innatech Co., Ltd.
//Author        : Becca
//Create Date   : 2024/09/25
//************************************************************************
//@Analytics.dataCategory: #CUBE
//@Analytics.internalName: #LOCAL
//@ObjectModel.modelingPattern: #ANALYTICAL_DIMENSION
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@EndUserText.label: '銷售訂單資料明細表'
define root view entity ZZ1_I_ZSD02LIST  
    as select from I_SalesDocumentItem as vbap
        inner join I_SalesDocument     as vbak on vbap.SalesDocument = vbak.SalesDocument
        
        left outer join I_SalesDocItemPricingElement as prcd_elements on vbak.SalesDocument = prcd_elements.SalesDocument and vbap.SalesDocumentItem = prcd_elements.SalesDocumentItem
                       and prcd_elements.TaxCode <> '' and prcd_elements.ConditionInactiveReason = ''
        
        left outer join I_SalesDocumentItemPartner as vbpa on vbap.SalesDocument = vbpa.SalesDocument and vbap.SalesDocumentItem = vbpa.SalesDocumentItem and vbpa.PartnerFunction = 'AE'
        left outer join I_AddrOrgNamePostalAddress as adrc on vbpa.AddressID = adrc.AddressID
        left outer join I_SalesDocumentItemPartner as vbpa_ae on  vbap.SalesDocument = vbpa_ae.SalesDocument and vbpa_ae.SalesDocumentItem = '000000' and vbpa_ae.PartnerFunction = 'AE'
        left outer join I_AddrOrgNamePostalAddress as adrc_ae on vbpa_ae.AddressID = adrc_ae.AddressID
        left outer join I_SrvcMgmtProductHierarchyText  as t179t on vbap.ProductHierarchyNode = t179t.SrvcProductHierarchy and t179t.Language = $session.system_language
        
        //inner join I_RFM_SalesDocument as kdkg on vbap.SalesDocument = kdkg.SalesDocument
        //inner join   acdoca as acdoca on acdoca.rbukrs = vbak.BillingCompanyCode
        association [0..1] to ZZ1_TF_VBEP          as _sche              on  $projection.SalesDocument     = _sche.SalesDocument
                                                                         and $projection.SalesDocumentItem = _sche.SalesDocumentItem
        //VKP0 銷售價格
        association [0..1] to ZZ1_TF_KONV          as _cond_vkp0         on  $projection.SalesDocument     = _cond_vkp0.SalesDocument
                                                                         and $projection.SalesDocumentItem = _cond_vkp0.SalesDocumentItem
                                                                         and _cond_vkp0.CONDITIONTYPE      = 'VKP0'
        //PN10 銷售價格
        association [0..1] to ZZ1_TF_KONV          as _cond_pn10         on  $projection.SalesDocument     = _cond_pn10.SalesDocument
                                                                         and $projection.SalesDocumentItem = _cond_pn10.SalesDocumentItem
                                                                         and _cond_pn10.CONDITIONTYPE      = 'PN10'
        //PROO 價格
        association [0..1] to ZZ1_TF_KONV          as _cond_pr00         on  $projection.SalesDocument     = _cond_pr00.SalesDocument
                                                                         and $projection.SalesDocumentItem = _cond_pr00.SalesDocumentItem
                                                                         and _cond_pr00.CONDITIONTYPE      = 'PR00'
        association [0..1] to I_Product            as _matwa             on  $projection.OriginallyRequestedMaterial = _matwa.Product
        association [0..1] to I_CustomerMaterial_2 as _CUSTOMERMATERIAL  on  vbak.SoldToParty         = _CUSTOMERMATERIAL.Customer
                                                                         and vbak.SalesOrganization   = _CUSTOMERMATERIAL.SalesOrganization
                                                                         and vbak.DistributionChannel = _CUSTOMERMATERIAL.DistributionChannel
                                                                         and vbap.MaterialByCustomer   = _CUSTOMERMATERIAL.MaterialByCustomer
        association [0..1] to I_CustomerSalesArea  as _CustomerSalesArea on  vbak.SoldToParty          = _CustomerSalesArea.Customer
                                                                         and vbak.SalesOrganization    = _CustomerSalesArea.SalesOrganization
                                                                         and vbak.DistributionChannel  = _CustomerSalesArea.DistributionChannel
                                                                         and vbak.OrganizationDivision = _CustomerSalesArea.Division
        association [0..1] to I_CustomerGroup      as _CustomerGroup     on  vbak.CustomerGroup = _CustomerGroup.CustomerGroup


  //association [0..*] to I_ShippingPointText         as _ShippingPointText on  $projection.ShippingPoint = _ShippingPointText.ShippingPoint
  //association [0..1] to I_Plant                     as _Plant             on  $projection.Plant = _Plant.Plant
  //association [0..1] to I_Product                   as _Product           on  $projection.Material = _Product.Product
  //association [0..1] to I_SalesOffice               as _SalesOffice       on  $projection._SalesDocument.SalesOffice = _SalesOffice.SalesOffice
{


      @Consumption.semanticObject: 'SalesOrder'
      @UI.lineItem: [ { type: #FOR_INTENT_BASED_NAVIGATION, semanticObjectAction: 'manage'} ]
  key vbap.SalesDocument,       //vbeln
  key vbap.SalesDocumentItem,   //posnr   head is inital
      //缺少
      //'CWM_KWMENG' 'VBAP' 'KWMENG' 數量(雙單位)
      //'CWM_MEINS'  'VBAP' 'VRKME' 單位(雙單位)
      //'UNIT'   26 5  'CURR'   單價
      
      vbak.BillingCompanyCode,      //bukrs_vf
      vbak.SalesDocumentType,       //auart
      vbak._SalesDocumentType._Text[Language = $session.system_language].SalesDocumentTypeName, //tvakt-bezei//
      left( vbak.SalesDocumentDate, 6 ) as ymon, //ymon
      vbak.SalesDocumentDate,       //audat
      vbak.SoldToParty,             //kunnr
      vbap._SoldToParty.OrganizationBPName1,  //kna1-name1
      
      //head = 'X'
      concat( vbak._Partner[ PartnerFunction = 'AG']._OrganizationAddress.AddresseeName1,
              vbak._Partner[ PartnerFunction = 'AG']._OrganizationAddress.AddresseeName2  ) as name_ag,     //adrc-name1, name2//
      vbak._Partner[ PartnerFunction = 'AG']._OrganizationAddress.Region as region_ag,                      //region_buyer t005-land1
      vbak._Partner[ PartnerFunction = 'AG']._OrganizationAddress._Region._RegionText[Language = $session.system_language].RegionName  as RegionName_ag,    //bezei_buyer t005u.bezei
      vbak._Partner[ PartnerFunction = 'AG']._OrganizationAddress.Country as country_ag,                    //country_buyer adrc-country  
      vbak._Partner[ PartnerFunction = 'AG']._OrganizationAddress._Country._Text[Language = $session.system_language].CountryShortName as CountryName_ag,   //landx_buyer t005t-landx
      vbak._Partner[ PartnerFunction = 'WE'].Customer as kunnr_we,  //kunnr_we kna1-kunnr
      
      concat( vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.AddresseeName1,
          vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.AddresseeName2  ) as name_we,         //we_name adrc-name1, name2
      concat(
        concat(
                concat( vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetName,
                        vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetPrefixName1
                      ),
                vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetPrefixName2
              ),
        vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetSuffixName1
      ) as address_we,      //street_we street, str_suppl1, str_suppl2, str_suppl3
      vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.Region as region_we,  //region_we
      vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress._Region._RegionText[Language = $session.system_language].RegionName  as RegionName_we,    //bezei_we t005u.bezei
      
      //country
      vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress.Country                                                              as country_we,
      //t005t-landx
      vbak._Partner[ PartnerFunction = 'WE']._OrganizationAddress._Country._Text[Language = $session.system_language].CountryShortName as CountryName_we,

      vbap.TransactionCurrency,     //waerk     head is inital
      
      cast( vbak.AccountingExchangeRate as abap.dec(9,5) ) as AccountingExchangeRate, //kurrf
      vbak.PriceDetnExchangeRate,   //kursk

      //head = 'X'
      vbak.PurchaseOrderByCustomer,             //bstkd //bstnk  vbak-bstnk
      vbak.AccountingDocExternalReference,      //xblnr
      @ObjectModel.text.association: '_ProductText'
      @ObjectModel.text.element: ['MaterialName']
      vbap.Product,                                     //matnr             head is inital
      vbap._Product._Text[Language = $session.system_language].ProductName as MaterialName, //maktx     head is inital
      vbap.MaterialByCustomer,                          //kdmat             head is inital
      _CUSTOMERMATERIAL.MaterialDescriptionByCustomer,  //postx             head is inital
      vbap._Product.ProductGroup,                       //mtype t023-matkl  head is inital
      //vbap._ProductGroup._ProductGroupText[Language = $session.system_language].ProductGroupName,   //mdesc t023t-wgbez     head is inital
      vbap._Product._ProductGroupText_2[Language = $session.system_language].ProductGroupText,
      
      vbak.SalesOrganization,       //vkorg
      vbak._SalesOrganization._Text[Language = $session.system_language].SalesOrganizationName,     //vtext_vkorg  tvkot-vtext
      vbak.DistributionChannel,     //vtweg
      vbak._DistributionChannel._Text[Language = $session.system_language].DistributionChannelName, //vtext_vtweg tvtwt-vtext
      vbak.OrganizationDivision,    //spart
      vbak._OrganizationDivision._Text[Language = $session.system_language].DivisionName,           //vtext_spart tspat-vtext
      vbak.SalesOffice,             //vkbur
      vbak._SalesOffice._Text[Language = $session.system_language].SalesOfficeName,                 //bezei_vk tvkbt-bezei
      _CustomerSalesArea.CustomerPriceGroup,          //knvv-konda
      vbak.CustomerGroup,           //kdgrp
      vbak._CustomerGroup._Text[Language = $session.system_language].CustomerGroupName,             //t151t-ktext
      vbak.SalesDistrict,           //bzirk
      vbak._SalesDistrict._Text[Language = $session.system_language].SalesDistrictName,             //t171t-bztxt 
      vbap.OrderQuantityUnit, 
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbap.OrderQuantity,
      //cast ( vbap.OrderQuantity as abap.quan( 15, 3 ) ) as OrderQuantity,           //kwmeng        head is inital
            //vrkme         head is inital
      //'CWM_KWMENG' 'VBAP' 'KWMENG'    head is inital
      //'CWM_MEINS'  'VBAP' 'VRKME'     head is inital
      //'UNIT'   26 5  'CURR'           head is inital
      
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast ( vbap.NetAmount as abap.curr(15,2) ) as NetAmount,               //netwr
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast ( prcd_elements.ConditionAmount as abap.curr(15,2) ) as ConditionAmount,          //prcd_elements-kwert
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(
          case 
            when vbap.AccountingExchangeRate is not initial and vbap.AccountingExchangeRate <> 0
                then ( cast ( vbap.NetAmount as abap.dec(15,2) ) * vbap.AccountingExchangeRate )
            else ( cast ( vbap.NetAmount as abap.dec(15,2) ) * vbap.PriceDetnExchangeRate )
          end as abap.curr(15,2)
      ) as netwr_loc, //netwr_loc vbap-netwr
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(
          case 
              when vbap.AccountingExchangeRate is not initial and vbap.AccountingExchangeRate <> 0 //cast ( vbap.AccountingExchangeRate as abap.dec(9,5) ) <> 0000.00000
                then ( ( cast ( vbap.NetAmount as abap.dec(15,2) ) * vbap.AccountingExchangeRate ) + ( cast ( prcd_elements.ConditionAmount as abap.dec(15,2) ) * vbap.AccountingExchangeRate ) )
              else ( ( cast ( vbap.NetAmount as abap.dec(15,2) ) * vbap.PriceDetnExchangeRate ) + ( cast ( prcd_elements.ConditionAmount as abap.dec(15,2) ) * vbap.PriceDetnExchangeRate ) )
           end as abap.curr(15,2)
        ) as netwr_tax, //netwr_tax vbap-netwr //淨值*匯率 + 條件值*過帳至財務會計的匯率


      prcd_elements.TaxCode,          //prcd_elements-mwsk1
      case 
          when vbpa.Customer <> ''
              then vbpa.Customer
          else vbpa_ae.Customer
      end as sales, //sales VBPA-PERNR
    
      case 
          when vbpa.Customer <> ''
              then concat( adrc.AddresseeName1 , adrc.AddresseeName2)
          else concat( adrc_ae.AddresseeName1 , adrc_ae.AddresseeName2)
      end as cname, //cname
      
      _sche( client : $session.client ).PurchaseRequisition,        //banfn//vbep       head is inital
      _sche( client : $session.client ).PurchaseRequisitionItem,    //bnfpo//vbep       head is inital
      
      vbak.SDDocumentReason,                                        //augru
      vbak._SDDocumentReason._Text[Language = $session.system_language].SDDocumentReasonText,   //bezei_rs tvaut-bezei
      vbak.CreatedByUser,               //ernam
      vbak.CreationDate,                //erdat
      
      vbap.SalesDocumentItemCategory,   //pstyv                 head is inital
      vbap._ItemCategory._Text[Language = $session.system_language].SalesDocumentItemCategoryName, //vtext2 tvapt-vtext     head is inital
      vbap.SalesDocumentRjcnReason,     //abgru                 head is inital
      vbap._SalesDocumentRjcnReason._Text[Language = $session.system_language].SalesDocumentRjcnReasonName,     //bezei_ab tvagt-bezei  head is inital
      vbap.ProductHierarchyNode,        //prodh                 head is inital
      t179t.SrvcProductHierarchyText,   //p_text t179t-vtext    head is inital
      vbap.Plant,                       //werks                 head is inital
      vbap._Plant.PlantName,            //name2 t001w-name1     head is inital
      vbap.ShippingPoint,               //vstel                 head is inital
      case when vbap._ShippingPointText[Language = $session.system_language].ShippingPointName <> ''
        then vbap._ShippingPointText[Language = $session.system_language].ShippingPointName
        else vbap._ShippingPointText[Language = 'E'].ShippingPointName
      end as ShippingPointName,         //vtex1 tvstt-vtext     head is inital
      vbap.ProfitCenter,                //prctr                 head is inital
      
      vbak.CustomerPaymentTerms,        //zterm
      vbak._CustomerPaymentTerms._Text[Language = $session.system_language].CustomerPaymentTermsName,     //ztext tvzbt-vtext
      vbak.IncotermsClassification,     //inco1
      vbak.IncotermsTransferLocation,   //inco2
      vbap.OriginallyRequestedMaterial, //matwa
      _matwa._Text[Language = $session.system_language].ProductName as matwa_maktx, //matwa_maktx  makt.maktx
      
      //head is inital
      vbak.AdditionalCustomerGroup1,    //kvgr1 
      vbak._AdditionalCustomerGroup1._Text[Language = $session.system_language].AdditionalCustomerGroup1Name,   //tkvgr1  tvv1t-bezei
      vbak.AdditionalCustomerGroup2,    //kvgr2
      vbak._AdditionalCustomerGroup2._Text[Language = $session.system_language].AdditionalCustomerGroup2Name,   //tkvgr2 tvv2t-bezei
      vbak.AdditionalCustomerGroup3,    //kvgr3
      vbak._AdditionalCustomerGroup3._Text[Language = $session.system_language].AdditionalCustomerGroup3Name,   //tkvgr3 tvv3t--bezei
      vbak.AdditionalCustomerGroup4,    //kvgr4
      vbak._AdditionalCustomerGroup4._Text[Language = $session.system_language].AdditionalCustomerGroup4Name,   //tkvgr4 tvv4t--bezei
      vbak.AdditionalCustomerGroup5,    //kvgr5
      vbak._AdditionalCustomerGroup5._Text[Language = $session.system_language].AdditionalCustomerGroup5Name,   //tkvgr5 tvv5t--bezei
      
      //zmeng//
      @Semantics.quantity.unitOfMeasure: 'TargetQuantityUnit'
      vbap.TargetQuantity,
      //zieme//
      vbap.TargetQuantityUnit,
      
      

      
      //posex//
      vbap.UnderlyingPurchaseOrderItem,
      //knumv//
      vbak.SalesDocumentCondition,
      //zuonr//
      vbak.ControllingObject,
      //spstg//
      vbak.TotalBlockStatus,
      //mara
      //mtart//
      vbap._Product.ProductType,
      //t134t.mtbez//
      vbap._Product._ProductTypeName[Language = $session.system_language].MaterialTypeName,
      //vbpa
      //kunnr//
      vbak._Partner[ PartnerFunction = 'AE'].Customer as kunnr_ae,
      //adrc-name1, name2//
      concat( vbak._Partner[ PartnerFunction = 'AE']._OrganizationAddress.AddresseeName1,
              vbak._Partner[ PartnerFunction = 'AE']._OrganizationAddress.AddresseeName2  ) as name_ae,
      //abgru
      cast ( case when vbap.SalesDocumentRjcnReason = ''  then ''
        else 'X'
      end as abap.char( 1 ) )                                                                                                           as closed,
      //gbsta, lfsta, lfgsa, lfstk
      case when ( vbap.SDProcessStatus = ''  or  vbap.DeliveryStatus = '' or vbap.TotalDeliveryStatus = '' ) or vbak.OverallDeliveryStatus = 'C'
        then ''
        else 'X'
      end                                                                                                                               as undel,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_SOLIST'
      cast( ''  as abap.char(255))                                                                                                      as text,
      
      vbap._Product,
      vbap._ProductText,
      vbak.YY1_TW_GUINO_SDH,
      vbak.YY1_Vatno_SDH,
      vbak.YY1_EC_MEMO1_SDH,
      vbak.YY1_ECKUNNR_SDH,
      
      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZZ1_I_CLOSEDATA2', element: 'value_low' } } ]
      case 
       when vbap.SalesDocumentRjcnReason is initial
         or vbap.SalesDocumentRjcnReason = ''
        then cast ('N' as zz1_closedata) 
       when vbap.SalesDocumentRjcnReason is not initial
         or vbap.SalesDocumentRjcnReason <> ''
        then cast ('D' as zz1_closedata) 
      end as closedata

}
