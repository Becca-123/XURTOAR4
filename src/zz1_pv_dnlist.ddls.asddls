@EndUserText.label: '出貨單明細表Projection view'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Search.searchable: true
//@Analytics.query: true//@Analytics.query: true
@UI: {
     headerInfo: {
                typeName: '出貨單明細表',
                typeNamePlural: '出貨單明細表'
     }
}

define root view entity ZZ1_PV_DNList
  as projection on ZZ1_I_DNLIST2
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
             fieldGroup: [{ qualifier: 'item', position: 20 }]
           }
      @EndUserText.label: '項次'
  key OutboundDeliveryItem,
      @UI: {
             lineItem: [{ position: 21, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 21 }]
           }
      @EndUserText.label: '上層項次'
      HigherLvlItmOfBatSpltItm,
      @UI: {
             lineItem: [{ position: 30, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 30 }],
             selectionField: [{ position: 30 }]
           }
      @EndUserText.label: '交貨類型'
      DeliveryDocumentType,
      @UI: {
             lineItem: [{ position: 40 }],
             fieldGroup: [{ qualifier: 'head', position: 40 }],
             hidden: true
           }
      @EndUserText.label: '交貨類型說明'
      DeliveryDocumentTypeName,
      @UI: {
             lineItem: [{ position: 50 }],
             fieldGroup: [{ qualifier: 'head', position: 50 }],
             selectionField: [{ position: 50 }]
           }
      @EndUserText.label: '銷售組織'
      SalesOrganization,
      @UI: {
             lineItem: [{ position: 60 }],
             fieldGroup: [{ qualifier: 'head', position: 60 }],
             hidden: true
           }
      @EndUserText.label: '銷售組織說明'
      SalesOrganizationName,
      @UI: {
             lineItem: [{ position: 61 }],
             fieldGroup: [{ qualifier: 'item', position: 61 }],
             selectionField: [{ position: 61 }]
           }
      @EndUserText.label: '配銷通路'
      DistributionChannel,
      @UI: {
             lineItem: [{ position: 62 }],
             fieldGroup: [{ qualifier: 'item', position: 62 }],
             hidden: true
           }
      @EndUserText.label: '配銷通路說明'
      DistributionChannelName,
      @UI: {
             lineItem: [{ position: 63 }],
             fieldGroup: [{ qualifier: 'item', position: 63 }],
             selectionField: [{ position: 63 }]
           }
      @EndUserText.label: '部門'
      Division,
      @UI: {
             lineItem: [{ position: 64 }],
             fieldGroup: [{ qualifier: 'item', position: 64 }],
             hidden: true
           }
      @EndUserText.label: '部門說明'
      DivisionName,

      @UI: {
             lineItem: [{ position: 70, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 70 }],
             selectionField: [{ position: 70 }]
           }
      @Consumption.filter: { selectionType :#RANGE }
      @EndUserText.label: '交貨日期'
      DeliveryDate,
      @UI: {
             lineItem: [{ position: 71, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 71 }],
             selectionField: [{ position: 71 }]
           }
      @Consumption.filter: { selectionType :#RANGE }
      @EndUserText.label: '實際發貨過帳日'
      ActualGoodsMovementDate,
      @UI: {
             lineItem: [{ position: 72, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 72 }],
             selectionField: [{ position: 72 }]
           }
      @EndUserText.label: '發貨狀態'
      OverallGoodsMovementStatus,
      @UI: {
             lineItem: [{ position: 80, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 80 }],
             selectionField: [{ position: 80 }]
           }
      @EndUserText.label: '收貨人'
      Customer_we,
      @UI: {
             lineItem: [{ position: 90, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 90 }],
             hidden: true
           }
      @EndUserText.label: '收貨人名稱'
      CustomerName_we,
      //      @UI: {
      //             lineItem: [{ position: 100 }],
      //             fieldGroup: [{ qualifier: 'head', position: 100 }]
      //           }
      //      @EndUserText.label: '收貨人城市'
      //      CityName_we,
      @UI: {
             lineItem: [{ position: 110 }],
             fieldGroup: [{ qualifier: 'head', position: 110 }]
           }
      @EndUserText.label: '收貨人郵遞區號'
      PostalCode_we,
      @UI: {
             lineItem: [{ position: 120 }],
             fieldGroup: [{ qualifier: 'head', position: 120 }]
           }
      @EndUserText.label: '收貨人街道'
      StreetName_we,
      @UI: {
             lineItem: [{ position: 130 }],
             fieldGroup: [{ qualifier: 'head', position: 130 }]
           }
      @EndUserText.label: '收貨人電話'
      TelephoneNumber1_we,
      @UI: {
             lineItem: [{ position: 131 }],
             fieldGroup: [{ qualifier: 'head', position: 131 }]
           }
      @EndUserText.label: '收貨人手機'
      mobilephoneNumber1_we,
      @UI: {
             lineItem: [{ position: 140 }],
             fieldGroup: [{ qualifier: 'head', position: 140 }],
             selectionField: [{ position: 140 }]
           }
      @EndUserText.label: '買方'
      Customer_ag,
      @UI: {
             lineItem: [{ position: 150 }],
             fieldGroup: [{ qualifier: 'head', position: 150 }],
             hidden: true
           }
      @EndUserText.label: '買方名稱'
      CustomerName_ag,
      @UI: {
             lineItem: [{ position: 151 }],
             fieldGroup: [{ qualifier: 'head', position: 151 }]
           }
      @EndUserText.label: '付款方'
      Customer_rg,
      @UI: {
             lineItem: [{ position: 152 }],
             fieldGroup: [{ qualifier: 'head', position: 152 }],
             hidden: true
           }
      @EndUserText.label: '付款方名稱'
      CustomerName_rg,
      @UI: {
             lineItem: [{ position: 160, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 160 }]
           }
      @EndUserText.label: '出貨點'
      SHIPPINGPOINT,
      @UI: {
             lineItem: [{ position: 170 }],
             fieldGroup: [{ qualifier: 'head', position: 170 }],
             hidden: true
           }
      @EndUserText.label: '出貨點名稱'
      ShippingPointName,
      @UI: {
             lineItem: [{ position: 180, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 180 }]
           }
      @EndUserText.label: '工廠'
      Plant,
      @UI: {
             lineItem: [{ position: 190 }],
             fieldGroup: [{ qualifier: 'item', position: 190 }],
             hidden: true
           }
      @EndUserText.label: '工廠名稱'
      PlantName,
      @UI: {
             lineItem: [{ position: 200, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 200 }]
           }
      @EndUserText.label: '儲存地點'
      StorageLocation,
      @UI: {
             lineItem: [{ position: 210 }],
             fieldGroup: [{ qualifier: 'item', position: 210 }],
             hidden: true
           }
      @EndUserText.label: '儲存地點名稱'
      StorageLocationName,
      @UI: {
             lineItem: [{ position: 220, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 220 }],
             selectionField: [{ position: 220 }]
           }
      @EndUserText.label: '批次'
      Batch,
      @UI: {
             lineItem: [{ position: 230 }],
             fieldGroup: [{ qualifier: 'item', position: 230 }]
           }
      @EndUserText.label: '是否為批次管理'
      IsBatchManagementRequired,
      @UI: {
             lineItem: [{ position: 240, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 240 }],
             selectionField: [{ position: 240 }]
           }
      @EndUserText.label: '產品'
      Product,
      @UI: {
             lineItem: [{ position: 250 }],
             fieldGroup: [{ qualifier: 'item', position: 250 }],
             hidden: true
           }
      @EndUserText.label: '產品名稱'
      ProductName,
      @UI: {
             lineItem: [{ position: 260 }],
             fieldGroup: [{ qualifier: 'item', position: 260 }]
           }
      @EndUserText.label: '實際交貨數量(基礎單位)'      
      ActualDeliveredQtyInBaseUnit,
      @UI: {
             lineItem: [{ position: 270 }],
             fieldGroup: [{ qualifier: 'item', position: 270 }],
             hidden: true
           }
      @EndUserText.label: '基礎單位'
      BaseUnit,
      @UI: {
             lineItem: [{ position: 280 }],
             fieldGroup: [{ qualifier: 'item', position: 280 }]
           }
      @EndUserText.label: '基礎單位說明'
      BaseUnitName,
      @UI: {
             lineItem: [{ position: 290, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 290 }]
           }
      @EndUserText.label: '實際交貨數量' 
            
      ActualDeliveryQuantity,
      @UI: {
             lineItem: [{ position: 300 }],
             fieldGroup: [{ qualifier: 'item', position: 300 }],
             hidden: true
           }
      @EndUserText.label: '銷售單位'
      DeliveryQuantityUnit,
      @UI: {
             lineItem: [{ position: 310, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 310 }]
           }
      @EndUserText.label: '銷售單位說明'
      DeliveryQuantityUnitName,
      @UI: {
             lineItem: [{ position: 311 }],
             fieldGroup: [{ qualifier: 'head', position: 311 }]
           }
      @EndUserText.label: '客戶參考(EC單號)'
      PurchaseOrderByCustomer,
      @UI: {
             lineItem: [{ position: 312, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 312 }],
             hidden: true
           }
      @EndUserText.label: '訂單金額'
      TotalAmount,
      @UI: {
             //lineItem: [{ position: 312, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'item', position: 312 }],
             hidden:true
           }
      @EndUserText.label: '幣別'
      TransactionCurrency,

      @UI: {
             lineItem: [{ position: 320, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 320 }]
           }
      @EndUserText.label: '出貨指示'
      tx03,
      @UI: {
             lineItem: [{ position: 330, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 330 }]
           }
      @EndUserText.label: '客戶的出貨通知'
      tx04,
      @UI: {
             lineItem: [{ position: 340, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 340 }]
           }
      @EndUserText.label: '撿貨/包裝指示'
      tx07,
      @UI: {
             lineItem: [{ position: 350, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 350 }]
           }
      @EndUserText.label: '來自客戶的出貨指示'
      tx13,
      @UI: {
             lineItem: [{ position: 360, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 360 }]
           }
      @EndUserText.label: '來自客戶的出貨註記'
      tx14,
      @UI: {
             lineItem: [{ position: 370, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 370 }]
           }
      @EndUserText.label: '來自客戶的撿貨/包裝指示'
      tx17

      //      @UI: {
      //             hidden: true
      //           }
      //      BSItem
}
