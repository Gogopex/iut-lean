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

## 114. Direct Label Objects Expose Canonical Cusp/Zero Consequences

### Goal

We made the foundation anchor and cusp/zero consequences visible directly on
the direct local label/object route.

### Lean Move

Inside:

```text
FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit
```

we added:

```text
localLabCuspModel_eq_zmod
cuspLabelClassData_eq_zmod
cuspClassLogVolume_eq_packetLocalObjectFinite
canonicalCuspClassLogVolume_eq_packetLocalObjectFinite
zeroLogVolume_eq_packetLocalObjectFinite
```

The cusp/zero theorems are projections of the existing `ZMod` compatibility
route, but they are now available at the direct label-object layer without
manually unfolding the intermediate shared `ZMod` audit.

### Mathematical Point

This makes the current direct route easier to audit:

```text
direct label objects
  -> all ZMod label values are packet local-object values
  -> every cusp sign-label class is the packet local-object value
  -> zero label is the packet local-object value
```

It also records that the cusp-label model carried by the route is the canonical
`ZMod l` local cusp-label model.

### Trap Avoided

The canonical cusp class and the zero label are exposed separately.  We still
do not treat zero as a member of the nonzero sign-label quotient.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_label_object_cusp_model_example
placeAudited_logVolume_fl_zmod_direct_label_object_canonical_cusp_eq_example
placeAudited_logVolume_fl_zmod_direct_label_object_zero_eq_example
```

### Remaining Gap

The label-local objects are still supplied as a `ZMod`-indexed family.  The next
step should distinguish the nonzero sign-label class construction from the
separate zero-label construction at the level of local objects themselves.

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

## 115. Cusp/Zero Local-Object Split for Direct Label Objects

### Lean Move

I added:

```text
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit.labelLocalObject
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit.normalizedLogVolume_eq_labelLocalObjectFinite
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit.toDirectLocalLabelObjectConstructionAudit
```

This is a refinement of the previous direct label-object route.  Instead of
asking directly for a `ZMod l.value`-indexed local-object family, it asks for:

```text
one local object for every nonzero cusp sign-label class
one separate local object for the zero label
```

The exported `labelLocalObject` then performs the only allowed case split:

```text
j = 0        -> use zeroLocalObject
j != 0       -> use cuspClassLocalObject at zmodSignLabelFromCoordinate l j hj
```

### Mathematical Reason

This is closer to the current Stage 1 model of the local cusp-label object than
the previous direct route.  The local cusp model has a distinguished zero label
and nonzero labels modulo the sign action.  Keeping those two cases separate is
important for the Corollary 3.12 route because a later proof must not silently
identify the zero coordinate with a nonzero cusp class.

The bridge still proves the same endpoint consequence: after the zero/nonzero
split has supplied compatible local-object log-volumes, the construction
forgets the split and produces the existing direct `ZMod` label-object route.
That existing route then yields the target-average bound.

### Trap Avoided

The nonzero branch uses `zmodSignLabelFromCoordinate l j hj`, so a proof of
`j != 0` is required before entering the sign-label quotient.  The zero branch
uses `zeroLogVolume` and never passes through the quotient.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_to_direct_example
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_zero_eq_example
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_target_bound_example
```

### Remaining Gap

The split route still takes the cusp-class and zero local objects as supplied
data.  The next mathematical step should connect these fields to the canonical
`LocalLabCuspModel`/cusp-label construction itself, so that the split is not
merely an interface but is produced from the local cusp-label data.

## 116. Canonical One-Coordinate in the Cusp/Zero Split

### Lean Move

I exposed the canonical coordinate of the `ZMod l` local cusp model:

```text
IUTStage1FLZModCuspLabelClassModel.zmod_canonicalCoordinate_eq_one
IUTStage1FLZModCuspLabelClassModel.zmod_canonicalSignLabel_eq_fromCoordinate_one
IUTStage1FLZModCuspLabelClassModel.zmod_cuspLabelClass_eq_fromCoordinate_one
```

I also added the split-route consequence:

```text
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite
```

### Mathematical Reason

The canonical nonzero label in the current `LocalLabCuspModel` is represented by
`1 : ZMod l.value`.  The foundations layer already proves that this coordinate
maps to `zmodCanonicalSignLabelQuotient l`.  Stage 1 now records that fact at
the route boundary and uses it in the cusp/zero split.

This matters because the split route handles:

```text
0       as the separate zero log-volume
1       as a nonzero cusp sign-label class
```

Thus the canonical cusp class has a concrete nonzero coordinate witness.  The
Lean theorem for `j = 1` must use the nonzero branch and cannot be proved by
the zero branch.

