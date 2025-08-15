@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'JOURNALENTRY'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define table function ZZ1_TF_JOURNALENTRY
  with parameters
    @Environment.systemField: #CLIENT
    client : abap.clnt
returns
{
  Client                        : abap.clnt;
  CompanyCode                   : abap.char(4);
  FiscalYear                    : abap.numc(4);
  AccountingDocument            : abap.char(10);
  ReferenceDocumentType         : abap.char(5);
  OriginalReferenceDocument     : abap.char(20);
  POSTINGDATE                   : abap.dats;
  DocumentDate                  : abap.dats;
  DocumentReferenceID           : abap.char(16);
  TaxType                       : abap.char(1);
  AssignmentReference           : abap.char(18);
  Reference3IDByBusinessPartner : abap.char(20);
}
implemented by method
  zz1_cl_saleslist=>select;