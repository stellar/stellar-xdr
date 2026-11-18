// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

typedef opaque Value<>;

struct ScpBallot
{
    uint32 counter; // n
    Value value;    // x
};

enum ScpStatementType
{
    SCP_ST_PREPARE = 0,
    SCP_ST_CONFIRM = 1,
    SCP_ST_EXTERNALIZE = 2,
    SCP_ST_NOMINATE = 3
};

struct ScpNomination
{
    Hash quorumSetHash; // D
    Value votes<>;      // X
    Value accepted<>;   // Y
};

struct ScpStatement
{
    NodeId nodeId;    // v
    uint64 slotIndex; // i

    union switch (ScpStatementType type)
    {
    case SCP_ST_PREPARE:
        struct
        {
            Hash quorumSetHash;       // D
            ScpBallot ballot;         // b
            ScpBallot* prepared;      // p
            ScpBallot* preparedPrime; // p'
            uint32 nC;                // c.n
            uint32 nH;                // h.n
        } prepare;
    case SCP_ST_CONFIRM:
        struct
        {
            ScpBallot ballot;   // b
            uint32 nPrepared;   // p.n
            uint32 nCommit;     // c.n
            uint32 nH;          // h.n
            Hash quorumSetHash; // D
        } confirm;
    case SCP_ST_EXTERNALIZE:
        struct
        {
            ScpBallot commit;         // c
            uint32 nH;                // h.n
            Hash commitQuorumSetHash; // D used before EXTERNALIZE
        } externalize;
    case SCP_ST_NOMINATE:
        ScpNomination nominate;
    }
    pledges;
};

struct ScpEnvelope
{
    ScpStatement statement;
    Signature signature;
};

// supports things like: A,B,(C,D,E),(F,G,(H,I,(J,K,(L,M))))
// only allows 4 levels of nesting
struct ScpQuorumSet
{
    uint32 threshold;
    NodeId validators<>;
    ScpQuorumSet innerSets<>;
};
}