### Trap Avoided

The proof of the `j = 1` branch uses `(zmodOneNonzeroLabel l).2`, so Lean checks
that `1 != 0` in `ZMod l.value`.  This keeps the canonical cusp class tied to
the nonzero quotient, not merely to an arbitrary label name.

### Toy Check

The examples now check:

```text
flZModCuspLabelClassModel_zmod_label_class_from_one_example
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_one_eq_example
```

### Remaining Gap

This pins down the canonical nonzero cusp class, but only for the distinguished
coordinate `1`.  The next useful step is to expose the analogous sign-orbit
invariance for `-1` and then for arbitrary nonzero coordinates modulo sign, so
that the quotient behavior is available in the local-object route rather than
only in the raw compatibility structure.

## 117. Sign-Pair Invariance in the Cusp/Zero Local-Object Route

### Lean Move

I added:

```text
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .neg_normalizedLogVolume_eq_cuspClassLocalObjectFinite
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .neg_one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite
```

The first theorem says that if `j != 0`, then the label `-j` has the finite
log-volume of the same cusp-class local object selected by `j`.  The second is
the canonical specialization for the sign pair `{1, -1}`.

### Mathematical Reason

The local cusp labels are not ordinary `ZMod l` labels after passing to cusp
classes; nonzero coordinates are quotiented by the sign action.  The theorem
uses the existing compatibility result:

```text
IUTStage1ZModCuspLabelLogVolumeCompatibility.neg_nonzero_eq
```

and lifts it into the local-object route.  This keeps the sign quotient visible
at the point where log-volumes are tied to finite local objects.

### Trap Avoided

The proof still requires `j != 0`.  Thus the sign-pair theorem only applies to
the nonzero quotient and cannot be used to smuggle the zero label into a cusp
class.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_eq_example
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_one_eq_example
```

### Remaining Gap

The route now knows that opposite nonzero coordinates share a cusp-class local
object.  The next useful refinement is to expose this at the level of local
objects themselves, not only at the level of their finite log-volumes.

## 118. Self-Audit: Stage 1 Boundary and Zero/Nonzero Labels

### Check Performed

I reread the current Lean route against the local copies of:

```text
ON THE FORMALIZATION OF IUT.md, §2 and §4
IUT I, Remark 6.12.5
IUT II discussion around distinct theta labels and conjugate synchronization
```

The formalization note explicitly identifies the first stage as:

```text
[IUTchIII] Theorem 3.11 => Corollary 3.12
```

and describes the current Lean effort as skeletal Stage 1.  This matches the
current project boundary: we are not trying to prove all of IUT at once, but to
formalize the route from label/procession data to the Corollary 3.12-shaped
log-volume comparison.

### Alignment

IUT I, Remark 6.12.5 stresses that the relevant `F_l`/`F_l^±` symmetry relates
zero-labeled and nonzero-labeled prime-strips, while also warning that one must
not confuse the zero-labeled prime-strip with nonzero-labeled prime-strips.
This supports the current design:

```text
zero label             -> separate zeroLogVolume / zeroLocalObject branch
nonzero sign classes   -> SignLabelQuotient / cuspClassLocalObject branch
```

The code is intentionally proving bridges between these branches only through
explicit compatibility fields or theorems.  It is not identifying zero with a
nonzero sign class.

IUT II's discussion of distinct labels and conjugate synchronization also
supports keeping label distinctions visible at the point where Kummer/log-volume
data are compared.  The current Lean route keeps the sign quotient explicit
before passing to finite local-object log-volumes.

### Current Risk

The current local-object route is still conditional: it assumes the cusp-class
and zero local-object identifications, then verifies their consequences.  The
next implementation should continue lowering those assumptions toward data that
is closer to the Hodge-theater/local-cusp construction.

### Next Target

Expose sign-orbit equivalence at the local-object level itself:

```text
cuspClassLocalObject audited (label of j)
=
cuspClassLocalObject audited (label of -j)
```

This should be proved through the quotient equality rather than by any
zero/nonzero shortcut.

## 119. Sign-Orbit Equality of Cusp-Class Local Objects

### Lean Move

I added:

```text
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .cuspClassLocalObject_negCoordinate_eq
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .cuspClassLocalObject_neg_one_eq_canonical
```

These prove equality of the actual finite local objects indexed by opposite
nonzero coordinates, not just equality of their finite log-volumes.

### Mathematical Reason

The previous theorem lifted sign-pair invariance to log-volumes.  This one uses
the quotient identity:

```text
zmodSignLabelFromCoordinate_neg_eq
```

directly in the index of `cuspClassLocalObject`.  Thus the local object indexed
by the sign class of `-j` is definitionally transported to the local object
indexed by the sign class of `j`.

### Trap Avoided

The theorem is only stated for `j != 0`.  The zero local object remains outside
the sign-label quotient, and the canonical `-1` theorem explicitly uses the
proof that `1 != 0`.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_object_eq_example
placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_one_object_eq_example
```

