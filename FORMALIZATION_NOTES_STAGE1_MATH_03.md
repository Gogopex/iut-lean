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

## 106. Foundation Anchor for Packet-Local-Object Estimates

### Goal

We exposed the canonical `ZMod l` local cusp-label model at the
packet-local-object estimate layer.

### Lean Move

Inside:

```text
FLZModCuspLabelThetaPacketLocalObjectContainerAudit
```

we added:

```text
localLabCuspModel_eq_zmod
cuspLabelClassData_eq_zmod
```

These theorems project the existing foundation facts carried by the
`FLZModCuspLabelAveragedInd12Audit` inside the Theta source.

### Mathematical Point

The packet-local-object estimate layer is now visibly tied to the canonical
foundation data:

```text
LocalLabCuspModel = zmodLocalLabCuspModel l
CuspLabelClassData = zmodCanonicalCuspLabelClassData l
```

This matters because the next construction should not treat cusp labels as an
anonymous finite type.  The estimates must be attached to the same canonical
`ZMod l` cusp-label model used by the label average.

### Trap Avoided

We did not introduce a second, independent cusp-label model at the packet-local
object layer.  The theorems project the model already carried by the audited
Theta source, so any later mismatch between the estimate source and the label
average has to appear as an explicit failure.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_packet_local_object_cusp_model_example
placeAudited_logVolume_fl_zmod_packet_local_object_cusp_data_example
```

### Remaining Gap

The actual construction of packet-local-object estimates from this canonical
cusp-label data remains open.  The next Lean step should introduce only the
minimal interface needed to say that such estimates are produced from the
canonical local cusp construction.

## 107. Shared Packet Local-Object Estimate for All Cusp Labels

### Goal

We reduced labelwise freedom in the packet-local-object estimate layer.

### Lean Move

We added:

```text
FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit
```

This audit supplies, for each audited packet, one local-object container
estimate for the packet local object's finite log-volume:

```text
packetLocalObjectEstimate audited
```

It also supplies explicit equalities from each cusp-class and zero log-volume
to that packet finite log-volume.

Lean then constructs:

```text
toPacketLocalObjectContainerAudit
toClassifiedPacketLocalObjectContainerAudit
estimateSource_eq_direct
```

The cusp and zero estimates are obtained by transporting the single packet
local-object estimate along the corresponding log-volume equality.

### Mathematical Point

This is closer to the intended local picture than arbitrary per-label local
object estimates.  The formal route now has an intermediate layer saying:

```text
one packet local object supplies the local estimate
all cusp/zero log-volumes are explicitly identified with that object
```

Only after those identifications are provided do we obtain the labelwise
packet-local-object estimates.

### Trap Avoided

We did not allow each label to silently choose its own local object.  Every
labelwise estimate is transported from the same packet local-object estimate,
and the source is classified as `directLocalCuspConstruction`.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_shared_packet_object_to_packet_local_example
placeAudited_logVolume_fl_zmod_shared_packet_object_to_classified_example
placeAudited_logVolume_fl_zmod_shared_packet_object_source_example
```

### Remaining Gap

The shared packet estimate still requires explicit cusp/zero log-volume
equalities.  The next construction should connect those equalities to the
canonical nonzero sign-label quotient and the separate zero label, rather than
treating them as unstructured real-line equalities.

## 108. Shared Packet Estimates from ZMod Label Equality

### Goal

We derived the shared packet-local-object audit from a `ZMod l` label-family
equality to the packet local object's finite log-volume.

### Lean Move

We added:

```text
FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit
```

It supplies:

```text
packetLocalObjectEstimate audited
averaged ZMod label(j) = packet local-object finite log-volume
```

Lean then proves:

```text
cuspLogVolume_normalized_eq_packetLocalObjectFinite
cuspClassLogVolume_eq_packetLocalObjectFinite
zeroLogVolume_eq_packetLocalObjectFinite
toSharedPacketLocalObjectEstimateAudit
toClassifiedPacketLocalObjectContainerAudit
estimateSource_eq_direct
```

The cusp-class theorem uses:

```text
IUTStage1ZModCuspLabelLogVolumeCompatibility
  .cuspClass_eq_of_normalizedLogVolume_eq
```

and the zero theorem uses:

