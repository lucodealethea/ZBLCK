@AbapCatalog.sqlViewName: 'ZBLCK_FIDOCS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Based on BKPF-BSEG_BSET'
@OData.publish: true
define view ZTV_FIGL_DOC_ITEMS
as select from bseg as D 
inner join bkpf as H 
on D.mandt = H.mandt
and D.bukrs = H.bukrs
and D.gjahr = H.gjahr
and D.belnr = H.belnr
inner join bset as T
on D.mandt = T.mandt
and D.bukrs = T.bukrs
and D.gjahr = T.gjahr
and D.belnr = T.belnr
left outer join prps as P
on P.mandt = D.mandt
and P.pspnr = D.projk
{
key H.awtyp as OBJ_TYPE,
key H.awkey as OBJ_KEY,
H.belnr as AC_DOC_NO,
D.buzei as ITEMNO_ACC,
'R'  as ACTION,
//H.usnam as USNAM,
H.bktxt as HEADER_TXT,
H.bukrs as COMP_CODE,
H.bldat as DOC_DATE,
H.budat as PSTNG_DATE,
H.blart as DOC_TYPE,
H.xblnr as REF_DOC_NO,
D.hkont as GL_ACCOUNT,
T.hkont as GL_ACCOUNT_TX,
D.sgtxt as ITEM_TEXT,
D.menge as QUANTITY,
D.meins as BASE_UOM,
P.posid as WBS_ELEMENT,
D.lifnr as VENDOR_NO,
D.kunnr as CUSTOMER,
D.zterm as PMNTTRMS,
D.zuonr as ALLOC_NMBR,
cast('00' as abap.char(2)) as CURR_TYPE,
@Semantics.currencyCode: true
H.waers as CURRENCY,
@Semantics.amount.currencyCode: 'CURRENCY'
D.dmbtr as AMT_DOCCUR_LONG,
D.dmbtr as AMT_BASE
//D.mwskz as TAX_CODE,
//D.kostl as ACCT_KEY,
//T.kschl as COND_KEY,
}

where ( H.blart = 'KB' or H.blart = 'DB' ) and H.awtyp = 'BKPFF'
