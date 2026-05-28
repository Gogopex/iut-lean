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

## 136. Role-Marked Hodge-Descent Local Operations

### Lean Move

I added:

```text
IUTStage1HodgeDescentLocalObjectRole
IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit
```

The roles are:

```text
zeroColumnSHEInput
cuspClassHodgeArakelovEvaluation
packetDescentTarget
```

The role-marked packet transport audit derives the operated transport audit,
but it additionally checks that:

```text
zero operation source role = zeroColumnSHEInput
cusp-class operation source role = cuspClassHodgeArakelovEvaluation
all operation target roles = packetDescentTarget
```

### Mathematical Reason

This records a distinction that matters directly for the Corollary 3.12
dispute.  The zero-column/SHE input object and the nonzero cusp-class
Hodge-Arakelov evaluation objects may later transport to the same packet-side
target object, but the formalization now remembers that they entered the
transport route with different roles.

That prevents the local Hodge-descent interface from saying merely "two things
are equal".  It says which side of the intended construction each thing belongs
to before the transport is applied.

### Trap Avoided

A simplified route can still be formalized separately, but it cannot populate
this role-marked route without naming the zero-column/SHE role, the cusp-class
evaluation role, and the packet descent target role.  This is the anti-collapse
discipline we need before attempting the genuinely hard Hodge-theater
construction.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_role_marked_hodge_transport_to_operated_example
placeAudited_logVolume_fl_zmod_role_marked_zero_source_role_example
placeAudited_logVolume_fl_zmod_role_marked_cusp_source_role_example
placeAudited_logVolume_fl_zmod_role_marked_zero_target_role_example
```

### Remaining Gap

The roles are still bookkeeping.  The next mathematical target is to attach the
zero-column/SHE role and cusp-class evaluation role to more source-specific
objects from the original IUT III construction, especially the 0-column and the
Hodge-Arakelov label/cusp data.

## 137. Source-Marked Hodge-Descent Local Objects

### Lean Move

I added:

```text
IUTStage1ZeroColumnSHELocalObjectData
IUTStage1CuspClassHodgeArakelovLocalObjectData
IUTStage1PacketDescentTargetLocalObjectData
IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit
```

The source-marked operation family records:

```text
zero source object: 0-column/SHE local object data
cusp-class source object: Hodge-Arakelov local object data for each sign class
packet target object: descent target local object data
zero/cusp operations: local Hodge-descent operations into the packet target
```

It derives the role-marked operation family, so the source-specific layer feeds
the previous role discipline rather than bypassing it.

### Mathematical Reason

This is the first layer that explicitly names the source-side mathematical
roles from the papers:

```text
0-column / SHE input
Hodge-Arakelov label/cusp evaluation
packet-side descent target
```

IUT III emphasizes the distinct labels in `F_l` and their Hodge-Arakelov
evaluation context, while Mochizuki's formalization note emphasizes the
0-column and the descent/HDD/SHE route.  The new structures keep those two
sources separate until a local descent operation transports them to the packet
target.

### Trap Avoided

Previously, the role-marked layer remembered that zero and cusp-class objects
had different roles, but not what source data justified those roles.  Now a
formal proof must supply source objects for the 0-column/SHE side and for each
Hodge-Arakelov cusp-class side.

This still does not prove that these objects exist in the full IUT
construction.  It identifies a sharper local obligation for the next pass.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_source_marked_hodge_transport_to_role_marked_example
placeAudited_logVolume_fl_zmod_source_marked_zero_checkpoint_example
placeAudited_logVolume_fl_zmod_source_marked_cusp_checkpoint_example
placeAudited_logVolume_fl_zmod_source_marked_packet_descent_example
```

### Remaining Gap

The source-marked objects are still abstract.  Next we should connect the
Hodge-Arakelov cusp-class source objects to the existing `ZMod l` sign-label
model and the local lab/cusp data already formalized in `InitialThetaData`.

## 138. ZMod Label Provenance for Hodge-Arakelov Cusp Sources

### Lean Move

I added:

```text
IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit
```

The cusp-class source object now carries:

```text
source Hodge-Arakelov local object data
canonical ZMod cusp-label model
coordinate : ZMod l.value
coordinate_ne_zero : coordinate ≠ 0
label = zmodSignLabelFromCoordinate l coordinate coordinate_ne_zero
```

The packet transport audit with `ZMod` source data derives the previous
source-marked audit.

### Mathematical Reason

IUT III repeatedly emphasizes the distinct `F_l` labels and the
Hodge-Arakelov-theoretic evaluation attached to those labels.  Our previous
source-marked layer named the cusp-class role, but did not yet require an
explicit nonzero `F_l`/`ZMod l` coordinate for the cusp-class label.

The new layer forces that coordinate to be present.  Since the cusp-class label
lives in the sign quotient of nonzero labels, the nonzero proof is also part of
the data.

### Trap Avoided

This prevents a cusp-class source object from being an anonymous sign-label
class disconnected from the `ZMod l` model.  A future proof must now state which
nonzero label coordinate represents the cusp-class source, modulo sign.

