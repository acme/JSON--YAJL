#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <yajl_gen.h>     
#include <stdio.h>  
#include <stdlib.h>  
#include <string.h>
#include <stdint.h>
#define NEED_newSVpvn_flags
#define NEED_sv_2pv_flags
#include "ppport.h"

typedef yajl_gen JSON__YAJL__Generator;

MODULE = JSON::YAJL::Generator		PACKAGE = JSON::YAJL::Generator

JSON::YAJL::Generator new(package, beautify = 0, indentString = "    ")
    unsigned int beautify
    const char * indentString
CODE:
    yajl_gen_config conf = { beautify, indentString };
    yajl_gen g;
    g = yajl_gen_alloc(&conf, NULL);
    RETVAL = g;
OUTPUT:
    RETVAL

void integer(g, n)
    JSON::YAJL::Generator g
    long int n
CODE:
    yajl_gen_integer(g, n);

void double(g, n)
    JSON::YAJL::Generator g
    double n
CODE:
    yajl_gen_double(g, n);

void number(g, n)
    JSON::YAJL::Generator g
    SV* n
CODE:
    yajl_gen_number(g, SvPV_nolen(n), SvCUR(n));

void string(g, s)
    JSON::YAJL::Generator g
    SV* s
CODE:
    yajl_gen_string(g, SvPV_nolen(s), SvCUR(s));

void null(g)
    JSON::YAJL::Generator g
CODE:
    yajl_gen_null(g);

void bool(g, b)
    JSON::YAJL::Generator g
    SV* b
CODE:
    yajl_gen_bool(g, SvTRUE(b));

void map_open(g)
    JSON::YAJL::Generator g
CODE:
    yajl_gen_map_open(g);

void map_close(g)
    JSON::YAJL::Generator g
CODE:
    yajl_gen_map_close(g);

void array_open(g)
    JSON::YAJL::Generator g
CODE:
    yajl_gen_array_open(g);

void array_close(g)
    JSON::YAJL::Generator g
CODE:
    yajl_gen_array_close(g);

SV* get_buf(g)
    JSON::YAJL::Generator g
CODE:
    const unsigned char* buf;
    unsigned int len;
    yajl_gen_get_buf(g, &buf, &len);
    RETVAL = newSVpvn_utf8(buf, (STRLEN)len, 1);
OUTPUT:
    RETVAL

void clear(g)
    JSON::YAJL::Generator g
CODE:
    yajl_gen_clear(g);

void DESTROY(g)
    JSON::YAJL::Generator g
CODE:
    yajl_gen_free(g);
