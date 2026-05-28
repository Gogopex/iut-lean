# Stage 1 Math Formalization Notes, Part 2

This file continues the root formalization notes after
`FORMALIZATION_NOTES.md` became large.  The rule remains the same: every Lean
move is recorded with the mathematical reason for making it.

## 1. Local Tensor Packets Carry Typed Capsule Log-Volumes

### Goal

We started tightening the `(Ind2)` local tensor-factor coordinate from
Theorem 3.11 by connecting it to the typed capsule/log-volume data developed
from Proposition 3.9.

The previous Lean state

```text
IUTStage1LocalTensorState
```

only recorded a symmetry label, a direct summand count, and a representative.
That was useful for modeling the existence of a local tensor symmetry, but it
did not yet know about packet/procession-normalized log-volumes.

### Lean/API Check

The new source-facing record is:

```text
IUTStage1LocalTensorPacketLogVolumeState
```

It carries:

```text
tensorState
localObject
capsuleFamily
direct_summand_count_eq_capsuleCount
capsule_family_localObject_eq
```

The key mathematical interface is:

```text
tensorState.directSummandCount = capsuleFamily.capsuleCount
```

This is deliberately a proof field, not a definitional reduction.  At this
stage we have not constructed Mochizuki's local tensor packet internally, so
Lean should require an explicit source obligation whenever a tensor-packet
state is supplied.

We also exposed the typed capsule family's positivity field as:

```text
IUTStage1TypedCapsuleFamilyLogVolume.capsuleCount_pos
```

The packet state uses this theorem to prove positivity of the local tensor
direct summand count after rewriting by the direct-summand/capsule-count
equality.

### Theorem 3.11 Link

We added:

```text
IUTStage1TensorPacketTheorem311Choice
```

This is the existing Theorem 3.11 choice record with the local tensor coordinate
specialized to `IUTStage1LocalTensorPacketLogVolumeState`.

We also added a forgetful map:

```text
forgetPacket :
  IUTStage1TensorPacketTheorem311Choice coric kind ->
  IUTStage1StructuredTheorem311Choice coric
```

The map forgets the typed capsule/log-volume refinement and keeps the older
local tensor state.  This is one-way for now: a later refined `(Ind2)` step must
prove how the packet data transforms before we can quotient by it safely.

### Why This Matches the Source Direction

IUT III Proposition 3.9 discusses packet-normalized and
procession-normalized log-volumes, with averaging over finite capsule data.
IUT III Theorem 3.11 then separates `(Ind2)` local tensor-factor symmetries
from `(Ind3)` upper semi-compatibility.  The debated route to Corollary 3.12
depends on not silently collapsing these layers into one undifferentiated
object.

This milestone keeps the layers separate while making their first explicit
interface:

```text
local tensor direct summands <-> typed capsule count
```

That interface is intentionally minimal and auditable.

### Toy Check

The source examples now check:

```text
upperSemi_typedCapsuleFamily_capsuleCount_pos_example
localTensorPacket_to_localTensorState_example
localTensorPacket_directSummandCount_eq_capsuleCount_example
localTensorPacket_directSummandCount_pos_example
localTensorPacket_localObject_eq_example
localTensorPacket_totalLogVolume_eq_sum_example
tensorPacketTheorem311_forgetPacket_example
tensorPacketTheorem311_directSummandCount_eq_capsuleCount_example
```

### Remaining Gap

The local tensor packet itself is not yet built from Hodge-theater or Frobenioid
objects.  The next useful refinement is a packet-aware `(Ind2)` step relation:
it should allow representative changes while preserving the capsule/log-volume
obligations needed for later upper-semi comparison.

## 2. Packet-Aware `(Ind2)` Step

### Goal

We refined the local tensor-factor symmetry relation so that it acts on the
packet-enhanced Theorem 3.11 choice, not only on the older untyped local tensor
state.

### Source Check

In IUT III, Theorem 3.11, `(Ind2)` is described as the indeterminacy induced by
actions on the direct summands of the tensor product used to define the local
`IQ(S...)` objects.  The same theorem keeps procession automorphisms as
`(Ind1)` and upper semi-compatibility across the log-link column as `(Ind3)`.

The Lean move therefore does not let `(Ind2)` modify the procession, coric
data, or upper-semi state.  It also does not identify all local objects by
definition.  Instead, it records the packet-level preservation needed for later
log-volume comparison as explicit fields.

### Lean/API Check

The new step relation is:

```text
IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketSymmetryStep
```

It may change the local tensor representative but preserves:

```text
column
row
coric
procession_state
upper_semi_state
localObject
capsuleCount
totalLogVolume
normalizedLogVolume
```

From the packet equality

```text
tensorState.directSummandCount = capsuleFamily.capsuleCount
```

and preservation of `capsuleCount`, Lean proves:

```text
ind2_preserves_directSummandCount
```

The packet-aware step also converts to the older structured `(Ind2)` step by
forgetting packet data:

```text
toStructuredLocalTensorSymmetryStep
```

### Trap Avoided

A tempting but unsafe shortcut would be to require equality of the entire
packet state across `(Ind2)`.  That would make the proof easy but would suppress
the point of `(Ind2)`: representatives may change.  The current relation keeps
only the invariants that downstream log-volume comparison is allowed to use.

### Toy Check

The source examples now check:

```text
tensorPacketTheorem311_ind2_preserves_directSummandCount_example
tensorPacketTheorem311_ind2_preserves_totalLogVolume_example
tensorPacketTheorem311_ind2_to_structured_example
```

### Remaining Gap

The step relation still assumes preservation of packet log-volumes as fields.
The next deeper mathematical task is to replace these fields by a formal action
on indexed capsule/direct-summand data and then prove the total and normalized
log-volume preservation from invariance of the summands.

## 3. Indexed Capsule Actions

### Goal

We replaced part of the packet-level preservation assumption by an explicit
action on indexed capsule representatives.

### Lean/API Check

The new action record is:

```text
IUTStage1TypedCapsuleFamilyLogVolumeAction
```

It is attached to a typed capsule family and supplies a new capsule
representative at every index:

```text
capsule : Fin data.capsuleCount -> IUTStage1CapsuleLogVolumeObject kind
```

with proof fields:

```text
capsule_local_object_eq
logVolume_eq
```

The transformed family keeps the same finite index type, local object, total
log-volume, and normalized log-volume.  The nontrivial Lean check is the total
sum equation: Lean proves that the transformed total is still the finite sum
over transformed capsules by pointwise equality of capsule log-volumes.

### Packet `(Ind2)` Refinement

We added:

```text
LocalTensorPacketActionStep
```

for `IUTStage1TensorPacketTheorem311Choice`.  This step carries a capsule action
on the source packet existentially and a proof that the target capsule family is
the transformed family.  The existential packaging matters: the step remains a
`Prop`, suitable for an indeterminacy relation, rather than a data-valued
structure.  From this, Lean derives:

```text
actionStep_preserves_capsuleCount
actionStep_preserves_capsuleTotalLogVolume
actionStep_preserves_capsuleNormalizedLogVolume
actionStep_preserves_directSummandCount
```

and converts the action step to the previous packet symmetry step:

```text
actionStep_toPacketSymmetryStep
```

### Source Alignment

This matches the local Theorem 3.11 `(Ind2)` direction more closely than the
previous milestone: the formal object is now an action on the finite indexed
capsule/direct-summand surface, and log-volume preservation is a theorem from
pointwise preservation rather than merely a field in the step relation.

### Trap Avoided

We still do not model the actual `Ism` copies or order-two automorphisms from
Theorem 3.11.  The action is intentionally weaker and more abstract.  It only
asserts what the current log-volume layer can responsibly consume: unchanged
per-capsule log-volume values over the same finite index type.

### Toy Check

The source examples now check:

```text
upperSemi_capsuleFamilyAction_transformed_example
upperSemi_capsuleFamilyAction_totalLogVolume_example
upperSemi_capsuleFamilyAction_total_eq_sum_example
tensorPacketTheorem311_actionStep_preserves_totalLogVolume_example
tensorPacketTheorem311_actionStep_to_packetStep_example
tensorPacketTheorem311_actionStep_preserves_directSummandCount_example
```

### Remaining Gap

The next refinement should type the actual direct summands separately from the
capsules, then relate the summand action to the capsule action.  This is where
the formalization should eventually introduce the `Ism`/order-two symmetry
surface mentioned in Theorem 3.11.

## 4. Direct Summand Surface

### Goal

We introduced a separate typed surface for the direct summands mentioned in
Theorem 3.11 `(Ind2)`, while keeping it tied to the already formalized typed
capsule family.

### Source Check

Theorem 3.11 `(Ind2)` distinguishes two symmetry sources:

```text
nonarchimedean places: independent copies of Ism
archimedean places: order-two automorphisms
```

The new Lean inductive type records this distinction as:

```text
IUTStage1TensorSummandSymmetryKind
```

with constructors:

```text
nonarchimedeanIsm
archimedeanOrderTwo
```

### Lean/API Check

The new direct summand records are:

```text
IUTStage1TensorDirectSummandObject
IUTStage1TensorDirectSummandFamily
IUTStage1TensorDirectSummandFamilyAction
```

A direct summand object carries a local object and a capsule object, with proof
that the capsule belongs to the same local object.

The family is indexed by:

```text
Fin capsuleFamily.capsuleCount
```

This is an intentional design choice.  We do not separately introduce an
unrelated finite type for direct summands and then assert that it has the same
cardinality.  At the current layer, the same finite index type is the cleanest
way to record the invariant already exposed by the packet state:

```text
directSummandCount = capsuleCount
```

The family proves:

```text
(family.summand i).capsule = capsuleFamily.capsule i
```

and hence:

```text
(family.summand i).capsule.logVolume =
  (capsuleFamily.capsule i).logVolume
```

### Action Link

A direct summand action supplies transformed direct summand representatives and
proves that their capsules preserve local object and log-volume data.  From
this, Lean constructs:

```text
toCapsuleAction :
  IUTStage1TypedCapsuleFamilyLogVolumeAction capsuleFamily
```

Thus the older capsule-action finite-sum preservation theorem can now be fed by
a direct-summand action.

### Trap Avoided

We did not yet claim to have formalized `Ism` or the order-two automorphism
groups themselves.  The current formalization records their source distinction
and the action surface that their eventual formal versions must inhabit.

### Toy Check

The source examples now check:

```text
tensorDirectSummandObject_logVolume_eq_capsule_example
tensorDirectSummandFamily_capsule_eq_example
tensorDirectSummandFamily_logVolume_eq_example
tensorDirectSummandAction_to_capsuleAction_example
tensorDirectSummandAction_totalLogVolume_example
```

### Remaining Gap

The next step should thread `IUTStage1TensorDirectSummandFamily` into the local
tensor packet state, so a packet choice can carry not only a capsule family but
also the direct-summand family whose action induces the capsule action.

## 5. Direct Summands Threaded into Packet Choices

### Goal

We connected the direct summand family to the local tensor packet state and to a
Theorem 3.11 choice type.

### Lean/API Check

The new packet state is:

```text
IUTStage1LocalTensorDirectSummandPacketState
```

It carries:

```text
packetState :
  IUTStage1LocalTensorPacketLogVolumeState kind
summandFamily :
  IUTStage1TensorDirectSummandFamily packetState.capsuleFamily
```

This dependent field is important: the summand family is attached to the exact
capsule family already present in the packet state, not to an arbitrary
externally equal family.

The new Theorem 3.11 choice abbreviation is:

```text
IUTStage1DirectSummandPacketTheorem311Choice
```

It has forgetful maps:

```text
forgetDirectSummands :
  IUTStage1DirectSummandPacketTheorem311Choice coric kind ->
  IUTStage1TensorPacketTheorem311Choice coric kind

forgetPacket :
  IUTStage1DirectSummandPacketTheorem311Choice coric kind ->
  IUTStage1StructuredTheorem311Choice coric
```

### Mathematical Point

The local tensor coordinate can now expose three layers:

```text
plain local tensor state
packet/capsule/log-volume state
direct summand family over that packet
```

This mirrors the Theorem 3.11 `(Ind2)` source pressure more closely: local
tensor symmetries act on direct summand representatives, and the capsule
log-volume layer is downstream of that action.

### Toy Check

The source examples now check:

```text
localTensorDirectSummandPacket_to_packetState_example
localTensorDirectSummandPacket_directSummandCount_eq_example
localTensorDirectSummandPacket_logVolume_eq_example
directSummandPacketTheorem311_forgetDirectSummands_example
directSummandPacketTheorem311_logVolume_eq_example
```

### Remaining Gap

The next step should define an `(Ind2)` action step directly on
`IUTStage1DirectSummandPacketTheorem311Choice`, then derive the existing
packet-action step by applying `toCapsuleAction` to the direct summand action.

## 6. Direct-Summand `(Ind2)` Step Descends to Packet `(Ind2)`

### Goal

We defined the `(Ind2)` step at the direct-summand packet level and proved that
it descends to the packet-action step from the previous layer.

### Lean/API Check

The new relation is:

```text
IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
```

It preserves:

```text
column
row
coric
procession_state
upper_semi_state
localObject
```

and contains an existential direct-summand action:

```text
∃ action : IUTStage1TensorDirectSummandFamilyAction source.summandFamily,
  target.packetState.capsuleFamily =
    action.toCapsuleAction.transformedFamily
```

The existential packaging again keeps the step proof-valued.

### Descending Map

Lean now checks:

```text
toTensorPacketActionStep
```

which converts the direct-summand step into:

```text
IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketActionStep
```

Consequently, the direct-summand step inherits the already proved packet-level
invariants:

```text
ind2_preserves_directSummandCount
ind2_preserves_capsuleTotalLogVolume
```

### Mathematical Point

This is the cleanest formal version so far of the intended `(Ind2)` dependency
chain:

```text
direct summand symmetry
  -> induced capsule action
  -> finite-sum log-volume preservation
  -> local tensor direct-summand count preservation
```

### Toy Check

The source examples now check:

```text
directSummandPacketTheorem311_ind2_to_packetAction_example
directSummandPacketTheorem311_ind2_preserves_directSummandCount_example
directSummandPacketTheorem311_ind2_preserves_totalLogVolume_example
```

### Remaining Gap

The direct-summand action itself is still an abstract source-facing action. The
next serious mathematical refinement is to replace this action by typed
nonarchimedean `Ism` actions and archimedean order-two actions, or at least by
separate records for those two cases.

## 7. Nonarchimedean and Archimedean `(Ind2)` Action Surfaces

### Goal

We separated the two source cases of Theorem 3.11 `(Ind2)` into typed Lean
records.

### Source Check

Theorem 3.11 `(Ind2)` names:

```text
vQ in Vnon_Q: independent copies of Ism
vQ in Varc_Q: order-two automorphisms
```

The Lean layer now has one record for each case:

```text
IUTStage1NonarchimedeanIsmDirectSummandAction
IUTStage1ArchimedeanOrderTwoDirectSummandAction
```

Each record is specialized to the appropriate `IUTStage1PlaceKind`.

### Lean/API Check

Each source-specific action record carries:

```text
place
symmetry_kind_eq
action : IUTStage1TensorDirectSummandFamilyAction family
```

The symmetry-kind equality prevents a nonarchimedean `Ism` action from being
used on a family tagged as archimedean order-two, and conversely.

Both records expose:

```text
toDirectSummandAction
capsuleTotalLogVolume_eq
```

so the previously checked finite-sum preservation path remains reusable.

### Trap Avoided

We still have not formalized the `Ism` group or the order-two automorphism
itself.  The purpose of this milestone is to prevent the two cases from being
merged too early.  The actual group/action construction remains a separate
mathematical obligation.

### Toy Check

The source examples now check:

```text
nonarchimedeanIsmAction_to_directSummandAction_example
nonarchimedeanIsmAction_symmetryKind_example
nonarchimedeanIsmAction_totalLogVolume_example
archimedeanOrderTwoAction_to_directSummandAction_example
archimedeanOrderTwoAction_symmetryKind_example
archimedeanOrderTwoAction_totalLogVolume_example
```

### Remaining Gap

The next step should use these two source-specific action records to build
source-specific direct-summand packet `(Ind2)` steps, then compare them with the
generic direct-summand step.

## 8. Source-Specific `(Ind2)` Steps

### Goal

We promoted the nonarchimedean and archimedean action surfaces into actual
source-specific `(Ind2)` step relations for refined Theorem 3.11 choices.

### Lean/API Check

The new step relations are:

```text
NonarchimedeanIsmInd2Step
ArchimedeanOrderTwoInd2Step
```

inside the namespace:

```text
IUTStage1DirectSummandPacketTheorem311Choice
```

Each one preserves the non-local-tensor coordinates:

```text
column
row
coric
procession_state
upper_semi_state
localObject
```

and contains an existential source-specific action whose induced capsule action
constructs the target capsule family.

### Descending Maps

Lean checks:

```text
nonarchimedeanIsm_toDirectSummandActionStep
archimedeanOrderTwo_toDirectSummandActionStep
```

so both source-specific steps descend to the generic direct-summand action
step.  Consequently, both inherit:

```text
*_preserves_capsuleTotalLogVolume
```

### Mathematical Point

This keeps the two source cases of Theorem 3.11 `(Ind2)` separate while still
using the same downstream finite-sum preservation theorem.  That is the
intended abstraction boundary: the future construction of `Ism` and order-two
automorphisms should differ, but once they produce a valid direct-summand
action, the log-volume bookkeeping is common.

### Toy Check

The source examples now check:

```text
nonarchimedeanIsmInd2_to_directSummandActionStep_example
nonarchimedeanIsmInd2_preserves_totalLogVolume_example
archimedeanOrderTwoInd2_to_directSummandActionStep_example
archimedeanOrderTwoInd2_preserves_totalLogVolume_example
```

### Remaining Gap

We still need to connect these source-specific `(Ind2)` steps into a generated
indeterminacy relation for the refined direct-summand packet choice, analogous
to the earlier structured Theorem 3.11 relation.

## 9. Generated Indeterminacy for Direct-Summand Packet Choices

### Goal

We connected the refined direct-summand packet choice to a generated
`(Ind1)/(Ind2)/(Ind3)` indeterminacy relation.

### Lean/API Check

Inside:

```text
IUTStage1DirectSummandPacketTheorem311Choice
```

we added:

```text
ProcessionAutomorphismStep
UpperSemiCompatibilityStep
indeterminacySourceData
```

The local tensor step used by `indeterminacySourceData` is the generic
direct-summand action step:

```text
LocalTensorDirectSummandActionStep
```

The generated relation now proves:

```text
generated_preserves_coric
generated_preserves_column
generated_preserves_capsuleTotalLogVolume
```

### Mathematical Point

This is the first generated indeterminacy relation at the refined direct
summand/capsule/log-volume level.  It says that after closing under reflexivity,
symmetry, and transitivity of `(Ind1)`, `(Ind2)`, and `(Ind3)`, the coric data,
the log-theta column, and the packet capsule total log-volume remain invariant.

The total log-volume invariant uses different reasons in each case:

```text
Ind1: local tensor state equality
Ind2: direct-summand action -> capsule action -> finite-sum preservation
Ind3: local tensor state equality
```

### Trap Avoided

The generated relation does not yet include the source-specific nonarchimedean
and archimedean `(Ind2)` steps directly.  Those steps descend to the generic
direct-summand action step.  This keeps the generated relation small while
preserving the source-specific entry points.

### Toy Check

The source examples now check:

```text
directSummandPacketTheorem311_generated_preserves_coric_example
directSummandPacketTheorem311_generated_preserves_column_example
directSummandPacketTheorem311_generated_preserves_totalLogVolume_example
```

### Remaining Gap

The next refinement should connect this generated direct-summand packet
indeterminacy relation to multiradial possible-image invariance, paralleling
the older `image_invariant_of_coric` interface but now with the refined
Theorem 3.11 choice type.

## 10. Refined Multiradial Image Invariance

### Goal

We connected the generated direct-summand packet indeterminacy relation to the
multiradial possible-image pattern.

### Lean/API Check

The new theorem is:

```text
IUTStage1DirectSummandPacketTheorem311Choice.image_invariant_of_coric
```

It states that for region-valued possible images indexed by refined
direct-summand packet choices, if the regions depend only on the coric
coordinate, then any two choices related by the generated `(Ind1)/(Ind2)/(Ind3)`
relation have the same region.

The proof uses:

```text
generated_preserves_coric
```

from the refined relation.

### Mathematical Point

This is the refined version of the multiradiality checkpoint: local tensor
symmetry, including the direct-summand/capsule/log-volume refinement, is now
part of the generated relation that possible images must be invariant under.

### Toy Check

The source example now checks:

```text
directSummandPacketTheorem311_image_invariant_of_coric_example
```

### Remaining Gap

The next step is to package this as a refined multiradial theta-image object,
so the Stage 1 source package can ask for the stronger refined quotient rather
than only the older generic quotient.

## 11. Refined Multiradial Image Package

### Goal

We packaged the refined direct-summand packet quotient together with
region-valued possible images.

### Lean/API Check

The new package is:

```text
IUTStage1DirectSummandPacketMultiradialImages
```

It carries:

```text
possibleImages
quotient
quotient_eq_generated
image_invariant
```

The constructor:

```text
ofCoricInvariant
```

builds the package from possible images whose regions depend only on the coric
coordinate.  The quotient is the generated quotient of the refined
direct-summand packet `(Ind1)/(Ind2)/(Ind3)` source data.

### Lean Theorems

The package exposes:

```text
region_eq_of_related
quotient_profile
```

so downstream code can use the refined quotient without unfolding the generated
relation.

### Mathematical Point

This is a stronger multiradial interface than the older generic one: the
indeterminacies now include the direct-summand/capsule/log-volume `(Ind2)`
surface.  Any later route from Theorem 3.11 to Corollary 3.12 can ask for this
package when it needs the refined local tensor information.

### Toy Check

The source examples now check:

```text
directSummandPacketMultiradialImages_of_coric_example
directSummandPacketMultiradialImages_region_eq_example
directSummandPacketMultiradialImages_profile_example
```

### Remaining Gap

The package is still independent of the full `IUTStage1SourcePackage`.  The
next step should define a bridge from a source package indexed by refined
Theorem 3.11 choices into this refined multiradial image package.

## 12. Source-Package Bridge for Refined Multiradial Images

### Goal

We connected the refined multiradial image package to an actual
`IUTStage1SourcePackage` indexed by refined direct-summand packet choices.

### Lean/API Check

The new source-level package is:

```text
IUTStage1RefinedDirectSummandPacketMultiradialThetaImages
```

It carries:

```text
multiradialOutput
possibleImages : IUTStage1ThetaPilotPossibleImages package
refinedImages : IUTStage1DirectSummandPacketMultiradialImages
multiradial_output_eq
refined_possibleImages_eq
```

