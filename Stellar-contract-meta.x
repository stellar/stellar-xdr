// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract meta XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
namespace stellar
{

struct ScMetaV0
{
    string key<>;
    string val<>;
};

enum ScMetaKind
{
    SC_META_V0 = 0
};

union ScMetaEntry switch (ScMetaKind kind)
{
case SC_META_V0:
    ScMetaV0 v0;
};

}
