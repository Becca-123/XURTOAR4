@AbapCatalog.sqlViewName: 'ZZ1_XBLNR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BILLING參考第1及第2碼'
define view ZZ1_I_XBLNR as select from I_BillingDocumentBasic as i_BillingDocument
                     left outer join I_BillingDocumentItemBasic as i_BillingDocumentItem on i_BillingDocument.BillingDocument = i_BillingDocumentItem.BillingDocument
                     left outer join ZZ1_I_XBLNR2 as I_JournalentryItem on I_JournalentryItem.ReferenceDocument = i_BillingDocument.BillingDocument and I_JournalentryItem.ReferenceDocumentItem = i_BillingDocumentItem.BillingDocumentItem
                                                            //and I_JournalEntryItem.ControllingBusTransacType = 'COIN' and I_JournalEntryItem.ReferenceDocumentType = 'VBRK' and I_JournalEntryItem.Ledger = '0L' 
                                                            and ( I_JournalentryItem.AmountInCompanyCodeCurrency <= 0 )
{
    key i_BillingDocument.BillingDocument,
    key i_BillingDocumentItem.BillingDocumentItem,
    substring(i_BillingDocument.DocumentReferenceID , 1 , 1) as xblnr01 ,//參考第一碼
    substring(i_BillingDocument.DocumentReferenceID , 2 , 1) as xblnr02, //參考第二碼
    substring(i_BillingDocument.YY1_XBLNR_BDH , 1 , 1) as yy1_xblnr01, //客製參考第一碼 
    substring(i_BillingDocument.YY1_XBLNR_BDH , 2 , 1) as yy1_xblnr02, //客製參考第二碼
    case 
      when (i_BillingDocumentItem.BillingQuantity  != 0)
       then cast( division( i_BillingDocumentItem.NetAmount, i_BillingDocumentItem.BillingQuantity , 2 ) as abap.dec(15,3))
       else 0
    end as unit_price ,
    i_BillingDocumentItem.Product,
    i_BillingDocument.TransactionCurrency,
    I_JournalentryItem.AccountingDocument,
    I_JournalentryItem.CompanyCodeCurrency,
    I_JournalentryItem.AmountInCompanyCodeCurrency * -1  as AmountInCompanyCodeCurrency,
    case
      when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
       then
        case 
        when I_JournalentryItem.CompanyCodeCurrency = 'TWD' and i_BillingDocument.TransactionCurrency != 'TWD'
         then  cast( division( i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount * -1 , 100, 2) as abap.curr(15,2))
         else  round(i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount * -1, 2) 
         end 
      else  
        case 
          when I_JournalentryItem.CompanyCodeCurrency = 'TWD' and i_BillingDocument.TransactionCurrency != 'TWD'
            then cast( division( i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount, 100, 2) as abap.curr(15,2))
            else round(i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount , 2) 
            end
    end  as TaxAmountInCompanyCodeCurrency,
    case
      when i_BillingDocumentItem.SDDocumentCategory  = '6' or i_BillingDocumentItem.SDDocumentCategory  = 'N' or i_BillingDocumentItem.SDDocumentCategory  = 'O'
       then 
        case 
         when I_JournalentryItem.CompanyCodeCurrency = 'TWD' and i_BillingDocument.TransactionCurrency != 'TWD'
          then   cast(( I_JournalentryItem.AmountInCompanyCodeCurrency * -1 ) + division( i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount * -1 ,100,2) as abap.curr(15,2))
          else   ( I_JournalentryItem.AmountInCompanyCodeCurrency * -1 ) + round( i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount * -1 , 2)
         end
       else  
        case 
         when I_JournalentryItem.CompanyCodeCurrency = 'TWD' and i_BillingDocument.TransactionCurrency != 'TWD'
          then cast(( I_JournalentryItem.AmountInCompanyCodeCurrency * -1 ) + division( i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount ,100,2) as abap.curr(15,2))
          else ( I_JournalentryItem.AmountInCompanyCodeCurrency * -1 ) + round( i_BillingDocument.AccountingExchangeRate * i_BillingDocumentItem.TaxAmount  , 2)
         end
      end  as AllAmountInCompanyCodeCurrency 
}
