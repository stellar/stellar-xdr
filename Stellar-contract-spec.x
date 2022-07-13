// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract spec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
% #include "xdr/Stellar-contract.h"
namespace stellar
{

enum SpecType
{
    // Types with no parameters.
    SPEC_TYPE_U32 = 1,
    SPEC_TYPE_I32 = 2,
    SPEC_TYPE_U64 = 3,
    SPEC_TYPE_I64 = 4,
    SPEC_TYPE_BOOL = 5,
    SPEC_TYPE_SYMBOL = 6,
    SPEC_TYPE_BITSET = 7,
    SPEC_TYPE_STATUS = 8,
    SPEC_TYPE_BINARY = 9,
    SPEC_TYPE_BIG_INT = 10,

    // Types with parameters.
    SPEC_TYPE_OPTION = 1000,
    SPEC_TYPE_RESULT = 1001,
    SPEC_TYPE_VEC = 1002,
    SPEC_TYPE_SET = 1003,
    SPEC_TYPE_MAP = 1004,
    SPEC_TYPE_TUPLE = 1005,

    // User defined types.
    SPEC_TYPE_UDT = 2000
};

struct SpecTypeOption
{
    SpecTypeDef valueType;
};

struct SpecTypeResult
{
    SpecTypeDef okType;
    SpecTypeDef errorType;
};

struct SpecTypeVec
{
    SpecTypeDef elementType;
};

struct SpecTypeMap
{
    SpecTypeDef keyType;
    SpecTypeDef valueType;
};

struct SpecTypeSet
{
    SpecTypeDef elementType;
};

struct SpecTypeTuple
{
    SpecTypeDef valueTypes<12>;
};

struct SpecTypeUDT
{
    string name<60>;
};

union SpecTypeDef switch (SpecType type)
{
case SPEC_TYPE_U64:
case SPEC_TYPE_I64:
case SPEC_TYPE_U32:
case SPEC_TYPE_I32:
case SPEC_TYPE_BOOL:
case SPEC_TYPE_SYMBOL:
case SPEC_TYPE_BITSET:
case SPEC_TYPE_STATUS:
case SPEC_TYPE_BINARY:
case SPEC_TYPE_BIG_INT:
    void;
case SPEC_TYPE_OPTION:
    SpecTypeOption option;
case SPEC_TYPE_RESULT:
    SpecTypeResult result;
case SPEC_TYPE_VEC:
    SpecTypeVec vec;
case SPEC_TYPE_MAP:
    SpecTypeMap map;
case SPEC_TYPE_SET:
    SpecTypeSet set;
case SPEC_TYPE_TUPLE:
    SpecTypeTuple tuple;
case SPEC_TYPE_UDT:
    SpecTypeUDT udt;
};

struct SpecUDTStructFieldV0
{
    string name<30>;
    SpecTypeDef type;
};

struct SpecUDTStructV0
{
    string name<60>;
    SpecUDTStructFieldV0 fields<40>;
};

struct SpecUDTUnionCaseV0
{
    string name<60>;
    SpecTypeDef *type;
};

struct SpecUDTUnionV0
{
    string name<60>;
    SpecUDTUnionCaseV0 cases<50>;
};

struct SpecFunctionV0
{
    SCSymbol name;
    SpecTypeDef inputTypes<10>;
    SpecTypeDef outputTypes<1>;
};

enum SpecEntryKind
{
    SPEC_ENTRY_FUNCTION_V0 = 0,
    SPEC_ENTRY_UDT_STRUCT_V0 = 1,
    SPEC_ENTRY_UDT_UNION_V0 = 2
};

union SpecEntry switch (SpecEntryKind kind)
{
case SPEC_ENTRY_FUNCTION_V0:
    SpecFunctionV0 functionV0;
case SPEC_ENTRY_UDT_STRUCT_V0:
    SpecUDTStructV0 udtStructV0;
case SPEC_ENTRY_UDT_UNION_V0:
    SpecUDTUnionV0 udtUnionV0;
};

}
