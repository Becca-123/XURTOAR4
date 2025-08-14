@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: '銷售訂單排程明細Table Function'
define table function ZZ1_TF_VBEP
  with parameters
    @Environment.systemField: #CLIENT
    client : abap.clnt
returns
{
  Client                  : abap.clnt;
  SalesDocument           : abap.char(10);
  SalesDocumentItem       : abap.numc(6);
  PurchaseRequisition     : abap.char(10);
  PurchaseRequisitionItem : abap.numc(5);
}
implemented by method
  zz1_cl_solist=>exec_vbep;