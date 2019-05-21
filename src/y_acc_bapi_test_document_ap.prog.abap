*&---------------------------------------------------------------------*
*& Report  ACC_BAPI_TEST_DOCUMENT                                      *
*&                                                                     *
*&---------------------------------------------------------------------*
*& Test report, calls BAPI AcctngDocument                              *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  y_acc_bapi_test_document_ap                  .

SELECTION-SCREEN BEGIN OF BLOCK bl01 .

PARAMETERS:
  check_l             RADIOBUTTON GROUP rb1,
  check_a DEFAULT 'X' RADIOBUTTON GROUP rb1,
  post                RADIOBUTTON GROUP rb1.
SELECTION-SCREEN ULINE.
PARAMETERS:
  rev_c               RADIOBUTTON GROUP rb1,
  rev_p               RADIOBUTTON GROUP rb1.
SELECTION-SCREEN ULINE.
PARAMETERS:
*  ref_key LIKE bapiache01-obj_key DEFAULT 'TEST000001BAPICALL',
  dest    LIKE bdi_logsys-logsys  DEFAULT '          '.

SELECTION-SCREEN END   OF BLOCK bl01 .

DATA:
  ref_key LIKE bapiache01-obj_key VALUE 'TEST000001BAPICALL',
  gd_documentheader    LIKE bapiache09,
  gd_customercpd       LIKE bapiacpa09,
  gd_fica_hd           LIKE bapiaccahd,
  it_accountreceivable LIKE TABLE OF bapiacar09 WITH HEADER LINE,
  it_accountgl         LIKE TABLE OF bapiacgl09 WITH HEADER LINE,
  it_accounttax        LIKE TABLE OF bapiactx09 WITH HEADER LINE,
  it_criteria          LIKE TABLE OF bapiackec9 WITH HEADER LINE,
  it_valuefield        LIKE TABLE OF bapiackev9 WITH HEADER LINE,
  it_currencyamount    LIKE TABLE OF bapiaccr09 WITH HEADER LINE,
  it_return            LIKE TABLE OF bapiret2   WITH HEADER LINE,
  it_receivers         LIKE TABLE OF bdi_logsys WITH HEADER LINE,
  it_fica_it           LIKE TABLE OF bapiaccait WITH HEADER LINE,
  it_accountpayable    LIKE TABLE OF bapiacap09 WITH HEADER LINE,
  it_paymentcard       LIKE TABLE OF bapiacpc09 WITH HEADER LINE,
  it_ext               LIKE TABLE OF bapiacextc WITH HEADER LINE,
  it_re                LIKE TABLE OF bapiacre09 WITH HEADER LINE,
  it_ext2              LIKE TABLE OF bapiparex  WITH HEADER LINE.


PERFORM fill_internal_tables.

IF check_l = 'X'.

  CALL FUNCTION 'BAPI_ACC_DOCUMENT_CHECK'
       DESTINATION dest
       EXPORTING
            documentheader    = gd_documentheader
            customercpd       = gd_customercpd
            contractheader    = gd_fica_hd
       TABLES
            accountgl         = it_accountgl
            accountreceivable = it_accountreceivable
            accountpayable    = it_accountpayable
            accounttax        = it_accounttax
*     currencyamount    = it_currencyamount
            criteria          = it_criteria
            valuefield        = it_valuefield
            extension1        = it_ext
            return            = it_return
            paymentcard       = it_paymentcard
            contractitem      = it_fica_it
            extension2        = it_ext2
            realestate        = it_re.
  .

  WRITE: / 'Result of check lines:'.                        "#EC NOTEXT
  PERFORM show_messages.

ENDIF.

IF check_a = 'X'.

  CALL FUNCTION 'BAPI_ACC_DOCUMENT_CHECK'
    DESTINATION dest
    EXPORTING
      documentheader    = gd_documentheader
      customercpd       = gd_customercpd
      contractheader    = gd_fica_hd
    TABLES
      accountgl         = it_accountgl
      accountreceivable = it_accountreceivable
      accountpayable    = it_accountpayable
      accounttax        = it_accounttax
      currencyamount    = it_currencyamount
      criteria          = it_criteria
      valuefield        = it_valuefield
      extension1        = it_ext
      return            = it_return
      paymentcard       = it_paymentcard
      contractitem      = it_fica_it
      extension2        = it_ext2
      realestate        = it_re.

  WRITE: / 'Result of check all:'.                          "#EC NOTEXT
  PERFORM show_messages.

