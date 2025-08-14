CLASS zz1_cl_dnlist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
    INTERFACES if_amdp_marker_hdb.
    INTERFACES if_rap_query_provider .
    CLASS-METHODS exec_tax FOR TABLE FUNCTION zz1_tf_dnlist_tax.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZZ1_CL_DNLIST IMPLEMENTATION.


  METHOD exec_tax
  BY DATABASE FUNCTION FOR HDB
     LANGUAGE SQLSCRIPT
     OPTIONS READ-ONLY
     USING zz1_i_salesdocitemprice.

    lt_konv =
    select salesdocument, sum( conditionamount ) as conditionamount, transactioncurrency
      from zz1_i_salesdocitemprice
      WHERE conditioninactivereason = ''
       and ( conditiontype = 'TTX1' or conditiontype = 'ZTX1' )
      GROUP BY salesdocument, transactioncurrency;

    RETURN
     select client, salesdocument, conditionamount, transactioncurrency
       FROM :lt_konv ;
  ENDMETHOD.


  METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).
      DATA(w_top)     = io_request->get_paging( )->get_page_size( ).
      DATA(w_offset)    = io_request->get_paging( )->get_offset( ).
      DATA(t_parameter) = io_request->get_parameters( ).
      DATA(t_filter)  = io_request->get_filter( )->get_as_ranges( ).
      DATA(t_fields)  = io_request->get_requested_elements( ).
      DATA(t_sort)    = io_request->get_sort_elements( ).
    ENDIF.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: lwa_data TYPE zz1_i_dnlist2,
          lt_data  TYPE STANDARD TABLE OF zz1_i_dnlist2.

    DATA: lt_text_data TYPE TABLE FOR READ RESULT i_outbounddeliverytp\\outbounddeliverytext.
    DATA: lwa_text_data LIKE LINE OF lt_text_data .

    DATA: ls_reported TYPE RESPONSE FOR REPORTED i_outbounddeliverytp,
          ls_failed   TYPE RESPONSE FOR FAILED EARLY i_outbounddeliverytp.

    DATA: l_field(20).
    FIELD-SYMBOLS <fs> TYPE any.

    lt_data = CORRESPONDING #( it_original_data ).
    LOOP AT lt_data INTO lwa_data.
      DO 6 TIMES.
        l_field = COND #( WHEN sy-index = 1 THEN 'TX03'
                           WHEN sy-index = 2 THEN 'TX04'
                           WHEN sy-index = 3 THEN 'TX07'
                           WHEN sy-index = 4 THEN 'TX13'
                           WHEN sy-index = 5 THEN 'TX14'
                           WHEN sy-index = 6 THEN 'TX17' ).
        UNASSIGN <fs>.
        ASSIGN COMPONENT l_field OF STRUCTURE lwa_data TO <fs>.
        CHECK <fs> IS ASSIGNED.

        DO 3 TIMES.
          CLEAR: lwa_text_data, lt_text_data[].
          READ ENTITIES OF i_outbounddeliverytp ENTITY outbounddeliverytext
            FROM VALUE #( ( %key = VALUE #( outbounddelivery = lwa_data-outbounddelivery
                                            language         = COND sy-langu( WHEN sy-index = 1 THEN sy-langu
                                                                             WHEN sy-index = 2 THEN 'M'
                                                                             ELSE 'E' )
                                            longtextid       = l_field )
                            %control = VALUE #( outbounddelivery = if_abap_behv=>mk-on
                                                language = if_abap_behv=>mk-on
                                                longtextid = if_abap_behv=>mk-on
                                                longtext = if_abap_behv=>mk-on ) ) )
              RESULT   lt_text_data
              REPORTED ls_reported
              FAILED   ls_failed.
          READ TABLE lt_text_data INTO lwa_text_data INDEX 1.
          IF lwa_text_data-longtext IS NOT INITIAL.
            EXIT.
          ENDIF.
        ENDDO.
        <fs> = lwa_text_data-longtext.
      ENDDO.
      MODIFY lt_data FROM lwa_data.
    ENDLOOP.
    ct_calculated_data = CORRESPONDING #(  lt_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.
