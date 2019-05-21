@AbapCatalog.sqlViewName: 'ZV_FIGL_HDR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Joining BKPF BSET BSEG'
@OData.publish: true
define view ZTV_BKPF_BSEG
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
{
key H.awtyp as OBJ_TYPE,
key H.awkey as OBJ_KEY,
H.usnam as USNAM,
H.bktxt as HEADER_TXT,
H.bukrs as COMP_CODE,
H.bldat as DOC_DATE,
H.budat as PSTNG_DATE,
H.blart as DOC_TYPE,
H.xblnr as REF_DOC_NO,
H.glvor as BUS_ACT,
D.posnr as ITEMNO_ACC,
H.gjahr as FISC_YEAR,
H.belnr as DOC_NO,
D.buzei as LINE_ITEM,
D.taxps as TX_LINE_ITEM,
D.hkont as GL_ACCOUNT,
T.hkont as GL_ACCOUNT_TX,
D.mwskz as TAX_CODE,
D.kostl as ACCT_KEY,
T.kschl as COND_KEY,
D.sgtxt as ITEM_TEXT,
D.menge as QUANTITY,
D.meins as BASE_UOM,
D.projk as WBS_ELEMENT,
D.lifnr as VENDOR_NO,
D.zterm as PMNTTRMS,
D.zuonr as ALLOC_NMBR,
'00' as CURR_TYPE,
H.waers as CURRENCY,
D.dmbtr as AMT_DOCCUR
}
