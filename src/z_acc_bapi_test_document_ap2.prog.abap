*&---------------------------------------------------------------------*
*& Report  Z_ACC_BAPI_TEST_DOCUMENT_AP2                                *
*&                                                                     *
*&---------------------------------------------------------------------*
*& Test report, calls BAPI AcctngDocument                              *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  z_acc_bapi_test_document_ap2                  .

SELECTION-SCREEN BEGIN OF BLOCK bl01 .

PARAMETERS:
    p_action          TYPE zbapi_acc_post_ap-action DEFAULT 'S'.
SELECTION-SCREEN ULINE.
PARAMETERS:
    p_hdrtxt         TYPE zbapi_acc_post_ap-header_txt DEFAULT 'BAPI Test Header'.
SELECTION-SCREEN ULINE.
PARAMETERS:
        p_cycode       TYPE zbapi_acc_post_ap-comp_code DEFAULT 'BE10',
        p_doc_dt        TYPE zbapi_acc_post_ap-doc_date DEFAULT sy-datum,
        p_pstgdt      TYPE zbapi_acc_post_ap-pstng_date DEFAULT sy-datum,
        p_refdcn      TYPE zbapi_acc_post_ap-ref_doc_no DEFAULT 'TS00000011PZIN',
        p_glacc      TYPE zbapi_acc_post_ap-gl_account DEFAULT '6156000000',
        p_glactx   TYPE zbapi_acc_post_ap-gl_account_tx DEFAULT '4110000000',
        p_itmTxt       TYPE zbapi_acc_post_ap-item_text DEFAULT 'BAPI Test G/L line item',
        p_qty        TYPE zbapi_acc_post_ap-quantity DEFAULT 40,
        p_uom        TYPE zbapi_acc_post_ap-base_uom DEFAULT 'H',
        p_wbs     TYPE zbapi_acc_post_ap-wbs_element DEFAULT '/000/BCH-002/VEND1',
        p_vendor       TYPE zbapi_acc_post_ap-vendor_no DEFAULt '0002000023',
        p_pytrms        TYPE zbapi_acc_post_ap-pmnttrms DEFAULT 'NT30',
        p_alnmbr      TYPE zbapi_acc_post_ap-alloc_nmbr DEFAULT 'TS0000000010',
        p_cur        TYPE zbapi_acc_post_ap-currency DEFAULT 'EUR',
        p_amt TYPE zbapi_acc_post_ap-amt_doccur_long DEFAULT 100,
        p_amtbse   TYPE zbapi_acc_post_ap-amt_base DEFAULT 100.

SELECTION-SCREEN END   OF BLOCK bl01.

DATA:
  ref_key LIKE bapiache01-obj_key VALUE 'TEST000001BAPICALL',
  in_documentheader    LIKE zbapi_acc_post_ap,
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
     p_action to in_documentheader-action,
     p_hdrtxt to in_documentheader-header_txt,
     p_cycode to in_documentheader-comp_code,
     p_doc_dt To in_documentheader-doc_date,
     p_pstgdt to in_documentheader-pstng_date,
     p_refdcn to in_documentheader-ref_doc_no,
     p_glacc  to in_documentheader-gl_account,
     p_glactx to in_documentheader-gl_account_tx,
     p_itmTxt to in_documentheader-item_text,
     p_qty    to in_documentheader-quantity,
     p_uom    to in_documentheader-base_uom,
     p_wbs    to in_documentheader-wbs_element,
     p_vendor to in_documentheader-vendor_no,
     p_pytrms to in_documentheader-pmnttrms,
     p_alnmbr to in_documentheader-alloc_nmbr,
     p_cur    to in_documentheader-currency,
     p_amt    to in_documentheader-amt_doccur_long,
     p_amtbse to in_documentheader-amt_base.
.
CALL FUNCTION 'Z_RFC_POST_AP'
  EXPORTING
    documentheader       = in_documentheader
IMPORTING
   OBJ_TYPE             = l_type
   OBJ_KEY              = l_key
   OBJ_SYS              = l_sys
  tables
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
