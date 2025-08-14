@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: '出貨單明細表取來源訂單稅額'
define table function ZZ1_TF_DNList_TAX
with parameters 
@Environment.systemField: #CLIENT
    client : abap.clnt
returns {
  Client              : abap.clnt;
  SalesDocument       : abap.char(10);  
  CONDITIONAMOUNT     : abap.curr( 15, 2 );
  TRANSACTIONCURRENCY : abap.cuky( 5 );  
}
implemented by method zz1_cl_dnlist=>exec_tax ;