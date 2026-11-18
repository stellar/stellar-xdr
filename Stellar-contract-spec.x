// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract Contractspec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
% #include "xdr/Stellar-contract.h"
namespace stellar
{

const SC_SPEC_DOC_LIMIT = 1024;

const SC_SPEC_TYPE_NAME_LIMIT = 1024;

enum ScSpecType
{
    SC_SPEC_TYPE_VAL = 0,

    // Types with no parameters.
    SC_SPEC_TYPE_BOOL = 1,
    SC_SPEC_TYPE_VOID = 2,
    SC_SPEC_TYPE_ERROR = 3,
    SC_SPEC_TYPE_U32 = 4,
    SC_SPEC_TYPE_I32 = 5,
    SC_SPEC_TYPE_U64 = 6,
    SC_SPEC_TYPE_I64 = 7,
    SC_SPEC_TYPE_TIMEPOINT = 8,
    SC_SPEC_TYPE_DURATION = 9,
    SC_SPEC_TYPE_U128 = 10,
    SC_SPEC_TYPE_I128 = 11,
    SC_SPEC_TYPE_U256 = 12,
    SC_SPEC_TYPE_I256 = 13,
    SC_SPEC_TYPE_BYTES = 14,
    SC_SPEC_TYPE_STRING = 16,
    SC_SPEC_TYPE_SYMBOL = 17,
    SC_SPEC_TYPE_ADDRESS = 19,
    SC_SPEC_TYPE_MUXED_ADDRESS = 20,

    // Types with parameters.
    SC_SPEC_TYPE_OPTION = 1000,
    SC_SPEC_TYPE_RESULT = 1001,
    SC_SPEC_TYPE_VEC = 1002,
    SC_SPEC_TYPE_MAP = 1004,
    SC_SPEC_TYPE_TUPLE = 1005,
    SC_SPEC_TYPE_BYTES_N = 1006,

    // User defined types.
    SC_SPEC_TYPE_UDT = 2000
};

struct ScSpecTypeOption
{
    ScSpecTypeDef valueType;
};

struct ScSpecTypeResult
{
    ScSpecTypeDef okType;
    ScSpecTypeDef errorType;
};

struct ScSpecTypeVec
{
    ScSpecTypeDef elementType;
};

struct ScSpecTypeMap
{
    ScSpecTypeDef keyType;
    ScSpecTypeDef valueType;
};

struct ScSpecTypeTuple
{
    ScSpecTypeDef valueTypes<12>;
};

struct ScSpecTypeBytesN
{
    uint32 n;
};

struct ScSpecTypeUdt
{
    string name<SC_SPEC_TYPE_NAME_LIMIT>;
};

union ScSpecTypeDef switch (ScSpecType type)
{
case SC_SPEC_TYPE_VAL:
case SC_SPEC_TYPE_BOOL:
case SC_SPEC_TYPE_VOID:
case SC_SPEC_TYPE_ERROR:
case SC_SPEC_TYPE_U32:
case SC_SPEC_TYPE_I32:
case SC_SPEC_TYPE_U64:
case SC_SPEC_TYPE_I64:
case SC_SPEC_TYPE_TIMEPOINT:
case SC_SPEC_TYPE_DURATION:
case SC_SPEC_TYPE_U128:
case SC_SPEC_TYPE_I128:
case SC_SPEC_TYPE_U256:
case SC_SPEC_TYPE_I256:
case SC_SPEC_TYPE_BYTES:
case SC_SPEC_TYPE_STRING:
case SC_SPEC_TYPE_SYMBOL:
case SC_SPEC_TYPE_ADDRESS:
case SC_SPEC_TYPE_MUXED_ADDRESS:
    void;
case SC_SPEC_TYPE_OPTION:
    ScSpecTypeOption option;
case SC_SPEC_TYPE_RESULT:
    ScSpecTypeResult result;
case SC_SPEC_TYPE_VEC:
    ScSpecTypeVec vec;
case SC_SPEC_TYPE_MAP:
    ScSpecTypeMap map;
case SC_SPEC_TYPE_TUPLE:
    ScSpecTypeTuple tuple;
case SC_SPEC_TYPE_BYTES_N:
    ScSpecTypeBytesN bytesN;
case SC_SPEC_TYPE_UDT:
    ScSpecTypeUdt udt;
};

struct ScSpecUdtStructFieldV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<30>;
    ScSpecTypeDef type;
};

