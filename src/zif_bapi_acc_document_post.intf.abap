interface ZIF_BAPI_ACC_DOCUMENT_POST
  public .


  types:
    AWTYP type C length 000005 .
  types:
    AWKEY type C length 000020 .
  types:
    AWSYS type C length 000010 .
  types:
    GLVOR type C length 000004 .
  types:
    USNAM type C length 000012 .
  types:
    BKTXT type C length 000025 .
  types:
    BUKRS type C length 000004 .
  types:
    GJAHR type N length 000004 .
  types:
    MONAT type N length 000002 .
  types:
    BLART type C length 000002 .
  types:
    XBLNR type C length 000016 .
  types:
    BELNR_D type C length 000010 .
  types:
    AWKEY_REV type C length 000020 .
  types:
    ACPI_STGRD type C length 000002 .
  types:
    COMPO type C length 000004 .
  types:
    XBLNR_LONG type C length 000035 .
  types:
    ACCOUNTING_PRINCIPLE type C length 000004 .
  types:
    XNEGP type C length 000001 .
  types:
    AWKEY_REB type C length 000020 .
  types:
    FKTYP type C length 000001 .
  types:
    ACC_DTE_ECS_IF_TYPE type C length 000010 .
  types:
    BAPI_PART_REV type C length 000001 .
  types:
    BAPI_ACC_DOC_STATUS type C length 000001 .
  types:
    begin of BAPIACHE09,
      OBJ_TYPE type AWTYP,
      OBJ_KEY type AWKEY,
      OBJ_SYS type AWSYS,
      BUS_ACT type GLVOR,
      USERNAME type USNAM,
      HEADER_TXT type BKTXT,
      COMP_CODE type BUKRS,
      DOC_DATE type DATS,
      PSTNG_DATE type DATS,
      TRANS_DATE type DATS,
      FISC_YEAR type GJAHR,
      FIS_PERIOD type MONAT,
      DOC_TYPE type BLART,
      REF_DOC_NO type XBLNR,
      AC_DOC_NO type BELNR_D,
      OBJ_KEY_R type AWKEY_REV,
      REASON_REV type ACPI_STGRD,
      COMPO_ACC type COMPO,
      REF_DOC_NO_LONG type XBLNR_LONG,
      ACC_PRINCIPLE type ACCOUNTING_PRINCIPLE,
      NEG_POSTNG type XNEGP,
      OBJ_KEY_INV type AWKEY_REB,
      BILL_CATEGORY type FKTYP,
      VATDATE type DATS,
      INVOICE_REC_DATE type DATS,
      ECS_ENV type ACC_DTE_ECS_IF_TYPE,
      PARTIAL_REV type BAPI_PART_REV,
      DOC_STATUS type BAPI_ACC_DOC_STATUS,
    end of BAPIACHE09 .
  types:
    ACPI_DOC_NO type C length 000012 .
  types:
    ACPI_DOC_TYPE_CA type C length 000002 .
  types:
    ACPI_RES_KEY type C length 000030 .
  types:
    ACPI_FIKEY type C length 000012 .
  types:
    ACPI_PMNT_FORM_REF type C length 000030 .
  types:
    begin of BAPIACCAHD,
      DOC_NO type ACPI_DOC_NO,
      DOC_TYPE_CA type ACPI_DOC_TYPE_CA,
      RES_KEY type ACPI_RES_KEY,
      FIKEY type ACPI_FIKEY,
      PAYMENT_FORM_REF type ACPI_PMNT_FORM_REF,
    end of BAPIACCAHD .
  types:
    NAME1_GP type C length 000035 .
  types:
    NAME2_GP type C length 000035 .
  types:
    NAME3_GP type C length 000035 .
  types:
    NAME4_GP type C length 000035 .
  types:
    PSTLZ type C length 000010 .
  types:
    ORT01_GP type C length 000035 .
  types:
    LAND1_GP type C length 000003 .
  types:
    LAND1_ISO type C length 000002 .
  types:
    STRAS_GP type C length 000035 .
  types:
    PFACH type C length 000010 .
  types:
    PSTL2 type C length 000010 .
  types:
    PSKTO type C length 000016 .
  types:
    BANKN type C length 000018 .
  types:
    BANKL type C length 000015 .
  types:
    BANKS type C length 000003 .
  types:
    BANKS_ISO type C length 000002 .
  types:
    STCD1 type C length 000016 .
  types:
    STCD2 type C length 000011 .
  types:
    STKZU type C length 000001 .
  types:
    ACPI_STKZA type C length 000001 .
  types:
    REGIO type C length 000003 .
  types:
    BKONT type C length 000002 .
  types:
    DTAWS type C length 000002 .
  types:
    DTAMS type C length 000001 .
  types:
    LAISO type C length 000002 .
  types:
    IBAN type C length 000034 .
  types:
    SWIFT type C length 000011 .
  types:
    STCD3 type C length 000018 .
  types:
    STCD4 type C length 000018 .
  types:
    ANRED type C length 000015 .
  types:
    STCD5 type C length 000060 .
  types:
    begin of BAPIACPA09,
      NAME type NAME1_GP,
      NAME_2 type NAME2_GP,
      NAME_3 type NAME3_GP,
      NAME_4 type NAME4_GP,
      POSTL_CODE type PSTLZ,
      CITY type ORT01_GP,
      COUNTRY type LAND1_GP,
      COUNTRY_ISO type LAND1_ISO,
      STREET type STRAS_GP,
      PO_BOX type PFACH,
      POBX_PCD type PSTL2,
      POBK_CURAC type PSKTO,
      BANK_ACCT type BANKN,
      BANK_NO type BANKL,
      BANK_CTRY type BANKS,
      BANK_CTRY_ISO type BANKS_ISO,
      TAX_NO_1 type STCD1,
      TAX_NO_2 type STCD2,
      TAX type STKZU,
      EQUAL_TAX type ACPI_STKZA,
      REGION type REGIO,
      CTRL_KEY type BKONT,
      INSTR_KEY type DTAWS,
      DME_IND type DTAMS,
      LANGU_ISO type LAISO,
      IBAN type IBAN,
      SWIFT_CODE type SWIFT,
      TAX_NO_3 type STCD3,
      TAX_NO_4 type STCD4,
      TITLE type ANRED,
      TAX_NO_5 type STCD5,
    end of BAPIACPA09 .
  types:
    POSNR_ACC type N length 000010 .
  types:
    HKONT type C length 000010 .
  types:
    SGTXT type C length 000050 .
  types:
    ACPI_KSTAZ type C length 000001 .
  types:
    LOGVO type C length 000006 .
  types:
    XREF1 type C length 000012 .
  types:
    XREF2 type C length 000012 .
  types:
    XREF3 type C length 000020 .
  types:
    KTOSL type C length 000003 .
  types:
    KOART type C length 000001 .
  types:
    GSBER type C length 000004 .
  types:
    FKBER_SHORT type C length 000004 .
  types:
    WERKS_D type C length 000004 .
  types:
    FIKRS type C length 000004 .
  types:
    KUNNR type C length 000010 .
  types:
    XSKRL type C length 000001 .
  types:
    LIFNR type C length 000010 .
  types:
    ACPI_ZUONR type C length 000018 .
  types:
    MWSKZ type C length 000002 .
  types:
    TXJCD type C length 000015 .
  types:
    ACPI_IAOM_EO_ID type C length 000034 .
  types:
    ACPI_IAOM_BS_ID type C length 000016 .
  types:
    KSTRG type C length 000012 .
  types:
    KOSTL type C length 000010 .
  types:
    LSTAR type C length 000006 .
  types:
    PRCTR type C length 000010 .
  types:
    PPRCTR type C length 000010 .
  types:
    NPLNR type C length 000012 .
  types:
    PS_POSID type C length 000024 .
  types:
    AUFNR type C length 000012 .
  types:
    CO_POSNR type N length 000004 .
  types:
    CO_AUFPL type N length 000010 .
  types:
    VORNR type C length 000004 .
  types:
    KSCHA type C length 000004 .
  types:
    ACPI_DZAEHK type N length 000002 .
  types:
    ACPI_STUNR type N length 000003 .
  types:
    BP_GEBER type C length 000010 .
  types:
    FISTL type C length 000016 .
  types:
    FIPOS type C length 000014 .
  types:
    CO_PRZNR type C length 000012 .
  types:
    ANLN1 type C length 000012 .
  types:
    ANLN2 type C length 000004 .
  types:
    FKART type C length 000004 .
  types:
    KDAUF type C length 000010 .
  types:
    KDPOS type N length 000006 .
  types:
    VTWEG type C length 000002 .
  types:
    SPART type C length 000002 .
  types:
    VKORG type C length 000004 .
  types:
    VKGRP type C length 000003 .
  types:
    VKBUR type C length 000004 .
  types:
    KUNAG type C length 000010 .
  types:
    ACPI_TBTKZ type C length 000001 .
  types:
    ACPI_EPRCTR type C length 000010 .
  types:
    ACPI_XMFRW type C length 000001 .
  types:
    MENGE_D type P length 7  decimals 000003 .
  types:
    MEINS type C length 000003 .
  types:
    MEINS_ISO type C length 000003 .
  types:
    ACPI_FKIMG type P length 7  decimals 000003 .
  types:
    ACPI_FKLMG type P length 7  decimals 000003 .
  types:
    VRKME type C length 000003 .
  types:
    ACPI_VRKME_ISO type C length 000003 .
  types:
    ACPI_BPMNG type P length 7  decimals 000003 .
  types:
    ACPI_BPRME type C length 000003 .
  types:
    BPRME_ISO type C length 000003 .
  types:
    ERFMG type P length 7  decimals 000003 .
  types:
    ERFME type C length 000003 .
  types:
    ERFME_ISO type C length 000003 .
  types:
    ACPI_VOLUM_15 type P length 8  decimals 000003 .
  types:
    ACPI_VOLEH type C length 000003 .
  types:
    ACPI_VOLEH_ISO type C length 000003 .
  types:
    ACPI_BRGEW_15 type P length 8  decimals 000003 .
  types:
    ACPI_NTGEW_15 type P length 8  decimals 000003 .
  types:
    ACPI_GEWEI type C length 000003 .
  types:
    ACPI_GEWEI_ISO type C length 000003 .
  types:
    ACPI_PSTYP type C length 000001 .
  types:
    MATNR18 type C length 000018 .
  types:
    ACPI_MTART type C length 000004 .
  types:
    KZBEW type C length 000001 .
  types:
    ACPI_XUMBW type C length 000001 .
  types:
    HRKFT type C length 000004 .
  types:
    HKMAT type C length 000001 .
  types:
    ACPI_DZEKKN type N length 000002 .
  types:
    JV_PART type C length 000010 .
  types:
    PARGB type C length 000004 .
  types:
    RASSC type C length 000006 .
  types:
    BWKEY type C length 000004 .
  types:
    BWTAR_D type C length 000010 .
  types:
    EBELN type C length 000010 .
  types:
    EBELP type N length 000005 .
  types:
    POSNR type N length 000006 .
  types:
    ACPI_KNTYP type C length 000001 .
  types:
    FKBER type C length 000016 .
  types:
    FM_FIPEX type C length 000024 .
  types:
    GM_GRANT_NBR type C length 000020 .
  types:
    RMVCT type C length 000003 .
  types:
    FM_MEASURE type C length 000024 .
  types:
    FB_SEGMENT type C length 000010 .
  types:
    FB_PSEGMENT type C length 000010 .
  types:
    KBLNR type C length 000010 .
  types:
    KBLPOS type N length 000003 .
  types:
    EXCLUDE_FLG type C length 000001 .
  types:
    FMFG_FASTPAY_FLG type C length 000001 .
  types:
    GM_PGRANT_NBR type C length 000020 .
  types:
    FM_BUDGET_PERIOD type C length 000010 .
  types:
    FM_PBUDGET_PERIOD type C length 000010 .
  types:
    FM_PFUND type C length 000010 .
  types:
    TAXPS type N length 000006 .
  types:
    GTR_CRM_PAYMENT_TYPE type C length 000004 .
  types:
    GTR_CRM_EXPENSE_CAT type C length 000004 .
  types:
    GTR_CRM_PROG_PROFILE type C length 000010 .
  types:
    MATNR40 type C length 000040 .
  types:
    HBKID type C length 000005 .
  types:
    HKTID type C length 000005 .
  types:
    PERNR_D type N length 000008 .
  types:
    ACR_OBJ_TYPE type C length 000004 .
  types:
    ACR_OBJ_ID type C length 000032 .
  types:
    ACR_SUBOBJ_ID type C length 000032 .
  types:
    ACR_ITEM_TYPE type C length 000011 .
  types:
    VAL_OBJ_TYPE type C length 000004 .
  types:
    VAL_OBJ_ID type C length 000032 .
  types:
    VAL_SUBOBJ_ID type C length 000032 .
  types:
    begin of BAPIACGL09,
      ITEMNO_ACC type POSNR_ACC,
      GL_ACCOUNT type HKONT,
      ITEM_TEXT type SGTXT,
      STAT_CON type ACPI_KSTAZ,
      LOG_PROC type LOGVO,
      AC_DOC_NO type BELNR_D,
      REF_KEY_1 type XREF1,
      REF_KEY_2 type XREF2,
      REF_KEY_3 type XREF3,
      ACCT_KEY type KTOSL,
      ACCT_TYPE type KOART,
      DOC_TYPE type BLART,
      COMP_CODE type BUKRS,
      BUS_AREA type GSBER,
      FUNC_AREA type FKBER_SHORT,
      PLANT type WERKS_D,
      FIS_PERIOD type MONAT,
      FISC_YEAR type GJAHR,
      PSTNG_DATE type DATS,
      VALUE_DATE type DATS,
      FM_AREA type FIKRS,
      CUSTOMER type KUNNR,
      CSHDIS_IND type XSKRL,
      VENDOR_NO type LIFNR,
      ALLOC_NMBR type ACPI_ZUONR,
      TAX_CODE type MWSKZ,
      TAXJURCODE type TXJCD,
      EXT_OBJECT_ID type ACPI_IAOM_EO_ID,
      BUS_SCENARIO type ACPI_IAOM_BS_ID,
      COSTOBJECT type KSTRG,
      COSTCENTER type KOSTL,
      ACTTYPE type LSTAR,
      PROFIT_CTR type PRCTR,
      PART_PRCTR type PPRCTR,
      NETWORK type NPLNR,
      WBS_ELEMENT type PS_POSID,
      ORDERID type AUFNR,
      ORDER_ITNO type CO_POSNR,
      ROUTING_NO type CO_AUFPL,
      ACTIVITY type VORNR,
      COND_TYPE type KSCHA,
      COND_COUNT type ACPI_DZAEHK,
      COND_ST_NO type ACPI_STUNR,
      FUND type BP_GEBER,
      FUNDS_CTR type FISTL,
      CMMT_ITEM type FIPOS,
      CO_BUSPROC type CO_PRZNR,
      ASSET_NO type ANLN1,
      SUB_NUMBER type ANLN2,
      BILL_TYPE type FKART,
      SALES_ORD type KDAUF,
      S_ORD_ITEM type KDPOS,
      DISTR_CHAN type VTWEG,
      DIVISION type SPART,
      SALESORG type VKORG,
      SALES_GRP type VKGRP,
      SALES_OFF type VKBUR,
      SOLD_TO type KUNAG,
      DE_CRE_IND type ACPI_TBTKZ,
      P_EL_PRCTR type ACPI_EPRCTR,
      XMFRW type ACPI_XMFRW,
      QUANTITY type MENGE_D,
      BASE_UOM type MEINS,
      BASE_UOM_ISO type MEINS_ISO,
      INV_QTY type ACPI_FKIMG,
      INV_QTY_SU type ACPI_FKLMG,
      SALES_UNIT type VRKME,
      SALES_UNIT_ISO type ACPI_VRKME_ISO,
      PO_PR_QNT type ACPI_BPMNG,
      PO_PR_UOM type ACPI_BPRME,
      PO_PR_UOM_ISO type BPRME_ISO,
      ENTRY_QNT type ERFMG,
      ENTRY_UOM type ERFME,
      ENTRY_UOM_ISO type ERFME_ISO,
      VOLUME type ACPI_VOLUM_15,
      VOLUMEUNIT type ACPI_VOLEH,
      VOLUMEUNIT_ISO type ACPI_VOLEH_ISO,
      GROSS_WT type ACPI_BRGEW_15,
      NET_WEIGHT type ACPI_NTGEW_15,
      UNIT_OF_WT type ACPI_GEWEI,
      UNIT_OF_WT_ISO type ACPI_GEWEI_ISO,
      ITEM_CAT type ACPI_PSTYP,
      MATERIAL type MATNR18,
      MATL_TYPE type ACPI_MTART,
      MVT_IND type KZBEW,
      REVAL_IND type ACPI_XUMBW,
      ORIG_GROUP type HRKFT,
      ORIG_MAT type HKMAT,
      SERIAL_NO type ACPI_DZEKKN,
      PART_ACCT type JV_PART,
      TR_PART_BA type PARGB,
      TRADE_ID type RASSC,
      VAL_AREA type BWKEY,
      VAL_TYPE type BWTAR_D,
      ASVAL_DATE type DATS,
      PO_NUMBER type EBELN,
      PO_ITEM type EBELP,
      ITM_NUMBER type POSNR,
      COND_CATEGORY type ACPI_KNTYP,
      FUNC_AREA_LONG type FKBER,
      CMMT_ITEM_LONG type FM_FIPEX,
      GRANT_NBR type GM_GRANT_NBR,
      CS_TRANS_T type RMVCT,
      MEASURE type FM_MEASURE,
      SEGMENT type FB_SEGMENT,
      PARTNER_SEGMENT type FB_PSEGMENT,
      RES_DOC type KBLNR,
      RES_ITEM type KBLPOS,
      BILLING_PERIOD_START_DATE type DATS,
      BILLING_PERIOD_END_DATE type DATS,
      PPA_EX_IND type EXCLUDE_FLG,
      FASTPAY type FMFG_FASTPAY_FLG,
      PARTNER_GRANT_NBR type GM_PGRANT_NBR,
      BUDGET_PERIOD type FM_BUDGET_PERIOD,
      PARTNER_BUDGET_PERIOD type FM_PBUDGET_PERIOD,
      PARTNER_FUND type FM_PFUND,
      ITEMNO_TAX type TAXPS,
      PAYMENT_TYPE type GTR_CRM_PAYMENT_TYPE,
      EXPENSE_TYPE type GTR_CRM_EXPENSE_CAT,
      PROGRAM_PROFILE type GTR_CRM_PROG_PROFILE,
      MATERIAL_LONG type MATNR40,
      HOUSEBANKID type HBKID,
      HOUSEBANKACCTID type HKTID,
      PERSON_NO type PERNR_D,
      ACROBJ_TYPE type ACR_OBJ_TYPE,
      ACROBJ_ID type ACR_OBJ_ID,
      ACRSUBOBJ_ID type ACR_SUBOBJ_ID,
      ACRITEM_TYPE type ACR_ITEM_TYPE,
      VALOBJTYPE type VAL_OBJ_TYPE,
      VALOBJ_ID type VAL_OBJ_ID,
      VALSUBOBJ_ID type VAL_SUBOBJ_ID,
    end of BAPIACGL09 .
  types:
    __BAPIACGL09                   type standard table of BAPIACGL09                     with non-unique default key .
  types:
    ACPI_ZTERM type C length 000004 .
  types:
    ACPI_ZBD1T type P length 2  decimals 000000 .
  types:
    ACPI_ZBD2T type P length 2  decimals 000000 .
  types:
    ACPI_ZBD3T type P length 2  decimals 000000 .
  types:
    ACPI_ZBD1P type P length 3  decimals 000003 .
  types:
    ACPI_ZBD2P type P length 3  decimals 000003 .
  types:
    ACPI_ZLSCH type C length 000001 .
  types:
    UZAWE type C length 000002 .
  types:
    ACPI_ZLSPR type C length 000001 .
  types:
    LZBKZ type C length 000003 .
  types:
    LANDL type C length 000003 .
  types:
    LANDL_ISO type C length 000002 .
  types:
    DIEKZ type C length 000001 .
  types:
    ESRNR type C length 000011 .
  types:
    ESRPZ type C length 000002 .
  types:
    ESRRE type C length 000027 .
  types:
    ACPI_QSSKZ type C length 000002 .
  types:
    ACPI_BRANCH type C length 000004 .
  types:
    ACPI_SECCO1 type C length 000004 .
  types:
    DTAT16 type N length 000002 .
  types:
    DTAT17 type N length 000002 .
  types:
    DTAT18 type N length 000002 .
  types:
    DTAT19 type N length 000002 .
  types:
    ACPI_FILKD type C length 000010 .
  types:
    ACPI_PYCUR type C length 000005 .
  types:
    ACPI_PYAMT type P length 12  decimals 000004 .
  types:
    WAERS_ISO type C length 000003 .
  types:
    ACPI_UMSKZ type C length 000001 .
  types:
    VVABWZE type C length 000010 .
  types:
    VVBVTYPABW type C length 000004 .
  types:
    BVTYP type C length 000004 .
  types:
    ACPI_GC_PARTNEG type C length 000032 .
  types:
    BCODE type C length 000005 .
  types:
    ACPI_KIDNO type C length 000030 .
  types:
    ACPI_PYAMT_31 type P length 16  decimals 000008 .
  types:
    begin of BAPIACAP09,
      ITEMNO_ACC type POSNR_ACC,
      VENDOR_NO type LIFNR,
      GL_ACCOUNT type HKONT,
      REF_KEY_1 type XREF1,
      REF_KEY_2 type XREF2,
      REF_KEY_3 type XREF3,
      COMP_CODE type BUKRS,
      BUS_AREA type GSBER,
      PMNTTRMS type ACPI_ZTERM,
      BLINE_DATE type DATS,
      DSCT_DAYS1 type ACPI_ZBD1T,
      DSCT_DAYS2 type ACPI_ZBD2T,
      NETTERMS type ACPI_ZBD3T,
      DSCT_PCT1 type ACPI_ZBD1P,
      DSCT_PCT2 type ACPI_ZBD2P,
      PYMT_METH type ACPI_ZLSCH,
      PMTMTHSUPL type UZAWE,
      PMNT_BLOCK type ACPI_ZLSPR,
      SCBANK_IND type LZBKZ,
      SUPCOUNTRY type LANDL,
      SUPCOUNTRY_ISO type LANDL_ISO,
      BLLSRV_IND type DIEKZ,
      ALLOC_NMBR type ACPI_ZUONR,
      ITEM_TEXT type SGTXT,
      PO_SUB_NO type ESRNR,
      PO_CHECKDG type ESRPZ,
      PO_REF_NO type ESRRE,
      W_TAX_CODE type ACPI_QSSKZ,
      BUSINESSPLACE type ACPI_BRANCH,
      SECTIONCODE type ACPI_SECCO1,
      INSTR1 type DTAT16,
      INSTR2 type DTAT17,
      INSTR3 type DTAT18,
      INSTR4 type DTAT19,
      BRANCH type ACPI_FILKD,
      PYMT_CUR type ACPI_PYCUR,
      PYMT_AMT type ACPI_PYAMT,
      PYMT_CUR_ISO type WAERS_ISO,
      SP_GL_IND type ACPI_UMSKZ,
      TAX_CODE type MWSKZ,
      TAX_DATE type DATS,
      TAXJURCODE type TXJCD,
      ALT_PAYEE type VVABWZE,
      ALT_PAYEE_BANK type VVBVTYPABW,
      PARTNER_BK type BVTYP,
      BANK_ID type HBKID,
      PARTNER_GUID type ACPI_GC_PARTNEG,
      PROFIT_CTR type PRCTR,
      FUND type BP_GEBER,
      GRANT_NBR type GM_GRANT_NBR,
      MEASURE type FM_MEASURE,
      HOUSEBANKACCTID type HKTID,
      BUDGET_PERIOD type FM_BUDGET_PERIOD,
      PPA_EX_IND type EXCLUDE_FLG,
      PART_BUSINESSPLACE type BCODE,
      PAYMT_REF type ACPI_KIDNO,
      PYMT_AMT_LONG type ACPI_PYAMT_31,
    end of BAPIACAP09 .
  types:
    __BAPIACAP09                   type standard table of BAPIACAP09                     with non-unique default key .
  types:
    ACPI_MSCHL type C length 000001 .
  types:
    ACPI_MANSP type C length 000001 .
  types:
    STCEG type C length 000020 .
  types:
    ACPI_KKBER type C length 000004 .
  types:
    ACPI_MABER type C length 000002 .
  types:
    SCMG_CASE_GUID type C length 000032 .
  types:
    FM_FUND_LONG type C length 000020 .
  types:
    DISPUTE_IF_TYPE type C length 000001 .
  types:
    COM_WEC_PAYMENT_SRV_PROVIDER type C length 000004 .
  types:
    FPS_TRANSACTION type C length 000035 .
  types:
    SEPA_MNDID type C length 000035 .
  types:
    EGMLD_BSEZ type C length 000003 .
  types:
    begin of BAPIACAR09,
      ITEMNO_ACC type POSNR_ACC,
      CUSTOMER type KUNNR,
      GL_ACCOUNT type HKONT,
      REF_KEY_1 type XREF1,
      REF_KEY_2 type XREF2,
      REF_KEY_3 type XREF3,
      COMP_CODE type BUKRS,
      BUS_AREA type GSBER,
      PMNTTRMS type ACPI_ZTERM,
      BLINE_DATE type DATS,
      DSCT_DAYS1 type ACPI_ZBD1T,
      DSCT_DAYS2 type ACPI_ZBD2T,
      NETTERMS type ACPI_ZBD3T,
      DSCT_PCT1 type ACPI_ZBD1P,
      DSCT_PCT2 type ACPI_ZBD2P,
      PYMT_METH type ACPI_ZLSCH,
      PMTMTHSUPL type UZAWE,
      PAYMT_REF type ACPI_KIDNO,
      DUNN_KEY type ACPI_MSCHL,
      DUNN_BLOCK type ACPI_MANSP,
      PMNT_BLOCK type ACPI_ZLSPR,
      VAT_REG_NO type STCEG,
      ALLOC_NMBR type ACPI_ZUONR,
      ITEM_TEXT type SGTXT,
      PARTNER_BK type BVTYP,
      SCBANK_IND type LZBKZ,
      BUSINESSPLACE type ACPI_BRANCH,
      SECTIONCODE type ACPI_SECCO1,
      BRANCH type ACPI_FILKD,
      PYMT_CUR type ACPI_PYCUR,
      PYMT_CUR_ISO type WAERS_ISO,
      PYMT_AMT type ACPI_PYAMT,
      C_CTR_AREA type ACPI_KKBER,
      BANK_ID type HBKID,
      SUPCOUNTRY type LANDL,
      SUPCOUNTRY_ISO type LANDL_ISO,
      TAX_CODE type MWSKZ,
      TAXJURCODE type TXJCD,
      TAX_DATE type DATS,
      SP_GL_IND type ACPI_UMSKZ,
      PARTNER_GUID type ACPI_GC_PARTNEG,
      ALT_PAYEE type VVABWZE,
      ALT_PAYEE_BANK type VVBVTYPABW,
      DUNN_AREA type ACPI_MABER,
      CASE_GUID type SCMG_CASE_GUID,
      PROFIT_CTR type PRCTR,
      FUND type BP_GEBER,
      GRANT_NBR type GM_GRANT_NBR,
      MEASURE type FM_MEASURE,
      HOUSEBANKACCTID type HKTID,
      RES_DOC type KBLNR,
      RES_ITEM type KBLPOS,
      FUND_LONG type FM_FUND_LONG,
      DISPUTE_IF_TYPE type DISPUTE_IF_TYPE,
      BUDGET_PERIOD type FM_BUDGET_PERIOD,
      PAYS_PROV type COM_WEC_PAYMENT_SRV_PROVIDER,
      PAYS_TRAN type FPS_TRANSACTION,
      SEPA_MANDATE_ID type SEPA_MNDID,
      PART_BUSINESSPLACE type BCODE,
      REP_COUNTRY_EU type EGMLD_BSEZ,
      PYMT_AMT_LONG type ACPI_PYAMT_31,
    end of BAPIACAR09 .
  types:
    __BAPIACAR09                   type standard table of BAPIACAR09                     with non-unique default key .
  types:
    KSCHL type C length 000004 .
  types:
    MSATZ_F05L type P length 4  decimals 000003 .
  types:
    ACPI_TXJCD_DEEP type C length 000015 .
  types:
    ACPI_TXJCD_LEVEL type C length 000001 .
  types:
    BAPI_FLG_DIR type C length 000001 .
  types:
    begin of BAPIACTX09,
      ITEMNO_ACC type POSNR_ACC,
      GL_ACCOUNT type HKONT,
      COND_KEY type KSCHL,
      ACCT_KEY type KTOSL,
      TAX_CODE type MWSKZ,
      TAX_RATE type MSATZ_F05L,
      TAX_DATE type DATS,
      TAXJURCODE type TXJCD,
      TAXJURCODE_DEEP type ACPI_TXJCD_DEEP,
      TAXJURCODE_LEVEL type ACPI_TXJCD_LEVEL,
      ITEMNO_TAX type TAXPS,
      DIRECT_TAX type BAPI_FLG_DIR,
    end of BAPIACTX09 .
  types:
    __BAPIACTX09                   type standard table of BAPIACTX09                     with non-unique default key .
  types:
    WITHT type C length 000002 .
  types:
    WT_WITHCD type C length 000002 .
  types:
    BAPIWT_BS type P length 12  decimals 000004 .
  types:
    BAPIWT_BS1 type P length 12  decimals 000004 .
  types:
    BAPIWT_BS2 type P length 12  decimals 000004 .
  types:
    BAPIWT_BS3 type P length 12  decimals 000004 .
  types:
    BAPIWT_QBUIHH type P length 12  decimals 000004 .
  types:
    BAPIWT_QBUIHB type P length 12  decimals 000004 .
  types:
    BAPIWT_QBUIH2 type P length 12  decimals 000004 .
  types:
    BAPIWT_QBUIH3 type P length 12  decimals 000004 .
  types:
    BAPIWT_AWT type P length 12  decimals 000004 .
  types:
    BAPIWT_AWT1 type P length 12  decimals 000004 .
  types:
    BAPIWT_AWT2 type P length 12  decimals 000004 .
  types:
    BAPIWT_AWT3 type P length 12  decimals 000004 .
  types:
    WT_BASMAN type C length 000001 .
  types:
    WT_AMNMAN type C length 000001 .
  types:
    BAPIWT_BS_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_BS1_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_BS2_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_BS3_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_QBUIHH_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_QBUIHB_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_QBUIH2_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_QBUIH3_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_AWT_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_AWT1_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_AWT2_31 type P length 16  decimals 000008 .
  types:
    BAPIWT_AWT3_31 type P length 16  decimals 000008 .
  types:
    begin of BAPIACWT09,
      ITEMNO_ACC type POSNR_ACC,
      WT_TYPE type WITHT,
      WT_CODE type WT_WITHCD,
      BAS_AMT_LC type BAPIWT_BS,
      BAS_AMT_TC type BAPIWT_BS1,
      BAS_AMT_L2 type BAPIWT_BS2,
      BAS_AMT_L3 type BAPIWT_BS3,
      MAN_AMT_LC type BAPIWT_QBUIHH,
      MAN_AMT_TC type BAPIWT_QBUIHB,
      MAN_AMT_L2 type BAPIWT_QBUIH2,
      MAN_AMT_L3 type BAPIWT_QBUIH3,
      AWH_AMT_LC type BAPIWT_AWT,
      AWH_AMT_TC type BAPIWT_AWT1,
      AWH_AMT_L2 type BAPIWT_AWT2,
      AWH_AMT_L3 type BAPIWT_AWT3,
      BAS_AMT_IND type WT_BASMAN,
      MAN_AMT_IND type WT_AMNMAN,
      BAS_AMT_LC_LONG type BAPIWT_BS_31,
      BAS_AMT_TC_LONG type BAPIWT_BS1_31,
      BAS_AMT_L2_LONG type BAPIWT_BS2_31,
      BAS_AMT_L3_LONG type BAPIWT_BS3_31,
      MAN_AMT_LC_LONG type BAPIWT_QBUIHH_31,
      MAN_AMT_TC_LONG type BAPIWT_QBUIHB_31,
      MAN_AMT_L2_LONG type BAPIWT_QBUIH2_31,
      MAN_AMT_L3_LONG type BAPIWT_QBUIH3_31,
      AWH_AMT_LC_LONG type BAPIWT_AWT_31,
      AWH_AMT_TC_LONG type BAPIWT_AWT1_31,
      AWH_AMT_L2_LONG type BAPIWT_AWT2_31,
      AWH_AMT_L3_LONG type BAPIWT_AWT3_31,
    end of BAPIACWT09 .
  types:
    __BAPIACWT09                   type standard table of BAPIACWT09                     with non-unique default key .
  types:
    ACPI_CONT_ACCT type C length 000012 .
  types:
    ACPI_MAIN_TRANS type C length 000004 .
  types:
    ACPI_SUB_TRANS type C length 000004 .
  types:
    SYSUUID_X type X length 000016 .
  types:
    ACPI_CONT_REF type C length 000020 .
  types:
    ACPI_CA_DOC_REF type C length 000016 .
  types:
    begin of BAPIACCAIT,
      ITEMNO_ACC type POSNR_ACC,
      CONT_ACCT type ACPI_CONT_ACCT,
      MAIN_TRANS type ACPI_MAIN_TRANS,
      SUB_TRANS type ACPI_SUB_TRANS,
      FUNC_AREA type FKBER_SHORT,
      FM_AREA type FIKRS,
      CMMT_ITEM type FIPOS,
      FUNDS_CTR type FISTL,
      FUND type BP_GEBER,
      AGREEMENT_GUID type SYSUUID_X,
      FUNC_AREA_LONG type FKBER,
      CMMT_ITEM_LONG type FM_FIPEX,
      GRANT_NBR type GM_GRANT_NBR,
      VTREF type ACPI_CONT_REF,
      VTREF_GUID type SYSUUID_X,
      EXT_OBJECT_ID type ACPI_IAOM_EO_ID,
      BUS_SCENARIO type ACPI_IAOM_BS_ID,
      REFERENCE_NO type ACPI_CA_DOC_REF,
      BUDGET_PERIOD type FM_BUDGET_PERIOD,
    end of BAPIACCAIT .
  types:
    __BAPIACCAIT                   type standard table of BAPIACCAIT                     with non-unique default key .
  types:
    FIELDNAME type C length 000030 .
  types:
    ACPI_RKE_CRIGEN type C length 000018 .
  types:
    BAPI_PROD_NO type C length 000040 .
  types:
    begin of BAPIACKEC9,
      ITEMNO_ACC type POSNR_ACC,
      FIELDNAME type FIELDNAME,
      CHARACTER type ACPI_RKE_CRIGEN,
      PROD_NO_LONG type BAPI_PROD_NO,
    end of BAPIACKEC9 .
  types:
    __BAPIACKEC9                   type standard table of BAPIACKEC9                     with non-unique default key .
  types:
    CURTP type C length 000002 .
  types:
    WAERS type C length 000005 .
  types:
    BAPIDOCCUR type P length 12  decimals 000004 .
  types:
    KURSF type P length 5  decimals 000005 .
  types:
    ACPI_UKURSM type P length 5  decimals 000005 .
  types:
    BAPIAMTBASE type P length 12  decimals 000004 .
  types:
    ACPI_SKFBT type P length 12  decimals 000004 .
  types:
    ACPI_ACSKT type P length 12  decimals 000004 .
  types:
    BAPITAXAMT type P length 12  decimals 000004 .
  types:
    BAPIDOCCUR_31 type P length 16  decimals 000008 .
  types:
    BAPIAMTBASE_31 type P length 16  decimals 000008 .
  types:
    ACPI_SKFBT_31 type P length 16  decimals 000008 .
  types:
    ACPI_ACSKT_31 type P length 16  decimals 000008 .
  types:
    BAPITAXAMT_31 type P length 16  decimals 000008 .
  types:
    begin of BAPIACCR09,
      ITEMNO_ACC type POSNR_ACC,
      CURR_TYPE type CURTP,
      CURRENCY type WAERS,
      CURRENCY_ISO type WAERS_ISO,
      AMT_DOCCUR type BAPIDOCCUR,
      EXCH_RATE type KURSF,
      EXCH_RATE_V type ACPI_UKURSM,
      AMT_BASE type BAPIAMTBASE,
      DISC_BASE type ACPI_SKFBT,
      DISC_AMT type ACPI_ACSKT,
      TAX_AMT type BAPITAXAMT,
      AMT_DOCCUR_LONG type BAPIDOCCUR_31,
      AMT_BASE_LONG type BAPIAMTBASE_31,
      DISC_BASE_LONG type ACPI_SKFBT_31,
      DISC_AMT_LONG type ACPI_ACSKT_31,
      TAX_AMT_LONG type BAPITAXAMT_31,
    end of BAPIACCR09 .
  types:
    __BAPIACCR09                   type standard table of BAPIACCR09                     with non-unique default key .
  types:
    STRNG250 type C length 000250 .
  types:
    begin of BAPIACEXTC,
      FIELD1 type STRNG250,
      FIELD2 type STRNG250,
      FIELD3 type STRNG250,
      FIELD4 type STRNG250,
    end of BAPIACEXTC .
  types:
    __BAPIACEXTC                   type standard table of BAPIACEXTC                     with non-unique default key .
  types:
    TE_STRUC type C length 000030 .
  types:
    VALUEPART type C length 000240 .
  types:
    begin of BAPIPAREX,
      STRUCTURE type TE_STRUC,
      VALUEPART1 type VALUEPART,
      VALUEPART2 type VALUEPART,
      VALUEPART3 type VALUEPART,
      VALUEPART4 type VALUEPART,
    end of BAPIPAREX .
  types:
    __BAPIPAREX                    type standard table of BAPIPAREX                      with non-unique default key .
  types:
    ACPI_CCACT type C length 000010 .
  types:
    CCINS type C length 000004 .
  types:
    CCNUM type C length 000025 .
  types:
    CCFOL type C length 000010 .
  types:
    CCNAME type C length 000040 .
  types:
    CSOUR type C length 000001 .
  types:
    ACPI_CAUTW type P length 12  decimals 000004 .
  types:
    AUNUM type C length 000010 .
  types:
    AUTRA type C length 000015 .
  types AUTIM type T .
  types:
    MERCH type C length 000015 .
  types:
    LOCID_CC type C length 000010 .
  types:
    TRMID type C length 000010 .
  types:
    ACPI_CCTYP type C length 000002 .
  types:
    ACPI_CAUTW_31 type P length 16  decimals 000008 .
  types:
    begin of BAPIACPC09,
      ITEMNO_ACC type POSNR_ACC,
      CC_GLACCOUNT type ACPI_CCACT,
      CC_TYPE type CCINS,
      CC_NUMBER type CCNUM,
      CC_SEQ_NO type CCFOL,
      CC_VALID_F type DATS,
      CC_VALID_T type DATS,
      CC_NAME type CCNAME,
      DATAORIGIN type CSOUR,
      AUTHAMOUNT type ACPI_CAUTW,
      CURRENCY type WAERS,
      CURRENCY_ISO type WAERS_ISO,
      CC_AUTTH_NO type AUNUM,
      AUTH_REFNO type AUTRA,
      AUTH_DATE type DATS,
      AUTH_TIME type AUTIM,
      MERCHIDCL type MERCH,
      POINT_OF_RECEIPT type LOCID_CC,
      TERMINAL type TRMID,
      CCTYP type ACPI_CCTYP,
      AUTHAMOUNT_LONG type ACPI_CAUTW_31,
    end of BAPIACPC09 .
  types:
    __BAPIACPC09                   type standard table of BAPIACPC09                     with non-unique default key .
  types:
    SWENR type C length 000008 .
  types:
    SGENR type C length 000008 .
  types:
    SGRNR type C length 000008 .
  types:
    REBDRONRBAPI type C length 000008 .
  types:
    SNKSL type C length 000004 .
  types:
    SEMPSL type C length 000005 .
  types:
    RANL type C length 000013 .
  types:
    SBEWART type C length 000004 .
  types:
    SBERI type C length 000010 .
  types:
    POPTSATZ type P length 5  decimals 000006 .
  types:
    begin of BAPIACRE09,
      ITEMNO_ACC type POSNR_ACC,
      BUSINESS_ENTITY type SWENR,
      BUILDING type SGENR,
      PROPERTY type SGRNR,
      RENTAL_OBJECT type REBDRONRBAPI,
      SERV_CHARGE_KEY type SNKSL,
      SETTLEMENT_UNIT type SEMPSL,
      CONTRACT_NO type RANL,
      FLOW_TYPE type SBEWART,
      CORR_ITEM type SBERI,
      REF_DATE type DATS,
      OPTION_RATE type POPTSATZ,
    end of BAPIACRE09 .
  types:
    __BAPIACRE09                   type standard table of BAPIACRE09                     with non-unique default key .
  types:
    BAPI_MTYPE type C length 000001 .
  types:
    SYMSGID type C length 000020 .
  types:
    SYMSGNO type N length 000003 .
  types:
    BAPI_MSG type C length 000220 .
  types:
    BALOGNR type C length 000020 .
  types:
    BALMNR type N length 000006 .
  types:
    SYMSGV type C length 000050 .
  types:
    BAPI_PARAM type C length 000032 .
  types:
    BAPI_FLD type C length 000030 .
  types:
    BAPILOGSYS type C length 000010 .
  types:
    begin of BAPIRET2,
      TYPE type BAPI_MTYPE,
      ID type SYMSGID,
      NUMBER type SYMSGNO,
      MESSAGE type BAPI_MSG,
      LOG_NO type BALOGNR,
      LOG_MSG_NO type BALMNR,
      MESSAGE_V1 type SYMSGV,
      MESSAGE_V2 type SYMSGV,
      MESSAGE_V3 type SYMSGV,
      MESSAGE_V4 type SYMSGV,
      PARAMETER type BAPI_PARAM,
      ROW type INT4,
      FIELD type BAPI_FLD,
      SYSTEM type BAPILOGSYS,
    end of BAPIRET2 .
  types:
    __BAPIRET2                     type standard table of BAPIRET2                       with non-unique default key .
  types:
    BAPIRKEVAL type P length 12  decimals 000004 .
  types:
    QUA_VALCOM type P length 8  decimals 000003 .
  types:
    BAPIRKEVAL_31 type P length 16  decimals 000008 .
  types:
    begin of BAPIACKEV9,
      ITEMNO_ACC type POSNR_ACC,
      FIELDNAME type FIELDNAME,
      CURR_TYPE type CURTP,
      CURRENCY type WAERS,
      CURRENCY_ISO type WAERS_ISO,
      AMT_VALCOM type BAPIRKEVAL,
      BASE_UOM type MEINS,
      BASE_UOM_ISO type MEINS_ISO,
      QUA_VALCOM type QUA_VALCOM,
      AMT_VALCOM_LONG type BAPIRKEVAL_31,
    end of BAPIACKEV9 .
  types:
    __BAPIACKEV9                   type standard table of BAPIACKEV9                     with non-unique default key .
endinterface.