### Remaining Gap

We now have the sign quotient under control for the local-object index.  The
next boundary is the stronger IUT concern about relating zero-labeled and
nonzero-labeled data via permitted symmetries without collapsing them.  That
will likely require an explicit "zero-to-nonzero comparison source" rather than
an equality of labels.

## 120. Conditional Zero-to-Nonzero Collapse Through Packet Local Object

### Lean Move

I added:

```text
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .zeroLocalObject_eq_cuspClassLocalObject
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .zeroLocalObject_eq_canonicalCuspClassLocalObject
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .zeroLogVolume_eq_cuspClassLogVolume
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
  .zeroLogVolume_eq_canonicalCuspClassLogVolume
```

### Mathematical Reason

This is deliberately a conditional theorem.  In the current route, both the
zero branch and every nonzero cusp-class branch are assumed to be identified
with the audited packet local object:

```text
zeroLocalObject audited = packet local object
cuspClassLocalObject audited label = packet local object
```

Lean therefore proves that the zero local object and each cusp-class local
object are equal.  The corresponding log-volumes are equal for the same reason.

### Trap Exposed

This is exactly the kind of collapse that must not be hidden.  The theorem does
not identify the zero label with a nonzero sign-label class.  It identifies the
local objects only after the route has assumed that both branches are the same
packet local object.

Thus, if a future attempt to model Corollary 3.12 needs zero/nonzero data to
remain insulated longer, this theorem marks the precise assumption that causes
the collapse:

```text
zeroLocalObject_eq_packetLocalObject
cuspClassLocalObject_eq_packetLocalObject
```

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_cusp_zero_zero_to_cusp_object_eq_example
placeAudited_logVolume_fl_zmod_cusp_zero_zero_to_canonical_log_eq_example
```

### Remaining Gap

The next step should not add more consequences of this collapse.  It should
split the route into two variants:

```text
comparison route: zero/nonzero branches may be compared through a packet object
insulated route: zero/nonzero branches remain separate until an explicit bridge
```

That split will let us test whether Corollary 3.12 needs the comparison route
and where the required bridge is supposed to come from.

## 121. Insulated Cusp/Zero Local-Object Route

### Lean Move

I added:

```text
FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit
FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit
  .labelLocalObject
FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit
  .normalizedLogVolume_eq_labelLocalObjectFinite
FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit
  .one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite
FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit
  .neg_normalizedLogVolume_eq_cuspClassLocalObjectFinite
FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit
  .cuspClassLocalObject_negCoordinate_eq
```

### Mathematical Reason

This route records the zero branch and the nonzero cusp-class branch without
identifying either branch with the packet local object.  It still proves the
basic `ZMod` label-to-local-object facts:

```text
j = 0      -> zeroLocalObject
j != 0     -> cuspClassLocalObject at the sign class of j
```

It also preserves the sign quotient for nonzero coordinates.  What it does not
prove is any equality between `zeroLocalObject` and `cuspClassLocalObject`.

### Trap Avoided

This gives us a Lean object representing the pre-collapse state.  Any later
proof that zero and nonzero branches become comparable must pass through an
additional bridge, rather than being inherited from the route itself.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_insulated_cusp_zero_zero_eq_example
placeAudited_logVolume_fl_zmod_insulated_cusp_zero_one_eq_example
placeAudited_logVolume_fl_zmod_insulated_cusp_zero_neg_object_eq_example
```

### Remaining Gap

The next step is to add a bridge from the insulated route to the comparison
route.  That bridge should contain precisely the packet-local-object
identifications that cause the zero/nonzero collapse, making the disputed
assumption boundary easy to inspect.

## 122. Packet Bridge from Insulated to Comparison Route

### Lean Move

I added:

```text
FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit
  .toCuspZeroLocalLabelObjectConstructionAudit
FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit
  .zeroLocalObject_eq_cuspClassLocalObject
FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit
  .zeroLogVolume_eq_cuspClassLogVolume
FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit
  .targetSigned_le_thetaSourceAverage
```

### Mathematical Reason

The insulated route has separate zero and nonzero local objects.  The bridge
adds exactly the missing packet identifications:

```text
cuspClassLocalObject audited label = packet local object
zeroLocalObject audited = packet local object
```