```text
IUTStage1ZModCuspLabelLogVolumeCompatibility
  .zeroLogVolume_eq_of_normalizedLogVolume_eq
```

### Mathematical Point

This connects the shared packet estimate to the actual `ZMod` label family.
Instead of supplying separate cusp-class and zero real-line equalities, we prove
them from a single pointwise statement over `j : ZMod l.value`, then project
through the existing sign-label quotient compatibility.

### Trap Avoided

The zero label is still handled separately.  Nonzero labels pass through the
sign-label quotient theorem; zero passes through the zero-log-volume theorem.
Thus the construction does not pretend that zero is a nonzero cusp sign-label
class.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_cusp_eq_example
placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_to_shared_example
placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_source_example
```

### Remaining Gap

The pointwise `ZMod` equality to the packet local-object finite log-volume is
still supplied as an input.  A later construction should either derive this from
the local definition of the label log-volume family or explicitly classify it as
a separate local label/object identification.

## 109. Theta Average from Shared ZMod Packet-Object Equality

### Goal

We derived the Theta-source average and target bound directly from the shared
`ZMod` packet-local-object route.

### Lean Move

Inside:

```text
FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit
```

we added:

```text
thetaSourceAverage_eq_packetLocalObjectFinite
targetSigned_le_thetaSourceAverage
```

The average equality uses the finite label-average extensional lemma:

```text
IUTStage1LabelAveragedProcessionLogVolume.average_eq_of_pointwise
```

to compare the audited label family with the constant family whose value is the
packet local object's finite log-volume.

The target bound then comes from:

```text
packetLocalObjectEstimate audited
```

not from a packet-normalized or capsule-normalized detour.

### Mathematical Point

This gives a direct local-object route:

```text
every ZMod label value = packet local-object finite log-volume
packet local-object estimate bounds targetSigned
  -> targetSigned <= thetaSourceAverage
```

It is useful because it isolates the analytic/local-object burden from the
packet-normalization burden.  If the local `ZMod` label family can be shown to
be the packet local object, the target-average comparison follows directly.

### Trap Avoided

The proof again goes through pointwise label equality before averaging.  It
does not infer the result from equality of averages alone, and it does not
replace the local-object estimate by a capsule estimate unless a later route
explicitly chooses to do so.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_average_eq_example
placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_target_bound_example
```

### Remaining Gap

The pointwise `ZMod` equality to the packet local object remains the current
lowest explicit equality.  We should next classify or construct this equality
from a concrete local label/object definition.

## 110. Constant ZMod Family for Packet Local Object

### Goal

We reduced the pointwise `ZMod` equality to an object-level constant family
equality at the local-object level.

### Lean Move

We added:

```text
FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit
```

It assumes that the audited `ZMod l` label-averaged log-volume object is
literally:

```text
constant(packet local-object finite log-volume)
```

Lean derives:

```text
zmodNormalizedLogVolume_eq_packetLocalObjectFinite
toSharedZModPacketLocalObjectEstimateAudit
toSharedPacketLocalObjectEstimateAudit
toClassifiedPacketLocalObjectContainerAudit
thetaSourceAverage_eq_packetLocalObjectFinite
targetSigned_le_thetaSourceAverage
```

### Mathematical Point

This is stronger than equality of averages.  The assumption is an equality of
label-family objects, so every `j : ZMod l.value` has the packet local-object
finite log-volume as its normalized value.  The downstream average equality is
then a consequence.

### Trap Avoided

We did not infer labelwise equality from an average equality.  This matters
because the whole route is meant to police exactly where averaging may erase
information relevant to the Corollary 3.12 disagreement.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_constant_packet_object_eq_example
placeAudited_logVolume_fl_zmod_constant_packet_object_to_shared_zmod_example
placeAudited_logVolume_fl_zmod_constant_packet_object_target_bound_example
```

### Remaining Gap

The constant object equality is still an input.  The next useful step is to add
a source classification for this local label/object bridge, separating direct
local label construction from transported or separate identifications.

## 111. Classifying the ZMod-to-Local-Object Bridge

### Goal

We made the source of the constant `ZMod` packet-local-object bridge explicit.

### Lean Move

We added:

```text
IUTStage1ZModPacketLocalObjectBridgeSource
```

with cases:

```text
directLocalLabelObjectConstruction
ind12TransportedLocalLabelObjectConstruction
separateLocalObjectIdentification
```

and wrapped the constant route in:

```text
FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit
```

The wrapper exposes constructors for the three source cases and preserves the
target-average theorem:

```text
targetSigned_le_thetaSourceAverage
```

### Mathematical Point

The pointwise/constant label-to-local-object bridge is now source-tagged.  This
is the current lowest explicit equality in the direct local-object route, so it
should not remain anonymous.

### Trap Avoided

We did not let a separate local-object identification masquerade as a direct
local label construction.  The route can now record this distinction in Lean,
which is important for later comparison with both Mochizuki's use of labeled
Hodge-theater data and Scholze-Stix's insistence on explicit real-line
identifications.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_constant_packet_object_direct_example
placeAudited_logVolume_fl_zmod_classified_constant_packet_object_separate_example
placeAudited_logVolume_fl_zmod_classified_constant_packet_object_bound_example
```