ENDIF.

IF post = 'X'.

  DATA: l_type LIKE gd_documentheader-obj_type,
        l_key  LIKE gd_documentheader-obj_key,
        l_sys  LIKE gd_documentheader-obj_sys.

  IF dest = space OR
     dest = gd_documentheader-obj_sys.
*    post synchron

    CALL FUNCTION 'BAPI_ACC_DOCUMENT_POST'
      EXPORTING
        documentheader    = gd_documentheader
        customercpd       = gd_customercpd
        contractheader    = gd_fica_hd
      IMPORTING
        obj_type          = l_type
        obj_key           = l_key
        obj_sys           = l_sys
      TABLES
        accountgl         = it_accountgl
        accountreceivable = it_accountreceivable
        accountpayable    = it_accountpayable
        accounttax        = it_accounttax
        currencyamount    = it_currencyamount
        criteria          = it_criteria
        valuefield        = it_valuefield
        extension1        = it_ext
        return            = it_return
        paymentcard       = it_paymentcard
        contractitem      = it_fica_it
        extension2        = it_ext2
        realestate        = it_re.
BREAK-POINT.
    WRITE: / 'Result of post:'.                             "#EC NOTEXT
    PERFORM show_messages.

  ELSE.
*   create Idoc

    it_receivers-logsys = dest.
    APPEND it_receivers.

    CALL FUNCTION 'ALE_ACC_DOCUMENT_POST'
      EXPORTING
        documentheader    = gd_documentheader
        customercpd       = gd_customercpd
        contractheader    = gd_fica_hd
      TABLES
        accountgl         = it_accountgl
        accountreceivable = it_accountreceivable
        accountpayable    = it_accountpayable
        accounttax        = it_accounttax
        currencyamount    = it_currencyamount
        criteria          = it_criteria
        valuefield        = it_valuefield
        extension1        = it_ext
        paymentcard       = it_paymentcard
        contractitem      = it_fica_it
        extension2        = it_ext2
        realestate        = it_re
        receivers         = it_receivers
*       COMMUNICATION_DOCUMENTS =
*       APPLICATION_OBJECTS  =
      EXCEPTIONS
        error_creating_idocs    = 1
        OTHERS                  = 2  .

    IF sy-subrc = 0.
      WRITE: / 'IDoc created'.                              "#EC NOTEXT
    ELSE.
      WRITE: sy-msgid.
    ENDIF.

  ENDIF.
ENDIF.

IF rev_p = 'X' OR rev_c = 'X'.
  DATA: rev LIKE bapiacrev,
        rev_key LIKE ref_key.

  rev_key       = ref_key.
  rev_key(1)    = 'R'.
  rev-obj_type  = gd_documentheader-obj_type.
  rev-obj_key   = rev_key.
  rev-obj_sys   = gd_documentheader-obj_sys.
  rev-obj_key_r = ref_key.

  IF rev_c IS INITIAL.
    IF dest = space OR
       dest = gd_documentheader-obj_sys.

      CALL FUNCTION 'BAPI_ACC_DOCUMENT_REV_POST'
        EXPORTING
          reversal = rev
          bus_act  = gd_documentheader-bus_act
        TABLES
          return   = it_return.
    ELSE.
      it_receivers-logsys = dest.
      APPEND it_receivers.

      CALL FUNCTION 'ALE_ACC_DOCUMENT_REV_POST'
        EXPORTING
          reversal                      = rev
          busact                        = gd_documentheader-bus_act
*         OBJ_TYPE             = 'BUS6035'
*         SERIAL_ID            = '0'
        TABLES
          receivers                     = it_receivers
*         COMMUNICATION_DOCUMENTS       =
*         APPLICATION_OBJECTS  =
        EXCEPTIONS
          error_creating_idocs = 1
          OTHERS               = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ELSE.
        WRITE: / 'IDoc created'.                            "#EC NOTEXT
      ENDIF.

    ENDIF.
  ELSE.
    CALL FUNCTION 'BAPI_ACC_DOCUMENT_REV_CHECK'
      EXPORTING
        reversal = rev
        bus_act  = gd_documentheader-bus_act
      TABLES
        return   = it_return.
  ENDIF.

  WRITE: / 'Result of Reversal Posting:'.                   "#EC NOTEXT
  PERFORM show_messages.

ENDIF.

