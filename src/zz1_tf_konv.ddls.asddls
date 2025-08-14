@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: '銷售訂單價格Table Function'
define table function ZZ1_TF_KONV
  with parameters
    @Environment.systemField: #CLIENT
    client : abap.clnt
returns
{
  Client              : abap.clnt;
  SalesDocument       : abap.char(10);
  SalesDocumentItem   : abap.numc(6);
  CONDITIONTYPE       : abap.char(4);
  CONDITIONRATEVALUE  : abap.dec( 24, 9 );
  CONDITIONCURRENCY   : abap.cuky( 5 );
  CONDITIONQUANTITY   : abap.dec( 5, 0 );
  CONDITIONAMOUNT     : abap.curr( 15, 2 );
  TRANSACTIONCURRENCY : abap.cuky( 5 );
}
implemented by method
  zz1_cl_solist=>exec_konv;