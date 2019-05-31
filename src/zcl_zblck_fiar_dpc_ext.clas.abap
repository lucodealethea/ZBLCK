class ZCL_ZBLCK_FIAR_DPC_EXT definition
  public
  inheriting from ZCL_ZBLCK_FIAR_DPC
  create public .

public section.
protected section.

  methods POSTHDRSET_GET_ENTITY
    redefinition .
  methods POSTHDRSET_GET_ENTITYSET
    redefinition .
  methods POSTHDRSET_CREATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZBLCK_FIAR_DPC_EXT IMPLEMENTATION.


  method POSTHDRSET_CREATE_ENTITY.
**TRY.
*CALL METHOD SUPER->POSTHDRSET_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.

DATA: lv_rfc_name TYPE tfdir-funcname,
      lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text,
      lx_root TYPE REF TO cx_root,
      lv_subrc TYPE syst-subrc,
      lv_destination TYPE rfcdest.

DATA: ls_header TYPE zbapi_acc_post_ar,
*      ls_posthdrar LIKE er_entity,  "or better, as below data declaration more transparent
      lt_return TYPE STANDARD TABLE OF bapiret2.

DATA: ls_posthdrar TYPE zcl_zblck_fiar_mpc=>ts_posthdr.

DATA: l_type TYPE bapiache09-obj_type,
      l_key  TYPE bapiache09-obj_key,
      l_sys  TYPE bapiache09-obj_sys.

io_data_provider->read_entry_data( IMPORTING es_data = ls_posthdrar ).

CLEAR : ls_header.
MOVE:
     ls_posthdrar-action          TO ls_header-action,
     ls_posthdrar-header_txt      TO ls_header-header_txt,
     ls_posthdrar-comp_code       TO ls_header-comp_code,
     ls_posthdrar-doc_date        TO ls_header-doc_date,
     ls_posthdrar-pstng_date      TO ls_header-pstng_date,
     ls_posthdrar-ref_doc_no      TO ls_header-ref_doc_no,
     ls_posthdrar-gl_account      TO ls_header-gl_account,
     ls_posthdrar-gl_account_tx   TO ls_header-gl_account_tx,
     ls_posthdrar-item_text       TO ls_header-item_text,
     ls_posthdrar-quantity        TO ls_header-quantity,
     ls_posthdrar-base_uom        TO ls_header-base_uom,
     ls_posthdrar-wbs_element     TO ls_header-wbs_element,
     ls_posthdrar-customer       TO ls_header-customer,
     ls_posthdrar-pmnttrms        TO ls_header-pmnttrms,
     ls_posthdrar-alloc_nmbr      TO ls_header-alloc_nmbr,
     ls_posthdrar-currency        TO ls_header-currency,
     ls_posthdrar-amt_doccur_long TO ls_header-amt_doccur_long,
     ls_posthdrar-amt_base        TO ls_header-amt_base.

     lv_rfc_name = 'Z_RFC_POST_AR'.

IF lv_destination IS INITIAL OR lv_destination EQ 'NONE'.

TRY.

CALL FUNCTION lv_rfc_name
  EXPORTING
    documentheader       = ls_header
IMPORTING
   obj_type              = l_type
   obj_key               = l_key
   obj_sys               = l_sys
TABLES
    return               = lt_return
EXCEPTIONS
    system_failure = 1000 message lv_exc_msg
    OTHERS = 1002.

      lv_subrc = sy-subrc.
*in case of co-deployment the exception is raised and needs to be caught
    CATCH cx_root INTO lx_root.
      lv_subrc = 1001.
      lv_exc_msg = lx_root->if_message~get_text( ).

*IF lt_return IS NOT INITIAL.
*   mo_context->get_message_container( )->add_messages_from_bapi(
*   it_bapi_messages = lt_return
*   iv_determine_leading_msg = /iwbep/if_message_container=>gcs_leading_msg_search_option-first ).
*
*   me->/iwbep/if_sb_dpc_comm_services~rfc_save_log(
*         EXPORTING
*           iv_entity_type = iv_entity_name
*           it_return      = lt_return
*           it_key_tab     = it_key_tab ).
*-------------------------------------------------------------
* Error and exception handling
*-------------------------------------------------------------
 IF lv_subrc <> 0.
