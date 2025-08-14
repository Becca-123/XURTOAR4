CLASS zz1_cl_solist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "INTERFACES if_oo_adt_classrun.
    INTERFACES if_sadl_exit_calc_element_read.
    INTERFACES if_amdp_marker_hdb.


    CLASS-METHODS exec_vbep FOR TABLE FUNCTION zz1_tf_vbep.
    CLASS-METHODS exec_konv FOR TABLE FUNCTION zz1_tf_konv.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZZ1_CL_SOLIST IMPLEMENTATION.


  METHOD exec_konv
  BY DATABASE FUNCTION FOR HDB
     LANGUAGE SQLSCRIPT
     OPTIONS READ-ONLY
     USING i_salesdocitempricingelement.

    lt_konv =
    select mandt as client, salesdocument, salesdocumentitem,
           conditiontype, conditionratevalue,  conditioncurrency, conditionquantity, conditionamount, transactioncurrency,
           rank ( ) over ( PARTITION BY salesdocument, salesdocumentitem, conditiontype ORDER BY pricingprocedurecounter ) AS rank
      from i_salesdocitempricingelement
      WHERE mandt = :client and  conditioninactivereason = '';

    RETURN
     select client, salesdocument, salesdocumentitem,
       conditiontype, conditionratevalue,  conditioncurrency, conditionquantity, conditionamount, transactioncurrency
       FROM :lt_konv
      WHERE rank = 1;
  ENDMETHOD.


  METHOD exec_vbep
  BY DATABASE FUNCTION FOR HDB
     LANGUAGE SQLSCRIPT
     OPTIONS READ-ONLY
     USING i_salesdocumentscheduleline i_salesdocument.

    lt_vbep =
    select mandt as client, salesdocument, salesdocumentitem, purchaserequisition, purchaserequisitionitem,
           rank ( ) over ( PARTITION BY salesdocument, salesdocumentitem ORDER BY purchaserequisition desc ) AS rank
      from i_salesdocumentscheduleline
      WHERE mandt = :client and purchaserequisition <> '';

    lt_vbak =
    select mandt as client, salesdocument
      from i_salesdocument
      WHERE mandt = :client ;

    RETURN
     select client, salesdocument, salesdocumentitem, purchaserequisition, purchaserequisitionitem
       FROM :lt_vbep
      WHERE rank = 1;

    RETURN
     select client, salesdocument, salesdocumentitem, purchaserequisition, purchaserequisitionitem
       FROM :lt_vbep
      WHERE rank = 1;


  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: lwa_element TYPE string.
    DATA: lwa_data TYPE zz1_i_solist,
          lt_data  TYPE STANDARD TABLE OF zz1_i_solist.

    DATA: lt_text_data TYPE TABLE FOR READ RESULT i_salesordertp\\salesordertext.
    DATA: lwa_text_data LIKE LINE OF lt_text_data .

    lt_data = CORRESPONDING #( it_original_data ).
    LOOP AT lt_data INTO lwa_data.
      CLEAR lt_text_data[].
      READ ENTITIES OF i_salesordertp
          ENTITY salesordertext
            FROM VALUE #( ( %key = VALUE #( salesorder      = lwa_data-salesdocument
                                            language        = sy-langu
                                            longtextid      = 'TX01' ) ) )
          RESULT   lt_text_data
          REPORTED DATA(ls_reported)
          FAILED   DATA(ls_failed).
      CLEAR: lwa_text_data.
      READ TABLE lt_text_data into lwa_text_data index 1.
      lwa_data-text = lwa_text_data-longtext.
      MODIFY lt_data FROM lwa_data.
    ENDLOOP.
    ct_calculated_data = CORRESPONDING #(  lt_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
*    CHECK iv_entity = 'ZZ1_PR_SO'.
*
*    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<field>).
*      CASE <field>.
*        WHEN 'TEXT'.
*          APPEND 'SALESDOCUMENT' TO et_requested_orig_elements.
*      ENDCASE.
*    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