COMMIT WORK.




*---------------------------------------------------------------------*
*      Form  fill_internal_tables
*---------------------------------------------------------------------*
FORM fill_internal_tables.

  PERFORM fill_header.
  PERFORM fill_accountgl.
  PERFORM fill_accountar.
  PERFORM fill_accountap.
  PERFORM fill_accounttax.
  PERFORM fill_currencyamount.
  PERFORM fill_criteria.
  PERFORM fill_valuefield.
  PERFORM fill_re.
  PERFORM fill_cpd.
  PERFORM fill_contractitem.
  PERFORM fill_contractheader.
  PERFORM fill_paymentcard.
  PERFORM fill_extension.

ENDFORM.                               " fill_internal_tables

*---------------------------------------------------------------------*
*      Form  Show_messages
*---------------------------------------------------------------------*
FORM show_messages.

  IF it_return[] IS INITIAL.
    WRITE: / 'no messages'.
  ELSE.
    SKIP 1.
    LOOP AT it_return.
      WRITE: /    it_return-type,
             (2)  it_return-id,
                  it_return-number,
             (80) it_return-message,
*                 IT_RETURN-LOG_NO
*                 IT_RETURN-LOG_MSG_NO
*                 IT_RETURN-MESSAGE_V1
*                 IT_RETURN-MESSAGE_V2
*                 IT_RETURN-MESSAGE_V3
*                 IT_RETURN-MESSAGE_V4
             (20) it_return-parameter,
             (3)  it_return-row,
                  it_return-field.
*                 IT_RETURN-SYSTEM
    ENDLOOP.
  ENDIF.

  ULINE.

ENDFORM.                               " Show_messages


*---------------------------------------------------------------------*
*       FORM fill_accountgl                                           *
*---------------------------------------------------------------------*
FORM fill_accountgl.

  CLEAR it_accountgl.
  it_accountgl-itemno_acc     = 2.
  it_accountgl-gl_account     = '6156000000'.
* IT_ACCOUNTGL-STAT_CON       =
* IT_ACCOUNTGL-REF_KEY_1      =
* IT_ACCOUNTGL-REF_KEY_2      =
* IT_ACCOUNTGL-REF_KEY_3      =
  it_accountgl-tax_code       = 'V3'.
* IT_ACCOUNTGL-ACCT_KEY       =
* IT_ACCOUNTGL-TAXJURCODE     =
* IT_ACCOUNTGL-CSHDIS_IND     =
* IT_ACCOUNTGL-ALLOC_NMBR     =
  it_accountgl-item_text      = 'BAPI Test G/L line item'.  "#EC NOTEXT
* IT_ACCOUNTGL-BUS_AREA       =
* it_accountgl-costcenter     =
* IT_ACCOUNTGL-ORDERID        =
* it_accountgl-ext_object_id  =
* it_accountgl-bus_scenario   =
* IT_ACCOUNTGL-MATERIAL       =
  IT_ACCOUNTGL-QUANTITY       = '40'. "VARIABLE"
  IT_ACCOUNTGL-BASE_UOM       = 'H'.
* IT_ACCOUNTGL-BASE_UOM_ISO   =
* IT_ACCOUNTGL-PLANT          =
* it_accountgl-profit_ctr     =
* IT_ACCOUNTGL-PART_PRCTR     =
  IT_ACCOUNTGL-WBS_ELEMENT    = '/000/BCH-002/VEND1'. "VARIABLE"