Once those are supplied, Lean can convert the insulated route into the earlier
comparison route and inherit the zero/nonzero comparison consequences and the
target-average bound.

### Trap Exposed

The collapse now has a named bridge.  If the Corollary 3.12 route requires this
bridge, then a later formal proof must justify the packet-local-object
identifications from the actual IUT construction.  The insulated route alone
does not justify them.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_insulated_packet_bridge_to_comparison_example
placeAudited_logVolume_fl_zmod_insulated_packet_bridge_zero_to_cusp_example
placeAudited_logVolume_fl_zmod_insulated_packet_bridge_target_bound_example
```

### Remaining Gap

This is still an abstract bridge.  The next step should classify the bridge
source: direct local construction, `(Ind1)/(Ind2)` transport, or a separate
local-object comparison lemma.  This mirrors the earlier source classifications
and keeps the disputed identification auditable.

## 123. Classified Insulated-to-Packet Bridge

### Lean Move

I added:

```text
FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit
  .ofDirectLocalLabelObjectConstruction
FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit
  .ofInd12TransportedLocalLabelObjectConstruction
FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit
  .ofSeparateLocalObjectIdentification
FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit
  .toCuspZeroLocalLabelObjectConstructionAudit
```

### Mathematical Reason

The packet bridge is now tagged with the same source enum used for the existing
constant `ZMod` packet-local-object bridge:

```text
IUTStage1ZModPacketLocalObjectBridgeSource
```

This keeps the zero/nonzero comparison source visible.  A proof may say that
the bridge is direct local construction, transported construction, or separate
local-object identification, but it cannot use the bridge without choosing one
of these sources.

### Trap Avoided

The classified object does not make the bridge more true.  It only records the
provenance of the packet-local-object identifications.  This is important for
review because the bridge is exactly where the insulated route becomes the
comparison route.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_insulated_bridge_direct_example
placeAudited_logVolume_fl_zmod_classified_insulated_bridge_source_example
placeAudited_logVolume_fl_zmod_classified_insulated_bridge_target_bound_example
```

### Remaining Gap

The classification is still user-supplied.  The next mathematical target is to
connect one of the classifications, preferably the direct local construction
branch, to already formalized direct packet-normalization/local-object data.

## 124. Direct Identified Packet Route Produces the Insulated Bridge

### Lean Move

I added:

```text
FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit
  .toInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit
  .toClassifiedInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit
  .insulatedPacketBridgeSource_eq_direct
```

### Mathematical Reason

The direct identified local packet route already contains:

```text
direct packet normalization data
target capsule estimates
cusp-class log-volume = packet local-object finite log-volume
zero log-volume = packet local-object finite log-volume
```

From this data Lean can build the insulated route by choosing the packet local
object as the branch object for each cusp class and for zero.  It then builds
the packet bridge using the direct packet normalization container estimate.

### Trap Avoided

This does not make the insulated route collapse by itself.  It says that one
specific source, the direct identified packet route, supplies the bridge that
causes the comparison route.  The source tag is forced to:

```text
directLocalLabelObjectConstruction
```

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_identified_to_insulated_bridge_example
placeAudited_logVolume_fl_zmod_direct_identified_to_classified_insulated_bridge_example
placeAudited_logVolume_fl_zmod_direct_identified_insulated_bridge_source_example
```

### Remaining Gap

The direct identified route is still an interface: it assumes the cusp/zero
log-volume-to-local-object equalities.  The next step should investigate whether
those equalities can be derived from packet-normalized equalities plus direct
normalization, or whether they need a separate Hodge-theater/local-object
construction.

## 125. Direct Packet-Normalized Route Produces the Insulated Bridge

### Lean Move

I added:

```text
FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit
  .toInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit
  .toClassifiedInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit
  .insulatedPacketBridgeSource_eq_direct
```

### Mathematical Reason

This lowers the bridge source one step.  Instead of assuming directly that
cusp/zero log-volumes are the packet local-object finite log-volume, this route
starts from:

```text
cusp/zero log-volumes = packet-normalized capsule-family log-volume
direct packet normalization identifies packet-normalized value with local object
```

Lean composes those facts to produce the same insulated-to-packet bridge.

### Trap Avoided

The zero/nonzero collapse is still not free.  It now comes from packet-normalized
identifications plus direct normalization.  This is closer to the actual
Corollary 3.12 pressure point: where are the packet-normalized real values
allowed to be compared with finite local objects?

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_packet_normalized_to_insulated_bridge_example
placeAudited_logVolume_fl_zmod_direct_packet_normalized_insulated_bridge_source_example
```

