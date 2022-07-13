// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract spec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
% #include "xdr/Stellar-contract.h"
namespace stellar
{

struct SCMetaVersionSemVer
{
    int64 major;
    int64 minor;
    int64 patch;
};

enum SC_META_KIND
{
    SC_META_KIND_INTERFACE_VERSION = 0,
    SC_META_KIND_SDK_VERSION = 1
};

union SCMetaEntry switch (SpecEntryKind kind)
{
case SC_META_KIND_INTERFACE_VERSION:
    int64 interfaceVersion;
case SC_META_KIND_SDK_VERSION:
    SCMetaVersionSemVer sdkVersion;
};

}
