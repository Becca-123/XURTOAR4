@AbapCatalog.sqlViewName: 'ZZ1_XBLNR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BILLING參考第1及第2碼 未稅金額加總'
@Metadata.ignorePropagatedAnnotations: true
define view ZZ1_I_XBLNR2 as select from I_JournalEntryItem
{
    key I_JournalEntryItem.ReferenceDocument,
    key I_JournalEntryItem.ReferenceDocumentItem,
        sum(AmountInCompanyCodeCurrency) as AmountInCompanyCodeCurrency,
        I_JournalEntryItem.AccountingDocument,
        I_JournalEntryItem.CompanyCodeCurrency
} where I_JournalEntryItem.ControllingBusTransacType = 'COIN' and I_JournalEntryItem.ReferenceDocumentType = 'VBRK' 
    and I_JournalEntryItem.Ledger = '0L' 
group by I_JournalEntryItem.ReferenceDocument, I_JournalEntryItem.ReferenceDocumentItem,
         I_JournalEntryItem.AccountingDocument, I_JournalEntryItem.CompanyCodeCurrency
           
           
           
           






   
