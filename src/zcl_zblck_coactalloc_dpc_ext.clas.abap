class ZCL_ZBLCK_COACTALLOC_DPC_EXT definition
  public
  inheriting from ZCL_ZBLCK_COACTALLOC_DPC
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



CLASS ZCL_ZBLCK_COACTALLOC_DPC_EXT IMPLEMENTATION.


METHOD posthdrset_create_entity.
DATA: lv_rfc_name TYPE tfdir-funcname,
      lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text,
      lx_root TYPE REF TO cx_root,
      lv_subrc TYPE syst-subrc,
      lv_destination TYPE rfcdest.

DATA: ls_header TYPE zbapi_actalloc_post,
*      ls_posthdrap LIKE er_entity,  "or better, as below data declaration more transparent
      lt_return TYPE STANDARD TABLE OF bapiret2,
      ls_return TYPE bapiret1.

DATA: ls_posthdr TYPE zcl_zblck_coactalloc_mpc=>ts_posthdr.

DATA: l_doc_no TYPE bapidochdrp-doc_no.

io_data_provider->read_entry_data( IMPORTING es_data = ls_posthdr ).

CLEAR : ls_header, l_doc_no.
MOVE:
     ls_posthdr-action          TO ls_header-action,
     ls_posthdr-co_area         TO ls_header-co_area,
     ls_posthdr-doc_date        TO ls_header-doc_date,
     ls_posthdr-postgdate       TO ls_header-postgdate,
*     ls_posthdr-doc_no       TO ls_header-doc_no,
     ls_posthdr-variant         TO ls_header-variant,
     ls_posthdr-doc_hdr_tx      TO ls_header-doc_hdr_tx,
*     ls_posthdr-OBJ_KEY       TO ls_header-OBJ_KEY ,
*     ls_posthdr-OBJ_TYPE       TO ls_header-OBJ_TYPE,
*     ls_posthdr-OBJ_SYS       TO ls_header-OBJ_SYS,
     ls_posthdr-send_cctr       TO ls_header-send_cctr,
     ls_posthdr-acttype         TO ls_header-acttype,
     ls_posthdr-actvty_qty      TO ls_header-actvty_qty,
     ls_posthdr-activityun      TO ls_header-activityun,
     ls_posthdr-price           TO ls_header-price,
     ls_posthdr-currency        TO ls_header-currency,
     ls_posthdr-seg_text        TO ls_header-seg_text,
     ls_posthdr-rec_wbs_el      TO ls_header-rec_wbs_el.

     lv_rfc_name = 'Z_RFC_POST_ACTALLOC'.

IF lv_destination IS INITIAL OR lv_destination EQ 'NONE'.

TRY.

CALL FUNCTION lv_rfc_name
  EXPORTING
    documentheader       = ls_header
IMPORTING
   doc_no                = l_doc_no
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

ls_posthdr-doc_no   = l_doc_no.

ENDIF.

ENDTRY.
ELSE.
CALL FUNCTION lv_rfc_name DESTINATION lv_destination
EXPORTING
    documentheader       = ls_header
IMPORTING
   doc_no                = l_doc_no
TABLES
    return               = lt_return
        EXCEPTIONS
*          system_failure         = 1000 MESSAGE lv_exc_msg
          communication_failure  = 1001 MESSAGE lv_exc_msg
          OTHERS = 1002.

  lv_subrc = sy-subrc.
ENDIF.
*BREAK DEVELOPER.
er_entity = ls_posthdr.
ENDMETHOD.


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
          ls_bp_key     TYPE zcl_zblck_coactalloc_mpc=>ts_posthdr-doc_hdr_tx,
          ls_headerdata TYPE zcl_zblck_coactalloc_mpc=>ts_posthdr.

    CALL METHOD io_tech_request_context->get_converted_keys
      IMPORTING
        es_key_values = ls_headerdata.

    ls_bp_key = ls_headerdata-doc_hdr_tx.
* won't be correct since many doc_hdr_tx with same value
    SELECT SINGLE *
      INTO CORRESPONDING FIELDS OF @er_entity
      FROM ZTV_CO_COBK_COEP_ACTALLOC
      WHERE doc_hdr_tx  = @ls_headerdata-doc_hdr_tx.
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


*ZTV_CO_COBK_COEP_ACTALLOC

SELECT
OBJ_KEY,
OBJ_TYPE,
OBJ_SYS,
ACTION,
CO_AREA,
DOC_DATE,
POSTGDATE,
DOC_NO,
VARIANT,
DOC_HDR_TX,
SEND_CCTR,
ACTTYPE,
ACTVTY_QTY,
ACTIVITYUN,
PRICE,
CURRENCY,
SEG_TEXT,
REC_WBS_EL
FROM ZTV_CO_COBK_COEP_ACTALLOC
INTO CORRESPONDING FIELDS OF TABLE @et_entityset
UP TO @lv_max_index ROWS
WHERE (lv_osql_where_clause).
*- skipping entries specified by $skip
IF lv_skip IS NOT INITIAL.
  DELETE et_entityset TO lv_skip.
ENDIF.
*-  Inlinecount - get the total numbers of entries that fit to the where clause
IF io_tech_request_context->has_inlinecount( ) = abap_true.
 SELECT COUNT(*)  FROM   ZTV_CO_COBK_COEP_ACTALLOC WHERE (lv_osql_where_clause) .
   es_response_context-inlinecount = sy-dbcnt.
ELSE.
CLEAR es_response_context-inlinecount.
ENDIF.
endmethod.
ENDCLASS.
