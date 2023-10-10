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

struct PersistedSCPStateV0
{
	SCPEnvelope scpEnvelopes<DEFAULT_SIZE_LIMIT>;
	SCPQuorumSet quorumSets<DEFAULT_SIZE_LIMIT>;
	StoredTransactionSet txSets<DEFAULT_SIZE_LIMIT>;
};

struct PersistedSCPStateV1
{
	// Tx sets are saved separately
	SCPEnvelope scpEnvelopes<DEFAULT_SIZE_LIMIT>;
	SCPQuorumSet quorumSets<DEFAULT_SIZE_LIMIT>;
};

union PersistedSCPState switch (int v)
{
case 0:
	PersistedSCPStateV0 v0;
case 1:
	PersistedSCPStateV1 v1;
};
}