The constructor:

```text
ofPackageWithCoricInvariant
```

builds the refined package from a source package plus the obligation that its
Theta-pilot possible images depend only on the coric coordinate.

### Lean Theorems

The package exposes:

```text
region_eq_of_related
quotient_profile
union_eq_targetUnion
```

### Mathematical Point

This is the refined replacement for the older multiradial source package
interface.  It asks for invariance under the generated direct-summand packet
quotient, but still remains tied to the actual source package's possible images
and target union.

### Toy Check

The source examples now check:

```text
refinedDirectSummandPacketMultiradialThetaImages_of_package_example
refinedDirectSummandPacketMultiradialThetaImages_region_eq_example
refinedDirectSummandPacketMultiradialThetaImages_union_eq_example
```

### Remaining Gap

This bridge still requires coric dependence as an external hypothesis.  The next
task is to identify which Theorem 3.11 source subclaims should produce that
coric-dependence hypothesis for the refined choice type.

## 13. Refined Coric-Dependence Subclaim

### Goal

We turned the external coric-dependence hypothesis for refined multiradial
Theta-pilot images into a named source-facing Theorem 3.11 subclaim.

### Source Check

IUT III, Theorem 3.11 states the multiradial representation after quotienting
by the procession and local tensor-factor indeterminacies and then tracking
upper semi-compatibility.  In the refined Lean layer, this becomes the
obligation that possible images indexed by direct-summand packet choices depend
only on the coric coordinate after the refined `(Ind1)/(Ind2)/(Ind3)` quotient.

This is still a source obligation, not a constructed proof from Hodge theaters.
That is intentional: the formalization should expose this as a named claim that
the eventual proof of Theorem 3.11 must supply.

### Lean/API Check

The new refined dependence record is:

```text
IUTStage1RefinedThetaImagesDependOnlyOnCoric
```

It states:

```text
choice₁.coric = choice₂.coric ->
  possibleImages.region choice₁ = possibleImages.region choice₂
```

for packages indexed by:

```text
IUTStage1DirectSummandPacketTheorem311Choice coric kind
```

The named Theorem 3.11 subclaim is:

```text
IUTStage1Theorem311RefinedMultiradialSubclaim
```

It contains the refined coric-dependence obligation and produces:

```text
toRefinedMultiradialThetaImages
imageInvariant
quotientProfile
union_eq_targetUnion
```

### Trap Avoided

We did not add this field to the older generic `IUTStage1Theorem311Subclaims`,
which is indexed by arbitrary source packages and used for downstream endpoint
promotion.  The refined subclaim is specialized to the refined direct-summand
packet choice type, preventing accidental reuse where the refined quotient is
not present.

### Scholze-Stix Relevance

This subclaim is one of the places where the formalization must not hide the
dispute.  It does not identify all histories or all local tensor
representatives.  It says exactly what must be proved for the refined possible
images: invariance under the coric coordinate after explicitly modeled
indeterminacies.

### Toy Check

The source examples now check:

```text
refinedThetaImagesDependOnlyOnCoric_to_multiradial_example
refinedThetaImagesDependOnlyOnCoric_profile_example
refinedThetaImagesDependOnlyOnCoric_union_eq_example
theorem311RefinedMultiradialSubclaim_to_dependence_example
theorem311RefinedMultiradialSubclaim_to_multiradial_example
theorem311RefinedMultiradialSubclaim_profile_example
```

### Remaining Gap

The refined subclaim is still an assumption.  The next mathematical refinement
should decompose it into source-specific ingredients: algorithmic construction
of the refined representation, functoriality under procession isomorphisms, and
compatibility of direct-summand actions with the refined possible-image family.

## 14. Generator-Wise Refined Image Invariance

### Goal

We decomposed the refined multiradiality obligation one level further: instead
of requiring coric-dependence directly, a source proof may now supply image
invariance separately for the three refined generators `(Ind1)`, `(Ind2)`, and
`(Ind3)`.

### Source Check

IUT III, Theorem 3.11 first describes the relevant data up to `(Ind1)` and
`(Ind2)`, then discusses the log-Kummer/upper-semi behavior as `(Ind3)`.  It
also says the construction is functorial with respect to isomorphisms of
processions.  The generator-wise record follows this source shape more closely
than the coric-only obligation:

```text
Ind1: procession automorphism invariance
Ind2: direct-summand action invariance
Ind3: upper-semi compatibility invariance
```

### Lean/API Check

The new record is:

```text
IUTStage1RefinedThetaImageGeneratorInvariance
```

It has fields:

```text
ind1_region_eq
ind2_region_eq
ind3_region_eq
```

Lean then applies the existing generated-relation induction theorem:

```text
IUTStage1GeneratedIndeterminacyRelation.image_invariant
```

to prove:

```text
generatedImageInvariant
```

and construct:

```text
toRefinedMultiradialThetaImages
```

The named source subclaim is:

```text
IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim
```

### Mathematical Point

This is a better target for the eventual proof of Theorem 3.11.  The future
formalization can prove the three generator invariance fields separately from
the corresponding source constructions, while Lean handles closure under
reflexivity, symmetry, and transitivity.

### Trap Avoided

We did not infer coric-dependence from generator invariance.  Generator
invariance gives invariance under the generated quotient, which is exactly what
the refined multiradial package needs.  Coric-dependence remains a separate,
stronger-looking route.

### Toy Check

The source examples now check:

```text
refinedThetaImageGeneratorInvariance_to_multiradial_example
refinedThetaImageGeneratorInvariance_region_eq_example
refinedThetaImageGeneratorInvariance_profile_example
theorem311RefinedGeneratorInvarianceSubclaim_to_invariance_example
theorem311RefinedGeneratorInvarianceSubclaim_to_multiradial_example
theorem311RefinedGeneratorInvarianceSubclaim_union_eq_example
```

### Remaining Gap

The next refinement should split the `(Ind2)` generator field into its
nonarchimedean `Ism` and archimedean order-two cases, using the source-specific
steps already defined.

## 15. Source-Specific Refined `(Ind2)` Quotients

### Goal

We made the refined generated quotient itself source-specific in the two
Theorem 3.11 `(Ind2)` cases.

### Source Check

Theorem 3.11 distinguishes the local tensor-factor indeterminacies:

```text
nonarchimedean: independent copies of Ism
archimedean: order-two automorphisms
```

The previous refined quotient used the generic direct-summand action step as
its `(Ind2)` generator.  This milestone adds generated source data where the
`(Ind2)` generator is the corresponding source-specific step.

### Lean/API Check

The new source data are:

```text
nonarchimedeanIsmIndeterminacySourceData
archimedeanOrderTwoIndeterminacySourceData
```

inside:

```text
IUTStage1DirectSummandPacketTheorem311Choice
```

Lean proves for each source-specific generated relation:

```text
*_generated_preserves_coric
*_generated_preserves_capsuleTotalLogVolume
```

The log-volume proof uses the same generated-relation induction as before, but
the `(Ind2)` case now goes through:

```text
NonarchimedeanIsmInd2Step
ArchimedeanOrderTwoInd2Step
```

rather than through the generic direct-summand action step directly.

### Mathematical Point

This gives the formalization two entry points for future source proofs: one for
the nonarchimedean `Ism` construction and one for the archimedean order-two
construction.  Both still descend to the common finite-sum log-volume
bookkeeping once the source-specific action is supplied.

### Toy Check

The source examples now check:

```text
nonarchimedeanIsm_generated_preserves_coric_example
nonarchimedeanIsm_generated_preserves_totalLogVolume_example
archimedeanOrderTwo_generated_preserves_coric_example
archimedeanOrderTwo_generated_preserves_totalLogVolume_example
```

### Remaining Gap

The next refinement should package source-specific image invariance, just as
the generic generator-wise invariance package does, so the nonarchimedean and
archimedean quotients can drive multiradial image packages directly.

## 16. Source-Specific Generator-Wise Image Invariance

### Goal

We added generator-wise image invariance records for the two source-specific
refined quotients.

### Lean/API Check

The new records are:

```text
IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance
IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance
```

The nonarchimedean record uses:

```text
NonarchimedeanIsmInd2Step
nonarchimedeanIsmIndeterminacySourceData
```

The archimedean record uses:

```text
ArchimedeanOrderTwoInd2Step
archimedeanOrderTwoIndeterminacySourceData
```

Both records have generator fields:

```text
ind1_region_eq
ind2_region_eq
ind3_region_eq
```

and both prove:

```text
generatedImageInvariant
```

by applying the general generated-relation induction theorem.

### Mathematical Point

The earlier generator-wise invariance package used the generic direct-summand
action as `(Ind2)`.  This milestone provides the source-specific versions that
future proofs of `Ism` and order-two automorphism invariance should target.

### Toy Check

The source examples now check:

```text
nonarchimedeanIsmThetaImageGeneratorInvariance_region_eq_example
archimedeanOrderTwoThetaImageGeneratorInvariance_region_eq_example
```

### Remaining Gap

The next step should wrap these source-specific invariance records into
source-specific multiradial image packages, rather than exposing only the raw
generated-image-invariance theorem.

## 17. Source-Specific Multiradial Image Packages

### Goal

We wrapped the source-specific generator-wise invariance records into
source-level multiradial image packages.

### Lean/API Check

The new packages are:

```text
IUTStage1NonarchimedeanIsmMultiradialThetaImages
IUTStage1ArchimedeanOrderTwoMultiradialThetaImages
```

Each carries:

```text
multiradialOutput
possibleImages
quotient
quotient_eq_generated
multiradial_output_eq
image_invariant
```

The constructors are:

```text
IUTStage1NonarchimedeanIsmMultiradialThetaImages.ofGeneratorInvariance
IUTStage1ArchimedeanOrderTwoMultiradialThetaImages.ofGeneratorInvariance
```

The packages expose:

```text
region_eq_of_related
quotient_profile
union_eq_targetUnion
```

### Mathematical Point

The generic refined multiradial package remains useful for a common
direct-summand action surface.  These new packages keep the source-specific
`(Ind2)` quotients visible all the way to the source package interface.  This
is closer to the source split in IUT III, Theorem 3.11.

### Toy Check

The source examples now check:

```text
nonarchimedeanIsmMultiradialThetaImages_of_invariance_example
nonarchimedeanIsmMultiradialThetaImages_region_eq_example
nonarchimedeanIsmMultiradialThetaImages_profile_example
archimedeanOrderTwoMultiradialThetaImages_of_invariance_example
archimedeanOrderTwoMultiradialThetaImages_region_eq_example
archimedeanOrderTwoMultiradialThetaImages_profile_example
```

### Remaining Gap

The source-specific packages are not yet tied into a combined place-family
package.  The next mathematical step should aggregate nonarchimedean and
archimedean local data across the relevant places rather than treating each
place kind as a separate one-kind package.

## 18. `(Ind2)` Place-Family Action Data

### Goal

We introduced the first place-family aggregation layer for the two local
tensor-factor action kinds in Theorem 3.11 `(Ind2)`.

### Lean/API Check

The new entry wrappers are:

```text
IUTStage1NonarchimedeanIsmActionEntry
IUTStage1ArchimedeanOrderTwoActionEntry
```

Each entry carries:

```text
capsuleFamily
family
action
```

and exposes:

```text
place
toDirectSummandAction
symmetryKind_eq
capsuleTotalLogVolume_eq
```

The aggregate record is:

```text
IUTStage1Ind2PlaceFamilyActionData
```

with fields:

```text
nonarchimedeanActions
archimedeanActions
```

and accessors:

```text
nonarchimedeanCount
archimedeanCount
totalActionCount
nonarchimedeanPlaces
archimedeanPlaces
```

### Mathematical Point

This begins to model the paper's distinction between the two families of
places:

```text
Vnon_Q
Varc_Q
```

without yet constructing the actual local tensor product actions.  It is a
bookkeeping layer that lets later source proofs talk about a collection of
nonarchimedean `Ism` actions and a collection of archimedean order-two actions.

### Trap Avoided

We did not merge the two place families into a single list of untyped actions.
The Lean types keep nonarchimedean and archimedean entries separate, so an
archimedean order-two action cannot be used where an `Ism` action is expected.

### Toy Check

The source examples now check:

```text
nonarchimedeanIsmActionEntry_place_example
nonarchimedeanIsmActionEntry_totalLogVolume_example
archimedeanOrderTwoActionEntry_place_example
archimedeanOrderTwoActionEntry_totalLogVolume_example
ind2PlaceFamily_totalActionCount_example
ind2PlaceFamily_totalActionCount_eq_example
ind2PlaceFamily_nonarchimedeanPlaces_example
ind2PlaceFamily_archimedeanPlaces_example
```

### Remaining Gap

This aggregation is still only for action data.  The next step should connect
the place-family action data to upper-semi place-family data, because Theorem
3.11 combines `(Ind2)` local tensor-factor behavior with `(Ind3)` upper
semi-compatibility across nonarchimedean inclusions and archimedean surjections.

## 19. `(Ind2)`/`(Ind3)` Place-Family Compatibility

### Goal

We connected the `(Ind2)` place-family action data to the existing `(Ind3)`
upper-semi place-family data.

### Lean/API Check

The new record is:

```text
IUTStage1Ind2UpperSemiPlaceFamilyCompatibility
```

It carries:

```text
ind2Actions : IUTStage1Ind2PlaceFamilyActionData
upperSemiState : IUTStage1UpperSemiCompatibilityState
```

and proof fields:

```text
ind2Actions.nonarchimedeanPlaces =
  upperSemiState.nonarchimedeanInclusions.map place

ind2Actions.archimedeanPlaces =
  upperSemiState.archimedeanSurjections.map place
```

It also exposes the upper-semi log-volume compatibility proof and upper-bound
inequality from the `upperSemiState`.

### Mathematical Point

This links the two local layers currently modeled:

```text
Ind2: local tensor-factor actions by place kind
Ind3: upper-semi inclusions/surjections by place kind
```

The source text treats these as distinct indeterminacy mechanisms, but they
refer to the same nonarchimedean and archimedean place families.  The Lean
record now makes that matching an explicit proof obligation.

### Trap Avoided

The compatibility record does not identify the `(Ind2)` action data with the
`(Ind3)` inclusion/surjection data.  It only aligns their place lists.  This
keeps the local tensor-factor action and the upper-semi comparison separate.

### Toy Check

The source examples now check:

```text
ind2UpperSemiPlaceFamily_nonarchimedeanPlaces_example
ind2UpperSemiPlaceFamily_archimedeanPlaces_example
ind2UpperSemiPlaceFamily_logVolumeCompatible_example
ind2UpperSemiPlaceFamily_logVolumeUpperBound_example
```

### Remaining Gap

The next refinement should connect this compatibility record to refined
Theorem 3.11 choices, so a choice can carry or reference a place-family
compatibility audit rather than only independent local tensor and upper-semi
states.

## 20. Place-Audited Refined Choices

### Goal

We attached the `(Ind2)`/`(Ind3)` place-family compatibility audit to refined
direct-summand packet Theorem 3.11 choices.

### Lean/API Check

The new wrapper is:

```text
IUTStage1PlaceAuditedDirectSummandPacketChoice
```

It carries:

```text
choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind
placeFamilyCompatibility :
  IUTStage1Ind2UpperSemiPlaceFamilyCompatibility
upper_semi_state_eq :
  placeFamilyCompatibility.upperSemiState = choice.upper_semi_state
```

The wrapper exposes:

```text
toDirectSummandPacketTheorem311Choice
upperSemi_logVolumeCompatible
upperSemi_logVolumeUpperBound
nonarchimedeanPlaces_eq
archimedeanPlaces_eq
```

### Mathematical Point

This does not change the existing refined choice type.  Instead, it provides an
audited wrapper for situations where a proof wants to remember that the choice's
upper-semi state is linked to the place-family action data.  This keeps the
base choice lightweight but makes the stronger place-family compatibility
available explicitly.

### Trap Avoided

The audit wrapper does not merge `(Ind2)` and `(Ind3)`.  It only proves that
their place lists align for this choice.  Local tensor action data and
upper-semi inclusion/surjection data remain separate fields.

### Toy Check

The source examples now check:

```text
placeAuditedDirectSummandPacketChoice_forget_example
placeAuditedDirectSummandPacketChoice_logVolumeCompatible_example
placeAuditedDirectSummandPacketChoice_upperBound_example
placeAuditedDirectSummandPacketChoice_nonarchPlaces_example
placeAuditedDirectSummandPacketChoice_archPlaces_example
```

### Remaining Gap

The next step should define how these place-audited choices behave under the
refined indeterminacy steps, especially whether `(Ind2)` and `(Ind3)` preserve
or update the place-family compatibility audit.

## 21. Place-Audited Indeterminacy Steps

### Goal

We added refined `(Ind1)`, `(Ind2)`, and `(Ind3)` step wrappers for
place-audited choices.

### Lean/API Check

Inside:

```text
IUTStage1PlaceAuditedDirectSummandPacketChoice
```

the new step records are:

```text
ProcessionAutomorphismStep
LocalTensorDirectSummandActionStep
UpperSemiCompatibilityStep
```

Each carries:

```text
choice_step
place_family_compatibility_eq
```

where `choice_step` is the corresponding step on the underlying refined
direct-summand packet choice, and `place_family_compatibility_eq` says that the
place-family audit is preserved.

Lean proves:

```text
ind1_preserves_placeFamilyCompatibility
ind2_preserves_placeFamilyCompatibility
ind3_preserves_placeFamilyCompatibility
ind2_preserves_capsuleTotalLogVolume
```

### Mathematical Point

This gives a clean way to lift refined indeterminacy steps to choices that also
carry a place-family compatibility audit.  The extra audit is not silently
discarded; preserving it is an explicit field of the audited step.

### Trap Avoided

We did not assume every refined step automatically preserves the place-family
audit.  A proof using audited choices must supply the preservation proof as part
of the audited step.

### Toy Check

The source examples now check:

```text
placeAuditedDirectSummandPacketChoice_ind1_preserves_audit_example
placeAuditedDirectSummandPacketChoice_ind2_preserves_audit_example
placeAuditedDirectSummandPacketChoice_ind3_preserves_audit_example
placeAuditedDirectSummandPacketChoice_ind2_preserves_totalLogVolume_example
```

### Remaining Gap

The next step should build a generated indeterminacy relation for the
place-audited choice type and prove that the audit is preserved under generated
relations.

## 22. Generated Relation for Place-Audited Choices

### Goal

We built the generated `(Ind1)/(Ind2)/(Ind3)` relation for place-audited
refined choices.

### Lean/API Check

The audited choice namespace now defines:

```text
indeterminacySourceData
```

with generators:

```text
ProcessionAutomorphismStep
LocalTensorDirectSummandActionStep
UpperSemiCompatibilityStep
```

Lean proves:

```text
generated_preserves_placeFamilyCompatibility
generated_preserves_coric
generated_preserves_upperSemiLogVolumeCompatible
```

### Mathematical Point

The compatibility audit is now stable under the generated closure, provided
each generator step supplies audit preservation.  This is the audited analogue
of the earlier refined generated relation.

### Trap Avoided

The generated preservation theorem is conditional on audited generator steps.
It does not say that every unaudited refined step preserves the place-family
audit automatically.

### Toy Check

The source examples now check:

```text
placeAuditedDirectSummandPacketChoice_generated_preserves_audit_example
placeAuditedDirectSummandPacketChoice_generated_preserves_coric_example
placeAuditedDirectSummandPacketChoice_generated_logVolumeCompatible_example
```

### Remaining Gap

The next refinement should connect place-audited generated relations to
multiradial image invariance, either by projecting to the underlying refined
choice relation or by defining audited image packages directly.

## 23. Audited Coric Image Invariance

### Goal

We connected the generated relation on place-audited choices to multiradial
image invariance.

### Lean/API Check

The new theorem is:

```text
IUTStage1PlaceAuditedDirectSummandPacketChoice.image_invariant_of_coric
```

It states that if a region family indexed by place-audited refined choices
depends only on the underlying choice's coric coordinate, then the region is
invariant under the generated audited `(Ind1)/(Ind2)/(Ind3)` relation.

The proof uses:

```text
generated_preserves_coric
```

for the audited relation.

### Mathematical Point

This is the multiradiality bridge for the audited choice layer.  It says that
adding a place-family compatibility audit does not break the usual coric-based
invariance pattern, provided the audited generator steps preserve the audit.

### Toy Check

The source example now checks:

```text
placeAuditedDirectSummandPacketChoice_image_invariant_of_coric_example
```

### Remaining Gap

The next refinement should package audited multiradial images in the same way
as the unaudited refined source packages.

## 24. Audited Multiradial Image Packages

### Goal

We packaged the audited generated relation into region-valued multiradial image
data, and then into the source-package theta-pilot interface.

### Lean/API Check

The new audited image package is:

```text
IUTStage1PlaceAuditedMultiradialImages
```

It carries:

```text
possibleImages
quotient
quotient_eq_generated
image_invariant
```

The source-package wrapper is:

```text
IUTStage1PlaceAuditedMultiradialThetaImages
```

The main constructors and theorems are:

```text
IUTStage1PlaceAuditedMultiradialImages.ofCoricInvariant
IUTStage1PlaceAuditedMultiradialImages.region_eq_of_related
IUTStage1PlaceAuditedMultiradialImages.quotient_profile
IUTStage1PlaceAuditedMultiradialThetaImages.ofPackageWithCoricInvariant
IUTStage1PlaceAuditedMultiradialThetaImages.region_eq_of_related
IUTStage1PlaceAuditedMultiradialThetaImages.quotient_profile
IUTStage1PlaceAuditedMultiradialThetaImages.union_eq_targetUnion
```

### Mathematical Point

This is the audited analogue of the refined multiradial package built earlier.
The important point is that the image-invariance statement is now indexed by
choices that still carry the place-family compatibility audit.  Thus the path
from Theorem 3.11-style generated indeterminacies to possible theta-pilot
images no longer drops the audit data before reaching the multiradial image
surface.

This matches the part of IUT III, Theorem 3.11 where the `(Ind2)` action is
described at the level of direct summands attached to the places above the
base place, while `(Ind3)` remains tied to the upper semi-compatible
structure.  The formal package still abstracts the genuine arithmetic content,
but it now keeps the correct bookkeeping pressure on the place-indexed
summand layer.

### Trap Avoided