That is relevant to the Scholze-Stix pressure point: if the label data is
discarded too early, the comparison can collapse into a constant or identity
route.  This layer keeps the label coordinate visible all the way into the
Hodge-descent transport obligation.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_zmod_source_marked_to_source_marked_example
placeAudited_logVolume_fl_zmod_zmod_source_marked_label_coordinate_example
placeAudited_logVolume_fl_zmod_zmod_source_marked_coordinate_ne_zero_example
placeAudited_logVolume_fl_zmod_zmod_source_marked_zero_to_cusp_example
```

### Remaining Gap

The `ZMod` coordinate is now explicit, but it is still supplied as data for each
sign-label class.  The next step should expose canonical and sign-invariant
special cases: in particular, the canonical class represented by `1`, and the
fact that `-j` represents the same sign-label source as `j`.

## 139. Sign-Normalized ZMod Cusp Source Labels

### Lean Move

I added sign-normalization lemmas for the `ZMod` cusp source layer:

```text
IUTStage1ZModCuspClassHodgeArakelovLocalObjectData.label_eq_negCoordinate
IUTStage1ZModCuspClassHodgeArakelovLocalObjectData.label_eq_canonical_of_coordinate_eq_one
IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData.cuspClassLabel_eq_negCoordinate
IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData.cuspClassLabel_eq_canonical_of_coordinate_eq_one
FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit.cuspClassLabel_eq_negCoordinate
FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit.cuspClassLabel_eq_canonical_of_coordinate_eq_one
```

and corresponding example endpoints:

```text
placeAudited_logVolume_fl_zmod_zmod_source_marked_label_neg_coordinate_example
placeAudited_logVolume_fl_zmod_zmod_source_marked_label_canonical_example
```

### Mathematical Reason

The nonzero cusp-label classes are not raw `ZMod l` coordinates.  They are
coordinates modulo the sign action.  This is why a label represented by `j` must
also be represented by `-j`, and why the coordinate `1` recovers the canonical
sign-label quotient.

This is a small but important correction in the formal interface: it makes the
source-marked Hodge-Arakelov cusp data remember the concrete `F_l` coordinate
while still respecting the quotient relation that the papers use for
cusp-label classes.

### Relevance to the 3.12 Dispute

The disputed step is sensitive to when label/cusp structure is preserved and
when it is collapsed into an undifferentiated comparison.  These lemmas do not
prove Corollary 3.12.  They make one local invariant explicit: quotienting by
sign is allowed, but losing the nonzero `ZMod` source data entirely is not part
of this route.

This gives the later Hodge-theater/descent bridge a precise local object to
transport, instead of only an anonymous endpoint equality.

## 140. Explicit Zero/Nonzero Full Cusp Labels

### Lean Move

I added an explicit full-label type for the concrete `F_l = ZMod l` cusp-label
interface:

```text
IUTStage1ZModCuspFullLabel.zero
IUTStage1ZModCuspFullLabel.nonzero label
IUTStage1ZModCuspFullLabel.fromCoordinate
IUTStage1ZModCuspFullLabel.localObject
```

The new API proves:

```text
fromCoordinate 0 = zero
fromCoordinate 1 = nonzero canonicalSignLabel
fromCoordinate (-j) = fromCoordinate j, for j != 0
localObject zero/cusp (fromCoordinate 0) = zeroObject
localObject zero/cusp (fromCoordinate j) = cuspClassObject (label of j), for j != 0
```

I also connected the existing insulated cusp/zero route to this full-label API:

```text
FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit.fullLabelLocalObject
...fullLabelLocalObject_zero
...fullLabelLocalObject_nonzero
...labelLocalObject_eq_fullLabelLocalObject_fromCoordinate
...fullLabelLocalObject_fromCoordinate_neg_eq
```

and added examples:

```text
placeAudited_logVolume_fl_zmod_insulated_full_label_zero_example
placeAudited_logVolume_fl_zmod_insulated_full_label_nonzero_example
placeAudited_logVolume_fl_zmod_insulated_label_object_full_label_example
placeAudited_logVolume_fl_zmod_insulated_full_label_neg_example
```

### Mathematical Reason

The papers distinguish two related symmetries.  IUT I, Remark 6.12.5 says the
`F_l^±` symmetry includes the zero element and can relate zero-labeled and
nonzero-labeled prime strips, but also warns that this makes it harder to
insulate nonzero labels from confusion with the zero label.  IUT II, Remark
4.7.3 says the `F_l^±` symmetry involves the zero label and has a coric role,
while the `F_l` symmetry separates zero from nonzero labels and is important for
Gaussian monoids and weighted-volume computations.

The previous Lean route already branched internally on `j = 0`, but the branch
type was implicit.  The new full-label type makes the branch explicit:

```text
zero coordinate        -> zero constructor
nonzero coordinate     -> nonzero sign-label quotient constructor
```

This is a better local model of the paper distinction.  It lets us write
functions over all `ZMod l` labels without pretending that zero belongs to the
nonzero sign-label quotient.

### Relevance to the 3.12 Dispute

Scholze-Stix argue that, after simplification, the Corollary 3.12 route loses
the intended nontrivial weighted comparison and collapses toward a trivial
inequality.  The formalization should therefore expose exactly where zero and
nonzero labels are related and exactly where they remain separate.

This milestone does not prove the disputed step.  It narrows the formal
language around it: a zero/nonzero comparison must either be a case split over
`IUTStage1ZModCuspFullLabel`, or must pass through an explicit bridge such as
the Hodge-descent packet transport.  It cannot silently reinterpret zero as a
nonzero cusp sign-label class.

### Remaining Gap

The full-label object selector is still local to the insulated cusp/zero route.
The next step should propagate this explicit full-label interface into the
Hodge-descent source-marked transport audit, so that the packet transport can
state in one theorem how the zero constructor and each nonzero cusp constructor
are transported to the packet object.

## 141. Full-Label Transport Through Hodge Descent

### Lean Move

I propagated the explicit full-label interface into the `ZMod` source-marked
Hodge-descent transport layer.

At the local operation level:

```text
IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData.fullLabelLocalObject
...fullLabelLocalObject_zero
...fullLabelLocalObject_nonzero
...fullLabelLocalObject_transports_to_packet
...fullLabelLocalObject_fromCoordinate_zero
...fullLabelLocalObject_fromCoordinate_nonzero
```

At the packet transport audit level:

```text
FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit.fullLabelLocalObject
...fullLabelLocalObject_zero
...fullLabelLocalObject_nonzero
...fullLabelLocalObject_transports_to_packet
...fullLabelLocalObject_fromCoordinate_zero
...fullLabelLocalObject_fromCoordinate_nonzero
```

The examples now include:

```text
placeAudited_logVolume_fl_zmod_zmod_source_marked_full_label_transport_example
placeAudited_logVolume_fl_zmod_zmod_source_marked_full_label_zero_example
placeAudited_logVolume_fl_zmod_zmod_source_marked_full_label_nonzero_example
```

### Mathematical Reason

The previous milestone made the zero/nonzero label split explicit, but only at
the insulated local-object route.  The present move carries that split through
the source-marked Hodge-descent packet transport.

The main theorem is now a single statement over the full-label type:

```text
fullLabelLocalObject label = packetLocalObject
```

where `label` may be the zero constructor or a nonzero sign-label class.  Lean
proves this by cases:

```text
zero             -> zeroOperation transports to packet
nonzero label    -> cuspClassOperation label transports to packet
```

Thus the zero/nonzero comparison is no longer hidden inside two unrelated
projection lemmas.  It is expressed as one case split over the formal label type.

### Relevance to the 3.12 Dispute

This is exactly the kind of bookkeeping the Scholze-Stix criticism asks not to
skip: if the comparison becomes trivial, Lean should show which explicit bridge
made zero and nonzero local objects land on the same packet object.

On the Mochizuki side, this keeps the bridge attached to the Hodge-descent
source data and to the fourth-triangle HDD/SHE checkpoint.  On the skeptical
side, it prevents the proof from silently using equality of endpoints without
naming the zero branch, the nonzero branch, and the descent operation that
transports each branch.

### Remaining Gap

The theorem still says that every full label transports to the same packet local
object once the source-marked Hodge-descent data is supplied.  The next
mathematical pressure point is to connect this transport theorem to the weighted
volume side: zero should remain the separate coric branch, while nonzero labels
contribute through the `1/l`-weighted `ZMod` average.

## 142. Full-Label Log-Volume Evaluation

### Lean Move

I added a full-label log-volume selector to the existing zero/nonzero
compatibility record:

```text
IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelLogVolume
```

It evaluates by cases:

```text
zero             -> zeroLogVolume
nonzero label    -> cuspClassLogVolume label
```

The key theorem is:

```text
normalizedLogVolume j =
  fullLabelLogVolume (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
```

with branch lemmas for `j = 0`, `j != 0`, and `-j`.

I then lifted this to the averaged `(Ind1)/(Ind2)` audit:

```text
FLZModCuspLabelCompatibleAveragedInd12Audit
  .averageLabel_eq_fullLabelLogVolume_fromCoordinate
  .averageFullLabelLogVolume_fromCoordinate_zero
  .averageFullLabelLogVolume_fromCoordinate_nonzero
```

The examples now check:

```text
zmodCuspLabelLogVolumeCompatibility_full_label_example
zmodCuspLabelLogVolumeCompatibility_full_label_zero_example
zmodCuspLabelLogVolumeCompatibility_full_label_nonzero_example
placeAudited_logVolume_fl_zmod_cusp_compatible_full_label_example
placeAudited_logVolume_fl_zmod_cusp_compatible_full_label_zero_example
placeAudited_logVolume_fl_zmod_cusp_compatible_full_label_nonzero_example
```

### Mathematical Reason

IUT III describes procession-normalized mono-analytic log-volumes as averages
over `j ∈ F_l`, and IUT II stresses that the `F_l` symmetry separates the zero
label from the nonzero labels when computing weighted volumes for Gaussian
monoids.

The new theorem says that the coordinate-indexed function used in the finite
average factors through the explicit full-label split:

```text
ZMod coordinate j
  -> full label: zero or nonzero sign class
  -> zero/cusp log-volume branch
```

Thus the average still ranges over all `ZMod l` coordinates, but the semantic
interpretation of each summand remembers whether it is the zero branch or a
nonzero cusp-sign class.

### Relevance to the 3.12 Dispute

Scholze-Stix emphasize that the Corollary 3.12 step is about comparing real
numbers after averaging over the concrete theta/q pilot data, and they argue
that the `j²` scaling disappears under consistent identifications.  This
milestone does not introduce or resolve the `j²` weights.  It prepares the Lean
interface where that issue must be stated: every averaged summand now has a
formal full-label provenance.

This prevents an argument from replacing the average over `j ∈ F_l` by an
anonymous real-line family without recording whether the summand came from the
zero/coric branch or a nonzero cusp branch.

### Remaining Gap

The average is still the uniform finite average already present in
`IUTStage1LabelAveragedProcessionLogVolume`.  The next step should introduce a
separate weighted-log-volume structure for the Gaussian-monoid-style `j²`
weights, so that the Scholze-Stix "missing `j²`" objection can be represented as
a precise Lean comparison between the unweighted `F_l` average and the weighted
Gaussian-monoid average.

## 143. Square-Weighted Label Averages

### Lean Move

I introduced a second finite-average structure:

```text
IUTStage1WeightedLabelAveragedProcessionLogVolume
```

It records:

```text
normalizedLogVolume : label -> Real
weight              : label -> Real
weightTotal         : Real
0 < weightTotal
weightTotal = sum weight
weightedAverageLogVolume =
  (sum (weight j * normalizedLogVolume j)) / weightTotal
```

This is deliberately separate from:

```text
IUTStage1LabelAveragedProcessionLogVolume
```

which remains the uniform finite average over the label set.

The generic weighted lemmas are:

```text
IUTStage1WeightedLabelAveragedProcessionLogVolume.weightedAverage_eq_formula
IUTStage1WeightedLabelAveragedProcessionLogVolume.weightedAverage_eq_of_pointwise
IUTStage1WeightedLabelAveragedProcessionLogVolume.const_le_weightedAverage_of_forall_le
```

I also added:

```text
IUTStage1LabelAveragedProcessionLogVolume.toWeighted
```

This converts a uniform-average data record into a weighted-average record using
the same normalized summands and an explicitly supplied weight profile.  It does
not assert that the uniform and weighted averages are equal.

For the concrete `F_l = ZMod l.value` model, I added:

```text
IUTStage1ZModSquareWeightProfile
```

with fields proving:

```text
weight j = ((j.val : Real) ^ 2)
0 <= weight j
0 < weightTotal
weightTotal = sum weight
```

The constructor:

```text
IUTStage1ZModSquareWeightProfile.fromSquareWeights
```

uses the square formula and nonnegativity directly, while keeping strict
positivity of the total as an explicit input.  This is intentional: a later
milestone should prove positivity from a named nonzero coordinate or from the
Gaussian-monoid source construction, rather than hide it in arithmetic
automation.

The example file now checks that a square-weight profile can be attached to a
uniform `ZMod l` average and that the resulting weighted record really has
weight `j^2` at coordinate `j`.

### Mathematical Reason

IUT III, in the Corollary 3.12 discussion, uses a procession-normalized average
over `j ∈ F_l`.  That is the uniform average already represented by
`IUTStage1LabelAveragedProcessionLogVolume`.

Scholze-Stix's criticism focuses on the claim that the relevant Theta-side
quantities carry `j^2` scaling, and that this scaling disappears once all real
line identifications are made consistently.  The Lean code therefore needs two
different objects:

```text
uniform F_l average
weighted square-profile average
```

and it must not smuggle equality between them into a definition.  This milestone
creates exactly that separation.

### Relevance to the 3.12 Dispute

We can now state future obligations in a sharper form:

```text
Given the same coordinate-indexed normalized log-volume values,
compare the uniform F_l average with the j^2-weighted average.
```

If the Mochizuki route requires the square weights to survive Hodge-theater
transport, then a later theorem must produce compatible square-weight data after
transport.  If the Scholze-Stix simplification is formalized, it should amount
to showing that the available identifications force a collapse in which this
extra weighted structure cannot be recovered from the common real-line data.

This milestone still does not decide that question.  It merely prevents the
formalization from confusing:

```text
average over labels
```

with:

```text
average over labels using the j^2 Gaussian-monoid weight profile.
```

### Remaining Gap

The square-weight profile is attached to `ZMod l` coordinates via `j.val`.
The next mathematical refinement should connect this weighted layer to the
full-label zero/nonzero split from the previous milestone and then ask whether
Hodge-theater transport preserves, erases, or reconstructs this square-weight
profile.  That is much closer to the actual Corollary 3.12 pressure point than
the previous infrastructure work.

## 144. Square-Weighted Full-Label Summands

### Lean Move

I connected the square-weight profile from Milestone 143 to the full-label
zero/nonzero decomposition from Milestone 142.

At the generic `ZMod l` profile level, the new theorems are:

```text
IUTStage1ZModSquareWeightProfile
  .toWeighted_normalizedLogVolume_eq_fullLabelLogVolume
  .toWeighted_weightedSummand_eq_square_fullLabelLogVolume
  .toWeighted_weightedAverage_eq_square_fullLabelLogVolume_sum
```

These say: if a uniform `ZMod l` averaged log-volume record is compatible with a
zero/nonzero cusp-label log-volume record, then the square-weighted version has
summands of the form

```text
((j.val : Real) ^ 2) *
  fullLabelLogVolume (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
```

and its weighted average is the finite sum of these summands divided by the
explicit square-weight total.

At the audited endpoint level, the new declarations are:

```text
FLZModCuspLabelCompatibleAveragedInd12Audit
  .squareWeightedAveragedLogVolume
  .squareWeighted_normalizedLogVolume_eq_fullLabelLogVolume
  .squareWeighted_weight_eq_square_val
  .squareWeighted_summand_eq_square_fullLabelLogVolume
  .squareWeightedAverage_eq_square_fullLabelLogVolume_sum
```

The example module now checks the same three public-facing facts: the normalized
summand still factors through the full-label branch, the weight at `j` is
`j^2`, and the whole weighted average is the finite `j^2 * fullLabel` sum.

### Mathematical Reason

The preceding milestone only created a square-weighted average.  That was not
yet close enough to the Corollary 3.12 pressure point, because it did not say
what was being weighted.

This milestone states that the thing being weighted is precisely the
coordinate-indexed log-volume after it has been interpreted through the
zero/nonzero full-label split:

```text
coordinate j
  -> full label fromCoordinate j
  -> full-label log-volume branch
  -> multiplied by j^2
```

This is a useful formal boundary because it prevents two opposite mistakes:

* treating the square weights as attached to anonymous real numbers with no
  label provenance;
* treating the full-label factorization as if it already solved the
  square-weight comparison.

### Source Check

IUT III, Corollary 3.12 and its proof discussion use averages over
`j ∈ F_l`; the local extract around lines 9899 and 9910 is the source for our
uniform `ZMod l` average interface.

IUT II discusses weighted volume computations and the `F_l` symmetry, including
the warning that zero and nonzero labels cannot simply be symmetrized away in
weighted-volume computations; the local extract around lines 9198--9208 is the
source for keeping the zero/nonzero full-label split visible.

Scholze-Stix, in their discussion of IUT III Corollary 3.12, describe the
critical comparison using `j`-indexed theta-pilot data and averages; the local
extract around lines 624--625 and the surrounding discussion are the source for
making the `j^2` weighting an explicit formal object rather than a hidden
interpretation.

### Relevance to the 3.12 Dispute

The formalization can now state the disputed local shape as a Lean-normalized
formula:

```text
weighted Theta-side average =
  sum_j (j^2 * full-label-log-volume(j)) / square-weight-total
```

This is still not a proof of Corollary 3.12.  It is a sharper target for the next
stage: an actual Hodge-theater/log-link transport theorem would have to account
for both pieces of structure at once:

```text
full-label provenance
square-weight provenance
```

If these pieces survive transport, the Lean proof must exhibit the transport.
If they collapse under consistent real-line identifications, the Lean proof
should expose that collapse by failing to reconstruct this weighted full-label
summand data from the common comparison object.

### Remaining Gap

We have not yet formalized the transport behavior of square-weight profiles.
The current theorem is local to the `ZMod l` coordinate model and to the audited
full-label compatibility.  The next milestone should introduce an explicit
"square-weight provenance under transport" audit: either a preservation record,
or a deliberately weaker record showing exactly which data are unavailable after
Hodge-theater erasure.

## 145. Square-Weighted Full-Label Transport Preservation Audit

### Lean Move

I added an explicit preservation audit:

```text
IUTStage1ZModSquareWeightedFullLabelTransportAudit
```

It contains:

```text
bridge              : IUTStage1HodgeTheaterDescentBridgeData
coordinateEquiv     : ZMod l.value ≃ ZMod l.value
sourceProfile       : IUTStage1ZModSquareWeightProfile l
targetProfile       : IUTStage1ZModSquareWeightProfile l
sourceLogVolume     : IUTStage1ZModCuspLabelLogVolumeCompatibility l
targetLogVolume     : IUTStage1ZModCuspLabelLogVolumeCompatibility l
```

and three preservation obligations:

```text
target full-label log-volume at coordinateEquiv j
  = source full-label log-volume at j

target square weight at coordinateEquiv j
  = source square weight at j

target weight total
  = source weight total
```

From these fields Lean proves:

```text
targetTransportedSummand_eq_sourceSummand
targetTransportedNumerator_eq_sourceNumerator
targetTransportedAverage_eq_sourceAverage
histories_not_identified
```

The example file checks the transported summand, numerator, average, and
history-separation projections.

### Mathematical Reason

The previous milestone wrote down the local formula

```text
sum_j (j^2 * fullLabelLogVolume(j)) / squareWeightTotal
```

but did not say what it would mean for this formula to survive a Hodge-theater
or log-link transition.  This milestone gives a precise preservation boundary:
to transport the square-weighted full-label expression, one must supply an
equivalence of coordinates and prove that both pieces of data are preserved
along it:

```text
full-label log-volume branch
square-weight branch
```

The bridge field keeps the Hodge-theater/descent context attached to this
preservation claim, including the already established guard that the histories
are not identified.

### Source Check

This matches the project reading of the disputed Corollary 3.12 passage:

* IUT III treats the final comparison as a simultaneous comparison at the
  `3.11.5 => 3.12` boundary, with averages over `j ∈ F_l`.
* IUT II and IUT III discuss weighted log-volume/measure calculations in which
  weights are part of the computation rather than decorative metadata.
* Scholze-Stix's critique presses precisely on whether the `j^2` information
  can remain meaningful after the relevant real-line identifications.

The Lean move is intentionally neutral.  It does not assert that the audit can
be supplied from Mochizuki's construction, and it does not assert that
Scholze-Stix's collapse is correct.  It says what preservation would have to
mean as a typechecked statement.

### Relevance to the 3.12 Dispute

This is the first formal object in the project that can express:

```text
the j^2-weighted full-label expression survived transport
```

as an auditable Lean hypothesis.  That is useful because the next stage can now
branch cleanly:

* Try to construct this preservation audit from the Hodge-theater/descent data.
* Try to formalize an erasure/collapse result showing that the available common
  real-line object is insufficient to reconstruct this audit.

Either route must now interact with the same typed object.  This reduces the
risk of arguing past the dispute by proving a theorem about uniform averages
while intending a theorem about square-weighted Gaussian-monoid averages.

### Remaining Gap

The preservation audit currently assumes the coordinate equivalence and the
three preservation fields.  The next mathematical work is to relate this audit
to the existing structured-SHE/common-container route: which data in that route
could supply the coordinate equivalence, and which data could supply or refute
the two preservation equalities?

## 146. Square-Weighted `(Ind1)/(Ind2)` Invariance

### Lean Move

I extended the existing `(Ind1)/(Ind2)` averaged-log-volume invariance to the
square-weighted `ZMod l` average:

```text
FLZModCuspLabelCompatibleAveragedInd12Audit
  .ind1SquareWeightedAverageLogVolumeEq
  .ind2SquareWeightedAverageLogVolumeEq
```

The proof reuses the generic weighted-average theorem:

```text
IUTStage1WeightedLabelAveragedProcessionLogVolume.weightedAverage_eq_of_pointwise
```

with:

```text
same square-weight profile
same weight total
existing labelwise equality from Ind1 or Ind2
```

The example module now exposes both invariance theorems.

### Mathematical Reason

The existing audit already says that `(Ind1)` and `(Ind2)` preserve the
coordinate-indexed normalized log-volume values label by label.  A weighted
average is still a finite expression in those labelwise values.  Therefore,
when the weight profile is held fixed, the weighted average is invariant under
the same labelwise equality.

This is a modest but important check: the square-weighted layer is not floating
outside the existing indeterminacy bookkeeping.  It behaves functorially with
respect to the already formalized labelwise `(Ind1)/(Ind2)` equalities.

### Relevance to the 3.12 Dispute

This does not show that the `j^2` profile survives a Hodge-theater/log-link
transition.  It only shows:

```text
if the same square-weight profile is available on both sides,
then Ind1/Ind2 labelwise invariance preserves the square-weighted average.
```

That distinction matters.  Scholze-Stix's objection is not that finite weighted
sums fail algebraically once the weights are fixed; it is about whether the
identifications in the Corollary 3.12 passage leave room for the relevant
`j^2` structure.  This milestone keeps the algebraic finite-average fact
separate from the harder provenance question formalized in Milestone 145.

### Remaining Gap

The next step should stop treating the square-weight profile as "the same
profile by hypothesis" and ask whether the structured-SHE/Hodge-theater route
actually supplies the preservation audit from Milestone 145.

## 147. Structured-SHE Square-Weight Transport Wrapper

### Lean Move

I added a route-level wrapper:

```text
IUTStage1StructuredSHESquareWeightTransportAudit
```

It contains a square-weighted full-label transport audit:

```text
preservation_audit :
  IUTStage1ZModSquareWeightedFullLabelTransportAudit l
```

and a bridge compatibility field:

```text
preservation_audit.bridge =
  bundle.hodgeTheaterDescentBridgeData
```

where `bundle` is an

```text
IUTStage1Theorem311StructuredInputsWithSHE package
```

The wrapper proves projections:

```text
bridge_domainTheater_eq
bridge_codomainTheater_eq
bridge_descent_eq
targetTransportedSummand_eq_sourceSummand
targetTransportedAverage_eq_sourceAverage
histories_not_identified
structuredSHE_histories_not_identified
```

The example file exposes the bridge equality, the HDD descent equality, and the
transported weighted-average equality.

### Mathematical Reason

Milestone 145 introduced a preservation audit for the expression

```text
sum_j (j^2 * fullLabelLogVolume(j)) / squareWeightTotal
```

but that audit still contained an arbitrary
`IUTStage1HodgeTheaterDescentBridgeData`.  This was too loose for the
Corollary 3.12 route, because a preservation claim must be attached to the same
Hodge-theater/SHE/HDD bridge that occurs in the structured Theorem 3.11 input.

The new wrapper closes that gap.  It does not create the preservation proof.  It
says that if such a proof is claimed in the structured-SHE route, then its
bridge must literally be:

```text
bundle.hodgeTheaterDescentBridgeData
```

This ties the square-weight provenance question to the existing Theorem 3.11
route rather than to an independent bookkeeping object.

### Source Check

The April 2026 formalization report describes the final `3.11.5 => 3.12`
portion as concentrating on the simultaneous comparison aspect of Corollary
3.12 after moving the `hull+det` material earlier.  Our structured-SHE bundle is
the current Lean placeholder for that route-level comparison context.

IUT III's proof of Corollary 3.12 uses the structured Hodge-theater and
log-volume machinery leading to averages over `j ∈ F_l`.  Scholze-Stix's
critique asks whether the relevant `j^2` information can remain meaningful
after the identifications used in this passage.  The wrapper is therefore a
formal way of asking the same question at the route boundary:

```text
does the structured-SHE bridge supply the square-weight/full-label
preservation audit?
```

### Relevance to the 3.12 Dispute

This milestone narrows the dispute surface.  A future proof cannot satisfy the
square-weight preservation requirement by producing a preservation audit over a
different bridge.  It must use the bridge extracted from the structured-SHE
bundle, whose domain/codomain Hodge-theater histories remain explicitly
non-identified.

This is still neutral.  If Mochizuki's explanation is formalizable, the next
work should construct this wrapper from actual Hodge-theater/log-link data.  If
Scholze-Stix's simplification exposes a collapse, it should appear as the
failure to produce the preservation fields for this very wrapper.

### Remaining Gap

The wrapper still assumes the preservation audit.  The next milestone should
separate the available structured-SHE data from the missing square-weight data:
what is already supplied by `bundle.hodgeTheaterDescentBridgeData`, and what
extra equalities are still needed to construct the wrapper?

## 148. Structured-SHE Square-Weight Transport Obligations

### Lean Move

I added an explicit construction-obligation record:

```text
IUTStage1StructuredSHESquareWeightTransportObligations
```

It is parameterized by the same `package`, structured-SHE `bundle`, and prime
`l` as the wrapper from Milestone 147.  The important design choice is that this
record does not ask for a Hodge-theater bridge.  The bridge is supplied by:

```text
bundle.hodgeTheaterDescentBridgeData
```

The remaining fields are exactly the square-weight/full-label preservation data:

```text
coordinateEquiv
sourceProfile
targetProfile
sourceLogVolume
targetLogVolume
fullLabelLogVolume_preserved
squareWeight_preserved
weightTotal_preserved
```

From these obligations Lean constructs:

```text
toPreservationAudit :
  IUTStage1ZModSquareWeightedFullLabelTransportAudit l

toStructuredSHESquareWeightTransportAudit :
  IUTStage1StructuredSHESquareWeightTransportAudit package bundle l
```

and proves:

```text
toPreservationAudit.bridge = bundle.hodgeTheaterDescentBridgeData
target transported average = source average
transport bridge descent = the HDD descent in the package
```

The example module now checks these conversions.

### Mathematical Reason

Milestone 147 bound a preservation audit to the structured-SHE route.  This
milestone turns that into a checklist of what remains to be proved.

The structured-SHE bundle already supplies:

```text
domain Hodge theater
codomain Hodge theater
HDD descent operation
zero-column checkpoint
indeterminacy profile
history non-identification
```

The square-weight controversy is not in those inert route labels alone.  It is
in whether the route supplies the extra preservation data:

```text
coordinate equivalence
full-label log-volume preservation
j^2 square-weight preservation
weight-total preservation
```

This record makes that division explicit in Lean.

### Source Check

This follows the April 2026 formalization report's decomposition of the
Theorem 3.11 to Corollary 3.12 route: the final `3.11.5 => 3.12` portion is
supposed to isolate the simultaneous comparison.  Our code now isolates the
additional square-weight preservation obligations that such a simultaneous
comparison would need if it is to preserve the `j^2` data.

It also reflects the Scholze-Stix pressure point: merely having a common
comparison route or common real-line reading is not the same as having a
transported square-weight/full-label expression.

### Relevance to the 3.12 Dispute

The formalization now has three distinct layers:

```text
1. structured-SHE bridge data supplied by the route;
2. square-weight/full-label preservation obligations not yet supplied;
3. wrapper proving transported weighted-average equality once 1 and 2 are both present.
```

This is a useful place to pause for future mathematical scrutiny.  If one wants
to defend the IUT route, the next proof obligation is no longer vague: construct
the fields of `IUTStage1StructuredSHESquareWeightTransportObligations`.  If one
wants to formalize the Scholze-Stix criticism, the target is also sharper: show
that the structured-SHE/common real-line data do not determine those fields.

### Remaining Gap

The project still has not constructed the preservation equalities.  The next
milestone should inspect the existing local-object Hodge-descent packet audits
and ask whether any of them can supply the coordinate equivalence and the two
preservation equalities, or whether we need an explicit "erasure" record saying
that this information is absent after passage to the common container.

## 149. Local-Object Hodge Descent Square-Weight Gap

### Lean Move

We added an explicit boundary record:

```text
IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
```

It wraps the existing local-object Hodge descent transport data and exposes the
equalities that this layer really provides:

```text
zero local object = packet local object
cusp-class local object = packet local object
domain history is not identified with codomain history
```

We also added:

```text
IUTStage1SquareWeightTransportMissingDatum
```

This finite checklist records the square-weight transport data not supplied by
local-object packet descent alone:

```text
coordinate equivalence
source and target square-weight profiles
source and target full-label log-volume evaluators
full-label log-volume preservation
j^2 square-weight preservation
weight-total preservation
```

The structured FL/ZMod Hodge packet audit now projects to this boundary via:

```text
localObjectSquareWeightBoundary
```

and proves concrete gap lemmas such as:

```text
localObjectSquareWeightBoundary_coordinateEquiv_missing
localObjectSquareWeightBoundary_squareWeightPreservation_missing
localObjectSquareWeightBoundary_fullLabelPreservation_missing
```

The example file checks these projections on the place-audited log-volume
route.

### Mathematical Reason

This is the first negative/boundary milestone in the square-weight corridor.
It says that the local-object Hodge descent packet layer is not being silently
used as a proof of Corollary 3.12-style square-weight preservation.

The local-object layer can identify several local objects with a packet object.
That is useful for describing the Hodge-descent packet route.  But the debated
Corollary 3.12 issue concerns the weighted full-label expression indexed by
`j in F_l`, especially whether the `j^2` contribution survives the passage to
the comparison setting.  Local-object equality by itself does not provide a
coordinate equivalence on `ZMod l`, nor does it provide preservation of the
full-label log-volume evaluator or the total weighted average.

### Source Check

IUT II and IUT III repeatedly treat the `j in F_l` labels, Gaussian monoids,
and weighted volumes as structured data rather than as an arbitrary finite
average.  Corollary 3.12 in IUT III is precisely at the point where the
weighted average over `j` is asserted after the Theorem 3.11 comparison.

Scholze-Stix's critique focuses on this same passage: their Step (xi) pressure
point is that after simplifying to a common comparison object, the averaging
data appears to collapse rather than carry nontrivial independent `j`
information.  This Lean boundary does not decide that claim.  It records the
more modest fact that the current local-object Hodge descent fields are
insufficient to decide it.

### Relevance to the 3.12 Dispute

The current formal state is:

```text
local-object Hodge descent
  supplies packet-object equalities and history separation

square-weight transport obligations
  require coordinate/profile/log-volume/weight preservation data

therefore
  packet-object local descent is not enough to derive 3.12-weight preservation
```

This is useful for impartiality.  It blocks a false positive proof in which the
formalization accidentally treats object-level descent as preservation of the
weighted full-label expression.  It also gives a precise target for the next
mathematical step: either construct the missing fields from a stronger
Mochizuki-style Hodge-theater erasure/transport statement, or show that the
available route data cannot determine them.

## 150. Coordinate Square-Preservation for the `j^2` Profile

### Lean Move

We refined the square-weight transport branch by naming the coordinate condition
that makes the `j^2` profile transportable:

```text
IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
```

For a coordinate equivalence

```text
coordinateEquiv : ZMod l.value ≃ ZMod l.value
```

this condition says:

```text
((coordinateEquiv j).val : Real)^2 = (j.val : Real)^2
```

for every `j : ZMod l.value`.

The new checked lemmas are:

```text
coordinateSquarePreserving_refl
squareWeight_preserved_of_coordinateSquarePreserving
coordinateSquarePreserving_of_squareWeight_preserved
squareWeight_preserved_iff_coordinateSquarePreserving
weightTotal_preserved_of_squareWeight_preserved
weightTotal_preserved_of_coordinateSquarePreserving
```

The example file now checks that:

```text
identity coordinates preserve the square profile;
coordinate square-preservation gives pointwise square-weight preservation;
pointwise square-weight preservation is equivalent to coordinate square-preservation;
coordinate square-preservation also gives total-weight preservation.
```

### Mathematical Reason

This milestone makes the square-weight transport obligation less opaque.  Earlier
we had a field:

```text
targetProfile.weight (coordinateEquiv j) = sourceProfile.weight j
```

but the formalization did not yet say what this means for the canonical
`j.val^2` profile.  Since every `IUTStage1ZModSquareWeightProfile` is tied to
the real square of the chosen `ZMod l` representative, Lean can now prove that
pointwise weight preservation is exactly the same as preservation of those real
square coordinates.

This is a useful trap check: arbitrary relabeling of `F_l` is not automatically
legal in the square-weight branch.  A coordinate equivalence only transports the
`j^2` data if it preserves the real-valued square profile used by the current
Stage 1 model.

### Source Check

IUT II describes the relevant diagonal as weighted by the vector of `j^2`
values and connects this to weighted-volume computation.  IUT III then uses
averages over `j in F_l` in the Corollary 3.12 corridor.  The Scholze-Stix
critique focuses on whether the comparison step still contains the nontrivial
`j`/`j^2` information after passage to the simplified common comparison object.

The April 2026 formalization report isolates the final `3.11.5 => 3.12` stage
as the simultaneous comparison problem.  This milestone keeps that comparison
honest by requiring a concrete coordinate-square preservation statement before
the square-weight branch can be transported.

### Relevance to the 3.12 Dispute

The current square-weight branch now has the following dependency:

```text
coordinate-square preservation
  <=> pointwise j^2 square-weight preservation
  => total square-weight preservation
```

Thus the formalization has reduced two fields of
`IUTStage1StructuredSHESquareWeightTransportObligations` to a sharper question:
does the Hodge-theater/SHE route supply a coordinate equivalence that preserves
the relevant real square profile?

It still does not solve the full Corollary 3.12 passage, because the
full-label log-volume preservation field remains separate.  But it narrows the
weight side of the dispute: the next serious gap is no longer "preserve weights"
in the abstract, but "produce or justify a coordinate equivalence preserving the
specific `j.val^2` profile while also preserving the full-label log-volume
branch."

## 151. Reduced Structured-SHE Obligations via Coordinate Squares

### Lean Move

We added a reduced structured-SHE obligation record:

```text
IUTStage1StructuredSHECoordinateSquareWeightObligations
```

This record still asks for the data needed to enter the square-weighted
full-label transport corridor:

```text
coordinate equivalence
source and target square profiles
source and target full-label log-volume branches
full-label log-volume preservation
```

But instead of asking separately for:

```text
pointwise square-weight preservation
total square-weight preservation
```

it asks for the sharper coordinate condition:

```text
CoordinateSquarePreserving coordinateEquiv
```

Lean then derives:

```text
squareWeight_preserved
weightTotal_preserved
toStructuredSHESquareWeightTransportObligations
toStructuredSHESquareWeightTransportObligations_average_eq
toStructuredSHESquareWeightTransportObligations_bridge_eq
```

The example file checks the conversion from reduced obligations to the existing
full structured-SHE square-weight obligations, together with the derived
pointwise-weight and total-weight preservation facts.

### Mathematical Reason

This is not a new assumption layer.  It is a simplification of the existing
obligation boundary.  The previous full obligation record was mathematically
correct but slightly redundant: once the square-weight profile is defined by
`j.val^2`, pointwise square-weight preservation and total-weight preservation
are consequences of coordinate-square preservation.

Thus the formalization now separates the square-weight side of the Corollary
3.12 dispute into:

```text
coordinate-square preservation: still open;
full-label log-volume preservation: still open;
transported weighted-average equality: derived once both are supplied.
```

### Source Check

This reflects the way the source material treats the weighted calculation.  IUT
II identifies the weighted diagonal using the vector of `j^2` weights and
connects it to weighted-volume computation.  IUT III then applies the final
comparison to averages over `j in F_l` in the Corollary 3.12 proof corridor.

Scholze-Stix's objection is not that finite weighted sums cannot be transported
when all preservation data are supplied.  The objection is that the comparison
route may not legitimately supply the nontrivial `j`/`j^2` data after the
simplification to a common real-line setting.  This reduced obligation record
matches that pressure point: the square-weight branch now asks for exactly the
coordinate-square preservation data that would have to survive.

### Relevance to the 3.12 Dispute

After this milestone, the formal endpoint for the square-weight side is sharper:

```text
CoordinateSquarePreserving coordinateEquiv
+ fullLabelLogVolume preservation
=> structured-SHE square-weight transport audit
=> transported weighted-average equality
```

So a future IUT-positive construction must produce a coordinate equivalence with
this preservation property from the Hodge-theater/SHE route.  A Scholze-Stix
style negative formalization can try to show that the currently formalized
common-container/local-object data do not determine such an equivalence.

## 152. Full-Label Log-Volume Preservation Factored

### Lean Move

We added a factored API for the remaining full-label log-volume branch:

```text
IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelLogVolumeValuePreserving
```

The first condition is coordinate-level:

```text
fromCoordinate l (coordinateEquiv j) = fromCoordinate l j
```

for all `j : ZMod l.value`.  It says that the coordinate equivalence preserves
the zero/nonzero/sign-class full-label branch.

The second condition is value-level:

```text
target.fullLabelLogVolume label = source.fullLabelLogVolume label
```

for every full label.

Lean then proves:

```text
transportedFullLabelLogVolume_preserved_of_fullLabelMap
```

which supplies the full-label preservation field used by the square-weighted
transport audit.

### Mathematical Reason

The previous reduced square-weight milestone isolated the weight side of the
problem.  This milestone begins the same process for the log-volume side.  The
full-label preservation field is not treated as an opaque equality anymore: it
can be obtained from two more primitive assertions, one about how the coordinate
equivalence acts on the full-label map, and one about equality of the
log-volume values once the labels have been matched.

This matters because the full labels encode the zero branch separately from the
nonzero cusp sign-label branch.  A comparison that preserves a real number but
forgets whether it came from the zero or nonzero branch is not enough for the
current square-weighted full-label audit.

### Source Check

IUT II separates the role of the `F_l` symmetry from the `F_l^±`/sign-label
quotient behavior in the weighted-volume discussion.  IUT III's Corollary 3.12
route uses averages over `j in F_l`, while the surrounding discussion stresses
that the relevant log-volume quantities are tied to the Hodge-theater/log-link
structure rather than to arbitrary common real values.

This is also aligned with the Scholze-Stix pressure point.  Their criticism
targets whether the simplified common comparison object can retain the
nontrivial `j`-indexed information needed for the final estimate.  This
milestone says that full-label preservation has two independent ingredients:
preserving the label branch and preserving the real log-volume attached to the
matched branch.

### Relevance to the 3.12 Dispute

The square-weighted transport corridor is now factored as:

```text
coordinate-square preservation
  gives j^2-weight preservation

full-label-map preservation
+ full-label-value preservation
  gives full-label log-volume preservation

both branches together
  give transported weighted-average equality
```

This still does not prove Corollary 3.12.  It gives a sharper target for the
next step: combine the coordinate-square and full-label-map/value branches into
a single fully factored structured-SHE obligation record, then compare that
record against the data actually supplied by local-object Hodge descent and the
SHE common-container route.

## 153. Fully Factored Structured-SHE Square/Full-Label Obligations

### Lean Move

We added a single factored structured-SHE input record:

```text
IUTStage1StructuredSHEFactoredSquareFullLabelObligations
```

It contains the common data:

```text
coordinate equivalence
source and target square-weight profiles
source and target full-label log-volume branches
```

and three primitive preservation fields:

```text
coordinateSquare_preserved
fullLabelMap_preserved
fullLabelValue_preserved
```

Lean derives from these fields:

```text
fullLabelLogVolume_preserved
toCoordinateSquareWeightObligations
toStructuredSHESquareWeightTransportObligations
toStructuredSHESquareWeightTransportAudit
transportedAverage_eq
bridge_eq_structuredSHE
```

The example module now checks this derivation path from factored data to the
existing structured-SHE square-weight transport audit and transported-average
equality.

### Mathematical Reason

This milestone consolidates the two factorizations from the previous commits.
The final square-weighted full-label average is not treated as a primitive
miracle.  It is derived from two independent branches:

```text
coordinate-square preservation
  controls the j^2 weights

full-label map/value preservation
  controls the log-volume value attached to each zero/nonzero/sign label
```

Once both branches are supplied, Lean constructs the existing
`IUTStage1StructuredSHESquareWeightTransportObligations`, hence the same
transported weighted-average equality as before.

### Source Check

This continues to track the source dispute directly.  IUT II treats the
weighted diagonal and weighted-volume computations as dependent on the `j^2`
profile.  IUT III's Corollary 3.12 corridor applies the Theorem 3.11 output to
averages over `j in F_l`.  The April 2026 formalization report isolates the
final `3.11.5 => 3.12` stage as the simultaneous comparison problem.

Scholze-Stix's critique asks whether the common comparison object still carries
the nontrivial `j`/`j^2` information.  This Lean record gives a precise form of
that question: does the IUT route supply the three primitive preservation
fields above, or are they extra data not determined by the common-container and
local-object descent structures?

### Relevance to the 3.12 Dispute

The current formal state is:

```text
factored primitive preservation data
  => full structured-SHE square-weight obligations
  => transported weighted-average equality
```

This is an important checkpoint.  The project has still not proved Corollary
3.12, but the disputed preservation mechanism is now expressed as a concrete
Lean interface.  The next review should compare this interface against the
currently formalized Hodge-descent/local-object/common-container data and mark
exactly which of the three primitive fields are supplied, missing, or
unjustified.

## 154. Local-Object Hodge Descent vs. Factored Preservation Fields

### Lean Move

We added a primitive missing-data checklist:

```text
IUTStage1FactoredSquareFullLabelMissingDatum
```

with three entries:

```text
coordinateSquarePreservation
fullLabelMapPreservation
fullLabelValuePreservation
```

The existing local-object Hodge descent boundary now exposes:

```text
missingFactoredSquareFullLabelData
coordinateSquarePreservation_missing
fullLabelMapPreservation_missing
fullLabelValuePreservation_missing
```

The structured Hodge-descent packet audit projects these same gaps through
`localObjectSquareWeightBoundary`, and the example file checks the three
primitive missing-field lemmas on a place-audited log-volume route.

### Mathematical Reason

This is a comparison milestone.  The previous milestone defined the factored
input record sufficient to derive transported square-weighted full-label average
equality.  This milestone asks whether the local-object Hodge descent packet
data supplies the primitive fields of that record.

The answer in the current Lean interface is no.  Local-object Hodge descent
supplies:

```text
zero local object = packet local object
cusp-class local object = packet local object
history separation
```

It does not supply:

```text
coordinate-square preservation of the j^2 profile
full-label-map preservation
full-label-value preservation
```

This is deliberately modest.  It does not claim that Mochizuki's full theory
cannot supply these fields elsewhere.  It only prevents the formalization from
silently extracting them from the local-object descent packet layer.

### Source Check

This matches the source tension around Corollary 3.12.  IUT III's final
comparison uses log-volume averages over `j in F_l`, and IUT II's weighted
volume discussion keeps the `j^2` weighting as structured data.  Scholze-Stix's
objection targets the possibility that, after simplifying to common comparison
data, the nontrivial label/weight information is no longer present.

The current Lean boundary reflects that issue exactly: packet-level
local-object equality is not enough to reconstruct either the `j^2` coordinate
profile or the full-label log-volume branch.

### Relevance to the 3.12 Dispute

The formal picture is now:

```text
local-object Hodge descent
  gives packet equalities

factored 3.12 square/full-label transport
  needs three primitive preservation fields

current Lean comparison
  marks all three primitive fields as missing from local-object descent alone
```

The next mathematical task is therefore sharper: inspect the stronger
Hodge-theater/SHE/common-container machinery and ask whether it supplies these
fields, or whether further source-specific assumptions must be introduced.

## 155. SHE/Common-Container Boundary for Factored Preservation

### Lean Move

We added a higher-level boundary record:

```text
IUTStage1StructuredSHEFactoredPreservationBoundary
```

It wraps the existing structured-SHE common-container compatibility:

```text
IUTStage1Theorem311StructuredSHECommonContainerCompatibility
```

and exposes the facts this layer really supplies:

```text
commonContainerContextMatches
simultaneousValid
domainHistory_ne_codomainHistory
```

It also records that the three primitive preservation fields needed by the
factored square/full-label transport interface are still missing from this
compatibility layer:

```text
coordinateSquarePreservation_missing
fullLabelMapPreservation_missing
fullLabelValuePreservation_missing
```

The example file now checks construction of this boundary from a structured-SHE
bundle and verifies both sides of the interface: available simultaneous
common-container data, and missing `j^2`/full-label primitive preservation
data.

### Mathematical Reason

The previous milestone compared local-object Hodge descent with the factored
transport interface.  This milestone moves one level higher, to the
structured-SHE/common-container route.

The common-container layer is stronger than local-object packet descent.  It
does supply the simultaneous comparison context and keeps the domain/codomain
histories separated.  But the current Lean data still does not include:

```text
coordinate-square preservation
full-label-map preservation
full-label-value preservation
```

This distinction matters.  "Simultaneous common-container comparison" is not
identical to "the `j^2`-weighted full-label expression has been transported".
The latter requires the three primitive fields isolated in Milestone 153.

### Source Check

The April 2026 formalization report describes the final `3.11.5 => 3.12` stage
as concentrating on the crucial simultaneous comparison aspect after moving the
`hull+det` work earlier.  Our structured-SHE/common-container compatibility
matches that simultaneous-comparison bookkeeping.

IUT III's Corollary 3.12 corridor still uses averages over `j in F_l`, and IUT
II's weighted-volume discussion treats the `j^2` profile as structured data.
Scholze-Stix's criticism asks whether the common comparison can retain that
nontrivial label/weight information.  This Lean boundary says: the current
common-container compatibility gives the simultaneous setting, but it does not
by itself give the primitive preservation fields needed for the weighted
full-label transport.

### Relevance to the 3.12 Dispute

The hierarchy is now explicit:

```text
local-object Hodge descent
  gives packet equalities

structured-SHE/common-container compatibility
  gives simultaneous comparison context

factored square/full-label transport
  still needs coordinate-square, full-label-map, and full-label-value preservation
```

This is a useful impartial checkpoint.  It does not refute IUT, because the full
source theory may intend to supply these fields by additional Hodge-theoretic
or log-link arguments.  It also does not prove Corollary 3.12, because the
fields are not yet constructed.  It identifies exactly what the next source
audit must look for.

## 156. Full-Label Map Preservation Is Weaker Than Square Transport

### Lean Move

We added the sign-change instance:

```text
IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelMapPreserving_neg
```

This proves that negation on `ZMod l.value` preserves the full-label map
`fromCoordinate`.  At zero this is immediate.  Away from zero it uses the
existing sign-quotient lemma:

```text
IUTStage1ZModCuspFullLabel.fromCoordinate_neg
```

We also added:

```text
IUTStage1FullLabelMapOnlyTransport
```

This record deliberately carries only:

```text
coordinateEquiv
fullLabelMap_preserved
```

and records that two fields are still missing for the stronger factored
square/full-label transport interface:

```text
coordinateSquarePreservation
fullLabelValuePreservation
```

The example file now checks the negation instance, construction of the
map-only transport, and the two explicitly missing fields.

### Mathematical Reason

This is a small but important trap guard.  The sign quotient identifies the
nonzero labels `j` and `-j`, so a sign change can preserve the full-label
branch.  That fact alone does not say that the transported `j^2`-weighted
expression has been preserved as a log-volume computation.

In the current Lean model, the square-weight branch and the full-label branch
are therefore kept factored:

```text
full-label-map preservation
coordinate-square preservation
full-label-value preservation
```

The new map-only transport witnesses the first item without supplying the
other two.  This prevents us from silently replacing the disputed weighted
transport step by a weaker sign-quotient compatibility statement.

### Source Check

IUT III's Corollary 3.12 corridor uses averages over `j in F_l` with the
`q^{j^2}` weight profile.  IUT II's weighted-volume discussion also treats this
square-weight profile as structured data, not merely as a quotient-label
lookup.  Scholze-Stix's criticism focuses precisely on whether the comparison
retains nontrivial `j^2` scaling data after the proposed simplification.

This Lean step is consistent with that pressure point: preserving the
zero/nonzero/sign-quotient label map is useful, but it is not the same datum as
transporting the square-weighted log-volume expression.

### Relevance to the 3.12 Dispute

We now have a formal counterweight against a possible false shortcut:

```text
sign-quotient branch preserved
  does not imply
3.12 weighted average transported
```

This does not decide whether Mochizuki's Hodge-theoretic route supplies the
missing data.  It says that our formalization will require that data explicitly
before accepting the `3.11 => 3.12` transport step.

## 157. Modular Squaring Is Weaker Than Real Square-Weight Transport

### Lean Move

We added a second square-preservation predicate:

```text
IUTStage1ZModSquareWeightProfile.CoordinateModularSquarePreserving
```

It states:

```text
(coordinateEquiv j)^2 = j^2
```

inside `ZMod l.value`.  This is intentionally separate from:

```text
IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
```

which states equality of real representative squares:

```text
((coordinateEquiv j).val : Real)^2 = (j.val : Real)^2
```

Lean proves that negation preserves the modular square:

```text
coordinateModularSquarePreserving_neg
```

We then added:

```text
IUTStage1FullLabelModularSquareOnlyTransport
```

This record carries both full-label map preservation and modular-square
preservation, but it still marks the real coordinate-square preservation and
full-label value preservation fields as missing.

### Mathematical Reason

The sign change `j ↦ -j` is harmless for the sign quotient and for the square
class in the finite field:

```text
(-j)^2 = j^2
```

But the current square-weight profile used for the Corollary 3.12 audit is not a
`ZMod`-valued square class.  It is the real number:

```text
(j.val : Real)^2
```

For a representative-valued profile, sign change need not preserve the chosen
real representative square.  The formalization therefore refuses to treat
finite-field square compatibility as enough evidence for transporting the
`q^{j^2}`-style real weighted average.

### Source Check

IUT II separates the roles of the `F_l^±`-symmetry and the full `F_l`-symmetry:
the former has uniradial/coric aspects, while the latter is tied to separating
zero from nonzero labels and describing Gaussian-monoid internal structure.
IUT III's Corollary 3.12 averages over `j in F_l`; Scholze-Stix's Section 2.2
presses on whether the required `j^2` scaling can be maintained under coherent
real-line identifications.

This milestone keeps those layers apart:

```text
F_l^± / sign quotient / modular square
real representative square profile used in the weighted log-volume expression
```

### Relevance to the 3.12 Dispute

The formal trap is now sharper:

```text
sign quotient preserved
modular square preserved
  still does not imply
real square-weighted full-label average transported
```

This is not a negative result about IUT.  It is an audit condition.  If
Mochizuki's Hodge-theoretic route supplies the real representative-square
transport by some additional mechanism, the Lean development must encode that
mechanism explicitly rather than deriving it from sign/modular compatibility.

## 158. Concrete Prime-Five Witness for the Square-Weight Trap

### Lean Move

The example file now contains a concrete prime-five regression:

```text
squareAuditPrimeFiveExample
zmodSquareWeightProfile_neg_not_coordinate_square_primeFive_example
```

Lean proves:

```text
not CoordinateSquarePreserving (Equiv.neg (ZMod 5))
```

for the real representative-square predicate.  The proof tests the coordinate
`1 : ZMod 5`.  Under negation its representative is `4`, so the real squares are:

```text
4^2 = 16
1^2 = 1
```

and the required equality is impossible.

### Mathematical Reason

This is the concrete witness behind Milestone 157.  The same negation map
preserves:

```text
full-label sign quotient
modular square class
```

but it does not preserve the representative-valued real square profile used in
our current weighted-average audit.  This is not merely a typing distinction:
Lean computes an explicit failing coordinate in the first admissible prime case.

### Source Check

The source documents make the distinction worth preserving.  IUT II distinguishes
the `F_l^±` symmetry from the full `F_l` symmetry involved in Gaussian-monoid
structure.  IUT III Corollary 3.12 works with averages over `j in F_l`, while
Scholze-Stix Section 2.2 argues that the `j^2` real scaling is exactly where
consistent real-line identifications become problematic.

### Relevance to the 3.12 Dispute

This example gives the formalization a small executable warning sign:

```text
do not replace real representative-square preservation
by sign/modular-square preservation
```

Any later construction that claims to supply the Corollary 3.12 weighted
transport must pass the stronger `CoordinateSquarePreserving` interface, not
just the sign-quotient or modular-square interfaces.

## 159. Rigidity of the Real Representative-Square Profile

### Lean Move

We proved three rigidity lemmas for the current square-weight profile:

```text
IUTStage1ZModSquareWeightProfile.coordinateSquarePreserving_val_eq
IUTStage1ZModSquareWeightProfile.coordinateSquarePreserving_apply_eq
IUTStage1ZModSquareWeightProfile.coordinateSquarePreserving_eq_refl
```

The first says that if a coordinate equivalence preserves the real square
profile:

```text
((coordinateEquiv j).val : Real)^2 = (j.val : Real)^2
```

then it preserves the representatives:

```text
(coordinateEquiv j).val = j.val
```

The second and third turn this into pointwise identity of the coordinate
equivalence, and then equality with `Equiv.refl`.

The proof uses only elementary ordered-ring reasoning: `ZMod.val` gives
nonnegative representatives, so equality of real squares implies equality of
the representatives.  Then `ZMod.val_injective` identifies the `ZMod` elements.

### Mathematical Reason

This makes explicit a consequence of the modeling choice introduced when we
represented the `j^2` weight as:

```text
(j.val : Real)^2
```

That choice is rigid.  A transport map that preserves this profile cannot merely
preserve the sign class or the finite-field square class; it must be the identity
on the chosen representatives.

This is a useful audit fact, not a final mathematical verdict.  It says that if
the intended IUT `j^2` datum is supposed to be invariant under nontrivial
sign/modular transport, then the formalization must eventually refine the model
of the square-weight profile or supply additional Hodge-theoretic data explaining
how representative choices are transported.

### Source Check

IUT III Corollary 3.12 describes the relevant log-volume as an average over
`j in F_l`, while the April 2026 formalization report isolates the final
`3.11.5 => 3.12` problem as the simultaneous comparison stage.  Scholze-Stix
Section 2.2 focuses on the same location from the opposite direction: coherent
real-line identifications appear to leave no room for the nontrivial `j^2`
scaling.

This Lean milestone contributes a precise local version of that pressure:

```text
with representative-valued real weights,
real square preservation is identity-rigid.
```

### Relevance to the 3.12 Dispute

The current formalization now has two adjacent facts:

```text
negation preserves sign and modular square data
negation does not preserve the representative real square profile
```

and a general rigidity theorem:

```text
preserving the representative real square profile forces identity
```

This is exactly the sort of boundary we need before encoding deeper
Hodge-theoretic mechanisms.  The next source-facing task is not to hide this
rigidity, but to determine whether the original papers intend a different square
profile, a different transport interface, or an additional construction that
justifies the representative-level preservation required by our current audit.

## 160. Balanced Sign-Invariant Square Profile

### Lean Move

We added a separate sign-invariant square profile:

```text
IUTStage1ZModSquareWeightProfile.balancedSquareWeight
```

It is defined by the minimal absolute representative supplied by mathlib:

```text
balancedSquareWeight j = (j.valMinAbs.natAbs : Real)^2
```

We also added the preservation predicate:

```text
IUTStage1ZModSquareWeightProfile.CoordinateBalancedSquarePreserving
```

and proved:

```text
balancedSquareWeight_neg_eq
coordinateBalancedSquarePreserving_refl
coordinateBalancedSquarePreserving_neg
```

The key input is mathlib's theorem:

```text
ZMod.natAbs_valMinAbs_neg
```

which says that `j` and `-j` have the same minimal absolute representative.

### Mathematical Reason

Milestone 159 showed that the current representative-valued profile:

```text
(j.val : Real)^2
```

is identity-rigid.  This milestone records a different possible real square
profile, one that is genuinely compatible with sign symmetry:

```text
(j.valMinAbs.natAbs : Real)^2
```

This does not replace the Corollary 3.12 audit profile.  It gives us an explicit
formal fork:

```text
representative profile
  rigid, tied to the chosen nonnegative representative j.val

balanced profile
  sign-invariant, tied to the minimal absolute representative
```

If later source analysis indicates that the relevant `j^2` datum should be
understood only up to sign, we now have a checked Lean object for that.  If the
source requires the representative-valued profile, the rigidity theorem from
Milestone 159 remains the correct audit condition.

### Source Check

IUT II separates the `F_l^±` symmetry from the full `F_l` symmetry.  The former
has a coric/uniradial role and interacts with the zero/nonzero symmetrization;
the latter separates the zero label from nonzero labels and supports the
Gaussian-monoid internal structure indexed by `j in F_l`.

IUT III Remark 3.12.4 describes averages over `j in F_l` as part of the
Corollary 3.12 log-volume estimate and compares this with the `mod p/p^2`
portion of Witt-vector-like structure.  Scholze-Stix Section 2.2 identifies the
`j^2` scaling as the obstruction under coherent real-line identifications.

The balanced profile records one possible sign-compatible square model, but it
does not answer which square model is intended by the source text at the
Corollary 3.12 boundary.

### Relevance to the 3.12 Dispute

This milestone prevents a false binary.  The formalization no longer has only:

```text
rigid representative square profile
```

It also has:

```text
sign-invariant balanced square profile
```

But these are different Lean objects.  A future proof of the `3.11.5 => 3.12`
transport step must say which one is being transported and why that matches the
paper's `j^2` expression.  That is exactly the kind of precision the
formalization is meant to enforce.

## 161. Balanced Square/Full-Label Summand Transport

### Lean Move

We added:

```text
IUTStage1BalancedSquareFullLabelTransport
```

This is a compact transport record for the balanced profile branch.  It carries:

```text
coordinateEquiv
sourceLogVolume
targetLogVolume
coordinateBalancedSquare_preserved
fullLabelMap_preserved
fullLabelValue_preserved
```

From these fields Lean proves:

```text
balancedSquareWeight_preserved
fullLabelLogVolume_preserved
balancedSummand_preserved
```

The final theorem states that the balanced weighted full-label summand is
preserved:

```text
balancedSquareWeight (coordinateEquiv j)
  * targetFullLabelLogVolume (coordinateEquiv j)
=
balancedSquareWeight j
  * sourceFullLabelLogVolume j
```

We also added:

```text
IUTStage1BalancedSquareFullLabelTransport.negSelf
```

which constructs this balanced transport for negation when source and target
log-volume branches are the same.

### Mathematical Reason

This is the positive counterpart to the representative-profile rigidity result.
For the representative profile:

```text
(j.val : Real)^2
```

negation fails and full preservation forces identity.  For the balanced profile:

```text
(j.valMinAbs.natAbs : Real)^2
```

negation is valid, and the full-label sign quotient is also valid under
negation.  Therefore the balanced weighted summand really is transported under
the sign-compatible route.

The point is not to claim that Corollary 3.12 uses the balanced profile.  The
point is to make the two options formally incomparable:

```text
representative summand transport
balanced summand transport
```

They are different Lean records with different hypotheses.

### Source Check

The distinction matches the tension visible in the source material.  IUT II
emphasizes the `F_l^±` symmetry and its compatibility with zero/nonzero
symmetrization and the log-link, while also assigning a distinct role to the
full `F_l` symmetry in the Gaussian-monoid structure.  IUT III Corollary 3.12
and Remark 3.12.4 keep averages over `j in F_l` central to the final log-volume
estimate.  Scholze-Stix Section 2.2 focuses on whether the `j^2` scaling can
survive real-line comparisons.

The new balanced summand theorem shows exactly what a sign-compatible square
route can prove.  It does not prove that this is the route intended in the IUT
papers.

### Relevance to the 3.12 Dispute

We now have two formal corridors:

```text
representative corridor:
  matches the current j.val^2 audit profile,
  but is identity-rigid

balanced corridor:
  compatible with sign quotient and negation,
  but uses valMinAbs.natAbs^2 instead of j.val^2
```

This is useful because future source-facing work must either:

```text
show that Corollary 3.12 really requires the representative corridor,
show that the balanced corridor is the intended interpretation,
or add the missing Hodge-theoretic mechanism that reconciles the two.
```

The formalization is now precise enough to keep these choices separate.
