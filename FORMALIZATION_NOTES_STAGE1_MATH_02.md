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
