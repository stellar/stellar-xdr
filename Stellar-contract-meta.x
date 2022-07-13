// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract spec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
% #include "xdr/Stellar-contract.h"
namespace stellar
{

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
