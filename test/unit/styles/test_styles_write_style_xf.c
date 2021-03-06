/*
 * Tests for the lib_xlsx_writer library.
 *
 * Copyright 2014, John McNamara, jmcnamara@cpan.org
 *
 */

#include "../ctest.h"
#include "../helper.h"

#include "xlsxwriter/styles.h"

// Test the _write_style_xf() function.
CTEST(styles, write_style_xf) {

    char* got;
    char exp[] = "<xf numFmtId=\"0\" fontId=\"0\" fillId=\"0\" borderId=\"0\"/>";
    FILE* testfile = tmpfile();

    lxw_styles *styles = _new_styles();
    styles->file = testfile;

    _write_style_xf(styles);

    RUN_XLSX_STREQ(exp, got);

    _free_styles(styles);
}