### Remaining Gap

The next step should push one level further back to the `ZMod` packet-normalized
route, where the equalities are stated labelwise over `ZMod l.value` before
being converted into cusp-class and zero log-volume equalities.

## 126. ZMod Packet-Normalized Route Produces the Insulated Bridge

### Lean Move

I added:

```text
FLZModCuspLabelThetaZModPacketNormalizedRouteAudit
  .toInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaZModPacketNormalizedRouteAudit
  .toClassifiedInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaZModPacketNormalizedRouteAudit
  .insulatedPacketBridgeSource_eq_direct
```

### Mathematical Reason

This pushes the bridge source back to the labelwise `ZMod l.value` route.  From
a theorem saying every `ZMod` label's normalized log-volume is the packet
normalized value, Lean first recovers the cusp-class and zero equalities via the
existing cusp-label compatibility theorem.  Then direct packet normalization
supplies the local-object bridge.

The route is now:

```text
ZMod labelwise packet-normalized equality
  -> cusp/zero packet-normalized equality
  -> direct packet-normalized local-object route
  -> insulated packet bridge
```

### Trap Avoided

The zero/nonzero comparison is still downstream of explicit labelwise equality
and direct normalization.  The proof does not identify zero as a sign-label
class; it converts zero through the separate zero theorem of the compatibility
structure.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_zmod_packet_to_insulated_bridge_example
placeAudited_logVolume_fl_zmod_zmod_packet_insulated_bridge_source_example
```

### Remaining Gap

The next step should expose the strongest version: a constant `ZMod` packet
family gives the same insulated bridge.  That will make clear that a constant
label family is sufficient to collapse the insulated zero/nonzero route through
the packet object.

## 127. Constant ZMod Packet Family Produces the Insulated Bridge

### Lean Move

I added:

```text
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
  .toInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
  .toClassifiedInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
  .insulatedPacketBridgeSource_eq_direct
```

### Mathematical Reason

A constant `ZMod` packet-normalized label family implies the labelwise `ZMod`
packet-normalized route.  Therefore it also produces the insulated packet
bridge.  This makes the consequence explicit:

```text
constant label family
  -> labelwise packet equality
  -> cusp/zero packet bridge
```

### Trap Exposed

If a proof assumes a constant label family too early, then the insulated
zero/nonzero distinction can be collapsed through the packet object.  Lean now
marks this as a theorem, not an implicit informal inference.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_constant_packet_to_insulated_bridge_example
placeAudited_logVolume_fl_zmod_constant_packet_insulated_bridge_source_example
```

### Remaining Gap

The next useful self-audit is to review whether the constant-family route is
intended to model a genuine IUT Hodge-theater operation or merely a simplified
comparison route.  This is close to the Scholze-Stix concern: a premature
constant-family assumption may erase exactly the history that Mochizuki says is
handled by Hodge theaters.

## 128. Self-Audit: Constant Families and the Scholze-Stix Collapse Concern

### Check Performed

I reread the current constant-family bridge against:

```text
Scholze-Stix, §2.2, "Proof of [IUTT-3, Corollary 3.12]"
ON THE FORMALIZATION OF IUT.md, §4, "Skeletal Lean code for 3.11.5 => 3.12"
README.md, project dispute summary
```

### Alignment

Scholze-Stix emphasize that the critical step requires spelling out all
identifications between copies of ordered one-dimensional real vector spaces.
They also state that, under simplifications such as identifying identical copies
of objects along the identity, the relevant Theorem 3.11 data becomes trivial
rather than false.  Our Lean route now makes an analogous phenomenon explicit:

```text
constant ZMod packet family
  -> labelwise packet equality
  -> insulated zero/nonzero bridge
  -> zero/nonzero local-object comparison
```

This does not decide whether IUT is correct.  It says that if the formalization
uses the constant-family route, then the formal proof is using a simplification
strong enough to produce the zero/nonzero comparison by packet-object
identification.

Mochizuki's formalization note describes the relevant Stage 1 as a reorganized
comparison involving the 0-column, descent, hull+det, and indeterminacies
`(Ind1,2,3)`.  That suggests the next Lean route should distinguish:

```text
constant comparison route
Hodge-theater/descent route with explicit history-erasing bridge
```

### Risk

If we treat the constant-family bridge as the actual IUT mechanism, we may
formalize a simplified route that Scholze-Stix would regard as collapsing the
critical content.  Conversely, if Mochizuki's Hodge-theater route supplies a
different kind of bridge, we need a separate Lean interface for it rather than
reusing the constant-family bridge silently.