The constructor only produces an audited image package from an explicit
coric-dependence hypothesis for audited choices.  It does not claim that every
source package is automatically multiradial, nor does it identify an unaudited
choice with an audited one.  This is deliberate: the disputed 3.11-to-3.12
step is exactly where an unjustified loss of history or index data would be
dangerous.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialImages_of_coric_example
placeAuditedMultiradialImages_region_eq_example
placeAuditedMultiradialImages_profile_example
placeAuditedMultiradialThetaImages_of_package_example
placeAuditedMultiradialThetaImages_region_eq_example
placeAuditedMultiradialThetaImages_union_eq_example
```

### Remaining Gap

The next step should make the audited package less monolithic by exposing
generator-wise image invariance for the audited `(Ind1)/(Ind2)/(Ind3)` steps.
That will make it easier to inspect exactly which generator is responsible for
which part of the possible-image invariance, and it will help us later isolate
the specific `(Ind2)`/direct-summand issue relevant to Corollary 3.12.

## 25. Generator-Wise Audited Image Invariance

### Goal

We exposed the audited image-invariance theorem one generator at a time for
`(Ind1)`, `(Ind2)`, and `(Ind3)`.

### Lean/API Check

At the audited choice level:

```text
IUTStage1PlaceAuditedDirectSummandPacketChoice.ind1_image_invariant_of_coric
IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_image_invariant_of_coric
IUTStage1PlaceAuditedDirectSummandPacketChoice.ind3_image_invariant_of_coric
```

At the audited multiradial image-package level:

```text
IUTStage1PlaceAuditedMultiradialImages.region_eq_of_ind1_step
IUTStage1PlaceAuditedMultiradialImages.region_eq_of_ind2_step
IUTStage1PlaceAuditedMultiradialImages.region_eq_of_ind3_step
```

At the source-package wrapper level:

```text
IUTStage1PlaceAuditedMultiradialThetaImages.region_eq_of_ind1_step
IUTStage1PlaceAuditedMultiradialThetaImages.region_eq_of_ind2_step
IUTStage1PlaceAuditedMultiradialThetaImages.region_eq_of_ind3_step
```

### Mathematical Point

The previous theorem proved possible-image invariance for the generated
equivalence relation.  That is logically useful, but it hides the individual
source mechanisms.  The new lemmas expose the three generators separately:
procession automorphism, local direct-summand action, and upper
semi-compatibility.

This matters for the 3.11/3.12 dispute because the fragile point is not
"some generated relation preserves the image"; it is whether the local
direct-summand `(Ind2)` mechanism can be transported through the multiradial
construction without collapsing the history that is meant to be forgotten only
in the controlled Hodge-theater sense.  The theorem
`region_eq_of_ind2_step` is therefore a named audit point.

### Trap Avoided

The generator-wise lemmas do not prove any new automatic multiradiality.  They
consume either an explicit coric-dependence hypothesis or an already-built
audited multiradial package.  Thus the `(Ind2)` theorem is visible without
pretending that the hard arithmetic construction of the `(Ind2)` action has
already been supplied.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialImages_ind1_region_eq_example
placeAuditedMultiradialImages_ind2_region_eq_example
placeAuditedMultiradialImages_ind3_region_eq_example
placeAuditedMultiradialThetaImages_ind2_region_eq_example
```

### Remaining Gap

The next mathematical step should refine the audited `(Ind2)` action itself:
instead of treating it as a single direct-summand action with preservation
fields, separate its nonarchimedean `Ism` and archimedean order-two sources at
the place-audited level and prove that both feed the same audited
multiradial-image invariance theorem.

## 26. Audited Nonarchimedean and Archimedean `(Ind2)` Sources

### Goal

We split the audited `(Ind2)` action into the two source mechanisms named in
IUT III, Theorem 3.11: the nonarchimedean `Ism` action and the archimedean
order-two action.

### Lean/API Check

The audited choice namespace now defines:

```text
NonarchimedeanIsmInd2Step
ArchimedeanOrderTwoInd2Step
nonarchimedeanIsm_toDirectSummandActionStep
archimedeanOrderTwo_toDirectSummandActionStep
nonarchimedeanIsm_preserves_placeFamilyCompatibility
archimedeanOrderTwo_preserves_placeFamilyCompatibility
nonarchimedeanIsm_preserves_capsuleTotalLogVolume
archimedeanOrderTwo_preserves_capsuleTotalLogVolume
nonarchimedeanIsm_image_invariant_of_coric
archimedeanOrderTwo_image_invariant_of_coric
```

The audited multiradial image package exposes:

```text
region_eq_of_nonarchimedeanIsm_step
region_eq_of_archimedeanOrderTwo_step
```

and the same two accessors exist on the audited source-package theta-image
wrapper.

### Mathematical Point

This is the first audited version of the local `(Ind2)` split.  Earlier, the
nonarchimedean and archimedean mechanisms existed for direct-summand packet
choices, but the place-family audit layer saw only a single broad
`LocalTensorDirectSummandActionStep`.  We now keep the two cases separate after
adding the audit.

This is important because Theorem 3.11 distinguishes independent copies of
`Ism` at nonarchimedean places from order-two automorphisms at archimedean
places, both acting on direct summands.  The formalization now has named Lean
endpoints where each case reaches multiradial image invariance without losing
the place-family compatibility certificate.

### Trap Avoided

The split does not assert that nonarchimedean and archimedean actions are the
same phenomenon.  Each has its own audited source step and is merely converted
to the common direct-summand `(Ind2)` step when we need the already-proved
image-invariance theorem.  This keeps the common proof path visible without
collapsing the two local cases.

### Toy Check

The source examples now check:

```text
placeAuditedNonarchimedeanIsm_to_ind2_example
placeAuditedArchimedeanOrderTwo_to_ind2_example
placeAuditedNonarchimedeanIsm_preserves_totalLogVolume_example
placeAuditedArchimedeanOrderTwo_preserves_totalLogVolume_example
placeAuditedMultiradialImages_nonarchimedeanIsm_region_eq_example
placeAuditedMultiradialImages_archimedeanOrderTwo_region_eq_example
placeAuditedMultiradialThetaImages_nonarchimedeanIsm_region_eq_example
placeAuditedMultiradialThetaImages_archimedeanOrderTwo_region_eq_example
```

### Remaining Gap

The next refinement should connect these audited local `(Ind2)` source steps to
the place-family action entries themselves.  At present the source step says
that an action exists on the relevant summand family; it does not yet point to
the corresponding audited action entry in the nonarchimedean or archimedean
place list.

## 27. Self-Audit: Theorem 3.11 `(Ind2)` Alignment

### Source Check

I reread the local Theorem 3.11 passage in IUT III around the definition of
`(Ind1)` and `(Ind2)`, and the Corollary 3.12 proof passage where the
multiradial representation is regarded as subject to `(Ind1)`, `(Ind2)`, and
`(Ind3)`.

The relevant source pressure is:

```text
Ind1: automorphisms of the procession of D-prime-strips
Ind2, nonarchimedean: independent copies of Ism
Ind2, archimedean: order-two automorphisms
Ind2 acts on direct summands of the tensor product defining the local IQ object
direct-summand count is tied to the places above the base place
Corollary 3.12 uses possible images and holomorphic hulls subject to Ind1/2/3
```

### Lean Alignment

The current audited layer now matches this much of the source shape:

```text
ProcessionAutomorphismStep
LocalTensorDirectSummandActionStep
NonarchimedeanIsmInd2Step
ArchimedeanOrderTwoInd2Step
UpperSemiCompatibilityStep
IUTStage1PlaceAuditedMultiradialImages
IUTStage1PlaceAuditedMultiradialThetaImages
```

The direct-summand/capsule count equality is already typed in the local tensor
packet layer, and the place-family audit carries separate nonarchimedean and
archimedean place lists aligned with the upper-semi state.

### Main Remaining Mismatch

The nonarchimedean and archimedean audited `(Ind2)` source steps still contain
existential action fields inherited from the unaudited layer.  They do not yet
identify a concrete action entry in:

```text
IUTStage1Ind2PlaceFamilyActionData.nonarchimedeanActions
IUTStage1Ind2PlaceFamilyActionData.archimedeanActions
```

Thus the formalization currently says "there exists the right kind of local
action and the audit is preserved", but it does not yet say "this action is one
of the place-indexed actions carried by the audit".

### Next Step

Introduce audited local action-entry steps that point to an entry in the
place-family action data, then derive the existing audited
`NonarchimedeanIsmInd2Step` and `ArchimedeanOrderTwoInd2Step` from those
entry-based steps.  This should make the "direct summands over places above
`vQ`" requirement more concrete.

## 28. Entry-Based Audited `(Ind2)` Steps

### Goal

We connected the audited nonarchimedean and archimedean `(Ind2)` source steps
to entries in the audited place-family action lists.

### Lean/API Check

The audited choice namespace now defines entry-based data structures:

```text
NonarchimedeanIsmActionEntryStep
ArchimedeanOrderTwoActionEntryStep
```

They descend to the source-specific audited `(Ind2)` steps:

```text
nonarchimedeanEntry_toNonarchimedeanIsmStep
archimedeanEntry_toArchimedeanOrderTwoStep
```

and then to the common direct-summand `(Ind2)` step:

```text
nonarchimedeanEntry_toDirectSummandActionStep
archimedeanEntry_toDirectSummandActionStep
```

The entry place is now linked to both sides of the audit:

```text
nonarchimedeanEntry_place_mem_ind2Actions
archimedeanEntry_place_mem_ind2Actions
nonarchimedeanEntry_place_mem_upperSemi
archimedeanEntry_place_mem_upperSemi
```

The image packages expose:

```text
region_eq_of_nonarchimedeanEntry_step
region_eq_of_archimedeanEntry_step
```

### Mathematical Point

The previous audited source steps said that an appropriate local `(Ind2)` action
exists and that the place-family audit is preserved.  This new layer remembers
which action entry in the audited nonarchimedean or archimedean action list is
being used.  Lean also proves that the entry's place appears in the
corresponding upper-semi place list via the compatibility audit.

This is closer to the Theorem 3.11 statement that the local `(Ind2)` actions
occur place-by-place over `vQ`: the formal step now ties a local action to the
audited place-family surface instead of leaving it as an unlocated existential.

### Trap Avoided

The entry-based records are data-carrying structures, not `Prop`, because they
contain an actual action entry.  Lean rejected the first attempt to make them
`Prop`; that was the correct failure mode.  Keeping these records in `Type`
prevents proof irrelevance from erasing the entry we are trying to audit.

The current layer still does not derive the arithmetic action from list
membership alone.  It requires an explicit source step and a matching-action
witness.  This avoids overstating what our abstract place-family entries prove.

### Toy Check

The source examples now check:

```text
placeAuditedNonarchimedeanEntry_to_ism_example
placeAuditedArchimedeanEntry_to_orderTwo_example
placeAuditedNonarchimedeanEntry_place_mem_upperSemi_example
placeAuditedArchimedeanEntry_place_mem_upperSemi_example
placeAuditedNonarchimedeanEntry_preserves_totalLogVolume_example
placeAuditedArchimedeanEntry_preserves_totalLogVolume_example
placeAuditedMultiradialImages_nonarchimedeanEntry_region_eq_example
placeAuditedMultiradialImages_archimedeanEntry_region_eq_example
placeAuditedMultiradialThetaImages_nonarchimedeanEntry_region_eq_example
placeAuditedMultiradialThetaImages_archimedeanEntry_region_eq_example
```

### Remaining Gap

The matching-action witness is still a compatibility field, not a constructed
transport of the action entry across an equality of direct-summand families.
The next serious refinement is to make the action-entry family and the choice's
local summand family share a common typed source, reducing the need for this
extra witness.

## 29. Direct-Summand Count Audit

### Goal

We added an audited count statement corresponding to the Theorem 3.11 sentence
that the number of direct summands is the number of places above the base
place.

### Lean/API Check

The place-family action data now has:

```text
IUTStage1Ind2PlaceFamilyActionData.actionCountForKind
actionCountForKind_nonarchimedean
actionCountForKind_archimedean
```

The audited choice namespace now has:

```text
DirectSummandPlaceCountAudit
```

with theorems:

```text
capsuleCount_eq_actionCount
nonarchimedean_directSummandCount_eq
archimedean_directSummandCount_eq
```

### Mathematical Point

The source text says that the cardinality of the direct-summand collection is
the cardinality of the set of places over `vQ`.  We do not yet have the full
arithmetic set of places over `vQ`; in this Stage 1 abstraction, the closest
typed substitute is the audited list of local `(Ind2)` action entries of the
appropriate place kind.

Thus `DirectSummandPlaceCountAudit` records the exact count obligation at the
current abstraction layer:

```text
directSummandCount = number of audited action entries of this kind
```

Since the local tensor packet already records
`directSummandCount = capsuleCount`, Lean also derives:

```text
capsuleCount = number of audited action entries of this kind
```

### Trap Avoided

This does not identify the action-entry list with the actual arithmetic fiber
`{v | v lies over vQ}`.  It records a count audit against our present typed
proxy for that fiber.  A later layer must replace or justify this proxy by
formalizing the actual place map and fiber.

### Toy Check

The source examples now check:

```text
ind2PlaceFamily_actionCountForKind_example
ind2PlaceFamily_nonarchimedean_actionCountForKind_example
ind2PlaceFamily_archimedean_actionCountForKind_example
directSummandPlaceCountAudit_capsuleCount_eq_actionCount_example
directSummandPlaceCountAudit_nonarchimedean_count_example
directSummandPlaceCountAudit_archimedean_count_example
```

### Remaining Gap

The next step should introduce an explicit typed place-fiber object for the
places above `vQ`, then compare the audited action-entry lists to that fiber.
Only then will this count audit stop depending on the action-entry list as a
proxy for the place fiber.

## 30. Typed Place Fibers over `vQ`

### Goal

We introduced an explicit typed place-fiber object for the places above a base
place `vQ`, and connected it to the audited `(Ind2)` action lists.

### Lean/API Check

The new typed place objects are:

```text
IUTStage1BasePlaceId
IUTStage1PlaceFiber
IUTStage1PlaceFiber.cardinality
```

The new audits are:

```text
IUTStage1NonarchimedeanInd2PlaceFiberAudit
IUTStage1ArchimedeanInd2PlaceFiberAudit
```

They prove:

```text
IUTStage1NonarchimedeanInd2PlaceFiberAudit.actionCount_eq_fiberCardinality
IUTStage1ArchimedeanInd2PlaceFiberAudit.actionCount_eq_fiberCardinality
```

Together with `DirectSummandPlaceCountAudit`, Lean derives:

```text
nonarchimedean_directSummandCount_eq_fiberCardinality
archimedean_directSummandCount_eq_fiberCardinality
```

### Mathematical Point

This is a closer formal counterpart to the Theorem 3.11 statement that the
direct-summand collection has cardinality equal to the set of places above
`vQ`.  We now have a typed object for that fiber and separate audits identifying
the nonarchimedean and archimedean `(Ind2)` action-place lists with the fiber's
place list.

The resulting proof path is:

```text
directSummandCount
= action-entry count of the relevant kind
= cardinality of the audited place fiber over vQ
```

### Trap Avoided

The place fiber is still an abstract list of typed place identifiers.  We have
not yet constructed it from a genuine morphism of arithmetic curves or from a
global set of valuations.  This is intentionally recorded as an audit object,
not hidden as definitional equality.

### Toy Check

The source examples now check:

```text
placeFiber_cardinality_example
placeFiber_cardinality_eq_length_example
nonarchimedeanPlaceFiberAudit_count_example
archimedeanPlaceFiberAudit_count_example
directSummandPlaceCountAudit_nonarchimedean_fiber_count_example
directSummandPlaceCountAudit_archimedean_fiber_count_example
```

### Remaining Gap

The next refinement should connect entry-based `(Ind2)` action steps to a
chosen place fiber, so that a local action entry is not only in the action list
and upper-semi list, but also in the explicit fiber over `vQ`.

## 31. Entry Places Lie in the Typed Fiber

### Goal

We connected entry-based audited `(Ind2)` steps to the explicit place fiber
over `vQ`.

### Lean/API Check

The audited choice namespace now proves:

```text
nonarchimedeanEntry_place_mem_fiber
archimedeanEntry_place_mem_fiber
```

These take an entry-based local `(Ind2)` step and a corresponding place-fiber
audit, and conclude that the action entry's place lies in the fiber's place
list.

### Mathematical Point

The local action entry is now traceable through three surfaces:

```text
audited Ind2 action list
upper-semi place list
explicit fiber of places over vQ
```

This is still abstract, but it gives the Lean development a named route from a
single local `(Ind2)` action to the fiber-count statement in Theorem 3.11.

### Trap Avoided

The proof uses the explicit fiber audit.  It does not infer fiber membership
from a label match or from the existence of a local action alone.

### Toy Check

The source examples now check:

```text
placeAuditedNonarchimedeanEntry_place_mem_fiber_example
placeAuditedArchimedeanEntry_place_mem_fiber_example
```

### Remaining Gap

We still need a common package that carries an audited choice, its direct
summand count audit, and its place-fiber audit together.  That package should
be the next target for source-facing Theorem 3.11 `(Ind2)` obligations.

## 32. Source-Facing `(Ind2)` Fiber Packages

### Goal

We packaged the count audit and place-fiber audit for an audited choice into
single nonarchimedean and archimedean `(Ind2)` fiber objects.

### Lean/API Check

The audited choice namespace now defines:

```text
NonarchimedeanInd2FiberPackage
ArchimedeanInd2FiberPackage
```

Each package exposes:

```text
directSummandCount_eq_fiberCardinality
capsuleCount_eq_fiberCardinality
entry_place_mem_fiber
```

### Mathematical Point

This gives the local `(Ind2)` side a single source-facing object that records:

```text
direct-summand count audit
place-fiber audit over vQ
membership of local action entries in that fiber
```

This is useful because Theorem 3.11 uses all of these facts together: the
action is local and place-indexed, the action is on direct summands, and the
direct-summand collection has the cardinality of the place fiber.

### Trap Avoided

The package is still an audit object.  It does not construct the fiber from
global valuation theory and does not construct `Ism` or order-two actions.
It only prevents later code from forgetting that the count and fiber evidence
must travel with the audited local `(Ind2)` choice.

### Toy Check

The source examples now check:

```text
nonarchimedeanInd2FiberPackage_directSummandCount_example
nonarchimedeanInd2FiberPackage_capsuleCount_example
archimedeanInd2FiberPackage_directSummandCount_example
archimedeanInd2FiberPackage_capsuleCount_example
nonarchimedeanInd2FiberPackage_entry_place_mem_fiber_example
archimedeanInd2FiberPackage_entry_place_mem_fiber_example
```

### Remaining Gap

The next step should thread these packages into entry-based image invariance,
so that a local `(Ind2)` entry can carry fiber membership and still land in the
audited multiradial possible-image equality.

## 33. Fiber-Aware Entry Image Invariance

### Goal

We threaded the `(Ind2)` fiber packages into entry-based multiradial image
invariance.

### Lean/API Check

The audited image package now proves:

```text
region_eq_and_fiber_mem_of_nonarchimedeanEntry_step
region_eq_and_fiber_mem_of_archimedeanEntry_step
```

The audited source-package theta-image wrapper exposes the same two theorems.

Each theorem returns both:

```text
possible-image region equality
action-entry place membership in the explicit fiber over vQ
```

### Mathematical Point

The local `(Ind2)` entry is now carried all the way to the multiradial image
surface without dropping its place-fiber evidence.  This is the kind of
bookkeeping we need near the Theorem 3.11 to Corollary 3.12 boundary: image
invariance and the source-local place indexing should remain visible together.

### Trap Avoided

The theorem returns a conjunction rather than building a new quotient relation.
This keeps the quotient structure unchanged and only augments the theorem with
the extra place-fiber evidence needed for auditing.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialImages_nonarchimedeanEntry_region_fiber_example
placeAuditedMultiradialImages_archimedeanEntry_region_fiber_example
placeAuditedMultiradialThetaImages_nonarchimedeanEntry_region_fiber_example
placeAuditedMultiradialThetaImages_archimedeanEntry_region_fiber_example
```

### Remaining Gap

The current equality is still region-valued.  The next major mathematical
pressure point is to connect these audited possible-image equalities to the
holomorphic hull and log-volume side used in Corollary 3.12.

## 34. Place-Audited Multiradial Hull Endpoint

### Goal

We connected the place-audited multiradial theta-image package to the existing
hull+det endpoint for the Corollary 3.12 comparison route.

### Lean/API Check

The source package namespace now defines:

```text
PlaceAuditedMultiradialThetaHullEndpoint
auditedPlaceAuditedMultiradialThetaHullEndpoint
```

The endpoint exposes:

```text
corollary312Endpoint
auditedUnion_subset_hull
auditedUnion_eq_possibleImagesUnion
determinantVolumeBound
region_eq_of_related
multiradialOutputMatchesPackage
```

### Mathematical Point

The audited `(Ind2)` bookkeeping now reaches the same hull+det boundary as the
older generic multiradial image package.  This matters because Corollary 3.12 is
not merely a statement about region equality under indeterminacies; it uses the
union of possible images, its holomorphic hull, and a determinant/log-volume
bound.

The new endpoint keeps the place-audited image package attached while proving:

```text
audited possible-image union = endpoint possible-image union
audited possible-image union is contained in the hull
the determinant/log-volume bound is available
the final signed Corollary 3.12 inequality is available from the obligations
```

### Trap Avoided

This does not prove the hull+det obligations from the audited `(Ind2)` data.
It only shows that once the existing hull+det obligations are supplied, the
audited multiradial images can be carried into that endpoint without being
forgotten.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_of_images_example
placeAuditedMultiradialThetaHullEndpoint_corollary_example
placeAuditedMultiradialThetaHullEndpoint_union_subset_hull_example
placeAuditedMultiradialThetaHullEndpoint_region_eq_related_example
```

### Remaining Gap

The next refinement should combine the fiber-aware entry image theorem with
this hull endpoint, so a single local `(Ind2)` entry carries both its fiber
membership and its audited image equality at the hull boundary.

## 35. Fiber-Aware Entry Invariance at the Hull Boundary

### Goal

We exposed the fiber-aware entry image theorem directly on the place-audited
multiradial hull endpoint.

### Lean/API Check

The endpoint now proves:

```text
nonarchimedeanEntry_region_eq_and_fiber_mem
archimedeanEntry_region_eq_and_fiber_mem
```

These are endpoint-level versions of the image-package theorems.  They return
both the audited region equality and the action-entry place's membership in the
explicit fiber over `vQ`.

### Mathematical Point

This keeps the local `(Ind2)` bookkeeping visible exactly where the hull and
determinant/log-volume data enter the Corollary 3.12 route.  A later proof that
uses the hull endpoint can no longer cite only the final inequality while
silently dropping the local place-fiber information.

### Trap Avoided

