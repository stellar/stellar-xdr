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
    SpecUDTDef *udtDef;
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

enum SpecUDTType
{
    SPEC_UDT_STRUCT = 0,
    SPEC_UDT_UNION = 1
};

struct SpecUDTStructField
{
    string name<30>;
    SpecTypeDef type;
};

struct SpecUDTStruct
{
    SpecUDTStructField fields<40>;
};

struct SpecUDTUnionCase
{
    string name<60>;
    SpecTypeDef *type;
};

struct SpecUDTUnion
{
    SpecUDTUnionCase cases<50>;
};

union SpecUDTDef switch (SpecUDTType type)
{
case SPEC_UDT_STRUCT:
    SpecUDTStruct struct;
case SPEC_UDT_UNION:
    SpecUDTUnion union;
};

union SpecEntryFunction switch (int v)
{
case 0:
    struct {
        SCSymbol name;
        SpecTypeDef inputTypes<10>;
        SpecTypeDef outputTypes<1>;
    } v0;
};

union SpecEntryUDT switch (int v)
{
case 0:
    struct {
        string name<60>;
        SpecUDTDef typ;
    } v0;
};

enum SpecEntryKind
{
    SPEC_ENTRY_FUNCTION = 0,
    SPEC_ENTRY_UDT = 1
};

union SpecEntry switch (SpecEntryKind kind)
{
case SPEC_ENTRY_FUNCTION:
    SpecEntryFunction function;
case SPEC_ENTRY_UDT:
    SpecEntryUDT udt;
};

}