* IT_ACCOUNTGL-COSTCENTER = '1020000000'.
* IT_ACCOUNTGL-NETWORK        =
* IT_ACCOUNTGL-CMMT_ITEM      =
* IT_ACCOUNTGL-FUNDS_CTR      =
* IT_ACCOUNTGL-FUND           =
* IT_ACCOUNTGL-SALES_ORD      =
* IT_ACCOUNTGL-S_ORD_ITEM     =
* IT_ACCOUNTGL-P_EL_PRCTR     =
* IT_ACCOUNTGL-BILL_TYPE      =
* IT_ACCOUNTGL-DISTR_CHAN     =
* IT_ACCOUNTGL-SOLD_TO        =
* IT_ACCOUNTGL-DIVISION       =
* IT_ACCOUNTGL-SALESORG       =
* IT_ACCOUNTGL-SALES_OFF      =
* IT_ACCOUNTGL-SALES_GRP      =
* IT_ACCOUNTGL-INV_QTY        =
* IT_ACCOUNTGL-SALES_UNIT     =
* IT_ACCOUNTGL-SALES_UNIT_ISO =
* IT_ACCOUNTGL-INV_QTY_SU     =
* IT_ACCOUNTGL-NET_WEIGHT     =
* IT_ACCOUNTGL-GROSS_WT       =
* IT_ACCOUNTGL-UNIT_OF_WT     =
* IT_ACCOUNTGL-UNIT_OF_WT_ISO =
* IT_ACCOUNTGL-VOLUME         =
* IT_ACCOUNTGL-VOLUMEUNIT     =
* IT_ACCOUNTGL-VOLUMEUNIT_ISO =
* it_accountgl-fm_area        =
* it_accountgl-log_proc       =
* it_accountgl-ac_doc_no      =
* it_accountgl-acct_type      =
* it_accountgl-doc_type       =
* it_accountgl-comp_code      =
* it_accountgl-func_area      =
* it_accountgl-plant          =
* it_accountgl-fis_period     =
* it_accountgl-fisc_year      =
* it_accountgl-pstng_date     =
* it_accountgl-value_date     =
* it_accountgl-customer       =
* it_accountgl-vendor_no      =
* it_accountgl-costobject     =
* it_accountgl-acttype        =
* it_accountgl-order_itno     =
* it_accountgl-routing_no     =
* it_accountgl-activity       =
* it_accountgl-cond_type      =
* it_accountgl-cond_count     =
* it_accountgl-cond_st_no     =
* it_accountgl-co_busproc     =
* it_accountgl-asset_no       =
* it_accountgl-sub_number     =
* it_accountgl-de_cre_ind     =
* it_accountgl-p_el_prctr     =
* it_accountgl-xmfrw          =
* it_accountgl-po_pr_qnt      =
* it_accountgl-po_pr_uom      =
* it_accountgl-po_pr_uom_iso  =
* it_accountgl-entry_qnt      =
* it_accountgl-entry_uom      =
* it_accountgl-entry_uom_iso  =
* it_accountgl-item_cat       =
* it_accountgl-matl_type      =
* it_accountgl-mvt_ind        =
* it_accountgl-reval_ind      =
* it_accountgl-orig_group     =
* it_accountgl-orig_mat       =
* it_accountgl-serial_no      =
* it_accountgl-part_acct      =
* it_accountgl-tr_part_ba     =
* it_accountgl-trade_id       =
* it_accountgl-val_area       =
* it_accountgl-val_type       =
* it_accountgl-asval_date     =
* it_accountgl-po_number      =
* it_accountgl-po_item        =
  APPEND it_accountgl.

ENDFORM.                    "fill_accountgl

*---------------------------------------------------------------------*
*       FORM fill_header                                              *
*---------------------------------------------------------------------*
FORM fill_header.

  CALL FUNCTION 'OWN_LOGICAL_SYSTEM_GET'
    IMPORTING
      own_logical_system = gd_documentheader-obj_sys.

* OBJ_TYPE has to be replaced by customers object key (Y* or Z*)
  gd_documentheader-obj_type   = 'BKPFF'.
  gd_documentheader-obj_key    = '$'. "ref_key.
  gd_documentheader-username   = sy-uname.
  gd_documentheader-header_txt = 'BAPI Test Header'. "VARIABLE"               "#EC NOTEXT
* gd_documentheader-obj_key_r  =
* GD_DOCUMENTHEADER-reason_rev =
  gd_documentheader-comp_code  = 'BE10'.
* gd_documentheader-ac_doc_no  =
  gd_documentheader-fisc_year  = '2019'.
  gd_documentheader-doc_date   = sy-datum.
  gd_documentheader-pstng_date = sy-datum.
* GD_DOCUMENTHEADER-TRANS_DATE =
* GD_DOCUMENTHEADER-VALUE_DATE =
* GD_DOCUMENTHEADER-FIS_PERIOD =
 GD_DOCUMENTHEADER-DOC_TYPE   = 'KB'.
  gd_documentheader-ref_doc_no = 'TS00000011PZIN'. "VARIABLE'
* GD_DOCUMENTHEADER-COMPO_ACC  =
  gd_documentheader-bus_act    = 'RFBU'.

ENDFORM.                    "fill_header

*---------------------------------------------------------------------*
*       FORM fill_contractheader                                     *
*---------------------------------------------------------------------*
FORM fill_contractheader.

