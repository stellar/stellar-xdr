# Definition
External Data Representation Standard (XDR) is a standard for the description and encoding of data.  
It is a standardized serialization format defined in [RFC 4506](https://datatracker.ietf.org/doc/html/rfc4506.html) 
and used for several standard unix and internet protocols and formats.
It is useful for transferring data between different computer architectures, and it has been used 
to communicate data between such diverse machines.

[stellar-core](https://github.com/stellar/stellar-core) leans heavily on the XDR data format used in Stellar Network.
XDR is used for 3 related but different tasks in stellar-core,
  * Exchanging peer-to-peer network protocol messages and achieving consensus.
  * Cryptographically hashing ledger entries, buckets, transactions, and similar values.
  * Storing and retrieving history (discussed in this document).

# Making modifications
There are several kinds of XDR definitions in the stellar-xdr repository. 
Different approaches need to be used based on the kind of the XDR being modified.

- Protocol related changes
    These are changes that are a part of the Stellar protocol which must come into effect at the protocol boundary.
    Specifically, changes that transitively modify LedgerEntry, LedgerHeader, TransactionEnvelope and StellarValue.
    In general, protocol changes should be merged into next branch and stay there until the maximum supported 
    protocol version has been increased in a major stellar-core release.
    
    When bumped to support the respective XDR revision, Core logic has to guard the logic related to the new XDR 
    based on the protocol version. For example, if TxSet format changes, Core has to start accepting the new format 
    only after the protocol upgrade has happened and not when the respective XDR becomes parseable.
    
    In some cases its safe to merge the protocol changes into curr branch immediately. An example for this is
    changes that only modify the LedgerEntry and not LedgerKey. The reason is that modified LedgerEntry may only 
    be created via consensus and there is no need to validate externally provided LedgerEntry XDR.

    TransactionEnvelope technically can be modified in the curr branch as well, as Core will only accept 
    TransactionEnvelopes that can be parsed by the Soroban host corresponding to the current protocol. 
    However, the changes in curr branch may get released in a minor XDR release and confuse the clients and allow 
    building XDR that won’t be valid for a while.
    Hence, when in doubt just make the changes only in the next branch.

- Overlay changes
    These are the changes that don’t affect the Stellar protocol, but do affect the overlay communication protocol
    Overlay version is tracked via OVERLAY_PROTOCOL_VERSION. Overlay XDR evolves independently of protocol 
    boundary, but OVERLAY_PROTOCOL_VERSION should be properly maintained. Core must correctly handle latest 
    overlay protocol, as well as be backwards compatible up to OVERLAY_PROTOCOL_MIN_VERSION

    Note: Avoid adding extensions to XDR structs for easier deprecation. For example, SEND_MORE message type has 
    no extensions and the extension is handled with the new message type SEND_MORE_EXTENDED
    When a core version drops support for old overlay (typically after 90 days of backward compatibility), we 
    can simply remove SEND_MORE XDR struct definition completely. This allows removing all the code handling 
    SEND_MORE explicitly and rely on XDR decoder instead.

- TransactionMeta changes
    These are the changes that only affect the TxMeta that Core emits. These are not protocol changes and they 
    can be merged into both curr and next branches given that they are backward compatible.
    However, emitting the meta in updated format should be either guarded by the protocol version or by a 
    separate configuration flag (off by default) to avoid disrupting downstream systems that ingest the meta.

- Contract spec changes
    XDR definitions that are only used by the smart contracts and are never read by the Core logic. 
    Currently this applies to Stellar-contract-spec.x
    Since, this has nothing to do with Core, modifications in this XDR don’t need to correlated in any way 
    with the Core/Soroban environment releases. The changes should be handled by the Soroban SDK and any 
    consumers of the spec (such as CLI). 
    Breaking changes should go into a major SDK release. 
    Non-breaking and backwards-compatible changes can go into minor releases.

- Internal changes
    Definitions in Stellar-internal.x are purely internal to stellar-core, should have no users downstream. 
    These can be modified anytime.