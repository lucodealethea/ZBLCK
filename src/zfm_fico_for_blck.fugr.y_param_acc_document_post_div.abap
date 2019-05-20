FUNCTION Y_PARAM_ACC_DOCUMENT_POST_DIV.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_LIMIT) TYPE  I DEFAULT 990
*"     REFERENCE(IV_DOC_TYPE) TYPE  BAPIACHE09-DOC_TYPE
*"     REFERENCE(IS_INTERMEDIATE_ACC) TYPE  BAPIACGL09
*"----------------------------------------------------------------------

  gv_limit            = iv_limit.
  gv_doc_type	        = iv_doc_type.
  gs_intermediate_acc = is_intermediate_acc.

ENDFUNCTION.
