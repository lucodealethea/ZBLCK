class ZCL_ZBLCK_FIAP_01_DPC_EXT definition
  public
  inheriting from ZCL_ZBLCK_FIAP_01_DPC
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

  methods _RAISE_BAPI_MESSAGES
    importing
      !IV_AC_DOC_NO type BELNR_D
      !IV_ENTITY type STRING
      !IS_RETURN type BAPIRET1
      !IT_RETURN type TY_T_BAPI_CORU_RETURN
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION .
ENDCLASS.



CLASS ZCL_ZBLCK_FIAP_01_DPC_EXT IMPLEMENTATION.


method POSTHDRSET_CREATE_ENTITY.

DATA: lv_rfc_name TYPE tfdir-funcname,
      lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text,
      lx_root TYPE REF TO cx_root,
      lv_subrc TYPE syst-subrc,
      lv_destination TYPE rfcdest.

DATA: ls_header TYPE zbapi_acc_post_ap,
*      ls_posthdrap LIKE er_entity,  "or better, as below data declaration more transparent
      lt_return TYPE STANDARD TABLE OF bapiret2,
      ls_return TYPE bapiret1.

DATA: ls_posthdrap TYPE zcl_zblck_fiap_01_mpc=>ts_posthdr.

DATA: l_type TYPE bapiache09-obj_type,
      l_key  TYPE bapiache09-obj_key,
      l_sys  TYPE bapiache09-obj_sys.

io_data_provider->read_entry_data( IMPORTING es_data = ls_posthdrap ).

CLEAR : ls_header.
MOVE:
     ls_posthdrap-action          TO ls_header-action,
     ls_posthdrap-header_txt      TO ls_header-header_txt,
     ls_posthdrap-comp_code       TO ls_header-comp_code,
     ls_posthdrap-doc_date        TO ls_header-doc_date,
     ls_posthdrap-pstng_date      TO ls_header-pstng_date,
     ls_posthdrap-ref_doc_no      TO ls_header-ref_doc_no,
     ls_posthdrap-gl_account      TO ls_header-gl_account,
     ls_posthdrap-gl_account_tx   TO ls_header-gl_account_tx,
     ls_posthdrap-item_text       TO ls_header-item_text,
     ls_posthdrap-quantity        TO ls_header-quantity,
     ls_posthdrap-base_uom        TO ls_header-base_uom,
     ls_posthdrap-wbs_element     TO ls_header-wbs_element,
     ls_posthdrap-vendor_no       TO ls_header-vendor_no,
     ls_posthdrap-pmnttrms        TO ls_header-pmnttrms,
     ls_posthdrap-alloc_nmbr      TO ls_header-alloc_nmbr,
     ls_posthdrap-currency        TO ls_header-currency,
     ls_posthdrap-amt_doccur_long TO ls_header-amt_doccur_long,
     ls_posthdrap-amt_base        TO ls_header-amt_base.

     lv_rfc_name = 'Z_RFC_POST_AP'.

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

* Report BAPI errors
*  _raise_bapi_messages(
*    EXPORTING IV_AC_DOC_NO  = l_key(10)
*              iv_entity     = 'FIAPInvoiceCreationConfirmation'
*              is_return     = ls_return "BAPIRET1
*              it_return     = lt_return ). "BAPIRET2 <>


IF lt_return IS NOT INITIAL.
   mo_context->get_message_container( )->add_messages_from_bapi(
   it_bapi_messages = lt_return
   iv_determine_leading_msg = /iwbep/if_message_container=>gcs_leading_msg_search_option-first ).

   me->/iwbep/if_sb_dpc_comm_services~rfc_save_log(
         EXPORTING
           iv_entity_type = iv_entity_name
           it_return      = lt_return
           it_key_tab     = it_key_tab ).
ELSE.
ls_posthdrap-obj_type    = l_type.
ls_posthdrap-obj_key     = l_key.
ls_posthdrap-ac_doc_no   = l_key(10).
ls_posthdrap-itemno_acc  = ''.
ENDIF.

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
er_entity = ls_posthdrap.

endmethod.


METHOD posthdrset_get_entity.

    DATA: lt_keys       TYPE /iwbep/t_mgw_tech_pairs,
          ls_key        TYPE /iwbep/s_mgw_tech_pair,
          ls_bp_key     TYPE zcl_zblck_fiap_01_mpc=>ts_posthdr-ref_doc_no,
          ls_headerdata TYPE zcl_zblck_fiap_01_mpc=>ts_posthdr.

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


METHOD posthdrset_get_entityset.

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
vendor_no,
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

ENDMETHOD.


  method _RAISE_BAPI_MESSAGES.
  endmethod.
ENDCLASS.
