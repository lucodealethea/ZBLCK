FUNCTION-POOL zfm_fico_for_blck.            "MESSAGE-ID ..

* INCLUDE LZFM_FICO_FOR_BLCKD...             " Local class definition

DATA:
  gd_documentheader    LIKE bapiache09,
  it_accountgl         LIKE TABLE OF bapiacgl09 WITH HEADER LINE,
  it_accounttax        LIKE TABLE OF bapiactx09 WITH HEADER LINE,
  it_currencyamount    LIKE TABLE OF bapiaccr09 WITH HEADER LINE,
  lt_return            LIKE TABLE OF bapiret2   WITH HEADER LINE,
  it_accountpayable    LIKE TABLE OF bapiacap09 WITH HEADER LINE.

DATA: lt_mwdat TYPE STANDARD TABLE OF rtax1u15,
      wa_mwdat TYPE rtax1u15,
      wa_amount TYPE bapidoccur_31,
      wa_orig_amt_doccur_long TYPE bapidoccur_31,
      wa_orig_amt_base TYPE BAPIAMTBASE.

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
* gd_documentheader-obj_key_r  =
* GD_DOCUMENTHEADER-reason_rev =
* gd_documentheader-ac_doc_no  =
* GD_DOCUMENTHEADER-TRANS_DATE =
* GD_DOCUMENTHEADER-VALUE_DATE =
* GD_DOCUMENTHEADER-FIS_PERIOD =
 gd_documentheader-doc_type   = 'KB'.
* GD_DOCUMENTHEADER-COMPO_ACC  =
  gd_documentheader-bus_act    = 'RFBU'.

ENDFORM.                    "fill_header

*---------------------------------------------------------------------*
*       FORM fill_accountgl                                           *
*---------------------------------------------------------------------*
FORM fill_accountgl.

*  CLEAR it_accountgl.
  it_accountgl-itemno_acc     = 2.

* IT_ACCOUNTGL-STAT_CON       =
* IT_ACCOUNTGL-REF_KEY_1      =
* IT_ACCOUNTGL-REF_KEY_2      =
* IT_ACCOUNTGL-REF_KEY_3      =
  it_accountgl-tax_code       = 'V3'.
* IT_ACCOUNTGL-ACCT_KEY       =
* IT_ACCOUNTGL-TAXJURCODE     =
* IT_ACCOUNTGL-CSHDIS_IND     =
* IT_ACCOUNTGL-ALLOC_NMBR     =

* IT_ACCOUNTGL-BUS_AREA       =
* it_accountgl-costcenter     =
* IT_ACCOUNTGL-ORDERID        =
* it_accountgl-ext_object_id  =
* it_accountgl-bus_scenario   =
* IT_ACCOUNTGL-MATERIAL       =
* IT_ACCOUNTGL-BASE_UOM_ISO   =
* IT_ACCOUNTGL-PLANT          =
* it_accountgl-profit_ctr     =
* IT_ACCOUNTGL-PART_PRCTR     =
*  IT_ACCOUNTGL-COSTCENTER = '1020000000'.
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
*       FORM fill_ap                                                  *
*---------------------------------------------------------------------*
FORM fill_accountap.

*  CLEAR it_accountpayable.
  it_accountpayable-itemno_acc = 1.
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

  CLEAR: it_accounttax-tax_rate.
  it_accounttax-itemno_acc = 3.

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
FORM fill_currencyamount_1.

CLEAR: it_currencyamount-amt_base_long, it_currencyamount-itemno_acc, wa_amount.

CALL FUNCTION 'CALCULATE_TAX_FROM_GROSSAMOUNT'
  EXPORTING
    i_bukrs                         = gd_documentheader-comp_code
    i_mwskz                         = it_accountgl-tax_code
*   I_TXJCD                         = ' '
    i_waers                         = it_currencyamount-currency
    i_wrbtr                         = 0
 TABLES
   t_mwdat                         = lt_mwdat
         .
IF sy-subrc <> 0.
* Implement suitable error handling here
ELSE.
READ TABLE lt_mwdat INDEX 1 INTO wa_mwdat.
MOVE wa_mwdat-msatz TO it_accounttax-tax_rate.
ENDIF.

wa_amount = -1 * ( wa_orig_amt_base + ( ( wa_orig_amt_base * it_accounttax-tax_rate ) / 100 ) ).

  it_currencyamount-amt_doccur_long = wa_amount.

  it_currencyamount-amt_base = -1 * it_currencyamount-amt_base.
  it_currencyamount-itemno_acc   = 1.
  it_currencyamount-curr_type    = '00'.
* IT_CURRENCYAMOUNT-CURRENCY_ISO =
* IT_CURRENCYAMOUNT-EXCH_RATE    = .
* it_currencyamount-amt_base     =
* IT_CURRENCYAMOUNT-DISC_BASE    =
* it_currencyamount-exch_rate_v  =
* it_currencyamount-disc_amt     =
  APPEND it_currencyamount.
ENDFORM.                    "fill_currencyamount_1

FORM fill_currencyamount_2.
  CLEAR: it_currencyamount-itemno_acc, wa_amount.
  it_currencyamount-amt_doccur_long = wa_orig_amt_doccur_long.
* was -1 in line 2
  it_currencyamount-amt_base = -1 * it_currencyamount-amt_base.
  it_currencyamount-itemno_acc   = 2.
  it_currencyamount-curr_type    = '00'.
* IT_CURRENCYAMOUNT-CURRENCY_ISO =
* IT_CURRENCYAMOUNT-EXCH_RATE    =
*  it_currencyamount-amt_base    =
* IT_CURRENCYAMOUNT-DISC_BASE    =
*  it_currencyamount-exch_rate_v =
* it_currencyamount-disc_amt     =
  APPEND it_currencyamount.
ENDFORM.                    "fill_currencyamount_2

FORM fill_currencyamount_3.
  CLEAR: it_currencyamount-itemno_acc, wa_amount, it_currencyamount-amt_base.
  it_currencyamount-amt_base_long = wa_orig_amt_base.
  wa_amount = ( ( wa_orig_amt_base * wa_mwdat-msatz ) / 100 ).
  it_currencyamount-amt_doccur_long = wa_amount.
  it_currencyamount-itemno_acc   = 3.
  it_currencyamount-curr_type    = '00'.
* it_currencyamount-currency_iso =
* IT_CURRENCYAMOUNT-EXCH_RATE    =
* IT_CURRENCYAMOUNT-DISC_BASE    =
* IT_CURRENCYAMOUNT-EXCH_RATE_V  =
* it_currencyamount-disc_amt     =
  APPEND it_currencyamount.

ENDFORM.                    "fill_currencyamount_3
