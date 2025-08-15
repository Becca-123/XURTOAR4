@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TEST'
//@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true

@UI: {
     headerInfo: {
                typeName: '出貨單明細表',
                typeNamePlural: '出貨單明細表'
     }
}

define root view entity ZZ1_PV_TEST23
  as projection on ZZ1_I_TEST23
{
      @UI.facet: [
                    { id:            'ALL',
                      purpose:         #STANDARD,
                      type:            #COLLECTION,
                      label:           '資料',
                      position:        10
                    },
                    { type: #FIELDGROUP_REFERENCE ,
                      label : '表頭資料',
                      targetQualifier: 'head' ,
                      parentId: 'ALL',
                      id: 'DNhead' ,
                      position: 10
                    },
                    { type: #FIELDGROUP_REFERENCE ,
                      label : '明細資料',
                      targetQualifier: 'item' ,
                      parentId: 'ALL' ,
                      id : 'DNitem' ,
                      position: 20
                    }
                ]
      @UI: {
              lineItem: [{ position: 10, importance: #HIGH }],
              selectionField: [{ position: 10 }],
              fieldGroup: [{ qualifier: 'head', position: 10 }]
            }
      @EndUserText.label: '交貨單號'
  key OutboundDelivery,
      @UI: {
              lineItem: [{ position: 20, importance: #HIGH }],
              selectionField: [{ position: 20 }],
              fieldGroup: [{ qualifier: 'head', position: 20 }]
            }
      @EndUserText.label: '交貨明細'
  key OutboundDeliveryItem,
      @UI: {
               lineItem: [{ position: 300 }],
               fieldGroup: [{ qualifier: 'item', position: 300 }],
               hidden: true
             }
      @EndUserText.label: '銷售單位'
      DeliveryQuantityUnit,
      @UI: {
              lineItem: [{ position: 290, importance: #HIGH }],
              fieldGroup: [{ qualifier: 'item', position: 290 }]
            }
      @EndUserText.label: '實際交貨數量'
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      ActualDeliveryQuantity
}