The theorem does not derive any new hull containment or determinant bound from
the `(Ind2)` entry.  It simply keeps the already-proved entry invariance and
fiber membership attached to the audited hull endpoint.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_nonarchimedeanEntry_example
placeAuditedMultiradialThetaHullEndpoint_archimedeanEntry_example
```

### Remaining Gap

The next global audit should re-read the Corollary 3.12 proof steps around the
holomorphic hull and procession-normalized log-volume to decide whether the
next formal object should be a hull-volume audit, a procession-normalization
audit, or a log-Kummer compatibility audit.

## 36. Self-Audit: Corollary 3.12 Hull and Log-Volume Boundary

### Source Check

I reread the Corollary 3.12 proof discussion around Steps (i)--(x), especially
the summary in Step (x).  The source pressure there is different from the local
`(Ind2)` bookkeeping we just formalized.

The relevant points are:

```text
the proof concentrates on a single Theta-link
the unit and value-group portions must be related simultaneously
the multiradial representation is subject to Ind1, Ind2, Ind3
procession-normalized log-volumes are invariant under Ind1 and Ind2
Ind3 is converted into an upper inequality
log-link compatibility is needed for the log-volumes
the final comparison lives in real-valued log-volumes
```

I also checked the Scholze-Stix discussion of the same critical step.  Their
emphasis is on consistently identifying the various ordered one-dimensional
real vector spaces or copies of real numbers attached to abstract and concrete
pilot objects across Hodge theaters.

### Current Lean Alignment

The current Lean state has:

```text
place-audited Ind2 source and entry/fiber bookkeeping
audited image invariance for Ind1/Ind2/Ind3-generated relations
audited possible-image unions connected to the hull endpoint
determinant/log-volume bound available from hull-det obligations
final signed Corollary 3.12 inequality available from obligations
```

This means the local direct-summand/action/fiber bookkeeping now reaches the
same endpoint as the earlier hull+det route.

### Main Remaining Mismatch

The next unresolved point is not local `(Ind2)` structure.  It is the boundary
where a region/hull statement becomes a real-valued log-volume statement.
In particular, we need to keep explicit:

```text
which real/log-volume chart is being used
which normalization is procession-normalized
which invariances are equalities under Ind1/Ind2
which part is an upper inequality from Ind3
```

This is also the place where the Scholze-Stix concern about identifying real
lines has to be represented as typed data rather than informal notation.

### Next Step

Add a hull-endpoint log-volume chart audit: a small structure attached to the
place-audited hull endpoint that records the target signed real, the theta
signed real, the chart compatibility, and the determinant/hull bound used to
obtain the upper estimate.  It should not prove new arithmetic content; it
should make the real-line/log-volume identifications explicit at the endpoint.

## 37. Hull-Endpoint Log-Volume Chart Audit

### Goal

We attached an explicit signed-real/log-volume chart audit to the
place-audited multiradial hull endpoint.

### Lean/API Check

The endpoint namespace now defines:

```text
LogVolumeChartAudit
logVolumeChartAudit
```

The audit records:

```text
q_charted
theta_charted
target_signed_eq_chosen_volume
q_signed_le_target
target_signed_le_theta
q_signed_le_theta
determinant_volume_bound
corollary312_endpoint
```

and exposes accessors:

```text
qCharted
thetaCharted
targetSigned_eq_chosenVolume
qSigned_le_thetaSigned
corollary312Endpoint
```

### Mathematical Point

This is a typed bookkeeping response to the Corollary 3.12 boundary.  The
endpoint already had the final inequality, but now the route records the real
chart equalities and the intermediate signed target-volume inequality at the
same place as the audited possible-image/hull data.

This is also where the Scholze-Stix real-line-identification concern begins to
touch the formalization: the chart equalities are explicit theorem fields rather
than implicit notation.

### Trap Avoided

The audit is proof-valued and contains no new arithmetic data.  It does not
collapse the source and target Hodge-theater histories; it only records which
charted real values the endpoint is using.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolumeChartAudit_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_q_charted_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_q_le_theta_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_corollary_example
```

### Remaining Gap

The next refinement should split the log-volume chart audit into its equality
part `(Ind1)/(Ind2)` and inequality part `(Ind3)`, matching the Step (x)
description that log-volumes are invariant under `(Ind1)/(Ind2)` while `(Ind3)`
is converted into an upper inequality.

## 38. Split Log-Volume Chart Audit

### Goal

We split the hull-endpoint log-volume chart audit into the two pieces suggested
by Step (x) of the Corollary 3.12 proof.

### Lean/API Check

Inside `LogVolumeChartAudit`, the new subrecords are:

```text
Ind12EqualityPart
Ind3UpperInequalityPart
```

with constructors:

```text
ind12EqualityPart
ind3UpperInequalityPart
```

The equality part carries the chart identifications and the q-to-target lower
side.  The upper-inequality part carries:

```text
target_signed_le_theta
determinant_volume_bound
```

### Mathematical Point

This reflects the source phrasing that the procession-normalized log-volumes
are invariant under `(Ind1)` and `(Ind2)`, while `(Ind3)` is converted into an
upper inequality.  At this stage the formalization does not prove that analytic
claim; it makes the split visible in the endpoint API.

### Trap Avoided

We did not collapse the whole real comparison into a single anonymous
`q <= theta` proof.  Downstream code can now inspect which part is chart/equality
data and which part is upper-bound data.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_part_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_ind3_part_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_q_le_target_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_ind3_target_le_theta_example
```

### Remaining Gap

The split is still fed by existing source obligations.  A later refinement
should connect `Ind12EqualityPart` to explicit `(Ind1)/(Ind2)` invariance of
procession-normalized log-volumes, not only to chart equalities.

## 39. Procession-Normalized `(Ind1)/(Ind2)` Log-Volume Audit

### Goal

We connected the `(Ind1)/(Ind2)` equality part of the hull log audit to
explicit invariance of procession-normalized local log-volumes.

### Lean/API Check

At the direct-summand packet choice level, Lean now proves:

```text
IUTStage1DirectSummandPacketTheorem311Choice.ind2_preserves_capsuleNormalizedLogVolume
```

At the place-audited choice level, Lean now proves:

```text
ind1_preserves_capsuleNormalizedLogVolume
ind2_preserves_capsuleNormalizedLogVolume
```

Inside `LogVolumeChartAudit`, the new subaudit is:

```text
ProcessionNormalizedInd12Audit
processionNormalizedInd12Audit
```

It contains the existing `Ind12EqualityPart` together with explicit normalized
log-volume invariance under audited `(Ind1)` and `(Ind2)` steps.

### Mathematical Point

This is a closer formal counterpart to the Step (x) assertion that
procession-normalized mono-analytic log-volumes are invariant with respect to
`(Ind1)` and `(Ind2)`.  In the current abstraction, the relevant
procession-normalized value is represented by the packet capsule family's
`normalizedLogVolume`.

For `(Ind1)`, invariance follows because the audited procession-automorphism
step preserves the local tensor state.  For `(Ind2)`, invariance follows from
the direct-summand action inducing a capsule-family action that preserves the
normalized log-volume.

### Trap Avoided

The audit does not claim anything about `(Ind3)`.  The upper-inequality part
remains separate in `Ind3UpperInequalityPart`.  This keeps the source
distinction between equality/invariance under `(Ind1)/(Ind2)` and the
one-sided `(Ind3)` effect visible in Lean.

### Toy Check

The source examples now check:

```text
placeAuditedDirectSummandPacketChoice_ind1_preserves_normalizedLogVolume_example
placeAuditedDirectSummandPacketChoice_ind2_preserves_normalizedLogVolume_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_normalized_audit_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_ind1_normalized_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_ind2_normalized_example
```

### Remaining Gap

The normalized log-volume is still the local capsule-family value.  A later
refinement should aggregate these local normalized values into the full
procession-normalized average over `j ∈ F_l` used in Corollary 3.12.

## 40. Label-Averaged Procession Log-Volumes

### Goal

We introduced an abstract finite-label average for procession-normalized
log-volumes, corresponding to the average over `j ∈ F_l` in Corollary 3.12.

### Lean/API Check

The new structure is:

```text
IUTStage1LabelAveragedProcessionLogVolume
```

It is indexed by an arbitrary finite label type:

```text
label : Type u
[Fintype label]
```

and carries:

```text
normalizedLogVolume : label -> Real
averageLogVolume : Real
average_eq :
  averageLogVolume =
    (Finset.univ.sum normalizedLogVolume) / (Fintype.card label : Real)
```

Lean also proves:

```text
average_eq_formula
average_eq_of_pointwise
```

The second theorem says that pointwise equality of the normalized log-volume
function implies equality of the averaged procession log-volume.

### Mathematical Point

This is the first Stage 1 object that models the source phrase "where the
average is taken over `j ∈ F_l`" without yet choosing the concrete `ZMod l`
label model from the foundations layer.  It gives us a target for lifting the
local `(Ind1)/(Ind2)` normalized-log-volume invariance to the averaged
Corollary 3.12 quantity.

### Trap Avoided

We did not hard-wire `ZMod l` into the Stage 1 source layer.  The foundations
module already contains concrete `ZMod l` label/torsor data, but the current
Stage 1 route only needs finiteness of the label set.  This keeps the API
generic until a later milestone explicitly connects it to `F_l`.

### Toy Check

The source examples now check:

```text
labelAveragedProcessionLogVolume_average_example
labelAveragedProcessionLogVolume_average_eq_example
labelAveragedProcessionLogVolume_average_eq_of_pointwise_example
```

### Remaining Gap

The next step should combine `ProcessionNormalizedInd12Audit` with
`IUTStage1LabelAveragedProcessionLogVolume`, proving averaged invariance under
`(Ind1)` and `(Ind2)` from pointwise label-wise invariance.

## 41. Label-Averaged `(Ind1)/(Ind2)` Invariance

### Goal

We connected the local `(Ind1)/(Ind2)` log-volume audit to label-averaged
procession log-volumes.

### Lean/API Check

Inside `LogVolumeChartAudit`, the new source-facing audit is:

```text
LabelAveragedInd12Audit
```

It carries:

```text
normalized_audit : ProcessionNormalizedInd12Audit
averagedLogVolume :
  audited choice -> IUTStage1LabelAveragedProcessionLogVolume label
ind1_labelwise_eq
ind2_labelwise_eq
```

Lean proves:

```text
ind1AverageLogVolumeEq
ind2AverageLogVolumeEq
localNormalizedAudit
```

### Mathematical Point

This bridges the local normalized-log-volume equality to the average over a
finite label set.  The proof is exactly the finite-sum argument: if the
label-wise normalized values agree for every label, then their averages agree.

This mirrors the Corollary 3.12 use of procession-normalized averages over
`j ∈ F_l`, while still leaving the concrete `F_l` model as a later refinement.

### Trap Avoided

The audit requires explicit label-wise equality hypotheses.  It does not infer
averaged invariance merely from a single unindexed local equality, since the
Corollary 3.12 average ranges over label-indexed theta values.

### Toy Check

The source examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_label_ind1_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_label_ind2_average_example
```

### Remaining Gap

The next refinement should instantiate the abstract finite label type with the
existing `ZMod l`/`F_l` label model in the foundations layer, or introduce a
bridge object that records when a finite label type represents that `F_l` label
set.

## 42. `F_l` Label Model Bridge

### Goal

We connected the abstract finite label average to the current foundations-layer
model of the `F_l` label set.

### Lean/API Check

The source layer now imports `Iut.Foundations.InitialThetaData` and introduces:

```text
IUTStage1FLLabelModel label
```

It records:

```text
prime : PrimeGeFive
labelEquiv : label ≃ ZMod prime.value
```

Lean also checks the canonical model:

```text
IUTStage1FLLabelModel.zmod
```

and the carrier cardinality theorem:

```text
IUTStage1FLLabelModel.card_eq_primeValue
```

The log-volume endpoint audit now has an `F_l`-labelled wrapper:

```text
FLLabelAveragedInd12Audit
```

It packages:

```text
label_model : IUTStage1FLLabelModel label
averaged_audit : LabelAveragedInd12Audit label
```

with delegated checked accessors:

```text
labelCard_eq_primeValue
localNormalizedAudit
ind1AverageLogVolumeEq
ind2AverageLogVolumeEq
```

### Mathematical Point

This is the first formal link between the Corollary 3.12 phrase "average over
`j ∈ F_l`" and the concrete `ZMod l.value` model already present in the
foundational theta-data file.  The bridge says that the labels used for the
average are identified with `ZMod l.value`, where `l` is prime and at least
five.

This remains deliberately weaker than the full label-cusp package in the
papers: it is a carrier-level bridge, not yet a proof that the averaged
log-volume family respects the additive torsor, unit action, sign quotient, or
cuspidal synchronization data.

### Trap Avoided

We did not replace the generic averaged log-volume object by a hard-coded
`ZMod l.value` object.  Instead, we attached `F_l` evidence only when the audit
needs to assert that a given finite label type is the `F_l` model.  This keeps
transport along equivalent finite label carriers explicit, which matters for
the overall anti-collapse discipline around cross-theater identifications.

### Lean Note

Mathlib provides `Fintype (ZMod n)` under a `NeZero n` instance.  Since
`PrimeGeFive` implies `l.value ≠ 0`, the cardinality theorem introduces that
instance locally before using `ZMod.card`.

### Toy Check

The examples now check:

```text
flLabelModel_zmod_example
flLabelModel_card_eq_primeValue_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_label_card_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_label_ind1_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_label_ind2_average_example
```

### Remaining Gap

The next refinement should use the existing `zmodLabelAdditiveTorsorData` and
translation lemmas from `InitialThetaData` to state that the `F_l` label model is
not merely equivalent to `ZMod l.value`, but carries the intended additive
torsor action.  That is the next step toward making the label average compatible
with the theta/cusp label structures rather than just the finite carrier.

## 43. Additive `F_l` Label Torsor Bridge

### Goal

We strengthened the `F_l` label bridge from a finite carrier identification to
an additive torsor model.

### Lean/API Check

The new source object is:

```text
IUTStage1FLLabelTorsorModel label
```

It carries:

```text
label_model : IUTStage1FLLabelModel label
torsor : AdditiveTorsorData (ZMod label_model.prime.value) label
torsor_vadd_eq_zmod :
  torsor.vadd t j =
    label_model.fromZMod (t + label_model.toZMod j)
```

Lean checks the canonical foundations model:

```text
IUTStage1FLLabelTorsorModel.zmod
```

using:

```text
zmodLabelAdditiveTorsorData
zmodLabelTranslate
```

and exposes the torsor laws:

```text
zero_vadd
add_vadd
exists_unique_vadd_eq
vadd_eq_zmod
zmod_vadd_eq_translate
```

The log-volume endpoint now also has:

```text
FLLabelTorsorAveragedInd12Audit
```

which packages the torsor-refined label model with the already checked
label-averaged `(Ind1)/(Ind2)` audit.

### Mathematical Point

The previous milestone only said that the labels in the average are equivalent
to `ZMod l.value`.  This milestone adds the additive translation structure on
those labels.  That is closer to the label/cusp structures in the source
papers, where the `F_l` labels are not just a finite set but carry translation
behavior used in synchronizing label data.

The transported action is intentionally explicit:

```text
t • j = fromZMod (t + toZMod j)
```

Thus every use of the additive label action must pass through the chosen
`F_l` model, rather than silently identifying all copies of `ZMod l`.

### Trap Avoided

This does not identify Hodge theaters, log-volume real lines, or theta data.  It
only states the additive label action on a chosen label carrier.  The averaged
log-volume invariance under `(Ind1)/(Ind2)` is still supplied by the existing
label-wise equality audit; the torsor structure is additional label geometry,
not a shortcut to Corollary 3.12.

### Lean Note

The torsor bridge is restricted to `label : Type` because the foundations
`AdditiveTorsorData` currently takes the acting group and carrier in the same
universe, and `ZMod l.value` is a small type.  The endpoint wrappers were made
label-universe-polymorphic so the earlier averaged audit can still be used with
small `ZMod` labels.

### Toy Check

The examples now check:

```text
flLabelTorsorModel_zmod_example
flLabelTorsorModel_zero_vadd_example
flLabelTorsorModel_add_vadd_example
flLabelTorsorModel_zmod_translate_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_torsor_label_vadd_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_torsor_label_ind1_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_torsor_label_ind2_average_example
```

### Remaining Gap

The next label refinement should connect this additive torsor model to the
existing unit action, sign quotient, and local cusp-label data in
`InitialThetaData`.  That is the next needed step before the label side can
claim to reflect the richer theta/cusp labeling apparatus used around the
Theorem 3.11 to Corollary 3.12 transition.

## 44. `F_l` Unit/Sign Label Bridge

### Goal

We connected the Stage 1 label bridge to the foundations-layer unit action and
sign quotient on the canonical `ZMod l` label model.

### Lean/API Check

The new bridge is:

```text
IUTStage1FLZModUnitSignLabelModel l
```

It records:

```text
torsor_model : IUTStage1FLLabelTorsorModel (ZMod l.value)
signUnitCompatibility :
  QuotientSignUnitCompatibility
    (zmodPointedQuotient l) (zmodUnitActionData l) (zmodSignAction l)
signUnitSubgroup : Subgroup (ZMod l.value)ˣ
signUnitSubgroup_smul_eq_self_or_neg
signUnitSubgroup_orbit_iff_signOrbit
```

Lean checks the canonical model:

```text
IUTStage1FLZModUnitSignLabelModel.zmod
```

and exposes:

```text
signUnit_smul_eq_neg
signUnitSubgroup_smul_eq_self_or_neg'
signUnitSubgroup_orbit_iff_signOrbit'
zmod_signUnitSubgroup_orbit_iff_signOrbit
```

### Mathematical Point

The additive label torsor is not the full label-class apparatus.  In the local
label/cusp model, the nonzero labels are also quotiented by the sign action,
and the subgroup `{1,-1}` of `(ZMod l)^×` controls exactly this sign ambiguity.

This milestone formalizes that bridge at the canonical `ZMod l` level:

```text
{1,-1}-orbit = sign orbit
```

and records the compatibility of the unit `-1` with additive negation.

### Trap Avoided

`QuotientUnitActionData` allows an abstract unit type.  A completely generic
unit action cannot automatically consume elements of `(ZMod l)^×`.  The bridge
therefore uses the canonical `zmodUnitActionData l` and `zmodSignAction l`
directly.  This avoids a false abstraction where Lean would appear to accept
unit/sign compatibility without a specified identification of unit groups.

### Toy Check

The examples now check:

```text
flZModUnitSignLabelModel_zmod_example
flZModUnitSignLabelModel_signUnit_example
flZModUnitSignLabelModel_subgroup_self_or_neg_example
flZModUnitSignLabelModel_orbit_iff_signOrbit_example
```

### Remaining Gap

The next step should connect this unit/sign bridge to
`LocalLabCuspModel`/`CuspLabelClassData`, especially the canonical nonzero
label and canonical sign-label class.  After that, the averaged label side will
have a clearer path from finite `F_l` labels to the structured cusp-label data
used in the source papers.

## 45. Canonical Cusp-Label Class Bridge

### Goal

We connected the Stage 1 `F_l` unit/sign label bridge to the foundations
`LocalLabCuspModel` and `CuspLabelClassData`.

### Lean/API Check

The new bridge is:

```text
IUTStage1FLZModCuspLabelClassModel l
```

It packages:

```text
unit_sign_model : IUTStage1FLZModUnitSignLabelModel l
local_lab_cusp_model : LocalLabCuspModel l
local_lab_cusp_model_eq_zmod :
  local_lab_cusp_model = zmodLocalLabCuspModel l
cusp_label_class_data : CuspLabelClassData l
cusp_label_class_data_eq_zmod :
  cusp_label_class_data = zmodCanonicalCuspLabelClassData l
```

Lean checks the canonical constructor:

```text
IUTStage1FLZModCuspLabelClassModel.zmod
```

and exposes:

```text
localLabCuspModel_eq_zmod
cuspLabelClassData_eq_zmod
canonicalLabelTranslate
canonicalSignLabelEq
labelClass_eq_model_quotient
zmod_canonicalSignLabel_eq
zmod_cuspLabelClass_eq_canonical
```

### Mathematical Point

This is the first Stage 1 object that ties the finite `F_l` label model to the
structured local cusp-label data in the foundations layer.  It records that the
canonical nonzero label is obtained by additive translation from the base label,
and that the canonical sign-label class is the sign quotient of this nonzero
label.

This matters for the later Theorem 3.11 to Corollary 3.12 route because the
label averages should eventually be attached to structured label/cusp data, not
just to a finite index set.

### Trap Avoided

The bridge is canonical and `ZMod`-based.  It does not yet assert that every
transported finite label carrier has a transported local cusp model, nor that
the log-volume average has already been indexed by these cusp-label classes.
Those are separate compatibility steps.

### Toy Check

The examples now check:

```text
flZModCuspLabelClassModel_zmod_example
flZModCuspLabelClassModel_local_eq_zmod_example
flZModCuspLabelClassModel_canonical_translate_example
flZModCuspLabelClassModel_canonical_sign_label_example
flZModCuspLabelClassModel_label_class_example
```

### Remaining Gap

The next useful refinement is to connect the label-averaged log-volume audit to
this canonical cusp-label bridge.  Concretely, we should introduce a wrapper
where the label set is `ZMod l.value`, the averaged audit is indexed by those
labels, and the same `l` carries the cusp-label class model.  That will make the
average over `j ∈ F_l` and the local cusp-label structure live in the same
formal package.

## 46. `ZMod l` Cusp-Label Averaged Audit

### Goal

We connected the label-averaged `(Ind1)/(Ind2)` log-volume audit to the
canonical `ZMod l` cusp-label class bridge.

### Lean/API Check

The new endpoint-level wrapper is:

```text
FLZModCuspLabelAveragedInd12Audit
```

It carries:

```text
cusp_label_model : IUTStage1FLZModCuspLabelClassModel l
averaged_audit : LabelAveragedInd12Audit (ZMod l.value)
```

Lean exposes:

```text
labelCard_eq_primeValue
localNormalizedAudit
canonicalLabelTranslate
labelClass_eq_model_quotient
ind1AverageLogVolumeEq
ind2AverageLogVolumeEq
```

We also added:

```text
primeGeFiveValueNeZero
```

as a local Stage 1 instance witnessing `NeZero l.value`, so the finite
`ZMod l.value` model is available whenever `l : PrimeGeFive`.

### Mathematical Point

This is the first checked package where the phrase "average over `j ∈ F_l`" is
not merely represented by an arbitrary finite label type, but by the concrete
`ZMod l.value` carrier tied to the same canonical cusp-label class model.

The result is still conditional in the right way: averaged invariance comes
from the explicit label-wise `(Ind1)/(Ind2)` audit, not from the cusp-label
model by itself.

### Trap Avoided

