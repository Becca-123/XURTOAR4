//@AbapCatalog.sqlViewName: 'ZZ1_DNLIST'
//@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@EndUserText.label: '出貨單明細表'

define root view entity ZZ1_I_DNList
  as select from    I_DeliveryDocument                            as I_OutboundDelivery
    left outer join I_DeliveryDocumentItem                        as _I_OutboundDeliveryItem  on _I_OutboundDeliveryItem.DeliveryDocument = I_OutboundDelivery.DeliveryDocument
    left outer join I_SalesDocument                               as _I_SalesDocument        on _I_SalesDocument.SalesDocument = _I_OutboundDeliveryItem.ReferenceSDDocument
    left outer join ZZ1_TF_DNList_TAX( client : $session.client ) as _tax                    on _tax.SalesDocument = _I_OutboundDeliveryItem.ReferenceSDDocument
    left outer join I_OutboundDeliveryItem                        as _BSItem                 on  _BSItem.OutboundDelivery         = _I_OutboundDeliveryItem.DeliveryDocument
                                                                                             and _BSItem.HigherLvlItmOfBatSpltItm = _I_OutboundDeliveryItem.DeliveryDocumentItem
    left outer join I_User                                        as _user                   on I_OutboundDelivery.CreatedByUser = _user.UserID
    left outer join I_AddressPersonName                           as _AddressPersonName      on  _user.AddressPersonID                        = _AddressPersonName.AddressPersonID
                                                                                             and _AddressPersonName.AddressRepresentationCode = ''