### Next Target

Introduce a bridge-source distinction between:

```text
constantZModPacketFamily
hodgeTheaterDescentIndeterminacy
separateRealLineIdentification
```

This should not replace the existing packet-local-object bridge source; it
should classify the higher-level reason that the insulated route is allowed to
be compared through the packet object.

## 129. Higher-Level Source for Insulated Cusp/Zero Bridge

### Lean Move

I added:

```text
IUTStage1InsulatedCuspZeroBridgeSource
FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit
  .ofDirectPacketNormalization
FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit
  .ofLabelwiseZModPacketEquality
FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit
  .ofConstantZModPacketFamily
FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit
  .ofHodgeTheaterDescentIndeterminacy
FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit
  .ofSeparateRealLineIdentification
```

### Mathematical Reason

The lower-level bridge source records how local objects are identified with the
packet local object.  The new source records why the insulated zero/nonzero
route is being compared through such a packet bridge in the first place.

This is the distinction needed after the Scholze-Stix audit:

```text
constantZModPacketFamily           -> simplified constant-family route
hodgeTheaterDescentIndeterminacy   -> future IUT-style history-erasing route
separateRealLineIdentification     -> explicit external comparison
```

### Trap Avoided

The constant-family route and a future Hodge-theater route are no longer forced
to share the same explanation.  They may produce the same kind of packet bridge,
but the higher-level source remains inspectable.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_constant_packet_sourced_bridge_example
placeAudited_logVolume_fl_zmod_constant_packet_sourced_bridge_source_example
placeAudited_logVolume_fl_zmod_hodge_descent_sourced_bridge_example
```

### Remaining Gap

The Hodge-theater/descent source is currently only a classification constructor.
The next mathematical work should define what data a Hodge-theater/descent
bridge must carry before it is allowed to produce the classified packet bridge.

## 130. Hodge-Theater/Descent Wrapper for the Insulated Bridge

### Lean Move

I added:

```text
IUTStage1HodgeTheaterDescentBridgeData
FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
  .toSourcedInsulatedCuspZeroPacketBridgeAudit
FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
  .comparisonSource_eq_hodgeTheaterDescent
FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
  .histories_not_identified
```

### Mathematical Reason

The Hodge-theater/descent source can no longer be just a tag.  It must carry:

```text
domain Hodge theater
codomain Hodge theater
descent operation identifier
zero-column checkpoint
indeterminacy profile
proof that the theater histories are not identified
classified insulated packet bridge
```

This follows the existing qualitative-data discipline in the repo: Hodge
theater histories may be related by a structured bridge, but they are not
silently the same history.

### Trap Avoided

This wrapper still does not prove the hard Hodge-theater bridge.  It only states
what must be present before we are allowed to classify a packet bridge as
`hodgeTheaterDescentIndeterminacy`.  This prevents reusing the constant-family
route while labeling it as a Hodge-theater route.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_hodge_descent_bridge_to_sourced_example
placeAudited_logVolume_fl_zmod_hodge_descent_bridge_source_example
placeAudited_logVolume_fl_zmod_hodge_descent_bridge_history_example
```

### Remaining Gap

The wrapper still accepts the classified packet bridge as input.  The next step
is to isolate which fields of `IUTStage1HodgeTheaterDescentBridgeData` should
produce that bridge, rather than merely accompany it.

## 131. Hodge-Descent Bridge Data Extracted from Structured SHE Inputs

### Lean Move

I added a canonical extractor:

```text
IUTStage1Theorem311StructuredInputsWithSHE.hodgeTheaterDescentBridgeData
```

and projection checks for its domain theater, codomain theater, descent
operation, fourth-triangle HDD/SHE checkpoint, indeterminacy profile, and
history-separation proof.

I also added:

```text
FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
  .ofStructuredInputsWithSHE
```

which builds the Hodge-descent wrapper from structured SHE inputs plus the still
explicit insulated packet bridge.

### Mathematical Reason

The previous wrapper required Hodge-theater/descent data, but that data could be
chosen independently.  This was too loose for the Corollary 3.12 dispute: the
Hodge-theater explanation must be tied to the same structured SHE and HDD data
used on the Theorem 3.11 side of the route.

The extractor now fixes that tie:

```text
domain theater      = structured SHE domain theater
codomain theater    = structured SHE codomain theater
descent             = package common-container HDD descent
zero checkpoint     = fourth-triangle HDD-after-SHE checkpoint
indeterminacies     = package Ind1-Ind2-Ind3 profile
history separation  = structured SHE history-separation proof
```

