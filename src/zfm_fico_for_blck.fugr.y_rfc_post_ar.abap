FUNCTION Y_RFC_POST_AR.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DOCUMENTHEADER) LIKE  ZBAPI_ACC_POST_AR
*"  STRUCTURE  ZBAPI_ACC_POST_AR
*"  EXPORTING
*"     VALUE(OBJ_TYPE) LIKE  BAPIACHE09-OBJ_TYPE
*"     VALUE(OBJ_KEY) LIKE  BAPIACHE09-OBJ_KEY
*"     VALUE(OBJ_SYS) LIKE  BAPIACHE09-OBJ_SYS
*"  TABLES
*"      RETURN STRUCTURE  BAPIRET2
*"--------------------------------------------------------------------
DATA:
  ref_key LIKE bapiache01-obj_key VALUE 'TEST000001BAPICALL',
  dest    LIKE bdi_logsys-logsys  VALUE '          '.

DATA lt_return         TYPE STANDARD TABLE OF bapiret2.

DATA:
  check_action TYPE c VALUE 'X',
  lv_exists_already TYPE belnr_d.

CLEAR:  sign, lv_exists_already, gd_documentheader, wa_orig_amt_base, wa_orig_amt_doccur_long.
* the following fields remain initialized, used for the return in the service
CLEAR: documentheader-obj_type, documentheader-obj_key, documentheader-ac_doc_no, documentheader-itemno_acc.
REFRESH:  it_accountgl, it_currencyamount, it_accountreceivable, it_accounttax.

*REF_DOC_NO BKPF-XBLNR is the key in the odata service
* we should check that the Timesheet is unique since the GET_ENTITYSET performs a select single
SELECT SINGLE belnr INTO lv_exists_already FROM bkpf WHERE xblnr = documentheader-ref_doc_no.
IF lv_exists_already IS NOT INITIAL.
return-type = 'E'.
return-id = 'RW'.
return-number = '001'.
CONCATENATE 'TimeSheet: ' documentheader-ref_doc_no ' already exists !' INTO return-message.
APPEND return.
ENDIF.

CHECK lv_exists_already IS INITIAL.

* Variable Values here
* Fixed values in perform

  gd_documentheader-header_txt = documentheader-header_txt.
  gd_documentheader-comp_code  = documentheader-comp_code.
  gd_documentheader-doc_date   = documentheader-doc_date.
  gd_documentheader-pstng_date = documentheader-pstng_date.
  gd_documentheader-fisc_year  = gd_documentheader-pstng_date(4).
  gd_documentheader-ref_doc_no = documentheader-ref_doc_no.

  PERFORM fill_header.
IF NOT documentheader-customer IS INITIAL.
  gd_documentheader-doc_type   = 'DB'.
  sign = 1.
ENDIF.

  it_accountgl-gl_account     = documentheader-gl_account. "7000300000'.
  it_accountgl-tax_code       = 'A3'.
  it_accountgl-alloc_nmbr     = documentheader-alloc_nmbr. "'TS0000011'. "VARIABLE"
  it_accountgl-item_text      = documentheader-item_text.
  it_accountgl-quantity       = documentheader-quantity.
  it_accountgl-base_uom       = documentheader-base_uom.
  it_accountgl-wbs_element    = documentheader-wbs_element.

  it_currencyamount-currency   = documentheader-currency.
  wa_orig_amt_doccur_long = documentheader-amt_doccur_long.
  wa_orig_amt_base = documentheader-amt_base.
  it_currencyamount-amt_doccur_long = documentheader-amt_doccur_long.
  it_currencyamount-amt_base   = documentheader-amt_base.

  PERFORM fill_accountgl.
  PERFORM fill_currencyamount_1.

  it_accountreceivable-customer  = documentheader-customer.  "'0002000022'.
  it_accountreceivable-alloc_nmbr = documentheader-alloc_nmbr.
  it_accountreceivable-item_text  = documentheader-item_text.
  PERFORM fill_accountar.
  sign = -1 * sign. "reverse
  PERFORM fill_currencyamount_2ar.

  it_accounttax-gl_account     =  documentheader-gl_account_tx. "'4510000000'.
  PERFORM fill_accounttax_ar.
  PERFORM fill_currencyamount_3ar.

IF documentheader-action = 'S'.

  CALL FUNCTION 'BAPI_ACC_DOCUMENT_CHECK'
    DESTINATION dest
    EXPORTING
      documentheader    = gd_documentheader
    TABLES
      accountgl         = it_accountgl
      accountreceivable    = it_accountreceivable
      accounttax        = it_accounttax
      currencyamount    = it_currencyamount
      return            = lt_return.

      APPEND LINES OF lt_return TO return.

ELSEIF documentheader-action = 'P'.

* Synchronous posting only contemplated here
    CALL FUNCTION 'BAPI_ACC_DOCUMENT_POST'
      EXPORTING
        documentheader    = gd_documentheader
      IMPORTING
        obj_type          = obj_type
        obj_key           = obj_key
        obj_sys           = obj_sys
      TABLES
        accountgl         = it_accountgl
        accountreceivable    = it_accountreceivable
        accounttax        = it_accounttax
        currencyamount    = it_currencyamount
        return            = lt_return.

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
      CLEAR obj_key.
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
    WHEN abap_false.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
  ENDCASE.



ENDIF.

ENDFUNCTION.
