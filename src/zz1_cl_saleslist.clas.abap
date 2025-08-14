CLASS zz1_cl_saleslist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS select FOR TABLE FUNCTION zz1_tf_journalentry.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZZ1_CL_SALESLIST IMPLEMENTATION.


  METHOD select
     BY DATABASE FUNCTION FOR HDB
        LANGUAGE SQLSCRIPT
        OPTIONS READ-ONLY
        USING zz1_I_JOURNALENTRY2.
    lt_acc =
      select CompanyCode,
             FiscalYear,
             AccountingDocument,
             ReferenceDocumentType,
             OriginalReferenceDocument,
             postingdate,
             DocumentDate,
             DocumentReferenceID,
             TaxType,
             AssignmentReference,
             Reference3IDByBusinessPartner,
             rank ( ) over ( PARTITION BY CompanyCode,  FiscalYear,
             AccountingDocument ORDER BY AssignmentReference DESC ) AS rank
        from zz1_I_JOURNALENTRY2;

     RETURN
      select client,
             CompanyCode,
             FiscalYear,
             AccountingDocument,
             ReferenceDocumentType,
             OriginalReferenceDocument,
             postingdate,
             DocumentDate,
             DocumentReferenceID,
             TaxType,
             AssignmentReference,
             Reference3IDByBusinessPartner
        from :lt_acc
        where rank = 1;

  ENDMETHOD.
ENDCLASS.
