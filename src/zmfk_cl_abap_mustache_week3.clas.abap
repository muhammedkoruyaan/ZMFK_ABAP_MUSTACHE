CLASS zmfk_cl_abap_mustache_week3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES:
      BEGIN OF ty_shop_item,
        name      TYPE string,
        price(15) TYPE p DECIMALS 2,
      END OF ty_shop_item,

      ty_shop_item_tt TYPE STANDARD TABLE OF ty_shop_item WITH DEFAULT KEY,

      BEGIN OF ty_shop,
        shop_name TYPE string,
        items     TYPE ty_shop_item_tt,
      END OF ty_shop.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zmfk_cl_abap_mustache_week3 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lo_mustache TYPE REF TO zcl_mustache.
    DATA lt_my_data TYPE STANDARD TABLE OF ty_shop WITH DEFAULT KEY.
    DATA lr_data TYPE REF TO ty_shop.

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_data.
    lr_data->shop_name = `Rich's Shop`.
    lr_data->items = VALUE ty_shop_item_tt(
        ( name  = `Flip Flops` price = `99.00` )
        ( name  = `Board Shorts` price = `39.00` )
        ( name  = `Hoodie` price = `199.00` )
    ).

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_data.
    lr_data->shop_name = `Tom's Shop`.
    lr_data->items = VALUE ty_shop_item_tt(
        ( name  = `Disney Hoodie` price = `89.00` )
        ( name  = `Star Wars T-Shirt` price = `49.00` )
        ( name  = `Nerdy Tech T-Shirt` price = `79.00` )
    ).

    TRY.
        lo_mustache = zcl_mustache=>create(
        'Welcome to {{shop_name}}!' && cl_abap_char_utilities=>newline &&
        '{{#items}}' && cl_abap_char_utilities=>newline &&
        '* {{name}} - ${{price}}' && cl_abap_char_utilities=>newline &&
        '{{/items}}!' && cl_abap_char_utilities=>newline
                      ).

        out->write( lo_mustache->render( lt_my_data )  ).

      CATCH zcx_mustache_error.

        out->write( |something went wrong!!!| ).

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
