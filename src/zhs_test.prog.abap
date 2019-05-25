*&---------------------------------------------------------------------*
*& Report ZHS_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHS_TEST.

 DATA documentheader TYPE zbop_appostheader=>zbapi_acc_post_ap.
 DATA obj_key TYPE zbop_appostheader=>bapiache09-obj_key.
 DATA obj_sys TYPE zbop_appostheader=>bapiache09-obj_sys.
 DATA obj_type TYPE zbop_appostheader=>bapiache09-obj_type.
 DATA return  TYPE zbop_appostheader=>__bapiret2.
 DATA ls_return  TYPE LINE OF zbop_appostheader=>__bapiret2.
 DATA lv_rfc_name TYPE tfdir-funcname.
 DATA lv_destination TYPE rfcdest.
 DATA lv_subrc TYPE syst-subrc.
 DATA lv_exc_msg TYPE /iwbep/mgw_bop_rfc_excep_text.
 DATA lx_root TYPE REF TO cx_root.
lv_rfc_name = 'Z_RFC_POST_AP'.

IF lv_destination IS INITIAL OR lv_destination EQ 'NONE'.

  TRY.
      CALL FUNCTION lv_rfc_name
        EXPORTING
          documentheader   =   documentheader
        IMPORTING
          obj_key    =   obj_key
          obj_sys    =   obj_sys
          obj_type   =   obj_type
        TABLES
          return   =   return
        EXCEPTIONS
          system_failure = 1000 message lv_exc_msg
          OTHERS = 1002.

      lv_subrc = sy-subrc.
*in case of co-deployment the exception is raised and needs to be caught
    CATCH cx_root INTO lx_root.
      lv_subrc = 1001.
      lv_exc_msg = lx_root->if_message~get_text( ).
  ENDTRY.

ELSE.

  CALL FUNCTION lv_rfc_name DESTINATION lv_destination
        EXPORTING
          documentheader   =   documentheader
        IMPORTING
          obj_key    =   obj_key
          obj_sys    =   obj_sys
          obj_type   =   obj_type
        TABLES
          return   =   return
        EXCEPTIONS
          system_failure         = 1000 MESSAGE lv_exc_msg
          communication_failure  = 1001 MESSAGE lv_exc_msg
          OTHERS = 1002.

  lv_subrc = sy-subrc.

ENDIF.

*-------------------------------------------------------------
*  Map the RFC response to the caller interface - Only mapped attributes
*-------------------------------------------------------------
*-------------------------------------------------------------
* Error and exception handling
*-------------------------------------------------------------
IF lv_subrc <> 0.
* Execute the RFC exception handling process
me->/iwbep/if_sb_dpc_comm_services~rfc_exception_handling(
EXPORTING
iv_subrc            = lv_subrc
iv_exp_message_text = lv_exc_msg ).
ENDIF.
