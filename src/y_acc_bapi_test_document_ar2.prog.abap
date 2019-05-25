*&---------------------------------------------------------------------*
*& Report  Z_ACC_BAPI_TEST_DOCUMENT_AR2                                *
*&                                                                     *
*&---------------------------------------------------------------------*
*& Test report, calls BAPI AcctngDocument                              *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  y_acc_bapi_test_document_ar2                  .

SELECTION-SCREEN BEGIN OF BLOCK bl01 .

PARAMETERS:
    p_action          TYPE zbapi_acc_post_ar-action DEFAULT 'S'.
SELECTION-SCREEN ULINE.
PARAMETERS:
    p_hdrtxt         TYPE zbapi_acc_post_ar-header_txt DEFAULT 'BAPI Test Header'.
SELECTION-SCREEN ULINE.
PARAMETERS:
        p_cycode       TYPE zbapi_acc_post_ar-comp_code DEFAULT 'BE99',
        p_doc_dt        TYPE zbapi_acc_post_ar-doc_date DEFAULT sy-datum,
        p_pstgdt      TYPE zbapi_acc_post_ar-pstng_date DEFAULT sy-datum,
        p_refdcn      TYPE zbapi_acc_post_ar-ref_doc_no DEFAULT 'TS000000104PZIN',
        p_glacc      TYPE zbapi_acc_post_ar-gl_account DEFAULT '7000300000',
        p_glactx   TYPE zbapi_acc_post_ar-gl_account_tx DEFAULT '4510000000',
        p_itmtxt       TYPE zbapi_acc_post_ar-item_text DEFAULT 'BAPI Test G/L line item',
        p_qty        TYPE zbapi_acc_post_ar-quantity DEFAULT 40,
        p_uom        TYPE zbapi_acc_post_ar-base_uom DEFAULT 'H',
        p_wbs     TYPE zbapi_acc_post_ar-wbs_element DEFAULT '/000/BCH-000/CUST2',
        p_cstomr       TYPE zbapi_acc_post_ar-customer DEFAULT '0002000022',
        p_pytrms        TYPE zbapi_acc_post_ar-pmnttrms DEFAULT 'NT30',
        p_alnmbr      TYPE zbapi_acc_post_ar-alloc_nmbr DEFAULT 'TS000000104PZIN',
        p_cur        TYPE zbapi_acc_post_ar-currency DEFAULT 'EUR',
        p_amt TYPE zbapi_acc_post_ar-amt_doccur_long DEFAULT 100,
        p_amtbse   TYPE zbapi_acc_post_ar-amt_base DEFAULT 100.

SELECTION-SCREEN END   OF BLOCK bl01.

DATA:
  ref_key LIKE bapiache01-obj_key VALUE 'TEST000001BAPICALL',
  in_documentheader    LIKE zbapi_acc_post_ar,
  lt_return            LIKE TABLE OF bapiret2   WITH HEADER LINE.

*  it_accountgl         LIKE TABLE OF bapiacgl09 WITH HEADER LINE,
*  it_accounttax        LIKE TABLE OF bapiactx09 WITH HEADER LINE,
*
*  it_currencyamount    LIKE TABLE OF bapiaccr09 WITH HEADER LINE


DATA: l_type LIKE bapiache09-obj_type,
      l_key  LIKE bapiache09-obj_key,
      l_sys  LIKE bapiache09-obj_sys.

CLEAR : in_documentheader.
MOVE:
     p_action TO in_documentheader-action,
     p_hdrtxt TO in_documentheader-header_txt,
     p_cycode TO in_documentheader-comp_code,
     p_doc_dt TO in_documentheader-doc_date,
     p_pstgdt TO in_documentheader-pstng_date,
     p_refdcn TO in_documentheader-ref_doc_no,
     p_glacc  TO in_documentheader-gl_account,
     p_glactx TO in_documentheader-gl_account_tx,
     p_itmtxt TO in_documentheader-item_text,
     p_qty    TO in_documentheader-quantity,
     p_uom    TO in_documentheader-base_uom,
     p_wbs    TO in_documentheader-wbs_element,
     p_cstomr TO in_documentheader-customer,
     p_pytrms TO in_documentheader-pmnttrms,
     p_alnmbr TO in_documentheader-alloc_nmbr,
     p_cur    TO in_documentheader-currency,
     p_amt    TO in_documentheader-amt_doccur_long,
     p_amtbse TO in_documentheader-amt_base.
.

CALL FUNCTION 'Y_RFC_POST_AR'
  EXPORTING
    documentheader       = in_documentheader
IMPORTING
   obj_type             = l_type
   obj_key              = l_key
   obj_sys              = l_sys
  TABLES
    return               = lt_return
          .

WRITE: / 'Result of post:'.                             "#EC NOTEXT
PERFORM show_messages.


*---------------------------------------------------------------------*
*      Form  Show_messages
*---------------------------------------------------------------------*
FORM show_messages.

  IF lt_return[] IS INITIAL.
    WRITE: / 'no messages'.
  ELSE.
    SKIP 1.
    LOOP AT lt_return.
      WRITE: /    lt_return-type,
             (2)  lt_return-id,
                  lt_return-number,
             (80) lt_return-message,
*                 it_return-LOG_NO
*                 it_return-LOG_MSG_NO
*                 it_return-MESSAGE_V1
*                 it_return-MESSAGE_V2
*                 it_return-MESSAGE_V3
*                 it_return-MESSAGE_V4
             (20) lt_return-parameter,
             (3)  lt_return-row,
                  lt_return-field.
*                 it_return-SYSTEM
    ENDLOOP.
  ENDIF.

  ULINE.

ENDFORM.                               " Show_messages
