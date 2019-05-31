*&---------------------------------------------------------------------*
*& Report  zz_acc_bapi_activity_alloc2                                 *
*&                                                                     *
*&---------------------------------------------------------------------*
*& Test report, calls BAPI ACTIVITY_ALLOC                              *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  z_acc_bapi_activity_alloc2                  .

SELECTION-SCREEN BEGIN OF BLOCK bl01 .

PARAMETERS:
    p_action          TYPE zbapi_actalloc_post-action DEFAULT 'S'.
SELECTION-SCREEN ULINE.
PARAMETERS:
    p_hdrtxt         TYPE zbapi_actalloc_post-doc_hdr_tx DEFAULT 'TS000011'.
SELECTION-SCREEN ULINE.
PARAMETERS:
        p_coarea      TYPE zbapi_actalloc_post-co_area DEFAULT 'MPOL',
        p_doc_dt      TYPE zbapi_actalloc_post-doc_date DEFAULT sy-datum,
        p_pstgdt      TYPE zbapi_actalloc_post-postgdate DEFAULT sy-datum,
        p_varnt       TYPE zbapi_actalloc_post-variant DEFAULT '04SAP',
        p_sdcctr      TYPE zbapi_actalloc_post-send_cctr DEFAULT '9920000000',
        p_acttyp      TYPE zbapi_actalloc_post-acttype DEFAULT '910000',
        p_qty         TYPE zbapi_actalloc_post-actvty_qty DEFAULT 40,
        p_uom         TYPE zbapi_actalloc_post-activityun DEFAULT 'H',
        p_price       TYPE zbapi_actalloc_post-price DEFAULT 50,
        p_cur         TYPE zbapi_actalloc_post-currency DEFAULT 'EUR',
        p_itmtxt      TYPE zbapi_actalloc_post-seg_text DEFAULT 'TS000011',
        p_wbs         TYPE zbapi_actalloc_post-rec_wbs_el DEFAULT '/000/BCH-000/CUST2'.

SELECTION-SCREEN END   OF BLOCK bl01.

DATA:
  ref_key LIKE bapiache01-obj_key VALUE 'TEST000001BAPICALL',
  in_documentheader    LIKE zbapi_actalloc_post,
  lt_return            LIKE TABLE OF bapiret2   WITH HEADER LINE.


DATA: l_doc_no LIKE bapidochdrp-doc_no.

CLEAR : in_documentheader, l_doc_no.
MOVE:
     p_action TO in_documentheader-action,
     p_coarea TO in_documentheader-co_area,
     p_doc_dt TO in_documentheader-doc_date,
     p_pstgdt TO in_documentheader-postgdate,
     p_varnt  TO in_documentheader-variant,
     p_hdrtxt TO in_documentheader-doc_hdr_tx,
     p_sdcctr TO in_documentheader-send_cctr,
     p_acttyp TO in_documentheader-acttype,
     p_qty    TO in_documentheader-actvty_qty,
     p_uom    TO in_documentheader-activityun,
     p_price  TO in_documentheader-price,
     p_cur    TO in_documentheader-currency,
     p_itmtxt TO in_documentheader-seg_text,
     p_wbs    TO in_documentheader-rec_wbs_el.

CALL FUNCTION 'Z_RFC_POST_ACTALLOC'
  EXPORTING
    documentheader        = in_documentheader
*   IGNORE_WARNINGS       = ' '
  IMPORTING
   doc_no                 = l_doc_no
  TABLES
    return                = lt_return

.

WRITE: / 'Result of post:'.                             "#EC NOTEXT
PERFORM show_messages.

*---------------------------------------------------------------------*
*      Form  Show_messages
*---------------------------------------------------------------------*
FORM show_messages.

  IF lt_return[] IS INITIAL.
  IF NOT l_doc_no IS INITIAL.
     WRITE: / 'CO Document posted: ', l_doc_no.
  ELSE.
    WRITE: / 'no error messages'.
  ENDIF.
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
