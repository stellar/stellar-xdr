// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract spec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
namespace stellar
{

enum SCMetaKind
{
    SC_META_KIND_SDK = 0
};

union SCMetaEntry switch (SCMetaKind kind)
{
case SC_META_KIND_SDK:
    string sdk<256>;
};

}
