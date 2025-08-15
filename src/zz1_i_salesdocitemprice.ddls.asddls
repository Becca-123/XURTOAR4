//@AbapCatalog.sqlViewName: 'ZZ1_SALESDOCITE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '銷售訂單明細價格條件'

define root view entity ZZ1_I_SALESDOCITEMPRICE
  as select from I_SalesDocItemPricingElement
{
  key SalesDocument,
  key SalesDocumentItem,
  key PricingProcedureStep,
  key PricingProcedureCounter, 
      ConditionType,  
      ConditionInactiveReason,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ConditionAmount,
      //@Semantics.currencyCode: true
      TransactionCurrency
}