This mirrors the source-side reading we are using: the Hodge-theater route is
not a bare real-line identification.  It is a descent/SHE/HDD route whose
history discipline has to be visible in the formal object.

### Trap Avoided

This still does not derive the packet bridge from Hodge theory.  The insulated
packet bridge remains an input.  The improvement is that a bridge may now be
called Hodge-descent-sourced only when its Hodge metadata comes from structured
SHE inputs, rather than from arbitrary labels.

This is important for the Scholze-Stix/Mochizuki pressure point: we should not
silently identify the two histories and then later claim that Hodge-theater
descent preserved the missing distinction.

### Toy Check

The examples now check:

```text
unitThetaToy_source_theorem311_hodge_descent_bridge_data_example
unitThetaToy_source_theorem311_hodge_descent_bridge_data_descent_example
unitThetaToy_source_theorem311_hodge_descent_bridge_data_history_example
placeAudited_logVolume_fl_zmod_hodge_descent_bridge_from_she_example
placeAudited_logVolume_fl_zmod_hodge_descent_bridge_from_she_source_example
placeAudited_logVolume_fl_zmod_hodge_descent_bridge_from_she_history_example
```

### Remaining Gap

The next mathematical gap is the hard one: specify which structured SHE/HDD
facts actually justify the packet bridge equalities.  At present the
formalization records the correct source of the Hodge-descent data, but it does
not yet construct the packet-local-object identifications from that source.

## 132. Low-Level Source for Hodge-Descent Packet Transport

### Lean Move

I extended:

```text
IUTStage1ZModPacketLocalObjectBridgeSource
```

with:

```text
hodgeTheaterDescentPacketTransport
```

and strengthened:

```text
FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
```

so that its classified packet bridge must have this low-level source.

The structured-SHE constructor now takes an unclassified insulated packet bridge
and classifies it internally as `hodgeTheaterDescentPacketTransport`.

### Mathematical Reason

The previous state still had a subtle drift risk: the high-level comparison
source could say "Hodge-theater descent", while the low-level packet bridge
could still be tagged as a direct local label/object construction, a constant
family, or a separate identification.

That is too permissive for the Corollary 3.12 dispute.  If the point of the
route is that a Hodge-theater/descent construction preserves a distinction that
a naive real-line identification would erase, then the local packet bridge must
carry a Hodge-descent source at the low level too.

### Trap Avoided

We no longer allow the following silent mismatch:

```text
high-level source = hodgeTheaterDescentIndeterminacy
low-level source  = directLocalLabelObjectConstruction
```

through the canonical constructor.  Manual construction of a Hodge wrapper also
requires a proof that the classified bridge source is the Hodge-descent packet
transport source.

### Toy Check

The examples now check that a bridge constructed from structured SHE has:

```text
classified_bridge.bridge_source =
  IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport
```

### Remaining Gap

The source tag is now honest, but still not mathematically sufficient.  The
next target is to make the Hodge-descent packet transport expose the actual
zero/cusp-class-to-packet-local-object identifications as named consequences of
structured SHE/HDD data, rather than merely as the fields of an insulated packet
bridge.

## 133. Hodge-Descent Packet Transport Audit

### Lean Move

I added:

```text
FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
```

This audit carries:

```text
structured SHE bundle
insulated cusp/zero local-object route
packet-local-object estimate
packet estimate object equality
cusp-class local object = packet local object
zero local object = packet local object
```

and exposes conversions:

```text
.toInsulatedCuspZeroPacketBridgeAudit
.toHodgeDescentInsulatedCuspZeroBridgeAudit
```

with theorems for:

```text
history separation
low-level bridge source = hodgeTheaterDescentPacketTransport
high-level comparison source = hodgeTheaterDescentIndeterminacy
zero local object = cusp-class local object
```

### Mathematical Reason

The packet-local-object identifications are the exact place where the insulated
route turns into the comparison route.  Before this step, those identifications
were only the fields of a generic insulated packet bridge.  Now there is a
separate Hodge-descent transport audit that carries the structured SHE bundle
next to those identifications.

This better matches the intended pressure point:

```text
structured SHE/HDD history discipline
  + packet-local-object transport identifications
  -> Hodge-descent packet bridge
  -> zero/nonzero local-object comparison
```

### Trap Avoided

This still does not prove that Mochizuki's Hodge-theater machinery supplies the
transport identifications.  The identifications remain assumptions of the
transport audit.  The gain is that a later proof must now target this audit
directly; it cannot hide the crucial identifications inside an unlabelled packet
bridge.

