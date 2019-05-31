FUNCTION z_rfc_post_actalloc.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DOCUMENTHEADER) TYPE  ZBAPI_ACTALLOC_POST
*"     VALUE(IGNORE_WARNINGS) TYPE  BAPIIW-IGNWARN DEFAULT SPACE
*"  EXPORTING
*"     VALUE(DOC_NO) TYPE  BAPIDOCHDRP-DOC_NO
*"  TABLES
*"      RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------
*DATA:
*  ref_key LIKE bapiache01-obj_key VALUE 'TEST000001BAPICALL'.
*  dest    LIKE bdi_logsys-logsys  VALUE '          '.

DATA: lt_return         TYPE STANDARD TABLE OF bapiret2,
      ls_return         TYPE bapiret2.

DATA:
  check_action TYPE c VALUE 'X',
  lv_exists_already TYPE belnr_d.

CLEAR:  lv_exists_already, gd_documentheader.
* the following fields remain initialized. used for the return in the service
CLEAR: gd_actdocumentheader, documentheader-obj_type, documentheader-obj_key, documentheader-obj_sys, it_doc_items, it_criteria.
REFRESH: lt_return.

*REF_DOC_NO BKPF-XBLNR is the key in the odata service
* we should check that the Timesheet is unique since the GET_ENTITYSET performs a select single
SELECT SINGLE belnr INTO lv_exists_already FROM cobk WHERE kokrs  =  documentheader-co_area AND bltxt  =  documentheader-doc_hdr_tx.
IF lv_exists_already IS NOT INITIAL.
return-type  =  'E'.
return-id  =  'RW'.
return-number  =  '001'.
CONCATENATE 'TimeSheet: ' documentheader-doc_hdr_tx ' already exists !' INTO return-message.
APPEND return.
ENDIF.

CHECK lv_exists_already IS INITIAL.


* Fixed values here
  CALL FUNCTION 'OWN_LOGICAL_SYSTEM_GET'
    IMPORTING
      own_logical_system = gd_actdocumentheader-obj_sys.

gd_actdocumentheader-obj_type    = 'COBK'.
gd_actdocumentheader-obj_key     = '$'.
gd_actdocumentheader-username     = sy-uname.

* Variable Values here
gd_actdocumentheader-co_area     = documentheader-co_area.
gd_actdocumentheader-docdate     = documentheader-doc_date.
gd_actdocumentheader-postgdate   = documentheader-postgdate.

* Unknown before posting
*gd_actdocumentheader-doc_no      = documentheader-doc_no.

gd_actdocumentheader-variant     = documentheader-variant.
gd_actdocumentheader-doc_hdr_tx  = documentheader-doc_hdr_tx.


* fill items
it_doc_items-send_cctr   = documentheader-send_cctr.
it_doc_items-acttype     = documentheader-acttype.
it_doc_items-actvty_qty  = documentheader-actvty_qty.
it_doc_items-activityun  = documentheader-activityun.
it_doc_items-price       = documentheader-price.
it_doc_items-currency    = documentheader-currency.
it_doc_items-seg_text    = documentheader-seg_text.
it_doc_items-rec_wbs_el  = documentheader-rec_wbs_el.
APPEND it_doc_items.

IF documentheader-action = 'S'.

CALL FUNCTION 'BAPI_ACC_ACTIVITY_ALLOC_CHECK'
  EXPORTING
    doc_header            = gd_actdocumentheader
  TABLES
    doc_items             = it_doc_items
    return                = lt_return.
**********************
*Evaluate return code.
**********************

READ TABLE lt_return INTO ls_return INDEX 1.

IF ls_return-type NE 'S'.
    APPEND LINES OF lt_return TO return.
ENDIF.


ELSEIF documentheader-action = 'P'.

CALL FUNCTION 'BAPI_ACC_ACTIVITY_ALLOC_POST'
  EXPORTING
    doc_header            = gd_actdocumentheader
*   IGNORE_WARNINGS       = ' '
  IMPORTING
    doc_no                = doc_no
  TABLES
    doc_items             = it_doc_items
    return                = lt_return.

    LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>) WHERE type CA 'AEX'.
      EXIT.
    ENDLOOP.

    IF sy-subrc = 0.
      DATA(lv_error_occured) = abap_true.
      APPEND LINES OF lt_return TO return.
      EXIT.
    ENDIF.

  CASE lv_error_occured.
    WHEN abap_true.
*      CLEAR obj_key.
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
    WHEN abap_false.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
  ENDCASE.



ENDIF.

ENDFUNCTION.
