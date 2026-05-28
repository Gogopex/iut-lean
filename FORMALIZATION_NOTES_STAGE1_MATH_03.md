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
