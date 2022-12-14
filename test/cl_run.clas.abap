CLASS cl_run DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS run
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS cl_run IMPLEMENTATION.
  METHOD run.
    DATA writer     TYPE REF TO zcl_aff_writer_json_schema.
    DATA log        TYPE REF TO zif_aff_log.
    DATA generator  TYPE REF TO zcl_aff_generator.
    DATA intf       TYPE zif_aff_intf_v1=>ty_main.
    DATA string_tab TYPE string_table.

    CREATE OBJECT writer
      EXPORTING
        schema_id = 'https://github.com/SAP/abap-file-formats/blob/main/file-formats/intf/intf-v1.json'.
    CREATE OBJECT generator
      EXPORTING
        writer = writer.
    string_tab = generator->generate_type( intf ).
    log = generator->get_log( ).

    CONCATENATE LINES OF string_tab INTO result SEPARATED BY |\n|.
  ENDMETHOD.
ENDCLASS.