We did not identify the cusp-label class with the averaged log-volume values.
The wrapper only makes them share the same `l` and the same `ZMod l` label
source.  A future theorem must still specify how theta/cusp labels index the
actual log-volume family.

### Toy Check

The examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_card_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_class_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_ind1_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_ind2_average_example
```

### Remaining Gap

The next refinement should state an explicit compatibility between the
label-indexed normalized log-volume family and the cusp-label class data.  In
other words, the formalization should distinguish "indexed by `ZMod l`" from
"indexed by the cusp labels arising from the local model" and then prove or
assume the precise bridge between those two descriptions.

## 47. Cusp-Compatible `ZMod l` Log-Volume Families

### Goal

We added an explicit compatibility layer between a `ZMod l`-indexed normalized
log-volume family and the nonzero cusp sign-label classes.

### Lean/API Check

The new source object is:

```text
IUTStage1ZModCuspLabelLogVolumeCompatibility l
```

It carries:

```text
normalizedLogVolume : ZMod l.value -> Real
cuspClassLogVolume : (zmodSignAction l).SignLabelQuotient -> Real
zeroLogVolume : Real
nonzero_eq_cuspClass
zero_eq
```

Lean proves:

```text
nonzero_eq
zero_eq_zeroLogVolume
neg_nonzero_eq
```

The endpoint-level wrapper is:

```text
FLZModCuspLabelCompatibleAveragedInd12Audit
```

It packages:

```text
zmod_cusp_audit : FLZModCuspLabelAveragedInd12Audit l
cuspLogVolume :
  audited choice -> IUTStage1ZModCuspLabelLogVolumeCompatibility l
normalizedLogVolume_eq
```

and exposes:

```text
nonzeroAverageLabel_eq_cuspClass
zeroAverageLabel_eq_zeroLogVolume
ind1AverageLogVolumeEq
ind2AverageLogVolumeEq
```

### Mathematical Point

This is a sharper version of the label/cusp bridge.  A normalized log-volume
family indexed by `j : ZMod l.value` is now explicitly related to a family
indexed by sign-label classes for nonzero labels:

```text
normalizedLogVolume j =
  cuspClassLogVolume (sign class of j)    if j ≠ 0
```

The zero label is separated:

```text
normalizedLogVolume 0 = zeroLogVolume
```

This separation is important because the sign-label quotient in the foundations
layer is defined on nonzero labels.

### Trap Avoided

We did not quotient the whole average by sign.  The average is still over
`ZMod l.value`; the sign-label description is an additional compatibility for
nonzero labels.  This avoids silently changing the indexing set of the average.

### Toy Check

The examples now check:

```text
zmodCuspLabelLogVolumeCompatibility_nonzero_example
zmodCuspLabelLogVolumeCompatibility_zero_example
zmodCuspLabelLogVolumeCompatibility_neg_nonzero_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compatible_nonzero_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compatible_zero_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compat_ind1_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compat_ind2_example
```

### Remaining Gap

We still need to connect this cusp-compatible label average to the actual
theta-value side of the source construction.  At present the compatibility is a
typed audit object; a later theorem must explain how the normalized log-volume
family is produced from the theta/cusp data used in Theorem 3.11.

## 48. Theta-Source Bound for Cusp-Compatible Averages

### Goal

We connected the cusp-compatible `ZMod l` label average to the existing
Theta-pilot source side of the Stage 1 package.

### Lean/API Check

The new endpoint-level audit is:

```text
FLZModCuspLabelThetaSourceAudit
```

It carries:

```text
compatible_average :
  FLZModCuspLabelCompatibleAveragedInd12Audit l
theta_images : IUTStage1ThetaPilotPossibleImages package
thetaSourceAverage :
  audited choice -> Real
thetaSourceAverage_eq_average
thetaSourceAverage_le_thetaSigned
```

Lean exposes:

```text
thetaPilotMatchesPackage
indeterminaciesMatchPackage
thetaSourceAverage_eq
averageLogVolume_le_thetaSigned
nonzeroAverageLabel_eq_cuspClass
ind1AverageLogVolumeEq
ind2AverageLogVolumeEq
```

### Mathematical Point

This is the first checked link from the cusp-compatible label average to the
Theta side of the source package.  It says that for each audited choice, the
label average is the corresponding Theta-source average and is bounded above by
the charted Theta signed log-volume:

```text
averageLogVolume <= package.preLedger.thetaSigned
```

The audit also carries `IUTStage1ThetaPilotPossibleImages package`, so the
Theta-pilot and indeterminacy labels remain tied to the source package.

### Trap Avoided

This is not a derivation from the analytic theta construction.  The equality
between the abstract average and the Theta-source average is an explicit audit
field, as is the upper bound by `thetaSigned`.  This keeps the current Lean
state honest: we have formalized the shape of the handoff, not yet the source
proof that supplies it.

### Toy Check

The examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_matches_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_bound_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_ind1_example
```

### Remaining Gap

The next hard step is to relate this Theta-source bounded average to the q-side
pilot/log-volume data and the final signed comparison.  We must keep the
Theta-source upper bound, q-side lower/target bound, and `(Ind3)` upper
semi-compatibility separate so that Corollary 3.12 is not obtained by an
unjustified real-line identification.

## 49. q-Side Comparison to Theta-Source Average

### Goal

We added a q-side comparison audit for the cusp-compatible Theta-source label
average.

### Lean/API Check

The new endpoint-level audit is:

```text
FLZModCuspLabelQThetaComparisonAudit
```

It carries:

```text
theta_source : FLZModCuspLabelThetaSourceAudit l
qPilotLogVolume : QPilotLogVolumeId
qPilotLogVolume_eq_package
qSourceLogVolume : Real
qSourceLogVolume_eq_qSigned
qSourceLogVolume_le_thetaAverage
```

Lean exposes:

```text
qPilotLogVolumeMatchesPackage
qSourceLogVolume_eq
qSigned_le_thetaSourceAverage
qSigned_le_averageLogVolume
qSigned_le_thetaSigned_via_average
averageLogVolume_le_thetaSigned
ind1AverageLogVolumeEq
ind2AverageLogVolumeEq
```

### Mathematical Point

The formal comparison chain now has an explicit audited route:

```text
qSigned = qSourceLogVolume
qSourceLogVolume <= thetaSourceAverage
thetaSourceAverage = label average
label average <= thetaSigned
```

so Lean can derive:

```text
qSigned <= thetaSigned
```

for an audited choice.

### Trap Avoided

This does not identify the q-side and Theta-side constructions by fiat.  The
q-side source real, its equality with `qSigned`, and its comparison to the
Theta-source average are all explicit fields.  This keeps the Scholze-Stix
concern in view: real-line comparisons must be visible and justified, not
silently imported through notation.

### Toy Check

The examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_q_matches_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_q_le_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_q_le_theta_example
```

### Remaining Gap

The next refinement should align this q-to-Theta average comparison with the
existing `LogVolumeChartAudit` endpoint and `(Ind3)` upper-inequality part.  In
particular, we should make clear whether the q-to-average comparison is a new
source obligation or a theorem derivable from the already audited q/target/Theta
charted comparison chain.

## 50. Final Comparison Alignment

### Goal

We aligned the q-to-Theta average route with the existing chart audit endpoint
and the `(Ind3)` upper-inequality part.

### Lean/API Check

The new endpoint-level wrapper is:

```text
FLZModCuspLabelFinalComparisonAudit
```

It carries:

```text
q_theta_comparison : FLZModCuspLabelQThetaComparisonAudit l
ind3_upper_part : Ind3UpperInequalityPart
```

Lean exposes:

```text
qSigned_le_thetaSigned_from_average
qSigned_le_thetaSigned_from_chart
corollary312FromAverage
corollary312FromChart
ind3TargetSigned_le_thetaSigned
determinantVolumeBound
averageLogVolume_le_thetaSigned
```

### Mathematical Point

There are now two visible routes to the final signed comparison:

```text
average route:
qSigned <= thetaSourceAverage = label average <= thetaSigned

chart route:
LogVolumeChartAudit.qSigned_le_thetaSigned
```

The wrapper does not identify these proof routes.  It places them next to each
other so later work can decide whether the q-to-average comparison is an
independent source obligation or should be derived from the existing
q/target/Theta charted chain and `(Ind3)` upper semi-compatibility.

### Trap Avoided

We did not reuse the existing `audit.corollary312Endpoint` to justify the new
average route.  `corollary312FromAverage` is built from
`qSigned_le_thetaSigned_from_average`, while `corollary312FromChart` is the
pre-existing endpoint.  This keeps the debated comparison mechanism inspectable.

### Toy Check

The examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_chart_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_cor312_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_ind3_example
```

### Remaining Gap

The next refinement should try to reduce the q-to-average comparison obligation
against the already available charted q/target/Theta comparison data.  If that
reduction cannot be made without adding a new hypothesis, that gap is
mathematically significant and should be recorded as a candidate pressure point
near the Theorem 3.11 to Corollary 3.12 transition.

## 51. Reducing q-to-Average to Target-to-Average

### Goal

We reduced the q-to-Theta-average comparison obligation to a target-to-average
bound plus the existing charted q-to-target inequality.

### Lean/API Check

The new endpoint-level audit is:

```text
FLZModCuspLabelTargetAverageReductionAudit
```

It carries:

```text
theta_source : FLZModCuspLabelThetaSourceAudit l
ind12_equality_part : Ind12EqualityPart
targetSigned_le_thetaAverage :
  targetSigned <= thetaSourceAverage audited
```

Lean proves:

```text
qSigned_le_targetSigned
qSigned_le_thetaSourceAverage
toQThetaComparisonAudit
toQThetaComparisonAudit_qSigned_le_thetaSigned
targetSigned_le_thetaSigned_via_average
```

### Mathematical Point

The q-to-average comparison is no longer a completely opaque field.  It can be
constructed from:

```text
qSigned <= targetSigned
targetSigned <= thetaSourceAverage
```

The first inequality is already part of the `(Ind1)/(Ind2)` equality/charting
side.  The remaining additional obligation is now isolated as:

```text
targetSigned <= thetaSourceAverage
```

### Trap Avoided

We did not assume that the existing `targetSigned <= thetaSigned` bound implies
`targetSigned <= thetaSourceAverage`.  That would be backwards unless the
Theta-source average is known to dominate the target.  The Lean object records
that domination as its own field.

### Toy Check

The examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_target_reduction_q_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_target_reduction_average_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_target_reduction_to_q_example
```

### Remaining Gap

This is now a clear mathematical pressure point: can
`targetSigned <= thetaSourceAverage` be derived from Mochizuki's source
construction, or is it an extra comparison assumption?  The next milestone
should inspect the surrounding source definitions and decide whether this bound
belongs to `(Ind3)` upper semi-compatibility, to the theta-value construction,
or to a separate comparison lemma.

## 52. Classifying the Target-to-Average Bound

### Goal

We classified the remaining target-to-Theta-average bound so it is not silently
attributed to `(Ind3)` alone.

### Source Check

In the IUT III introduction to Corollary 3.12, Mochizuki describes the
Theta-pilot log-volume as the log-volume of the holomorphic hull of the union of
possible images, subject to `(Ind1)`, `(Ind2)`, `(Ind3)`.  The same discussion
then says that the log-theta-lattice and the gluing isomorphism are constructed
so that this holomorphic-hull computation gives an upper-bound computation for
the q-pilot log-volume.

In IUT IV, the local estimates repeatedly say that `(Ind3)` is accounted for by
working with upper bounds/containers, while the actual local upper bounds are
computed from the container and then averaged over `j ∈ F_l`.

Scholze-Stix identify this comparison region as the critical place where
consistent real-line identifications and averaging must be made explicit.

### Lean/API Check

The new classification type is:

```text
IUTStage1TargetAverageBoundSource
```

with alternatives:

```text
ind3UpperSemiOnly
thetaPilotHullContainer
separateComparisonLemma
```

The new audit is:

```text
FLZModCuspLabelThetaContainerBoundAudit
```

It carries:

```text
theta_source : FLZModCuspLabelThetaSourceAudit l
ind12_equality_part : Ind12EqualityPart
ind3_upper_part : Ind3UpperInequalityPart
bound_source : IUTStage1TargetAverageBoundSource
bound_source_not_ind3_only :
  bound_source ≠ ind3UpperSemiOnly
targetSigned_le_thetaAverage
```

Lean proves:

```text
boundSource_not_ind3Only
targetSigned_le_thetaAverage'
ind3TargetSigned_le_thetaSigned
toTargetAverageReductionAudit
qSigned_le_thetaSourceAverage
qSigned_le_thetaSigned_via_average
targetSigned_le_thetaSigned_via_average
```

### Mathematical Point

The formalization now records the distinction suggested by the source texts:
`(Ind3)` provides the upper-bound/container context, but the numerical bound

```text
targetSigned <= thetaSourceAverage
```

must be justified by the theta-pilot hull/container computation or by a separate
comparison lemma.  It cannot be treated as an `(Ind3)` consequence by itself.

### Trap Avoided

We made `ind3UpperSemiOnly` a possible classification but require every usable
audit to prove that this is not the chosen classification.  This prevents later
code from hiding the target-to-average comparison inside the existing
`Ind3UpperInequalityPart`.

### Toy Check

The examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_container_not_ind3_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_container_to_reduction_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_container_q_le_theta_example
```

### Remaining Gap

The next milestone should split the non-`Ind3` source into the two constructive
paths now named by the classification: a theta-pilot hull/container theorem, or
a separate comparison lemma.  The more faithful first target is the
theta-pilot hull/container route, since that matches the IUT III/IV descriptions
of upper bounds for the holomorphic hull of possible Theta-pilot images.

## 53. Theta-Pilot Hull/Container Source for the Target-to-Average Bound

### Goal

We implemented the constructive branch of the classification from Section 52:
the target-to-average comparison may now be recorded as coming from the
Theta-pilot hull/container computation, not from `(Ind3)` alone.

### Source Check

IUT III describes the relevant Theta-pilot log-volume in terms of the
holomorphic hull of the union of possible images of the Theta-pilot object,
subject to `(Ind1)`, `(Ind2)`, `(Ind3)` (local notes: IUT III lines around
839--945).  This is exactly the source shape already present in our endpoint:
possible Theta-pilot images, their union, containment in the hull, and the
determinant/log-volume bound.

The newer formalization paper separates the route into a final
`3.11.5 => 3.12` comparison after moving the `hull+det` component earlier
(local notes: formalization paper lines around 477--492).  This supports our
current split: the hull/container facts are tracked explicitly, while the
simultaneous comparison remains visible as a separate bound.

Scholze-Stix's Section 2.2 remains the guardrail: identifying abstract
Theta-pilot data with real-valued degrees and averages is precisely where an
unjustified collapse can enter.  For that reason the new Lean object does not
pretend that the average comparison follows automatically from the hull
containment.

### Lean Move

We added:

```text
FLZModCuspLabelThetaPilotHullContainerAudit
```

It carries:

```text
theta_source
ind12_equality_part
ind3_upper_part
theta_images_eq_endpoint
targetSigned_le_thetaAverage_from_hull_container
```

Lean now proves from this audit:

```text
thetaSourceUnion_subset_hull
thetaSourceUnion_eq_targetUnion
thetaSourceChoiceRegion_eq_targetRegion
determinantVolumeBound
targetSigned_le_thetaAverage
toThetaContainerBoundAudit
boundSource_eq_thetaPilotHullContainer
qSigned_le_thetaSourceAverage
qSigned_le_thetaSigned_via_hull_container
```

The conversion

```text
toThetaContainerBoundAudit
```

sets

```text
bound_source := thetaPilotHullContainer
```

and proves that the source is not `ind3UpperSemiOnly`.

### Mathematical Point

The formal route is now:

```text
Theta-source images = endpoint possible Theta-pilot images
  -> union is contained in the hull/container
  -> determinant/log-volume bound remains attached
  -> targetSigned <= thetaSourceAverage is supplied as the hull/container
     comparison
  -> qSigned <= thetaSourceAverage by the `(Ind1)/(Ind2)` equality part
  -> qSigned <= thetaSigned by the Theta-source upper bound
```

This is still not a full proof of the numerical local bound.  It is a faithful
typed location for that bound: a later theorem must derive
`targetSigned_le_thetaAverage_from_hull_container` from the actual analytic
container and averaging estimates.

### Trap Avoided

The audit explicitly stores equality between `theta_source.theta_images` and
the endpoint's possible images.  Without this, one could accidentally compare a
label average attached to one image family with a hull bound attached to a
different image family.

### Toy Check

The examples now check:

```text
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_to_classified_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_source_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_union_example
placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_q_le_theta_example
```

### Remaining Gap

The next mathematical step is to refine
`targetSigned_le_thetaAverage_from_hull_container`.  It should become a theorem
whose hypotheses name the actual local container estimate and the finite
`F_l`-average estimate, instead of remaining a field of the audit.

## 54. Turning Labelwise Container Estimates into the Theta Average

### Goal

We began refining the remaining hull/container field by adding the finite
average theorem that converts pointwise label estimates into an averaged
estimate.

### Lean Move

For any finite nonempty label type, Lean now proves:

```text
IUTStage1LabelAveragedProcessionLogVolume.const_le_average_of_forall_le
```

If a constant `c` is bounded above by every label-normalized log-volume, then
`c` is bounded above by the average log-volume.  The proof is the standard
finite-sum argument:

```text
c <= f(j) for all j
  -> card(label) * c <= sum_j f(j)
  -> c <= sum_j f(j) / card(label)
```

The nonempty hypothesis is essential.  Without it, averaging over an empty
label set would divide by zero and would not support this comparison.

We then added:

```text
FLZModCuspLabelThetaLabelwiseContainerAudit
```

This refines the previous hull/container audit by assuming a labelwise bound:

```text
targetSigned <= normalizedLogVolume(j)
```

for every `j : ZMod l.value`.  Lean derives:

```text
targetSigned_le_averageLogVolume
targetSigned_le_thetaAverage
toThetaPilotHullContainerAudit
qSigned_le_thetaSigned_via_labelwise_container
```

### Mathematical Point

This is a real reduction of the remaining gap.  Previously the hull/container
audit carried:

```text
targetSigned <= thetaSourceAverage
```

directly.  Now we have a more local route:

```text
for every F_l label j:
  targetSigned <= normalized local log-volume at j

therefore:
  targetSigned <= F_l-average
```

This matches the IUT IV style of local upper-bound computations followed by
averaging over `j ∈ F_l`, while keeping the Scholze-Stix concern visible: the
pointwise real-valued inequalities must be attached to the correct label and
real-line identification before the averaging theorem applies.

### Trap Avoided

We did not use the final chart inequality `targetSigned <= thetaSigned` to
derive the average estimate.  The new route derives the average bound only
from labelwise normalized log-volume estimates.

### Toy Check

The examples now check:

```text
labelAveragedProcessionLogVolume_const_le_average_example
placeAudited_logVolume_fl_zmod_labelwise_container_average_example
placeAudited_logVolume_fl_zmod_labelwise_container_to_hull_example
placeAudited_logVolume_fl_zmod_labelwise_container_q_le_theta_example
```

### Remaining Gap

The next step is to replace the raw labelwise inequality field by more
structured source data: a local container estimate for each `j : F_l`, tied to
the cusp/sign label model and to the chosen place-audited packet.

## 55. Cusp-Class Bounds Imply Labelwise Bounds

### Goal

We refined the labelwise container estimate so that it is expressed through the
cusp/sign-label model rather than as an arbitrary function on `ZMod l.value`.

### Source Check

The Corollary 3.12 discussion averages over `j ∈ F_l`, but the local
Theta-side data is organized through cusp labels and their sign/unit
identifications.  This is also one of the places where the Scholze-Stix critique
warns against silently changing the interpretation of the real-valued objects.
Therefore we should not treat the raw `ZMod l` label family as independent of
the cusp-label model.

### Lean Move

We added:

```text
FLZModCuspLabelThetaCuspClassContainerAudit
```

It assumes:

```text
targetSigned <= cuspClassLogVolume(sign label)
targetSigned <= zeroLogVolume
```

for each audited place-packet.  Lean then proves:

```text
targetSigned_le_normalizedLogVolume
toThetaLabelwiseContainerAudit
targetSigned_le_averageLogVolume
toThetaPilotHullContainerAudit
qSigned_le_thetaSigned_via_cusp_container
```

The proof splits on whether `j : ZMod l.value` is zero.

For `j ≠ 0`, it uses the compatibility theorem:

```text
nonzeroAverageLabel_eq_cuspClass
```

For `j = 0`, it uses:

```text
zeroAverageLabel_eq_zeroLogVolume
```

### Mathematical Point

The route is now:

```text
cusp-class and zero-label local bounds
  -> normalized bound for every ZMod l label
  -> finite F_l average bound
  -> Theta-source average bound
  -> qSigned <= thetaSigned
```

This is closer to the structure of the IUT local estimates: the future analytic
proof should supply bounds for the cusp/sign-label classes and the zero label,
not for an anonymous list of real numbers.

### Trap Avoided

The zero label is not forced into the nonzero cusp sign-label quotient.  Lean
requires a separate zero bound, which matches the way the compatibility object
was designed.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_cusp_container_labelwise_example
placeAudited_logVolume_fl_zmod_cusp_container_to_labelwise_example
placeAudited_logVolume_fl_zmod_cusp_container_q_le_theta_example
```

### Remaining Gap

The next refinement should unpack the source of the cusp-class bounds
themselves: a local container estimate attached to the audited place packet and
the corresponding cusp sign-label class.

## 56. Local Container Estimates for Cusp-Class Bounds

### Goal

We refined the source of the cusp-class bounds by introducing explicit local
container log-volume estimates.

### Lean Move

We added a small real-valued estimate object:

```text
IUTStage1LocalContainerLogVolumeEstimate targetSigned localLogVolume
```

It records:

```text
containerLogVolume
localLogVolume = containerLogVolume
targetSigned <= containerLogVolume
```

Lean proves:

```text
targetSigned_le_localLogVolume
```

We then added:

```text
FLZModCuspLabelThetaLocalContainerAudit
```

It supplies such estimates for:

```text
each audited packet and nonzero cusp sign-label class
the separately handled zero label
```

Lean derives:

```text
targetSigned_le_cuspClassLogVolume
targetSigned_le_zeroLogVolume
toThetaCuspClassContainerAudit
targetSigned_le_normalizedLogVolume
toThetaPilotHullContainerAudit
qSigned_le_thetaSigned_via_local_container
```

### Mathematical Point

The chain is now more structured:

```text
local container log-volume estimate
  -> cusp-class or zero-label bound
  -> ZMod labelwise bound
  -> finite F_l average bound
  -> Theta-source average bound
  -> qSigned <= thetaSigned
