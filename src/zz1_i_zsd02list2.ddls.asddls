//************************************************************************
//Copyright     : Innatech Co., Ltd.
//Author        : Becca
//Create Date   : 2024/09/25 
//************************************************************************
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@EndUserText.label: '銷售訂單資料明細表'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
//@Metadata.ignorePropagatedAnnotations: true
@UI.presentationVariant: [
  {
    sortOrder: [
      {
        by: 'SalesDocument'
      },
      {
        by: 'SalesDocumentItem'
      }
    ],
    visualizations: [{type: #AS_LINEITEM }]
  }
]

@UI: {
     headerInfo: {
                typeName: '銷售訂單資料明細表',
                typeNamePlural: '銷售訂單資料明細表'
     }
}
define view entity ZZ1_I_ZSD02LIST2 
    with parameters 
        @EndUserText.label: '文件日期-起'
        s_audat_low : budat,
        @EndUserText.label: '文件日期-迄'
        s_audat_high : budat
    as select from ZZ1_I_ZSD02LIST

{
        @UI: {
             lineItem: [{ position: 40, importance: #HIGH  }],
             selectionField: [{ position: 40 }]
             }
        @EndUserText.label: '訂單號碼'
    key SalesDocument,       //vbeln
        @UI: {
          lineItem:       [ { position: 50, importance: #HIGH  } ] }
        @EndUserText.label: '項目'
    key SalesDocumentItem,       //posnr
        @UI: {
          lineItem:       [ { position: 1, importance: #HIGH  } ],
          selectionField: [ { position: 10 } ] }
        @EndUserText.label: '公司代碼'
        BillingCompanyCode,                //bukrs_vf
        @UI: {
          lineItem:       [ { position: 20, importance: #HIGH  } ],
          selectionField: [ { position: 20 } ] }
        @EndUserText.label: '訂單類型'
        SalesDocumentType,                 //auart
        @UI: {
          lineItem:       [ { position: 30, importance: #HIGH  } ] }
        @EndUserText.label: '訂單類型說明'
        SalesDocumentTypeName,            //tvakt-bezei
        @UI: {
          lineItem:       [ { position: 60, importance: #HIGH  } ] }
        @EndUserText.label: '訂單月份'
        ymon,   //ymon S031-SPMON
//        @UI: {
//          lineItem:       [ { position: 70, importance: #HIGH  } ],
//          fieldGroup: [ { qualifier: 'item', position: 10 } ],
//          selectionField: [ { position: 10 } ] }
//        @EndUserText.label: '文件日期'
//        @UI.hidden: true
//        @Consumption.filter: {mandatory: true, selectionType: #INTERVAL, multipleSelections: false }
//        SalesDocumentDate,                 //audat
        @UI: {
          lineItem:       [ { position: 80, importance: #HIGH  } ],
          selectionField: [ { position: 80 } ] }
        @EndUserText.label: '買方'
        SoldToParty,                       //kunnr
        @UI: {
          lineItem:       [ { position: 90, importance: #HIGH  } ] }
        @EndUserText.label: '買方說明'
        OrganizationBPName1,  //kna1-name1
        @UI: {
          lineItem:       [ { position: 100, importance: #HIGH  } ] }
        @EndUserText.label: '幣別'
        TransactionCurrency,               //waerk
        @UI: {
          lineItem:       [ { position: 110, importance: #HIGH  } ] }
        @EndUserText.label: '匯率-會計'
        AccountingExchangeRate,            //kurrf
        @UI: {
          lineItem:       [ { position: 120, importance: #HIGH  } ] }
        @EndUserText.label: '匯率'
        PriceDetnExchangeRate,             //kursk
        @UI: {
          lineItem:       [ { position: 130, importance: #HIGH  } ],
          selectionField: [ { position: 110 } ] }
        @EndUserText.label: '物料號碼'
        Product,                          //matnr
        @UI: {
          lineItem:       [ { position: 140, importance: #HIGH  } ] }
        @EndUserText.label: '物料號碼說明'
        MaterialName,        //makt-maktx  
        @UI: {
          lineItem:       [ { position: 150, importance: #HIGH  } ],
          selectionField: [ { position: 120 } ] }
        @EndUserText.label: '客戶物料號碼'
        MaterialByCustomer,                //kdmat
        @UI: {
          lineItem:       [ { position: 160, importance: #HIGH  } ] }
        @EndUserText.label: '客戶物料號碼說明'
        MaterialDescriptionByCustomer,      //postx KNMT-POSTX
        @UI: {
          lineItem:       [ { position: 170, importance: #HIGH  } ] }
        @EndUserText.label: '物料群組'
        ProductGroup,        //mtype t023-matkl
        @UI: {
          lineItem:       [ { position: 180, importance: #HIGH  } ] }
        @EndUserText.label: '物料群組說明'
        ProductGroupText, //mdesc t023t-wgbez
        @UI: {
          lineItem:       [ { position: 190, importance: #HIGH  } ],
          selectionField: [ { position: 30 } ] }
        @EndUserText.label: '銷售組織'
        SalesOrganization,                 //vkorg 
        @UI: {
          lineItem:       [ { position: 200, importance: #HIGH  } ] }
        @EndUserText.label: '銷售組織說明'
        SalesOrganizationName, //vtext_vkorg  tvkot-vtext
        @UI: {
          lineItem:       [ { position: 210, importance: #HIGH  } ],
          selectionField: [ { position: 40 } ] }
        @EndUserText.label: '通路'
        DistributionChannel,               //vtweg
        @UI: {
          lineItem:       [ { position: 220, importance: #HIGH  } ] }
        @EndUserText.label: '配銷通路說明'
        DistributionChannelName, //vtext_vtweg tvtwt-vtext
        @UI: {
          lineItem:       [ { position: 230, importance: #HIGH  } ],
          selectionField: [ { position: 50 } ] }
        @EndUserText.label: '部門'
        OrganizationDivision,              //spart
        @UI: {
          lineItem:       [ { position: 240, importance: #HIGH  } ] }
        @EndUserText.label: '部門說明'
        DivisionName, //vtext_spart tspat-vtext
        @UI: {
          lineItem:       [ { position: 250, importance: #HIGH  } ],
          selectionField: [ { position: 60 } ] }
        @EndUserText.label: '銷售據點'
        SalesOffice,                       //vkbur
        @UI: {
          lineItem:       [ { position: 260, importance: #HIGH  } ] }
        @EndUserText.label: '銷售據點說明'
        SalesOfficeName, //bezei_vk tvkbt-bezei
        @UI: {
          lineItem:       [ { position: 270, importance: #HIGH  } ] }
        @EndUserText.label: '價格群組'
        CustomerPriceGroup,                //konda KNVV-KONDA
        @UI: {
          lineItem:       [ { position: 280, importance: #HIGH  } ],
          selectionField: [ { position: 130 } ] }
        @EndUserText.label: '客戶群組'
        CustomerGroup,                     //kdgrp
        @UI: {
          lineItem:       [ { position: 290, importance: #HIGH  } ] }
        @EndUserText.label: '客戶群組說明'
        CustomerGroupName,                  //t151t-ktext
        @UI: {
          lineItem:       [ { position: 300, importance: #HIGH  } ] }
        @EndUserText.label: '銷售地區'
        SalesDistrict,                      //bzirk
        @UI: {
          lineItem:       [ { position: 310, importance: #HIGH  } ] }
        @EndUserText.label: '地區名稱'
        SalesDistrictName,                  //bztxt t171t-bztxt
        @UI: {
          lineItem:       [ { position: 320, importance: #HIGH  } ] }
        @EndUserText.label: '訂購數量'
        OrderQuantity,                      //kwmeng
        @UI: {
          lineItem:       [ { position: 330, importance: #HIGH  } ] }
        @EndUserText.label: '銷售單位'
        OrderQuantityUnit,                  //vrkme
        //CWM_KWMENG VBAP-KWMENG
        //CWM_MEINS mara-/cwm/valum
        //UNIT
        @UI: {
          lineItem:       [ { position: 340, importance: #HIGH  } ] }
        @EndUserText.label: '原幣金額'
        NetAmount,                         //netwr
        @UI: {
          lineItem:       [ { position: 350, importance: #HIGH  } ] }
        @EndUserText.label: '本國幣金額'
        netwr_loc,  //netwr_loc VBAP-NETWR
        @UI: {
          lineItem:       [ { position: 360, importance: #HIGH  } ] }
        @EndUserText.label: '含稅本國幣金額'
        netwr_tax,  //netwr_tax VBAP-NETWR
        @UI: {
          lineItem:       [ { position: 370, importance: #HIGH  } ] }
        @EndUserText.label: '稅碼'
        TaxCode,           //prcd_elements-mwsk1
        @UI: {
          lineItem:       [ { position: 380, importance: #HIGH  } ],
          selectionField: [ { position: 150 } ] }
        @EndUserText.label: '銷售人員'
        sales, //sales vbpa-pernr
        @UI: {
          lineItem:       [ { position: 390, importance: #HIGH  } ] }
        @EndUserText.label: '銷售人員名稱'
        cname,  //cname
        @UI: {
          lineItem:       [ { position: 400, importance: #HIGH  } ],
          selectionField: [ { position: 140 } ] }
        @EndUserText.label: '請購單號'
        PurchaseRequisition,         //vbep-banfn
        @UI: {
          lineItem:       [ { position: 410, importance: #HIGH  } ] }
        @EndUserText.label: '請購項目'
        PurchaseRequisitionItem,     //vbep-bnfpo
        @UI: {
          lineItem:       [ { position: 420, importance: #HIGH  } ] }
        @EndUserText.label: '訂貨原因'
        SDDocumentReason,                  //augru
        @UI: {
          lineItem:       [ { position: 430, importance: #HIGH  } ] }
        @EndUserText.label: '訂貨原因說明'
        SDDocumentReasonText,              //bezei_rs tvaut-bezei
        @UI: {
          lineItem:       [ { position: 440, importance: #HIGH  } ],
          selectionField: [ { position: 160 } ] }
        @EndUserText.label: '建立者'
        CreatedByUser,                     //ernam
        @UI: {
          lineItem:       [ { position: 450, importance: #HIGH  } ],
          selectionField: [ { position: 170 } ] }
        @EndUserText.label: '建立日期'
        CreationDate,                      //erdat
        @UI: {
          lineItem:       [ { position: 460, importance: #HIGH  } ] }
        @EndUserText.label: 'ItCa'
        SalesDocumentItemCategory,         //pstyv
        @UI: {
          lineItem:       [ { position: 470, importance: #HIGH  } ] }
        @EndUserText.label: 'ItCa-說明'
        SalesDocumentItemCategoryName,     //vtext2 tvapt-vtext
        @UI: {
          lineItem:       [ { position: 480, importance: #HIGH  } ] }
        @EndUserText.label: '拒收原因'
        SalesDocumentRjcnReason,           //abgru
        @UI: {
          lineItem:       [ { position: 490, importance: #HIGH  } ] }
        @EndUserText.label: '拒收原因說明'
        SalesDocumentRjcnReasonName,       //bezei_ab tvagt-bezei
        @UI: {
          lineItem:       [ { position: 500, importance: #HIGH  } ],
          selectionField: [ { position: 180 } ] }
        @EndUserText.label: '產品階層'
        ProductHierarchyNode,              //prodh
        @UI: {
          lineItem:       [ { position: 510, importance: #HIGH  } ] }
        @EndUserText.label: '產品階層說明'
        SrvcProductHierarchyText,         //p_text t179t-vtext
        @UI: {
          lineItem:       [ { position: 520, importance: #HIGH  } ] }
        @EndUserText.label: '工廠'
        Plant,                             //werks
        @UI: {
          lineItem:       [ { position: 530, importance: #HIGH  } ] }
        @EndUserText.label: '工廠說明'
        PlantName,                  //name2 t001w-name1
        @UI: {
          lineItem:       [ { position: 540, importance: #HIGH  } ] }
        @EndUserText.label: '出貨點'
        ShippingPoint,                     //vstel
        @UI: {
          lineItem:       [ { position: 550, importance: #HIGH  } ] }
        @EndUserText.label: '出貨點說明'
        ShippingPointName,                 //vtex1 tvstt-vtext
        @UI: {
          lineItem:       [ { position: 560, importance: #HIGH  } ] }
        @EndUserText.label: '利潤中心'
        ProfitCenter,                      //prctr
        @UI: {
          lineItem:       [ { position: 570, importance: #HIGH  } ] }
        @EndUserText.label: '付款條件'
        CustomerPaymentTerms,              //zterm
        @UI: {
          lineItem:       [ { position: 580, importance: #HIGH  } ] }
        @EndUserText.label: '付款條件說明'
        CustomerPaymentTermsName,          //ztext tvzbt-vtext
        @UI: {
          lineItem:       [ { position: 590, importance: #HIGH  } ] }
        @EndUserText.label: '國貿條件'
        IncotermsClassification,           //inco1
        @UI: {
          lineItem:       [ { position: 600, importance: #HIGH  } ] }
        @EndUserText.label: '國貿條件說明'
        IncotermsTransferLocation,         //inco2
        @UI: {
          lineItem:       [ { position: 610, importance: #HIGH  } ] }
        @EndUserText.label: '已輸入物料'
        OriginallyRequestedMaterial,       //matwa  vbap-matwa
        @UI: {
          lineItem:       [ { position: 620, importance: #HIGH  } ] }
        @EndUserText.label: '已輸入物料說明'
        matwa_maktx,                       //matwa_maktx VBKD-INCO2 //makt.ProductName as matwa_maktx
        //bstnk vbak-bstnk
        @UI: {
          lineItem:       [ { position: 630, importance: #HIGH  } ] }
        @EndUserText.label: 'EC客戶代號'
        YY1_ECKUNNR_SDH,
        @UI: {
          lineItem:       [ { position: 640, importance: #HIGH  } ] }
        @EndUserText.label: '統一編號'
        YY1_Vatno_SDH,
        @UI: {
          lineItem:       [ { position: 650, importance: #HIGH  } ] }
        @EndUserText.label: '優惠代碼'
        YY1_EC_MEMO1_SDH,
        @UI: {
          lineItem:       [ { position: 660, importance: #HIGH  } ] }
        @EndUserText.label: '電子發票號碼'
        YY1_TW_GUINO_SDH,
        @UI: {
          lineItem:       [ { position: 670, importance: #HIGH  } ] }
        @EndUserText.label: '發票註記'
        AdditionalCustomerGroup1,          //kvgr1
        @UI: {
          lineItem:       [ { position: 680, importance: #HIGH  } ] }
        @EndUserText.label: '發票註記(說明)'
        AdditionalCustomerGroup1Name,  //tkvgr1 tvv1t-bezei
        @UI: {
          lineItem:       [ { position: 690, importance: #HIGH  } ] }
        @EndUserText.label: '電子發票類別'
        AdditionalCustomerGroup2,          //kvgr2
        @UI: {
          lineItem:       [ { position: 700, importance: #HIGH  } ] }
        @EndUserText.label: '電子發票類別(說明)'
        AdditionalCustomerGroup2Name,  //tkvgr2 tvv2t-bezei
        @UI: {
          lineItem:       [ { position: 710, importance: #HIGH  } ] }
        @EndUserText.label: '運送方式'
        AdditionalCustomerGroup3,          //kvgr3
        @UI: {
          lineItem:       [ { position: 720, importance: #HIGH  } ] }
        @EndUserText.label: '運送方式(說明)'
        AdditionalCustomerGroup3Name,  //tkvgr3 tvv3t-bezei
        @UI: {
          lineItem:       [ { position: 730, importance: #HIGH  } ] }
        @EndUserText.label: '申請運費碼'
        AdditionalCustomerGroup4,          //kvgr4
        @UI: {
          lineItem:       [ { position: 740, importance: #HIGH  } ] }
        @EndUserText.label: '申請運費碼(說明)'
        AdditionalCustomerGroup4Name,  //tkvgr4 tvv4t-bezei
        @UI: {
          lineItem:       [ { position: 750, importance: #HIGH  } ] }
        @EndUserText.label: '發票列印抬頭'
        AdditionalCustomerGroup5,          //kvgr5
        @UI: {
          lineItem:       [ { position: 760, importance: #HIGH  } ] }
        @EndUserText.label: '發票列印抬頭(說明)'
        AdditionalCustomerGroup5Name,  //tkvgr5 tvv5t-bezei

        @UI: {
             selectionField: [{ position: 90 }]
           }
        @EndUserText.label: '客戶採購單號'  
        PurchaseOrderByCustomer,
        @UI: {
             selectionField: [{ position: 190 }]
           }
        @EndUserText.label: '強制結案資料'  
        closedata
        
        //vbkd-kdkg1
        //tvkggt-vtext
        //vbkd-kdkg2
        //tvkggt-vtext
        //vbkd-kdkg3
        //tvkggt-vtext
        //vbkd-kdkg4
        //tvkggt-vtext
        //vbkd-kdkg5
        //tvkggt-vtext
          
}
where SalesDocumentDate between $parameters.s_audat_low and $parameters.s_audat_high
group by SalesDocument, SalesDocumentItem, BillingCompanyCode, SalesDocumentType, SalesDocumentTypeName,  ymon, SoldToParty, OrganizationBPName1,
         TransactionCurrency, AccountingExchangeRate, PriceDetnExchangeRate, Product, MaterialName, MaterialByCustomer, MaterialDescriptionByCustomer,
         ProductGroup, ProductGroupText, SalesOrganization, SalesOrganizationName, DistributionChannel, DistributionChannelName, OrganizationDivision,              //spart
         DivisionName, SalesOffice, SalesOfficeName, CustomerPriceGroup, CustomerGroup, CustomerGroupName, SalesDistrict, SalesDistrictName, OrderQuantity,                      //kwmeng
         OrderQuantityUnit, NetAmount, netwr_loc, netwr_tax, TaxCode, sales, cname,  PurchaseRequisition, PurchaseRequisitionItem, SDDocumentReason, 
         SDDocumentReasonText, CreatedByUser, CreationDate, SalesDocumentItemCategory, SalesDocumentItemCategoryName, SalesDocumentRjcnReason,
         SalesDocumentRjcnReasonName, ProductHierarchyNode, SrvcProductHierarchyText, Plant, PlantName, ShippingPoint, ShippingPointName, ProfitCenter,
         CustomerPaymentTerms, CustomerPaymentTermsName, IncotermsClassification, IncotermsTransferLocation, OriginallyRequestedMaterial, matwa_maktx, 
         YY1_ECKUNNR_SDH, YY1_Vatno_SDH, YY1_EC_MEMO1_SDH, YY1_TW_GUINO_SDH, AdditionalCustomerGroup1, AdditionalCustomerGroup1Name, AdditionalCustomerGroup2, 
         AdditionalCustomerGroup2Name, AdditionalCustomerGroup3, AdditionalCustomerGroup3Name, AdditionalCustomerGroup4, AdditionalCustomerGroup4Name,  
         AdditionalCustomerGroup5, AdditionalCustomerGroup5Name, PurchaseOrderByCustomer, closedata ;