*  gd_fica_hd-doc_no           =
*  gd_fica_hd-doc_type_ca      =
*  gd_fica_hd-res_key          =
*  gd_fica_hd-fikey            =
*  gd_fica_hd-payment_form_ref =

ENDFORM.                    "fill_contractheader

*---------------------------------------------------------------------*
*       FORM fill_cpd                                                 *
*---------------------------------------------------------------------*
FORM fill_cpd.

*  gd_customercpd-name
*  gd_customercpd-name_2
*  gd_customercpd-name_3
*  gd_customercpd-name_4
*  gd_customercpd-postl_code
*  gd_customercpd-city
*  gd_customercpd-country
*  gd_customercpd-country_iso
*  gd_customercpd-street
*  gd_customercpd-po_box
*  gd_customercpd-pobx_pcd
*  gd_customercpd-pobk_curac
*  gd_customercpd-bank_acct
*  gd_customercpd-bank_no
*  gd_customercpd-bank_ctry
*  gd_customercpd-bank_ctry_iso
*  gd_customercpd-tax_no_1
*  gd_customercpd-tax_no_2
*  gd_customercpd-tax
*  gd_customercpd-equal_tax
*  gd_customercpd-region
*  gd_customercpd-ctrl_key
*  gd_customercpd-instr_key
*  gd_customercpd-dme_ind
*  gd_customercpd-langu_iso

ENDFORM.                    "fill_cpd

*---------------------------------------------------------------------*
*       FORM fill_ar                                                  *
*---------------------------------------------------------------------*
FORM fill_accountar.

* CLEAR it_accountreceivable.
* it_accountreceivable-itemno_acc =
* it_accountreceivable-customer   =
* IT_ACCOUNTRECEIVABLE-REF_KEY_1  =
* IT_ACCOUNTRECEIVABLE-REF_KEY_2  =
* IT_ACCOUNTRECEIVABLE-REF_KEY_3  =
* IT_ACCOUNTRECEIVABLE-PMNTTRMS   =
* IT_ACCOUNTRECEIVABLE-BLINE_DATE =
* IT_ACCOUNTRECEIVABLE-DSCT_DAYS1 =
* IT_ACCOUNTRECEIVABLE-DSCT_DAYS2 =
* IT_ACCOUNTRECEIVABLE-NETTERMS   =
* IT_ACCOUNTRECEIVABLE-DSCT_PCT1  =
* IT_ACCOUNTRECEIVABLE-DSCT_PCT2  =
* IT_ACCOUNTRECEIVABLE-PYMT_METH  =
* IT_ACCOUNTRECEIVABLE-DUNN_KEY   =
* IT_ACCOUNTRECEIVABLE-DUNN_BLOCK =
* IT_ACCOUNTRECEIVABLE-PMNT_BLOCK =
* IT_ACCOUNTRECEIVABLE-VAT_REG_NO =
* IT_ACCOUNTRECEIVABLE-ALLOC_NMBR =
* it_accountreceivable-item_text  =
* IT_ACCOUNTRECEIVABLE-PARTNER_BK =
* IT_ACCOUNTRECEIVABLE-GL_ACCOUNT =
* it_accountreceivable-comp_code
* it_accountreceivable-bus_area
* it_accountreceivable-pmtmthsupl
* it_accountreceivable-paymt_ref
* it_accountreceivable-scbank_ind
* it_accountreceivable-businessplace
* it_accountreceivable-sectioncode
* it_accountreceivable-branch
* it_accountreceivable-pymt_cur
* it_accountreceivable-pymt_cur_iso
* it_accountreceivable-pymt_amt
* it_accountreceivable-c_ctr_area
* it_accountreceivable-bank_id
* it_accountreceivable-supcountry
* it_accountreceivable-supcountry_iso
* it_accountreceivable-tax_code
* it_accountreceivable-taxjurcode
* it_accountreceivable-tax_date
* it_accountreceivable-sp_gl_ind
* it_accountreceivable-partner_guid = '1465464654'.
* APPEND it_accountreceivable.

ENDFORM.                    "fill_accountar

*---------------------------------------------------------------------*
*       FORM fill_ap                                                  *
*---------------------------------------------------------------------*
FORM fill_accountap.

  CLEAR it_accountpayable.
  it_accountpayable-itemno_acc = 1.
  it_accountpayable-vendor_no  = '0002000023'.