```

This keeps the hard future work in the expected place: proving local analytic
container estimates for the actual cusp-labelled log-volume objects.

### Periodic Audit

The formalization still targets the disputed boundary rather than drifting into
general infrastructure.  The current route explicitly separates:

```text
(Ind1)/(Ind2): qSigned <= targetSigned and invariance/averaging compatibility
(Ind3): the hull/container upper-bound context
local container estimates: the source of targetSigned <= thetaSourceAverage
```

This matches the source-text split: IUT III describes the holomorphic hull of
possible Theta-pilot images, the formalization note moves `hull+det` into a
prior `3.11.5`-style stage, and Scholze-Stix identify the real-line/average
comparison as the dangerous point.  Our Lean code now keeps that dangerous
point named and localized instead of hiding it inside the endpoint.

### Trap Avoided

The local estimate object proves a bound for a named local log-volume only
after checking its equality with the container log-volume.  This prevents the
container bound from being applied to an unrelated real number.

### Toy Check

The examples now check:

```text
localContainerLogVolumeEstimate_target_le_local_example
placeAudited_logVolume_fl_zmod_local_container_cusp_bound_example
placeAudited_logVolume_fl_zmod_local_container_to_cusp_example
placeAudited_logVolume_fl_zmod_local_container_q_le_theta_example
```

### Remaining Gap

The next step should make the local container estimate less real-opaque by
attaching it to the local log-volume object/capsule data already present in the
place-audited packet.  That will connect the estimate to the actual
procession-normalized local object rather than only to its real value.

## 57. Local Objects Behind the Container Estimates

### Goal

We refined the local container estimate so that it names a finite local
log-volume object before producing a real-valued bound.

### Lean Move

We added:

```text
IUTStage1LocalObjectContainerLogVolumeEstimate
```

It records:

```text
localObject : IUTStage1FiniteLocalLogVolumeObject kind
localLogVolume = localObject.finiteLogVolume
localObject.finiteLogVolume has a local container estimate
```

Lean derives:

```text
toLocalContainerEstimate
targetSigned_le_localLogVolume
```

We then added:

```text
FLZModCuspLabelThetaLocalObjectContainerAudit
```

It supplies local-object estimates for each cusp sign-label class and for the
zero label.  Lean converts it to:

```text
FLZModCuspLabelThetaLocalContainerAudit
```

and therefore recovers the full route to:

```text
qSigned_le_thetaSigned_via_local_object_container
```

### Mathematical Point

The chain now begins with a named local object:

```text
finite local log-volume object
  -> container log-volume estimate
  -> cusp-class/zero-label real bound
  -> labelwise bound
  -> F_l-average bound
  -> qSigned <= thetaSigned
```

This is still not the final analytic construction, but it prevents the local
estimate from being just a free real inequality.  The real number being bounded
must first be identified with the finite log-volume of a local object.

### Trap Avoided

The equality

```text
localLogVolume = localObject.finiteLogVolume
```

is explicit.  Without it, a proof could use a valid container estimate for one
local object while applying the result to a different log-volume real.

### Toy Check

The examples now check:

```text
localObjectContainerLogVolumeEstimate_target_le_local_example
placeAudited_logVolume_fl_zmod_local_object_container_cusp_bound_example
placeAudited_logVolume_fl_zmod_local_object_container_to_local_example
placeAudited_logVolume_fl_zmod_local_object_container_q_le_theta_example
```

### Remaining Gap

The next refinement should connect these finite local log-volume objects to the
capsule-family/procession-normalized local data carried by the place-audited
packet, so that the local object estimates are not supplied independently of
the packet being averaged.

## 58. Packet-Local Objects for Container Estimates

### Goal

We connected the local object used in each cusp/zero container estimate to the
finite local object carried by the audited local tensor packet.

### Lean Move

We added:

```text
FLZModCuspLabelThetaPacketLocalObjectContainerAudit
```

It carries the same local-object container estimates as the previous audit, but
adds:

```text
cuspClassObjectEstimate(audited, label).localObject
  = audited.choice.local_tensor_state.packetState.localObject

zeroObjectEstimate(audited).localObject
  = audited.choice.local_tensor_state.packetState.localObject
```

Lean proves:

```text
cuspClassObject_eq_packetLocalObject'
zeroObject_eq_packetLocalObject'
toThetaLocalObjectContainerAudit
targetSigned_le_cuspClassLogVolume
toThetaPilotHullContainerAudit
qSigned_le_thetaSigned_via_packet_local_object_container
```

### Mathematical Point

The route now starts from the local object of the audited packet:

```text
audited packet local object
  -> local-object container estimate
  -> cusp/zero log-volume bound
  -> labelwise normalized bound
  -> F_l average bound
  -> qSigned <= thetaSigned
```

This is an important anti-drift check.  The local estimates are no longer
allowed to refer to unrelated local objects; they must match the local tensor
packet whose label average is being used.

### Trap Avoided

This avoids a subtle version of the real-line identification problem: even if a
container estimate is valid for some local object, it cannot be inserted into
the average route unless Lean also has the equality identifying that object
with the audited packet's local object.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_packet_local_object_eq_example
placeAudited_logVolume_fl_zmod_packet_local_object_to_local_object_example
placeAudited_logVolume_fl_zmod_packet_local_object_q_le_theta_example
```

### Remaining Gap

The next refinement should connect the packet-local object to the packet's
capsule-family normalized log-volume.  That will make the relation between the
object-level estimate and the procession-normalized value explicit.

## 59. Packet-Normalized Container Estimates

### Goal

We connected the local object/container estimate to the packet's
capsule-family normalized log-volume.

### Lean Move

We added:

```text
IUTStage1PacketNormalizedContainerEstimate
```

It records:

```text
objectEstimate :
  IUTStage1LocalObjectContainerLogVolumeEstimate ...

objectEstimate.localObject
  = packetState.packetState.localObject

localLogVolume
  = packetState.packetState.capsuleFamily.normalizedLogVolume
```

Lean proves:

```text
toLocalObjectContainerEstimate
localObject_eq_packetLocalObject'
localLogVolume_eq_packetNormalized'
targetSigned_le_localLogVolume
```

We then added:

```text
FLZModCuspLabelThetaPacketNormalizedContainerAudit
```

This supplies packet-normalized container estimates for each cusp sign-label
class and for the zero label.  Lean derives:

```text
cuspClassLogVolume_eq_packetNormalized
zeroLogVolume_eq_packetNormalized
toThetaPacketLocalObjectContainerAudit
targetSigned_le_normalizedLogVolume
toThetaPilotHullContainerAudit
qSigned_le_thetaSigned_via_packet_normalized_container
```

### Mathematical Point

The formal route now requires the cusp/zero log-volume real to be the
procession-normalized capsule-family value of the same audited local tensor
packet:

```text
cusp/zero log-volume
  = packet capsule-family normalized log-volume
  -> packet-local object/container estimate
  -> targetSigned <= cusp/zero log-volume
  -> labelwise and averaged comparison
```

This is a stronger anti-drift condition than the previous packet-local-object
check: the object must match, and the real log-volume used in the average must
also match the packet's normalized capsule-family value.

### Trap Avoided

We avoid silently averaging reals that merely have the same local object label.
The real itself must be identified with the normalized capsule-family value of
the audited packet.

### Toy Check

The examples now check:

```text
packetNormalizedContainerEstimate_target_le_local_example
placeAudited_logVolume_fl_zmod_packet_normalized_eq_example
placeAudited_logVolume_fl_zmod_packet_normalized_to_object_example
placeAudited_logVolume_fl_zmod_packet_normalized_q_le_theta_example
```

### Remaining Gap

The next step should connect this packet-normalized estimate to the actual
capsule sum formula already present in `IUTStage1TypedCapsuleFamilyLogVolume`,
so the normalized value is not a black-box real.

## 60. Capsule-Sum Formula for Packet-Normalized Estimates

### Goal

We exposed the finite capsule-sum formula behind the packet-normalized
log-volume used by the container route.

### Lean Move

For:

```text
IUTStage1PacketNormalizedContainerEstimate
```

Lean now proves:

```text
localLogVolume_eq_capsuleAverage
localLogVolume_eq_capsuleSumAverage
```

The second theorem expands the normalized packet value to:

```text
(sum_i capsule(i).logVolume) / capsuleCount
```

using the existing `IUTStage1TypedCapsuleFamilyLogVolume` fields:

```text
total_eq_sum
normalized_eq_average
```

For the full cusp-label route, Lean now proves:

```text
cuspClassLogVolume_eq_capsuleSumAverage
zeroLogVolume_eq_capsuleSumAverage
```

inside `FLZModCuspLabelThetaPacketNormalizedContainerAudit`.

### Mathematical Point

The source real in the average route is now traceable down to a finite capsule
sum:

```text
cusp/zero log-volume
  = packet normalized capsule-family value
  = (finite sum of capsule log-volumes) / capsule count
```

This is the expected shape for the procession-normalized local log-volume side
of the IUT III/IV estimates.

### Trap Avoided

The normalized value is no longer treated as an uninterpreted real once the
packet-normalized audit is supplied.  It is tied to the actual finite capsule
family carried by the audited packet.

### Toy Check

The examples now check:

```text
packetNormalizedContainerEstimate_capsule_sum_example
placeAudited_logVolume_fl_zmod_packet_normalized_capsule_sum_example
```

### Remaining Gap

The next step should push one level further into the capsule entries: local
container estimates should eventually bound the finite capsule log-volume sum,
not merely the normalized real after the sum has already been packaged.

## 61. Capsule-Entry Bounds Imply Normalized Capsule Bounds

### Goal

We added the finite averaging theorem for capsule entries.

### Lean Move

For:

```text
IUTStage1TypedCapsuleFamilyLogVolume
```

Lean now constructs:

```text
toLabelAveragedCapsuleLogVolume
```

This views the finite capsule family as a finite label-average over
`Fin capsuleCount`.  The denominator is checked by Lean as
`Fintype.card (Fin capsuleCount) = capsuleCount`.

Lean then proves:

```text
const_le_normalizedLogVolume_of_capsule_le
```

If:

```text
c <= capsule(i).logVolume
```

for every capsule `i`, then:

```text
c <= normalizedLogVolume
```

For packet-normalized estimates, Lean also proves:

```text
targetSigned_le_localLogVolume_of_capsule_le
```

after rewriting the local log-volume to the packet's normalized capsule-family
value.

### Mathematical Point

The route can now start at individual capsule entries:

```text
targetSigned <= capsule(i).logVolume for every capsule i
  -> targetSigned <= packet normalized capsule average
  -> targetSigned <= cusp/zero local log-volume
  -> labelwise and F_l average route
```

This is closer to the source mathematics around procession-normalized local
log-volumes, where a finite capsule family is averaged.

### Trap Avoided

The proof uses the positivity of `capsuleCount`; averaging over an empty capsule
family is not permitted.  This is already part of
`IUTStage1TypedCapsuleFamilyLogVolume`.

### Toy Check

The examples now check:

```text
typedCapsuleFamily_const_le_normalized_example
packetNormalizedContainerEstimate_capsule_bound_example
```

### Remaining Gap

The capsule-entry bound itself is still a hypothesis.  The next step should
make that hypothesis come from a capsule-entry container estimate, parallel to
the local-object and packet-normalized container estimates above.

## 62. Capsule-Entry Container Estimates

### Goal

We replaced the raw per-capsule lower-bound hypothesis by explicit
capsule-entry container estimates.

### Lean Move

We added:

```text
IUTStage1CapsuleEntryContainerEstimate
```

It records a local-object container estimate for one capsule log-volume and an
equality identifying the estimate's local object with the capsule's local
object.

Lean proves:

```text
targetSigned_le_capsuleLogVolume
localObject_eq_capsuleLocalObject'
```

We also added:

```text
IUTStage1TypedCapsuleFamilyContainerEstimate
```

which supplies such a capsule-entry estimate for every capsule in a typed
capsule family.  Lean derives:

```text
targetSigned_le_capsuleLogVolume
targetSigned_le_normalizedLogVolume
```

Finally, `IUTStage1PacketNormalizedContainerEstimate` now has:

```text
targetSigned_le_localLogVolume_of_capsule_estimates
```

### Mathematical Point

The local start of the route can now be:

```text
container estimate for each capsule entry
  -> targetSigned <= each capsule log-volume
  -> targetSigned <= normalized capsule-family average
  -> packet/cusp/label/F_l average route
```

This is closer to a formal version of the finite local estimate, since the
individual capsule entries are no longer bounded by an anonymous hypothesis.

### Trap Avoided

Each capsule-entry estimate carries the local-object match for that capsule.
This prevents using a container estimate attached to a different capsule-local
object.

### Toy Check

The examples now check:

```text
capsuleEntryContainerEstimate_target_le_capsule_example
typedCapsuleFamilyContainerEstimate_target_le_normalized_example
packetNormalizedContainerEstimate_capsule_estimates_example
```

### Remaining Gap

The next refinement should decide how these capsule-entry estimates interact
with `(Ind2)` direct-summand actions, i.e. whether capsule-entry container
estimates are preserved under the local tensor direct-summand action.

## 63. Transporting Capsule Estimates Across Local Tensor Actions

### Goal

We checked that capsule-entry container estimates are stable under the modeled
capsule action used for the local tensor/direct-summand side of `(Ind2)`.

### Lean Move

We added transport operations:

```text
IUTStage1LocalObjectContainerLogVolumeEstimate.transportLocalLogVolume
IUTStage1CapsuleEntryContainerEstimate.transportCapsule
```

These transport an estimate across an equality of local log-volume reals, while
requiring the appropriate local-object equality for the target capsule.

For:

```text
IUTStage1TypedCapsuleFamilyLogVolumeAction
```

Lean now constructs:

```text
transformedContainerEstimate
```

from a container estimate on the original capsule family.  The construction
uses the action's two preservation facts:

```text
capsule local object is preserved
capsule log-volume is preserved
```

Lean also proves:

```text
transformedContainerEstimate_targetSigned_le_normalizedLogVolume
```

### Mathematical Point

This connects the local container estimates to the `(Ind2)` action surface:

```text
capsule-entry estimates on a capsule family
  -> transported estimates on the transformed capsule family
  -> normalized bound survives the local tensor action
```

This is important because the average route must remain compatible with the
indeterminacies represented by local tensor/direct-summand actions.

### Trap Avoided

The transport is not based on name equality alone.  Lean requires both the
log-volume equality and the local-object equality before an estimate can be
moved to the transformed capsule.

### Toy Check

The examples now check:

```text
typedCapsuleFamilyAction_transformed_container_estimate_example
typedCapsuleFamilyAction_transformed_container_bound_example
```

### Remaining Gap

The next refinement should lift this preservation from raw capsule-family
actions to the direct-summand packet action data already used in the
place-audited `(Ind2)` model.

## 64. Direct-Summand Action Preservation of Capsule Estimates

### Goal

We lifted capsule-entry container estimate preservation from raw capsule
actions to the direct-summand action layer.

### Lean Move

For:

```text
IUTStage1TensorDirectSummandFamilyAction
```

Lean now constructs:

```text
transformedContainerEstimate
```

by passing through the existing:

```text
toCapsuleAction
```

Lean also proves:

```text
transformedContainerEstimate_targetSigned_le_normalizedLogVolume
```

The two typed source surfaces for `(Ind2)` inherit this theorem:

```text
IUTStage1NonarchimedeanIsmDirectSummandAction
IUTStage1ArchimedeanOrderTwoDirectSummandAction
```

### Mathematical Point

This moves the preservation statement from the raw capsule-family level to the
local tensor/direct-summand action layer:

```text
direct-summand action
  -> induced capsule action
  -> transported capsule-entry container estimates
  -> transformed normalized capsule-family bound
```

This is closer to the formal `(Ind2)` model, where the source action is a local
tensor/direct-summand action and capsule preservation is a consequence.

### Trap Avoided

The direct-summand theorem does not introduce a new preservation assumption. It
uses the existing induced capsule action and its already checked log-volume and
local-object preservation.

### Toy Check

The examples now check:

```text
directSummandFamilyAction_transformed_container_estimate_example
directSummandFamilyAction_transformed_container_bound_example
nonarchimedeanDirectSummandAction_transformed_container_bound_example
archimedeanDirectSummandAction_transformed_container_bound_example
```

### Remaining Gap

The next refinement should connect these direct-summand action preservation
facts to `IUTStage1PlaceAuditedDirectSummandPacketChoice` and its `(Ind2)` step
records.

## 65. Capsule Container Bounds Across Direct-Summand `(Ind2)` Steps

### Goal

We connected capsule-entry container estimate preservation to the actual
`LocalTensorDirectSummandActionStep` records used by the refined Theorem 3.11
choice model.

### Lean Move

For:

```text
IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
```

Lean now proves:

```text
ind2_transports_capsuleContainerBound
```

Given capsule-family container estimates on the source choice, the target
choice's normalized capsule-family log-volume satisfies the same target lower
bound.

The two concrete `(Ind2)` action surfaces inherit this theorem:

```text
nonarchimedeanIsm_transports_capsuleContainerBound
archimedeanOrderTwo_transports_capsuleContainerBound
```

### Mathematical Point

We now have a formal preservation statement at the intended `(Ind2)` level:

```text
source capsule-entry container estimates
  -> direct-summand action step
  -> target normalized capsule-family bound
```

This matters because the Corollary 3.12 average route should not depend on a
particular representative of the local tensor/direct-summand data.

### Trap Avoided

The theorem is proved by unpacking the action witness in the `(Ind2)` step and
then using the already-audited capsule-action transport.  It does not assume
that all choices have identical capsule estimates by fiat.

### Periodic Audit

At this point the formal chain from the local side to the final q/Theta bound
has the following audited layers:

```text
capsule-entry container estimate
  -> finite capsule normalized average
  -> packet-normalized cusp/zero log-volume
  -> cusp/sign-label bound
  -> ZMod labelwise bound
  -> F_l average bound
  -> theta-source average
  -> target-to-average classified as thetaPilotHullContainer
  -> qSigned <= thetaSigned
```

The chain is still aligned with the main dispute: the real-valued comparison
and averaging steps are explicit, and `(Ind3)` is still not used as the source
of the target-to-average bound.

### Toy Check

The examples now check:

```text
directSummandActionStep_transports_capsule_container_example
nonarchimedeanIsmStep_transports_capsule_container_example
archimedeanOrderTwoStep_transports_capsule_container_example
```

### Remaining Gap

The next step should lift this from direct-summand packet choices to
`IUTStage1PlaceAuditedDirectSummandPacketChoice`, the type used by the
place-audited multiradial Theta endpoint.

## 66. Place-Audited `(Ind2)` Transport of Capsule Container Bounds

### Goal

We lifted the direct-summand `(Ind2)` transport theorem to the
place-audited choice type used by the multiradial Theta endpoint.

### Lean Move

For:

```text
IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
```

Lean now proves:

```text
ind2_transports_capsuleContainerBound
```

The audited nonarchimedean and archimedean instances also inherit the theorem:

```text
nonarchimedeanIsm_transports_capsuleContainerBound
archimedeanOrderTwo_transports_capsuleContainerBound
```

### Mathematical Point

The preservation chain now reaches the same audited choice type that indexes
the place-audited Theta-pilot image family:

```text
place-audited source choice
  -> capsule-entry container estimates
  -> audited `(Ind2)` direct-summand action step
  -> place-audited target choice normalized capsule bound
```

This matters because the final Theta-source average is indexed by
`IUTStage1PlaceAuditedDirectSummandPacketChoice`.

### Trap Avoided

The place-family compatibility audit is preserved by the audited step, while
the capsule-bound transport is still delegated to the underlying choice-level
direct-summand action.  These two responsibilities remain separate.

### Toy Check

The examples now check:

```text
placeAuditedInd2Step_transports_capsule_container_example
placeAuditedNonarchimedeanStep_transports_capsule_container_example
placeAuditedArchimedeanStep_transports_capsule_container_example
```

### Remaining Gap

The next step should connect this transported capsule-bound data to the
`FLZModCuspLabelThetaPacketNormalizedContainerAudit`, so the high-level
q-to-Theta average route can explicitly use place-audited `(Ind2)` transport.

## 67. Feeding `(Ind2)` Transport into the Packet-Normalized Cusp Audit

### Goal

We connected place-audited `(Ind2)` capsule-bound transport back into the
high-level packet-normalized cusp/zero log-volume audit.

### Lean Move

Inside:

```text
FLZModCuspLabelThetaPacketNormalizedContainerAudit
```

Lean now proves:

```text
targetSigned_le_cuspClassLogVolume_of_ind2_capsuleEstimates
targetSigned_le_zeroLogVolume_of_ind2_capsuleEstimates
```

Given:

```text
source capsule-family container estimates
an audited LocalTensorDirectSummandActionStep from source to target
```

Lean derives the target cusp-class or zero-label bound by:

```text
1. transporting the source capsule estimates across the audited `(Ind2)` step
2. rewriting the target cusp/zero log-volume to the target packet-normalized
   capsule-family log-volume
```

### Mathematical Point

This links the low-level local estimate transport to the high-level average
route:

```text
source capsule estimates
  -> audited `(Ind2)` transport
  -> target packet normalized bound
  -> target cusp/zero log-volume bound
  -> labelwise/F_l average route
```

The formalization now has a visible path showing how an estimate attached to
one place-audited representative can survive a local tensor/direct-summand
indeterminacy before entering the cusp-label average.

### Trap Avoided

The theorem does not assert that cusp-log values are invariant under `(Ind2)`.
It proves the target bound by transporting capsule estimates to the target
packet and then using the target packet-normalized equality.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_packet_normalized_ind2_cusp_bound_example
placeAudited_logVolume_fl_zmod_packet_normalized_ind2_zero_bound_example
```

### Remaining Gap

The next refinement should package this as an optional source of the
`FLZModCuspLabelThetaCuspClassContainerAudit` fields, so downstream code can
use either direct target estimates or estimates transported along audited
`(Ind2)` steps.

## 68. Packaging `(Ind2)`-Transported Bounds as a Cusp-Class Audit

### Goal

We packaged the `(Ind2)`-transported capsule-estimate route as a source of the
standard cusp-class container audit.

### Lean Move

We added:

```text
FLZModCuspLabelThetaInd2TransportedCuspClassAudit
```

For each target audited packet, it stores:

```text
sourceAudited target
audited `(Ind2)` step from source to target
source capsule-family container estimates
```

together with the packet-normalized audit that identifies target cusp/zero
log-volumes with target packet-normalized capsule values.

Lean proves:

```text
targetSigned_le_cuspClassLogVolume
targetSigned_le_zeroLogVolume
toThetaCuspClassContainerAudit
qSigned_le_thetaSigned_via_ind2_transport
```

### Mathematical Point

The high-level route can now consume transported estimates through the same
interface as direct target cusp-class estimates:

```text
source capsule estimates + audited `(Ind2)` step
  -> target cusp/zero bounds
  -> FLZModCuspLabelThetaCuspClassContainerAudit
  -> labelwise/F_l average route
  -> qSigned <= thetaSigned
