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