* it_accountpayable-gl_account
* it_accountpayable-ref_key_1
* it_accountpayable-ref_key_2
* it_accountpayable-ref_key_3
* it_accountpayable-comp_code
* it_accountpayable-bus_area
  it_accountpayable-pmnttrms = 'NT30'.
* it_accountpayable-bline_date
* it_accountpayable-dsct_days1
* it_accountpayable-dsct_days2
* it_accountpayable-netterms
* it_accountpayable-dsct_pct1
* it_accountpayable-dsct_pct2
* it_accountpayable-pymt_meth
* it_accountpayable-pmtmthsupl
* it_accountpayable-pmnt_block
* it_accountpayable-scbank_ind
* it_accountpayable-supcountry
* it_accountpayable-supcountry_iso
* it_accountpayable-bllsrv_ind
  it_accountpayable-alloc_nmbr = 'TS0000000010'.  "VARIABLE
  it_accountpayable-item_text  = 'BAPI Test A/P line item'. "#EC NOTEXT
* it_accountpayable-po_sub_no
* it_accountpayable-po_checkdg
* it_accountpayable-po_ref_no
* it_accountpayable-w_tax_code
* it_accountpayable-businessplace
* it_accountpayable-sectioncode
* it_accountpayable-instr1
* it_accountpayable-instr2
* it_accountpayable-instr3
* it_accountpayable-instr4
* it_accountpayable-branch
* it_accountpayable-pymt_cur
* it_accountpayable-pymt_amt
* it_accountpayable-pymt_cur_iso
* it_accountpayable-sp_gl_ind


  APPEND it_accountpayable.

ENDFORM.                    "fill_accountap

*---------------------------------------------------------------------*
*       FORM fill_tax                                                 *
*---------------------------------------------------------------------*
FORM fill_accounttax.

  CLEAR it_accounttax.
  it_accounttax-itemno_acc = 3.
  it_accounttax-gl_account = '4110000000'.
  it_accounttax-tax_code   = 'V3'.
  it_accounttax-acct_key   = 'VST'.
* it_accounttax-ITEMNO_TAX = '2'.
* IT_ACCOUNTTAX-TAXJURCODE =
  it_accounttax-cond_key   = 'MWVS'.
* IT_ACCOUNTTAX-TAX_RATE   =
* IT_ACCOUNTTAX-TAX_DATE   =
* IT_ACCOUNTTAX-STAT_CON   =
* IT_ACCOUNTTAX-taxjurcode_deep
* IT_ACCOUNTTAX-taxjurcode_level
  APPEND it_accounttax.

ENDFORM.                    "fill_accounttax

*---------------------------------------------------------------------*
*       FORM fill_currencyamount                                      *
*---------------------------------------------------------------------*
FORM fill_currencyamount.

  CLEAR it_currencyamount.
  it_currencyamount-itemno_acc   = 1.
  it_currencyamount-curr_type    = '00'.
  it_currencyamount-currency     = 'EUR'.
* IT_CURRENCYAMOUNT-CURRENCY_ISO =
  it_currencyamount-amt_doccur_long = -121.     "AFLE
* IT_CURRENCYAMOUNT-EXCH_RATE    = .
 it_currencyamount-amt_base     = -100.
* IT_CURRENCYAMOUNT-DISC_BASE    =
* it_currencyamount-exch_rate_v  =
* it_currencyamount-disc_amt     =
  APPEND it_currencyamount.

  CLEAR it_currencyamount.
  it_currencyamount-itemno_acc   = 2.
  it_currencyamount-curr_type    = '00'.
  it_currencyamount-currency     = 'EUR'.
* IT_CURRENCYAMOUNT-CURRENCY_ISO =
  it_currencyamount-amt_doccur_long   = 100.  "AFLE
* IT_CURRENCYAMOUNT-EXCH_RATE    =
   it_currencyamount-amt_base    = 100.
* IT_CURRENCYAMOUNT-DISC_BASE    =
*  it_currencyamount-exch_rate_v =
* it_currencyamount-disc_amt     =
  APPEND it_currencyamount.

  CLEAR it_currencyamount.
  it_currencyamount-itemno_acc   = 3.
  it_currencyamount-curr_type    = '00'.
  it_currencyamount-currency     = 'EUR'.
* it_currencyamount-currency_iso =
  it_currencyamount-amt_doccur_long   = 21.   "AFLE
