@AbapCatalog.sqlViewName: 'ZBLCK_COBK_COEP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Get CO Activity Allocation  Documents'
@OData.publish: true
define view ZTV_CO_COBK_COEP_ACTALLOC
as select from coep as D inner join cobk as H
on D.mandt = H.mandt
and D.kokrs = H.kokrs
and D.belnr = H.belnr
 {
key H.awkey as OBJ_KEY,
key H.awtyp as OBJ_TYPE,
H.awsys as OBJ_SYS,
'R'  as ACTION,
H.kokrs as CO_AREA,
H.bldat as DOC_DATE,
H.budat as POSTGDATE,
H.belnr as DOC_NO,
H.varnr as VARIANT,
H.bltxt as DOC_HDR_TX,
D.pkostl as SEND_CCTR,
D.plstar as ACTTYPE,
D.megbtr as ACTVTY_QTY,
D.meinh as ACTIVITYUN,
@Semantics.amount.currencyCode: 'CURRENCY'
division (D.wtgbtr , D.megbtr, 2 )  as PRICE, 
@Semantics.currencyCode: true
D.twaer as CURRENCY,
D.sgtxt as SEG_TEXT,
D.pspnr as REC_WBS_EL
}
where scope = 'PA' and H.kokrs = 'MPOL'
