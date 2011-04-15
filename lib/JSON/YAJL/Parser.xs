#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <yajl_lex.h>
#include <yajl_parse.h>
#include <yajl_parser.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define NEED_newSVpvn_flags
#define NEED_sv_2pv_flags
#include "ppport.h"

typedef yajl_handle JSON__YAJL__Parser;

MODULE = JSON::YAJL::Parser		PACKAGE = JSON::YAJL::Parser

JSON::YAJL::Parser new(package, unsigned int allowComments = 0, unsigned int checkUTF8 = 0)
CODE:
    yajl_parser_config config = { allowComments, checkUTF8 };
    yajl_handle parser;
    SV* data;
    parser = yajl_alloc(NULL, &config, NULL, (void *) data);
    RETVAL = parser;
OUTPUT:
    RETVAL

void parse(JSON::YAJL::Parser parser, SV* data)
CODE:
    const unsigned char * jsonText;
    unsigned int jsonTextLength;
    yajl_status status;
    unsigned char * error;
    jsonText = SvPV_nolen(data);
    jsonTextLength = SvCUR(data);
    status = yajl_parse(parser, jsonText, jsonTextLength);
    parser->ctx = data;
    if (status != yajl_status_ok && status != yajl_status_insufficient_data) {
        error = yajl_get_error(parser, 1, jsonText, jsonTextLength);
        Perl_croak(aTHX_ "%s", error);
    }

void parse_complete(JSON::YAJL::Parser parser)
CODE:
    yajl_status status;
    unsigned char * error;
    const unsigned char * jsonText;
    unsigned int jsonTextLength;
    SV* data;
    status = yajl_parse_complete(parser);
    if (status != yajl_status_ok) {
        data = (SV*) parser->ctx;
        jsonText = SvPV_nolen(data);
        jsonTextLength = SvCUR(data);
        error = yajl_get_error(parser, 1, jsonText, jsonTextLength);
        Perl_croak(aTHX_ "%s", error);
    }

void DESTROY(JSON::YAJL::Parser parser)
CODE:
    yajl_free(parser);