### Remaining Gap

Classification is not construction.  The next mathematical reduction is to
define a direct local label/object construction interface that produces the
constant `ZMod` packet-local-object family, rather than merely classifying an
assumed equality.

## 113. Direct Local Label/Object Construction

### Goal

We replaced the constant `ZMod` packet-local-object family assumption by a more
local construction interface.

### Lean Move

We added:

```text
FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit
```

It supplies, for each audited packet and each `j : ZMod l.value`:

```text
labelLocalObject audited j
labelLocalObject audited j = packet local object
label normalized log-volume(j) = finite log-volume(labelLocalObject audited j)
```

Lean derives:

```text
zmodNormalizedLogVolume_eq_packetLocalObjectFinite
toSharedZModPacketLocalObjectEstimateAudit
toConstantZModPacketLocalObjectEstimateAudit
toClassifiedConstantZModPacketLocalObjectEstimateAudit
bridgeSource_eq_direct
targetSigned_le_thetaSourceAverage
```

### Mathematical Point

This is a lower and more local input than a constant family equality.  The
constant label-family route now follows because each label has an explicitly
provided local object and that object is proved to be the packet local object.

### Trap Avoided

We did not allow the `ZMod` family to become constant by averaging.  Constancy
is derived label by label from local object identifications:

```text
label(j) -> labelLocalObject(j) = packet local object
```

This keeps the labelwise data present at exactly the point where it could
otherwise be lost.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_label_object_zmod_eq_example
placeAudited_logVolume_fl_zmod_direct_label_object_to_constant_example
placeAudited_logVolume_fl_zmod_direct_label_object_source_example
placeAudited_logVolume_fl_zmod_direct_label_object_target_bound_example
```

### Remaining Gap

The direct local label/object interface still supplies the label-local objects
as data.  The next deeper construction should connect those objects to the
canonical `LocalLabCuspModel`/`CuspLabelClassData` foundations, especially the
nonzero sign-label quotient and the separate zero label.

## 112. Source Audit: Labels, Averages, and Real-Line Identifications

### Check Performed

I reread the current route against:

```text
IUT III, Theorem 3.11 / Corollary 3.12 discussion around procession-normalized
  log-volumes and averages over j in F_l
Scholze-Stix, Section 2.2, on explicit identifications of copies of real lines
IUT III toy discussion with distinct q/Theta real-line labels
```

I also checked the Lean source for proof holes:

```text
rg "sorry|admit|axiom|unsafe" Iut/Stage1
```

The only match is the word "unsafe" inside a prose warning comment.

### Alignment

The current Lean route continues to respect the two main pressures:

```text
IUT side: averages over F_l labels are central and should be modeled explicitly.
Scholze-Stix side: real-line/copy identifications must be explicit.
```

The latest bridge classification is therefore useful but not sufficient.  It
records whether the constant `ZMod` packet-local-object family is meant to come
from direct local label construction, `(Ind1)/(Ind2)` transport, or a separate
local-object identification.

### Risk

The route could still become too weak if the constant local-object family is
treated as a primitive assumption forever.  That would verify only a conditional
statement:

```text
if the label family is already the packet local object, then the target-average
bound follows
```

The next construction should push below that condition and specify what local
label/object data is sufficient to produce the constant family.

### Next Target

Define a direct local label/object construction interface that outputs the
constant `ZMod` packet-local-object family and classifies the bridge as:

```text
directLocalLabelObjectConstruction
```
