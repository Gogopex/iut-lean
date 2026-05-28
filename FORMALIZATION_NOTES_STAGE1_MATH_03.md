# Stage 1 Mathematical Formalization Notes, Part 03

This file continues `FORMALIZATION_NOTES_STAGE1_MATH_02.md`.

The immediate focus is the lowest currently visible input in the direct route:
constructing packet-local-object estimates from local/cusp data, while keeping
the Corollary 3.12 real-line and label-identification questions explicit.

## 104. Transition Audit: Current Route Boundary

### Verified State

The current Lean route proves the target-to-Theta-average bound from the
following direct-branch inputs:

```text
packet-local-object estimates for cusp classes and zero
direct packet normalization for each audited packet
target capsule estimates for each audited packet
```

It also exposes an `(Ind2)` transported branch where source capsule estimates
and source packet-normalization compatibility are transported across an audited
`(Ind2)` direct-summand step.

The current code has no proof holes:

```text
rg "sorry|admit|axiom|unsafe" Iut/Stage1
```

The only match is the word "unsafe" in a prose comment.

### Mathematical Boundary

The next real construction target is:

```text
cusp/zero local-object estimates attached to the packet local object
```

This is lower than the previous average-level and packet-normalized assumptions.
It is also the right place to connect the Stage 1 source route back to the
foundation layer:

```text
LocalLabCuspModel
CuspLabelClassData
ZMod sign-label quotient
local tensor packets/log-shell objects
```

### Guardrails

The next Lean moves should preserve these distinctions:

```text
zero label vs nonzero sign-label quotient
labelwise equality vs equality of averages
source packet vs target packet under (Ind2)
packet local object vs arbitrary local object
```

We should not introduce a theorem that silently identifies all of these as the
same object.  Any new constructor should make the identification source visible
in its fields or in a source-classification theorem.

## 105. Classifying Packet-Local-Object Estimate Sources

### Goal

We made the source of packet-local-object estimates explicit.

### Lean Move

We added:

```text
IUTStage1PacketLocalObjectEstimateSource
```

with the cases:

```text
directLocalCuspConstruction
ind2TransportedLocalCuspConstruction
separateLocalObjectEstimate
```

and wrapped the packet-local-object audit in:

```text
FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit
```

The wrapper has constructors for each source case and inherits the direct
packet endpoint:

```text
targetSigned_le_thetaSourceAverage_of_directPacket
```

### Mathematical Point

The current lowest-level assumption is no longer an anonymous packet-local
object estimate.  Any route using these estimates can now say whether they are
intended to come from direct local/cusp construction, from transported local
cusp construction, or from a separate local-object estimate.

### Trap Avoided

This prevents us from silently treating a separately supplied real-line/local
object identification as though it had been constructed from the actual local
cusp data.  That distinction is one of the main things the formalization is
supposed to police.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_packet_local_object_direct_example
placeAudited_logVolume_fl_zmod_classified_packet_local_object_target_bound_example
```

### Remaining Gap

The classification still does not construct the estimates.  The next target is
to define a local/cusp construction interface whose output is a classified
packet-local-object estimate with source
`directLocalCuspConstruction`.