This is also useful against the Scholze-Stix simplification risk: if a future
route derives this audit by identifying all copies of the real line or all local
objects by identity, the formal source of the collapse will be visible in the
constructor used to populate the audit.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_hodge_transport_to_bridge_example
placeAudited_logVolume_fl_zmod_hodge_transport_bridge_source_example
placeAudited_logVolume_fl_zmod_hodge_transport_comparison_source_example
placeAudited_logVolume_fl_zmod_hodge_transport_zero_to_cusp_example
```

### Remaining Gap

The next mathematical task is to replace the transport audit's equality fields
with more structured local Hodge-theater data where possible.  In particular,
we need to identify which source-side objects correspond to the 0-column/SHE
input and which correspond to the local packet object after descent.

## 134. Structured Local Hodge-Descent Transport Data

### Lean Move

I added:

```text
IUTStage1HodgeDescentLocalObjectTransportData
FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit
```

The local transport datum records, for one audited packet:

```text
hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint
domain/codomain histories are not identified
zero object transports to packet object
each cusp-class object transports to packet object
```

The structured packet transport audit then stores one such local transport
datum for every audited packet choice, and derives:

```text
FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
zero local object = cusp-class local object
```

### Mathematical Reason

This is a small but important move from raw equality fields toward source-shaped
local data.  The zero/cusp-to-packet identifications are now consequences of
per-place Hodge-descent local transport data that explicitly mentions the
fourth-triangle HDD-after-SHE checkpoint and the history-separation guard.

This matches Mochizuki's 2026 formalization note more closely than the previous
interface: the relevant final stage is organized around the 0-column, the
descent/HDD/SHE composite, and the indeterminacy profile.  We are not yet
formalizing the internal Hodge-theater construction, but the local transport
obligation now has the right shape to be attacked later.

### Trap Avoided

The formalization no longer presents the zero/cusp-to-packet equations as an
unexplained packet bridge in the structured route.  To use the structured route,
a proof must provide local transport data at each audited packet.

This still does not settle the dispute.  It only isolates the disputed
mathematical burden more sharply: either the IUT machinery supplies these local
transport data without collapsing the histories, or the formalization will get
stuck exactly here.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_structured_hodge_transport_to_transport_example
placeAudited_logVolume_fl_zmod_structured_hodge_transport_checkpoint_example
placeAudited_logVolume_fl_zmod_structured_hodge_transport_source_example
placeAudited_logVolume_fl_zmod_structured_hodge_transport_zero_to_cusp_example
```

### Remaining Gap

The next target is to connect the local transport datum to existing
source-side local objects more concretely: which object is the 0-column/SHE
input object, which object is the descended packet object, and what local
operation transports one to the other.

## 135. Local Descent-Operation Records for Hodge Transport

### Lean Move

I added:

```text
IUTStage1HodgeDescentLocalObjectOperationData
IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit
```

The single-operation record names:

```text
source local object
packet-side target local object
descent operation identifier
descent = hodgeData.descent
fourth-triangle checkpoint
history-separation guard
source object transports to packet object
```

The cusp/zero operation family contains one zero operation and one operation
for every nonzero cusp sign-label class.  It derives the previous local
transport datum.

### Mathematical Reason

This connects the local transport equations to the descent operation already
stored in `IUTStage1HodgeTheaterDescentBridgeData`.  The formal object now says
more than "these objects are equal": it says the equality is being supplied by
a local operation whose descent identifier is the same descent identifier used
in the structured SHE/HDD bridge data.

This is closer to the intended final target in the IUT formalization note: the
0-column/SHE input is moved through the descent/HDD/SHE route before entering
the Corollary 3.12 comparison.

### Trap Avoided

The descent operation is not allowed to be an unrelated label.  The Lean field

```text
descent_eq_hodgeData : descent = hodgeData.descent
```

forces the local operation to use the same descent recorded in the Hodge bridge
data extracted from structured SHE inputs.

This still does not build the analytic/arithmetic Hodge-theater operation.  It
only gives that future construction a sharper target: produce these local
operation records for zero and nonzero cusp-class objects.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_operated_hodge_transport_to_structured_example
placeAudited_logVolume_fl_zmod_operated_hodge_transport_zero_descent_example
placeAudited_logVolume_fl_zmod_operated_hodge_transport_cusp_descent_example
placeAudited_logVolume_fl_zmod_operated_hodge_transport_source_example
```

### Remaining Gap

The next step is to distinguish the source object roles more explicitly: the
zero object should be marked as coming from the 0-column/SHE side, while
nonzero cusp-class objects should be marked as the local Hodge-Arakelov
evaluation/cusp-class side.  That distinction matters because collapsing those
roles too early would recreate the simplified Scholze-Stix route.