* Execute the RFC exception handling process
   me->/iwbep/if_sb_dpc_comm_services~rfc_exception_handling(
     EXPORTING
       iv_subrc            = lv_subrc
       iv_exp_message_text = lv_exc_msg ).
 ENDIF.

 IF lt_return IS NOT INITIAL.
   me->/iwbep/if_sb_dpc_comm_services~rfc_save_log(
     EXPORTING
       iv_entity_type = iv_entity_name
       it_return      = lt_return
       it_key_tab     = it_key_tab ).
 ENDIF.

ls_posthdrar-obj_type    = l_type.
ls_posthdrar-obj_key     = l_key.
ls_posthdrar-ac_doc_no   = l_key(10).
ls_posthdrar-itemno_acc  = ''.


ENDTRY.
ELSE.
CALL FUNCTION lv_rfc_name DESTINATION lv_destination
  EXPORTING
    documentheader       = ls_header
IMPORTING
   obj_type              = l_type
   obj_key               = l_key
   obj_sys               = l_sys
TABLES
    return               = lt_return
        EXCEPTIONS
*          system_failure         = 1000 MESSAGE lv_exc_msg
          communication_failure  = 1001 MESSAGE lv_exc_msg
          OTHERS = 1002.

  lv_subrc = sy-subrc.
ENDIF.
*BREAK DEVELOPER.
er_entity = ls_posthdrar.
  endmethod.


  METHOD posthdrset_get_entity.
**TRY.
*CALL METHOD SUPER->POSTHDRSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.


    DATA: lt_keys       TYPE /iwbep/t_mgw_tech_pairs,
          ls_key        TYPE /iwbep/s_mgw_tech_pair,
          ls_bp_key     TYPE zcl_zblck_fiar_mpc=>ts_posthdr-ref_doc_no,
          ls_headerdata TYPE zcl_zblck_fiar_mpc=>ts_posthdr.

    CALL METHOD io_tech_request_context->get_converted_keys
      IMPORTING
        es_key_values = ls_headerdata.

    ls_bp_key = ls_headerdata-ref_doc_no.
* won't be correct since many ref_doc_no with same value
    SELECT SINGLE *
      INTO CORRESPONDING FIELDS OF @er_entity
      FROM ztv_figl_doc_items
      WHERE ref_doc_no  = @ls_headerdata-ref_doc_no.

  ENDMETHOD.


  method POSTHDRSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->POSTHDRSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.

DATA: lv_osql_where_clause TYPE string,
          lv_top               TYPE i,
          lv_skip              TYPE i,
          lv_max_index         TYPE i,
          n                    TYPE i.
*- get number of records requested
    lv_top = io_tech_request_context->get_top( ).
*- get number of lines that should be skipped
    lv_skip = io_tech_request_context->get_skip( ).
*- value for maxrows must only be calculated if the request also contains a $top
    IF lv_top IS NOT INITIAL.
      lv_max_index = lv_top + lv_skip.
    ENDIF.
* was lv_osql_where_clause = io_tech_request_context->get_osql_where_clause( ).
* because otherwise the statement GET SalesOrderSet?$filter=(Customer eq ‘100000000’)
* would not work because alpha conversion to ‘0100000000’ would not take place.
    lv_osql_where_clause = io_tech_request_context->get_osql_where_clause_convert( ).


*ZBLCK_FIDOCS - ZTV_FIGL_DOC_ITEMS

SELECT
obj_type,
obj_key,
ac_doc_no,
itemno_acc,
action,
header_txt,
comp_code,
doc_date,
pstng_date,
ref_doc_no,
gl_account,
gl_account_tx,
item_text,
quantity,
base_uom,
wbs_element,
customer,
pmnttrms,
alloc_nmbr,
currency,
amt_doccur_long,
0 AS amt_base
FROM ztv_figl_doc_items
INTO CORRESPONDING FIELDS OF TABLE @et_entityset
UP TO @lv_max_index ROWS
WHERE (lv_osql_where_clause).
*- skipping entries specified by $skip
IF lv_skip IS NOT INITIAL.
  DELETE et_entityset TO lv_skip.
ENDIF.
*-  Inlinecount - get the total numbers of entries that fit to the where clause
IF io_tech_request_context->has_inlinecount( ) = abap_true.
 SELECT COUNT(*)  FROM   ztv_figl_doc_items WHERE (lv_osql_where_clause) .
   es_response_context-inlinecount = sy-dbcnt.
ELSE.
CLEAR es_response_context-inlinecount.
ENDIF.

endmethod.
ENDCLASS.
