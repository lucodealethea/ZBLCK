interface ZIF_Y_RFC_POST_AP
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
    CHAR1 type C length 000001 .
  types:
    HKONT type C length 000010 .
  types:
    SGTXT type C length 000050 .
  types:
    MENGE_D type P length 7  decimals 000003 .
  types:
    MEINS type C length 000003 .
  types:
    PS_POSID type C length 000024 .
  types:
    LIFNR type C length 000010 .
  types:
    ACPI_ZTERM type C length 000004 .
  types:
    ACPI_ZUONR type C length 000018 .
  types:
    WAERS type C length 000005 .
  types:
    BAPIDOCCUR_31 type P length 16  decimals 000008 .
  types:
    BAPIAMTBASE type P length 12  decimals 000004 .
  types:
    begin of ZBAPI_ACC_POST_AP,
      ACTION type CHAR1,
      HEADER_TXT type BKTXT,
      COMP_CODE type BUKRS,
      DOC_DATE type DATS,
      PSTNG_DATE type DATS,
      REF_DOC_NO type XBLNR,
      GL_ACCOUNT type HKONT,
      GL_ACCOUNT_TX type HKONT,
      ITEM_TEXT type SGTXT,
      QUANTITY type MENGE_D,
      BASE_UOM type MEINS,
      WBS_ELEMENT type PS_POSID,
      VENDOR_NO type LIFNR,
      PMNTTRMS type ACPI_ZTERM,
      ALLOC_NMBR type ACPI_ZUONR,
      CURRENCY type WAERS,
      AMT_DOCCUR_LONG type BAPIDOCCUR_31,
      AMT_BASE type BAPIAMTBASE,
    end of ZBAPI_ACC_POST_AP .
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
endinterface.
