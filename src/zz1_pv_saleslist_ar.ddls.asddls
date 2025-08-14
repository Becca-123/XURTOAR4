@Search.searchable: true
@Metadata.allowExtensions: true

@UI.presentationVariant: [
  {
    sortOrder: [
      {
        by: 'SalesOrganization'
      },
      {
        by: 'BillingDocumentDate'
      },
      {
        by: 'BillingDocument'
      },
      {
        by: 'BillingDocumentItem'
      }
    ],
    visualizations: [{type: #AS_LINEITEM }]
  }
]

@UI: {
     headerInfo: {
                typeName: '銷售交易明細表-AR',
                typeNamePlural: '銷售交易明細表-AR'
     }
}
define root view entity ZZ1_PV_SALESLIST_AR as projection on ZZ1_I_SALESLIST_AR2
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
             lineItem: [{ position: 40, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 40 }],
             selectionField: [{ position: 40 }]
           }
      @EndUserText.label: '請款文件'
      key BillingDocument,
      @UI: {
             lineItem: [{ position: 150, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 150 }]
           }
      @EndUserText.label: '請款文件項目'
      key BillingDocumentItem,
      @UI: {
             lineItem: [{ position: 10 }],
             fieldGroup: [{ qualifier: 'head', position: 10 }],
             selectionField: [{ position: 10 }]
           }
      @EndUserText.label: '銷售組織'
      SalesOrganization,
      @UI: {
             lineItem: [{ position: 11 }],
             fieldGroup: [{ qualifier: 'head', position: 11 }],
             hidden: true
           }
      @EndUserText.label: '銷售組織說明'      
      SalesOrganizationName,
      @UI: {
             lineItem: [{ position: 12 }],
             fieldGroup: [{ qualifier: 'item', position: 12 }],
             selectionField: [{ position: 12 }]
           }
      @EndUserText.label: '配銷通路'
      DistributionChannel,
      @UI: {
             lineItem: [{ position: 13 }],
             fieldGroup: [{ qualifier: 'item', position: 13 }],
             hidden: true
           }
      @EndUserText.label: '配銷通路說明'
      DistributionChannelName,
      @UI: {
             lineItem: [{ position: 14 }],
             fieldGroup: [{ qualifier: 'item', position: 14 }],
             selectionField: [{ position: 14 }]
           }
      @EndUserText.label: '部門'
      Division,
      @UI: {
             lineItem: [{ position: 15 }],
             fieldGroup: [{ qualifier: 'item', position: 15 }],
             hidden: true
           }
      @EndUserText.label: '部門說明'
      DivisionName,
      @UI: {
             lineItem: [{ position: 20, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 20 }],
             selectionField: [{ position: 20 }]
           }
      @EndUserText.label: '請款類型'
      BillingDocumentType,
      @UI: {
             lineItem: [{ position: 30, importance: #HIGH }],
             fieldGroup: [{ qualifier: 'head', position: 30 }],
             selectionField: [{ position: 30 }]
           }
      @Consumption.filter: { selectionType :#RANGE }     
      @EndUserText.label: '請款日期'
      BillingDocumentDate,
      @UI: {
             lineItem: [{ position: 60 }],
             fieldGroup: [{ qualifier: 'head', position: 60 }]
           }
      @EndUserText.label: '是否迴轉'
      BillingDocumentIsCancelled,
      @UI: {
             lineItem: [{ position: 61 }],
             fieldGroup: [{ qualifier: 'head', position: 61 }]
           }
      @EndUserText.label: '迴轉的請款文件'
      CancelledBillingDocument,
      @UI: {
             lineItem: [{ position: 70 }],
             fieldGroup: [{ qualifier: 'head', position: 70 }],
             selectionField: [{ position: 70 }]
           }
      @EndUserText.label: '參考/台灣發票號碼'      
      BillingDocumentXblnr,
      
      @UI: {
             lineItem: [{ position: 71 }],
             fieldGroup: [{ qualifier: 'head', position: 71 }],
             selectionField: [{ position: 71 }]
           }
      @EndUserText.label: '台灣發票號碼'      
      BillingDocumentXblnrnew,

      @UI: {
             lineItem: [{ position: 72 }],
             fieldGroup: [{ qualifier: 'head', position: 72 }],
             selectionField: [{ position: 72 }]
           }
      @EndUserText.label: '發票日期'      
      invoicedate,
              
      @UI: {
             lineItem: [{ position: 73 }],
             fieldGroup: [{ qualifier: 'head', position: 73 }],
             selectionField: [{ position: 73 }]
           }
      @EndUserText.label: '客戶稅分類'      
      CustomerTaxClassification1  ,
      @UI: {
             lineItem: [{ position: 74 }],
             fieldGroup: [{ qualifier: 'head', position: 74 }],
             selectionField: [{ position: 74 }]
           }
      @EndUserText.label: '稅碼'      
      TaxCode,
      @UI: {
             lineItem: [{ position: 80 }],
             fieldGroup: [{ qualifier: 'head', position: 80 }]
           }
      @EndUserText.label: '銷售據點'      
      BusinessPlace,
      @UI: {
             lineItem: [{ position: 90 }],
             fieldGroup: [{ qualifier: 'head', position: 90 }]
           }
      @EndUserText.label: '幣別'      
      TransactionCurrency,
      @UI: {
             lineItem: [{ position: 100 }],
             fieldGroup: [{ qualifier: 'head', position: 100 }]
           }
      @EndUserText.label: '匯率'      
      AccountingExchangeRate,
      @UI: {
             lineItem: [{ position: 101 }],
             fieldGroup: [{ qualifier: 'head', position: 101 }],
             selectionField: [{ position: 101 }]
           }
      @EndUserText.label: '買方'      
      Customer_ag,
      @UI: {
             lineItem: [{ position: 102 }],
             fieldGroup: [{ qualifier: 'head', position: 102 }]
           }
      @EndUserText.label: '買方名稱'      
      CustomerName_ag,
      @UI: {
             lineItem: [{ position: 103 }],
             fieldGroup: [{ qualifier: 'head', position: 103 }]
           }
      @EndUserText.label: '買方客代統編'      
      TaxNumber1_ag,
      @UI: {
             lineItem: [{ position: 110 }],
             fieldGroup: [{ qualifier: 'head', position: 110 }],
             selectionField: [{ position: 110 }]
           }
      @EndUserText.label: '付款方'      
      PayerParty,
      @UI: {
             lineItem: [{ position: 120 }],
             fieldGroup: [{ qualifier: 'head', position: 120 }]
           }
      @EndUserText.label: '付款方名稱'      
      CustomerName,
      
      @UI: {
             lineItem: [{ position: 130 }],
             fieldGroup: [{ qualifier: 'head', position: 130 }],
             selectionField: [{ position: 130 }]
           }
      @EndUserText.label: '業務員'      
      PersonWorkAgreement,
      @UI: {
             lineItem: [{ position: 140 }],
             fieldGroup: [{ qualifier: 'head', position: 140 }]
           }
      @EndUserText.label: '業務員名稱'      
      CustomerName_ZM,
      
      @UI: {
             lineItem: [{ position: 160 }],
             fieldGroup: [{ qualifier: 'head', position: 160 }],
             selectionField: [{ position: 160 }]
           }
      @EndUserText.label: '物料'      
      Product,
      @UI: {
             lineItem: [{ position: 170 }],
             fieldGroup: [{ qualifier: 'head', position: 170 }]
           }
      @EndUserText.label: '物料說明'      
      ProductName,
      @UI: {
             lineItem: [{ position: 171 }],
             fieldGroup: [{ qualifier: 'head', position: 171 }],
             selectionField: [{ position: 171 }]
           }
      @EndUserText.label: '下階'  
      combination,
      @UI: {
             lineItem: [{ position: 180 }],
             fieldGroup: [{ qualifier: 'head', position: 180 }]
           }
      @EndUserText.label: '請款數量'      
      zzqty,
      //BillingQuantity,
      @UI: {
             lineItem: [{ position: 190 }],
             fieldGroup: [{ qualifier: 'head', position: 190 }]
           }
      @EndUserText.label: '單位'      
      BillingQuantityUnit,
      @UI: {
             lineItem: [{ position: 200 }],
             fieldGroup: [{ qualifier: 'head', position: 200 }]

           }
      @EndUserText.label: '單價'      
      unit_price,
      @UI: {
             lineItem: [{ position: 210 }],
             fieldGroup: [{ qualifier: 'head', position: 210 }]
           }
      @EndUserText.label: '未稅金額'      
      NetAmount,
      @UI: {
             lineItem: [{ position: 220 }],
             fieldGroup: [{ qualifier: 'head', position: 220 }]
           }
      @EndUserText.label: '稅額'      
      TaxAmount,
      @UI: {
             lineItem: [{ position: 230 }],
             fieldGroup: [{ qualifier: 'head', position: 230 }]
           }
      @EndUserText.label: '含稅總額'      
      TotalAmount,
      @UI: {
             lineItem: [{ position: 231 }],
             fieldGroup: [{ qualifier: 'head', position: 231 }]
           }
      @EndUserText.label: '未稅金額(本國幣)'      
      AmountInCompanyCodeCurrency,
      @UI: {
             lineItem: [{ position: 232 }],
             fieldGroup: [{ qualifier: 'head', position: 232 }]
           }
      @EndUserText.label: '稅額(本國幣)'      
      TaxAmountInCompanyCodeCurrency,
      @UI: {
             lineItem: [{ position: 233 }],
             fieldGroup: [{ qualifier: 'head', position: 233 }]
           }
      @EndUserText.label: '含稅金額(本國幣)'      
      AllAmountInCompanyCodeCurrency,
      @UI: {
             lineItem: [{ position: 234 }],
             fieldGroup: [{ qualifier: 'head', position: 234 }]
           }
      @EndUserText.label: '公司幣別'      
      CompanyCodeCurrency,
      @UI: {
             lineItem: [{ position: 240 }],
             fieldGroup: [{ qualifier: 'head', position: 240 }],
             selectionField: [{ position: 240 }]
           }
      @EndUserText.label: '物料群組'      
      ProductGroup,
      @UI: {
             lineItem: [{ position: 250 }],
             fieldGroup: [{ qualifier: 'head', position: 250 }]
           }
      @EndUserText.label: '物料群組說明'      
      ProductGroupText,
      @UI: {
             lineItem: [{ position: 260 }],
             fieldGroup: [{ qualifier: 'head', position: 260 }],
             selectionField: [{ position: 260 }]
           }
      @EndUserText.label: '來源訂單別'      
      SalesDocumentType,
      @UI: {
             lineItem: [{ position: 270 }],
             fieldGroup: [{ qualifier: 'head', position: 270 }]
           }
      @EndUserText.label: '來源訂單別說明'      
      SalesDocumentTypeName,
      @UI: {
             lineItem: [{ position: 271 }],
             fieldGroup: [{ qualifier: 'head', position: 271 }],
             selectionField: [{ position: 271 }]
           }
      @EndUserText.label: '應收傳票號碼'      
      AccountingDocument,
      @UI: {
             lineItem: [{ position: 280 }],
             fieldGroup: [{ qualifier: 'head', position: 280 }]
           }
      @EndUserText.label: '來源訂單單號'      
      SalesDocument,
      @UI: {
             lineItem: [{ position: 290 }],
             fieldGroup: [{ qualifier: 'head', position: 290 }]
           }
      @EndUserText.label: '來源訂單單號項目'      
      SalesDocumentItem,
      @UI: {
             lineItem: [{ position: 291 }],
             fieldGroup: [{ qualifier: 'head', position: 291 }]
           }
      @EndUserText.label: '原始訂單單號'
      originalSalesDocument,
      @UI: {
             lineItem: [{ position: 292 }],
             fieldGroup: [{ qualifier: 'head', position: 292 }]
           }
      @EndUserText.label: '原始訂單單號項目'
      originalSalesDocumentitem,
      
      @UI: {
             lineItem: [{ position: 293 }],
             fieldGroup: [{ qualifier: 'head', position: 293 }]
           }
      @EndUserText.label: '來源出貨單單號'      
      Delivery,
      @UI: {
             lineItem: [{ position: 294 }],
             fieldGroup: [{ qualifier: 'head', position: 294 }]
           }
      @EndUserText.label: '來源出貨單單號項目'      
      DeliveryItem,
      @UI: {
             lineItem: [{ position: 300 }],
             fieldGroup: [{ qualifier: 'head', position: 300 }]

          }
      @EndUserText.label: '買方-客戶群組'      
      CustomerGroup,
      @UI: {
             lineItem: [{ position: 310 }],
            fieldGroup: [{ qualifier: 'head', position: 310 }]
           }
      @EndUserText.label: '買方-客戶群組說明'      
      CustomerGroupName,
      @UI: {
             lineItem: [{ position: 320 }],
             fieldGroup: [{ qualifier: 'head', position: 320 }]
           }
      @EndUserText.label: '買方-客戶群組1'      
      AdditionalCustomerGroup1,
      @UI: {
             lineItem: [{ position: 330 }],
             fieldGroup: [{ qualifier: 'head', position: 330 }]
           }
      @EndUserText.label: '買方-客戶群組1說明'      
      AdditionalCustomerGroup1Name,
      @UI: {
             lineItem: [{ position: 340 }],
             fieldGroup: [{ qualifier: 'head', position: 340 }]             
           }
      @EndUserText.label: '買方-客戶群組2'      
      AdditionalCustomerGroup2,
      @UI: {
             lineItem: [{ position: 350 }],
             fieldGroup: [{ qualifier: 'head', position: 350 }]
           }
      @EndUserText.label: '買方-客戶群組2說明'      
      AdditionalCustomerGroup2Name,
      @UI: {
             lineItem: [{ position: 360 }],
             fieldGroup: [{ qualifier: 'head', position: 360 }]
           }
      @EndUserText.label: '買方-客戶群組3'      
      AdditionalCustomerGroup3,
      @UI: {
             lineItem: [{ position: 370 }],
             fieldGroup: [{ qualifier: 'head', position: 370 }]
           }
      @EndUserText.label: '買方-客戶群組3說明'      
      AdditionalCustomerGroup3Name,
      @UI: {
             lineItem: [{ position: 380 }],
             fieldGroup: [{ qualifier: 'head', position: 380 }]
           }
      @EndUserText.label: '買方-客戶群組4'      
      AdditionalCustomerGroup4,
      @UI: {
             lineItem: [{ position: 390 }],
             fieldGroup: [{ qualifier: 'head', position: 390 }]
           }
      @EndUserText.label: '買方-客戶群組4說明'      
      AdditionalCustomerGroup4Name,
      @UI: {
             lineItem: [{ position: 400 }],
             fieldGroup: [{ qualifier: 'head', position: 400 }]
           }
      @EndUserText.label: '買方-客戶群組5'      
      AdditionalCustomerGroup5,
      @UI: {
             lineItem: [{ position: 410 }],
             fieldGroup: [{ qualifier: 'head', position: 410 }]
           }
      @EndUserText.label: '買方-客戶群組5說明'      
      AdditionalCustomerGroup5Name,
      @UI: {
             lineItem: [{ position: 411 }],
             fieldGroup: [{ qualifier: 'head', position: 411 }],
             selectionField: [{ position: 110 }]
           }
      @EndUserText.label: '已取消'      
      BillingDocumentItemIsCancelled,
      @UI: {
             lineItem: [{ position: 420 }],
             fieldGroup: [{ qualifier: 'head', position: 420 }]
           }
      @EndUserText.label: '客戶參考'      
      PurchaseOrderByCustomer,
      @UI: {
             lineItem: [{ position: 430 }],
             fieldGroup: [{ qualifier: 'item', position: 430 }]
           }
      @EndUserText.label: '訂單-EC客代'      
      YY1_ECKUNNR_SDH,
      @UI: {
             lineItem: [{ position: 440 }],
             fieldGroup: [{ qualifier: 'head', position: 440 }]
           }
      @EndUserText.label: '訂單-統一編號'      
      YY1_Vatno_SDH,
      @UI: {
             lineItem: [{ position: 441 }],
             fieldGroup: [{ qualifier: 'head', position: 441 }]
           }
      @EndUserText.label: '外部發票日期'      
      YY1_date_BDH,
      @UI: {
             lineItem: [{ position: 450 }],
             fieldGroup: [{ qualifier: 'head', position: 450 }]
           }
      @EndUserText.label: '收貨方'      
      Customer_WE,
      @UI: {
             lineItem: [{ position: 460 }],
             fieldGroup: [{ qualifier: 'head', position: 460 }]
           }
      @EndUserText.label: '收貨方名稱'      
      CustomerName_WE,
      @UI: {
             lineItem: [{ position: 470 }],
             fieldGroup: [{ qualifier: 'head', position: 470 }]
           }
      @EndUserText.label: '發票收受人'      
      Customer_RE,
      @UI: {
             lineItem: [{ position: 480 }],
             fieldGroup: [{ qualifier: 'head', position: 480 }]
           }
      @EndUserText.label: '發票收受人名稱'      
       CustomerName_RE,
      @UI: {
             lineItem: [{ position: 481 }],
             fieldGroup: [{ qualifier: 'head', position: 481 }]
           }
      @EndUserText.label: '發票收受人客代統編'      
       TaxNumber1_re, 
      @UI: {
             lineItem: [{ position: 490 }],
             fieldGroup: [{ qualifier: 'head', position: 490 }],
             selectionField: [{ position: 111 }]
           }
      @EndUserText.label: '上線客戶代號'      
       Customer_AA,
      @UI: {
             lineItem: [{ position: 500 }],
             fieldGroup: [{ qualifier: 'head', position: 500 }]
           }
      @EndUserText.label: '上線客戶名稱'      
       CustomerName_AA,
      @UI: {
             //lineItem: [{ position: 510 }],
             //fieldGroup: [{ qualifier: 'head', position: 490 }],
             selectionField: [{ position: 510 }]
             //hidden: true
           }
      @EndUserText.label: '請款文件狀態'      
      OverallBillingStatus
      
      
      
}