```

This keeps the downstream q-to-Theta comparison independent of whether the
cusp/zero bounds were proved directly at the target packet or transported from
an `(Ind2)`-related source packet.

### Trap Avoided

The audit chooses a source packet separately for each target packet.  This
avoids a hidden global identification of all audited choices while still
requiring an explicit audited `(Ind2)` step for every transported estimate.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_ind2_transport_cusp_bound_example
placeAudited_logVolume_fl_zmod_ind2_transport_to_cusp_audit_example
placeAudited_logVolume_fl_zmod_ind2_transport_q_le_theta_example
```

### Remaining Gap

The next refinement should introduce an analogous package for direct target
capsule estimates, so both direct and transported local-estimate sources have
parallel high-level audit constructors.

## 69. Direct Capsule Estimates as a Cusp-Class Audit

### Goal

We added the direct-target analogue of the `(Ind2)`-transported cusp-class
audit.

### Lean Move

We added:

```text
FLZModCuspLabelThetaDirectCapsuleCuspClassAudit
```

For every audited packet, it supplies:

```text
targetCapsuleEstimates audited :
  IUTStage1TypedCapsuleFamilyContainerEstimate
    targetSigned audited.packet.capsuleFamily
```

Together with the packet-normalized audit, Lean derives:

```text
targetSigned_le_cuspClassLogVolume
targetSigned_le_zeroLogVolume
toThetaCuspClassContainerAudit
qSigned_le_thetaSigned_via_direct_capsules
```

### Mathematical Point

We now have two parallel high-level sources for cusp/zero bounds:

```text
direct capsule estimates at the audited packet
transported capsule estimates along audited `(Ind2)` steps
```

Both produce the same downstream object:

```text
FLZModCuspLabelThetaCuspClassContainerAudit
```

This keeps the later q-to-Theta average route independent of how the local
capsule estimates were obtained.

### Trap Avoided

The direct route still goes through packet-normalized cusp/zero equalities.
It does not bypass the explicit identification between cusp labels and the
packet's normalized capsule-family log-volume.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_capsule_cusp_bound_example
placeAudited_logVolume_fl_zmod_direct_capsule_to_cusp_audit_example
placeAudited_logVolume_fl_zmod_direct_capsule_q_le_theta_example
```

### Remaining Gap

The next step should classify the source of cusp-class bounds, analogous to the
earlier classification of the target-to-average bound source.  This will make
explicit whether a cusp bound came from direct capsule estimates, transported
capsule estimates, or a still-separate analytic comparison lemma.

## 70. Classifying the Source of Cusp-Class Bounds

### Goal

We classified the source of cusp-class and zero-label bounds.

### Lean Move

We added:

```text
IUTStage1CuspClassBoundSource
```

with constructors:

```text
directCapsuleEstimates
ind2TransportedCapsuleEstimates
separateAnalyticComparison
```

We then added:

```text
FLZModCuspLabelThetaClassifiedCuspClassAudit
```

It packages a standard:

```text
FLZModCuspLabelThetaCuspClassContainerAudit
```

with its bound-source classification.

Lean provides constructors:

```text
ofDirectCapsule
ofInd2Transport
ofSeparateAnalyticComparison
```

and proves the same downstream bounds:

```text
targetSigned_le_cuspClassLogVolume
targetSigned_le_zeroLogVolume
qSigned_le_thetaSigned_via_classified_cusp
```

### Mathematical Point

The formal route now records the provenance of the local cusp/zero estimates:

```text
direct capsule estimates
transported capsule estimates along audited `(Ind2)` steps
separate analytic comparison
```

This mirrors the earlier target-to-average source classification and gives us a
clear audit trail for local estimates.

### Trap Avoided

Downstream code can no longer consume a cusp-class audit without the option of
recording how its bounds were obtained.  This is important because direct local
estimates and transported estimates have different mathematical obligations.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_cusp_direct_example
placeAudited_logVolume_fl_zmod_classified_cusp_ind2_example
placeAudited_logVolume_fl_zmod_classified_cusp_q_le_theta_example
```

### Remaining Gap

The next step should connect the classified cusp-class audit to the
target-to-average classification, so the final hull/container route records
both the source of the local cusp bounds and the source of the global
target-to-average comparison.

## 71. Connecting Cusp-Bound Classification to the Target-Average Source

### Goal

We connected the classified cusp-class audit to the earlier
target-to-average source classification.

### Lean Move

For:

```text
FLZModCuspLabelThetaClassifiedCuspClassAudit
```

Lean now exposes:

```text
toThetaPilotHullContainerAudit
toThetaContainerBoundAudit
targetAverageBoundSource_eq_thetaPilotHullContainer
```

Thus a classified cusp-bound route can be converted all the way to the
target-to-average container-bound audit, with:

```text
bound_source = thetaPilotHullContainer
```

### Mathematical Point

We now carry two layers of provenance:

```text
cusp/zero bound source:
  direct capsule estimates
  transported capsule estimates
  separate analytic comparison

target-to-average source:
  thetaPilotHullContainer
```

This is the intended dependency structure: local cusp-bound provenance is
separate from the global fact that the target-to-average comparison is being
attributed to the Theta-pilot hull/container route.

### Trap Avoided

The code does not collapse the local source classification into the global
target-to-average classification.  They remain two different pieces of audit
data.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_cusp_to_hull_example
placeAudited_logVolume_fl_zmod_classified_cusp_target_source_example
```

### Remaining Gap

The next step should produce a compact summary object for this two-level
classification, so later reviews can inspect the local cusp-bound source and
the global target-average source together.

## 72. Compact Summary for the Classified Route

### Goal

We added a compact summary object for the two-level classification of the
local-to-global route.

### Lean Move

We added:

```text
FLZModCuspLabelThetaClassifiedRouteSummary
```

It stores:

```text
classified_cusp
cusp_bound_source
target_average_source
```

with equality fields tying these summary labels back to the underlying
classified cusp audit and target-container audit.

Lean constructs summaries by:

```text
ofClassifiedCusp
```

and proves:

```text
targetAverageSource_eq_thetaPilotHullContainer
qSigned_le_thetaSigned
```

### Mathematical Point

This is a review object.  It lets us inspect, in one place:

```text
where the local cusp/zero bounds came from
where the global target-to-average comparison came from
```

The two classifications remain distinct, but can be viewed together.

### Trap Avoided

The summary does not replace the underlying audits.  It stores equalities back
to the audits, so it cannot drift into a hand-written label that disagrees with
the proof route.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_route_summary_example
placeAudited_logVolume_fl_zmod_classified_route_target_source_example
```

### Remaining Gap

The next step should use this summary as the checkpoint for a broader review of
the current local-to-global chain against IUT III/IV and the Scholze-Stix
critique before adding more layers.

## 73. Periodic Review of the Local-to-Global Chain

### Scope

We reviewed the current Lean route after introducing the classified route
summary.

### Source Check

IUT III, in the discussion around Corollary 3.12, describes the Theta-pilot
log-volume as the log-volume of the holomorphic hull of the union of possible
Theta-pilot images, with the possible images subject to `(Ind1)`, `(Ind2)`,
`(Ind3)`.  It then says that this holomorphic-hull computation gives an upper
bound for the q-pilot log-volume.

Mochizuki's recent formalization note describes a reorganization in which the
`hull+det` component is moved into a prior `3.11.5`-style stage, leaving the
final `3.11.5 => 3.12` portion focused on simultaneous comparison.

Scholze-Stix's critique of the Corollary 3.12 step emphasizes that the various
copies of ordered real lines and the averaged `j = 1,...,l` concrete Theta-pilot
degrees must be identified consistently.

### Current Lean Alignment

The current route is:

```text
capsule-entry container estimates
  -> capsule-family normalized bound
  -> packet-normalized cusp/zero log-volume bound
  -> cusp/sign-label bound
  -> ZMod labelwise bound
  -> F_l average bound
  -> Theta-source average bound
  -> thetaPilotHullContainer target-average bound
  -> qSigned <= thetaSigned
```

The current classification summary records:

```text
cusp_bound_source
target_average_source
```

with equality links back to the proof route.

### Assessment

The implementation remains on target.  We are not proving the full analytic
IUT estimates yet, but we are replacing formerly opaque real inequalities with
smaller typed obligations:

```text
capsule-entry estimates
packet-normalized equalities
cusp/sign-label compatibility
finite F_l averaging
Theta-pilot hull/container classification
```

This is a useful formalization direction because it puts the disputed real-line
and averaging identifications directly into Lean data.

### Watch Points

The strongest assumptions currently introduced are:

```text
cusp/zero log-volume = packet normalized capsule-family log-volume
targetSigned <= each capsule entry log-volume
sourceAudited target choices for transported `(Ind2)` bounds
```

These are not final IUT theorems.  They are typed placeholders for future
analytic/container proofs.  The notes and names now make that status explicit.

### Next Step

Continue by reducing these assumptions further when possible, but avoid adding
new abstractions unless they discharge or localize one of the watch-point
assumptions above.

## 74. Classifying Packet-Normalized Real-Line Identifications

### Goal

We localized one of the main watch-point assumptions from the periodic review:
the equality between cusp/zero log-volumes and packet-normalized capsule-family
values.

### Lean Move

We added:

```text
IUTStage1PacketNormalizedIdentificationSource
```

with constructors:

```text
directPacketNormalization
ind2TransportedPacketNormalization
separateRealLineIdentification
```

We then added:

```text
FLZModCuspLabelThetaClassifiedPacketNormalizedAudit
```

It packages:

```text
FLZModCuspLabelThetaPacketNormalizedContainerAudit
```

with an identification-source classification.  Lean re-exposes:

```text
cuspClassLogVolume_eq_packetNormalized
zeroLogVolume_eq_packetNormalized
```

### Mathematical Point

This classification addresses the Scholze-Stix warning about real-line
identifications.  The equality:

```text
cusp/zero log-volume = packet normalized capsule-family log-volume
```

is now not just a field of a large audit; it can carry explicit provenance.

### Trap Avoided

We did not reinterpret the equality as automatic.  It remains a required audit,
now with a named source classification.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_packet_normalized_example
placeAudited_logVolume_fl_zmod_classified_packet_normalized_eq_example
```

### Remaining Gap

The route summary should eventually include this third classification:

```text
packet-normalized identification source
cusp-bound source
target-average source
```

## 75. Full Three-Level Route Summary

### Goal

We extended the route summary to include the packet-normalized real-line
identification source.

### Lean Move

We added:

```text
FLZModCuspLabelThetaFullClassifiedRouteSummary
```

It stores:

```text
classified_packet
classified_route
theta_source_eq
```

where `theta_source_eq` checks that the packet-normalized audit and the
classified cusp route refer to the same Theta-source audit.

Lean exposes:

```text
packetIdentificationSource
cuspBoundSource
targetAverageSource
targetAverageSource_eq_thetaPilotHullContainer
qSigned_le_thetaSigned
```

### Mathematical Point

The review object now records all three provenance layers:

```text
packet-normalized real-line identification source
cusp/zero bound source
target-to-average source
```

This is directly aimed at keeping the real-line identification and averaging
steps inspectable.

### Trap Avoided

The full summary requires an equality between the packet-normalized audit's
Theta source and the classified cusp route's Theta source.  This prevents a
summary from combining unrelated local and global routes.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_full_classified_summary_example
placeAudited_logVolume_fl_zmod_full_classified_target_source_example
```

### Remaining Gap

The full summary is a review surface, not a new theorem source.  The next
mathematical work should continue reducing the still-open analytic assumptions
behind capsule-entry container estimates and packet-normalized identifications.

## 76. Constructors for Full Classified Summaries

### Goal

We removed a manual Theta-source equality obligation from the common full-route
summary constructors.

### Lean Move

The full summary still stores:

```text
theta_source_eq
```

but Lean now constructs this equality automatically for the two standard
routes:

```text
FLZModCuspLabelThetaFullClassifiedRouteSummary.ofDirectCapsule
FLZModCuspLabelThetaFullClassifiedRouteSummary.ofInd2Transport
```

Each constructor takes a classified packet-normalized audit and either a direct
capsule route or an `(Ind2)`-transported route, plus an equality saying that
both routes use the same packet-normalized audit.  The Theta-source equality is
then definitional after rewriting by that packet equality.

### Mathematical Point

This reduces a possible bookkeeping error.  For the standard direct and
transported routes, one should not separately prove that the packet-normalized
Theta source and the cusp-route Theta source match; both are projected from the
same packet-normalized audit.

### Trap Avoided

We still require the packet-normalized audits to match.  Thus the constructor
does not allow unrelated packet and cusp routes to be combined.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_full_classified_direct_summary_example
placeAudited_logVolume_fl_zmod_full_classified_ind2_summary_example
```

### Remaining Gap

The next useful reduction is still mathematical: explain or derive the
packet-normalized identification itself, or the capsule-entry container
estimates, from more structured local source data.

## 77. Packet Local-Object Normalized Compatibility

### Goal

We isolated the equality between a packet's normalized capsule-family
log-volume and the finite log-volume of its local object.

### Lean Move

We added:

```text
IUTStage1LocalTensorPacketNormalizedCompatibility
```

for a local tensor packet log-volume state.  Its single field is:

```text
state.capsuleFamily.normalizedLogVolume =
  state.localObject.finiteLogVolume
```

Lean also exposes the reverse direction:

```text
localObject_finiteLogVolume_eq_normalizedLogVolume
```

and the induced average formula:

```text
state.localObject.finiteLogVolume =
  state.capsuleFamily.totalLogVolume /
    state.capsuleFamily.capsuleCount
```

Finally, `IUTStage1PacketNormalizedContainerEstimate` now has:

```text
ofLocalObjectCompatibility
```

This constructor builds a packet-normalized container estimate from:

```text
local object container estimate
same local object as packet
packet normalized compatibility
```

### Mathematical Point

The base packet state already recorded:

```text
capsuleFamily.localObject = localObject
```

but that only says the capsule family is attached to the same local object.  It
does not say that the real number obtained by averaging capsule log-volumes is
the same real number as the finite log-volume attached to that local object.

This distinction is important for the Corollary 3.12 dispute.  The debated
route cannot silently identify all relevant real lines or averages.  The new
compatibility object names the precise equality that a later, more source-close
formalization must prove from the local packet/capsule construction.

### Trap Avoided

We did not add the normalized equality as a field of the basic packet state.
Doing that would make every packet carry the disputed real-line identification
for free.  Instead, packet-normalized container estimates must now either carry
the equality directly, as before, or be constructed from this explicit
compatibility certificate.

### Toy Check

The examples now check:

```text
localTensorPacketNormalizedCompatibility_finite_eq_normalized_example
localTensorPacketNormalizedCompatibility_average_example
packetNormalizedContainerEstimate_of_local_compatibility_example
```

### Remaining Gap

The compatibility certificate is still an assumption at this layer.  The next
mathematical task is to connect it to a more concrete description of the local
tensor packet/capsule construction, or to classify its source as a direct packet
normalization, an `(Ind2)`-transported normalization, or a separate real-line
identification.

## 78. Classified Local Packet-Normalized Compatibility

### Goal

We moved the packet-normalized source classification down to the local
compatibility certificate itself.

### Lean Move

The source enum:

```text
IUTStage1PacketNormalizedIdentificationSource
```

is now available at the local compatibility layer.  We added:

```text
IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
```

It stores:

```text
compatibility
identification_source
```

with constructors:

```text
ofDirectPacketNormalization
ofInd2TransportedPacketNormalization
ofSeparateRealLineIdentification
```

`IUTStage1PacketNormalizedContainerEstimate` now also has:

```text
ofClassifiedLocalObjectCompatibility
```

so a packet-normalized estimate can be constructed from a classified local
compatibility certificate.

### Mathematical Point

The global packet-normalized audit already classified the source of the
real-line identification.  This refinement says the same provenance should be
visible at the local packet level, where the equality actually lives:

```text
capsuleFamily.normalizedLogVolume = localObject.finiteLogVolume
```

This is closer to the Scholze-Stix pressure point: the equality is not just a
global bookkeeping label; it is a local assertion that must be justified by a
specific route.

### Trap Avoided

The classification does not prove the compatibility.  It records how a proof is
being sourced.  This prevents us from treating an `(Ind2)`-transported
normalization and a separate real-line identification as interchangeable merely
because both end in the same equality type.

### Toy Check

The examples now check:

```text
classifiedLocalTensorPacketNormalizedCompatibility_direct_example
classifiedLocalTensorPacketNormalizedCompatibility_ind2_example
classifiedLocalTensorPacketNormalizedCompatibility_source_example
packetNormalizedContainerEstimate_of_classified_local_compatibility_example
```

### Remaining Gap

The next useful step is to connect classified local compatibility certificates
to the high-level `FLZModCuspLabelThetaClassifiedPacketNormalizedAudit`, so the
classification used by packet estimates and the classification reported by the
route summary cannot drift apart.

## 79. Local Classified Packet Audit to Global Route Classification

### Goal

We connected classified local packet-normalized compatibility certificates to
the high-level packet-normalized audit used in the route summary.

### Lean Move

We added:

```text
FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit
```

It carries:

```text
theta_source
Ind1/Ind2 equality part
Ind3 upper part
global identification_source
cusp-class local object estimates
cusp-class classified local compatibilities
zero local object estimates
zero classified local compatibility
source-equality checks for all local compatibilities
```

It converts to:

```text
FLZModCuspLabelThetaPacketNormalizedContainerAudit
FLZModCuspLabelThetaClassifiedPacketNormalizedAudit
```

The conversion constructs packet-normalized estimates from local object
estimates and classified local compatibility certificates.

### Mathematical Point

This closes a bookkeeping gap between the local equality:

```text
packet normalized capsule average = packet local object finite log-volume
```

and the global route summary's label:

```text
direct packet normalization
Ind2-transported packet normalization
separate real-line identification
```

Every local certificate now has to report the same source as the high-level
classified packet audit.

### Trap Avoided

Without the source-equality checks, the formalization could locally use
certificates classified as one kind of identification while globally summarizing
the route as another.  That would be a subtle provenance drift, especially near
the Corollary 3.12 real-line-identification issue.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_local_packet_to_global_example
placeAudited_logVolume_fl_zmod_classified_local_packet_source_example
```

### Remaining Gap

The local compatibility certificates are still not constructed from the actual
Mochizuki local packet/capsule definitions.  The next implementation step should
move toward the data that makes these certificates true, or toward the
transport theorem that carries a direct packet normalization through an audited
`(Ind2)` action.

## 80. Transporting Packet-Normalized Compatibility Across Ind2

### Goal

We proved that packet-normalized compatibility transports across the existing
`(Ind2)` action data.

### Lean Move

We added transport maps at three levels:

```text
IUTStage1TensorPacketTheorem311Choice
  .ind2_transports_packetNormalizedCompatibility
  .ind2_transports_classifiedPacketNormalizedCompatibility

IUTStage1DirectSummandPacketTheorem311Choice
  .ind2_transports_packetNormalizedCompatibility
  .ind2_transports_classifiedPacketNormalizedCompatibility

IUTStage1PlaceAuditedDirectSummandPacketChoice
  .ind2_transports_packetNormalizedCompatibility
  .ind2_transports_classifiedPacketNormalizedCompatibility
```

The classified transport relabels the target compatibility source as:

```text
ind2TransportedPacketNormalization
```

### Mathematical Point

The proof uses only data already recorded by the `(Ind2)` step:

```text
source normalized capsule log-volume =
  target normalized capsule log-volume

source local object =
  target local object
```

Given a source compatibility:

```text
source normalized capsule log-volume =
  source local object finite log-volume
```

Lean derives:

```text
target normalized capsule log-volume =
  target local object finite log-volume
```

This is a real mathematical reduction of an assumption: the target
packet-normalized compatibility no longer has to be independently asserted when
it is obtained by an audited `(Ind2)` transport from a source compatibility.

### Trap Avoided

We did not transport the compatibility using only equality of normalized
capsule-family values.  That would leave the finite local object on the target
side unidentified.  The proof also requires the `(Ind2)` step's
`local_object_eq` field.

### Toy Check

The examples now check:

```text
directSummandActionStep_transports_packet_compatibility_example
directSummandActionStep_transports_classified_packet_compatibility_example
placeAuditedDirectSummandPacketChoice_ind2_transports_packet_compatibility_example
placeAuditedDirectSummandPacketChoice_ind2_transports_classified_packet_compatibility_example
```

### Remaining Gap

We can now transport a source packet-normalization certificate.  We still need
to construct such source certificates from a more concrete local packet/capsule
definition, and then use transported certificates inside the classified local
packet audit automatically.

## 81. Ind2-Transported Local Packet Audit

### Goal

We packaged the transported packet-normalized compatibility theorem into the
local packet audit used by the high-level route.

### Lean Move

We added:

```text
FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit
```

For each target audited packet it carries:

```text
sourceAudited target
audited Ind2 step from source to target
target cusp/zero local object estimates
source cusp/zero classified packet-normalized compatibilities
```

It constructs:

```text
targetCuspClassCompatibility
targetZeroCompatibility
toClassifiedLocalPacketNormalizedAudit
toClassifiedPacketNormalizedAudit
```

The target compatibility source is definitionally:

```text
ind2TransportedPacketNormalization
```

### Mathematical Point

This is the packet-normalized analogue of the transported capsule-bound route.
Instead of assuming that the target cusp/zero log-volumes are packet-normalized
by a target-side real-line identification, the audit derives the target
packet-normalized compatibility from:

```text
source classified packet-normalized compatibility
audited Ind2 local tensor/direct-summand step
```

The local object estimates for the target cusp/zero values remain target-side
data.  The new reduction concerns the compatibility certificate equating the
target packet's normalized capsule average with its finite local object.

### Trap Avoided

The transported audit does not say that a source cusp-class value is the target
cusp-class value.  It only transports the packet-local normalization
compatibility through the audited `(Ind2)` step.  The target local object
estimate is still supplied for the target log-volume real.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_ind2_local_packet_to_global_example
placeAudited_logVolume_fl_zmod_ind2_local_packet_source_example
```

### Remaining Gap

The transported local packet audit still assumes source classified
packet-normalized compatibilities.  The next mathematical pressure point is to
construct direct source compatibilities from a more concrete model of the
packet/capsule normalization itself.

## 82. Direct Packet Normalization as a Capsule-Sum Formula

### Goal

We refined direct packet-normalized compatibility into a finite capsule-sum
normalization statement.

### Lean Move

We added:

```text
IUTStage1DirectPacketNormalizationData
```

For a local tensor packet state it records:

```text
localObject.finiteLogVolume =
  (sum over capsules of capsule.logVolume) / capsuleCount