* IT_CURRENCYAMOUNT-EXCH_RATE    =
  it_currencyamount-amt_base_long     = 100.  "AFLE
* IT_CURRENCYAMOUNT-DISC_BASE    =
* IT_CURRENCYAMOUNT-EXCH_RATE_V  =
* it_currencyamount-disc_amt     =
  APPEND it_currencyamount.

ENDFORM.                    "fill_currencyamount

*---------------------------------------------------------------------*
*       FORM fill_criteria                                            *
*---------------------------------------------------------------------*
FORM fill_criteria.

* CLEAR it_criteria.
* it_criteria-itemno_acc = 2.
* it_criteria-fieldname = 'BZIRK'.
* it_criteria-character = '000001'.
* append it_criteria.

ENDFORM.                    "fill_criteria

*---------------------------------------------------------------------*
*       FORM fill_valuefield                                          *
*---------------------------------------------------------------------*
FORM fill_valuefield.

* CLEAR it_valuefield.
* it_valuefield-itemno_acc = 2.
* it_valuefield-fieldname = 'VV010'.
* it_valuefield-curr_type
* it_valuefield-currency = 'EUR'.
* it_valuefield-currency_iso
* it_valuefield-amt_valcom
* it_valuefield-base_uom
* it_valuefield-base_uom_iso
* it_valuefield-qua_valcom
* append it_valuefield.

ENDFORM.                    "fill_valuefield

*---------------------------------------------------------------------*
*       FORM fill_extension                                           *
*---------------------------------------------------------------------*
FORM fill_extension.

* CLEAR it_ext.
* it_ext-field1
* it_ext-field2
* it_ext-field3
* it_ext-field4
* APPEND it_ext.

* DATA: ls_zzz TYPE ZZZ_ACCIT.
* CLEAR it_ext2.
* it_ext2-structure = 'ZZZ_ACCIT'.
*  ls_zzz-posnr = 2.
*  ls_zzz-awref_reb = '123654'.
*  ls_zzz-aworg_reb = '654654'.
*  ls_zzz-grant_nbr = '0022002'.
* MOVE ls_zzz TO it_ext2-valuepart1.
* APPEND it_ext2.

ENDFORM.                    "fill_extension

*---------------------------------------------------------------------*
*       FORM fill_paymentcard                                         *
*---------------------------------------------------------------------*
FORM fill_paymentcard.

*  CLEAR it_paymentcard.
*  it_paymentcard-itemno_acc = 1.
*  it_paymentcard-cc_glaccount
*  it_paymentcard-cc_type
*  it_paymentcard-cc_number
*  it_paymentcard-cc_seq_no
*  it_paymentcard-cc_valid_f
*  it_paymentcard-cc_valid_t
*  it_paymentcard-cc_name
*  it_paymentcard-dataorigin
*  it_paymentcard-authamount = '100'.
*  it_paymentcard-currency = 'EUR'.
*  it_paymentcard-currency_iso
*  it_paymentcard-cc_autth_no
*  it_paymentcard-auth_refno
*  it_paymentcard-auth_date
*  it_paymentcard-auth_time
*  it_paymentcard-merchidcl
*  it_paymentcard-point_of_receipt
*  it_paymentcard-terminal
*  it_paymentcard-cctyp = '1'.
*  APPEND it_paymentcard.

ENDFORM.                    "fill_paymentcard

*---------------------------------------------------------------------*
*       FORM fill_contractitem                                        *
*---------------------------------------------------------------------*
FORM fill_contractitem.

* CLEAR it_fica_it.
*  it_fica_it-itemno_acc
*  it_fica_it-cont_acct
*  it_fica_it-main_trans
*  it_fica_it-sub_trans
*  it_fica_it-func_area
*  it_fica_it-fm_area
*  it_fica_it-cmmt_item
*  it_fica_it-funds_ctr
*  it_fica_it-fund
* append it_fica_it.

ENDFORM.                    "fill_contractitem

*&---------------------------------------------------------------------*
*&      Form  fill_re
*&---------------------------------------------------------------------*
FORM fill_re .

*  CLEAR it_re.
*  it_re-itemno_acc      =
*  it_re-business_entity =
*  it_re-building        =
*  it_re-property        =
*  it_re-rental_object   =
*  it_re-serv_charge_key =
*  it_re-settlement_unit =
*  it_re-contract_no     =
*  APPEND it_re.
*

ENDFORM.                    "fill_re