{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_DeliveryDocumentStdVH' , element: 'DeliveryDocument' } 
                                            ,additionalBinding: [{ localElement: 'OutboundDelivery' ,element: 'DeliveryDocument', usage: #FILTER }]
                                        } ]
      @Consumption.semanticObject: 'OutboundDelivery'
      @UI.lineItem: [ { type: #FOR_INTENT_BASED_NAVIGATION, semanticObjectAction: 'display'} ]
  key I_OutboundDelivery.DeliveryDocument                                                                                                                                             as OutboundDelivery,
  key _I_OutboundDeliveryItem.DeliveryDocumentItem                                                                                                                                     as OutboundDeliveryItem,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_DeliveryDocumentType', element: 'DeliveryDocumentType' } 
                                            ,additionalBinding: [{ localConstant: 'J' ,element: 'SDDocumentCategory', usage: #FILTER } ]
                                        } ]
      @ObjectModel.text.element: ['DeliveryDocumentTypeName']
      @UI.textArrangement: #TEXT_ONLY
      I_OutboundDelivery.DeliveryDocumentType                                                                                                                                          as DeliveryDocumentType,
      @Semantics.text: true
      I_OutboundDelivery._DeliveryDocumentType._Text[Language = $session.system_language].DeliveryDocumentTypeName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnSalesOrganizationVH', element: 'SalesOrganization' } } ]
      @ObjectModel.text.element: ['SalesOrganizationName']
      I_OutboundDelivery.SalesOrganization                                                                                                                                             as SalesOrganization,
      @Semantics.text: true
      I_OutboundDelivery._SalesOrganization._Text[Language = $session.system_language].SalesOrganizationName,

      I_OutboundDelivery.DeliveryDate                                                                                                                                                  as DeliveryDate,
      I_OutboundDelivery.ActualGoodsMovementDate                                                                                                                                       as ActualGoodsMovementDate,

      I_OutboundDelivery.CreatedByUser                                                                                                                                                 as CreatedByUser,
      _AddressPersonName.PersonFullName                                                                                                                                                as PersonFullName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CUSTOMER_VH', element: 'Customer' } } ]
      @ObjectModel.text.element: [ 'CustomerName_we' ]
      I_OutboundDelivery._ShipToParty.Customer                                                                                                                                         as Customer_we,

      //      I_OutboundDelivery._ShipToParty.CustomerName                                                               as CustomerName_we,
      //      I_OutboundDelivery._ShipToParty.CityName                                                                   as CityName_we,
      //      I_OutboundDelivery._ShipToParty.PostalCode                                                                 as PostalCode_we,
      //      I_OutboundDelivery._ShipToParty.StreetName                                                                 as StreetName_we,
      //      I_OutboundDelivery._ShipToParty.TelephoneNumber1                                                           as TelephoneNumber1_we,
      @Semantics.text: true
      concat( I_OutboundDelivery._Partner[ PartnerFunction = 'WE']._DfltAddrRprstn.OrganizationName1,
              I_OutboundDelivery._Partner[ PartnerFunction = 'WE']._DfltAddrRprstn.OrganizationName2 )                                                                                 as CustomerName_we,
      I_OutboundDelivery._Partner[ PartnerFunction = 'WE']._DfltAddrRprstn.CityName                                                                                                    as CityName_we,
      I_OutboundDelivery._Partner[ PartnerFunction = 'WE']._DfltAddrRprstn.PostalCode                                                                                                  as PostalCode_we,
      I_OutboundDelivery._Partner[ PartnerFunction = 'WE']._DfltAddrRprstn.StreetName                                                                                                  as StreetName_we,
      I_OutboundDelivery._Partner[ PartnerFunction = 'WE']._DfltAddrRprstn._PhoneNumber[ PhNmbrIsCurrentOverallDefault = 'X' and PhoneNumberType = '1' ].PhoneAreaCodeSubscriberNumber as TelephoneNumber1_we,
      I_OutboundDelivery._Partner[ PartnerFunction = 'WE']._DfltAddrRprstn._CurrentDfltMobilePhoneNumber.PhoneAreaCodeSubscriberNumber                                                 as mobilephoneNumber1_we,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CUSTOMER_VH', element: 'Customer' } } ]
      @ObjectModel.text.element: [ 'CustomerName_ag' ]
      I_OutboundDelivery._SoldToParty.Customer                                                                                                                                         as Customer_ag,
      //      I_OutboundDelivery._SoldToParty.CustomerName                                                               as CustomerName_ag,
      @Semantics.text: true
      concat( I_OutboundDelivery._Partner[ PartnerFunction = 'AG']._DfltAddrRprstn.OrganizationName1,
              I_OutboundDelivery._Partner[ PartnerFunction = 'AG']._DfltAddrRprstn.OrganizationName2 )                                                                                 as CustomerName_ag,

      I_OutboundDelivery._Partner[ PartnerFunction = 'ZM' ].ReferenceBusinessPartner                                                                                                   as customer_zm,
      concat( I_OutboundDelivery._Partner[ PartnerFunction = 'ZM']._DfltAddrRprstn.OrganizationName1,
               I_OutboundDelivery._Partner[ PartnerFunction = 'ZM']._DfltAddrRprstn.OrganizationName2 )                                                                                as CustomerName_zm,

      _I_SalesDocument._Partner[ PartnerFunction = 'RG']._OrganizationAddress.AddresseeName1                                                                                           as CustomerName_rg,
      @ObjectModel.text.element: ['ShippingPointName']
      I_OutboundDelivery.ShippingPoint                                                                                                                                                 as SHIPPINGPOINT,
      @Semantics.text: true
      I_OutboundDelivery._ShippingPoint._Text[Language = $session.system_language].ShippingPointName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnDistributionChannelVH', element: 'DistributionChannel' } } ]
      @ObjectModel.text.element: ['DistributionChannelName']
      _I_OutboundDeliveryItem.DistributionChannel                                                                                                                                      as DistributionChannel,
      @Semantics.text: true
      _I_OutboundDeliveryItem._DistributionChannel._Text[Language = $session.system_language].DistributionChannelName,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnDivisionVH', element: 'Division' } } ]
      @ObjectModel.text.element: ['DivisionName']
      _I_OutboundDeliveryItem.Division                                                                                                                                                 as Division,
      @Semantics.text: true
      _I_OutboundDeliveryItem._Division._Text[Language = $session.system_language].DivisionName,

      @ObjectModel.text.element: ['PlantName']
      _I_OutboundDeliveryItem.Plant                                                                                                                                                    as Plant,
      @Semantics.text: true
      _I_OutboundDeliveryItem._Plant.PlantName                                                                                                                                         as PlantName,
      @ObjectModel.text.element: ['StorageLocationName']
      _I_OutboundDeliveryItem.StorageLocation                                                                                                                                          as StorageLocation,
      @Semantics.text: true
      _I_OutboundDeliveryItem._StorageLocation.StorageLocationName                                                                                                                     as StorageLocationName,

      _I_OutboundDeliveryItem.Batch                                                                                                                                                    as Batch,
      _I_OutboundDeliveryItem._Product.IsBatchManagementRequired                                                                                                                       as IsBatchManagementRequired,
      @ObjectModel.text.element: ['ProductName']
      _I_OutboundDeliveryItem.Material                                                                                                                                                 as Product,
      @Semantics.text: true
      _I_OutboundDeliveryItem._Product._Text[Language = $session.system_language].ProductName                                                                                          as ProductName,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      _I_OutboundDeliveryItem.ActualDeliveredQtyInBaseUnit                                                                                                                             as ActualDeliveredQtyInBaseUnit,
      @ObjectModel.text.element: ['BaseUnitName']
      _I_OutboundDeliveryItem.BaseUnit                                                                                                                                                 as BaseUnit,
      @Semantics.text: true
      _I_OutboundDeliveryItem._BaseUnit._Text[Language = $session.system_language].UnitOfMeasureName                                                                                   as BaseUnitName,

      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      _I_OutboundDeliveryItem.ActualDeliveryQuantity                                                                                                                                   as ActualDeliveryQuantity,
      @ObjectModel.text.element: ['DeliveryQuantityUnitName']
      _I_OutboundDeliveryItem.DeliveryQuantityUnit                                                                                                                                     as DeliveryQuantityUnit,
      @Semantics.text: true
      _I_OutboundDeliveryItem._DeliveryQuantityUnit._Text[Language = $session.system_language].UnitOfMeasureName                                                                       as DeliveryQuantityUnitName,


      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ( _I_SalesDocument.TotalNetAmount + _tax.CONDITIONAMOUNT )                                                                                                                       as TotalAmount,
      //@Semantics.currencyCode: true
      _I_SalesDocument.TransactionCurrency                                                                                                                                             as TransactionCurrency,
      _I_SalesDocument.PurchaseOrderByCustomer                                                                                                                                         as PurchaseOrderByCustomer,



      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_DNLIST'
      cast( ''  as abap.char(255))                                                                                                                                                     as tx03,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_DNLIST'
      cast( ''  as abap.char(255))                                                                                                                                                     as tx04,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_DNLIST'
      cast( ''  as abap.char(255))                                                                                                                                                     as tx07,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_DNLIST'
      cast( ''  as abap.char(255))                                                                                                                                                     as tx13,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_DNLIST'
      cast( ''  as abap.char(255))                                                                                                                                                     as tx14,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_DNLIST'
      cast( ''  as abap.char(255))                                                                                                                                                     as tx17,

      cast( _BSItem.OutboundDeliveryItem as abap.char(6) )                                                                                                                             as BSItem
}
where
      I_OutboundDelivery.DeliveryDocumentType = 'LF'
  and _BSItem.OutboundDeliveryItem            is null