```

Lean then derives:

```text
localObject.finiteLogVolume =
  capsuleFamily.totalLogVolume / capsuleCount

capsuleFamily.normalizedLogVolume =
  localObject.finiteLogVolume
```

and packages this as:

```text
toPacketNormalizedCompatibility
toClassifiedPacketNormalizedCompatibility
```

where the classified source is:

```text
directPacketNormalization
```

### Mathematical Point

This is closer to the concrete packet/capsule normalization than the previous
compatibility object.  The direct source is now not merely an equality between
two named real fields; it must identify the finite local object with the average
of the actual capsule log-volume entries.

This matters near Corollary 3.12 because the disputed step is sensitive to
which averages are being identified.  The Lean object now records the finite
sum over the packet's capsule family before producing the real-line
compatibility used by the downstream route.

### Trap Avoided

We did not redefine every packet state to make its local object finite
log-volume equal to the capsule average by default.  Direct normalization is a
separate certificate, so packets without this certificate cannot be used as
directly normalized packets.

### Toy Check

The examples now check:

```text
directPacketNormalizationData_to_compatibility_example
directPacketNormalizationData_capsule_average_example
directPacketNormalizationData_to_classified_compatibility_example
```

### Remaining Gap

The finite-sum formula is still a certificate, not a theorem from Mochizuki's
underlying packet construction.  The next useful refinement is to build
high-level direct local packet audits from this direct normalization data, just
as the transported audit now builds target compatibility from source
compatibility and an audited `(Ind2)` step.

## 83. Direct Local Packet Audit from Capsule-Sum Normalization

### Goal

We packaged direct finite-sum packet normalization into the high-level local
packet audit.

### Lean Move

We added:

```text
FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit
```

For each audited packet it carries:

```text
target cusp/zero local object estimates
direct finite-sum packet normalization data
```

It constructs:

```text
targetCuspClassCompatibility
targetZeroCompatibility
toClassifiedLocalPacketNormalizedAudit
toClassifiedPacketNormalizedAudit
```

and the target compatibility source is definitionally:

```text
directPacketNormalization
```

### Mathematical Point

This gives the direct route the same structure as the transported route.  A
direct packet-normalized audit no longer needs to assume opaque classified local
compatibilities.  It can be built from the finite capsule-sum formula:

```text
localObject.finiteLogVolume =
  average of the packet capsule log-volumes
```

The downstream packet-normalized container audit then follows through the
already checked conversion from direct normalization data to classified local
compatibility.

### Trap Avoided

The direct audit still requires target-side local object estimates for the
cusp/zero log-volume reals.  The finite-sum normalization only supplies the
packet-normalized compatibility; it does not by itself prove that a cusp-class
real is bounded or that it is the correct target real.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_local_packet_to_global_example
placeAudited_logVolume_fl_zmod_direct_local_packet_source_example
```

### Remaining Gap

The finite-sum normalization certificate should eventually be obtained from a
formal local packet/capsule construction.  The next practical step is to connect
the direct and `(Ind2)`-transported local packet audits to the existing full
route-summary constructors, reducing manual packet-audit assembly.

## 84. Full Routes from Local Packet Normalization Audits

### Goal

We connected the direct and `(Ind2)`-transported local packet-normalization
audits to the full classified route summaries.

### Lean Move

We added two route-input structures:

```text
FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit
FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit
```

The direct route combines:

```text
direct local packet normalization audit
direct target capsule estimates
```

The transported route combines:

```text
Ind2-transported local packet normalization audit
source capsule estimates
```

Each route constructs:

```text
toFullClassifiedRouteSummary
```

and exposes source checks:

```text
packetIdentificationSource = directPacketNormalization
cuspBoundSource = directCapsuleEstimates

packetIdentificationSource = ind2TransportedPacketNormalization
cuspBoundSource = ind2TransportedCapsuleEstimates
```

### Mathematical Point

The full route summary can now be assembled from the two actual mathematical
inputs we have isolated:

```text
packet-normalized compatibility source
cusp/zero capsule-bound source
```

For the direct route, both are target-side.  For the transported route, both use
an audited `(Ind2)` step from a source packet to the target packet.  This keeps
the packet-normalization source and the cusp-bound source aligned in the final
summary.

### Trap Avoided

The new route-input structures avoid manually combining a packet-normalized
audit with an unrelated cusp-bound audit.  The packet-normalized audit used by
the cusp route is projected from the same local packet-normalization audit used
by the full route summary.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_local_packet_full_route_example
placeAudited_logVolume_fl_zmod_ind2_local_packet_full_route_example
placeAudited_logVolume_fl_zmod_direct_local_packet_full_route_source_example
placeAudited_logVolume_fl_zmod_ind2_local_packet_full_route_source_example
```

### Remaining Gap

These full route inputs still assume local object estimates and direct
finite-sum packet normalization data.  The next mathematical step is to reduce
one of those assumptions from more concrete capsule/local-object data, or to
audit exactly where the local object estimates are supposed to enter from
Mochizuki's source definitions.

## 85. Local Object Bounds from Direct Packet Normalization

### Goal

We reduced a local object estimate obligation from direct packet normalization
and capsule-entry estimates.

### Lean Move

For:

```text
IUTStage1DirectPacketNormalizationData state
```

Lean now proves:

```text
targetSigned <= every capsule log-volume
  -> targetSigned <= state.localObject.finiteLogVolume
```

and the bundled version:

```text
IUTStage1TypedCapsuleFamilyContainerEstimate
  targetSigned state.capsuleFamily
  -> targetSigned <= state.localObject.finiteLogVolume
```

Lean also constructs:

```text
toLocalObjectContainerEstimateOfCapsuleEstimates
```

which returns a local object container estimate for:

```text
state.localObject.finiteLogVolume
```

### Mathematical Point

This is the first direct bridge from capsule-entry bounds to a local object
container estimate.  The proof goes through the finite average:

```text
targetSigned <= each capsule log-volume
  -> targetSigned <= normalized capsule average
  -> targetSigned <= localObject.finiteLogVolume
```

where the final step uses the direct packet normalization certificate.

### Trap Avoided

The theorem does not say that an arbitrary cusp-class real is the local object
finite log-volume.  It constructs an estimate specifically for
`state.localObject.finiteLogVolume`.  Any use for a cusp/zero log-volume still
requires an explicit equality or transport of the log-volume real.

### Toy Check

The examples now check:

```text
directPacketNormalizationData_capsule_estimates_bound_localObject_example
directPacketNormalizationData_capsule_estimates_to_localObject_example
```

### Remaining Gap

The high-level direct local packet audit still takes target cusp/zero local
object estimates directly.  A future refinement can use this theorem when the
cusp/zero log-volume is explicitly identified with the packet local object's
finite log-volume.

## 86. Local Object Estimates for Identified Log-Volumes

### Goal

We made the capsule-derived local object estimate reusable for an explicitly
identified log-volume real.

### Lean Move

`IUTStage1DirectPacketNormalizationData` now has:

```text
toLocalObjectContainerEstimateOfIdentifiedLogVolume
```

It takes:

```text
capsule-family container estimates
localLogVolume = packet local object finiteLogVolume
```

and returns:

```text
IUTStage1LocalObjectContainerLogVolumeEstimate kind targetSigned localLogVolume
```

### Mathematical Point

This is the small bridge needed for future cusp/zero refinements.  If a
cusp-class or zero log-volume is explicitly identified with the packet local
object's finite log-volume, then capsule-entry bounds plus direct packet
normalization give the corresponding local object estimate.

### Trap Avoided

The equality to the packet local object's finite log-volume is still an input.
Lean does not infer that a cusp/zero log-volume is the local object value merely
because the packet is directly normalized.

### Toy Check

The examples now check:

```text
directPacketNormalizationData_capsule_estimates_to_identified_log_example
```

### Remaining Gap

The next step is to expose the cusp/zero-to-local-object finite-log-volume
identifications at the high-level direct local packet audit, so these estimates
can be constructed rather than supplied manually.

## 87. Direct Identified Local Packet Route

### Goal

We reduced the direct local packet route so that cusp/zero local object
estimates are constructed from smaller data.

### Lean Move

We added:

```text
FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit
```

It carries:

```text
target capsule-family container estimates
direct packet normalization data
cusp-class log-volume = packet local object finiteLogVolume
zero log-volume = packet local object finiteLogVolume
```

From this Lean constructs:

```text
cuspClassObjectEstimate
zeroObjectEstimate
toDirectLocalPacketNormalizedAudit
toDirectLocalPacketDirectCapsuleRouteAudit
toFullClassifiedRouteSummary
```

The resulting full route has:

```text
packetIdentificationSource = directPacketNormalization
cuspBoundSource = directCapsuleEstimates
```

### Mathematical Point

This removes one layer of manual input from the direct route.  Previously the
high-level direct packet audit required local object container estimates for all
cusp-class and zero log-volumes.  Now those estimates are derived from:

```text
capsule-entry bounds
direct finite-sum packet normalization
explicit equality between the cusp/zero log-volume and the packet local object
```

This is exactly the kind of reduction we want near Corollary 3.12: the equality
that identifies a log-volume real with the packet local object is still a named
input, while the resulting bound is checked by Lean.

### Trap Avoided

The new route does not assert that cusp/zero log-volumes automatically equal
the packet local object value.  Those equalities are explicit fields.  Thus the
Scholze-Stix real-line-identification concern remains visible at the point where
it is used.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_direct_identified_packet_to_direct_example
placeAudited_logVolume_fl_zmod_direct_identified_packet_full_route_example
placeAudited_logVolume_fl_zmod_direct_identified_packet_source_example
```

### Remaining Gap

The direct identified route still assumes the cusp/zero-to-local-object
finite-log-volume equalities.  The next mathematical task is to trace those
equalities back to the source definitions of the cusp-compatible label average,
or to classify them as separate real-line identifications if no source-close
construction is available.

## 88. Classifying Local Object Log-Volume Identifications

### Goal

We classified the source of the cusp/zero-to-local-object log-volume
identifications used by the direct identified route.

### Lean Move

We added:

```text
IUTStage1LocalObjectLogVolumeIdentificationSource
```

with cases:

```text
directLocalObjectConstruction
packetNormalizationAndLocalObjectCompatibility
separateRealLineIdentification
```

We also added:

```text
FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit
```

It packages:

```text
direct identified local packet route
cusp-class identification source for each audited packet and label
zero-label identification source for each audited packet
```

and still exposes the same full route summary, packet source, and cusp-bound
source as the underlying direct identified route.

### Mathematical Point

The new classification distinguishes two equalities that were easy to conflate:

```text
cusp/zero log-volume = packet normalized capsule average
packet normalized capsule average = packet local object finiteLogVolume
```

The direct identified route uses the composed target:

```text
cusp/zero log-volume = packet local object finiteLogVolume
```

Lean now records where that equality is meant to come from.  This is directly
relevant to the Scholze-Stix pressure point: if the equality is only a separate
real-line identification, it must be visible as such.

### Trap Avoided

We did not reuse `IUTStage1PacketNormalizedIdentificationSource` for this
local-object equality.  Packet normalization and cusp/zero-to-local-object
identification are related but distinct proof obligations.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_direct_identified_separate_example
placeAudited_logVolume_fl_zmod_classified_direct_identified_packet_example
placeAudited_logVolume_fl_zmod_classified_direct_identified_source_example
```

### Remaining Gap

The classified route still carries the equality proofs themselves.  The next
source-facing refinement should derive the packet-normalization/local-object
case from an explicit pair of equalities:

```text
cusp/zero log-volume = packet normalized capsule average
packet normalized capsule average = local object finiteLogVolume
```

## 89. Deriving Local Object Equalities from Packet-Normalized Equalities

### Goal

We derived the cusp/zero-to-local-object finite-log-volume equalities from two
smaller equalities.

### Lean Move

We added:

```text
FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit
```

It carries:

```text
target capsule-family container estimates
direct packet normalization data
cusp-class log-volume = packet normalized capsule average
zero log-volume = packet normalized capsule average
```

Lean then proves:

```text
cusp-class log-volume = packet local object finiteLogVolume
zero log-volume = packet local object finiteLogVolume
```

and constructs:

```text
toDirectIdentifiedLocalPacketRouteAudit
toClassifiedDirectIdentifiedLocalPacketRouteAudit
toFullClassifiedRouteSummary
```

### Mathematical Point

The proof composes exactly the two equalities that should be separately
auditable:

```text
cusp/zero log-volume = packet normalized capsule average
packet normalized capsule average = packet local object finiteLogVolume
```

The second equality comes from direct finite-sum packet normalization.  Thus the
combined local-object equality is no longer a primitive field in this route.

### Trap Avoided

We did not identify cusp/zero values with the packet local object merely from
direct packet normalization.  The route still requires the first equality,
namely the explicit cusp/zero-to-packet-normalized comparison.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_packet_normalized_local_object_to_identified_example
placeAudited_logVolume_fl_zmod_packet_normalized_local_object_eq_example
placeAudited_logVolume_fl_zmod_packet_normalized_local_object_full_route_example
```

### Remaining Gap

The route still assumes the cusp/zero-to-packet-normalized equalities.  The next
source-facing work is to trace those equalities back to the cusp-compatible
label average and the packet/capsule construction, or keep them explicitly
classified as separate real-line identifications.

## 90. Self-Review: Packet-Normalized Local Object Route

### Scope Checked

This review checked the current direct packet-normalized/local-object route
against the Corollary 3.12 dispute surface.

### Current Lean Chain

The direct source-facing route now factors the target-to-average path through
the following pieces:

```text
capsule-entry estimates
direct finite-sum packet normalization
cusp/zero = packet normalized capsule average
packet normalized capsule average = packet local object finiteLogVolume
local object estimate for cusp/zero log-volume
packet-normalized container audit
cusp-class/zero bounds
label average bound
theta-pilot hull container route
qSigned <= thetaSigned
```

Lean has checked the following derived route packages:

```text
FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit
FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit
FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit
FLZModCuspLabelThetaFullClassifiedRouteSummary
```

### Alignment With the Papers and Dispute

This remains aligned with the IUT III Theorem 3.11 to Corollary 3.12 boundary:
the formalization still treats the holomorphic hull/Theta-pilot route as the
target route, while keeping the local packet and label-average identifications
explicit.

The Scholze-Stix warning is still visible in the Lean data.  The route cannot
use a cusp or zero log-volume as a packet local object unless it supplies either
an explicit equality or a structured derivation from:

```text
cusp/zero = packet normalized capsule average
packet normalized capsule average = packet local object finiteLogVolume
```

### Current Assumptions

The largest remaining source assumptions in this part of the route are:

```text
cusp/zero log-volume = packet normalized capsule average
direct finite-sum packet normalization data
capsule-entry container estimates
```

The first is the most sensitive real-line identification.  The second should
eventually come from a concrete local packet/capsule construction.  The third
is the analytic estimate layer.

### Verification

Before this review, the worktree was clean.  Focused builds and full `lake
build` had passed after the last committed milestone.  A search for Lean holes
found no `sorry`, `admit`, `axiom`, or actual unsafe declaration in the Stage 1
Lean files; the only match was the word "unsafe" inside a prose comment.

### Next Step

The next useful implementation target is the first remaining assumption:
classify or derive the cusp/zero-to-packet-normalized equalities from the
cusp-compatible label average and packet/capsule side, rather than treating them
as unstructured fields.

## 91. Cusp/Zero to Packet-Normalized Equalities from ZMod Labels

### Goal

We derived cusp/zero-to-packet-normalized equalities from the `ZMod l` averaged
label family.

### Lean Move

At the cusp-label compatibility layer we added:

```text
zmod_toSignLabelQuotient_eq_fromCoordinate
IUTStage1ZModCuspLabelLogVolumeCompatibility
  .cuspClass_eq_of_normalizedLogVolume_eq
  .zeroLogVolume_eq_of_normalizedLogVolume_eq
```

The key theorem says: if every `ZMod l` normalized log-volume is equal to a
constant `c`, then every cusp sign-label class log-volume and the zero
log-volume are also equal to `c`.

We then added:

```text
FLZModCuspLabelThetaZModPacketNormalizedRouteAudit
```

It carries:

```text
target capsule estimates
direct packet normalization data
ZMod averaged normalized log-volume = packet normalized capsule average
```

Lean derives:

```text
cusp-class log-volume = packet normalized capsule average
zero log-volume = packet normalized capsule average
```

and then constructs:

```text
toDirectPacketNormalizedLocalObjectRouteAudit
toFullClassifiedRouteSummary
```

### Mathematical Point

The important step is quotient induction over the sign-label quotient.  The
formalization does not prove the cusp-class equality only for displayed
nonzero representatives.  It proves it for every sign-label class by using the
definition of the quotient by the `{±1}` sign relation.

This reduces the previous assumption:

```text
cusp/zero log-volume = packet normalized capsule average
```

to the more source-facing statement:

```text
ZMod l averaged normalized log-volume at every label =
  packet normalized capsule average
```

together with the already formalized cusp-label compatibility.

### Trap Avoided

We did not assume that all sign-label classes have representatives in an
informal way.  Lean uses the actual quotient type and proves the result by
quotient induction.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_zmod_packet_normalized_to_local_object_example
placeAudited_logVolume_fl_zmod_zmod_packet_normalized_cusp_eq_example
placeAudited_logVolume_fl_zmod_zmod_packet_normalized_full_route_example
```

### Remaining Gap

The route still assumes the equality between each `ZMod l` averaged normalized
log-volume and the packet normalized capsule average.  The next source-facing
task is to derive or classify this labelwise packet bridge from the local
packet/capsule construction and the `(Ind1)/(Ind2)` label-averaged audit.

## 92. Classifying the ZMod-to-Packet-Normalized Bridge

### Goal

We classified the source of the bridge from the `ZMod l` averaged normalized
log-volume family to packet-normalized capsule-family values.

### Lean Move

We added:

```text
IUTStage1ZModPacketNormalizedBridgeSource
```

with cases:

```text
directLabelPacketNormalization
ind12TransportedLabelPacketNormalization
separateAveragingIdentification
```

We also added:

```text
FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit
```

It packages:

```text
FLZModCuspLabelThetaZModPacketNormalizedRouteAudit
bridge_source
```

and preserves the full route summary, packet-identification source, and
cusp-bound source exposed by the underlying route.

### Mathematical Point

The remaining bridge:

```text
ZMod averaged normalized log-volume(j) =
  packet normalized capsule average
```

is now a named and classified interface.  This is distinct from both:

```text
cusp/zero = packet normalized
packet normalized = local object finiteLogVolume
```

The classification tells us whether the bridge is intended to come from a
direct label/packet normalization construction, from `(Ind1)/(Ind2)` transport
of such a construction, or from a separate averaging identification.

### Trap Avoided

We did not report the final route as direct packet normalization while leaving
the label-to-packet bridge untracked.  The bridge source is now visible as its
own piece of provenance.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_classified_zmod_packet_direct_example
placeAudited_logVolume_fl_zmod_classified_zmod_packet_separate_example
placeAudited_logVolume_fl_zmod_classified_zmod_packet_source_example
```

### Remaining Gap

The classification still does not prove the bridge.  The next step is to reduce
the direct case to an explicit equality between each label value and the packet
capsule-family normalized value, or to build an `(Ind1)/(Ind2)` transport layer
for this bridge.

## 93. Constant ZMod Label Family as Direct Packet Bridge

### Goal

We reduced the direct `ZMod`-to-packet-normalized bridge to an equality of
label-averaged log-volume objects.

### Lean Move

We added:

```text
IUTStage1LabelAveragedProcessionLogVolume.constant
```

for a finite nonempty label type.  It is the label-averaged log-volume object
whose normalized value is constantly `c` and whose average is also `c`.

We then added:

```text
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
```

It carries:

```text
target capsule estimates
direct packet normalization data
averaged ZMod log-volume object =
  constant packet-normalized label object
```

Lean derives:

```text
ZMod averaged normalized log-volume(j) =
  packet normalized capsule average
```

and then reuses the route from Section 91.

### Mathematical Point

The bridge is now one step more concrete.  Instead of asking for a separate
pointwise equality at every label, the direct route can state that the whole
`ZMod l` averaged label family is the constant packet-normalized family.  The
pointwise equality used downstream is obtained by projecting the normalized
log-volume function from this object equality.

### Trap Avoided

The constant family is explicit.  We do not silently replace a nonconstant label
family by its average.  This is important because the Scholze-Stix critique is
sensitive to averaging and identification: equality of averages is not equality
of labelwise values.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_constant_zmod_packet_to_zmod_example
placeAudited_logVolume_fl_zmod_constant_zmod_packet_eq_example
placeAudited_logVolume_fl_zmod_constant_zmod_packet_full_route_example
```

### Remaining Gap

The object equality with the constant packet-normalized label family is still
an assumption.  The next refinement should either construct this equality from
a concrete local label/capsule definition or classify it as a separate
averaging identification when it cannot be source-derived.

## 94. Theta Average from Constant ZMod Packet Family

### Goal

We connected the constant `ZMod` label-family bridge directly to the
Theta-source average bound.

### Lean Move

For:

```text
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
```

we added:

```text
thetaSourceAverage_eq_packetNormalized
targetSigned_le_thetaSourceAverage
```

The first theorem says that if the audited `ZMod l` averaged log-volume object
is literally the constant packet-normalized family, then the
`thetaSourceAverage` is the packet capsule-family normalized log-volume.

The second theorem composes this equality with the previously audited target
capsule estimate:

```text
targetSigned <= packet normalized log-volume
```

to obtain:

```text
targetSigned <= thetaSourceAverage
```

### Mathematical Point

This is a small but important closure step.  Section 93 projected the constant
family equality labelwise.  Here we also project it at the averaged-value level.
The formal route now exposes both:

```text
each ZMod label value = packet normalized value
Theta-source average = packet normalized value
```

and the target bound comes from the capsule estimate, not from an untracked
average comparison.

### Trap Avoided

We did not infer the target bound from a generic "average should behave well"
principle.  The proof uses the explicit equality between the Theta-source
average and the packet-normalized capsule value, then applies the audited
capsule estimate.  This keeps the averaging bridge visible at the exact point
where the Corollary 3.12-style target inequality is derived.

### Toy Check

The examples now check:

```text
placeAudited_logVolume_fl_zmod_constant_zmod_average_eq_example
placeAudited_logVolume_fl_zmod_constant_zmod_target_bound_example
```

### Remaining Gap

The constant label-family equality is still assumed.  The next mathematical
task is to stop treating it as primitive in the direct route: either construct
it from the local `ZMod`/cusp label definitions and packet normalization data,
or split the route into explicit direct and separately supplied averaging
identification cases.