struct ScSpecUdtStructV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<SC_SPEC_TYPE_NAME_LIMIT>;
    ScSpecUdtStructFieldV0 fields<>;
};

struct ScSpecUdtUnionCaseVoidV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
};

struct ScSpecUdtUnionCaseTupleV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
    ScSpecTypeDef type<>;
};

enum ScSpecUdtUnionCaseV0Kind
{
    SC_SPEC_UDT_UNION_CASE_VOID_V0 = 0,
    SC_SPEC_UDT_UNION_CASE_TUPLE_V0 = 1
};

union ScSpecUdtUnionCaseV0 switch (ScSpecUdtUnionCaseV0Kind kind)
{
case SC_SPEC_UDT_UNION_CASE_VOID_V0:
    ScSpecUdtUnionCaseVoidV0 voidCase;
case SC_SPEC_UDT_UNION_CASE_TUPLE_V0:
    ScSpecUdtUnionCaseTupleV0 tupleCase;
};

struct ScSpecUdtUnionV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<SC_SPEC_TYPE_NAME_LIMIT>;
    ScSpecUdtUnionCaseV0 cases<>;
};

struct ScSpecUdtEnumCaseV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
    uint32 value;
};

struct ScSpecUdtEnumV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<SC_SPEC_TYPE_NAME_LIMIT>;
    ScSpecUdtEnumCaseV0 cases<>;
};

struct ScSpecUdtErrorEnumCaseV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<60>;
    uint32 value;
};

struct ScSpecUdtErrorEnumV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<SC_SPEC_TYPE_NAME_LIMIT>;
    ScSpecUdtErrorEnumCaseV0 cases<>;
};

struct ScSpecFunctionInputV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<30>;
    ScSpecTypeDef type;
};

struct ScSpecFunctionV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    ScSymbol name;
    ScSpecFunctionInputV0 inputs<>;
    ScSpecTypeDef outputs<1>;
};

enum ScSpecEventParamLocationV0
{
    SC_SPEC_EVENT_PARAM_LOCATION_DATA = 0,
    SC_SPEC_EVENT_PARAM_LOCATION_TOPIC_LIST = 1
};

struct ScSpecEventParamV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string name<30>;
    ScSpecTypeDef type;
    ScSpecEventParamLocationV0 location;
};

enum ScSpecEventDataFormat
{
    SC_SPEC_EVENT_DATA_FORMAT_SINGLE_VALUE = 0,
    SC_SPEC_EVENT_DATA_FORMAT_VEC = 1,
    SC_SPEC_EVENT_DATA_FORMAT_MAP = 2
};

struct ScSpecEventV0
{
    string doc<SC_SPEC_DOC_LIMIT>;
    string lib<80>;
    string name<SC_SPEC_TYPE_NAME_LIMIT>;
    ScSymbol prefixTopics<2>;
    ScSpecEventParamV0 params<>;
    ScSpecEventDataFormat dataFormat;
};

enum ScSpecEntryKind
{
    SC_SPEC_ENTRY_FUNCTION_V0 = 0,
    SC_SPEC_ENTRY_UDT_STRUCT_V0 = 1,
    SC_SPEC_ENTRY_UDT_UNION_V0 = 2,
    SC_SPEC_ENTRY_UDT_ENUM_V0 = 3,
    SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0 = 4,
    SC_SPEC_ENTRY_EVENT_V0 = 5
};

union ScSpecEntry switch (ScSpecEntryKind kind)
{
case SC_SPEC_ENTRY_FUNCTION_V0:
    ScSpecFunctionV0 functionV0;
case SC_SPEC_ENTRY_UDT_STRUCT_V0:
    ScSpecUdtStructV0 udtStructV0;
case SC_SPEC_ENTRY_UDT_UNION_V0:
    ScSpecUdtUnionV0 udtUnionV0;
case SC_SPEC_ENTRY_UDT_ENUM_V0:
    ScSpecUdtEnumV0 udtEnumV0;
case SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0:
    ScSpecUdtErrorEnumV0 udtErrorEnumV0;
case SC_SPEC_ENTRY_EVENT_V0:
    ScSpecEventV0 eventV0;
};

}
