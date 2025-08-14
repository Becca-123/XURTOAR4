@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOURNALENTRY'
@AbapCatalog.extensibility.extensible: true
define view entity ZZ1_I_JOURNALENTRY2
  as select distinct from I_JournalEntry
    left outer join       I_OperationalAcctgDocItem on  I_JournalEntry.FiscalYear                     =  I_OperationalAcctgDocItem.FiscalYear
                                                    and I_JournalEntry.AccountingDocument             =  I_OperationalAcctgDocItem.AccountingDocument
                                                    and I_JournalEntry.CompanyCode                    =  I_OperationalAcctgDocItem.CompanyCode
                                                    and I_OperationalAcctgDocItem.TaxType             =  'A'
                                                    and I_OperationalAcctgDocItem.AssignmentReference <> ''
                                                    and I_OperationalAcctgDocItem.AssignmentReference is not null


{
  I_JournalEntry.CompanyCode,
  I_JournalEntry.FiscalYear,
  I_JournalEntry.AccountingDocument,
  I_JournalEntry.ReferenceDocumentType,
  I_JournalEntry.OriginalReferenceDocument,
  I_JournalEntry.PostingDate,
  I_JournalEntry.DocumentDate,
  I_JournalEntry.DocumentReferenceID,
  I_OperationalAcctgDocItem.TaxType,
  I_OperationalAcctgDocItem.AssignmentReference,
  I_OperationalAcctgDocItem.Reference3IDByBusinessPartner
}

where
  I_JournalEntry.ReferenceDocumentType = 'VBRK'
