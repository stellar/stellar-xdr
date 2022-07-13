// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// The contract spec XDR is highly experimental, incomplete, and still being
// iterated on. Breaking changes expected.

% #include "xdr/Stellar-types.h"
% #include "xdr/Stellar-contract.h"
namespace stellar
{

struct SCMetaCustom
{
    opaque key<64>;
    opaque value<64>;
};

struct SCMetaVersionSemVer
{
    int64 major;
    int64 minor;
    int64 patch;
};

enum SCMetaKind
{
    SC_META_KIND_CUSTOM = 0,
    SC_META_KIND_INTERFACE_VERSION = 1,
    SC_META_KIND_SDK_VERSION = 2
};

union SCMetaEntry switch (SCMetaKind kind)
{
case SC_META_KIND_CUSTOM:
    SCMetaCustom custom;
case SC_META_KIND_INTERFACE_VERSION:
    int64 interfaceVersion;
case SC_META_KIND_SDK_VERSION:
    SCMetaVersionSemVer sdkVersion;
};

}
