// Copyright 2022 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

// This is for 'internal'-only messages that are not meant to be read/written
// by any other binaries besides a single Core instance.
%#include "xdr/Stellar-ledger.h"
%#include "xdr/Stellar-SCP.h"

namespace stellar
{
union StoredTransactionSet switch (int v)
{
case 0:
	TransactionSet txSet;
case 1:
	GeneralizedTransactionSet generalizedTxSet;
};

struct StoredDebugTransactionSet
{
	StoredTransactionSet txSet;
	uint32 ledgerSeq;
	StellarValue scpValue;
};

struct PersistedScpStateV0
{
	ScpEnvelope scpEnvelopes<>;
	ScpQuorumSet quorumSets<>;
	StoredTransactionSet txSets<>;
};

struct PersistedScpStateV1
{
	// Tx sets are saved separately
	ScpEnvelope scpEnvelopes<>;
	ScpQuorumSet quorumSets<>;
};

union PersistedScpState switch (int v)
{
case 0:
	PersistedScpStateV0 v0;
case 1:
	PersistedScpStateV1 v1;
};
}