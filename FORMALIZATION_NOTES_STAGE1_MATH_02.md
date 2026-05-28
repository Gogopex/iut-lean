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
