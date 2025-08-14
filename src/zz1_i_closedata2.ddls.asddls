@ObjectModel.sapObjectNodeType.name: 'ZZ1_CLOSEDATA2'
@ObjectModel.representativeKey: 'value_low'
@ObjectModel.usageType.dataClass: #META
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.resultSet.sizeCategory: #XS 
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.modelingPattern:         #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #SEARCHABLE_ENTITY,
                                      #SQL_DATA_SOURCE,
                                      #VALUE_HELP_PROVIDER ]
@EndUserText.label: '強制結案資料'
@Analytics.dataCategory: #DIMENSION
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:  #NOT_REQUIRED
@AbapCatalog: {
  sqlViewName: 'ZZ1CLOSEDATA',
  preserveKey: true
}
@Search.searchable: true
@Consumption.ranked: true
@Metadata.ignorePropagatedAnnotations: true
define view ZZ1_I_CLOSEDATA2
       as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZZ1_CLOSEDATA')
{
    key value_low,
    @Semantics.text: true
    text
}
