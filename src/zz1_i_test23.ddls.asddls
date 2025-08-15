//@AbapCatalog.sqlViewName: 'ZZ1TEST23'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'TEST'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]

define root view entity ZZ1_I_TEST23
  as select from ZZ1_I_DNLIST2
{
      
  key OutboundDelivery,
  key OutboundDeliveryItem,
            
      //@Semantics.unitOfMeasure: true
      DeliveryQuantityUnit,
      @Aggregation.default: #SUM  
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      ActualDeliveryQuantity
}
