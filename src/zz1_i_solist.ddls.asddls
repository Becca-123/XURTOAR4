@AbapCatalog.sqlViewName: 'ZZ1_SOLIST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@Analytics.dataCategory: #CUBE
@Analytics.internalName: #LOCAL
@ObjectModel.modelingPattern: #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
//@ObjectModel.representativeKey: 'SalesDocumentItem'
@EndUserText.label: '銷售訂單資料'
define view ZZ1_I_SOLIST  as select from I_SalesDocumentItem as item
    inner join   I_SalesDocument     as _head on item.SalesDocument = _head.SalesDocument
    //inner join   acdoca as acdoca on acdoca.rbukrs = _head.BillingCompanyCode
  association [0..1] to ZZ1_TF_VBEP          as _sche              on  $projection.SalesDocument     = _sche.SalesDocument
                                                                   and $projection.SalesDocumentItem = _sche.SalesDocumentItem
  association [0..1] to ZZ1_TF_KONV          as _cond_vkp0         on  $projection.SalesDocument     = _cond_vkp0.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_vkp0.SalesDocumentItem
                                                                   and _cond_vkp0.CONDITIONTYPE      = 'VKP0'
  association [0..1] to ZZ1_TF_KONV          as _cond_pn10         on  $projection.SalesDocument     = _cond_pn10.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_pn10.SalesDocumentItem
                                                                   and _cond_pn10.CONDITIONTYPE      = 'PN10'
  association [0..1] to ZZ1_TF_KONV          as _cond_pr00         on  $projection.SalesDocument     = _cond_pr00.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_pr00.SalesDocumentItem
                                                                   and _cond_pr00.CONDITIONTYPE      = 'PR00'
  association [0..1] to ZZ1_TF_KONV          as _cond_ztal         on  $projection.SalesDocument     = _cond_ztal.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_ztal.SalesDocumentItem
                                                                   and _cond_ztal.CONDITIONTYPE      = 'ZTAL'
  association [0..1] to ZZ1_TF_KONV          as _cond_zta1         on  $projection.SalesDocument     = _cond_zta1.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_zta1.SalesDocumentItem
                                                                   and _cond_zta1.CONDITIONTYPE      = 'ZTA1'
  association [0..1] to ZZ1_TF_KONV          as _cond_zta2         on  $projection.SalesDocument     = _cond_zta2.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_zta2.SalesDocumentItem
                                                                   and _cond_zta2.CONDITIONTYPE      = 'ZTA2'
  association [0..1] to ZZ1_TF_KONV          as _cond_zpn0         on  $projection.SalesDocument     = _cond_zpn0.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_zpn0.SalesDocumentItem
                                                                   and _cond_zpn0.CONDITIONTYPE      = 'ZPN0'
  association [0..1] to ZZ1_TF_KONV          as _cond_zpn1         on  $projection.SalesDocument     = _cond_zpn1.SalesDocument
                                                                   and $projection.SalesDocumentItem = _cond_zpn1.SalesDocumentItem
                                                                   and _cond_zpn1.CONDITIONTYPE      = 'ZPN1'
  association [0..1] to I_Product            as _matwa             on  $projection.OriginallyRequestedMaterial = _matwa.Product
  association [0..1] to I_CustomerMaterial_2 as _CUSTOMERMATERIAL  on  _head.SoldToParty         = _CUSTOMERMATERIAL.Customer
                                                                   and _head.SalesOrganization   = _CUSTOMERMATERIAL.SalesOrganization
                                                                   and _head.DistributionChannel = _CUSTOMERMATERIAL.DistributionChannel
                                                                   and item.MaterialByCustomer   = _CUSTOMERMATERIAL.MaterialByCustomer
  association [0..1] to I_CustomerSalesArea  as _CustomerSalesArea on  _head.SoldToParty          = _CustomerSalesArea.Customer
                                                                   and _head.SalesOrganization    = _CustomerSalesArea.SalesOrganization
                                                                   and _head.DistributionChannel  = _CustomerSalesArea.DistributionChannel
                                                                   and _head.OrganizationDivision = _CustomerSalesArea.Division
  association [0..1] to I_CustomerGroup      as _CustomerGroup     on  _head.CustomerGroup = _CustomerGroup.CustomerGroup


  //association [0..*] to I_ShippingPointText         as _ShippingPointText on  $projection.ShippingPoint = _ShippingPointText.ShippingPoint
  //association [0..1] to I_Plant                     as _Plant             on  $projection.Plant = _Plant.Plant
  //association [0..1] to I_Product                   as _Product           on  $projection.Material = _Product.Product
  //association [0..1] to I_SalesOffice               as _SalesOffice       on  $projection._SalesDocument.SalesOffice = _SalesOffice.SalesOffice
{


      @Consumption.semanticObject: 'SalesOrder'
      @UI.lineItem: [ { type: #FOR_INTENT_BASED_NAVIGATION, semanticObjectAction: 'manage'} ]
  key item.SalesDocument,
  key item.SalesDocumentItem,
      @ObjectModel.text.association: '_ProductText'
      @ObjectModel.text.element: ['materialname']
      item.Product,
      item._Product._Text[Language = $session.system_language].ProductName                                                              as materialname,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      item.NetAmount,
      @Semantics.currencyCode: true
      item.TransactionCurrency,
      @Semantics.quantity.unitOfMeasure: 'TargetQuantityUnit'
      item.TargetQuantity,
      @Semantics.unitOfMeasure: true
      item.TargetQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      item.OrderQuantity,
      @Semantics.unitOfMeasure: true
      item.OrderQuantityUnit,
      item.Plant,
      item._Plant.PlantName,
      item.MaterialByCustomer,
      _CUSTOMERMATERIAL.MaterialDescriptionByCustomer,
      item.SalesDocumentItemCategory,
      item._ItemCategory._Text[Language = $session.system_language].SalesDocumentItemCategoryName,
      item.SalesDocumentRjcnReason,
      item._SalesDocumentRjcnReason._Text[Language = $session.system_language].SalesDocumentRjcnReasonName,
      item.ProductHierarchyNode,
      //item._ProductHierarchyNode._Text[Language = $session.system_language].ProductHierarchyNodeText,
      item.ShippingPoint,
      case when item._ShippingPointText[Language = $session.system_language].ShippingPointName <> ''
        then item._ShippingPointText[Language = $session.system_language].ShippingPointName
        else item._ShippingPointText[Language = 'E'].ShippingPointName
      end                                                                                                                               as ShippingPointName,
      item.ProfitCenter,
      item.OriginallyRequestedMaterial,
      _matwa._Text[Language = $session.system_language].ProductName                                                                     as matwaname,

      //KONV
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when _cond_vkp0( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_vkp0( client : $session.client ).CONDITIONAMOUNT , _cond_vkp0( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_pn10( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_pn10( client : $session.client ).CONDITIONAMOUNT , _cond_pn10( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_pr00( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_pr00( client : $session.client ).CONDITIONAMOUNT , _cond_pr00( client : $session.client ).CONDITIONQUANTITY,2 )
      end                                                                                                                               as origin_amount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when _cond_ztal( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_ztal( client : $session.client ).CONDITIONAMOUNT , _cond_ztal( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zta1( client : $session.client ).CONDITIONTYPE <> ''
           then division(_cond_zta1( client : $session.client ).CONDITIONAMOUNT , _cond_zta1( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zta2( client : $session.client ).CONDITIONTYPE <> ''
           then division(_cond_zta2( client : $session.client ).CONDITIONAMOUNT , _cond_zta2( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zpn0( client : $session.client ).CONDITIONTYPE <> ''
           then division(_cond_zpn0( client : $session.client ).CONDITIONAMOUNT , _cond_zpn0( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zpn1( client : $session.client ).CONDITIONTYPE <> ''
           then division(_cond_zpn1( client : $session.client ).CONDITIONAMOUNT , _cond_zpn1( client : $session.client ).CONDITIONQUANTITY,2 )
      end                                                                                                                               as actual_amount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when item.OrderQuantity > 0 then
      ( case when _cond_vkp0( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_vkp0( client : $session.client ).CONDITIONAMOUNT , _cond_vkp0( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_pn10( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_pn10( client : $session.client ).CONDITIONAMOUNT , _cond_pn10( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_pr00( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_pr00( client : $session.client ).CONDITIONAMOUNT , _cond_pr00( client : $session.client ).CONDITIONQUANTITY,2 )
      end )
      end                                                                                                                               as origin_unit,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when item.OrderQuantity > 0 then
      ( case when _cond_ztal( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_ztal( client : $session.client ).CONDITIONAMOUNT , _cond_ztal( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zta1( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_zta1( client : $session.client ).CONDITIONAMOUNT , _cond_zta1( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zta2( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_zta2( client : $session.client ).CONDITIONAMOUNT , _cond_zta2( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zpn0( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_zpn0( client : $session.client ).CONDITIONAMOUNT , _cond_zpn0( client : $session.client ).CONDITIONQUANTITY,2 )
           when _cond_zpn1( client : $session.client ).CONDITIONTYPE <> ''
           then division( _cond_zpn1( client : $session.client ).CONDITIONAMOUNT , _cond_zpn1( client : $session.client ).CONDITIONQUANTITY,2 )
      end )
      end                                                                                                                               as actual_unit,

      _head.SalesDocumentType,
      _head._SalesDocumentType._Text[Language = $session.system_language].SalesDocumentTypeName,
      _head.SalesOrganization,
      _head._SalesOrganization._Text[Language = $session.system_language].SalesOrganizationName,
      _head.DistributionChannel,
      _head._DistributionChannel._Text[Language = $session.system_language].DistributionChannelName,
      _head.OrganizationDivision,
      _head._OrganizationDivision._Text[Language = $session.system_language].DivisionName,
      _head.SalesDocumentDate,
      _head.SoldToParty,
      _head.BillingCompanyCode,
      _head.CreatedByUser,
      _head.CreationDate,
      _head.PurchaseOrderByCustomer,
      item.UnderlyingPurchaseOrderItem,
      _head.AccountingDocExternalReference,
      _head.SDDocumentReason,
      _head._SDDocumentReason._Text[Language = $session.system_language].SDDocumentReasonText,
      _head.SalesDocumentCondition,
      _head.SalesOffice,
      _head._SalesOffice._Text[Language = $session.system_language].SalesOfficeName,
      _head.ControllingObject,
      _head.AdditionalCustomerGroup1,
      _head._AdditionalCustomerGroup1._Text[Language = $session.system_language].AdditionalCustomerGroup1Name,
      _head.AdditionalCustomerGroup2,
      _head._AdditionalCustomerGroup2._Text[Language = $session.system_language].AdditionalCustomerGroup2Name,
      _head.AdditionalCustomerGroup3,
      _head._AdditionalCustomerGroup3._Text[Language = $session.system_language].AdditionalCustomerGroup3Name,
      _head.AdditionalCustomerGroup4,
      _head._AdditionalCustomerGroup4._Text[Language = $session.system_language].AdditionalCustomerGroup4Name,
      _head.AdditionalCustomerGroup5,
      _head._AdditionalCustomerGroup5._Text[Language = $session.system_language].AdditionalCustomerGroup5Name,
      _head.TotalBlockStatus,
      //vbkd
      _head.CustomerGroup,
      _head._CustomerGroup._Text[Language = $session.system_language].CustomerGroupName,
      cast( _head.AccountingExchangeRate as abap.dec(9,5) )                                                                             as AccountingExchangeRate,
      _head.PriceDetnExchangeRate,
      _head.SalesDistrict,
      _head._SalesDistrict._Text[Language = $session.system_language].SalesDistrictName,
      _head.CustomerPaymentTerms,
      _head._CustomerPaymentTerms._Text[Language = $session.system_language].CustomerPaymentTermsName,
      _head.IncotermsClassification,
      _head.IncotermsTransferLocation,

      //vbep
      _sche( client : $session.client ).PurchaseRequisition,
      _sche( client : $session.client ).PurchaseRequisitionItem,

      //mara
      item._Product.ProductType,
      item._Product._ProductTypeName[Language = $session.system_language].MaterialTypeName,
      item._Product.ProductGroup,
      //item._Material._MaterialGroup._Text[Language = $session.system_language].MaterialGroupName,
      item._Product._ProductGroupText_2[Language = $session.system_language].ProductGroupText,

      //vbpa
      _head._Partner[ PartnerFunction = 'AE'].Customer                                                                                  as kunnr_ae,
      concat( _head._Partner[ PartnerFunction = 'AE']._OrganizationAddress.AddresseeName1,
              _head._Partner[ PartnerFunction = 'AE']._OrganizationAddress.AddresseeName2  )                                            as name_ae,

      concat( _head._Partner[ PartnerFunction = 'AG']._OrganizationAddress.AddresseeName1,
              _head._Partner[ PartnerFunction = 'AG']._OrganizationAddress.AddresseeName2  )                                            as name_ag,
      _head._Partner[ PartnerFunction = 'AG']._OrganizationAddress.Region                                                               as region_ag,
      _head._Partner[ PartnerFunction = 'AG']._OrganizationAddress.Country                                                              as country_ag,
      _head._Partner[ PartnerFunction = 'AG']._OrganizationAddress._Region._RegionText[Language = $session.system_language].RegionName  as RegionName_ag,
      _head._Partner[ PartnerFunction = 'AG']._OrganizationAddress._Country._Text[Language = $session.system_language].CountryShortName as CountryName_ag,

      _head._Partner[ PartnerFunction = 'WE'].Customer                                                                                  as kunnr_we,
      concat( _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.AddresseeName1,
              _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.AddresseeName2  )                                            as name_we,
      concat(
        concat(
                concat( _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetName,
                        _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetPrefixName1
                      ),
                _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetPrefixName2
              ),
        _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.StreetSuffixName1
      )                                                                                                                                 as address_we,
      _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.Region                                                               as region_we,
      _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress.Country                                                              as country_we,
      _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress._Region._RegionText[Language = $session.system_language].RegionName  as RegionName_we,
      _head._Partner[ PartnerFunction = 'WE']._OrganizationAddress._Country._Text[Language = $session.system_language].CountryShortName as CountryName_we,


      //knvv
      _CustomerSalesArea.CustomerPriceGroup,
      left( _head.SalesDocumentDate, 6 )                                                                                                as ymon,
      cast ( case when item.SalesDocumentRjcnReason = ''  then ''
        else 'X'
      end as abap.char( 1 ) )                                                                                                           as closed,

      case when ( item.SDProcessStatus = ''  or  item.DeliveryStatus = '' or item.TotalDeliveryStatus = '' ) or _head.OverallDeliveryStatus = 'C'
        then ''
        else 'X'
      end                                                                                                                               as undel,


      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_SOLIST'
      cast( ''  as abap.char(255))                                                                                                      as text,

      decimal_shift( amount => item.NetAmount,
      currency => item.TransactionCurrency,
      error_handling => 'SET_TO_NULL' )                                                                                                 as nettest,

      item._Product,
      item._ProductText,
      
      case when 
      item.ProfitCenter between 'AA00000000' and 'AZZZZZZZZZ' or
      item.ProfitCenter between 'BA00000000' and 'BZZZZZZZZZ' or
      item.ProfitCenter between 'CA00000000' and 'CZZZZZZZZZ' or
      item.ProfitCenter between 'DA00000000' and 'DZZZZZZZZZ' or
      item.ProfitCenter between 'EA00000000' and 'EZZZZZZZZZ'
      then item.ProfitCenter
      else ''
      
      end as test     

}
where
  _head.TotalBlockStatus = ''
