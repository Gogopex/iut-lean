/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.InitialThetaData
import Iut.Stage1.IUTStage1Data
import Mathlib.Data.ZMod.ValMinAbs

/-!
First non-toy source-facing package for the Stage 1 IUT scaffold.

The package names the IUT III Theorem 3.11 to Corollary 3.12 data boundary, but
it does not prove that the source mathematics supplies the remaining promotion
obligations. Those obligations are restated explicitly below and must be supplied
before any public Stage 1 endpoint is available.
-/

namespace Iut
namespace Stage1

open RealLineCopy
open scoped BigOperators

universe u v w x

/-- A prime `l ≥ 5` is nonzero, so `ZMod l.value` has its finite model. -/
instance primeGeFiveValueNeZero (l : PrimeGeFive) : NeZero l.value :=
  ⟨l.ne_zero⟩

/-- Inert identifier for a pilot object in the source-facing Stage 1 package. -/
structure PilotObjectId where
  label : String

/-- Inert identifier for the log-Kummer correspondence used in Stage 1. -/
structure LogKummerCorrespondenceId where
  label : String

/-- Inert identifier for the indeterminacy profile `(Ind1)`, `(Ind2)`, `(Ind3)`. -/
structure IndeterminacyProfileId where
  label : String

/-- Inert identifier for the q-pilot log-volume sign datum. -/
structure QPilotLogVolumeId where
  label : String

/-- Inert identifier for the source normalization datum. -/
structure SourceNormalizationId where
  label : String

/-- Inert identifier for a named checkpoint in the Theorem 3.11 to Corollary 3.12 route. -/
structure TransitionCheckpointId where
  label : String

/--
Bookkeeping data for a Hodge-theater/descent bridge at the Stage 1 boundary.

This record is still inert: it does not construct the bridge.  It prevents a
future Hodge-theater/descent explanation from being represented as an unnamed
packet comparison by requiring explicit theater histories, descent operation,
zero-column checkpoint, and indeterminacy profile.
-/
structure IUTStage1HodgeTheaterDescentBridgeData where
  domainTheater : QualitativeData.HodgeTheaterId
  codomainTheater : QualitativeData.HodgeTheaterId
  descent : AlgorithmicOutput.DescentOperationId
  zeroColumnCheckpoint : TransitionCheckpointId
  indeterminacyProfile : IndeterminacyProfileId
  histories_not_identified : domainTheater.side ≠ codomainTheater.side

/--
Source-facing labels for the IUT III Theorem 3.11 to Corollary 3.12 boundary.

These labels carry no proof content. They are bookkeeping names for the objects
that the local source text describes before the final signed real comparison.
-/
structure IUTStage1SourceLabels where
  input : Stage1InputId
  multiradialOutput : MultiradialOutputId
  logVolumeComparison : LogVolumeComparisonId
  thetaPilot : PilotObjectId
  qPilot : PilotObjectId
  logKummer : LogKummerCorrespondenceId
  indeterminacies : IndeterminacyProfileId
  qPilotLogVolume : QPilotLogVolumeId
  sourceNormalization : SourceNormalizationId

/-- Default inert labels for the current non-toy Stage 1 source placeholder. -/
def theorem311ToCorollary312Labels : IUTStage1SourceLabels :=
  { input := { label := "IUT III Theorem 3.11 situation" },
    multiradialOutput := { label := "Theorem 3.11 multiradial output" },
    logVolumeComparison := { label := "Corollary 3.12 log-volume comparison" },
    thetaPilot := { label := "Theta-pilot object" },
    qPilot := { label := "q-pilot object" },
    logKummer := { label := "1-column log-Kummer correspondence" },
    indeterminacies := { label := "Ind1-Ind2-Ind3 profile" },
    qPilotLogVolume := { label := "q-pilot log-volume sign datum" },
    sourceNormalization := { label := "source normalization datum" } }

def fourthTriangleHDDSHECheckpoint : TransitionCheckpointId :=
  { label := "fourth triangle HDD after SHE" }

def simultaneousComparisonCheckpoint : TransitionCheckpointId :=
  { label := "simultaneous common-container comparison" }

def theorem3115ToCorollary312Checkpoint : TransitionCheckpointId :=
  { label := "3.11.5 to Corollary 3.12 final comparison" }

/--
Non-toy source package for future IUT Stage 1 data.

The package records that a pre-ledger object is being treated as the source data
for the Theorem 3.11 to Corollary 3.12 boundary. It also records that the generic
pre-ledger labels agree with the source-facing labels.
-/
structure IUTStage1SourcePackage (source target : Copy) (index : Type u) where
  labels : IUTStage1SourceLabels
  preLedger : IUTStage1PreLedgerData source target index
  input_eq : preLedger.input = labels.input
  multiradialOutput_eq : preLedger.multiradialOutput = labels.multiradialOutput
  logVolumeComparison_eq :
    preLedger.logVolumeComparison = labels.logVolumeComparison

namespace IUTStage1SourcePackage

variable {source target : Copy} {index : Type u}

def input (package : IUTStage1SourcePackage source target index) :
    Stage1InputId :=
  package.preLedger.input

def multiradialOutput (package : IUTStage1SourcePackage source target index) :
    MultiradialOutputId :=
  package.preLedger.multiradialOutput

def logVolumeComparison
    (package : IUTStage1SourcePackage source target index) :
    LogVolumeComparisonId :=
  package.preLedger.logVolumeComparison

def thetaPilot (package : IUTStage1SourcePackage source target index) :
    PilotObjectId :=
  package.labels.thetaPilot

def qPilot (package : IUTStage1SourcePackage source target index) :
    PilotObjectId :=
  package.labels.qPilot

def logKummer (package : IUTStage1SourcePackage source target index) :
    LogKummerCorrespondenceId :=
  package.labels.logKummer

def indeterminacies (package : IUTStage1SourcePackage source target index) :
    IndeterminacyProfileId :=
  package.labels.indeterminacies

def qPilotLogVolume (package : IUTStage1SourcePackage source target index) :
    QPilotLogVolumeId :=
  package.labels.qPilotLogVolume

def sourceNormalizationLabel
    (package : IUTStage1SourcePackage source target index) :
    SourceNormalizationId :=
  package.labels.sourceNormalization

theorem input_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.input = package.labels.input :=
  package.input_eq

theorem multiradialOutput_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.multiradialOutput = package.labels.multiradialOutput :=
  package.multiradialOutput_eq

theorem logVolumeComparison_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.logVolumeComparison = package.labels.logVolumeComparison :=
  package.logVolumeComparison_eq

theorem qPilotLogVolume_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.qPilotLogVolume = package.labels.qPilotLogVolume :=
  rfl

theorem sourceNormalization_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.sourceNormalizationLabel = package.labels.sourceNormalization :=
  rfl

theorem thetaPilot_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.thetaPilot = package.labels.thetaPilot :=
  rfl

theorem qPilot_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.qPilot = package.labels.qPilot :=
  rfl

theorem logKummer_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.logKummer = package.labels.logKummer :=
  rfl

theorem indeterminacies_matches_labels
    (package : IUTStage1SourcePackage source target index) :
    package.indeterminacies = package.labels.indeterminacies :=
  rfl

end IUTStage1SourcePackage

/--
Source-facing coric data visible at the Stage 1 boundary.

This packages the common-container/SHE/HDD data that is intended to survive the
erasure of representative-dependent indeterminacy coordinates.
-/
structure IUTStage1CoricData
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) where
  multiradialOutput : MultiradialOutputId
  commonContainer : AlgorithmicOutput.CommonContainerId
  sharedContext : QualitativeData.SharedHolomorphicContext
  commonLanguage : QualitativeData.CommonLanguageId
  hdd :
    package.preLedger.output.HDDCompositeData
      package.preLedger.measure package.preLedger.thetaSigned
  multiradial_output_eq : multiradialOutput = package.multiradialOutput
  common_container_eq :
    commonContainer =
      package.preLedger.chartedContainer.commonContainer.container
  shared_context_eq :
    sharedContext =
      package.preLedger.chartedContainer.commonContainer.context
  common_language_eq : commonLanguage = sharedContext.commonLanguage
  hdd_eq :
    hdd = package.preLedger.chartedContainer.commonContainer.hddShe.hdd

namespace IUTStage1CoricData

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

def ofPackage
    (package : IUTStage1SourcePackage source target index) :
    IUTStage1CoricData package :=
  { multiradialOutput := package.multiradialOutput,
    commonContainer :=
      package.preLedger.chartedContainer.commonContainer.container,
    sharedContext :=
      package.preLedger.chartedContainer.commonContainer.context,
    commonLanguage :=
      package.preLedger.chartedContainer.commonContainer.context.commonLanguage,
    hdd := package.preLedger.chartedContainer.commonContainer.hddShe.hdd,
    multiradial_output_eq := rfl,
    common_container_eq := rfl,
    shared_context_eq := rfl,
    common_language_eq := rfl,
    hdd_eq := rfl }

theorem multiradialOutputMatchesPackage
    (coricData : IUTStage1CoricData package) :
    coricData.multiradialOutput = package.multiradialOutput :=
  coricData.multiradial_output_eq

theorem commonContainerMatchesPackage
    (coricData : IUTStage1CoricData package) :
    coricData.commonContainer =
      package.preLedger.chartedContainer.commonContainer.container :=
  coricData.common_container_eq

theorem sharedContextMatchesPackage
    (coricData : IUTStage1CoricData package) :
    coricData.sharedContext =
      package.preLedger.chartedContainer.commonContainer.context :=
  coricData.shared_context_eq

theorem commonLanguageMatchesSharedContext
    (coricData : IUTStage1CoricData package) :
    coricData.commonLanguage = coricData.sharedContext.commonLanguage :=
  coricData.common_language_eq

theorem hddMatchesPackage
    (coricData : IUTStage1CoricData package) :
    coricData.hdd =
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd :=
  coricData.hdd_eq

end IUTStage1CoricData

/--
Source-facing family of possible Theta-pilot images.

The family records that the target regions in the pre-ledger output are being
read as the possible images of the Theta-pilot object, indexed by the current
indeterminacy choices.
-/
structure IUTStage1ThetaPilotPossibleImages
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) where
  thetaPilot : PilotObjectId
  indeterminacies : IndeterminacyProfileId
  images : RegionFamily target index
  theta_pilot_eq : thetaPilot = package.thetaPilot
  indeterminacies_eq : indeterminacies = package.indeterminacies
  images_eq_targetRegions :
    images = package.preLedger.output.comparisons.targetRegions

namespace IUTStage1ThetaPilotPossibleImages

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

def ofPackage
    (package : IUTStage1SourcePackage source target index) :
    IUTStage1ThetaPilotPossibleImages package :=
  { thetaPilot := package.thetaPilot,
    indeterminacies := package.indeterminacies,
    images := package.preLedger.output.comparisons.targetRegions,
    theta_pilot_eq := rfl,
    indeterminacies_eq := rfl,
    images_eq_targetRegions := rfl }

def union (images : IUTStage1ThetaPilotPossibleImages package) :
    Region target :=
  images.images.union

theorem union_eq_targetUnion
    (images : IUTStage1ThetaPilotPossibleImages package) :
    images.union = package.preLedger.output.comparisons.targetUnion := by
  unfold union RegionComparisonFamily.targetUnion
  rw [images.images_eq_targetRegions]

theorem choice_region_eq_targetRegion
    (images : IUTStage1ThetaPilotPossibleImages package) (choice : index) :
    images.images.region choice =
      (package.preLedger.output.comparison choice).targetRegion := by
  rw [images.images_eq_targetRegions]
  rfl

theorem union_subset_target
    (images : IUTStage1ThetaPilotPossibleImages package)
    {targetRegion : Region target}
    (hsubset :
      Region.Subset package.preLedger.output.comparisons.targetUnion
        targetRegion) :
    Region.Subset images.union targetRegion := by
  rw [images.union_eq_targetUnion]
  exact hsubset

theorem thetaPilotMatchesPackage
    (images : IUTStage1ThetaPilotPossibleImages package) :
    images.thetaPilot = package.thetaPilot :=
  images.theta_pilot_eq

theorem indeterminaciesMatchPackage
    (images : IUTStage1ThetaPilotPossibleImages package) :
    images.indeterminacies = package.indeterminacies :=
  images.indeterminacies_eq

end IUTStage1ThetaPilotPossibleImages

/--
Whether a pilot object is read modulo the Theorem 3.11 indeterminacies in the
statement of IUT III, Corollary 3.12.
-/
inductive IUTStage1Corollary312PilotIndeterminacyStatus where
  | subjectToIndeterminacies
  | notSubjectToIndeterminacies
deriving DecidableEq, Repr

namespace IUTStage1Corollary312PilotIndeterminacyStatus

theorem subject_ne_notSubject :
    subjectToIndeterminacies ≠ notSubjectToIndeterminacies := by
  intro h
  cases h

theorem notSubject_ne_subject :
    notSubjectToIndeterminacies ≠ subjectToIndeterminacies := by
  intro h
  cases h

end IUTStage1Corollary312PilotIndeterminacyStatus

/--
Statement-level indeterminacy boundary in IUT III, Corollary 3.12.

The source regards the Theta-pilot possible-image log-volume as subject to
`(Ind1)`, `(Ind2)`, `(Ind3)`, but explicitly does not regard the q-pilot
log-volume as subject to these indeterminacies.
-/
structure IUTStage1Corollary312PilotIndeterminacyBoundary where
  thetaPilot : PilotObjectId
  qPilot : PilotObjectId
  indeterminacies : IndeterminacyProfileId
  thetaStatus : IUTStage1Corollary312PilotIndeterminacyStatus
  qStatus : IUTStage1Corollary312PilotIndeterminacyStatus
  theta_status :
    thetaStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.subjectToIndeterminacies
  q_status :
    qStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.notSubjectToIndeterminacies

namespace IUTStage1Corollary312PilotIndeterminacyBoundary

def ofLabels (labels : IUTStage1SourceLabels) :
    IUTStage1Corollary312PilotIndeterminacyBoundary :=
  { thetaPilot := labels.thetaPilot,
    qPilot := labels.qPilot,
    indeterminacies := labels.indeterminacies,
    thetaStatus :=
      IUTStage1Corollary312PilotIndeterminacyStatus.subjectToIndeterminacies,
    qStatus :=
      IUTStage1Corollary312PilotIndeterminacyStatus.notSubjectToIndeterminacies,
    theta_status := rfl,
    q_status := rfl }

theorem thetaSubject
    (data : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    data.thetaStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.subjectToIndeterminacies :=
  data.theta_status

theorem qNotSubject
    (data : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    data.qStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.notSubjectToIndeterminacies :=
  data.q_status

theorem thetaStatus_ne_qStatus
    (data : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    data.thetaStatus ≠ data.qStatus := by
  rw [data.theta_status, data.q_status]
  exact IUTStage1Corollary312PilotIndeterminacyStatus.subject_ne_notSubject

theorem qStatus_ne_thetaStatus
    (data : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    data.qStatus ≠ data.thetaStatus := by
  rw [data.theta_status, data.q_status]
  exact IUTStage1Corollary312PilotIndeterminacyStatus.notSubject_ne_subject

end IUTStage1Corollary312PilotIndeterminacyBoundary

/-- Source-facing placeholder for the `(Ind1)` indeterminacy in Theorem 3.11. -/
def theorem311Ind1 : Indeterminacy :=
  { name := "Ind1",
    actsOnLogShells := true,
    absorbedByHull := true }

/-- Source-facing placeholder for the `(Ind2)` indeterminacy in Theorem 3.11. -/
def theorem311Ind2 : Indeterminacy :=
  { name := "Ind2",
    actsOnLogShells := true,
    absorbedByHull := true }

/-- Source-facing placeholder for the `(Ind3)` indeterminacy in Theorem 3.11. -/
def theorem311Ind3 : Indeterminacy :=
  { name := "Ind3",
    actsOnLogShells := true,
    absorbedByHull := true }

/-- The named `(Ind1)`, `(Ind2)`, `(Ind3)` profile used at the Stage 1 boundary. -/
def theorem311IndeterminacyProfile : IndeterminacyProfile :=
  [theorem311Ind1, theorem311Ind2, theorem311Ind3]

/--
Indeterminacy quotient for the possible-image index set.

The relation records when two choices determine the same multiradial
Theta-pilot image after quotienting by `(Ind1)`, `(Ind2)`, `(Ind3)`.
For Corollary 3.12 this is only a choice-index quotient interface: IUT III,
Step (x), supplies log-volume invariance for `(Ind1)`, `(Ind2)` and converts
`(Ind3)` into an upper bound, not an automatic equality of regions.
-/
structure IUTStage1IndeterminacyQuotient (index : Type u) where
  ind1 : Indeterminacy
  ind2 : Indeterminacy
  ind3 : Indeterminacy
  relation : index -> index -> Prop
  is_equivalence : Equivalence relation
  ind1_name : ind1.name = "Ind1"
  ind2_name : ind2.name = "Ind2"
  ind3_name : ind3.name = "Ind3"

namespace IUTStage1IndeterminacyQuotient

variable {index : Type u}

def profile (quotient : IUTStage1IndeterminacyQuotient index) :
    IndeterminacyProfile :=
  [quotient.ind1, quotient.ind2, quotient.ind3]

theorem refl (quotient : IUTStage1IndeterminacyQuotient index)
    (choice : index) :
    quotient.relation choice choice :=
  quotient.is_equivalence.refl choice

theorem symm (quotient : IUTStage1IndeterminacyQuotient index)
    {choice₁ choice₂ : index}
    (hrel : quotient.relation choice₁ choice₂) :
    quotient.relation choice₂ choice₁ :=
  quotient.is_equivalence.symm hrel

theorem trans (quotient : IUTStage1IndeterminacyQuotient index)
    {choice₁ choice₂ choice₃ : index}
    (h₁₂ : quotient.relation choice₁ choice₂)
    (h₂₃ : quotient.relation choice₂ choice₃) :
    quotient.relation choice₁ choice₃ :=
  quotient.is_equivalence.trans h₁₂ h₂₃

/-- The discrete quotient is the no-extra-identification baseline. -/
def discrete (index : Type u) : IUTStage1IndeterminacyQuotient index :=
  { ind1 := theorem311Ind1,
    ind2 := theorem311Ind2,
    ind3 := theorem311Ind3,
    relation := Eq,
    is_equivalence := eq_equivalence,
    ind1_name := rfl,
    ind2_name := rfl,
    ind3_name := rfl }

theorem discrete_profile (index : Type u) :
    (discrete index).profile = theorem311IndeterminacyProfile :=
  rfl

end IUTStage1IndeterminacyQuotient

/--
Generator relations for the three Stage 1 indeterminacies.

Each field records one elementary way that two choices may become identified
before passing to the equivalence relation generated by `(Ind1)`, `(Ind2)`,
`(Ind3)`.
-/
structure IUTStage1IndeterminacyGenerators (index : Type u) where
  ind1_step : index -> index -> Prop
  ind2_step : index -> index -> Prop
  ind3_step : index -> index -> Prop

/--
Coordinate model for choices before quotienting by `(Ind1)`, `(Ind2)`,
`(Ind3)`.

The `coric` coordinate represents the common data that survives all three
indeterminacies. The other coordinates record the representative-dependent
parts erased one at a time by the three generators.
-/
structure IUTStage1IndeterminacyChoice
    (coric ind1State ind2State ind3State : Type u) where
  coric : coric
  ind1_state : ind1State
  ind2_state : ind2State
  ind3_state : ind3State

namespace IUTStage1IndeterminacyChoice

variable {coric ind1State ind2State ind3State : Type u}

/--
Coordinate generators: `(Ind1)` may change only the first indeterminacy state,
`(Ind2)` only the second, and `(Ind3)` only the third. All three preserve the
coric coordinate.
-/
def coordinateGenerators :
    IUTStage1IndeterminacyGenerators
      (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State) :=
  { ind1_step := fun choice₁ choice₂ =>
      choice₁.coric = choice₂.coric ∧
        choice₁.ind2_state = choice₂.ind2_state ∧
          choice₁.ind3_state = choice₂.ind3_state,
    ind2_step := fun choice₁ choice₂ =>
      choice₁.coric = choice₂.coric ∧
        choice₁.ind1_state = choice₂.ind1_state ∧
          choice₁.ind3_state = choice₂.ind3_state,
    ind3_step := fun choice₁ choice₂ =>
      choice₁.coric = choice₂.coric ∧
        choice₁.ind1_state = choice₂.ind1_state ∧
          choice₁.ind2_state = choice₂.ind2_state }

theorem ind1_step_coric_eq
    {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State}
    (hstep : coordinateGenerators.ind1_step choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  hstep.1

theorem ind2_step_coric_eq
    {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State}
    (hstep : coordinateGenerators.ind2_step choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  hstep.1

theorem ind3_step_coric_eq
    {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State}
    (hstep : coordinateGenerators.ind3_step choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  hstep.1

end IUTStage1IndeterminacyChoice

/--
Equivalence relation generated by the three indeterminacy step relations.

This is the formal replacement for treating "up to `(Ind1)`, `(Ind2)`,
`(Ind3)`" as an informal phrase when a caller explicitly supplies equality
data for every generator. The source-faithful Step (x) log-volume route is
modeled separately by `IUTStage1ProcessionNormalizedIndeterminacyCorridor`,
where `(Ind3)` is one-sided.
-/
inductive IUTStage1GeneratedIndeterminacyRelation
    {index : Type u}
    (steps : IUTStage1IndeterminacyGenerators index) :
    index -> index -> Prop where
  | refl (choice : index) :
      IUTStage1GeneratedIndeterminacyRelation steps choice choice
  | ind1 {choice₁ choice₂ : index} :
      steps.ind1_step choice₁ choice₂ ->
        IUTStage1GeneratedIndeterminacyRelation steps choice₁ choice₂
  | ind2 {choice₁ choice₂ : index} :
      steps.ind2_step choice₁ choice₂ ->
        IUTStage1GeneratedIndeterminacyRelation steps choice₁ choice₂
  | ind3 {choice₁ choice₂ : index} :
      steps.ind3_step choice₁ choice₂ ->
        IUTStage1GeneratedIndeterminacyRelation steps choice₁ choice₂
  | symm {choice₁ choice₂ : index} :
      IUTStage1GeneratedIndeterminacyRelation steps choice₁ choice₂ ->
        IUTStage1GeneratedIndeterminacyRelation steps choice₂ choice₁
  | trans {choice₁ choice₂ choice₃ : index} :
      IUTStage1GeneratedIndeterminacyRelation steps choice₁ choice₂ ->
        IUTStage1GeneratedIndeterminacyRelation steps choice₂ choice₃ ->
          IUTStage1GeneratedIndeterminacyRelation steps choice₁ choice₃

namespace IUTStage1GeneratedIndeterminacyRelation

variable {index : Type u}
variable {steps : IUTStage1IndeterminacyGenerators index}

theorem is_equivalence :
    Equivalence (IUTStage1GeneratedIndeterminacyRelation steps) where
  refl := IUTStage1GeneratedIndeterminacyRelation.refl
  symm := IUTStage1GeneratedIndeterminacyRelation.symm
  trans := IUTStage1GeneratedIndeterminacyRelation.trans

theorem image_invariant
    {target : Copy}
    (images : RegionFamily target index)
    (hInd1 :
      ∀ {choice₁ choice₂ : index},
        steps.ind1_step choice₁ choice₂ ->
          images.region choice₁ = images.region choice₂)
    (hInd2 :
      ∀ {choice₁ choice₂ : index},
        steps.ind2_step choice₁ choice₂ ->
          images.region choice₁ = images.region choice₂)
    (hInd3 :
      ∀ {choice₁ choice₂ : index},
        steps.ind3_step choice₁ choice₂ ->
          images.region choice₁ = images.region choice₂) :
    ∀ {choice₁ choice₂ : index},
      IUTStage1GeneratedIndeterminacyRelation steps choice₁ choice₂ ->
        images.region choice₁ = images.region choice₂ := by
  intro choice₁ choice₂ hrel
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hInd1 hstep
  | ind2 hstep =>
      exact hInd2 hstep
  | ind3 hstep =>
      exact hInd3 hstep
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

end IUTStage1GeneratedIndeterminacyRelation

namespace IUTStage1IndeterminacyChoice

variable {coric ind1State ind2State ind3State : Type u}

theorem generated_coric_eq
    {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (coordinateGenerators
          (coric := coric) (ind1State := ind1State)
          (ind2State := ind2State) (ind3State := ind3State))
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact ind1_step_coric_eq hstep
  | ind2 hstep =>
      exact ind2_step_coric_eq hstep
  | ind3 hstep =>
      exact ind3_step_coric_eq hstep
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂) :
    ∀ {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State},
      IUTStage1GeneratedIndeterminacyRelation
        (coordinateGenerators
          (coric := coric) (ind1State := ind1State)
          (ind2State := ind2State) (ind3State := ind3State))
        choice₁ choice₂ ->
        images.region choice₁ = images.region choice₂ := by
  intro choice₁ choice₂ hrel
  exact hcoric choice₁ choice₂ (generated_coric_eq hrel)

end IUTStage1IndeterminacyChoice

namespace IUTStage1IndeterminacyQuotient

variable {index : Type u}

/-- Quotient relation generated by explicit `(Ind1)`, `(Ind2)`, `(Ind3)` steps. -/
def generated (steps : IUTStage1IndeterminacyGenerators index) :
    IUTStage1IndeterminacyQuotient index :=
  { ind1 := theorem311Ind1,
    ind2 := theorem311Ind2,
    ind3 := theorem311Ind3,
    relation := IUTStage1GeneratedIndeterminacyRelation steps,
    is_equivalence := IUTStage1GeneratedIndeterminacyRelation.is_equivalence,
    ind1_name := rfl,
    ind2_name := rfl,
    ind3_name := rfl }

theorem generated_profile (steps : IUTStage1IndeterminacyGenerators index) :
    (generated steps).profile = theorem311IndeterminacyProfile :=
  rfl

end IUTStage1IndeterminacyQuotient

/--
Theorem 3.11 source names for the three indeterminacy generator relations.

This record specializes the generic `ind1_step`, `ind2_step`, `ind3_step`
interface to the descriptions in Theorem 3.11:
procession automorphisms, local tensor-factor symmetries, and upper
semi-compatibility.
-/
structure IUTStage1Theorem311IndeterminacySourceData (index : Type u) where
  procession_automorphism_step : index -> index -> Prop
  local_tensor_symmetry_step : index -> index -> Prop
  upper_semi_compatibility_step : index -> index -> Prop

namespace IUTStage1Theorem311IndeterminacySourceData

variable {index : Type u}

def generators
    (data : IUTStage1Theorem311IndeterminacySourceData index) :
    IUTStage1IndeterminacyGenerators index :=
  { ind1_step := data.procession_automorphism_step,
    ind2_step := data.local_tensor_symmetry_step,
    ind3_step := data.upper_semi_compatibility_step }

def quotient
    (data : IUTStage1Theorem311IndeterminacySourceData index) :
    IUTStage1IndeterminacyQuotient index :=
  IUTStage1IndeterminacyQuotient.generated data.generators

theorem ind1_step_eq
    (data : IUTStage1Theorem311IndeterminacySourceData index) :
    data.generators.ind1_step = data.procession_automorphism_step :=
  rfl

theorem ind2_step_eq
    (data : IUTStage1Theorem311IndeterminacySourceData index) :
    data.generators.ind2_step = data.local_tensor_symmetry_step :=
  rfl

theorem ind3_step_eq
    (data : IUTStage1Theorem311IndeterminacySourceData index) :
    data.generators.ind3_step = data.upper_semi_compatibility_step :=
  rfl

theorem quotient_profile
    (data : IUTStage1Theorem311IndeterminacySourceData index) :
    data.quotient.profile = theorem311IndeterminacyProfile :=
  IUTStage1IndeterminacyQuotient.generated_profile data.generators

end IUTStage1Theorem311IndeterminacySourceData

/-- Inert identifier for a procession of D-prime-strips in Theorem 3.11. -/
structure ProcessionPrimeStripId where
  label : String

/-- Inert identifier for local tensor-packet symmetry data in Theorem 3.11. -/
structure LocalTensorSymmetryId where
  label : String

/-- Inert identifier for a log-link column used by upper semi-compatibility. -/
structure LogThetaColumnId where
  label : String

/-- Inert identifier for local upper-semi-compatibility data. -/
structure UpperSemiCompatibilityId where
  label : String

/-- The two place kinds separated in the upper-semi-compatibility discussion. -/
inductive IUTStage1PlaceKind where
  | nonarchimedean
  | archimedean
deriving DecidableEq, Repr

/-- Typed identifier for a place of a fixed kind. -/
structure IUTStage1PlaceId (kind : IUTStage1PlaceKind) where
  label : String

/-- Typed identifier for a base place `vQ` of a fixed kind. -/
structure IUTStage1BasePlaceId (kind : IUTStage1PlaceKind) where
  label : String

/-- The typed fiber of places lying above a base place `vQ`. -/
structure IUTStage1PlaceFiber (kind : IUTStage1PlaceKind) where
  basePlace : IUTStage1BasePlaceId kind
  places : List (IUTStage1PlaceId kind)

namespace IUTStage1PlaceFiber

variable {kind : IUTStage1PlaceKind}

def cardinality (fiber : IUTStage1PlaceFiber kind) : Nat :=
  fiber.places.length

theorem cardinality_eq_length (fiber : IUTStage1PlaceFiber kind) :
    fiber.cardinality = fiber.places.length :=
  rfl

end IUTStage1PlaceFiber

/-- Typed identifier for a local object over a place of a fixed kind. -/
structure IUTStage1LocalObjectId (kind : IUTStage1PlaceKind) where
  place : IUTStage1PlaceId kind
  label : String

/-- Normalization used for local log-volume data in Proposition 3.9. -/
inductive IUTStage1LogVolumeNormalization where
  | packet
  | procession
  | global
deriving DecidableEq, Repr

/--
Typed local log-shell/tensor-packet object with a log-volume.

This is still a source-facing interface: it records the object, place,
normalization, and resulting real log-volume without constructing the analytic
set `M(IQ(-))` internally.
-/
structure IUTStage1LocalLogVolumeObject
    (kind : IUTStage1PlaceKind) where
  object : IUTStage1LocalObjectId kind
  normalization : IUTStage1LogVolumeNormalization
  logVolume : Real

/-- A local object whose log-volume is finite and explicitly named. -/
structure IUTStage1FiniteLocalLogVolumeObject
    (kind : IUTStage1PlaceKind) where
  localObject : IUTStage1LocalLogVolumeObject kind
  finiteLogVolume : Real
  finite_log_volume_eq : localObject.logVolume = finiteLogVolume

/--
Procession-normalized local log-volume datum.

This records the finite capsule count and the normalized average used in
Proposition 3.9, without yet formalizing the capsule family itself.
-/
structure IUTStage1ProcessionNormalizedLogVolume
    (kind : IUTStage1PlaceKind) where
  localObject : IUTStage1FiniteLocalLogVolumeObject kind
  capsuleCount : Nat
  positive_capsule_count : 0 < capsuleCount
  totalLogVolume : Real
  normalizedLogVolume : Real
  normalized_eq_average :
    normalizedLogVolume = totalLogVolume / (capsuleCount : Real)

/--
Finite procession containers from IUT III.

The paper writes `S^±_{j+1} = {0, 1, ..., j}`.  The current model represents
this set by `Fin (j + 1)`.  This is only the finite label skeleton; prime-strips,
log-shells, and tensor packets are attached later.
-/
abbrev IUTStage1ProcessionContainer (j : Nat) : Type :=
  Fin (j + 1)

namespace IUTStage1ProcessionContainer

def core (j : Nat) : IUTStage1ProcessionContainer j :=
  ⟨0, Nat.succ_pos j⟩

def terminal (j : Nat) : IUTStage1ProcessionContainer j :=
  ⟨j, Nat.lt_succ_self j⟩

def inclusion (j : Nat) :
    IUTStage1ProcessionContainer j ->
      IUTStage1ProcessionContainer (j + 1) :=
  fun label => ⟨label.val, by omega⟩

theorem card_eq (j : Nat) :
    Fintype.card (IUTStage1ProcessionContainer j) = j + 1 :=
  Fintype.card_fin (j + 1)

theorem inclusion_injective (j : Nat) :
    Function.Injective (inclusion j) := by
  intro a b h
  apply Fin.ext
  simpa [inclusion] using congrArg Fin.val h

theorem inclusion_core (j : Nat) :
    inclusion j (core j) = core (j + 1) :=
  rfl

def labelIndeterminacyCount (j : Nat) : Nat :=
  Fintype.card (IUTStage1ProcessionContainer j)

theorem labelIndeterminacyCount_eq (j : Nat) :
    labelIndeterminacyCount j = j + 1 :=
  card_eq j

theorem labelIndeterminacyCount_le_full
    {j full : Nat} (h : j ≤ full) :
    labelIndeterminacyCount j ≤ full + 1 := by
  rw [labelIndeterminacyCount_eq]
  omega

def wholeSetIndeterminacyCount (full : Nat) : Nat :=
  (full + 1) ^ (full + 1)

def processionTotalIndeterminacyCount (full : Nat) : Nat :=
  (Finset.range (full + 1)).prod labelIndeterminacyCount

theorem processionTotalIndeterminacyCount_eq_factorial (full : Nat) :
    processionTotalIndeterminacyCount full =
      Nat.factorial (full + 1) := by
  unfold processionTotalIndeterminacyCount
  induction full with
  | zero =>
      simp [labelIndeterminacyCount]
  | succ full ih =>
      rw [Finset.prod_range_succ]
      rw [ih]
      rw [labelIndeterminacyCount_eq]
      simp [Nat.factorial_succ, Nat.mul_comm, Nat.mul_assoc,
        Nat.add_comm, Nat.add_left_comm]

theorem processionTotalIndeterminacyCount_le_wholeSetIndeterminacyCount
    (full : Nat) :
    processionTotalIndeterminacyCount full ≤
      wholeSetIndeterminacyCount full := by
  rw [processionTotalIndeterminacyCount_eq_factorial,
    wholeSetIndeterminacyCount]
  exact Nat.factorial_le_pow (full + 1)

end IUTStage1ProcessionContainer

/--
Real-valued local container estimate.

This is the Stage 1 placeholder for a local analytic container computation:
the local log-volume is identified with a named container log-volume, and the
target signed value is bounded by that container value.
-/
structure IUTStage1LocalContainerLogVolumeEstimate
    (targetSigned localLogVolume : Real) where
  containerLogVolume : Real
  localLogVolume_eq_container : localLogVolume = containerLogVolume
  targetSigned_le_containerLogVolume : targetSigned <= containerLogVolume

/--
Local container estimate tied to a finite local log-volume object.

This refines the real-valued estimate by recording which local object supplies
the local log-volume being bounded.
-/
structure IUTStage1LocalObjectContainerLogVolumeEstimate
    (kind : IUTStage1PlaceKind)
    (targetSigned localLogVolume : Real) where
  localObject : IUTStage1FiniteLocalLogVolumeObject kind
  localLogVolume_eq_object : localLogVolume = localObject.finiteLogVolume
  object_container_estimate :
    IUTStage1LocalContainerLogVolumeEstimate
      targetSigned localObject.finiteLogVolume

/--
Procession-normalized log-volume averaged over a finite label set.

This is the Stage 1 abstraction of the average over `j ∈ F_l` that appears in
the Corollary 3.12 discussion.  The concrete `F_l`/`ZMod l` label model is not
chosen here; the only required structure is a finite label type.
-/
structure IUTStage1LabelAveragedProcessionLogVolume
    (label : Type u) [Fintype label] where
  normalizedLogVolume : label -> Real
  averageLogVolume : Real
  average_eq :
    averageLogVolume =
      (Finset.univ.sum normalizedLogVolume) / (Fintype.card label : Real)

/--
Procession-normalized log-volume averaged over a finite label set with explicit
weights.

This is separate from `IUTStage1LabelAveragedProcessionLogVolume`: the latter is
the uniform average over `F_l`, while this record is the Stage 1 place where
Gaussian-monoid-style weights such as the `j^2` profile can be recorded and
compared.
-/
structure IUTStage1WeightedLabelAveragedProcessionLogVolume
    (label : Type u) [Fintype label] where
  normalizedLogVolume : label -> Real
  weight : label -> Real
  weightTotal : Real
  positive_weightTotal : 0 < weightTotal
  weightTotal_eq_sum : weightTotal = Finset.univ.sum weight
  weightedAverageLogVolume : Real
  weighted_average_eq :
    weightedAverageLogVolume =
      (Finset.univ.sum fun j => weight j * normalizedLogVolume j) /
        weightTotal

/--
Raw coordinate square-weight profile on the current `F_l = ZMod l.value` model.

The formula records the finite-field coordinate representative `j.val` and
squares it as a real number. This is the representative-coordinate diagnostic
profile, not the descended `|F_l|` theta exponent. The source-compatible
zero-plus-sign-quotient exponent is formalized later by
`thetaExponentOnAbsLabel`.
-/
structure IUTStage1ZModSquareWeightProfile
    (l : PrimeGeFive) where
  weight : ZMod l.value -> Real
  weight_eq_square_val : ∀ j : ZMod l.value, weight j = ((j.val : Real) ^ 2)
  weight_nonnegative : ∀ j : ZMod l.value, 0 <= weight j
  weightTotal : Real
  positive_weightTotal : 0 < weightTotal
  weightTotal_eq_sum : weightTotal = Finset.univ.sum weight

/--
Classification of square-comparison evidence at the Corollary 3.12 boundary.

The constructors intentionally separate facts that are easy to conflate:
pointwise representative `j.val^2` preservation, aggregate reindexing of the
same representative summands, balanced sign-compatible preservation, and a
future holomorphic-hull/log-volume comparison.
-/
inductive IUTStage1SquareComparisonLevel where
  | pointwiseRepresentative
  | aggregateRepresentative
  | balancedSignCompatible
  | hullLogVolume
deriving DecidableEq, Repr

namespace IUTStage1SquareComparisonLevel

theorem aggregate_ne_pointwise :
    aggregateRepresentative ≠ pointwiseRepresentative := by
  decide

theorem balanced_ne_pointwise :
    balancedSignCompatible ≠ pointwiseRepresentative := by
  decide

theorem hull_ne_pointwise :
    hullLogVolume ≠ pointwiseRepresentative := by
  decide

theorem hull_ne_aggregate :
    hullLogVolume ≠ aggregateRepresentative := by
  decide

theorem hull_ne_balanced :
    hullLogVolume ≠ balancedSignCompatible := by
  decide

theorem pointwise_ne_aggregate :
    pointwiseRepresentative ≠ aggregateRepresentative := by
  decide

theorem pointwise_ne_balanced :
    pointwiseRepresentative ≠ balancedSignCompatible := by
  decide

theorem pointwise_ne_hull :
    pointwiseRepresentative ≠ hullLogVolume := by
  decide

end IUTStage1SquareComparisonLevel

/--
Evidence that a finite label type is being used as the Stage 1 model of the
`F_l` labels.

The foundations layer supplies the concrete current model as `ZMod l.value`,
with `l` a prime at least five.  This bridge deliberately records only the
finite label carrier identification; torsor and unit-action compatibility are
separate audits.
-/
structure IUTStage1FLLabelModel
    (label : Type u) where
  prime : PrimeGeFive
  labelEquiv : label ≃ ZMod prime.value

/--
Procession-normalized log-volume with an explicit finite capsule family.

The total log-volume is now tied to the finite sum over capsules rather than
being an independent real.
-/
structure IUTStage1CapsuleFamilyLogVolume
    (kind : IUTStage1PlaceKind) where
  localObject : IUTStage1FiniteLocalLogVolumeObject kind
  capsuleCount : Nat
  positive_capsule_count : 0 < capsuleCount
  capsuleLogVolume : Fin capsuleCount -> Real
  totalLogVolume : Real
  total_eq_sum : totalLogVolume = Finset.univ.sum capsuleLogVolume
  normalizedLogVolume : Real
  normalized_eq_average :
    normalizedLogVolume = totalLogVolume / (capsuleCount : Real)

/-- A typed capsule object carrying its local log-volume. -/
structure IUTStage1CapsuleLogVolumeObject
    (kind : IUTStage1PlaceKind) where
  capsuleLabel : String
  localObject : IUTStage1FiniteLocalLogVolumeObject kind
  logVolume : Real
  log_volume_eq : logVolume = localObject.finiteLogVolume

/-- A finite capsule family whose total is computed from capsule objects. -/
structure IUTStage1TypedCapsuleFamilyLogVolume
    (kind : IUTStage1PlaceKind) where
  localObject : IUTStage1FiniteLocalLogVolumeObject kind
  capsuleCount : Nat
  positive_capsule_count : 0 < capsuleCount
  capsule : Fin capsuleCount -> IUTStage1CapsuleLogVolumeObject kind
  capsule_local_object_eq :
    ∀ i : Fin capsuleCount, (capsule i).localObject = localObject
  totalLogVolume : Real
  total_eq_sum : totalLogVolume = Finset.univ.sum fun i => (capsule i).logVolume
  normalizedLogVolume : Real
  normalized_eq_average :
    normalizedLogVolume = totalLogVolume / (capsuleCount : Real)

/--
Log-volume shadow of the IUT III tensor packet over a procession container.

For each element of `S^±_{j+1}` this record stores the finite log-volume object
representing the direct sum of log-shells over the relevant valuations.  The
tensor-packet log-volume is recorded at the additive log-volume level as the sum
over the container, with procession normalization by `j+1`.
-/
structure IUTStage1ProcessionTensorPacketLogVolume
    (kind : IUTStage1PlaceKind) (j : Nat) where
  logShellDirectSum :
    IUTStage1ProcessionContainer j ->
      IUTStage1FiniteLocalLogVolumeObject kind
  tensorPacketLogVolume : Real
  tensor_packet_eq_sum :
    tensorPacketLogVolume =
      Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
        (logShellDirectSum label).finiteLogVolume
  normalizedLogVolume : Real
  normalized_eq_average :
    normalizedLogVolume = tensorPacketLogVolume / ((j + 1 : Nat) : Real)

namespace IUTStage1ProcessionTensorPacketLogVolume

variable {kind : IUTStage1PlaceKind} {j : Nat}

theorem normalized_eq_card_average
    (data : IUTStage1ProcessionTensorPacketLogVolume kind j) :
    data.normalizedLogVolume =
      data.tensorPacketLogVolume /
        (Fintype.card (IUTStage1ProcessionContainer j) : Real) := by
  rw [data.normalized_eq_average]
  rw [IUTStage1ProcessionContainer.card_eq]

def toLabelAveraged
    (data : IUTStage1ProcessionTensorPacketLogVolume kind j) :
    IUTStage1LabelAveragedProcessionLogVolume
      (IUTStage1ProcessionContainer j) :=
  { normalizedLogVolume := fun label =>
      (data.logShellDirectSum label).finiteLogVolume,
    averageLogVolume := data.normalizedLogVolume,
    average_eq := by
      calc
        data.normalizedLogVolume =
            data.tensorPacketLogVolume / ((j + 1 : Nat) : Real) :=
          data.normalized_eq_average
        _ =
            (Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
              (data.logShellDirectSum label).finiteLogVolume) /
                ((j + 1 : Nat) : Real) := by
          rw [data.tensor_packet_eq_sum]
        _ =
            (Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
              (data.logShellDirectSum label).finiteLogVolume) /
                (Fintype.card (IUTStage1ProcessionContainer j) : Real) := by
          rw [IUTStage1ProcessionContainer.card_eq] }

end IUTStage1ProcessionTensorPacketLogVolume

/--
Finite-fiber direct sum of log-shell log-volumes over the places above a base
valuation `v_Q`.

This is the log-volume shadow of the IUT III operation that, for a fixed element
of `S^±_{j+1}` and a fixed base valuation, forms the direct sum over the places
`v ∈ V` above that base valuation.
-/
structure IUTStage1ValuationFiberLogShellDirectSum
    (kind : IUTStage1PlaceKind) where
  fiber : IUTStage1PlaceFiber kind
  logShellLogVolume : Fin fiber.cardinality -> Real
  directSumLogVolume : Real
  direct_sum_eq_sum :
    directSumLogVolume = Finset.univ.sum logShellLogVolume

namespace IUTStage1ValuationFiberLogShellDirectSum

variable {kind : IUTStage1PlaceKind}

theorem direct_sum_eq
    (data : IUTStage1ValuationFiberLogShellDirectSum kind) :
    data.directSumLogVolume =
      Finset.univ.sum data.logShellLogVolume :=
  data.direct_sum_eq_sum

theorem direct_sum_eq_zero_of_empty
    (data : IUTStage1ValuationFiberLogShellDirectSum kind)
    (hempty : data.fiber.cardinality = 0) :
    data.directSumLogVolume = 0 := by
  rw [data.direct_sum_eq]
  haveI : IsEmpty (Fin data.fiber.cardinality) := by
    rw [hempty]
    infer_instance
  simp

end IUTStage1ValuationFiberLogShellDirectSum

/--
Tensor-packet log-volume over a procession container, with each factor already
resolved as a finite-fiber direct sum over the places above a base valuation.
-/
structure IUTStage1ProcessionFiberTensorPacketLogVolume
    (kind : IUTStage1PlaceKind) (j : Nat) where
  directSum :
    IUTStage1ProcessionContainer j ->
      IUTStage1ValuationFiberLogShellDirectSum kind
  tensorPacketLogVolume : Real
  tensor_packet_eq_sum :
    tensorPacketLogVolume =
      Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
        (directSum label).directSumLogVolume
  normalizedLogVolume : Real
  normalized_eq_average :
    normalizedLogVolume = tensorPacketLogVolume / ((j + 1 : Nat) : Real)

namespace IUTStage1ProcessionFiberTensorPacketLogVolume

variable {kind : IUTStage1PlaceKind} {j : Nat}

theorem normalized_eq_card_average
    (data : IUTStage1ProcessionFiberTensorPacketLogVolume kind j) :
    data.normalizedLogVolume =
      data.tensorPacketLogVolume /
        (Fintype.card (IUTStage1ProcessionContainer j) : Real) := by
  rw [data.normalized_eq_average]
  rw [IUTStage1ProcessionContainer.card_eq]

def reindex
    (data : IUTStage1ProcessionFiberTensorPacketLogVolume kind j)
    (perm :
      IUTStage1ProcessionContainer j ≃
        IUTStage1ProcessionContainer j) :
    IUTStage1ProcessionFiberTensorPacketLogVolume kind j :=
  { directSum := fun label => data.directSum (perm label),
    tensorPacketLogVolume := data.tensorPacketLogVolume,
    tensor_packet_eq_sum := by
      have hsum :
          (Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
            (data.directSum (perm label)).directSumLogVolume) =
            Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
              (data.directSum label).directSumLogVolume :=
        Fintype.sum_equiv perm
          (fun label : IUTStage1ProcessionContainer j =>
            (data.directSum (perm label)).directSumLogVolume)
          (fun label : IUTStage1ProcessionContainer j =>
            (data.directSum label).directSumLogVolume)
          (fun _label => rfl)
      calc
        data.tensorPacketLogVolume =
            Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
              (data.directSum label).directSumLogVolume :=
          data.tensor_packet_eq_sum
        _ =
            Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
              (data.directSum (perm label)).directSumLogVolume :=
          hsum.symm,
    normalizedLogVolume := data.normalizedLogVolume,
    normalized_eq_average := data.normalized_eq_average }

theorem reindex_normalizedLogVolume_eq
    (data : IUTStage1ProcessionFiberTensorPacketLogVolume kind j)
    (perm :
      IUTStage1ProcessionContainer j ≃
        IUTStage1ProcessionContainer j) :
    (data.reindex perm).normalizedLogVolume =
      data.normalizedLogVolume :=
  rfl

end IUTStage1ProcessionFiberTensorPacketLogVolume

/--
Finite product, over base valuations `v_Q`, of procession tensor-packet
log-volumes.

IUT III forms products over `v_Q ∈ V_Q` of the tensor-packet portions at `v_Q`.
At the current finite log-volume level, product log-volume is represented as a
sum of the log-volumes of the base-valuation packet factors.
-/
structure IUTStage1BaseValuationTensorPacketProductLogVolume
    (kind : IUTStage1PlaceKind) (j : Nat) where
  baseCount : Nat
  basePlace : Fin baseCount -> IUTStage1BasePlaceId kind
  packet :
    Fin baseCount -> IUTStage1ProcessionFiberTensorPacketLogVolume kind j
  packet_basePlace_eq :
    ∀ (base : Fin baseCount) (label : IUTStage1ProcessionContainer j),
      ((packet base).directSum label).fiber.basePlace = basePlace base
  productLogVolume : Real
  product_eq_sum :
    productLogVolume =
      Finset.univ.sum fun base : Fin baseCount =>
        (packet base).tensorPacketLogVolume

namespace IUTStage1BaseValuationTensorPacketProductLogVolume

variable {kind : IUTStage1PlaceKind} {j : Nat}

theorem packet_directSum_basePlace_eq
    (product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j)
    (base : Fin product.baseCount)
    (label : IUTStage1ProcessionContainer j) :
    ((product.packet base).directSum label).fiber.basePlace =
      product.basePlace base :=
  product.packet_basePlace_eq base label

theorem productLogVolume_eq_nested_sum
    (product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j) :
    product.productLogVolume =
      Finset.univ.sum fun base : Fin product.baseCount =>
        Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
          ((product.packet base).directSum label).directSumLogVolume := by
  calc
    product.productLogVolume =
        Finset.univ.sum fun base : Fin product.baseCount =>
          (product.packet base).tensorPacketLogVolume :=
      product.product_eq_sum
    _ =
        Finset.univ.sum fun base : Fin product.baseCount =>
          Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
            ((product.packet base).directSum label).directSumLogVolume := by
      apply Finset.sum_congr rfl
      intro base _hbase
      exact (product.packet base).tensor_packet_eq_sum

end IUTStage1BaseValuationTensorPacketProductLogVolume

/--
Log-volume shadow of the action of the labeled copies `(F_mod^×)_j`.

The paper describes copies of the multiplicative monoid of nonzero elements of
`F_mod`, labeled by `j`, acting on the product over `v_Q` of tensor-packet
portions.  The present record stores only the finite log-volume effect: for each
base valuation and each procession label, the action adds the log-volume of the
corresponding labeled `F_mod^×` copy.
-/
structure IUTStage1FmodUnitCopyTensorPacketProductAction
    (kind : IUTStage1PlaceKind) (j : Nat) where
  product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j
  unitCopyLogVolume : IUTStage1ProcessionContainer j -> Real
  actedFactorLogVolume :
    Fin product.baseCount -> IUTStage1ProcessionContainer j -> Real
  acted_factor_eq :
    ∀ (base : Fin product.baseCount) (label : IUTStage1ProcessionContainer j),
      actedFactorLogVolume base label =
        ((product.packet base).directSum label).directSumLogVolume +
          unitCopyLogVolume label
  actedProductLogVolume : Real
  acted_product_eq_sum :
    actedProductLogVolume =
      Finset.univ.sum fun base : Fin product.baseCount =>
        Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
          actedFactorLogVolume base label

namespace IUTStage1FmodUnitCopyTensorPacketProductAction

variable {kind : IUTStage1PlaceKind} {j : Nat}

theorem actedProductLogVolume_eq_original_plus_unitCopies
    (action : IUTStage1FmodUnitCopyTensorPacketProductAction kind j) :
    action.actedProductLogVolume =
      action.product.productLogVolume +
        Finset.univ.sum fun _base : Fin action.product.baseCount =>
          Finset.univ.sum action.unitCopyLogVolume := by
  calc
    action.actedProductLogVolume =
        Finset.univ.sum fun base : Fin action.product.baseCount =>
          Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
            action.actedFactorLogVolume base label :=
      action.acted_product_eq_sum
    _ =
        Finset.univ.sum fun base : Fin action.product.baseCount =>
          Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
            ((action.product.packet base).directSum label).directSumLogVolume +
              action.unitCopyLogVolume label := by
      apply Finset.sum_congr rfl
      intro base _hbase
      apply Finset.sum_congr rfl
      intro label _hlabel
      exact action.acted_factor_eq base label
    _ =
        (Finset.univ.sum fun base : Fin action.product.baseCount =>
          Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
            ((action.product.packet base).directSum label).directSumLogVolume) +
        Finset.univ.sum fun _base : Fin action.product.baseCount =>
          Finset.univ.sum action.unitCopyLogVolume := by
      rw [← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl
      intro base _hbase
      rw [Finset.sum_add_distrib]
    _ =
        action.product.productLogVolume +
        Finset.univ.sum fun _base : Fin action.product.baseCount =>
          Finset.univ.sum action.unitCopyLogVolume := by
      rw [action.product.productLogVolume_eq_nested_sum]

end IUTStage1FmodUnitCopyTensorPacketProductAction

/-- Realization stage of a tensor-packet product in the IUT III passage. -/
inductive IUTStage1TensorPacketRealizationKind where
  | holomorphicF
  | holomorphicD
  | monoAnalyticD
deriving DecidableEq, Repr

/--
Tensor-packet product together with the realization kind that records whether it
is still attached to an `F`-prime-strip, to a `D`-prime-strip, or to the
mono-analytic `D^⊢` container after forgetting the holomorphic structure.
-/
structure IUTStage1RealizedTensorPacketProductLogVolume
    (kind : IUTStage1PlaceKind) (j : Nat) where
  realization : IUTStage1TensorPacketRealizationKind
  theater : QualitativeData.HodgeTheaterId
  product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j

/--
Finite realified Frobenioid divisor source.

IUT I, Example 3.5 describes the global realified Frobenioid through its
divisor monoid, whose primes are indexed by the relevant set of valuations, and
through realified degree/log-volume readings.  This finite source keeps the
Stage 1 shadow at the divisor-monoid level: a divisor is a finite family of
prime multiplicities, and its degree is computed as the finite weighted sum of
the prime degrees.
-/
structure IUTStage1FiniteRealifiedFrobenioidDivisorSource
    (π : Type u) [Fintype π] where
  object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean
  primeMultiplicity : π -> Nat
  primeDegree : π -> Int
  unitLogVolume : Real

namespace IUTStage1FiniteRealifiedFrobenioidDivisorSource

variable {π : Type u} [Fintype π]

def divisorDegree
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π) : Int :=
  ∑ p : π, (source.primeMultiplicity p : Int) * source.primeDegree p

def realifiedLogVolume
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π) : Real :=
  (source.divisorDegree : Real) + source.unitLogVolume

def tensorProduct
    (left right : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    IUTStage1FiniteRealifiedFrobenioidDivisorSource π :=
  { object := object,
    primeMultiplicity := fun p =>
      left.primeMultiplicity p + right.primeMultiplicity p,
    primeDegree := left.primeDegree,
    unitLogVolume := left.unitLogVolume + right.unitLogVolume }

theorem tensorProduct_divisorDegree_eq_add
    (left right : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.primeDegree = right.primeDegree) :
    (left.tensorProduct right object).divisorDegree =
      left.divisorDegree + right.divisorDegree := by
  simp [tensorProduct, divisorDegree, Finset.sum_add_distrib,
    right_distrib, hprime]

theorem tensorProduct_realifiedLogVolume_eq_add
    (left right : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.primeDegree = right.primeDegree) :
    (left.tensorProduct right object).realifiedLogVolume =
      left.realifiedLogVolume + right.realifiedLogVolume := by
  rw [realifiedLogVolume, realifiedLogVolume, realifiedLogVolume,
    tensorProduct_divisorDegree_eq_add left right object hprime]
  simp [tensorProduct]
  ring_nf

end IUTStage1FiniteRealifiedFrobenioidDivisorSource

/--
Finite theta-realified Frobenioid divisor source.

IUT I, Example 3.5(ii) forms a theta-version of the global realified
Frobenioid by replacing the divisor monoid with an isomorphic copy generated by
a formal `log(Theta)`.  This finite source records that operation at the
degree/log-volume level: the ordinary divisor degree is read through a chosen
theta-generator log-volume.  The full theta Frobenioid is not constructed here.
-/
structure IUTStage1ThetaRealifiedFrobenioidDivisorSource
    (π : Type u) [Fintype π] where
  base : IUTStage1FiniteRealifiedFrobenioidDivisorSource π
  thetaGeneratorLogVolume : Real

namespace IUTStage1ThetaRealifiedFrobenioidDivisorSource

variable {π : Type u} [Fintype π]

def thetaDivisorLogVolume
    (source : IUTStage1ThetaRealifiedFrobenioidDivisorSource π) : Real :=
  (source.base.divisorDegree : Real) * source.thetaGeneratorLogVolume +
    source.base.unitLogVolume

def tensorProduct
    (left right : IUTStage1ThetaRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    IUTStage1ThetaRealifiedFrobenioidDivisorSource π :=
  { base := left.base.tensorProduct right.base object,
    thetaGeneratorLogVolume := left.thetaGeneratorLogVolume }

theorem thetaDivisorLogVolume_eq_base_realified_of_theta_one
    (source : IUTStage1ThetaRealifiedFrobenioidDivisorSource π)
    (htheta : source.thetaGeneratorLogVolume = 1) :
    source.thetaDivisorLogVolume = source.base.realifiedLogVolume := by
  simp [thetaDivisorLogVolume,
    IUTStage1FiniteRealifiedFrobenioidDivisorSource.realifiedLogVolume,
    htheta]

theorem tensorProduct_thetaDivisorLogVolume_eq_add
    (left right : IUTStage1ThetaRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.base.primeDegree = right.base.primeDegree)
    (htheta :
      left.thetaGeneratorLogVolume = right.thetaGeneratorLogVolume) :
    (left.tensorProduct right object).thetaDivisorLogVolume =
      left.thetaDivisorLogVolume + right.thetaDivisorLogVolume := by
  simp only [tensorProduct]
  rw [thetaDivisorLogVolume, thetaDivisorLogVolume, thetaDivisorLogVolume,
    IUTStage1FiniteRealifiedFrobenioidDivisorSource.tensorProduct_divisorDegree_eq_add
      left.base right.base object hprime]
  simp [IUTStage1FiniteRealifiedFrobenioidDivisorSource.tensorProduct, htheta]
  ring

theorem endpoint
    (source : IUTStage1ThetaRealifiedFrobenioidDivisorSource π)
    (htheta : source.thetaGeneratorLogVolume = 1) :
    source.thetaDivisorLogVolume =
      (source.base.divisorDegree : Real) * source.thetaGeneratorLogVolume +
        source.base.unitLogVolume ∧
      source.thetaDivisorLogVolume = source.base.realifiedLogVolume :=
  ⟨rfl, source.thetaDivisorLogVolume_eq_base_realified_of_theta_one htheta⟩

end IUTStage1ThetaRealifiedFrobenioidDivisorSource

/--
Finite `D`/log-shell realified Frobenioid divisor source.

IUT I, Example 3.5(iii) forms a `D`-version, or log-shell version, of the
global realified divisor data.  The local copy is read through a distinguished
Frobenius/log-shell element and normalized by the local extension degree.  This
finite record keeps only that degree/log-volume content.
-/
structure IUTStage1LogShellRealifiedFrobenioidDivisorSource
    (π : Type u) [Fintype π] where
  base : IUTStage1FiniteRealifiedFrobenioidDivisorSource π
  extensionDegree : Nat
  extensionDegree_pos : 0 < extensionDegree
  localFrobeniusLogVolume : Real

namespace IUTStage1LogShellRealifiedFrobenioidDivisorSource

variable {π : Type u} [Fintype π]

noncomputable def normalizedFrobeniusLogVolume
    (source : IUTStage1LogShellRealifiedFrobenioidDivisorSource π) : Real :=
  source.localFrobeniusLogVolume / (source.extensionDegree : Real)

noncomputable def logShellDivisorLogVolume
    (source : IUTStage1LogShellRealifiedFrobenioidDivisorSource π) : Real :=
  (source.base.divisorDegree : Real) * source.normalizedFrobeniusLogVolume +
    source.base.unitLogVolume

def tensorProduct
    (left right : IUTStage1LogShellRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    IUTStage1LogShellRealifiedFrobenioidDivisorSource π :=
  { base := left.base.tensorProduct right.base object,
    extensionDegree := left.extensionDegree,
    extensionDegree_pos := left.extensionDegree_pos,
    localFrobeniusLogVolume := left.localFrobeniusLogVolume }

theorem normalizedFrobeniusLogVolume_eq
    (source : IUTStage1LogShellRealifiedFrobenioidDivisorSource π) :
    source.normalizedFrobeniusLogVolume =
      source.localFrobeniusLogVolume / (source.extensionDegree : Real) :=
  rfl

theorem logShellDivisorLogVolume_eq_base_realified_of_normalized_one
    (source : IUTStage1LogShellRealifiedFrobenioidDivisorSource π)
    (hnorm : source.normalizedFrobeniusLogVolume = 1) :
    source.logShellDivisorLogVolume = source.base.realifiedLogVolume := by
  simp [logShellDivisorLogVolume,
    IUTStage1FiniteRealifiedFrobenioidDivisorSource.realifiedLogVolume,
    hnorm]

theorem tensorProduct_logShellDivisorLogVolume_eq_add
    (left right : IUTStage1LogShellRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.base.primeDegree = right.base.primeDegree)
    (hnorm :
      left.normalizedFrobeniusLogVolume =
        right.normalizedFrobeniusLogVolume) :
    (left.tensorProduct right object).logShellDivisorLogVolume =
      left.logShellDivisorLogVolume + right.logShellDivisorLogVolume := by
  simp only [tensorProduct]
  rw [logShellDivisorLogVolume, logShellDivisorLogVolume,
    logShellDivisorLogVolume,
    IUTStage1FiniteRealifiedFrobenioidDivisorSource.tensorProduct_divisorDegree_eq_add
      left.base right.base object hprime]
  rw [← hnorm]
  simp [normalizedFrobeniusLogVolume,
    IUTStage1FiniteRealifiedFrobenioidDivisorSource.tensorProduct]
  ring_nf

theorem endpoint
    (source : IUTStage1LogShellRealifiedFrobenioidDivisorSource π)
    (hnorm : source.normalizedFrobeniusLogVolume = 1) :
    source.normalizedFrobeniusLogVolume =
        source.localFrobeniusLogVolume / (source.extensionDegree : Real) ∧
      source.logShellDivisorLogVolume =
        (source.base.divisorDegree : Real) *
          source.normalizedFrobeniusLogVolume +
          source.base.unitLogVolume ∧
      source.logShellDivisorLogVolume = source.base.realifiedLogVolume :=
  ⟨rfl, rfl,
    source.logShellDivisorLogVolume_eq_base_realified_of_normalized_one hnorm⟩

end IUTStage1LogShellRealifiedFrobenioidDivisorSource

/--
Finite compatibility package for the ordinary, theta, and log-shell divisor
copies of IUT I, Example 3.5.

The source paper expresses these copies as naturally isomorphic collections of
data.  At the current finite level, compatibility means that all three records
use the same divisor source and that the theta/log-shell readings are normalized
so their log-volumes agree with the ordinary realified divisor log-volume.
-/
structure IUTStage1CompatibleRealifiedFrobenioidDivisorCopies
    (π : Type u) [Fintype π] where
  ordinary : IUTStage1FiniteRealifiedFrobenioidDivisorSource π
  theta : IUTStage1ThetaRealifiedFrobenioidDivisorSource π
  logShell : IUTStage1LogShellRealifiedFrobenioidDivisorSource π
  theta_base_eq : theta.base = ordinary
  logShell_base_eq : logShell.base = ordinary
  theta_normalized : theta.thetaGeneratorLogVolume = 1
  logShell_normalized : logShell.normalizedFrobeniusLogVolume = 1

namespace IUTStage1CompatibleRealifiedFrobenioidDivisorCopies

variable {π : Type u} [Fintype π]

theorem thetaLogVolume_eq_ordinary
    (copies : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π) :
    copies.theta.thetaDivisorLogVolume =
      copies.ordinary.realifiedLogVolume := by
  rw [← copies.theta_base_eq]
  exact
    copies.theta.thetaDivisorLogVolume_eq_base_realified_of_theta_one
      copies.theta_normalized

theorem logShellLogVolume_eq_ordinary
    (copies : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π) :
    copies.logShell.logShellDivisorLogVolume =
      copies.ordinary.realifiedLogVolume := by
  rw [← copies.logShell_base_eq]
  exact
    copies.logShell.logShellDivisorLogVolume_eq_base_realified_of_normalized_one
      copies.logShell_normalized

theorem thetaLogVolume_eq_logShellLogVolume
    (copies : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π) :
    copies.theta.thetaDivisorLogVolume =
      copies.logShell.logShellDivisorLogVolume := by
  rw [copies.thetaLogVolume_eq_ordinary,
    copies.logShellLogVolume_eq_ordinary]

theorem endpoint
    (copies : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π) :
    copies.theta.base = copies.ordinary ∧
      copies.logShell.base = copies.ordinary ∧
      copies.theta.thetaDivisorLogVolume =
        copies.ordinary.realifiedLogVolume ∧
      copies.logShell.logShellDivisorLogVolume =
        copies.ordinary.realifiedLogVolume ∧
      copies.theta.thetaDivisorLogVolume =
        copies.logShell.logShellDivisorLogVolume :=
  ⟨copies.theta_base_eq,
    copies.logShell_base_eq,
    copies.thetaLogVolume_eq_ordinary,
    copies.logShellLogVolume_eq_ordinary,
    copies.thetaLogVolume_eq_logShellLogVolume⟩

end IUTStage1CompatibleRealifiedFrobenioidDivisorCopies

/--
Finite environment/Gaussian realified Frobenioid evaluation package.

IUT II, Corollary 4.6(v), constructs global realified theta and Gaussian
Frobenioids `Cenv` and `Cgau` together with evaluation isomorphisms between
the environment and Gaussian sides, compatible with the local realified monoid
isomorphisms.  At the current finite divisor level, this package records the
part that is already semantic in the code: both sides carry ordinary/theta/
log-shell compatible divisor copies, and the evaluation map identifies the
ordinary divisor source.  The theta and log-shell equalities are then derived,
not stored independently.
-/
structure IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation
    (π : Type u) [Fintype π] where
  environment : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π
  gaussian : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π
  evaluation_ordinary_eq : gaussian.ordinary = environment.ordinary

namespace IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation

variable {π : Type u} [Fintype π]

theorem gaussianOrdinaryLogVolume_eq_environment
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π) :
    evaluation.gaussian.ordinary.realifiedLogVolume =
      evaluation.environment.ordinary.realifiedLogVolume := by
  rw [evaluation.evaluation_ordinary_eq]

theorem gaussianThetaLogVolume_eq_environment
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π) :
    evaluation.gaussian.theta.thetaDivisorLogVolume =
      evaluation.environment.ordinary.realifiedLogVolume := by
  rw [evaluation.gaussian.thetaLogVolume_eq_ordinary,
    evaluation.gaussianOrdinaryLogVolume_eq_environment]

theorem gaussianLogShellLogVolume_eq_environment
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π) :
    evaluation.gaussian.logShell.logShellDivisorLogVolume =
      evaluation.environment.ordinary.realifiedLogVolume := by
  rw [evaluation.gaussian.logShellLogVolume_eq_ordinary,
    evaluation.gaussianOrdinaryLogVolume_eq_environment]

theorem environmentThetaLogVolume_eq_gaussianThetaLogVolume
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π) :
    evaluation.environment.theta.thetaDivisorLogVolume =
      evaluation.gaussian.theta.thetaDivisorLogVolume := by
  rw [evaluation.environment.thetaLogVolume_eq_ordinary,
    evaluation.gaussianThetaLogVolume_eq_environment]

theorem environmentLogShellLogVolume_eq_gaussianLogShellLogVolume
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π) :
    evaluation.environment.logShell.logShellDivisorLogVolume =
      evaluation.gaussian.logShell.logShellDivisorLogVolume := by
  rw [evaluation.environment.logShellLogVolume_eq_ordinary,
    evaluation.gaussianLogShellLogVolume_eq_environment]

theorem endpoint
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π) :
    evaluation.gaussian.ordinary = evaluation.environment.ordinary ∧
      evaluation.gaussian.ordinary.realifiedLogVolume =
        evaluation.environment.ordinary.realifiedLogVolume ∧
      evaluation.gaussian.theta.thetaDivisorLogVolume =
        evaluation.environment.ordinary.realifiedLogVolume ∧
      evaluation.gaussian.logShell.logShellDivisorLogVolume =
        evaluation.environment.ordinary.realifiedLogVolume ∧
      evaluation.environment.theta.thetaDivisorLogVolume =
        evaluation.gaussian.theta.thetaDivisorLogVolume ∧
      evaluation.environment.logShell.logShellDivisorLogVolume =
        evaluation.gaussian.logShell.logShellDivisorLogVolume :=
  ⟨evaluation.evaluation_ordinary_eq,
    evaluation.gaussianOrdinaryLogVolume_eq_environment,
    evaluation.gaussianThetaLogVolume_eq_environment,
    evaluation.gaussianLogShellLogVolume_eq_environment,
    evaluation.environmentThetaLogVolume_eq_gaussianThetaLogVolume,
    evaluation.environmentLogShellLogVolume_eq_gaussianLogShellLogVolume⟩

end IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation

/--
Finite realified Frobenioid degree object.

IUT III treats the relevant global/non-realified and realified Frobenioids as
the source of the log-volume quantities later used in Step (x).  This record is
still a finite shadow, but it separates the Frobenioid object degree from the
real log-volume extracted from it.
-/
structure IUTStage1RealifiedFrobenioidDegreeObject where
  object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean
  divisorDegree : Int
  unitLogVolume : Real
  realifiedLogVolume : Real
  realified_logVolume_eq :
    realifiedLogVolume = (divisorDegree : Real) + unitLogVolume

namespace IUTStage1FiniteRealifiedFrobenioidDivisorSource

variable {π : Type u} [Fintype π]

def toDegreeObject
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π) :
    IUTStage1RealifiedFrobenioidDegreeObject :=
  { object := source.object,
    divisorDegree := source.divisorDegree,
    unitLogVolume := source.unitLogVolume,
    realifiedLogVolume := source.realifiedLogVolume,
    realified_logVolume_eq := rfl }

theorem toDegreeObject_divisorDegree
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π) :
    source.toDegreeObject.divisorDegree =
      ∑ p : π, (source.primeMultiplicity p : Int) * source.primeDegree p :=
  rfl

theorem toDegreeObject_realifiedLogVolume_eq
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π) :
    source.toDegreeObject.realifiedLogVolume =
      ((∑ p : π,
          (source.primeMultiplicity p : Int) * source.primeDegree p) : Real) +
        source.unitLogVolume :=
  by
    simp [toDegreeObject, realifiedLogVolume, divisorDegree]

theorem endpoint
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π) :
    source.toDegreeObject.divisorDegree =
        ∑ p : π, (source.primeMultiplicity p : Int) * source.primeDegree p ∧
      source.toDegreeObject.unitLogVolume = source.unitLogVolume ∧
      source.toDegreeObject.realifiedLogVolume =
        ((∑ p : π,
            (source.primeMultiplicity p : Int) * source.primeDegree p) : Real) +
          source.unitLogVolume :=
  ⟨source.toDegreeObject_divisorDegree, rfl,
    source.toDegreeObject_realifiedLogVolume_eq⟩

end IUTStage1FiniteRealifiedFrobenioidDivisorSource

namespace IUTStage1RealifiedFrobenioidDegreeObject

theorem realifiedLogVolume_eq
    (object : IUTStage1RealifiedFrobenioidDegreeObject) :
    object.realifiedLogVolume =
      (object.divisorDegree : Real) + object.unitLogVolume :=
  object.realified_logVolume_eq

theorem realifiedLogVolume_eq_of_degree_unit
    {source target : IUTStage1RealifiedFrobenioidDegreeObject}
    (hdegree : source.divisorDegree = target.divisorDegree)
    (hunit : source.unitLogVolume = target.unitLogVolume) :
    source.realifiedLogVolume = target.realifiedLogVolume := by
  rw [source.realifiedLogVolume_eq, target.realifiedLogVolume_eq,
    hdegree, hunit]

/--
Finite degree/log-volume morphism between realified Frobenioid objects.

This is the finite shadow of the pull-back/base-change and structure morphisms
that appear in IUT III, Remark 3.9.5(ix), (cQ3).  It records the change in
divisor degree and unit log-volume and derives the corresponding change in
realified log-volume.
-/
structure DegreeMorphism
    (source target : IUTStage1RealifiedFrobenioidDegreeObject) where
  divisorDegreeShift : Int
  unitLogVolumeShift : Real
  target_divisorDegree_eq :
    target.divisorDegree = source.divisorDegree + divisorDegreeShift
  target_unitLogVolume_eq :
    target.unitLogVolume = source.unitLogVolume + unitLogVolumeShift

namespace DegreeMorphism

variable
  {source target middle final :
    IUTStage1RealifiedFrobenioidDegreeObject}

theorem target_realifiedLogVolume_eq_source_plus_shifts
    (morphism : DegreeMorphism source target) :
    target.realifiedLogVolume =
      source.realifiedLogVolume +
        ((morphism.divisorDegreeShift : Int) : Real) +
        morphism.unitLogVolumeShift := by
  calc
    target.realifiedLogVolume =
        (target.divisorDegree : Real) + target.unitLogVolume :=
      target.realifiedLogVolume_eq
    _ =
        ((source.divisorDegree + morphism.divisorDegreeShift : Int) : Real) +
          (source.unitLogVolume + morphism.unitLogVolumeShift) := by
      rw [morphism.target_divisorDegree_eq, morphism.target_unitLogVolume_eq]
    _ =
        source.realifiedLogVolume +
          ((morphism.divisorDegreeShift : Int) : Real) +
          morphism.unitLogVolumeShift := by
      rw [source.realifiedLogVolume_eq]
      norm_num [Int.cast_add]
      ring

def identity
    (source : IUTStage1RealifiedFrobenioidDegreeObject) :
    DegreeMorphism source source :=
  { divisorDegreeShift := 0,
    unitLogVolumeShift := 0,
    target_divisorDegree_eq := by simp,
    target_unitLogVolume_eq := by simp }

def comp
    (first : DegreeMorphism source middle)
    (second : DegreeMorphism middle final) :
    DegreeMorphism source final :=
  { divisorDegreeShift :=
      first.divisorDegreeShift + second.divisorDegreeShift,
    unitLogVolumeShift :=
      first.unitLogVolumeShift + second.unitLogVolumeShift,
    target_divisorDegree_eq := by
      rw [second.target_divisorDegree_eq, first.target_divisorDegree_eq,
        Int.add_assoc],
    target_unitLogVolume_eq := by
      rw [second.target_unitLogVolume_eq, first.target_unitLogVolume_eq]
      ring }

theorem identity_endpoint
    (source : IUTStage1RealifiedFrobenioidDegreeObject) :
    (identity source).divisorDegreeShift = 0 ∧
      (identity source).unitLogVolumeShift = 0 ∧
      source.realifiedLogVolume =
        source.realifiedLogVolume +
          (((identity source).divisorDegreeShift : Int) : Real) +
          (identity source).unitLogVolumeShift :=
  ⟨rfl, rfl, by
    change source.realifiedLogVolume =
      source.realifiedLogVolume + ((0 : Int) : Real) + (0 : Real)
    norm_num⟩

theorem comp_endpoint
    (first : DegreeMorphism source middle)
    (second : DegreeMorphism middle final) :
    (first.comp second).divisorDegreeShift =
        first.divisorDegreeShift + second.divisorDegreeShift ∧
      (first.comp second).unitLogVolumeShift =
        first.unitLogVolumeShift + second.unitLogVolumeShift ∧
      final.realifiedLogVolume =
        source.realifiedLogVolume +
          (((first.comp second).divisorDegreeShift : Int) : Real) +
          (first.comp second).unitLogVolumeShift :=
  ⟨rfl, rfl,
    (first.comp second).target_realifiedLogVolume_eq_source_plus_shifts⟩

end DegreeMorphism

/--
Finite tensor product of realified Frobenioid degree objects.

This is the degree/log-volume shadow of tensor product of arithmetic line-bundle
or divisor data in a Frobenioid: divisor degrees and unit log-volumes add, hence
the extracted realified log-volume also adds.
-/
def tensorProduct
    (source target : IUTStage1RealifiedFrobenioidDegreeObject)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    IUTStage1RealifiedFrobenioidDegreeObject :=
  { object := object,
    divisorDegree := source.divisorDegree + target.divisorDegree,
    unitLogVolume := source.unitLogVolume + target.unitLogVolume,
    realifiedLogVolume := source.realifiedLogVolume + target.realifiedLogVolume,
    realified_logVolume_eq := by
      calc
        source.realifiedLogVolume + target.realifiedLogVolume =
            ((source.divisorDegree : Real) + source.unitLogVolume) +
              ((target.divisorDegree : Real) + target.unitLogVolume) := by
          rw [source.realifiedLogVolume_eq, target.realifiedLogVolume_eq]
        _ =
            ((source.divisorDegree + target.divisorDegree : Int) : Real) +
              (source.unitLogVolume + target.unitLogVolume) := by
          norm_num [Int.cast_add]
          ring }

theorem tensorProduct_divisorDegree
    (source target : IUTStage1RealifiedFrobenioidDegreeObject)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.tensorProduct target object).divisorDegree =
      source.divisorDegree + target.divisorDegree :=
  rfl

theorem tensorProduct_unitLogVolume
    (source target : IUTStage1RealifiedFrobenioidDegreeObject)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.tensorProduct target object).unitLogVolume =
      source.unitLogVolume + target.unitLogVolume :=
  rfl

theorem tensorProduct_realifiedLogVolume
    (source target : IUTStage1RealifiedFrobenioidDegreeObject)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.tensorProduct target object).realifiedLogVolume =
      source.realifiedLogVolume + target.realifiedLogVolume :=
  rfl

theorem tensorProduct_realifiedLogVolume_eq_of_eq
    {source₁ source₂ target₁ target₂ :
      IUTStage1RealifiedFrobenioidDegreeObject}
    {object₁ object₂ :
      IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean}
    (hsource : source₁.realifiedLogVolume = source₂.realifiedLogVolume)
    (htarget : target₁.realifiedLogVolume = target₂.realifiedLogVolume) :
    (source₁.tensorProduct target₁ object₁).realifiedLogVolume =
      (source₂.tensorProduct target₂ object₂).realifiedLogVolume := by
  simp [tensorProduct, hsource, htarget]

theorem tensorProduct_endpoint
    (source target : IUTStage1RealifiedFrobenioidDegreeObject)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.tensorProduct target object).divisorDegree =
        source.divisorDegree + target.divisorDegree ∧
      (source.tensorProduct target object).unitLogVolume =
        source.unitLogVolume + target.unitLogVolume ∧
      (source.tensorProduct target object).realifiedLogVolume =
        source.realifiedLogVolume + target.realifiedLogVolume :=
  ⟨rfl, rfl, rfl⟩

end IUTStage1RealifiedFrobenioidDegreeObject

namespace IUTStage1FiniteRealifiedFrobenioidDivisorSource

variable {π : Type u} [Fintype π]

theorem toDegreeObject_tensorProduct_endpoint
    (left right : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.primeDegree = right.primeDegree) :
    (left.tensorProduct right object).toDegreeObject.divisorDegree =
        (left.toDegreeObject.tensorProduct
          right.toDegreeObject object).divisorDegree ∧
      (left.tensorProduct right object).toDegreeObject.unitLogVolume =
        (left.toDegreeObject.tensorProduct
          right.toDegreeObject object).unitLogVolume ∧
      (left.tensorProduct right object).toDegreeObject.realifiedLogVolume =
        (left.toDegreeObject.tensorProduct
          right.toDegreeObject object).realifiedLogVolume :=
  ⟨by
      simp [toDegreeObject, IUTStage1RealifiedFrobenioidDegreeObject.tensorProduct,
        tensorProduct_divisorDegree_eq_add left right object hprime],
    by
      simp [toDegreeObject, tensorProduct,
        IUTStage1RealifiedFrobenioidDegreeObject.tensorProduct],
    by
      simp [toDegreeObject, IUTStage1RealifiedFrobenioidDegreeObject.tensorProduct,
        tensorProduct_realifiedLogVolume_eq_add left right object hprime]⟩

end IUTStage1FiniteRealifiedFrobenioidDivisorSource

/--
Realified Frobenioid source for a realized tensor-packet product.

The existing tensor-packet product record is retained as the finite
base-valuation packet data.  The new field `frobenioidDegree` records the
Frobenioid-theoretic degree/log-volume source whose realification is the
product log-volume.
-/
structure IUTStage1RealifiedFrobenioidTensorPacketProductSource
    (kind : IUTStage1PlaceKind) (j : Nat) where
  realization : IUTStage1TensorPacketRealizationKind
  theater : QualitativeData.HodgeTheaterId
  product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j
  frobenioidDegree : IUTStage1RealifiedFrobenioidDegreeObject
  productLogVolume_eq_realified :
    product.productLogVolume = frobenioidDegree.realifiedLogVolume

namespace IUTStage1RealifiedFrobenioidTensorPacketProductSource

variable {kind : IUTStage1PlaceKind} {j : Nat}

def toRealized
    (source :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j) :
    IUTStage1RealizedTensorPacketProductLogVolume kind j :=
  { realization := source.realization,
    theater := source.theater,
    product := source.product }

theorem toRealized_productLogVolume_eq_realified
    (source :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j) :
    source.toRealized.product.productLogVolume =
      source.frobenioidDegree.realifiedLogVolume :=
  source.productLogVolume_eq_realified

theorem productLogVolume_eq_of_realifiedLogVolume_eq
    {source target :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j}
    (hrealified :
      target.frobenioidDegree.realifiedLogVolume =
        source.frobenioidDegree.realifiedLogVolume) :
    target.toRealized.product.productLogVolume =
      source.toRealized.product.productLogVolume := by
  calc
    target.toRealized.product.productLogVolume =
        target.frobenioidDegree.realifiedLogVolume :=
      target.toRealized_productLogVolume_eq_realified
    _ = source.frobenioidDegree.realifiedLogVolume := hrealified
    _ = source.toRealized.product.productLogVolume :=
      source.toRealized_productLogVolume_eq_realified.symm

end IUTStage1RealifiedFrobenioidTensorPacketProductSource

/--
Tensor-product source at the realized tensor-packet layer.

The record does not manufacture a product of base-valuation packets.  Instead it
certifies that an already supplied realized tensor-packet product has the
Frobenioid degree obtained by tensoring two source degrees.  This matches the
current finite interface: product-log-volume additivity is then a theorem about
the Frobenioid degree source, not an independent packet equality.
-/
structure IUTStage1RealifiedFrobenioidTensorProductPacketSource
    {kind : IUTStage1PlaceKind} {j : Nat}
    (left right product :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j) where
  productObject : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean
  productDegree_eq_tensor :
    product.frobenioidDegree =
      left.frobenioidDegree.tensorProduct right.frobenioidDegree productObject

namespace IUTStage1RealifiedFrobenioidTensorProductPacketSource

variable {kind : IUTStage1PlaceKind} {j : Nat}
variable {left right product :
  IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j}

theorem productDegree_realifiedLogVolume_eq_sum
    (source :
      IUTStage1RealifiedFrobenioidTensorProductPacketSource
        left right product) :
    product.frobenioidDegree.realifiedLogVolume =
      left.frobenioidDegree.realifiedLogVolume +
        right.frobenioidDegree.realifiedLogVolume := by
  rw [source.productDegree_eq_tensor]
  rfl

theorem productLogVolume_eq_sum
    (source :
      IUTStage1RealifiedFrobenioidTensorProductPacketSource
        left right product) :
    product.toRealized.product.productLogVolume =
      left.toRealized.product.productLogVolume +
        right.toRealized.product.productLogVolume := by
  calc
    product.toRealized.product.productLogVolume =
        product.frobenioidDegree.realifiedLogVolume :=
      product.toRealized_productLogVolume_eq_realified
    _ =
        left.frobenioidDegree.realifiedLogVolume +
          right.frobenioidDegree.realifiedLogVolume :=
      source.productDegree_realifiedLogVolume_eq_sum
    _ =
        left.toRealized.product.productLogVolume +
          right.toRealized.product.productLogVolume := by
      rw [left.toRealized_productLogVolume_eq_realified,
        right.toRealized_productLogVolume_eq_realified]

theorem tensorProductPacket_endpoint
    (source :
      IUTStage1RealifiedFrobenioidTensorProductPacketSource
        left right product) :
    product.frobenioidDegree.realifiedLogVolume =
        left.frobenioidDegree.realifiedLogVolume +
          right.frobenioidDegree.realifiedLogVolume ∧
      product.toRealized.product.productLogVolume =
        left.toRealized.product.productLogVolume +
          right.toRealized.product.productLogVolume :=
  ⟨source.productDegree_realifiedLogVolume_eq_sum,
    source.productLogVolume_eq_sum⟩

end IUTStage1RealifiedFrobenioidTensorProductPacketSource

/--
Finite log-volume shadow of the Kummer/coric transfer from one realized
tensor-packet product to another.

For the IUT III paragraph after Fig. I.5, the intended uses are:
`holomorphicF -> holomorphicD` by Kummer isomorphism, and then
`holomorphicD -> monoAnalyticD` by forgetting the arithmetic holomorphic
structure of a vertical line.  The history guard prevents this transfer from
being represented as an identification of the two Hodge-theater histories.
-/
structure IUTStage1TensorPacketCoricTransfer
    {kind : IUTStage1PlaceKind} {j : Nat}
    (source target :
      IUTStage1RealizedTensorPacketProductLogVolume kind j) where
  sourceRealization : IUTStage1TensorPacketRealizationKind
  targetRealization : IUTStage1TensorPacketRealizationKind
  source_realization_eq : source.realization = sourceRealization
  target_realization_eq : target.realization = targetRealization
  histories_not_identified : source.theater.side ≠ target.theater.side
  baseCount_eq : source.product.baseCount = target.product.baseCount
  productLogVolume_eq :
    target.product.productLogVolume = source.product.productLogVolume

namespace IUTStage1TensorPacketCoricTransfer

variable {kind : IUTStage1PlaceKind} {j : Nat}
variable {source target :
  IUTStage1RealizedTensorPacketProductLogVolume kind j}

theorem preserves_productLogVolume
    (transfer : IUTStage1TensorPacketCoricTransfer source target) :
    target.product.productLogVolume = source.product.productLogVolume :=
  transfer.productLogVolume_eq

theorem source_history_ne_target_history
    (transfer : IUTStage1TensorPacketCoricTransfer source target) :
    source.theater.side ≠ target.theater.side :=
  transfer.histories_not_identified

end IUTStage1TensorPacketCoricTransfer

/-- Kummer transfer from labeled `F` tensor packets to labeled `D` tensor packets. -/
structure IUTStage1KummerFTensorPacketToDTensorPacketTransfer
    {kind : IUTStage1PlaceKind} {j : Nat}
    (source target :
      IUTStage1RealizedTensorPacketProductLogVolume kind j) where
  transfer : IUTStage1TensorPacketCoricTransfer source target
  source_is_holomorphicF :
    source.realization = IUTStage1TensorPacketRealizationKind.holomorphicF
  target_is_holomorphicD :
    target.realization = IUTStage1TensorPacketRealizationKind.holomorphicD

namespace IUTStage1KummerFTensorPacketToDTensorPacketTransfer

variable {kind : IUTStage1PlaceKind} {j : Nat}
variable {source target :
  IUTStage1RealizedTensorPacketProductLogVolume kind j}

theorem preserves_productLogVolume
    (data :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer source target) :
    target.product.productLogVolume = source.product.productLogVolume :=
  data.transfer.preserves_productLogVolume

theorem source_history_ne_target_history
    (data :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer source target) :
    source.theater.side ≠ target.theater.side :=
  data.transfer.source_history_ne_target_history

end IUTStage1KummerFTensorPacketToDTensorPacketTransfer

/--
Forgetting step from a holomorphic `D` tensor-packet product to a mono-analytic
`D^⊢` tensor-packet product.
-/
structure IUTStage1MonoAnalyticTensorPacketForgettingTransfer
    {kind : IUTStage1PlaceKind} {j : Nat}
    (source target :
      IUTStage1RealizedTensorPacketProductLogVolume kind j) where
  transfer : IUTStage1TensorPacketCoricTransfer source target
  source_is_holomorphicD :
    source.realization = IUTStage1TensorPacketRealizationKind.holomorphicD
  target_is_monoAnalyticD :
    target.realization = IUTStage1TensorPacketRealizationKind.monoAnalyticD
  holomorphicStructureForgotten : Prop
  holomorphic_structure_forgotten : holomorphicStructureForgotten

namespace IUTStage1MonoAnalyticTensorPacketForgettingTransfer

variable {kind : IUTStage1PlaceKind} {j : Nat}
variable {source target :
  IUTStage1RealizedTensorPacketProductLogVolume kind j}

theorem preserves_productLogVolume
    (data :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer source target) :
    target.product.productLogVolume = source.product.productLogVolume :=
  data.transfer.preserves_productLogVolume

theorem source_history_ne_target_history
    (data :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer source target) :
    source.theater.side ≠ target.theater.side :=
  data.transfer.source_history_ne_target_history

theorem structureForgotten
    (data :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer source target) :
    data.holomorphicStructureForgotten :=
  data.holomorphic_structure_forgotten

end IUTStage1MonoAnalyticTensorPacketForgettingTransfer

/--
Frobenioid-level source for a Kummer/log-link compatible tensor-packet
transfer.

This is a finite realified shadow of the IUT III statement that the
Frobenioid-theoretic side and the vertically coric/etale side are related by
Kummer/log-Kummer correspondences.  The theorem below projects it to the current
`IUTStage1TensorPacketCoricTransfer` by deriving product-log-volume equality
from equality of realified Frobenioid log-volumes.
-/
structure IUTStage1RealifiedFrobenioidKummerCompatibility
    {kind : IUTStage1PlaceKind} {j : Nat}
    (source target :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j) where
  sourceRealization : IUTStage1TensorPacketRealizationKind
  targetRealization : IUTStage1TensorPacketRealizationKind
  source_realization_eq : source.realization = sourceRealization
  target_realization_eq : target.realization = targetRealization
  histories_not_identified : source.theater.side ≠ target.theater.side
  baseCount_eq : source.product.baseCount = target.product.baseCount
  realifiedLogVolume_eq :
    target.frobenioidDegree.realifiedLogVolume =
      source.frobenioidDegree.realifiedLogVolume

namespace IUTStage1RealifiedFrobenioidKummerCompatibility

variable {kind : IUTStage1PlaceKind} {j : Nat}
variable {source target :
  IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j}

def toTensorPacketCoricTransfer
    (compat :
      IUTStage1RealifiedFrobenioidKummerCompatibility source target) :
    IUTStage1TensorPacketCoricTransfer
      source.toRealized target.toRealized :=
  { sourceRealization := compat.sourceRealization,
    targetRealization := compat.targetRealization,
    source_realization_eq := compat.source_realization_eq,
    target_realization_eq := compat.target_realization_eq,
    histories_not_identified := compat.histories_not_identified,
    baseCount_eq := compat.baseCount_eq,
    productLogVolume_eq :=
      source.productLogVolume_eq_of_realifiedLogVolume_eq
        compat.realifiedLogVolume_eq }

theorem toTransfer_preserves_productLogVolume
    (compat :
      IUTStage1RealifiedFrobenioidKummerCompatibility source target) :
    target.toRealized.product.productLogVolume =
      source.toRealized.product.productLogVolume :=
  compat.toTensorPacketCoricTransfer.preserves_productLogVolume

def toKummerFTensorPacketToDTensorPacketTransfer
    (compat :
      IUTStage1RealifiedFrobenioidKummerCompatibility source target)
    (source_is_holomorphicF :
      source.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (target_is_holomorphicD :
      target.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD) :
    IUTStage1KummerFTensorPacketToDTensorPacketTransfer
      source.toRealized target.toRealized :=
  { transfer := compat.toTensorPacketCoricTransfer,
    source_is_holomorphicF := source_is_holomorphicF,
    target_is_holomorphicD := target_is_holomorphicD }

def toMonoAnalyticTensorPacketForgettingTransfer
    (compat :
      IUTStage1RealifiedFrobenioidKummerCompatibility source target)
    (source_is_holomorphicD :
      source.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (target_is_monoAnalyticD :
      target.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten) :
    IUTStage1MonoAnalyticTensorPacketForgettingTransfer
      source.toRealized target.toRealized :=
  { transfer := compat.toTensorPacketCoricTransfer,
    source_is_holomorphicD := source_is_holomorphicD,
    target_is_monoAnalyticD := target_is_monoAnalyticD,
    holomorphicStructureForgotten := holomorphicStructureForgotten,
    holomorphic_structure_forgotten := holomorphic_structure_forgotten }

theorem frobenioidKummerCompatibility_endpoint
    (compat :
      IUTStage1RealifiedFrobenioidKummerCompatibility source target) :
    target.toRealized.product.productLogVolume =
        source.toRealized.product.productLogVolume ∧
      source.toRealized.theater.side ≠ target.toRealized.theater.side :=
  ⟨compat.toTransfer_preserves_productLogVolume,
    compat.histories_not_identified⟩

end IUTStage1RealifiedFrobenioidKummerCompatibility

/--
Remark 3.9.5 holomorphic-hull shadow.

The paper characterizes hull formation by the three closure properties P1--P3:
closed hulls are fixed, every region is contained in its hull, and inclusion of
regions is preserved by hull formation.  We record exactly that closure-operator
skeleton, together with the monotonicity of the log-volume used in Step (xi).
-/
structure IUTStage1HolomorphicHullLogVolumeShadow (α : Type u) where
  hull : ClosureOperator (Set α)
  logVolume : Set α -> Real
  logVolume_mono :
    ∀ {region₁ region₂ : Set α},
      region₁ ⊆ region₂ -> logVolume region₁ <= logVolume region₂

namespace IUTStage1HolomorphicHullLogVolumeShadow

variable {α : Type u}
variable {line : Copy}

def hullRegion
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    Set α :=
  data.hull region

theorem hull_fix_of_closed
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {region : Set α}
    (hclosed : data.hull.IsClosed region) :
    data.hullRegion region = region :=
  data.hull.isClosed_iff.mp hclosed

theorem region_subset_hull
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    region ⊆ data.hullRegion region :=
  data.hull.le_closure region

theorem hull_mono
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {region₁ region₂ : Set α}
    (hsubset : region₁ ⊆ region₂) :
    data.hullRegion region₁ ⊆ data.hullRegion region₂ :=
  data.hull.monotone hsubset

theorem hull_idempotent
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    data.hullRegion (data.hullRegion region) = data.hullRegion region :=
  data.hull.idempotent region

/--
Remark 3.9.5(ii) hull-map laws.

For a closed hull `H`, the map `phi(P) = hullRegion P` fixes `H`,
contains every region `P`, and preserves inclusions `P₁ ⊆ P₂`.  The final
idempotence clause records that applying the hull map again does not enlarge
the already formed hull.
-/
theorem remark395_hullMap_laws
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {closedHull region region₁ region₂ : Set α}
    (hclosed : data.hull.IsClosed closedHull)
    (hsubset : region₁ ⊆ region₂) :
    data.hullRegion closedHull = closedHull ∧
      region ⊆ data.hullRegion region ∧
      data.hullRegion region₁ ⊆ data.hullRegion region₂ ∧
      data.hullRegion (data.hullRegion region) = data.hullRegion region :=
  ⟨data.hull_fix_of_closed hclosed,
    data.region_subset_hull region,
    data.hull_mono hsubset,
    data.hull_idempotent region⟩

theorem logVolume_le_hullLogVolume
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    data.logVolume region <= data.logVolume (data.hullRegion region) :=
  data.logVolume_mono (data.region_subset_hull region)

theorem logVolume_hull_mono
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {region₁ region₂ : Set α}
    (hsubset : region₁ ⊆ region₂) :
    data.logVolume (data.hullRegion region₁) <=
      data.logVolume (data.hullRegion region₂) :=
  data.logVolume_mono (data.hull_mono hsubset)

theorem logVolume_le_of_subset_hull
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {region₁ region₂ : Set α}
    (hsubset : region₁ ⊆ data.hullRegion region₂) :
    data.logVolume region₁ <= data.logVolume (data.hullRegion region₂) :=
  data.logVolume_mono hsubset

theorem hull_subset_closed_of_subset
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {region closedRegion : Set α}
    (hsubset : region ⊆ closedRegion)
    (hclosed : data.hull.IsClosed closedRegion) :
    data.hullRegion region ⊆ closedRegion :=
  hclosed.closure_le_iff.mpr hsubset

theorem logVolume_hull_le_closed_of_subset
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {region closedRegion : Set α}
    (hsubset : region ⊆ closedRegion)
    (hclosed : data.hull.IsClosed closedRegion) :
    data.logVolume (data.hullRegion region) <=
      data.logVolume closedRegion :=
  data.logVolume_mono
    (data.hull_subset_closed_of_subset hsubset hclosed)

def toRegionHullOperator
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line)) :
    HullOperator line :=
  { hull := fun region =>
      Region.ofSet (data.hullRegion region.toSet),
    extensive := fun region _ hx =>
      data.region_subset_hull region.toSet hx,
    monotone := fun hsubset _ hx =>
      data.hull_mono
        (Region.subset_iff_toSet_subset.mp hsubset) hx }

def toRegionMeasure
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line)) :
    RegionMeasure line :=
  { volume := fun region => data.logVolume region.toSet,
    monotone := fun hsubset =>
      data.logVolume_mono
        (Region.subset_iff_toSet_subset.mp hsubset) }

@[simp]
theorem toRegionHullOperator_hull_toSet
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line))
    (region : Region line) :
    ((data.toRegionHullOperator).hull region).toSet =
      data.hullRegion region.toSet :=
  rfl

@[simp]
theorem toRegionMeasure_volume_eq
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line))
    (region : Region line) :
    data.toRegionMeasure.volume region = data.logVolume region.toSet :=
  rfl

theorem toRegionMeasure_le_hull
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line))
    (region : Region line) :
    data.toRegionMeasure.volume region <=
      data.toRegionMeasure.volume ((data.toRegionHullOperator).hull region) :=
  data.logVolume_le_hullLogVolume region.toSet

theorem toRegionMeasure_hull_volume_eq
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line))
    (region : Region line) :
    data.toRegionMeasure.volume ((data.toRegionHullOperator).hull region) =
      data.logVolume (data.hullRegion region.toSet) :=
  rfl

theorem toRegionHullOperator_endpoint
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line))
    (region : Region line) :
    ((data.toRegionHullOperator).hull region).toSet =
        data.hullRegion region.toSet ∧
      Region.Subset region ((data.toRegionHullOperator).hull region) ∧
      data.toRegionMeasure.volume region <=
        data.toRegionMeasure.volume ((data.toRegionHullOperator).hull region) :=
  ⟨rfl,
    (data.toRegionHullOperator).extensive region,
    data.toRegionMeasure_le_hull region⟩

end IUTStage1HolomorphicHullLogVolumeShadow

/--
Remark 3.9.5(iii) hull approximant.

For a region `P`, Mochizuki's set `Φ(P)` consists of hulls contained in
`φ(P)` whose log-volume lies between the log-volume of `P` and that of
`φ(P)`.  This record formalizes exactly that order/log-volume skeleton.  The
field `approximant_subset_hull` is the compactness guard emphasized in the
paper: every allowed choice remains inside the canonical hull `φ(P)`.
-/
structure IUTStage1HullLogVolumeApproximant
    {α : Type u}
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) where
  approximant : Set α
  approximant_closed : data.hull.IsClosed approximant
  approximant_subset_hull : approximant ⊆ data.hullRegion region
  region_logVolume_le :
    data.logVolume region <= data.logVolume approximant
  approximant_logVolume_le_hull :
    data.logVolume approximant <= data.logVolume (data.hullRegion region)

namespace IUTStage1HullLogVolumeApproximant

variable {α : Type u}
variable {data : IUTStage1HolomorphicHullLogVolumeShadow α}
variable {region : Set α}

def canonical
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    IUTStage1HullLogVolumeApproximant data region :=
  { approximant := data.hullRegion region,
    approximant_closed := data.hull.isClosed_closure region,
    approximant_subset_hull := fun _ hx => hx,
    region_logVolume_le := data.logVolume_le_hullLogVolume region,
    approximant_logVolume_le_hull := le_rfl }

theorem canonical_approximant_eq_hull
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    (canonical data region).approximant = data.hullRegion region :=
  rfl

theorem approximant_logVolume_between
    (approximant :
      IUTStage1HullLogVolumeApproximant data region) :
    data.logVolume region <= data.logVolume approximant.approximant ∧
      data.logVolume approximant.approximant <=
        data.logVolume (data.hullRegion region) :=
  ⟨approximant.region_logVolume_le,
    approximant.approximant_logVolume_le_hull⟩

theorem approximant_subset_compactCarrier
    (approximant :
      IUTStage1HullLogVolumeApproximant data region) :
    approximant.approximant ⊆ data.hullRegion region :=
  approximant.approximant_subset_hull

theorem approximant_hull_le_canonical_hull
    (approximant :
      IUTStage1HullLogVolumeApproximant data region) :
    data.hullRegion approximant.approximant ⊆ data.hullRegion region :=
  data.hull_subset_closed_of_subset
    approximant.approximant_subset_hull (data.hull.isClosed_closure region)

theorem approximant_hull_eq_self
    (approximant :
      IUTStage1HullLogVolumeApproximant data region) :
    data.hullRegion approximant.approximant = approximant.approximant :=
  data.hull_fix_of_closed approximant.approximant_closed

theorem approximant_hullLogVolume_le_canonical_hull
    (approximant :
      IUTStage1HullLogVolumeApproximant data region) :
    data.logVolume (data.hullRegion approximant.approximant) <=
      data.logVolume (data.hullRegion region) := by
  rw [approximant.approximant_hull_eq_self]
  exact approximant.approximant_logVolume_le_hull

theorem endpoint
    (approximant :
      IUTStage1HullLogVolumeApproximant data region) :
    approximant.approximant ⊆ data.hullRegion region ∧
      data.logVolume region <= data.logVolume approximant.approximant ∧
      data.logVolume approximant.approximant <=
        data.logVolume (data.hullRegion region) ∧
      data.hullRegion approximant.approximant = approximant.approximant :=
  ⟨approximant.approximant_subset_compactCarrier,
    approximant.region_logVolume_le,
    approximant.approximant_logVolume_le_hull,
    approximant.approximant_hull_eq_self⟩

end IUTStage1HullLogVolumeApproximant

/--
Remark 3.9.5(iii) exact hull approximant.

This is the finite skeleton of an element of `Xi(P)`: it is a hull
approximant whose log-volume is exactly the log-volume of the original region
`P`.  The definition deliberately keeps this weaker than uniqueness; uniqueness
of exact approximants is not available from the present order/log-volume
skeleton alone.
-/
structure IUTStage1ExactHullLogVolumeApproximant
    {α : Type u}
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) where
  approximant : IUTStage1HullLogVolumeApproximant data region
  exact_logVolume :
    data.logVolume approximant.approximant = data.logVolume region

namespace IUTStage1ExactHullLogVolumeApproximant

variable {α : Type u}
variable {data : IUTStage1HolomorphicHullLogVolumeShadow α}
variable {region : Set α}

def canonicalOfClosed
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α)
    (hclosed : data.hull.IsClosed region) :
    IUTStage1ExactHullLogVolumeApproximant data region :=
  { approximant := IUTStage1HullLogVolumeApproximant.canonical data region,
    exact_logVolume := by
      rw [IUTStage1HullLogVolumeApproximant.canonical_approximant_eq_hull,
        data.hull_fix_of_closed hclosed] }

theorem approximant_subset_hull
    (exact : IUTStage1ExactHullLogVolumeApproximant data region) :
    exact.approximant.approximant ⊆ data.hullRegion region :=
  exact.approximant.approximant_subset_compactCarrier

theorem approximant_hull_eq_self
    (exact : IUTStage1ExactHullLogVolumeApproximant data region) :
    data.hullRegion exact.approximant.approximant =
      exact.approximant.approximant :=
  exact.approximant.approximant_hull_eq_self

theorem regionLogVolume_eq_approximantLogVolume
    (exact : IUTStage1ExactHullLogVolumeApproximant data region) :
    data.logVolume region = data.logVolume exact.approximant.approximant :=
  exact.exact_logVolume.symm

theorem exactLogVolume_le_hullLogVolume
    (exact : IUTStage1ExactHullLogVolumeApproximant data region) :
    data.logVolume exact.approximant.approximant <=
      data.logVolume (data.hullRegion region) :=
  exact.approximant.approximant_logVolume_le_hull

theorem endpoint
    (exact : IUTStage1ExactHullLogVolumeApproximant data region) :
    exact.approximant.approximant ⊆ data.hullRegion region ∧
      data.logVolume exact.approximant.approximant =
        data.logVolume region ∧
      data.logVolume region =
        data.logVolume exact.approximant.approximant ∧
      data.logVolume exact.approximant.approximant <=
        data.logVolume (data.hullRegion region) ∧
      data.hullRegion exact.approximant.approximant =
        exact.approximant.approximant :=
  ⟨exact.approximant_subset_hull,
    exact.exact_logVolume,
    exact.regionLogVolume_eq_approximantLogVolume,
    exact.exactLogVolume_le_hullLogVolume,
    exact.approximant_hull_eq_self⟩

theorem canonicalOfClosed_endpoint
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α)
    (hclosed : data.hull.IsClosed region) :
    let exact := canonicalOfClosed data region hclosed;
    exact.approximant.approximant = data.hullRegion region ∧
      data.hullRegion region = region ∧
      data.logVolume exact.approximant.approximant =
        data.logVolume region :=
  by
    intro exact
    exact
      ⟨IUTStage1HullLogVolumeApproximant.canonical_approximant_eq_hull
          data region,
        data.hull_fix_of_closed hclosed,
        exact.exact_logVolume⟩

end IUTStage1ExactHullLogVolumeApproximant

/--
Remark 3.9.5(iv) finite approximant family.

The paper writes `H_{Phi(P)}` for the union of all hull approximants in
`Phi(P)` and observes that `phi(P) ∈ Phi(P)`, hence `H_{Phi(P)} = phi(P)`.
This record is the finite version needed by the present formalization: a
family of `Phi(P)`-approximants together with a distinguished member whose
carrier is the canonical hull `phi(P)`.
-/
structure IUTStage1HullLogVolumeApproximantFamily
    {α : Type u}
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α)
    (κ : Type v) where
  approximant : κ -> IUTStage1HullLogVolumeApproximant data region
  canonicalIndex : κ
  canonical_approximant_eq_hull :
    (approximant canonicalIndex).approximant = data.hullRegion region

namespace IUTStage1HullLogVolumeApproximantFamily

variable {α : Type u} {κ : Type v}
variable {data : IUTStage1HolomorphicHullLogVolumeShadow α}
variable {region : Set α}

def canonical
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    IUTStage1HullLogVolumeApproximantFamily data region PUnit :=
  { approximant := fun _ =>
      IUTStage1HullLogVolumeApproximant.canonical data region,
    canonicalIndex := PUnit.unit,
    canonical_approximant_eq_hull :=
      IUTStage1HullLogVolumeApproximant.canonical_approximant_eq_hull
        data region }

def familyUnion
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ) :
    Set α :=
  ⋃ k, (family.approximant k).approximant

theorem approximant_subset_hull
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ)
    (k : κ) :
    (family.approximant k).approximant ⊆ data.hullRegion region :=
  (family.approximant k).approximant_subset_compactCarrier

theorem familyUnion_subset_hull
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ) :
    family.familyUnion ⊆ data.hullRegion region := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨k, hxk⟩
  exact family.approximant_subset_hull k hxk

theorem hull_subset_familyUnion
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ) :
    data.hullRegion region ⊆ family.familyUnion := by
  intro x hx
  exact Set.mem_iUnion.mpr
    ⟨family.canonicalIndex,
      by
        rw [family.canonical_approximant_eq_hull]
        exact hx⟩

theorem familyUnion_eq_hull
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ) :
    family.familyUnion = data.hullRegion region :=
  Set.Subset.antisymm family.familyUnion_subset_hull
    family.hull_subset_familyUnion

theorem logVolume_familyUnion_eq_hull
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ) :
    data.logVolume family.familyUnion =
      data.logVolume (data.hullRegion region) := by
  rw [family.familyUnion_eq_hull]

theorem endpoint
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ) :
    family.familyUnion ⊆ data.hullRegion region ∧
      data.hullRegion region ⊆ family.familyUnion ∧
      family.familyUnion = data.hullRegion region ∧
      data.logVolume family.familyUnion =
        data.logVolume (data.hullRegion region) :=
  ⟨family.familyUnion_subset_hull,
    family.hull_subset_familyUnion,
    family.familyUnion_eq_hull,
    family.logVolume_familyUnion_eq_hull⟩

theorem canonical_endpoint
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α) :
    let family := canonical data region;
    family.familyUnion = data.hullRegion region ∧
      data.logVolume family.familyUnion =
        data.logVolume (data.hullRegion region) :=
  by
    intro family
    exact
      ⟨family.familyUnion_eq_hull,
        family.logVolume_familyUnion_eq_hull⟩

end IUTStage1HullLogVolumeApproximantFamily

/--
Remark 3.9.5(iv) finite exact-approximant family.

This is the `Xi(P)` analogue of `IUTStage1HullLogVolumeApproximantFamily`.
Each member has the exact log-volume of `P`; if the family contains the
canonical hull, its union is again `phi(P)`.  When `P` itself is closed under
the hull operator, the canonical one-point exact family has union `P`.
-/
structure IUTStage1ExactHullLogVolumeApproximantFamily
    {α : Type u}
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α)
    (κ : Type v) where
  exactApproximant :
    κ -> IUTStage1ExactHullLogVolumeApproximant data region
  canonicalIndex : κ
  canonical_approximant_eq_hull :
    ((exactApproximant canonicalIndex).approximant).approximant =
      data.hullRegion region

namespace IUTStage1ExactHullLogVolumeApproximantFamily

variable {α : Type u} {κ : Type v}
variable {data : IUTStage1HolomorphicHullLogVolumeShadow α}
variable {region : Set α}

def canonicalOfClosed
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α)
    (hclosed : data.hull.IsClosed region) :
    IUTStage1ExactHullLogVolumeApproximantFamily data region PUnit :=
  { exactApproximant := fun _ =>
      IUTStage1ExactHullLogVolumeApproximant.canonicalOfClosed
        data region hclosed,
    canonicalIndex := PUnit.unit,
    canonical_approximant_eq_hull :=
      IUTStage1HullLogVolumeApproximant.canonical_approximant_eq_hull
        data region }

def familyUnion
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ) :
    Set α :=
  ⋃ k, ((family.exactApproximant k).approximant).approximant

theorem exactApproximant_subset_hull
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ)
    (k : κ) :
    ((family.exactApproximant k).approximant).approximant ⊆
      data.hullRegion region :=
  (family.exactApproximant k).approximant_subset_hull

theorem exactApproximant_logVolume_eq_region
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ)
    (k : κ) :
    data.logVolume
        ((family.exactApproximant k).approximant).approximant =
      data.logVolume region :=
  (family.exactApproximant k).exact_logVolume

theorem familyUnion_subset_hull
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ) :
    family.familyUnion ⊆ data.hullRegion region := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨k, hxk⟩
  exact family.exactApproximant_subset_hull k hxk

theorem hull_subset_familyUnion
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ) :
    data.hullRegion region ⊆ family.familyUnion := by
  intro x hx
  exact Set.mem_iUnion.mpr
    ⟨family.canonicalIndex,
      by
        rw [family.canonical_approximant_eq_hull]
        exact hx⟩

theorem familyUnion_eq_hull
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ) :
    family.familyUnion = data.hullRegion region :=
  Set.Subset.antisymm family.familyUnion_subset_hull
    family.hull_subset_familyUnion

theorem logVolume_familyUnion_eq_hull
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ) :
    data.logVolume family.familyUnion =
      data.logVolume (data.hullRegion region) := by
  rw [family.familyUnion_eq_hull]

theorem endpoint
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ)
    (k : κ) :
    family.familyUnion ⊆ data.hullRegion region ∧
      data.hullRegion region ⊆ family.familyUnion ∧
      family.familyUnion = data.hullRegion region ∧
      data.logVolume
          ((family.exactApproximant k).approximant).approximant =
        data.logVolume region ∧
      data.logVolume family.familyUnion =
        data.logVolume (data.hullRegion region) :=
  ⟨family.familyUnion_subset_hull,
    family.hull_subset_familyUnion,
    family.familyUnion_eq_hull,
    family.exactApproximant_logVolume_eq_region k,
    family.logVolume_familyUnion_eq_hull⟩

theorem canonicalOfClosed_endpoint
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α)
    (hclosed : data.hull.IsClosed region) :
    let family := canonicalOfClosed data region hclosed;
    family.familyUnion = data.hullRegion region ∧
      data.hullRegion region = region ∧
      family.familyUnion = region ∧
      data.logVolume family.familyUnion = data.logVolume region :=
  by
    intro family
    have hUnion : family.familyUnion = data.hullRegion region :=
      family.familyUnion_eq_hull
    have hHull : data.hullRegion region = region :=
      data.hull_fix_of_closed hclosed
    exact
      ⟨hUnion,
        hHull,
        hUnion.trans hHull,
        by rw [hUnion, hHull]⟩

end IUTStage1ExactHullLogVolumeApproximantFamily

/--
Remark 3.9.5(v) upper-semi set quotient.

For a subset `S ⊆ E`, the paper considers the quotient `E^S` that identifies
all elements of `S` and leaves the complement unchanged.  This is the abstract
set-theoretic skeleton used to explain upper semi-compatibility: after passing
to the quotient, any nonempty subset of `S` has the same image.
-/
inductive IUTStage1UpperSemiSetQuotient (E : Type u) (S : Set E) where
  | collapsed : IUTStage1UpperSemiSetQuotient E S
  | outside (x : E) (hx : x ∉ S) : IUTStage1UpperSemiSetQuotient E S

namespace IUTStage1UpperSemiSetQuotient

variable {E : Type u} {S : Set E}

noncomputable def quotientMap
    (S : Set E) (x : E) : IUTStage1UpperSemiSetQuotient E S := by
  classical
  exact if hx : x ∈ S then collapsed else outside x hx

theorem quotientMap_eq_collapsed_of_mem
    {x : E} (hx : x ∈ S) :
    quotientMap S x = collapsed := by
  simp [quotientMap, hx]

theorem quotientMap_eq_outside_of_not_mem
    {x : E} (hx : x ∉ S) :
    quotientMap S x = outside x hx := by
  simp [quotientMap, hx]

theorem quotientMap_eq_of_mem
    {x y : E} (hx : x ∈ S) (hy : y ∈ S) :
    quotientMap S x = quotientMap S y := by
  rw [quotientMap_eq_collapsed_of_mem hx,
    quotientMap_eq_collapsed_of_mem hy]

theorem quotientMap_preimage_collapsed :
    { x : E | quotientMap S x = collapsed } = S := by
  ext x
  constructor
  · intro hmap
    change quotientMap S x = collapsed at hmap
    by_cases hx : x ∈ S
    · exact hx
    · rw [quotientMap_eq_outside_of_not_mem hx] at hmap
      cases hmap
  · intro hx
    exact quotientMap_eq_collapsed_of_mem hx

theorem quotientMap_eq_collapsed_iff {x : E} :
    quotientMap S x = collapsed ↔ x ∈ S := by
  constructor
  · intro hmap
    have hpre :
        x ∈ { x : E | quotientMap S x = collapsed } :=
      hmap
    rw [quotientMap_preimage_collapsed] at hpre
    exact hpre
  · intro hx
    exact quotientMap_eq_collapsed_of_mem hx

theorem quotientMap_ne_collapsed_of_not_mem
    {x : E} (hx : x ∉ S) :
    quotientMap S x ≠ collapsed := by
  intro hmap
  exact hx (quotientMap_eq_collapsed_iff.mp hmap)

theorem quotientMap_eq_quotientMap_of_mem_iff
    {x y : E} (hy : y ∈ S) :
    quotientMap S x = quotientMap S y ↔ x ∈ S := by
  rw [quotientMap_eq_collapsed_of_mem hy]
  exact quotientMap_eq_collapsed_iff

theorem quotientMap_image_eq_singleton_collapsed_of_nonempty_subset
    {A : Set E} (hne : A.Nonempty) (hsubset : A ⊆ S) :
    quotientMap S '' A = {collapsed} := by
  ext q
  constructor
  · rintro ⟨x, hxA, rfl⟩
    simp [quotientMap_eq_collapsed_of_mem (hsubset hxA)]
  · intro hq
    rcases hne with ⟨x, hxA⟩
    rw [Set.mem_singleton_iff] at hq
    subst q
    exact
      ⟨x, hxA, quotientMap_eq_collapsed_of_mem (hsubset hxA)⟩

theorem quotientMap_image_eq_singleton_collapsed_iff
    {A : Set E} (hne : A.Nonempty) :
    quotientMap S '' A = {collapsed} ↔ A ⊆ S := by
  constructor
  · intro himage x hxA
    have hcollapsed :
        quotientMap S x = collapsed := by
      have hmem : quotientMap S x ∈ quotientMap S '' A :=
        ⟨x, hxA, rfl⟩
      rw [himage] at hmem
      exact Set.mem_singleton_iff.mp hmem
    have hpre :
        x ∈ { x : E | quotientMap S x = collapsed } :=
      hcollapsed
    rw [quotientMap_preimage_collapsed] at hpre
    exact hpre
  · intro hsubset
    exact
      quotientMap_image_eq_singleton_collapsed_of_nonempty_subset
        hne hsubset

theorem quotientMap_images_eq_of_nonempty_subsets
    {A B : Set E}
    (hneA : A.Nonempty) (hsubA : A ⊆ S)
    (hneB : B.Nonempty) (hsubB : B ⊆ S) :
    quotientMap S '' A = quotientMap S '' B := by
  rw [quotientMap_image_eq_singleton_collapsed_of_nonempty_subset hneA hsubA,
    quotientMap_image_eq_singleton_collapsed_of_nonempty_subset hneB hsubB]

theorem quotientMap_two_images_collapse_iff
    {A B : Set E}
    (hneA : A.Nonempty) (hneB : B.Nonempty) :
    quotientMap S '' A = {collapsed} ∧
        quotientMap S '' B = {collapsed} ↔
      A ⊆ S ∧ B ⊆ S := by
  constructor
  · rintro ⟨hA, hB⟩
    exact
      ⟨(quotientMap_image_eq_singleton_collapsed_iff hneA).mp hA,
        (quotientMap_image_eq_singleton_collapsed_iff hneB).mp hB⟩
  · rintro ⟨hA, hB⟩
    exact
      ⟨(quotientMap_image_eq_singleton_collapsed_iff hneA).mpr hA,
        (quotientMap_image_eq_singleton_collapsed_iff hneB).mpr hB⟩

theorem quotientMap_map_between_subsets_eq_identity
    {A B : Set E} {f : E -> E}
    (hsubA : A ⊆ S) (hsubB : B ⊆ S)
    (hf : ∀ x, x ∈ A -> f x ∈ B)
    {x : E} (hxA : x ∈ A) :
    quotientMap S (f x) = quotientMap S x := by
  exact quotientMap_eq_of_mem (hsubB (hf x hxA)) (hsubA hxA)

theorem quotientMap_image_under_map_between_subsets
    {A B : Set E} {f : E -> E}
    (hneA : A.Nonempty)
    (hsubA : A ⊆ S) (hsubB : B ⊆ S)
    (hf : ∀ x, x ∈ A -> f x ∈ B) :
    (fun x => quotientMap S (f x)) '' A = quotientMap S '' A := by
  rw [quotientMap_image_eq_singleton_collapsed_of_nonempty_subset hneA hsubA]
  ext q
  constructor
  · rintro ⟨x, hxA, rfl⟩
    simp [quotientMap_eq_collapsed_of_mem (hsubB (hf x hxA))]
  · intro hq
    rcases hneA with ⟨x, hxA⟩
    rw [Set.mem_singleton_iff] at hq
    subst q
    exact
      ⟨x, hxA, quotientMap_eq_collapsed_of_mem (hsubB (hf x hxA))⟩

theorem quotientMap_eq_iff_of_not_mem
    {x y : E} (hx : x ∉ S) (hy : y ∉ S) :
    quotientMap S x = quotientMap S y ↔ x = y := by
  constructor
  · intro hmap
    rw [quotientMap_eq_outside_of_not_mem hx,
      quotientMap_eq_outside_of_not_mem hy] at hmap
    cases hmap
    rfl
  · intro hxy
    subst y
    rfl

/--
Remark 3.9.5(v) formal intersection system.

The source text extends the upper-semi quotient discussion to a "formal empty
set" treated as an inverse system of nonempty subsets of `S`.  This finite
skeleton records such a system: every component is nonempty and contained in
`S`, so after quotienting every component maps to the collapsed point.
-/
structure FormalIntersectionSystem (κ : Type v) where
  component : κ -> Set E
  component_nonempty : ∀ k, (component k).Nonempty
  component_subset : ∀ k, component k ⊆ S

namespace FormalIntersectionSystem

variable {κ : Type v}

def quotientImage
    (system : FormalIntersectionSystem (E := E) (S := S) κ)
    (k : κ) :
    Set (IUTStage1UpperSemiSetQuotient E S) :=
  quotientMap S '' system.component k

theorem quotientImage_eq_collapsed
    (system : FormalIntersectionSystem (E := E) (S := S) κ)
    (k : κ) :
    system.quotientImage k = {collapsed} :=
  quotientMap_image_eq_singleton_collapsed_of_nonempty_subset
    (system.component_nonempty k) (system.component_subset k)

theorem quotientImages_eq
    (system : FormalIntersectionSystem (E := E) (S := S) κ)
    (i j : κ) :
    system.quotientImage i = system.quotientImage j := by
  rw [system.quotientImage_eq_collapsed i,
    system.quotientImage_eq_collapsed j]

theorem component_map_quotientImage_eq
    (system : FormalIntersectionSystem (E := E) (S := S) κ)
    (i j : κ)
    (f : E -> E)
    (hf :
      ∀ x, x ∈ system.component i -> f x ∈ system.component j) :
    (fun x => quotientMap S (f x)) '' system.component i =
      system.quotientImage i := by
  simpa [quotientImage] using
    quotientMap_image_under_map_between_subsets
      (S := S)
      (A := system.component i)
      (B := system.component j)
      (f := f)
      (system.component_nonempty i)
      (system.component_subset i)
      (system.component_subset j)
      hf

theorem endpoint
    (system : FormalIntersectionSystem (E := E) (S := S) κ)
    (i j : κ) :
    system.component i ⊆ S ∧
      system.quotientImage i = {collapsed} ∧
      system.quotientImage i = system.quotientImage j :=
  ⟨system.component_subset i,
    system.quotientImage_eq_collapsed i,
    system.quotientImages_eq i j⟩

end FormalIntersectionSystem

end IUTStage1UpperSemiSetQuotient

/--
Remark 3.9.5(v)--(vi) bounded-family hull quotient.

For a bounded family of possible regions `Pβ`, the source text takes the
upper-semi quotient determined by the hull of the family.  This finite skeleton
uses the hull of the union as the family hull and proves that every nonempty
possible region maps to the collapsed quotient point; hence any two nonempty
choices have the same quotient image.
-/
structure IUTStage1BoundedFamilyHullQuotientSource
    (α : Type u) (ι : Type v) where
  hullData : IUTStage1HolomorphicHullLogVolumeShadow α
  possibleRegion : ι -> Set α

namespace IUTStage1BoundedFamilyHullQuotientSource

variable {α : Type u} {ι : Type v}

open IUTStage1UpperSemiSetQuotient

def familyUnion
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι) :
    Set α :=
  ⋃ i, data.possibleRegion i

def familyHull
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι) :
    Set α :=
  data.hullData.hullRegion data.familyUnion

noncomputable def quotientMap
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (x : α) :
    IUTStage1UpperSemiSetQuotient α data.familyHull :=
  IUTStage1UpperSemiSetQuotient.quotientMap data.familyHull x

theorem possibleRegion_subset_familyUnion
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i : ι) :
    data.possibleRegion i ⊆ data.familyUnion := by
  intro x hx
  exact Set.mem_iUnion.mpr ⟨i, hx⟩

theorem possibleRegion_subset_familyHull
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i : ι) :
    data.possibleRegion i ⊆ data.familyHull :=
  fun _ hx =>
    data.hullData.region_subset_hull data.familyUnion
      (data.possibleRegion_subset_familyUnion i hx)

theorem quotientMap_image_possibleRegion_eq_collapsed
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i : ι)
    (hne : (data.possibleRegion i).Nonempty) :
    data.quotientMap '' data.possibleRegion i =
      {IUTStage1UpperSemiSetQuotient.collapsed} := by
  simpa [quotientMap] using
    quotientMap_image_eq_singleton_collapsed_of_nonempty_subset
      (S := data.familyHull) hne
      (data.possibleRegion_subset_familyHull i)

theorem quotientMap_images_eq
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i j : ι)
    (hnei : (data.possibleRegion i).Nonempty)
    (hnej : (data.possibleRegion j).Nonempty) :
    data.quotientMap '' data.possibleRegion i =
      data.quotientMap '' data.possibleRegion j := by
  rw [data.quotientMap_image_possibleRegion_eq_collapsed i hnei,
    data.quotientMap_image_possibleRegion_eq_collapsed j hnej]

theorem quotientMap_image_under_map_between_possibleRegions
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i j : ι)
    (f : α -> α)
    (hnei : (data.possibleRegion i).Nonempty)
    (hf :
      ∀ x, x ∈ data.possibleRegion i -> f x ∈ data.possibleRegion j) :
    (fun x => data.quotientMap (f x)) '' data.possibleRegion i =
      data.quotientMap '' data.possibleRegion i := by
  simpa [quotientMap] using
    quotientMap_image_under_map_between_subsets
      (S := data.familyHull)
      (A := data.possibleRegion i)
      (B := data.possibleRegion j)
      (f := f)
      hnei
      (data.possibleRegion_subset_familyHull i)
      (data.possibleRegion_subset_familyHull j)
      hf

theorem quotientMap_two_regions_collapse_iff
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    {A B : Set α}
    (hneA : A.Nonempty)
    (hneB : B.Nonempty) :
    data.quotientMap '' A =
          {IUTStage1UpperSemiSetQuotient.collapsed} ∧
        data.quotientMap '' B =
          {IUTStage1UpperSemiSetQuotient.collapsed} ↔
      A ⊆ data.familyHull ∧ B ⊆ data.familyHull := by
  simpa [quotientMap] using
    IUTStage1UpperSemiSetQuotient.quotientMap_two_images_collapse_iff
      (S := data.familyHull) hneA hneB

theorem quotientMap_possibleRegion_collapse_iff
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i : ι)
    (hne : (data.possibleRegion i).Nonempty) :
    data.quotientMap '' data.possibleRegion i =
        {IUTStage1UpperSemiSetQuotient.collapsed} ↔
      data.possibleRegion i ⊆ data.familyHull := by
  simpa [quotientMap] using
    IUTStage1UpperSemiSetQuotient.quotientMap_image_eq_singleton_collapsed_iff
      (S := data.familyHull) hne

theorem endpoint
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i j : ι)
    (hnei : (data.possibleRegion i).Nonempty)
    (hnej : (data.possibleRegion j).Nonempty) :
    data.possibleRegion i ⊆ data.familyHull ∧
      data.possibleRegion j ⊆ data.familyHull ∧
      data.quotientMap '' data.possibleRegion i =
        data.quotientMap '' data.possibleRegion j :=
  ⟨data.possibleRegion_subset_familyHull i,
    data.possibleRegion_subset_familyHull j,
    data.quotientMap_images_eq i j hnei hnej⟩

end IUTStage1BoundedFamilyHullQuotientSource

/--
Finite log-volume shadow of the Step (xi-d) determinant passage.

The paper passes from localizations of arithmetic vector bundles of rank `> 1` to
a positive tensor power of their determinant, and then applies a suitably
normalized log-volume.  This record keeps only that numerical skeleton.
-/
structure IUTStage1ArithmeticVectorBundleDeterminantLogVolume where
  rank : Nat
  rank_gt_one : 1 < rank
  determinantLogVolume : Real
  positiveTensorPower : Nat
  tensor_power_pos : 0 < positiveTensorPower
  tensorPowerLogVolume : Real
  tensor_power_eq :
    tensorPowerLogVolume =
      (positiveTensorPower : Real) * determinantLogVolume
  normalizedLogVolume : Real
  normalized_eq :
    normalizedLogVolume =
      tensorPowerLogVolume / (positiveTensorPower : Real)

namespace IUTStage1ArithmeticVectorBundleDeterminantLogVolume

theorem positiveTensorPower_ne_zero
    (data : IUTStage1ArithmeticVectorBundleDeterminantLogVolume) :
    (data.positiveTensorPower : Real) ≠ 0 := by
  exact_mod_cast Nat.ne_of_gt data.tensor_power_pos

theorem normalizedLogVolume_eq_determinant
    (data : IUTStage1ArithmeticVectorBundleDeterminantLogVolume) :
    data.normalizedLogVolume = data.determinantLogVolume := by
  rw [data.normalized_eq, data.tensor_power_eq]
  exact mul_div_cancel_left₀ data.determinantLogVolume
    data.positiveTensorPower_ne_zero

theorem rank_pos
    (data : IUTStage1ArithmeticVectorBundleDeterminantLogVolume) :
    0 < data.rank :=
  lt_trans Nat.zero_lt_one data.rank_gt_one

theorem normalizedLogVolume_eq_of_determinantLogVolume_eq
    (source target : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (hdet :
      source.determinantLogVolume = target.determinantLogVolume) :
    source.normalizedLogVolume = target.normalizedLogVolume := by
  rw [source.normalizedLogVolume_eq_determinant,
    target.normalizedLogVolume_eq_determinant, hdet]

theorem determinantNormalization_endpoint
    (data : IUTStage1ArithmeticVectorBundleDeterminantLogVolume) :
    1 < data.rank ∧
      0 < data.positiveTensorPower ∧
      data.tensorPowerLogVolume =
        (data.positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume :=
  ⟨data.rank_gt_one, data.tensor_power_pos, data.tensor_power_eq,
    data.normalizedLogVolume_eq_determinant⟩

end IUTStage1ArithmeticVectorBundleDeterminantLogVolume

/--
Finite log-volume source for one localized arithmetic vector-bundle summand in
Remark 3.9.5(vii), (Ob3-1).

The `structureSheafLogVolume` term records the normalization adjustment from
(Ob3-1-2), while `weight` records the weighted tensor-power contribution from
(Ob3-1-1).  This is still a log-volume skeleton: it does not construct the
underlying arithmetic vector bundle.
-/
structure IUTStage1ArithmeticVectorBundleLocalizationLogVolume where
  rank : Nat
  rank_gt_one : 1 < rank
  bundleLogVolume : Real
  structureSheafLogVolume : Real
  weight : Nat
  weight_pos : 0 < weight

namespace IUTStage1ArithmeticVectorBundleLocalizationLogVolume

def adjustedLogVolume
    (data : IUTStage1ArithmeticVectorBundleLocalizationLogVolume) :
    Real :=
  (data.weight : Real) *
    (data.bundleLogVolume - data.structureSheafLogVolume)

theorem weight_ne_zero
    (data : IUTStage1ArithmeticVectorBundleLocalizationLogVolume) :
    (data.weight : Real) ≠ 0 := by
  exact_mod_cast Nat.ne_of_gt data.weight_pos

theorem rank_pos
    (data : IUTStage1ArithmeticVectorBundleLocalizationLogVolume) :
    0 < data.rank :=
  lt_trans Nat.zero_lt_one data.rank_gt_one

theorem adjustedLogVolume_eq
    (data : IUTStage1ArithmeticVectorBundleLocalizationLogVolume) :
    data.adjustedLogVolume =
      (data.weight : Real) *
        (data.bundleLogVolume - data.structureSheafLogVolume) :=
  rfl

end IUTStage1ArithmeticVectorBundleLocalizationLogVolume

/--
Finite direct-summand source for a localized arithmetic vector bundle.

Remark 3.9.5(vii), (Ob3-1-1), describes determinant factors attached to the
direct summands of the tensor packet of log-shells.  This record keeps that
finite additive skeleton: the bundle log-volume is the sum of direct-summand
log-volumes, while the structure-sheaf adjustment and positive weight are the
same data consumed by the localization interface.
-/
structure IUTStage1ArithmeticVectorBundleLocalizationSource
    (γ : Type u) [Fintype γ] where
  directSummandLogVolume : γ -> Real
  structureSheafLogVolume : Real
  weight : Nat
  weight_pos : 0 < weight
  rank_gt_one : 1 < Fintype.card γ

namespace IUTStage1ArithmeticVectorBundleLocalizationSource

variable {γ : Type u} [Fintype γ]

def rank
    (_data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    Nat :=
  Fintype.card γ

def bundleLogVolume
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    Real :=
  Finset.univ.sum data.directSummandLogVolume

def toLocalizationLogVolume
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    IUTStage1ArithmeticVectorBundleLocalizationLogVolume :=
  { rank := data.rank,
    rank_gt_one := data.rank_gt_one,
    bundleLogVolume := data.bundleLogVolume,
    structureSheafLogVolume := data.structureSheafLogVolume,
    weight := data.weight,
    weight_pos := data.weight_pos }

def adjustedLogVolume
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    Real :=
  data.toLocalizationLogVolume.adjustedLogVolume

theorem bundleLogVolume_eq_sum
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    data.bundleLogVolume =
      Finset.univ.sum data.directSummandLogVolume :=
  rfl

theorem toLocalizationLogVolume_bundleLogVolume_eq
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    data.toLocalizationLogVolume.bundleLogVolume =
      Finset.univ.sum data.directSummandLogVolume :=
  rfl

theorem adjustedLogVolume_eq
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    data.adjustedLogVolume =
      (data.weight : Real) *
        ((Finset.univ.sum data.directSummandLogVolume) -
          data.structureSheafLogVolume) :=
  rfl

theorem endpoint
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    data.rank = Fintype.card γ ∧
      1 < data.rank ∧
      data.bundleLogVolume =
        Finset.univ.sum data.directSummandLogVolume ∧
      data.adjustedLogVolume =
        (data.weight : Real) *
          (data.bundleLogVolume - data.structureSheafLogVolume) :=
  ⟨rfl, data.rank_gt_one, rfl, rfl⟩

end IUTStage1ArithmeticVectorBundleLocalizationSource

/--
Structure-sheaf adjusted localization source.

This refines the Ob3-1-2 normalization step.  The raw localized vector-bundle
log-volume is computed from direct summands; the adjusted value is obtained by
subtracting the structure-sheaf log-volume `O(-)`, and the weighted adjusted
contribution is the value projected to the localization summand interface.
-/
structure IUTStage1StructureSheafAdjustedLocalizationSource
    (γ : Type u) [Fintype γ] where
  directSummandLogVolume : γ -> Real
  structureSheafLogVolume : Real
  adjustedRawLogVolume : Real
  adjusted_raw_eq :
    adjustedRawLogVolume =
      (Finset.univ.sum directSummandLogVolume) -
        structureSheafLogVolume
  weight : Nat
  weight_pos : 0 < weight
  rank_gt_one : 1 < Fintype.card γ

namespace IUTStage1StructureSheafAdjustedLocalizationSource

variable {γ : Type u} [Fintype γ]

def toLocalizationSource
    (data : IUTStage1StructureSheafAdjustedLocalizationSource γ) :
    IUTStage1ArithmeticVectorBundleLocalizationSource γ :=
  { directSummandLogVolume := data.directSummandLogVolume,
    structureSheafLogVolume := data.structureSheafLogVolume,
    weight := data.weight,
    weight_pos := data.weight_pos,
    rank_gt_one := data.rank_gt_one }

def weightedAdjustedLogVolume
    (data : IUTStage1StructureSheafAdjustedLocalizationSource γ) :
    Real :=
  (data.weight : Real) * data.adjustedRawLogVolume

theorem toLocalizationSource_bundleLogVolume_eq
    (data : IUTStage1StructureSheafAdjustedLocalizationSource γ) :
    data.toLocalizationSource.bundleLogVolume =
      Finset.univ.sum data.directSummandLogVolume :=
  rfl

theorem toLocalizationSource_adjustedLogVolume_eq_weightedAdjusted
    (data : IUTStage1StructureSheafAdjustedLocalizationSource γ) :
    data.toLocalizationSource.adjustedLogVolume =
      data.weightedAdjustedLogVolume := by
  simp [weightedAdjustedLogVolume,
    toLocalizationSource,
    IUTStage1ArithmeticVectorBundleLocalizationSource.adjustedLogVolume,
    IUTStage1ArithmeticVectorBundleLocalizationSource.toLocalizationLogVolume,
    IUTStage1ArithmeticVectorBundleLocalizationSource.bundleLogVolume,
    IUTStage1ArithmeticVectorBundleLocalizationLogVolume.adjustedLogVolume,
    data.adjusted_raw_eq]

theorem endpoint
    (data : IUTStage1StructureSheafAdjustedLocalizationSource γ) :
    data.toLocalizationSource.bundleLogVolume =
        Finset.univ.sum data.directSummandLogVolume ∧
      data.adjustedRawLogVolume =
        data.toLocalizationSource.bundleLogVolume -
          data.structureSheafLogVolume ∧
      data.toLocalizationSource.adjustedLogVolume =
        data.weightedAdjustedLogVolume :=
  ⟨data.toLocalizationSource_bundleLogVolume_eq,
    by simpa [toLocalizationSource,
      IUTStage1ArithmeticVectorBundleLocalizationSource.bundleLogVolume]
      using data.adjusted_raw_eq,
    data.toLocalizationSource_adjustedLogVolume_eq_weightedAdjusted⟩

end IUTStage1StructureSheafAdjustedLocalizationSource

/--
Finite determinant source for Remark 3.9.5(vii), (Ob3).

The determinant log-volume is constructed as the finite weighted sum of
structure-sheaf-normalized localization contributions.  The positive tensor
power and normalized log-volume are then derived by definitions before being
projected to the determinant interface.
-/
structure IUTStage1ArithmeticVectorBundleWeightedDeterminantSource
    (β : Type u) [Fintype β] where
  summand : β -> IUTStage1ArithmeticVectorBundleLocalizationLogVolume
  anchor : β
  positiveTensorPower : Nat
  tensor_power_pos : 0 < positiveTensorPower

namespace IUTStage1ArithmeticVectorBundleWeightedDeterminantSource

variable {β : Type u} [Fintype β]

def ofLocalizationSources
    {γ : Type v} [Fintype γ]
    (source : β -> IUTStage1ArithmeticVectorBundleLocalizationSource γ)
    (anchor : β)
    (positiveTensorPower : Nat)
    (tensor_power_pos : 0 < positiveTensorPower) :
    IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β :=
  { summand := fun index =>
      (source index).toLocalizationLogVolume,
    anchor := anchor,
    positiveTensorPower := positiveTensorPower,
    tensor_power_pos := tensor_power_pos }

def ofAdjustedLocalizationSources
    {γ : Type v} [Fintype γ]
    (source : β -> IUTStage1StructureSheafAdjustedLocalizationSource γ)
    (anchor : β)
    (positiveTensorPower : Nat)
    (tensor_power_pos : 0 < positiveTensorPower) :
    IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β :=
  ofLocalizationSources
    (fun index => (source index).toLocalizationSource)
    anchor positiveTensorPower tensor_power_pos

def determinantLogVolume
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    Real :=
  Finset.univ.sum fun index => (data.summand index).adjustedLogVolume

def tensorPowerLogVolume
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    Real :=
  (data.positiveTensorPower : Real) * data.determinantLogVolume

noncomputable def normalizedLogVolume
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    Real :=
  data.tensorPowerLogVolume / (data.positiveTensorPower : Real)

noncomputable def toDeterminantLogVolume
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    IUTStage1ArithmeticVectorBundleDeterminantLogVolume :=
  { rank := (data.summand data.anchor).rank,
    rank_gt_one := (data.summand data.anchor).rank_gt_one,
    determinantLogVolume := data.determinantLogVolume,
    positiveTensorPower := data.positiveTensorPower,
    tensor_power_pos := data.tensor_power_pos,
    tensorPowerLogVolume := data.tensorPowerLogVolume,
    tensor_power_eq := rfl,
    normalizedLogVolume := data.normalizedLogVolume,
    normalized_eq := rfl }

theorem determinantLogVolume_eq_sum
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    data.determinantLogVolume =
      Finset.univ.sum fun index =>
        (data.summand index).adjustedLogVolume :=
  rfl

theorem tensorPowerLogVolume_eq
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    data.tensorPowerLogVolume =
      (data.positiveTensorPower : Real) * data.determinantLogVolume :=
  rfl

theorem normalizedLogVolume_eq_determinantLogVolume
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    data.normalizedLogVolume = data.determinantLogVolume :=
  data.toDeterminantLogVolume.normalizedLogVolume_eq_determinant

theorem toDeterminantLogVolume_determinantLogVolume_eq
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    data.toDeterminantLogVolume.determinantLogVolume =
      data.determinantLogVolume :=
  rfl

theorem toDeterminantLogVolume_normalizedLogVolume_eq
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    data.toDeterminantLogVolume.normalizedLogVolume =
      data.determinantLogVolume :=
  data.toDeterminantLogVolume.normalizedLogVolume_eq_determinant

theorem endpoint
    (data :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    data.determinantLogVolume =
        (Finset.univ.sum fun index =>
          (data.summand index).adjustedLogVolume) ∧
      data.tensorPowerLogVolume =
        (data.positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume ∧
      data.toDeterminantLogVolume.determinantLogVolume =
        data.determinantLogVolume ∧
      data.toDeterminantLogVolume.normalizedLogVolume =
        data.determinantLogVolume :=
  ⟨data.determinantLogVolume_eq_sum,
    data.tensorPowerLogVolume_eq,
    data.normalizedLogVolume_eq_determinantLogVolume,
    data.toDeterminantLogVolume_determinantLogVolume_eq,
    data.toDeterminantLogVolume_normalizedLogVolume_eq⟩

theorem ofLocalizationSources_endpoint
    {γ : Type v} [Fintype γ]
    (source : β -> IUTStage1ArithmeticVectorBundleLocalizationSource γ)
    (anchor : β)
    (positiveTensorPower : Nat)
    (tensor_power_pos : 0 < positiveTensorPower) :
    let data :=
      ofLocalizationSources source anchor positiveTensorPower
        tensor_power_pos;
    data.determinantLogVolume =
        (Finset.univ.sum fun index =>
          (source index).adjustedLogVolume) ∧
      data.tensorPowerLogVolume =
        (positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume :=
  by
    intro data
    exact
      ⟨rfl, rfl, data.normalizedLogVolume_eq_determinantLogVolume⟩

theorem ofAdjustedLocalizationSources_endpoint
    {γ : Type v} [Fintype γ]
    (source : β -> IUTStage1StructureSheafAdjustedLocalizationSource γ)
    (anchor : β)
    (positiveTensorPower : Nat)
    (tensor_power_pos : 0 < positiveTensorPower) :
    let data :=
      ofAdjustedLocalizationSources source anchor positiveTensorPower
        tensor_power_pos;
    data.determinantLogVolume =
        (Finset.univ.sum fun index =>
          (source index).weightedAdjustedLogVolume) ∧
      data.tensorPowerLogVolume =
        (positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume :=
  by
    intro data
    refine ⟨?_, rfl, data.normalizedLogVolume_eq_determinantLogVolume⟩
    dsimp [ofAdjustedLocalizationSources, ofLocalizationSources,
      determinantLogVolume]
    exact Finset.sum_congr rfl (fun index _ =>
      (source index).toLocalizationSource_adjustedLogVolume_eq_weightedAdjusted)

end IUTStage1ArithmeticVectorBundleWeightedDeterminantSource

/--
Log-volume compatibility between a hull approximant and a weighted determinant
source.

Remark 3.9.5(vii), (Ob3-3), permits omitting the intermediate determinant
operation when the argument only computes log-volumes.  This record is the
finite compatibility certificate used by the current Stage 1 route: the
approximant log-volume is identified with the normalized log-volume derived
from the weighted determinant source.
-/
structure IUTStage1HullApproximantWeightedDeterminantCompatibility
    {α : Type u} {β : Type v} [Fintype β]
    {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant : IUTStage1HullLogVolumeApproximant hullData region)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) where
  approximant_eq_weighted_normalized :
    hullData.logVolume approximant.approximant =
      determinantSource.normalizedLogVolume

namespace IUTStage1HullApproximantWeightedDeterminantCompatibility

variable {α : Type u} {β : Type v} [Fintype β]
variable {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
variable {region : Set α}
variable {approximant : IUTStage1HullLogVolumeApproximant hullData region}
variable {determinantSource :
  IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β}

theorem approximant_eq_determinantLogVolume
    (data :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource) :
    hullData.logVolume approximant.approximant =
      determinantSource.determinantLogVolume := by
  rw [data.approximant_eq_weighted_normalized,
    determinantSource.normalizedLogVolume_eq_determinantLogVolume]

theorem approximant_eq_projected_normalized
    (data :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource) :
    hullData.logVolume approximant.approximant =
      determinantSource.toDeterminantLogVolume.normalizedLogVolume :=
  data.approximant_eq_weighted_normalized

theorem endpoint
    (data :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource) :
    hullData.logVolume approximant.approximant =
        determinantSource.normalizedLogVolume ∧
      hullData.logVolume approximant.approximant =
        determinantSource.determinantLogVolume ∧
      hullData.logVolume approximant.approximant =
        determinantSource.toDeterminantLogVolume.normalizedLogVolume :=
  ⟨data.approximant_eq_weighted_normalized,
    data.approximant_eq_determinantLogVolume,
    data.approximant_eq_projected_normalized⟩

theorem region_logVolume_le_determinantLogVolume
    (data :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource) :
    hullData.logVolume region <= determinantSource.determinantLogVolume :=
  approximant.region_logVolume_le.trans
    (le_of_eq data.approximant_eq_determinantLogVolume)

end IUTStage1HullApproximantWeightedDeterminantCompatibility

/--
Finite log-volume skeleton of Remark 3.9.5(vii), (Ob4).

The passage from an object to its `M`-th tensor-power Frobenioid copy is modeled
only at the level relevant for Corollary 3.12 estimates: tensor-powering scales
the log-volume by `M`, and the normalized log-volume recovers the original
base value.
-/
structure IUTStage1NaiveFrobeniusTensorPowerLogVolume where
  baseLogVolume : Real
  tensorDegree : Nat
  tensor_degree_pos : 0 < tensorDegree
  tensorPowerLogVolume : Real
  tensor_power_eq :
    tensorPowerLogVolume = (tensorDegree : Real) * baseLogVolume
  normalizedLogVolume : Real
  normalized_eq :
    normalizedLogVolume = tensorPowerLogVolume / (tensorDegree : Real)

namespace IUTStage1NaiveFrobeniusTensorPowerLogVolume

theorem tensorDegree_ne_zero
    (data : IUTStage1NaiveFrobeniusTensorPowerLogVolume) :
    (data.tensorDegree : Real) ≠ 0 := by
  exact_mod_cast Nat.ne_of_gt data.tensor_degree_pos

theorem normalizedLogVolume_eq_base
    (data : IUTStage1NaiveFrobeniusTensorPowerLogVolume) :
    data.normalizedLogVolume = data.baseLogVolume := by
  rw [data.normalized_eq, data.tensor_power_eq]
  exact mul_div_cancel_left₀ data.baseLogVolume data.tensorDegree_ne_zero

theorem normalizedLogVolume_eq_of_base_eq
    (source target : IUTStage1NaiveFrobeniusTensorPowerLogVolume)
    (hbase : source.baseLogVolume = target.baseLogVolume) :
    source.normalizedLogVolume = target.normalizedLogVolume := by
  rw [source.normalizedLogVolume_eq_base,
    target.normalizedLogVolume_eq_base, hbase]

noncomputable def ofWeightedDeterminant
    {β : Type u} [Fintype β]
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    IUTStage1NaiveFrobeniusTensorPowerLogVolume :=
  { baseLogVolume := determinantSource.determinantLogVolume,
    tensorDegree := determinantSource.positiveTensorPower,
    tensor_degree_pos := determinantSource.tensor_power_pos,
    tensorPowerLogVolume := determinantSource.tensorPowerLogVolume,
    tensor_power_eq := determinantSource.tensorPowerLogVolume_eq,
    normalizedLogVolume := determinantSource.normalizedLogVolume,
    normalized_eq := rfl }

theorem ofWeightedDeterminant_normalizedLogVolume_eq
    {β : Type u} [Fintype β]
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    (ofWeightedDeterminant determinantSource).normalizedLogVolume =
      determinantSource.determinantLogVolume :=
  (ofWeightedDeterminant determinantSource).normalizedLogVolume_eq_base

theorem ofWeightedDeterminant_normalizedLogVolume_le_iff
    {β : Type u} [Fintype β]
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (bound : Real) :
    (ofWeightedDeterminant determinantSource).normalizedLogVolume <= bound ↔
      determinantSource.determinantLogVolume <= bound := by
  rw [ofWeightedDeterminant_normalizedLogVolume_eq determinantSource]

theorem endpoint
    (data : IUTStage1NaiveFrobeniusTensorPowerLogVolume) :
    data.tensorPowerLogVolume =
        (data.tensorDegree : Real) * data.baseLogVolume ∧
      data.normalizedLogVolume = data.baseLogVolume :=
  ⟨data.tensor_power_eq, data.normalizedLogVolume_eq_base⟩

end IUTStage1NaiveFrobeniusTensorPowerLogVolume

/--
Comparison of two positive tensor-power presentations of the same
log-volume-level Frobenioid datum.

This is the finite form of the Ob4 assertion used by the present route: the
choice of a sufficiently divisible tensor degree may change the tensor-power
presentation, but not the normalized log-volume once the base log-volume is the
same.
-/
structure IUTStage1TensorPowerPresentationComparison where
  source : IUTStage1NaiveFrobeniusTensorPowerLogVolume
  target : IUTStage1NaiveFrobeniusTensorPowerLogVolume
  base_eq : source.baseLogVolume = target.baseLogVolume

namespace IUTStage1TensorPowerPresentationComparison

theorem normalizedLogVolume_eq
    (data : IUTStage1TensorPowerPresentationComparison) :
    data.source.normalizedLogVolume = data.target.normalizedLogVolume :=
  IUTStage1NaiveFrobeniusTensorPowerLogVolume.normalizedLogVolume_eq_of_base_eq
    data.source data.target data.base_eq

theorem endpoint
    (data : IUTStage1TensorPowerPresentationComparison) :
    data.source.baseLogVolume = data.target.baseLogVolume ∧
      data.source.normalizedLogVolume =
        data.source.baseLogVolume ∧
      data.target.normalizedLogVolume =
        data.target.baseLogVolume ∧
      data.source.normalizedLogVolume =
        data.target.normalizedLogVolume :=
  ⟨data.base_eq,
    data.source.normalizedLogVolume_eq_base,
    data.target.normalizedLogVolume_eq_base,
    data.normalizedLogVolume_eq⟩

end IUTStage1TensorPowerPresentationComparison

/--
Remark 3.9.5(vii), (Ob5), at the finite log-volume level.

The source text says that the upper-semi quotient attached to the family hull
`φ(P_B)` may also be applied compatibly to `det⊗M(φ(P_B))` and
`μlog(φ(P_B))`.  This record keeps that compatibility in the current Stage 1
skeleton: the family quotient is built from `φ(P_B)`, while the log-volume of
that same canonical hull is identified with the weighted determinant source.
-/
structure IUTStage1BoundedFamilyHullDetLogVolumeSource
    (α : Type u) (ι : Type v) (β : Type w) [Fintype β] where
  hullData : IUTStage1HolomorphicHullLogVolumeShadow α
  possibleRegion : ι -> Set α
  determinantSource :
    IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β
  compatibility :
    IUTStage1HullApproximantWeightedDeterminantCompatibility
      (IUTStage1HullLogVolumeApproximant.canonical
        hullData (⋃ i, possibleRegion i))
      determinantSource

namespace IUTStage1BoundedFamilyHullDetLogVolumeSource

variable {α : Type u} {ι : Type v} {β : Type w} [Fintype β]

def toBoundedFamilyHullQuotientSource
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    IUTStage1BoundedFamilyHullQuotientSource α ι :=
  { hullData := data.hullData,
    possibleRegion := data.possibleRegion }

def familyUnion
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    Set α :=
  data.toBoundedFamilyHullQuotientSource.familyUnion

def familyHull
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    Set α :=
  data.toBoundedFamilyHullQuotientSource.familyHull

def familyHullLogVolume
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    Real :=
  data.hullData.logVolume data.familyHull

def familyUnionLogVolume
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    Real :=
  data.hullData.logVolume data.familyUnion

noncomputable def tensorPower
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    IUTStage1NaiveFrobeniusTensorPowerLogVolume :=
  IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
    data.determinantSource

noncomputable def quotientMap
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    (x : α) :
    IUTStage1UpperSemiSetQuotient α data.familyHull :=
  data.toBoundedFamilyHullQuotientSource.quotientMap x

theorem possibleRegion_subset_familyHull
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    (i : ι) :
    data.possibleRegion i ⊆ data.familyHull :=
  data.toBoundedFamilyHullQuotientSource.possibleRegion_subset_familyHull i

theorem quotientMap_images_eq
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    (i j : ι)
    (hnei : (data.possibleRegion i).Nonempty)
    (hnej : (data.possibleRegion j).Nonempty) :
    data.quotientMap '' data.possibleRegion i =
      data.quotientMap '' data.possibleRegion j :=
  data.toBoundedFamilyHullQuotientSource.quotientMap_images_eq
    i j hnei hnej

theorem quotientMap_two_regions_collapse_iff
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    {A B : Set α}
    (hneA : A.Nonempty)
    (hneB : B.Nonempty) :
    data.quotientMap '' A =
          {IUTStage1UpperSemiSetQuotient.collapsed} ∧
        data.quotientMap '' B =
          {IUTStage1UpperSemiSetQuotient.collapsed} ↔
      A ⊆ data.familyHull ∧ B ⊆ data.familyHull := by
  simpa [quotientMap, familyHull] using
    data.toBoundedFamilyHullQuotientSource
      |>.quotientMap_two_regions_collapse_iff hneA hneB

theorem familyHullLogVolume_eq_normalized
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    data.familyHullLogVolume = data.determinantSource.normalizedLogVolume := by
  simpa [familyHullLogVolume, familyHull,
    toBoundedFamilyHullQuotientSource, IUTStage1BoundedFamilyHullQuotientSource.familyHull,
    IUTStage1BoundedFamilyHullQuotientSource.familyUnion] using
    data.compatibility.approximant_eq_weighted_normalized

theorem familyHullLogVolume_eq_determinant
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    data.familyHullLogVolume =
      data.determinantSource.determinantLogVolume := by
  rw [data.familyHullLogVolume_eq_normalized,
    data.determinantSource.normalizedLogVolume_eq_determinantLogVolume]

theorem familyUnionLogVolume_le_familyHullLogVolume
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    data.familyUnionLogVolume <= data.familyHullLogVolume :=
  data.hullData.logVolume_le_hullLogVolume data.familyUnion

theorem familyUnionLogVolume_le_determinant
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    data.familyUnionLogVolume <=
      data.determinantSource.determinantLogVolume :=
  data.familyUnionLogVolume_le_familyHullLogVolume.trans
    (le_of_eq data.familyHullLogVolume_eq_determinant)

theorem tensorPower_baseLogVolume_eq_familyHullLogVolume
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    data.tensorPower.baseLogVolume = data.familyHullLogVolume := by
  rw [tensorPower,
    IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant]
  exact data.familyHullLogVolume_eq_determinant.symm

theorem tensorPower_normalizedLogVolume_eq_familyHullLogVolume
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    data.tensorPower.normalizedLogVolume = data.familyHullLogVolume := by
  rw [data.tensorPower.normalizedLogVolume_eq_base,
    data.tensorPower_baseLogVolume_eq_familyHullLogVolume]

theorem tensorPowerLogVolume_eq_scaled_familyHullLogVolume
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β) :
    data.tensorPower.tensorPowerLogVolume =
      (data.tensorPower.tensorDegree : Real) * data.familyHullLogVolume := by
  rw [data.tensorPower.tensor_power_eq,
    data.tensorPower_baseLogVolume_eq_familyHullLogVolume]

theorem endpoint
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    (i j : ι)
    (hnei : (data.possibleRegion i).Nonempty)
    (hnej : (data.possibleRegion j).Nonempty) :
    data.possibleRegion i ⊆ data.familyHull ∧
      data.possibleRegion j ⊆ data.familyHull ∧
      data.quotientMap '' data.possibleRegion i =
        data.quotientMap '' data.possibleRegion j ∧
      data.familyHullLogVolume =
        data.determinantSource.determinantLogVolume ∧
      data.familyUnionLogVolume <=
        data.determinantSource.determinantLogVolume ∧
      data.tensorPower.normalizedLogVolume =
        data.familyHullLogVolume ∧
      data.tensorPower.tensorPowerLogVolume =
        (data.tensorPower.tensorDegree : Real) * data.familyHullLogVolume :=
  ⟨data.possibleRegion_subset_familyHull i,
    data.possibleRegion_subset_familyHull j,
    data.quotientMap_images_eq i j hnei hnej,
    data.familyHullLogVolume_eq_determinant,
    data.familyUnionLogVolume_le_determinant,
    data.tensorPower_normalizedLogVolume_eq_familyHullLogVolume,
    data.tensorPowerLogVolume_eq_scaled_familyHullLogVolume⟩

theorem ob5_endpoint
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    {A B : Set α}
    (hneA : A.Nonempty)
    (hneB : B.Nonempty) :
    (data.quotientMap '' A =
          {IUTStage1UpperSemiSetQuotient.collapsed} ∧
        data.quotientMap '' B =
          {IUTStage1UpperSemiSetQuotient.collapsed} ↔
      A ⊆ data.familyHull ∧ B ⊆ data.familyHull) ∧
      data.familyHullLogVolume =
        data.determinantSource.determinantLogVolume ∧
      data.familyUnionLogVolume <=
        data.determinantSource.determinantLogVolume ∧
      data.tensorPower.normalizedLogVolume =
        data.familyHullLogVolume ∧
      data.tensorPower.tensorPowerLogVolume =
        (data.tensorPower.tensorDegree : Real) * data.familyHullLogVolume :=
  ⟨data.quotientMap_two_regions_collapse_iff hneA hneB,
    data.familyHullLogVolume_eq_determinant,
    data.familyUnionLogVolume_le_determinant,
    data.tensorPower_normalizedLogVolume_eq_familyHullLogVolume,
    data.tensorPowerLogVolume_eq_scaled_familyHullLogVolume⟩

end IUTStage1BoundedFamilyHullDetLogVolumeSource

/--
Step (xi-e)/(xi-f) upper-ray comparison after hull, determinant, and normalized
log-volume.

The source text writes the possible output pilot log-volumes as
`R_{≤ -|log(Theta)|}` and then records `-|log(q)|` as an element of this subset.
The current record keeps the comparable real-line skeleton of that step, with
`thetaHullLogVolume` supplied by the determinant-normalized hull value.
-/
structure IUTStage1HullDetPilotUpperRayLogVolume where
  determinant :
    IUTStage1ArithmeticVectorBundleDeterminantLogVolume
  thetaHullLogVolume : Real
  theta_eq_normalized_determinant :
    thetaHullLogVolume = determinant.normalizedLogVolume
  qPilotLogVolume : Real
  q_mem_upperRay : qPilotLogVolume <= thetaHullLogVolume

namespace IUTStage1HullDetPilotUpperRayLogVolume

def ofHolomorphicHull
    {α : Type u}
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (qRegion thetaRegion : Set α)
    (q_subset_hull : qRegion ⊆ hullData.hullRegion thetaRegion)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (theta_eq_normalized_determinant :
      hullData.logVolume (hullData.hullRegion thetaRegion) =
        determinant.normalizedLogVolume) :
    IUTStage1HullDetPilotUpperRayLogVolume :=
  { determinant := determinant,
    thetaHullLogVolume :=
      hullData.logVolume (hullData.hullRegion thetaRegion),
    theta_eq_normalized_determinant := theta_eq_normalized_determinant,
    qPilotLogVolume := hullData.logVolume qRegion,
    q_mem_upperRay := hullData.logVolume_le_of_subset_hull q_subset_hull }

def ofHullApproximant
    {α : Type u}
    {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant : IUTStage1HullLogVolumeApproximant hullData region)
    (qRegion : Set α)
    (q_subset_approximant : qRegion ⊆ approximant.approximant)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (approximant_eq_normalized_determinant :
      hullData.logVolume approximant.approximant =
        determinant.normalizedLogVolume) :
    IUTStage1HullDetPilotUpperRayLogVolume :=
  { determinant := determinant,
    thetaHullLogVolume := hullData.logVolume approximant.approximant,
    theta_eq_normalized_determinant := approximant_eq_normalized_determinant,
    qPilotLogVolume := hullData.logVolume qRegion,
    q_mem_upperRay := hullData.logVolume_mono q_subset_approximant }

def upperRay
    (data : IUTStage1HullDetPilotUpperRayLogVolume) : Set Real :=
  { value | value <= data.thetaHullLogVolume }

theorem mem_upperRay_iff
    (data : IUTStage1HullDetPilotUpperRayLogVolume)
    (value : Real) :
    value ∈ data.upperRay ↔ value <= data.thetaHullLogVolume :=
  Iff.rfl

theorem qPilot_mem_upperRay
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume ∈ data.upperRay :=
  data.q_mem_upperRay

theorem qPilot_mem_upperRay_iff
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume ∈ data.upperRay ↔
      data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.mem_upperRay_iff data.qPilotLogVolume

theorem qPilotLogVolume_le_thetaHullLogVolume
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.q_mem_upperRay

theorem ofHolomorphicHull_qPilotLogVolume_le_thetaHullLogVolume
    {α : Type u}
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (qRegion thetaRegion : Set α)
    (q_subset_hull : qRegion ⊆ hullData.hullRegion thetaRegion)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (theta_eq_normalized_determinant :
      hullData.logVolume (hullData.hullRegion thetaRegion) =
        determinant.normalizedLogVolume) :
    (ofHolomorphicHull hullData qRegion thetaRegion q_subset_hull
      determinant theta_eq_normalized_determinant).qPilotLogVolume <=
      (ofHolomorphicHull hullData qRegion thetaRegion q_subset_hull
        determinant theta_eq_normalized_determinant).thetaHullLogVolume :=
  hullData.logVolume_le_of_subset_hull q_subset_hull

theorem ofHullApproximant_qPilotLogVolume_le_thetaHullLogVolume
    {α : Type u}
    {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant : IUTStage1HullLogVolumeApproximant hullData region)
    (qRegion : Set α)
    (q_subset_approximant : qRegion ⊆ approximant.approximant)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (approximant_eq_normalized_determinant :
      hullData.logVolume approximant.approximant =
        determinant.normalizedLogVolume) :
    (ofHullApproximant approximant qRegion q_subset_approximant
      determinant approximant_eq_normalized_determinant).qPilotLogVolume <=
      (ofHullApproximant approximant qRegion q_subset_approximant
        determinant approximant_eq_normalized_determinant).thetaHullLogVolume :=
  hullData.logVolume_mono q_subset_approximant

theorem ofHullApproximant_thetaHullLogVolume_le_canonicalHull
    {α : Type u}
    {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant : IUTStage1HullLogVolumeApproximant hullData region)
    (qRegion : Set α)
    (q_subset_approximant : qRegion ⊆ approximant.approximant)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (approximant_eq_normalized_determinant :
      hullData.logVolume approximant.approximant =
        determinant.normalizedLogVolume) :
    (ofHullApproximant approximant qRegion q_subset_approximant
      determinant approximant_eq_normalized_determinant).thetaHullLogVolume <=
      hullData.logVolume (hullData.hullRegion region) :=
  approximant.approximant_logVolume_le_hull

theorem ofHullApproximant_qPilotLogVolume_le_canonicalHull
    {α : Type u}
    {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant : IUTStage1HullLogVolumeApproximant hullData region)
    (qRegion : Set α)
    (q_subset_approximant : qRegion ⊆ approximant.approximant)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (approximant_eq_normalized_determinant :
      hullData.logVolume approximant.approximant =
        determinant.normalizedLogVolume) :
    (ofHullApproximant approximant qRegion q_subset_approximant
      determinant approximant_eq_normalized_determinant).qPilotLogVolume <=
      hullData.logVolume (hullData.hullRegion region) :=
  le_trans
    (ofHullApproximant_qPilotLogVolume_le_thetaHullLogVolume
      approximant qRegion q_subset_approximant determinant
      approximant_eq_normalized_determinant)
    (ofHullApproximant_thetaHullLogVolume_le_canonicalHull
      approximant qRegion q_subset_approximant determinant
      approximant_eq_normalized_determinant)

theorem thetaHullLogVolume_eq_determinant
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.thetaHullLogVolume = data.determinant.determinantLogVolume := by
  rw [data.theta_eq_normalized_determinant,
    data.determinant.normalizedLogVolume_eq_determinant]

theorem qPilotLogVolume_le_determinant
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume <= data.determinant.determinantLogVolume := by
  rw [← data.thetaHullLogVolume_eq_determinant]
  exact data.qPilotLogVolume_le_thetaHullLogVolume

theorem qPilotLogVolume_eq_thetaHullLogVolume_iff_reverse_bound
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume = data.thetaHullLogVolume ↔
      data.thetaHullLogVolume <= data.qPilotLogVolume :=
  ⟨fun h => by rw [h],
    fun h => le_antisymm data.qPilotLogVolume_le_thetaHullLogVolume h⟩

theorem qPilotLogVolume_eq_determinant_iff_reverse_bound
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume = data.determinant.determinantLogVolume ↔
      data.determinant.determinantLogVolume <= data.qPilotLogVolume :=
  ⟨fun h => by rw [h],
    fun h => le_antisymm data.qPilotLogVolume_le_determinant h⟩

theorem upperRayEqualityRequiresReverseBounds
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    (data.qPilotLogVolume = data.thetaHullLogVolume ↔
        data.thetaHullLogVolume <= data.qPilotLogVolume) ∧
      (data.qPilotLogVolume = data.determinant.determinantLogVolume ↔
        data.determinant.determinantLogVolume <= data.qPilotLogVolume) :=
  ⟨data.qPilotLogVolume_eq_thetaHullLogVolume_iff_reverse_bound,
    data.qPilotLogVolume_eq_determinant_iff_reverse_bound⟩

end IUTStage1HullDetPilotUpperRayLogVolume

/--
Step (xi) possible-image hull shadow.

Theorem B and the proof of Corollary 3.12 define the theta-pilot log-volume as
the log-volume of the holomorphic hull of the union of possible theta images,
subject to `(Ind1)`, `(Ind2)`, `(Ind3)`.  This record keeps the exact
order/log-volume skeleton needed for the later real inequality.
-/
structure IUTStage1ThetaPossibleImagesHullLogVolumeShadow
    (α : Type u) (ι : Type v) where
  hullData : IUTStage1HolomorphicHullLogVolumeShadow α
  possibleThetaImage : ι -> Set α
  qPilotRegion : Set α
  determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume
  q_subset_theta_hull :
    qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i)
  theta_hull_eq_normalized_determinant :
    hullData.logVolume (hullData.hullRegion (⋃ i, possibleThetaImage i)) =
      determinant.normalizedLogVolume

namespace IUTStage1ThetaPossibleImagesHullLogVolumeShadow

variable {α : Type u} {ι : Type v}

def thetaImageUnion
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    Set α :=
  ⋃ i, data.possibleThetaImage i

def thetaHull
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    Set α :=
  data.hullData.hullRegion data.thetaImageUnion

def thetaHullLogVolume
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    Real :=
  data.hullData.logVolume data.thetaHull

def qPilotLogVolume
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    Real :=
  data.hullData.logVolume data.qPilotRegion

theorem qPilotLogVolume_le_thetaHullLogVolume
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.hullData.logVolume_le_of_subset_hull data.q_subset_theta_hull

theorem thetaImageUnion_subset_thetaHull
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.thetaImageUnion ⊆ data.thetaHull :=
  data.hullData.region_subset_hull data.thetaImageUnion

theorem possibleThetaImage_subset_thetaHull
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (i : ι) :
    data.possibleThetaImage i ⊆ data.thetaHull := by
  intro x hx
  exact data.thetaImageUnion_subset_thetaHull
    (Set.mem_iUnion.mpr ⟨i, hx⟩)

theorem thetaHull_hullRegion_eq_self
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.hullData.hullRegion data.thetaHull = data.thetaHull := by
  simpa [thetaHull] using
    data.hullData.hull_idempotent data.thetaImageUnion

theorem thetaHullContainment_endpoint
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (i : ι) :
    data.thetaImageUnion ⊆ data.thetaHull ∧
      data.possibleThetaImage i ⊆ data.thetaHull ∧
      data.qPilotRegion ⊆ data.thetaHull ∧
      data.hullData.hullRegion data.thetaHull = data.thetaHull :=
  ⟨data.thetaImageUnion_subset_thetaHull,
    data.possibleThetaImage_subset_thetaHull i,
    data.q_subset_theta_hull,
    data.thetaHull_hullRegion_eq_self⟩

theorem thetaHullLogVolume_eq_normalized_determinant
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.thetaHullLogVolume = data.determinant.normalizedLogVolume := by
  simpa [thetaHullLogVolume, thetaHull, thetaImageUnion] using
    data.theta_hull_eq_normalized_determinant

def toHullDetPilotUpperRayLogVolume
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    IUTStage1HullDetPilotUpperRayLogVolume :=
  IUTStage1HullDetPilotUpperRayLogVolume.ofHolomorphicHull
    data.hullData data.qPilotRegion data.thetaImageUnion
    data.q_subset_theta_hull data.determinant
    data.thetaHullLogVolume_eq_normalized_determinant

theorem toUpperRay_qPilotLogVolume_eq
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume =
      data.qPilotLogVolume :=
  rfl

theorem toUpperRay_thetaHullLogVolume_eq
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.toHullDetPilotUpperRayLogVolume.thetaHullLogVolume =
      data.thetaHullLogVolume :=
  rfl

theorem toUpperRay_qPilot_mem_upperRay
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume ∈
      data.toHullDetPilotUpperRayLogVolume.upperRay :=
  data.toHullDetPilotUpperRayLogVolume.qPilot_mem_upperRay

theorem endpoint
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume =
        data.qPilotLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.thetaHullLogVolume =
        data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay :=
  ⟨rfl, rfl, data.qPilotLogVolume_le_thetaHullLogVolume,
    data.toUpperRay_qPilot_mem_upperRay⟩

theorem thetaHull_subset_closed_of_possibleImages_subset
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    {closedRegion : Set α}
    (himages :
      ∀ i, data.possibleThetaImage i ⊆ closedRegion)
    (hclosed : data.hullData.hull.IsClosed closedRegion) :
    data.thetaHull ⊆ closedRegion := by
  exact
    data.hullData.hull_subset_closed_of_subset
      (by
        intro x hx
        rcases Set.mem_iUnion.mp hx with ⟨i, hi⟩
        exact himages i hi)
      hclosed

theorem thetaHullLogVolume_le_closed_of_possibleImages_subset
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    {closedRegion : Set α}
    (himages :
      ∀ i, data.possibleThetaImage i ⊆ closedRegion)
    (hclosed : data.hullData.hull.IsClosed closedRegion) :
    data.thetaHullLogVolume <= data.hullData.logVolume closedRegion :=
  data.hullData.logVolume_mono
    (data.thetaHull_subset_closed_of_possibleImages_subset himages hclosed)

end IUTStage1ThetaPossibleImagesHullLogVolumeShadow

/--
Step (xi) possible-image hull source with a chosen hull approximant.

This is the same possible-image union as in
`IUTStage1ThetaPossibleImagesHullLogVolumeShadow`, but the upper-ray bound is
produced through a certified approximant \(H\in\Phi(P)\) for
`P = ⋃ i, possibleThetaImage i`.  Thus the data records the source-paper order
`P ≤ H ≤ φ(P)` and asks separately for q-pilot containment in `H`.
-/
structure IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow
    (α : Type u) (ι : Type v) where
  hullData : IUTStage1HolomorphicHullLogVolumeShadow α
  possibleThetaImage : ι -> Set α
  qPilotRegion : Set α
  approximant :
    IUTStage1HullLogVolumeApproximant
      hullData (⋃ i, possibleThetaImage i)
  determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume
  q_subset_approximant : qPilotRegion ⊆ approximant.approximant
  approximant_eq_normalized_determinant :
    hullData.logVolume approximant.approximant =
      determinant.normalizedLogVolume

namespace IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow

variable {α : Type u} {ι : Type v}

open IUTStage1UpperSemiSetQuotient

noncomputable def ofWeightedDeterminant
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (approximant :
      IUTStage1HullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_approximant : qPilotRegion ⊆ approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource) :
    IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι :=
  { hullData := hullData,
    possibleThetaImage := possibleThetaImage,
    qPilotRegion := qPilotRegion,
    approximant := approximant,
    determinant := determinantSource.toDeterminantLogVolume,
    q_subset_approximant := q_subset_approximant,
    approximant_eq_normalized_determinant :=
      compatibility.approximant_eq_projected_normalized }

noncomputable def ofExactWeightedDeterminant
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (exact :
      IUTStage1ExactHullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_exact :
      qPilotRegion ⊆ exact.approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        exact.approximant determinantSource) :
    IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι :=
  ofWeightedDeterminant
    hullData possibleThetaImage qPilotRegion exact.approximant
    q_subset_exact determinantSource compatibility

noncomputable def ofCanonicalHullWeightedDeterminant
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource) :
    IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι :=
  ofWeightedDeterminant
    hullData possibleThetaImage qPilotRegion
    (IUTStage1HullLogVolumeApproximant.canonical
      hullData (⋃ i, possibleThetaImage i))
    q_subset_hull determinantSource compatibility

noncomputable def canonicalHullWeightedDeterminantFamilyHullDetLogVolumeSource
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource) :
    IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β :=
  { hullData := hullData,
    possibleRegion := possibleThetaImage,
    determinantSource := determinantSource,
    compatibility := compatibility }

def thetaImageUnion
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    Set α :=
  ⋃ i, data.possibleThetaImage i

def toBoundedFamilyHullQuotientSource
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    IUTStage1BoundedFamilyHullQuotientSource α ι :=
  { hullData := data.hullData,
    possibleRegion := data.possibleThetaImage }

def thetaHull
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    Set α :=
  data.hullData.hullRegion data.thetaImageUnion

def approximantRegion
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    Set α :=
  data.approximant.approximant

def thetaImageUnionLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    Real :=
  data.hullData.logVolume data.thetaImageUnion

def approximantLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    Real :=
  data.hullData.logVolume data.approximantRegion

def thetaHullLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    Real :=
  data.hullData.logVolume data.thetaHull

def qPilotLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    Real :=
  data.hullData.logVolume data.qPilotRegion

theorem thetaImageUnionLogVolume_le_approximantLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.thetaImageUnionLogVolume <= data.approximantLogVolume :=
  data.approximant.region_logVolume_le

theorem approximantLogVolume_le_thetaHullLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.approximantLogVolume <= data.thetaHullLogVolume :=
  data.approximant.approximant_logVolume_le_hull

theorem qPilotLogVolume_le_approximantLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.qPilotLogVolume <= data.approximantLogVolume :=
  data.hullData.logVolume_mono data.q_subset_approximant

theorem thetaImageUnion_subset_thetaHull
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.thetaImageUnion ⊆ data.thetaHull :=
  data.hullData.region_subset_hull data.thetaImageUnion

theorem possibleThetaImage_subset_thetaHull
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (i : ι) :
    data.possibleThetaImage i ⊆ data.thetaHull := by
  intro x hx
  exact data.thetaImageUnion_subset_thetaHull
    (Set.mem_iUnion.mpr ⟨i, hx⟩)

theorem approximantRegion_subset_thetaHull
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.approximantRegion ⊆ data.thetaHull :=
  data.approximant.approximant_subset_hull

theorem qPilotRegion_subset_thetaHull
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.qPilotRegion ⊆ data.thetaHull :=
  fun _ hx =>
    data.approximantRegion_subset_thetaHull
      (data.q_subset_approximant hx)

theorem thetaHull_hullRegion_eq_self
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.hullData.hullRegion data.thetaHull = data.thetaHull := by
  simpa [thetaHull] using
    data.hullData.hull_idempotent data.thetaImageUnion

theorem thetaHullContainment_endpoint
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (i : ι) :
    data.thetaImageUnion ⊆ data.thetaHull ∧
      data.possibleThetaImage i ⊆ data.thetaHull ∧
      data.approximantRegion ⊆ data.thetaHull ∧
      data.qPilotRegion ⊆ data.thetaHull ∧
      data.hullData.hullRegion data.thetaHull = data.thetaHull :=
  ⟨data.thetaImageUnion_subset_thetaHull,
    data.possibleThetaImage_subset_thetaHull i,
    data.approximantRegion_subset_thetaHull,
    data.qPilotRegion_subset_thetaHull,
    data.thetaHull_hullRegion_eq_self⟩

theorem qPilotLogVolume_le_thetaHullLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.qPilotLogVolume <= data.thetaHullLogVolume :=
  le_trans data.qPilotLogVolume_le_approximantLogVolume
    data.approximantLogVolume_le_thetaHullLogVolume

theorem approximantLogVolume_eq_normalized_determinant
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.approximantLogVolume = data.determinant.normalizedLogVolume := by
  simpa [approximantLogVolume, approximantRegion] using
    data.approximant_eq_normalized_determinant

theorem thetaImageUnionLogVolume_le_determinant
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.thetaImageUnionLogVolume <= data.determinant.determinantLogVolume :=
  data.thetaImageUnionLogVolume_le_approximantLogVolume.trans
    (le_of_eq
      (data.approximantLogVolume_eq_normalized_determinant.trans
        data.determinant.normalizedLogVolume_eq_determinant))

def toHullDetPilotUpperRayLogVolume
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    IUTStage1HullDetPilotUpperRayLogVolume :=
  IUTStage1HullDetPilotUpperRayLogVolume.ofHullApproximant
    data.approximant data.qPilotRegion data.q_subset_approximant
    data.determinant data.approximantLogVolume_eq_normalized_determinant

theorem toUpperRay_qPilotLogVolume_eq
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume =
      data.qPilotLogVolume :=
  rfl

theorem toUpperRay_thetaHullLogVolume_eq_approximant
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.toHullDetPilotUpperRayLogVolume.thetaHullLogVolume =
      data.approximantLogVolume :=
  rfl

theorem toUpperRay_qPilot_mem_upperRay
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume ∈
      data.toHullDetPilotUpperRayLogVolume.upperRay :=
  data.toHullDetPilotUpperRayLogVolume.qPilot_mem_upperRay

theorem endpoint
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.thetaImageUnionLogVolume <= data.approximantLogVolume ∧
      data.approximantLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.approximantLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaImageUnionLogVolume <=
        data.determinant.determinantLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume <=
        data.determinant.determinantLogVolume :=
  ⟨data.thetaImageUnionLogVolume_le_approximantLogVolume,
    data.approximantLogVolume_le_thetaHullLogVolume,
    data.qPilotLogVolume_le_approximantLogVolume,
    data.qPilotLogVolume_le_thetaHullLogVolume,
    data.thetaImageUnionLogVolume_le_determinant,
    data.toUpperRay_qPilot_mem_upperRay,
    data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume_le_determinant⟩

theorem boundedFamilyQuotient_endpoint
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (i j : ι)
    (hnei : (data.possibleThetaImage i).Nonempty)
    (hnej : (data.possibleThetaImage j).Nonempty) :
    data.toBoundedFamilyHullQuotientSource.possibleRegion i ⊆
        data.toBoundedFamilyHullQuotientSource.familyHull ∧
      data.toBoundedFamilyHullQuotientSource.possibleRegion j ⊆
        data.toBoundedFamilyHullQuotientSource.familyHull ∧
      data.toBoundedFamilyHullQuotientSource.quotientMap ''
          data.toBoundedFamilyHullQuotientSource.possibleRegion i =
        data.toBoundedFamilyHullQuotientSource.quotientMap ''
          data.toBoundedFamilyHullQuotientSource.possibleRegion j :=
  data.toBoundedFamilyHullQuotientSource.endpoint i j hnei hnej

theorem qPilotRegion_subset_familyHull
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.qPilotRegion ⊆
      data.toBoundedFamilyHullQuotientSource.familyHull :=
  fun _ hx =>
    data.approximant.approximant_subset_hull
      (data.q_subset_approximant hx)

theorem qPilot_quotientMap_image_eq_collapsed
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (hne : data.qPilotRegion.Nonempty) :
    data.toBoundedFamilyHullQuotientSource.quotientMap ''
        data.qPilotRegion =
      {IUTStage1UpperSemiSetQuotient.collapsed} := by
  simpa [IUTStage1BoundedFamilyHullQuotientSource.quotientMap] using
    quotientMap_image_eq_singleton_collapsed_of_nonempty_subset
      (S := data.toBoundedFamilyHullQuotientSource.familyHull)
      hne data.qPilotRegion_subset_familyHull

theorem qPilot_quotientMap_image_eq_possibleThetaImage
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (i : ι)
    (hq : data.qPilotRegion.Nonempty)
    (htheta : (data.possibleThetaImage i).Nonempty) :
    data.toBoundedFamilyHullQuotientSource.quotientMap ''
        data.qPilotRegion =
      data.toBoundedFamilyHullQuotientSource.quotientMap ''
        data.possibleThetaImage i := by
  have hqcollapsed :=
    data.qPilot_quotientMap_image_eq_collapsed hq
  have hthetacollapsed :
      data.toBoundedFamilyHullQuotientSource.quotientMap ''
          data.possibleThetaImage i =
        {IUTStage1UpperSemiSetQuotient.collapsed} := by
    simpa [toBoundedFamilyHullQuotientSource] using
      data.toBoundedFamilyHullQuotientSource
        |>.quotientMap_image_possibleRegion_eq_collapsed i htheta
  rw [hqcollapsed, hthetacollapsed]

theorem ofWeightedDeterminant_endpoint
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (approximant :
      IUTStage1HullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_approximant : qPilotRegion ⊆ approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource) :
    let data :=
      ofWeightedDeterminant hullData possibleThetaImage qPilotRegion
        approximant q_subset_approximant determinantSource
        compatibility;
    data.thetaImageUnionLogVolume <= data.approximantLogVolume ∧
      data.approximantLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.approximantLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaImageUnionLogVolume <=
        determinantSource.determinantLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume <=
        determinantSource.determinantLogVolume :=
  by
    intro data
    exact
      ⟨data.thetaImageUnionLogVolume_le_approximantLogVolume,
        data.approximantLogVolume_le_thetaHullLogVolume,
        data.qPilotLogVolume_le_approximantLogVolume,
        data.qPilotLogVolume_le_thetaHullLogVolume,
        by
          simpa [ofWeightedDeterminant]
            using data.thetaImageUnionLogVolume_le_determinant,
        by
          simpa [ofWeightedDeterminant]
            using
              data.toHullDetPilotUpperRayLogVolume
                |>.qPilotLogVolume_le_determinant⟩

theorem ofExactWeightedDeterminant_thetaImageUnionLogVolume_eq
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (exact :
      IUTStage1ExactHullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_exact :
      qPilotRegion ⊆ exact.approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        exact.approximant determinantSource) :
    let data :=
      ofExactWeightedDeterminant hullData possibleThetaImage qPilotRegion
        exact q_subset_exact determinantSource compatibility;
    data.thetaImageUnionLogVolume = data.approximantLogVolume :=
  by
    intro data
    simpa [data, ofExactWeightedDeterminant, ofWeightedDeterminant,
      thetaImageUnionLogVolume, approximantLogVolume, approximantRegion]
      using exact.regionLogVolume_eq_approximantLogVolume

theorem ofExactWeightedDeterminant_endpoint
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (exact :
      IUTStage1ExactHullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_exact :
      qPilotRegion ⊆ exact.approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        exact.approximant determinantSource) :
    let data :=
      ofExactWeightedDeterminant hullData possibleThetaImage qPilotRegion
        exact q_subset_exact determinantSource compatibility;
    data.thetaImageUnionLogVolume = data.approximantLogVolume ∧
      data.approximantLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.approximantLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaImageUnionLogVolume =
        determinantSource.determinantLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume <=
        determinantSource.determinantLogVolume :=
  by
    intro data
    have htheta :
        data.thetaImageUnionLogVolume = data.approximantLogVolume :=
      ofExactWeightedDeterminant_thetaImageUnionLogVolume_eq
        hullData possibleThetaImage qPilotRegion exact q_subset_exact
        determinantSource compatibility
    exact
      ⟨htheta,
        data.approximantLogVolume_le_thetaHullLogVolume,
        data.qPilotLogVolume_le_approximantLogVolume,
        data.qPilotLogVolume_le_thetaHullLogVolume,
        by
          rw [htheta]
          simpa [data, ofExactWeightedDeterminant, ofWeightedDeterminant,
            approximantLogVolume, approximantRegion]
            using compatibility.approximant_eq_determinantLogVolume,
        by
          simpa [data, ofExactWeightedDeterminant, ofWeightedDeterminant]
            using
              data.toHullDetPilotUpperRayLogVolume
                |>.qPilotLogVolume_le_determinant⟩

theorem ofCanonicalHullWeightedDeterminant_approximantRegion_eq_thetaHull
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource) :
    let data :=
      ofCanonicalHullWeightedDeterminant hullData possibleThetaImage
        qPilotRegion q_subset_hull determinantSource compatibility;
    data.approximantRegion = data.thetaHull :=
  by
    intro data
    rfl

theorem ofCanonicalHullWeightedDeterminant_endpoint
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource) :
    let data :=
      ofCanonicalHullWeightedDeterminant hullData possibleThetaImage
        qPilotRegion q_subset_hull determinantSource compatibility;
    data.approximantRegion = data.thetaHull ∧
      data.thetaImageUnionLogVolume <= data.approximantLogVolume ∧
      data.approximantLogVolume = data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      data.thetaImageUnionLogVolume <=
        determinantSource.determinantLogVolume :=
  by
    intro data
    exact
      ⟨rfl,
        data.thetaImageUnionLogVolume_le_approximantLogVolume,
        le_antisymm data.approximantLogVolume_le_thetaHullLogVolume
          (by
            change
              hullData.logVolume (hullData.hullRegion (⋃ i, possibleThetaImage i)) <=
                hullData.logVolume
                  (hullData.hullRegion (⋃ i, possibleThetaImage i))
            exact le_rfl),
        data.qPilotLogVolume_le_thetaHullLogVolume,
        by
          simpa [data, ofCanonicalHullWeightedDeterminant, ofWeightedDeterminant,
            approximantLogVolume, approximantRegion]
            using compatibility.approximant_eq_determinantLogVolume,
        by
          simpa [data, ofCanonicalHullWeightedDeterminant, ofWeightedDeterminant]
            using data.thetaImageUnionLogVolume_le_determinant⟩

theorem canonicalHullWeightedDeterminantFamilyHullDetLogVolume_endpoint
    {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource)
    (i j : ι)
    (hnei : (possibleThetaImage i).Nonempty)
    (hnej : (possibleThetaImage j).Nonempty) :
    let data :=
      ofCanonicalHullWeightedDeterminant hullData possibleThetaImage
        qPilotRegion q_subset_hull determinantSource compatibility;
    let familySource :=
      canonicalHullWeightedDeterminantFamilyHullDetLogVolumeSource
        hullData possibleThetaImage determinantSource compatibility;
    data.thetaHull = familySource.familyHull ∧
      data.approximantLogVolume = familySource.familyHullLogVolume ∧
      familySource.possibleRegion i ⊆ familySource.familyHull ∧
      familySource.possibleRegion j ⊆ familySource.familyHull ∧
      familySource.quotientMap '' familySource.possibleRegion i =
        familySource.quotientMap '' familySource.possibleRegion j ∧
      familySource.familyHullLogVolume =
        determinantSource.determinantLogVolume ∧
      familySource.familyUnionLogVolume <=
        determinantSource.determinantLogVolume ∧
      familySource.tensorPower.normalizedLogVolume =
        familySource.familyHullLogVolume :=
  by
    intro data familySource
    have hendpoint := familySource.endpoint i j hnei hnej
    exact
      ⟨rfl,
        rfl,
        hendpoint.1,
        hendpoint.2.1,
        hendpoint.2.2.1,
        hendpoint.2.2.2.1,
        hendpoint.2.2.2.2.1,
        hendpoint.2.2.2.2.2.1⟩

end IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow

/--
Step (xi-g) tautological two-computation view of the q-pilot log-volume.

After Step (xi-f), the same q-pilot log-volume is read from the input
prime-strip side and from the hull/log-volume output side.  The equality is
recorded explicitly so that this passage is not represented as an untracked
identification of histories or real-line copies.
-/
structure IUTStage1QPilotTwoComputationLogVolume where
  upperRayData : IUTStage1HullDetPilotUpperRayLogVolume
  inputPrimeStripLogVolume : Real
  outputHullLogVolume : Real
  input_eq_q :
    inputPrimeStripLogVolume = upperRayData.qPilotLogVolume
  output_eq_q :
    outputHullLogVolume = upperRayData.qPilotLogVolume

namespace IUTStage1QPilotTwoComputationLogVolume

theorem input_eq_output
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume = data.outputHullLogVolume :=
  data.input_eq_q.trans data.output_eq_q.symm

theorem input_le_thetaHullLogVolume
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume <= data.upperRayData.thetaHullLogVolume := by
  rw [data.input_eq_q]
  exact data.upperRayData.qPilotLogVolume_le_thetaHullLogVolume

theorem output_le_thetaHullLogVolume
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.outputHullLogVolume <= data.upperRayData.thetaHullLogVolume := by
  rw [data.output_eq_q]
  exact data.upperRayData.qPilotLogVolume_le_thetaHullLogVolume

theorem input_eq_thetaHullLogVolume_iff_reverse_bound
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume =
        data.upperRayData.thetaHullLogVolume ↔
      data.upperRayData.thetaHullLogVolume <=
        data.inputPrimeStripLogVolume :=
  ⟨fun h => by rw [h],
    fun h => le_antisymm data.input_le_thetaHullLogVolume h⟩

theorem output_eq_thetaHullLogVolume_iff_reverse_bound
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.outputHullLogVolume =
        data.upperRayData.thetaHullLogVolume ↔
      data.upperRayData.thetaHullLogVolume <=
        data.outputHullLogVolume :=
  ⟨fun h => by rw [h],
    fun h => le_antisymm data.output_le_thetaHullLogVolume h⟩

theorem input_le_determinant
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume <=
      data.upperRayData.determinant.determinantLogVolume := by
  rw [data.input_eq_q]
  exact data.upperRayData.qPilotLogVolume_le_determinant

theorem output_le_determinant
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.outputHullLogVolume <=
      data.upperRayData.determinant.determinantLogVolume := by
  rw [data.output_eq_q]
  exact data.upperRayData.qPilotLogVolume_le_determinant

theorem input_eq_determinant_iff_reverse_bound
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume =
        data.upperRayData.determinant.determinantLogVolume ↔
      data.upperRayData.determinant.determinantLogVolume <=
        data.inputPrimeStripLogVolume :=
  ⟨fun h => by rw [h],
    fun h => le_antisymm data.input_le_determinant h⟩

theorem output_eq_determinant_iff_reverse_bound
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.outputHullLogVolume =
        data.upperRayData.determinant.determinantLogVolume ↔
      data.upperRayData.determinant.determinantLogVolume <=
        data.outputHullLogVolume :=
  ⟨fun h => by rw [h],
    fun h => le_antisymm data.output_le_determinant h⟩

end IUTStage1QPilotTwoComputationLogVolume

/--
Signed Corollary 3.12 endpoint extracted from the Step (xi-g) q-pilot
two-computation record.

The input prime-strip log-volume is used as the signed q-pilot value, while the
upper-ray boundary supplied by the hull/determinant construction is used as the
signed Theta-pilot value.
-/
structure IUTStage1QPilotTwoComputationSignedEndpoint where
  twoComputation : IUTStage1QPilotTwoComputationLogVolume
  q_pilot_positive : 0 < -twoComputation.inputPrimeStripLogVolume

namespace IUTStage1QPilotTwoComputationSignedEndpoint

def comparisonData
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    Corollary312ComparisonData :=
  { thetaSigned := data.twoComputation.upperRayData.thetaHullLogVolume,
    qSigned := data.twoComputation.inputPrimeStripLogVolume,
    q_positive := data.q_pilot_positive,
    qSigned_le_thetaSigned :=
      data.twoComputation.input_le_thetaHullLogVolume }

theorem comparisonData_qSigned
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    data.comparisonData.qSigned =
      data.twoComputation.inputPrimeStripLogVolume :=
  rfl

theorem comparisonData_thetaSigned
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    data.comparisonData.thetaSigned =
      data.twoComputation.upperRayData.thetaHullLogVolume :=
  rfl

theorem qSigned_le_thetaSigned
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    data.comparisonData.qSigned <= data.comparisonData.thetaSigned :=
  data.comparisonData.qSigned_le_thetaSigned

theorem corollary312
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    Corollary312Inequality
      data.comparisonData.thetaPilot data.comparisonData.qPilot :=
  data.comparisonData.corollary312

def absLogQ
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) : Real :=
  -data.twoComputation.inputPrimeStripLogVolume

theorem absLogQ_pos
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    0 < data.absLogQ :=
  data.q_pilot_positive

theorem inputPrimeStripLogVolume_eq_neg_absLogQ
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    data.twoComputation.inputPrimeStripLogVolume = -data.absLogQ := by
  unfold absLogQ
  ring

theorem outputHullLogVolume_eq_neg_absLogQ
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    data.twoComputation.outputHullLogVolume = -data.absLogQ := by
  calc
    data.twoComputation.outputHullLogVolume =
        data.twoComputation.upperRayData.qPilotLogVolume :=
      data.twoComputation.output_eq_q
    _ = data.twoComputation.inputPrimeStripLogVolume :=
      data.twoComputation.input_eq_q.symm
    _ = -data.absLogQ :=
      data.inputPrimeStripLogVolume_eq_neg_absLogQ

theorem fixed_qPilot_mem_upperRay
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    -data.absLogQ ∈ data.twoComputation.upperRayData.upperRay := by
  rw [← data.inputPrimeStripLogVolume_eq_neg_absLogQ]
  exact data.twoComputation.input_le_thetaHullLogVolume

theorem fixed_qPilot_le_thetaHullLogVolume
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    -data.absLogQ <=
      data.twoComputation.upperRayData.thetaHullLogVolume :=
  data.fixed_qPilot_mem_upperRay

end IUTStage1QPilotTwoComputationSignedEndpoint

/--
Extended signed log-volume used in the statement of IUT III, Corollary 3.12.

The source first writes the Theta-pilot signed log-volume as an element of
`R ∪ {+∞}` and then proves that the value is real.  This finite/infinite split is
kept separate from the real-valued comparison records.
-/
inductive IUTStage1ExtendedSignedLogVolume where
  | finite : Real -> IUTStage1ExtendedSignedLogVolume
  | plusInfinity : IUTStage1ExtendedSignedLogVolume

namespace IUTStage1ExtendedSignedLogVolume

def IsFinite : IUTStage1ExtendedSignedLogVolume -> Prop
  | finite _ => True
  | plusInfinity => False

def finiteValue : (value : IUTStage1ExtendedSignedLogVolume) ->
    value.IsFinite -> Real
  | finite realValue, _ => realValue
  | plusInfinity, h => False.elim h

def finiteValueOrZero : IUTStage1ExtendedSignedLogVolume -> Real
  | finite realValue => realValue
  | plusInfinity => 0

theorem finite_isFinite (value : Real) :
    (finite value).IsFinite :=
  trivial

theorem not_plusInfinity_isFinite :
    ¬ plusInfinity.IsFinite := by
  intro h
  exact h

theorem finiteValue_finite (value : Real) :
    finiteValue (finite value) (finite_isFinite value) = value :=
  rfl

theorem finiteValueOrZero_finite (value : Real) :
    finiteValueOrZero (finite value) = value :=
  rfl

theorem finiteValue_eq_finiteValueOrZero
    (value : IUTStage1ExtendedSignedLogVolume) (h : value.IsFinite) :
    finiteValue value h = finiteValueOrZero value := by
  cases value with
  | finite realValue =>
      rfl
  | plusInfinity =>
      exact False.elim h

theorem finite_ne_plusInfinity (value : Real) :
    finite value ≠ plusInfinity := by
  intro h
  cases h

theorem plusInfinity_ne_finite (value : Real) :
    plusInfinity ≠ finite value := by
  intro h
  cases h

end IUTStage1ExtendedSignedLogVolume

/--
Finiteness endpoint for the Theta-pilot signed log-volume in Corollary 3.12.

The hull/determinant upper-ray datum provides a real value for the
Theta-pilot boundary.  Thus the extended statement-level value is the finite
branch, and the same datum still supplies the q-pilot upper-ray comparison.
-/
structure IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint where
  upperRayData : IUTStage1HullDetPilotUpperRayLogVolume
  thetaExtended : IUTStage1ExtendedSignedLogVolume
  thetaExtended_eq_finiteHull :
    thetaExtended =
      IUTStage1ExtendedSignedLogVolume.finite
        upperRayData.thetaHullLogVolume

namespace IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint

def ofUpperRayData
    (upperRayData : IUTStage1HullDetPilotUpperRayLogVolume) :
    IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint :=
  { upperRayData := upperRayData,
    thetaExtended :=
      IUTStage1ExtendedSignedLogVolume.finite
        upperRayData.thetaHullLogVolume,
    thetaExtended_eq_finiteHull := rfl }

theorem thetaExtendedFinite
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.thetaExtended.IsFinite := by
  rw [data.thetaExtended_eq_finiteHull]
  exact IUTStage1ExtendedSignedLogVolume.finite_isFinite
    data.upperRayData.thetaHullLogVolume

theorem thetaExtended_ne_plusInfinity
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.thetaExtended ≠
      IUTStage1ExtendedSignedLogVolume.plusInfinity := by
  rw [data.thetaExtended_eq_finiteHull]
  exact IUTStage1ExtendedSignedLogVolume.finite_ne_plusInfinity
    data.upperRayData.thetaHullLogVolume

theorem thetaFiniteValue_eq_hull
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
        data.thetaExtended =
      data.upperRayData.thetaHullLogVolume := by
  rw [data.thetaExtended_eq_finiteHull]
  rfl

def thetaRealLogVolume
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) : Real :=
  IUTStage1ExtendedSignedLogVolume.finiteValue
    data.thetaExtended data.thetaExtendedFinite

theorem thetaRealLogVolume_eq_hull
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.thetaRealLogVolume =
      data.upperRayData.thetaHullLogVolume := by
  unfold thetaRealLogVolume
  rw [IUTStage1ExtendedSignedLogVolume.finiteValue_eq_finiteValueOrZero,
    data.thetaFiniteValue_eq_hull]

theorem qPilotLogVolume_le_thetaFiniteValue
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.upperRayData.qPilotLogVolume <=
      IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
        data.thetaExtended := by
  rw [data.thetaFiniteValue_eq_hull]
  exact data.upperRayData.qPilotLogVolume_le_thetaHullLogVolume

theorem qPilotLogVolume_le_thetaRealLogVolume
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.upperRayData.qPilotLogVolume <= data.thetaRealLogVolume := by
  rw [data.thetaRealLogVolume_eq_hull]
  exact data.upperRayData.qPilotLogVolume_le_thetaHullLogVolume

theorem qPilotLogVolume_mem_upperRay
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.upperRayData.qPilotLogVolume ∈ data.upperRayData.upperRay :=
  data.upperRayData.qPilot_mem_upperRay

end IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint

/--
IUT III, Corollary 3.12 Step (xi-f) final `C_Theta` algebra.

The source text obtains `-|log(q)| <= -|log(Theta)|` from membership of the
q-pilot log-volume in the upper ray of possible output pilot log-volumes.  It
then says that `C_Theta >= -1` follows formally for any `C_Theta` satisfying
`-|log(Theta)| <= C_Theta * |log(q)|`.  This record isolates only that final
ordered-real calculation.
-/
structure IUTStage1Corollary312CThetaLowerBoundShadow where
  absLogQ : Real
  absLogQ_pos : 0 < absLogQ
  qPilotLogVolume : Real
  thetaPilotLogVolume : Real
  cTheta : Real
  qPilotLogVolume_eq_neg_absLogQ :
    qPilotLogVolume = -absLogQ
  qPilotLogVolume_le_thetaPilotLogVolume :
    qPilotLogVolume <= thetaPilotLogVolume
  thetaPilotLogVolume_le_cTheta_absLogQ :
    thetaPilotLogVolume <= cTheta * absLogQ

namespace IUTStage1Corollary312CThetaLowerBoundShadow

theorem qPilotLogVolume_le_cTheta_absLogQ
    (data : IUTStage1Corollary312CThetaLowerBoundShadow) :
    data.qPilotLogVolume <= data.cTheta * data.absLogQ :=
  le_trans data.qPilotLogVolume_le_thetaPilotLogVolume
    data.thetaPilotLogVolume_le_cTheta_absLogQ

theorem neg_absLogQ_le_cTheta_absLogQ
    (data : IUTStage1Corollary312CThetaLowerBoundShadow) :
    -data.absLogQ <= data.cTheta * data.absLogQ := by
  rw [← data.qPilotLogVolume_eq_neg_absLogQ]
  exact data.qPilotLogVolume_le_cTheta_absLogQ

theorem cTheta_ge_neg_one
    (data : IUTStage1Corollary312CThetaLowerBoundShadow) :
    (-1 : Real) <= data.cTheta := by
  have hmul :
      (-1 : Real) * data.absLogQ <= data.cTheta * data.absLogQ := by
    simpa using data.neg_absLogQ_le_cTheta_absLogQ
  exact le_of_mul_le_mul_right hmul data.absLogQ_pos

theorem thetaPilotLogVolume_eq_neg_absLogQ_of_cTheta_eq_neg_one
    (data : IUTStage1Corollary312CThetaLowerBoundShadow)
    (hC : data.cTheta = (-1 : Real)) :
    data.thetaPilotLogVolume = -data.absLogQ := by
  have hupper :
      data.thetaPilotLogVolume <= -data.absLogQ := by
    calc
      data.thetaPilotLogVolume <= data.cTheta * data.absLogQ :=
        data.thetaPilotLogVolume_le_cTheta_absLogQ
      _ = -data.absLogQ := by
        rw [hC]
        ring
  have hlower :
      -data.absLogQ <= data.thetaPilotLogVolume := by
    rw [← data.qPilotLogVolume_eq_neg_absLogQ]
    exact data.qPilotLogVolume_le_thetaPilotLogVolume
  exact le_antisymm hupper hlower

theorem qPilotLogVolume_eq_thetaPilotLogVolume_of_cTheta_eq_neg_one
    (data : IUTStage1Corollary312CThetaLowerBoundShadow)
    (hC : data.cTheta = (-1 : Real)) :
    data.qPilotLogVolume = data.thetaPilotLogVolume := by
  rw [data.qPilotLogVolume_eq_neg_absLogQ,
    data.thetaPilotLogVolume_eq_neg_absLogQ_of_cTheta_eq_neg_one hC]

theorem cTheta_eq_neg_one_or_gt_neg_one
    (data : IUTStage1Corollary312CThetaLowerBoundShadow) :
    data.cTheta = (-1 : Real) ∨ (-1 : Real) < data.cTheta := by
  by_cases hC : data.cTheta = (-1 : Real)
  · exact Or.inl hC
  · exact Or.inr (lt_of_le_of_ne data.cTheta_ge_neg_one (Ne.symm hC))

theorem neg_absLogQ_lt_cTheta_absLogQ_of_qPilot_lt_theta
    (data : IUTStage1Corollary312CThetaLowerBoundShadow)
    (hstrict :
      data.qPilotLogVolume < data.thetaPilotLogVolume) :
    -data.absLogQ < data.cTheta * data.absLogQ := by
  rw [← data.qPilotLogVolume_eq_neg_absLogQ]
  exact lt_of_lt_of_le hstrict data.thetaPilotLogVolume_le_cTheta_absLogQ

theorem cTheta_gt_neg_one_of_qPilot_lt_theta
    (data : IUTStage1Corollary312CThetaLowerBoundShadow)
    (hstrict :
      data.qPilotLogVolume < data.thetaPilotLogVolume) :
    (-1 : Real) < data.cTheta := by
  have hmul :
      (-1 : Real) * data.absLogQ < data.cTheta * data.absLogQ := by
    simpa using
      data.neg_absLogQ_lt_cTheta_absLogQ_of_qPilot_lt_theta hstrict
  nlinarith [data.absLogQ_pos]

theorem not_cTheta_le_neg_one_of_qPilot_lt_theta
    (data : IUTStage1Corollary312CThetaLowerBoundShadow)
    (hstrict :
      data.qPilotLogVolume < data.thetaPilotLogVolume) :
    ¬ data.cTheta <= (-1 : Real) :=
  not_le_of_gt (data.cTheta_gt_neg_one_of_qPilot_lt_theta hstrict)

end IUTStage1Corollary312CThetaLowerBoundShadow

/--
Statement-level Corollary 3.12 endpoint with the extended Theta value.

This record uses the finite branch of
`-|log(Theta)| ∈ R ∪ {+∞}`, keeps the q-pilot outside the indeterminacy
quotient, and applies the final ordered-real algebra to the displayed
upper-bound hypothesis `-|log(Theta)| <= C_Theta |log(q)|`.
-/
structure IUTStage1Corollary312StatementEndpoint where
  pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary
  finiteEndpoint : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint
  q_pilot_positive : 0 < -finiteEndpoint.upperRayData.qPilotLogVolume
  cTheta : Real
  thetaFiniteValue_le_cTheta_absLogQ :
    IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
        finiteEndpoint.thetaExtended <=
      cTheta * (-finiteEndpoint.upperRayData.qPilotLogVolume)

namespace IUTStage1Corollary312StatementEndpoint

def toCThetaLowerBoundShadow
    (data : IUTStage1Corollary312StatementEndpoint) :
    IUTStage1Corollary312CThetaLowerBoundShadow :=
  { absLogQ := -data.finiteEndpoint.upperRayData.qPilotLogVolume,
    absLogQ_pos := data.q_pilot_positive,
    qPilotLogVolume := data.finiteEndpoint.upperRayData.qPilotLogVolume,
    thetaPilotLogVolume :=
      IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
        data.finiteEndpoint.thetaExtended,
    cTheta := data.cTheta,
    qPilotLogVolume_eq_neg_absLogQ := by
      ring,
    qPilotLogVolume_le_thetaPilotLogVolume :=
      data.finiteEndpoint.qPilotLogVolume_le_thetaFiniteValue,
    thetaPilotLogVolume_le_cTheta_absLogQ :=
      data.thetaFiniteValue_le_cTheta_absLogQ }

theorem thetaExtendedFinite
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.thetaExtended.IsFinite :=
  data.finiteEndpoint.thetaExtendedFinite

theorem thetaExtended_ne_plusInfinity
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.thetaExtended ≠
      IUTStage1ExtendedSignedLogVolume.plusInfinity :=
  data.finiteEndpoint.thetaExtended_ne_plusInfinity

theorem qPilotNotSubject
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.pilotBoundary.qStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.notSubjectToIndeterminacies :=
  data.pilotBoundary.qNotSubject

theorem thetaPilotSubject
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.pilotBoundary.thetaStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.subjectToIndeterminacies :=
  data.pilotBoundary.thetaSubject

theorem qPilotLogVolume_le_thetaFiniteValue
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume <=
      IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
        data.finiteEndpoint.thetaExtended :=
  data.finiteEndpoint.qPilotLogVolume_le_thetaFiniteValue

def thetaRealLogVolume
    (data : IUTStage1Corollary312StatementEndpoint) : Real :=
  data.finiteEndpoint.thetaRealLogVolume

theorem thetaRealLogVolume_eq_hull
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.thetaRealLogVolume =
      data.finiteEndpoint.upperRayData.thetaHullLogVolume :=
  data.finiteEndpoint.thetaRealLogVolume_eq_hull

theorem qPilotLogVolume_le_thetaRealLogVolume
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume <=
      data.thetaRealLogVolume :=
  data.finiteEndpoint.qPilotLogVolume_le_thetaRealLogVolume

theorem qPilotLogVolume_mem_upperRay
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume ∈
      data.finiteEndpoint.upperRayData.upperRay :=
  data.finiteEndpoint.qPilotLogVolume_mem_upperRay

theorem qPilotLogVolume_neg
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume < 0 := by
  linarith [data.q_pilot_positive]

theorem qPilotLogVolume_lt_thetaRealLogVolume_of_theta_nonneg
    (data : IUTStage1Corollary312StatementEndpoint)
    (hTheta : 0 <= data.thetaRealLogVolume) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume <
      data.thetaRealLogVolume :=
  lt_of_lt_of_le data.qPilotLogVolume_neg hTheta

theorem thetaRealLogVolume_le_cTheta_absLogQ
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.thetaRealLogVolume <=
      data.cTheta * (-data.finiteEndpoint.upperRayData.qPilotLogVolume) := by
  rw [IUTStage1Corollary312StatementEndpoint.thetaRealLogVolume,
    data.finiteEndpoint.thetaRealLogVolume_eq_hull,
    ← data.finiteEndpoint.thetaFiniteValue_eq_hull]
  exact data.thetaFiniteValue_le_cTheta_absLogQ

theorem cTheta_nonnegative_of_thetaRealLogVolume_nonnegative
    (data : IUTStage1Corollary312StatementEndpoint)
    (hTheta : 0 <= data.thetaRealLogVolume) :
    0 <= data.cTheta := by
  have hmul :
      0 <= data.cTheta *
        (-data.finiteEndpoint.upperRayData.qPilotLogVolume) :=
    le_trans hTheta data.thetaRealLogVolume_le_cTheta_absLogQ
  nlinarith [hmul, data.q_pilot_positive]

theorem cTheta_ge_neg_one
    (data : IUTStage1Corollary312StatementEndpoint) :
    (-1 : Real) <= data.cTheta :=
  data.toCThetaLowerBoundShadow.cTheta_ge_neg_one

theorem cTheta_gt_neg_one_of_qPilot_lt_thetaRealLogVolume
    (data : IUTStage1Corollary312StatementEndpoint)
    (hstrict :
      data.finiteEndpoint.upperRayData.qPilotLogVolume <
        data.thetaRealLogVolume) :
    (-1 : Real) < data.cTheta := by
  apply data.toCThetaLowerBoundShadow.cTheta_gt_neg_one_of_qPilot_lt_theta
  have htheta :
      data.thetaRealLogVolume =
        IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
          data.finiteEndpoint.thetaExtended := by
    rw [data.thetaRealLogVolume_eq_hull,
      data.finiteEndpoint.thetaFiniteValue_eq_hull]
  change data.finiteEndpoint.upperRayData.qPilotLogVolume <
    IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
      data.finiteEndpoint.thetaExtended
  rw [← htheta]
  exact hstrict

theorem qPilotLogVolume_eq_thetaRealLogVolume_of_cTheta_eq_neg_one
    (data : IUTStage1Corollary312StatementEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume =
      data.thetaRealLogVolume := by
  have h :=
    data.toCThetaLowerBoundShadow
      |>.qPilotLogVolume_eq_thetaPilotLogVolume_of_cTheta_eq_neg_one hC
  change data.finiteEndpoint.upperRayData.qPilotLogVolume =
    IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
      data.finiteEndpoint.thetaExtended at h
  have htheta :
      IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
          data.finiteEndpoint.thetaExtended =
        data.thetaRealLogVolume := by
    rw [data.thetaRealLogVolume_eq_hull,
      data.finiteEndpoint.thetaFiniteValue_eq_hull]
  rw [htheta] at h
  exact h

theorem thetaRealLogVolume_neg_of_cTheta_eq_neg_one
    (data : IUTStage1Corollary312StatementEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    data.thetaRealLogVolume < 0 := by
  rw [← data.qPilotLogVolume_eq_thetaRealLogVolume_of_cTheta_eq_neg_one hC]
  exact data.qPilotLogVolume_neg

theorem not_thetaRealLogVolume_nonnegative_of_cTheta_eq_neg_one
    (data : IUTStage1Corollary312StatementEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    ¬ 0 <= data.thetaRealLogVolume :=
  not_le_of_gt (data.thetaRealLogVolume_neg_of_cTheta_eq_neg_one hC)

theorem cTheta_eq_neg_one_or_gt_neg_one
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.cTheta = (-1 : Real) ∨ (-1 : Real) < data.cTheta :=
  data.toCThetaLowerBoundShadow.cTheta_eq_neg_one_or_gt_neg_one

theorem not_cTheta_lt_neg_one
    (data : IUTStage1Corollary312StatementEndpoint) :
    ¬ data.cTheta < (-1 : Real) :=
  not_lt_of_ge data.cTheta_ge_neg_one

end IUTStage1Corollary312StatementEndpoint

/--
Signed Corollary 3.12 comparison data together with the final `C_Theta` bound.

This connects the existing Stage 1 signed comparison payload
`qSigned <= thetaSigned` to the Step (xi-f) lower bound on `C_Theta`.  The only
new hypothesis is the source condition on the chosen constant:
`thetaSigned <= C_Theta * (-qSigned)`, i.e. the displayed
`-|log(Theta)| <= C_Theta |log(q)|`.
-/
structure IUTStage1Corollary312SignedCThetaBound where
  comparison : Corollary312ComparisonData
  cTheta : Real
  thetaSigned_le_cTheta_absLogQ :
    comparison.thetaSigned <= cTheta * (-comparison.qSigned)

namespace IUTStage1Corollary312SignedCThetaBound

def toCThetaLowerBoundShadow
    (data : IUTStage1Corollary312SignedCThetaBound) :
    IUTStage1Corollary312CThetaLowerBoundShadow :=
  { absLogQ := -data.comparison.qSigned,
    absLogQ_pos := by
      simpa using data.comparison.q_positive,
    qPilotLogVolume := data.comparison.qSigned,
    thetaPilotLogVolume := data.comparison.thetaSigned,
    cTheta := data.cTheta,
    qPilotLogVolume_eq_neg_absLogQ := by
      ring,
    qPilotLogVolume_le_thetaPilotLogVolume :=
      data.comparison.qSigned_le_thetaSigned,
    thetaPilotLogVolume_le_cTheta_absLogQ :=
      data.thetaSigned_le_cTheta_absLogQ }

theorem qSigned_le_cTheta_absLogQ
    (data : IUTStage1Corollary312SignedCThetaBound) :
    data.comparison.qSigned <= data.cTheta * (-data.comparison.qSigned) :=
  data.toCThetaLowerBoundShadow.qPilotLogVolume_le_cTheta_absLogQ

theorem cTheta_ge_neg_one
    (data : IUTStage1Corollary312SignedCThetaBound) :
    (-1 : Real) <= data.cTheta :=
  data.toCThetaLowerBoundShadow.cTheta_ge_neg_one

theorem cTheta_gt_neg_one_of_qSigned_lt_thetaSigned
    (data : IUTStage1Corollary312SignedCThetaBound)
    (hstrict : data.comparison.qSigned < data.comparison.thetaSigned) :
    (-1 : Real) < data.cTheta :=
  data.toCThetaLowerBoundShadow.cTheta_gt_neg_one_of_qPilot_lt_theta
    hstrict

theorem qSigned_eq_thetaSigned_of_cTheta_eq_neg_one
    (data : IUTStage1Corollary312SignedCThetaBound)
    (hC : data.cTheta = (-1 : Real)) :
    data.comparison.qSigned = data.comparison.thetaSigned :=
  data.toCThetaLowerBoundShadow
    |>.qPilotLogVolume_eq_thetaPilotLogVolume_of_cTheta_eq_neg_one hC

theorem thetaSigned_neg_of_cTheta_eq_neg_one
    (data : IUTStage1Corollary312SignedCThetaBound)
    (hC : data.cTheta = (-1 : Real)) :
    data.comparison.thetaSigned < 0 := by
  rw [← data.qSigned_eq_thetaSigned_of_cTheta_eq_neg_one hC]
  linarith [data.comparison.q_positive]

theorem cTheta_eq_neg_one_or_gt_neg_one
    (data : IUTStage1Corollary312SignedCThetaBound) :
    data.cTheta = (-1 : Real) ∨ (-1 : Real) < data.cTheta :=
  data.toCThetaLowerBoundShadow.cTheta_eq_neg_one_or_gt_neg_one

end IUTStage1Corollary312SignedCThetaBound

namespace IUTStage1ThetaPossibleImagesHullLogVolumeShadow

variable {α : Type u} {ι : Type v}

def toQPilotTwoComputationLogVolume
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι) :
    IUTStage1QPilotTwoComputationLogVolume :=
  { upperRayData := data.toHullDetPilotUpperRayLogVolume,
    inputPrimeStripLogVolume := data.qPilotLogVolume,
    outputHullLogVolume := data.qPilotLogVolume,
    input_eq_q := rfl,
    output_eq_q := rfl }

def toSignedEndpoint
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (q_pilot_positive : 0 < -data.qPilotLogVolume) :
    IUTStage1QPilotTwoComputationSignedEndpoint :=
  { twoComputation := data.toQPilotTwoComputationLogVolume,
    q_pilot_positive := q_pilot_positive }

def toSignedCThetaBound
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (q_pilot_positive : 0 < -data.qPilotLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <= cTheta * (-data.qPilotLogVolume)) :
    IUTStage1Corollary312SignedCThetaBound :=
  { comparison := (data.toSignedEndpoint q_pilot_positive).comparisonData,
    cTheta := cTheta,
    thetaSigned_le_cTheta_absLogQ := by
      simpa [toSignedEndpoint, toQPilotTwoComputationLogVolume,
        IUTStage1QPilotTwoComputationSignedEndpoint.comparisonData]
        using thetaHull_le_cTheta_absLogQ }

theorem cTheta_ge_neg_one
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (q_pilot_positive : 0 < -data.qPilotLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <= cTheta * (-data.qPilotLogVolume)) :
    (-1 : Real) <= cTheta :=
  (data.toSignedCThetaBound q_pilot_positive cTheta
    thetaHull_le_cTheta_absLogQ).cTheta_ge_neg_one

theorem cTheta_eq_neg_one_or_gt_neg_one
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (q_pilot_positive : 0 < -data.qPilotLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <= cTheta * (-data.qPilotLogVolume)) :
    cTheta = (-1 : Real) ∨ (-1 : Real) < cTheta :=
  (data.toSignedCThetaBound q_pilot_positive cTheta
    thetaHull_le_cTheta_absLogQ).cTheta_eq_neg_one_or_gt_neg_one

theorem cTheta_gt_neg_one_of_qPilot_lt_thetaHull
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (q_pilot_positive : 0 < -data.qPilotLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <= cTheta * (-data.qPilotLogVolume))
    (hstrict : data.qPilotLogVolume < data.thetaHullLogVolume) :
    (-1 : Real) < cTheta :=
  (data.toSignedCThetaBound q_pilot_positive cTheta
    thetaHull_le_cTheta_absLogQ)
      |>.cTheta_gt_neg_one_of_qSigned_lt_thetaSigned
        (by
          simpa [toSignedCThetaBound, toSignedEndpoint,
            toQPilotTwoComputationLogVolume,
            IUTStage1QPilotTwoComputationSignedEndpoint.comparisonData]
            using hstrict)

theorem thetaHull_eq_qPilotLogVolume_of_cTheta_eq_neg_one
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (q_pilot_positive : 0 < -data.qPilotLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <= cTheta * (-data.qPilotLogVolume))
    (hC : cTheta = (-1 : Real)) :
    data.thetaHullLogVolume = data.qPilotLogVolume := by
  have htheta :
      data.qPilotLogVolume = data.thetaHullLogVolume :=
    (data.toSignedCThetaBound q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ)
        |>.toCThetaLowerBoundShadow
        |>.qPilotLogVolume_eq_thetaPilotLogVolume_of_cTheta_eq_neg_one hC
  simpa [toSignedCThetaBound, toSignedEndpoint, toQPilotTwoComputationLogVolume,
    IUTStage1QPilotTwoComputationSignedEndpoint.comparisonData] using
    htheta.symm

theorem thetaHull_eq_qPilotLogVolume_or_cTheta_gt_neg_one
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (q_pilot_positive : 0 < -data.qPilotLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <= cTheta * (-data.qPilotLogVolume)) :
    data.thetaHullLogVolume = data.qPilotLogVolume ∨
      (-1 : Real) < cTheta := by
  rcases data.cTheta_eq_neg_one_or_gt_neg_one
      q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ with
    hboundary | hstrict
  · exact Or.inl
      (data.thetaHull_eq_qPilotLogVolume_of_cTheta_eq_neg_one
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hboundary)
  · exact Or.inr hstrict

end IUTStage1ThetaPossibleImagesHullLogVolumeShadow

/--
Generalized `q^lambda` Step (xi-f) algebra.

Remark 3.11.1(ii) and Remark 3.12.1(ii) discuss replacing the q-pilot by a
`q^lambda`-pilot.  At the real-valued endpoint, a signed q-pilot log-volume
`-lambda * |log(q)|`, together with the same Theta upper bound by
`C_Theta * |log(q)|`, yields `C_Theta >= -lambda`.
-/
structure IUTStage1Corollary312QLambdaCThetaBoundShadow where
  lambda : Rat
  lambda_pos : 0 < lambda
  absLogQ : Real
  absLogQ_pos : 0 < absLogQ
  qLambdaSigned : Real
  thetaSigned : Real
  cTheta : Real
  qLambdaSigned_eq_neg_lambda_absLogQ :
    qLambdaSigned = -((lambda : Real) * absLogQ)
  qLambdaSigned_le_thetaSigned :
    qLambdaSigned <= thetaSigned
  thetaSigned_le_cTheta_absLogQ :
    thetaSigned <= cTheta * absLogQ

namespace IUTStage1Corollary312QLambdaCThetaBoundShadow

theorem qLambdaSigned_le_cTheta_absLogQ
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow) :
    data.qLambdaSigned <= data.cTheta * data.absLogQ :=
  le_trans data.qLambdaSigned_le_thetaSigned
    data.thetaSigned_le_cTheta_absLogQ

theorem cTheta_ge_neg_lambda
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow) :
    -((data.lambda : Real)) <= data.cTheta := by
  have hle := data.qLambdaSigned_le_cTheta_absLogQ
  rw [data.qLambdaSigned_eq_neg_lambda_absLogQ] at hle
  have hmul :
      -((data.lambda : Real)) * data.absLogQ <=
        data.cTheta * data.absLogQ := by
    simpa [neg_mul] using hle
  exact le_of_mul_le_mul_right hmul data.absLogQ_pos

theorem thetaSigned_eq_neg_lambda_absLogQ_of_cTheta_eq_neg_lambda
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hC : data.cTheta = -((data.lambda : Real))) :
    data.thetaSigned = -((data.lambda : Real) * data.absLogQ) := by
  have hupper :
      data.thetaSigned <= -((data.lambda : Real) * data.absLogQ) := by
    calc
      data.thetaSigned <= data.cTheta * data.absLogQ :=
        data.thetaSigned_le_cTheta_absLogQ
      _ = -((data.lambda : Real) * data.absLogQ) := by
        rw [hC]
        ring
  have hlower :
      -((data.lambda : Real) * data.absLogQ) <= data.thetaSigned := by
    rw [← data.qLambdaSigned_eq_neg_lambda_absLogQ]
    exact data.qLambdaSigned_le_thetaSigned
  exact le_antisymm hupper hlower

theorem qLambdaSigned_eq_thetaSigned_of_cTheta_eq_neg_lambda
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hC : data.cTheta = -((data.lambda : Real))) :
    data.qLambdaSigned = data.thetaSigned := by
  rw [data.qLambdaSigned_eq_neg_lambda_absLogQ,
    data.thetaSigned_eq_neg_lambda_absLogQ_of_cTheta_eq_neg_lambda hC]

theorem cTheta_eq_neg_lambda_or_gt_neg_lambda
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow) :
    data.cTheta = -((data.lambda : Real)) ∨
      -((data.lambda : Real)) < data.cTheta := by
  by_cases hC : data.cTheta = -((data.lambda : Real))
  · exact Or.inl hC
  · exact Or.inr (lt_of_le_of_ne data.cTheta_ge_neg_lambda (Ne.symm hC))

theorem neg_lambda_absLogQ_lt_cTheta_absLogQ_of_qLambda_lt_theta
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hstrict : data.qLambdaSigned < data.thetaSigned) :
    -((data.lambda : Real) * data.absLogQ) <
      data.cTheta * data.absLogQ := by
  rw [← data.qLambdaSigned_eq_neg_lambda_absLogQ]
  exact lt_of_lt_of_le hstrict data.thetaSigned_le_cTheta_absLogQ

theorem cTheta_gt_neg_lambda_of_qLambda_lt_theta
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hstrict : data.qLambdaSigned < data.thetaSigned) :
    -((data.lambda : Real)) < data.cTheta := by
  have hmul :
      -((data.lambda : Real)) * data.absLogQ <
        data.cTheta * data.absLogQ := by
    simpa [neg_mul] using
      data.neg_lambda_absLogQ_lt_cTheta_absLogQ_of_qLambda_lt_theta hstrict
  nlinarith [data.absLogQ_pos]

theorem standard_bound_of_lambda_le_one
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hlambda : data.lambda <= 1) :
    (-1 : Real) <= data.cTheta := by
  have hcast : (data.lambda : Real) <= 1 := by
    exact_mod_cast hlambda
  have hstandard : (-1 : Real) <= -((data.lambda : Real)) := by
    linarith
  exact le_trans hstandard data.cTheta_ge_neg_lambda

theorem strict_standard_bound_of_lambda_lt_one
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hlambda : data.lambda < 1) :
    (-1 : Real) < data.cTheta := by
  have hcast : (data.lambda : Real) < 1 := by
    exact_mod_cast hlambda
  have hstrict : (-1 : Real) < -((data.lambda : Real)) := by
    linarith
  exact lt_of_lt_of_le hstrict data.cTheta_ge_neg_lambda

end IUTStage1Corollary312QLambdaCThetaBoundShadow

/--
Step (xi-g) to Step (xi-f) endpoint with a chosen `C_Theta`.

This composes the two q-pilot computations, the signed Corollary 3.12 payload,
and the final `C_Theta` bound hypothesis into the lower bound
`C_Theta >= -1`.
-/
structure IUTStage1QPilotTwoComputationCThetaEndpoint where
  signedEndpoint : IUTStage1QPilotTwoComputationSignedEndpoint
  cTheta : Real
  thetaHullLogVolume_le_cTheta_absLogQ :
    signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume <=
      cTheta * (-signedEndpoint.twoComputation.inputPrimeStripLogVolume)

namespace IUTStage1QPilotTwoComputationCThetaEndpoint

def absLogQ
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) : Real :=
  data.signedEndpoint.absLogQ

theorem absLogQ_pos
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    0 < data.absLogQ :=
  data.signedEndpoint.absLogQ_pos

theorem thetaHullLogVolume_le_cTheta_fixedAbsLogQ
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume <=
      data.cTheta * data.absLogQ := by
  simpa [IUTStage1QPilotTwoComputationCThetaEndpoint.absLogQ,
    IUTStage1QPilotTwoComputationSignedEndpoint.absLogQ, mul_neg] using
    data.thetaHullLogVolume_le_cTheta_absLogQ

theorem fixed_qPilot_le_thetaHullLogVolume
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    -data.absLogQ <=
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume := by
  simpa [IUTStage1QPilotTwoComputationCThetaEndpoint.absLogQ] using
    data.signedEndpoint.fixed_qPilot_le_thetaHullLogVolume

theorem fixed_qPilot_le_cTheta_absLogQ
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    -data.absLogQ <= data.cTheta * data.absLogQ :=
  le_trans data.fixed_qPilot_le_thetaHullLogVolume
    data.thetaHullLogVolume_le_cTheta_fixedAbsLogQ

def toFixedValueCThetaLowerBoundShadow
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    IUTStage1Corollary312CThetaLowerBoundShadow :=
  { absLogQ := data.absLogQ,
    absLogQ_pos := data.absLogQ_pos,
    qPilotLogVolume := -data.absLogQ,
    thetaPilotLogVolume :=
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume,
    cTheta := data.cTheta,
    qPilotLogVolume_eq_neg_absLogQ := rfl,
    qPilotLogVolume_le_thetaPilotLogVolume :=
      data.fixed_qPilot_le_thetaHullLogVolume,
    thetaPilotLogVolume_le_cTheta_absLogQ :=
      data.thetaHullLogVolume_le_cTheta_fixedAbsLogQ }

def toSignedCThetaBound
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    IUTStage1Corollary312SignedCThetaBound :=
  { comparison := data.signedEndpoint.comparisonData,
    cTheta := data.cTheta,
    thetaSigned_le_cTheta_absLogQ := by
      simpa [IUTStage1QPilotTwoComputationSignedEndpoint.comparisonData] using
        data.thetaHullLogVolume_le_cTheta_absLogQ }

theorem cTheta_ge_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    (-1 : Real) <= data.cTheta :=
  data.toSignedCThetaBound.cTheta_ge_neg_one

theorem cTheta_ge_neg_one_from_fixed_qPilot
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    (-1 : Real) <= data.cTheta :=
  data.toFixedValueCThetaLowerBoundShadow.cTheta_ge_neg_one

theorem cTheta_gt_neg_one_of_fixed_qPilot_lt_thetaHullLogVolume
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hstrict :
      -data.absLogQ <
        data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume) :
    (-1 : Real) < data.cTheta :=
  data.toFixedValueCThetaLowerBoundShadow.cTheta_gt_neg_one_of_qPilot_lt_theta
    hstrict

theorem cTheta_gt_neg_one_of_qInput_lt_thetaHullLogVolume
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hstrict :
      data.signedEndpoint.twoComputation.inputPrimeStripLogVolume <
        data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume) :
    (-1 : Real) < data.cTheta := by
  apply data.cTheta_gt_neg_one_of_fixed_qPilot_lt_thetaHullLogVolume
  have hinput :
      data.signedEndpoint.twoComputation.inputPrimeStripLogVolume =
        -data.absLogQ := by
    rw [IUTStage1QPilotTwoComputationCThetaEndpoint.absLogQ,
      data.signedEndpoint.inputPrimeStripLogVolume_eq_neg_absLogQ]
  rw [← hinput]
  exact hstrict

theorem cTheta_gt_neg_one_of_qOutput_lt_thetaHullLogVolume
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hstrict :
      data.signedEndpoint.twoComputation.outputHullLogVolume <
        data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume) :
    (-1 : Real) < data.cTheta := by
  apply data.cTheta_gt_neg_one_of_qInput_lt_thetaHullLogVolume
  rw [data.signedEndpoint.twoComputation.input_eq_output]
  exact hstrict

theorem fixed_qPilot_eq_thetaHullLogVolume_of_cTheta_eq_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    -data.absLogQ =
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume :=
  data.toFixedValueCThetaLowerBoundShadow
    |>.qPilotLogVolume_eq_thetaPilotLogVolume_of_cTheta_eq_neg_one hC

theorem qInputLogVolume_eq_thetaHullLogVolume_of_cTheta_eq_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    data.signedEndpoint.twoComputation.inputPrimeStripLogVolume =
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume := by
  rw [data.signedEndpoint.inputPrimeStripLogVolume_eq_neg_absLogQ]
  simpa [IUTStage1QPilotTwoComputationCThetaEndpoint.absLogQ] using
    data.fixed_qPilot_eq_thetaHullLogVolume_of_cTheta_eq_neg_one hC

theorem qOutputLogVolume_eq_thetaHullLogVolume_of_cTheta_eq_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    data.signedEndpoint.twoComputation.outputHullLogVolume =
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume := by
  rw [← data.signedEndpoint.twoComputation.input_eq_output]
  exact data.qInputLogVolume_eq_thetaHullLogVolume_of_cTheta_eq_neg_one hC

theorem not_qOutputLogVolume_lt_thetaHullLogVolume_of_cTheta_eq_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    ¬ data.signedEndpoint.twoComputation.outputHullLogVolume <
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume := by
  rw [data.qOutputLogVolume_eq_thetaHullLogVolume_of_cTheta_eq_neg_one hC]
  exact lt_irrefl _

theorem thetaHullLogVolume_neg_of_cTheta_eq_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume < 0 := by
  rw [← data.qInputLogVolume_eq_thetaHullLogVolume_of_cTheta_eq_neg_one hC]
  linarith [data.signedEndpoint.q_pilot_positive]

theorem cTheta_eq_neg_one_or_gt_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    data.cTheta = (-1 : Real) ∨ (-1 : Real) < data.cTheta :=
  data.toFixedValueCThetaLowerBoundShadow.cTheta_eq_neg_one_or_gt_neg_one

theorem not_cTheta_lt_neg_one_from_fixed_qPilot
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    ¬ data.cTheta < (-1 : Real) :=
  not_lt_of_ge data.cTheta_ge_neg_one_from_fixed_qPilot

theorem qInputLogVolume_le_cTheta_absLogQ
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    data.signedEndpoint.twoComputation.inputPrimeStripLogVolume <=
      data.cTheta *
        (-data.signedEndpoint.twoComputation.inputPrimeStripLogVolume) :=
  data.toSignedCThetaBound.qSigned_le_cTheta_absLogQ

theorem fixed_qPilotLogVolume_le_cTheta_absLogQ
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    -data.absLogQ <= data.cTheta * data.absLogQ :=
  data.toFixedValueCThetaLowerBoundShadow.neg_absLogQ_le_cTheta_absLogQ

def toStatementEndpoint
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    IUTStage1Corollary312StatementEndpoint :=
  { pilotBoundary := pilotBoundary,
    finiteEndpoint :=
      IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint.ofUpperRayData
        data.signedEndpoint.twoComputation.upperRayData,
    q_pilot_positive := by
      simpa [IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint.ofUpperRayData,
        data.signedEndpoint.twoComputation.input_eq_q] using
        data.signedEndpoint.q_pilot_positive,
    cTheta := data.cTheta,
    thetaFiniteValue_le_cTheta_absLogQ := by
      simpa [IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint.ofUpperRayData,
        data.signedEndpoint.twoComputation.input_eq_q] using
        data.thetaHullLogVolume_le_cTheta_absLogQ }

theorem toStatementEndpoint_cTheta_ge_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    (-1 : Real) <= (data.toStatementEndpoint pilotBoundary).cTheta :=
  (data.toStatementEndpoint pilotBoundary).cTheta_ge_neg_one

end IUTStage1QPilotTwoComputationCThetaEndpoint

/--
Opening sign reduction in the proof of IUT III, Corollary 3.12.

The source proof observes that, since `|log(q)| > 0`, if
`-|log(Theta)| >= 0`, then the desired comparison
`-|log(q)| <= -|log(Theta)|` is immediate.  Thus the nontrivial case may assume
`-|log(Theta)| < 0`.
-/
structure IUTStage1Corollary312ThetaSignReduction where
  qSigned : Real
  thetaSigned : Real
  q_pilot_positive : 0 < -qSigned

namespace IUTStage1Corollary312ThetaSignReduction

theorem qSigned_neg
    (data : IUTStage1Corollary312ThetaSignReduction) :
    data.qSigned < 0 := by
  linarith [data.q_pilot_positive]

theorem qSigned_le_thetaSigned_of_theta_nonneg
    (data : IUTStage1Corollary312ThetaSignReduction)
    (hTheta : 0 <= data.thetaSigned) :
    data.qSigned <= data.thetaSigned := by
  linarith [data.qSigned_neg, hTheta]

def comparisonDataOfThetaNonnegative
    (data : IUTStage1Corollary312ThetaSignReduction)
    (hTheta : 0 <= data.thetaSigned) :
    Corollary312ComparisonData :=
  { thetaSigned := data.thetaSigned,
    qSigned := data.qSigned,
    q_positive := data.q_pilot_positive,
    qSigned_le_thetaSigned :=
      data.qSigned_le_thetaSigned_of_theta_nonneg hTheta }

theorem corollary312_of_theta_nonnegative
    (data : IUTStage1Corollary312ThetaSignReduction)
    (hTheta : 0 <= data.thetaSigned) :
    Corollary312Inequality
      (data.comparisonDataOfThetaNonnegative hTheta).thetaPilot
      (data.comparisonDataOfThetaNonnegative hTheta).qPilot :=
  (data.comparisonDataOfThetaNonnegative hTheta).corollary312

end IUTStage1Corollary312ThetaSignReduction

namespace IUTStage1Corollary312StatementEndpoint

def toThetaSignReduction
    (data : IUTStage1Corollary312StatementEndpoint) :
    IUTStage1Corollary312ThetaSignReduction :=
  { qSigned := data.finiteEndpoint.upperRayData.qPilotLogVolume,
    thetaSigned := data.thetaRealLogVolume,
    q_pilot_positive := data.q_pilot_positive }

theorem thetaSignReduction_qSigned
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.toThetaSignReduction.qSigned =
      data.finiteEndpoint.upperRayData.qPilotLogVolume :=
  rfl

theorem thetaSignReduction_thetaSigned
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.toThetaSignReduction.thetaSigned = data.thetaRealLogVolume :=
  rfl

theorem qPilotLogVolume_le_thetaRealLogVolume_of_theta_nonnegative
    (data : IUTStage1Corollary312StatementEndpoint)
    (hTheta : 0 <= data.thetaRealLogVolume) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume <=
      data.thetaRealLogVolume :=
  data.toThetaSignReduction.qSigned_le_thetaSigned_of_theta_nonneg hTheta

theorem corollary312_of_thetaRealLogVolume_nonnegative
    (data : IUTStage1Corollary312StatementEndpoint)
    (hTheta : 0 <= data.thetaRealLogVolume) :
    Corollary312Inequality
      (data.toThetaSignReduction.comparisonDataOfThetaNonnegative
        hTheta).thetaPilot
      (data.toThetaSignReduction.comparisonDataOfThetaNonnegative
        hTheta).qPilot :=
  data.toThetaSignReduction.corollary312_of_theta_nonnegative hTheta

end IUTStage1Corollary312StatementEndpoint

/--
Step (xi-h) tensor-power warning for the `Theta`-pilot log-volume.

The source text recalls that the EtTh argument used in Step (xi) has no evident
generalization to `N`-th tensor powers of `Theta`-pilot objects for `N ≥ 2`.
Numerically, the log-volume of such a tensor power is computed by multiplying
the original `Theta`-pilot log-volume by `N`.  For the negative log-volumes in
the Corollary 3.12 corridor, this produces a genuinely sharper upper-ray
boundary, so it cannot be silently substituted for the original comparison.
-/
structure IUTStage1ThetaPilotTensorPowerLogVolume where
  originalThetaPilotLogVolume : Real
  tensorPower : Nat
  tensor_power_ge_two : 2 ≤ tensorPower
  tensorPowerLogVolume : Real
  tensor_power_logVolume_eq :
    tensorPowerLogVolume =
      (tensorPower : Real) * originalThetaPilotLogVolume

namespace IUTStage1ThetaPilotTensorPowerLogVolume

def originalUpperRay
    (data : IUTStage1ThetaPilotTensorPowerLogVolume) : Set Real :=
  { value | value <= data.originalThetaPilotLogVolume }

def tensorPowerUpperRay
    (data : IUTStage1ThetaPilotTensorPowerLogVolume) : Set Real :=
  { value | value <= data.tensorPowerLogVolume }

theorem tensorPowerLogVolume_eq_mul
    (data : IUTStage1ThetaPilotTensorPowerLogVolume) :
    data.tensorPowerLogVolume =
      (data.tensorPower : Real) * data.originalThetaPilotLogVolume :=
  data.tensor_power_logVolume_eq

theorem one_le_tensorPower_real
    (data : IUTStage1ThetaPilotTensorPowerLogVolume) :
    (1 : Real) <= data.tensorPower := by
  exact_mod_cast le_trans (by decide : 1 ≤ 2) data.tensor_power_ge_two

theorem one_lt_tensorPower_real
    (data : IUTStage1ThetaPilotTensorPowerLogVolume) :
    (1 : Real) < data.tensorPower := by
  exact_mod_cast lt_of_lt_of_le (by decide : 1 < 2) data.tensor_power_ge_two

theorem tensorPowerLogVolume_le_original_of_original_nonpos
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume <= 0) :
    data.tensorPowerLogVolume <= data.originalThetaPilotLogVolume := by
  rw [data.tensorPowerLogVolume_eq_mul]
  have h :=
    mul_le_mul_of_nonpos_right data.one_le_tensorPower_real hTheta
  simpa using h

theorem tensorPowerUpperRay_subset_originalUpperRay_of_original_nonpos
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume <= 0) :
    data.tensorPowerUpperRay ⊆ data.originalUpperRay := by
  intro value hvalue
  exact le_trans hvalue
    (data.tensorPowerLogVolume_le_original_of_original_nonpos hTheta)

theorem tensorPowerLogVolume_lt_original_of_original_neg
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0) :
    data.tensorPowerLogVolume < data.originalThetaPilotLogVolume := by
  rw [data.tensorPowerLogVolume_eq_mul]
  have h :=
    mul_lt_mul_of_neg_right data.one_lt_tensorPower_real hTheta
  simpa using h

theorem originalBoundary_mem_originalUpperRay
    (data : IUTStage1ThetaPilotTensorPowerLogVolume) :
    data.originalThetaPilotLogVolume ∈ data.originalUpperRay := by
  unfold originalUpperRay
  exact le_refl data.originalThetaPilotLogVolume

theorem originalBoundary_not_mem_tensorPowerUpperRay_of_original_neg
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0) :
    data.originalThetaPilotLogVolume ∉ data.tensorPowerUpperRay := by
  exact not_le_of_gt
    (data.tensorPowerLogVolume_lt_original_of_original_neg hTheta)

theorem mem_tensorPowerUpperRay_lt_original_of_original_neg
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0)
    {value : Real}
    (hvalue : value ∈ data.tensorPowerUpperRay) :
    value < data.originalThetaPilotLogVolume :=
  lt_of_le_of_lt hvalue
    (data.tensorPowerLogVolume_lt_original_of_original_neg hTheta)

theorem originalUpperRay_not_subset_tensorPowerUpperRay_of_original_neg
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0) :
    ¬ data.originalUpperRay ⊆ data.tensorPowerUpperRay := by
  intro hsubset
  exact data.originalBoundary_not_mem_tensorPowerUpperRay_of_original_neg
    hTheta (hsubset data.originalBoundary_mem_originalUpperRay)

end IUTStage1ThetaPilotTensorPowerLogVolume

/--
Step (xii) local Frobenioid ambiguity for log-volume computation.

The paper warns that replacing the global realified Frobenioids in the
`Theta^{×μ}` LGP-link by only local Frobenioids leaves an integer ambiguity:
a local object may correspond to an open log-shell submodule or to its
`p_v^N`-multiple.  This additive log-volume shadow records that ambiguity as an
integer shift by a fixed local step.
-/
structure IUTStage1LocalFrobenioidLogVolumeAmbiguity where
  unshiftedLogVolume : Real
  localExponent : Int
  localPrimeStepLogVolume : Real
  shiftedLogVolume : Real
  shifted_logVolume_eq :
    shiftedLogVolume =
      unshiftedLogVolume +
        (localExponent : Real) * localPrimeStepLogVolume

namespace IUTStage1LocalFrobenioidLogVolumeAmbiguity

theorem shiftTerm_ne_zero
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity)
    (hExponent : data.localExponent ≠ 0)
    (hStep : data.localPrimeStepLogVolume ≠ 0) :
    (data.localExponent : Real) * data.localPrimeStepLogVolume ≠ 0 :=
  mul_ne_zero (by exact_mod_cast hExponent) hStep

theorem shiftedLogVolume_ne_unshifted
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity)
    (hExponent : data.localExponent ≠ 0)
    (hStep : data.localPrimeStepLogVolume ≠ 0) :
    data.shiftedLogVolume ≠ data.unshiftedLogVolume := by
  intro h
  have hsum :
      data.unshiftedLogVolume +
          (data.localExponent : Real) * data.localPrimeStepLogVolume =
        data.unshiftedLogVolume := by
    simpa [data.shifted_logVolume_eq] using h
  have hsum' :
      data.unshiftedLogVolume +
          (data.localExponent : Real) * data.localPrimeStepLogVolume =
        data.unshiftedLogVolume + 0 := by
    simpa using hsum
  have hzero :
      (data.localExponent : Real) * data.localPrimeStepLogVolume = 0 :=
    add_left_cancel hsum'
  exact data.shiftTerm_ne_zero hExponent hStep hzero

theorem shiftedLogVolume_eq_unshifted_iff_shiftTerm_eq_zero
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity) :
    data.shiftedLogVolume = data.unshiftedLogVolume ↔
      (data.localExponent : Real) * data.localPrimeStepLogVolume = 0 := by
  constructor
  · intro h
    have hsum :
        data.unshiftedLogVolume +
            (data.localExponent : Real) * data.localPrimeStepLogVolume =
          data.unshiftedLogVolume := by
      simpa [data.shifted_logVolume_eq] using h
    have hsum' :
        data.unshiftedLogVolume +
            (data.localExponent : Real) * data.localPrimeStepLogVolume =
          data.unshiftedLogVolume + 0 := by
      simpa using hsum
    exact add_left_cancel hsum'
  · intro h
    rw [data.shifted_logVolume_eq, h, add_zero]

theorem shiftTerm_eq_zero_iff_exponent_zero_or_step_zero
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity) :
    (data.localExponent : Real) * data.localPrimeStepLogVolume = 0 ↔
      data.localExponent = 0 ∨ data.localPrimeStepLogVolume = 0 := by
  constructor
  · intro h
    rcases mul_eq_zero.mp h with hexp | hstep
    · left
      exact_mod_cast hexp
    · exact Or.inr hstep
  · rintro (hexp | hstep)
    · rw [hexp]
      norm_num
    · rw [hstep, mul_zero]

theorem shiftedLogVolume_eq_unshifted_iff_exponent_zero_or_step_zero
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity) :
    data.shiftedLogVolume = data.unshiftedLogVolume ↔
      data.localExponent = 0 ∨ data.localPrimeStepLogVolume = 0 := by
  rw [data.shiftedLogVolume_eq_unshifted_iff_shiftTerm_eq_zero,
    data.shiftTerm_eq_zero_iff_exponent_zero_or_step_zero]

theorem shiftedLogVolume_eq_iff_exponent_eq_of_same_base_step
    (data₁ data₂ : IUTStage1LocalFrobenioidLogVolumeAmbiguity)
    (hunshift : data₁.unshiftedLogVolume = data₂.unshiftedLogVolume)
    (hstep :
      data₁.localPrimeStepLogVolume = data₂.localPrimeStepLogVolume)
    (hstep_ne_zero : data₁.localPrimeStepLogVolume ≠ 0) :
    data₁.shiftedLogVolume = data₂.shiftedLogVolume ↔
      data₁.localExponent = data₂.localExponent := by
  constructor
  · intro hshift
    have hsum :
        data₁.unshiftedLogVolume +
            (data₁.localExponent : Real) *
              data₁.localPrimeStepLogVolume =
          data₂.unshiftedLogVolume +
            (data₂.localExponent : Real) *
              data₂.localPrimeStepLogVolume := by
      calc
        data₁.unshiftedLogVolume +
            (data₁.localExponent : Real) *
              data₁.localPrimeStepLogVolume =
            data₁.shiftedLogVolume := data₁.shifted_logVolume_eq.symm
        _ = data₂.shiftedLogVolume := hshift
        _ =
            data₂.unshiftedLogVolume +
              (data₂.localExponent : Real) *
                data₂.localPrimeStepLogVolume :=
          data₂.shifted_logVolume_eq
    have hsum_same_step :
        data₁.unshiftedLogVolume +
            (data₁.localExponent : Real) *
              data₁.localPrimeStepLogVolume =
          data₁.unshiftedLogVolume +
            (data₂.localExponent : Real) *
              data₁.localPrimeStepLogVolume := by
      simpa [← hunshift, ← hstep] using hsum
    have hmuleq :
        (data₁.localExponent : Real) *
            data₁.localPrimeStepLogVolume =
          (data₂.localExponent : Real) *
            data₁.localPrimeStepLogVolume :=
      add_left_cancel hsum_same_step
    have hreal :
        (data₁.localExponent : Real) =
          (data₂.localExponent : Real) :=
      mul_right_cancel₀ hstep_ne_zero hmuleq
    exact_mod_cast hreal
  · intro hExponent
    rw [data₁.shifted_logVolume_eq, data₂.shifted_logVolume_eq,
      hunshift, hstep, hExponent]

theorem shiftedLogVolume_lt_unshifted_iff_shiftTerm_lt_zero
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity) :
    data.shiftedLogVolume < data.unshiftedLogVolume ↔
      (data.localExponent : Real) * data.localPrimeStepLogVolume < 0 := by
  constructor
  · intro h
    nlinarith [data.shifted_logVolume_eq]
  · intro h
    rw [data.shifted_logVolume_eq]
    linarith

theorem unshiftedLogVolume_lt_shifted_iff_shiftTerm_pos
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity) :
    data.unshiftedLogVolume < data.shiftedLogVolume ↔
      0 < (data.localExponent : Real) * data.localPrimeStepLogVolume := by
  constructor
  · intro h
    nlinarith [data.shifted_logVolume_eq]
  · intro h
    rw [data.shifted_logVolume_eq]
    linarith

end IUTStage1LocalFrobenioidLogVolumeAmbiguity

/--
Source-facing local Frobenioid log-shell submodule for Step (xii).

This is the local object whose log-volume is being compared.  The global
realified Frobenioid calibration should select this object, while the local
Frobenioid alone also admits `p_v^N` endomorphic shifts.
-/
structure IUTStage1LocalFrobenioidLogShellSubmodule where
  id : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean
  logVolume : Real

/--
Source-facing `p_v^N` local Frobenioid action on a log-shell submodule.

The action is modeled at the log-volume level by adding
`N * localPrimeStepLogVolume`.  The automorphism predicate records the source
distinction stressed in IUT III, Step (xii): local Frobenioid endomorphisms need
not be automorphisms.  In this model, the only automorphic `p_v^N` shift is the
zero exponent.
-/
structure IUTStage1LocalFrobenioidPVPowerLogVolumeSource where
  baseSubmodule : IUTStage1LocalFrobenioidLogShellSubmodule
  localExponent : Int
  localPrimeStepLogVolume : Real
  pPowerEndomorphismIsAutomorphism : Prop
  pPowerEndomorphism_isAutomorphism_iff_exponent_zero :
    pPowerEndomorphismIsAutomorphism ↔ localExponent = 0

namespace IUTStage1LocalFrobenioidPVPowerLogVolumeSource

open IUTStage1LocalFrobenioidLogVolumeAmbiguity

def shiftedLogVolume
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource) : Real :=
  source.baseSubmodule.logVolume +
    (source.localExponent : Real) * source.localPrimeStepLogVolume

def toLocalFrobenioidLogVolumeAmbiguity
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource) :
    IUTStage1LocalFrobenioidLogVolumeAmbiguity :=
  { unshiftedLogVolume := source.baseSubmodule.logVolume,
    localExponent := source.localExponent,
    localPrimeStepLogVolume := source.localPrimeStepLogVolume,
    shiftedLogVolume := source.shiftedLogVolume,
    shifted_logVolume_eq := rfl }

theorem shiftedLogVolume_eq
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource) :
    source.shiftedLogVolume =
      source.baseSubmodule.logVolume +
        (source.localExponent : Real) * source.localPrimeStepLogVolume :=
  rfl

theorem toAmbiguity_unshifted
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource) :
    source.toLocalFrobenioidLogVolumeAmbiguity.unshiftedLogVolume =
      source.baseSubmodule.logVolume :=
  rfl

theorem toAmbiguity_shifted
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource) :
    source.toLocalFrobenioidLogVolumeAmbiguity.shiftedLogVolume =
      source.shiftedLogVolume :=
  rfl

theorem exponent_ne_zero_of_not_automorphism
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource)
    (hnot : ¬ source.pPowerEndomorphismIsAutomorphism) :
    source.localExponent ≠ 0 := by
  intro hzero
  exact hnot
    (source.pPowerEndomorphism_isAutomorphism_iff_exponent_zero.mpr hzero)

theorem shiftedLogVolume_ne_base_of_not_automorphism
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource)
    (hnot : ¬ source.pPowerEndomorphismIsAutomorphism)
    (hStep : source.localPrimeStepLogVolume ≠ 0) :
    source.shiftedLogVolume ≠ source.baseSubmodule.logVolume := by
  exact
    source.toLocalFrobenioidLogVolumeAmbiguity.shiftedLogVolume_ne_unshifted
      (source.exponent_ne_zero_of_not_automorphism hnot) hStep

theorem shiftedLogVolume_eq_base_iff_automorphism_or_zero_step
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource) :
    source.shiftedLogVolume = source.baseSubmodule.logVolume ↔
      source.pPowerEndomorphismIsAutomorphism ∨
        source.localPrimeStepLogVolume = 0 := by
  have hambiguity :=
    shiftedLogVolume_eq_unshifted_iff_exponent_zero_or_step_zero
      source.toLocalFrobenioidLogVolumeAmbiguity
  rw [← source.toAmbiguity_shifted, ← source.toAmbiguity_unshifted,
    hambiguity]
  constructor
  · rintro (hexp | hstep)
    · exact Or.inl
        (source.pPowerEndomorphism_isAutomorphism_iff_exponent_zero.mpr hexp)
    · exact Or.inr hstep
  · rintro (hauto | hstep)
    · exact Or.inl
        (source.pPowerEndomorphism_isAutomorphism_iff_exponent_zero.mp hauto)
    · exact Or.inr hstep

theorem localFrobenioidSource_endpoint
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource) :
    source.toLocalFrobenioidLogVolumeAmbiguity.unshiftedLogVolume =
        source.baseSubmodule.logVolume ∧
      source.toLocalFrobenioidLogVolumeAmbiguity.shiftedLogVolume =
        source.baseSubmodule.logVolume +
          (source.localExponent : Real) * source.localPrimeStepLogVolume ∧
      (source.pPowerEndomorphismIsAutomorphism ↔ source.localExponent = 0) :=
  ⟨rfl, rfl, source.pPowerEndomorphism_isAutomorphism_iff_exponent_zero⟩

end IUTStage1LocalFrobenioidPVPowerLogVolumeSource

/--
Global realified Frobenioid calibration shadow for Step (xii).

This record represents the use of global Frobenioid data to eliminate the local
integer scaling ambiguity before a precise log-volume comparison is attempted.
-/
structure IUTStage1GlobalFrobenioidLogVolumeCalibration where
  localData :
    IUTStage1LocalFrobenioidLogVolumeAmbiguity
  globalExponent : Int
  global_exponent_eq_zero : globalExponent = 0
  calibratedLogVolume : Real
  calibrated_logVolume_eq :
    calibratedLogVolume =
      localData.unshiftedLogVolume +
        (globalExponent : Real) * localData.localPrimeStepLogVolume

namespace IUTStage1GlobalFrobenioidLogVolumeCalibration

theorem calibratedLogVolume_eq_unshifted
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.calibratedLogVolume = data.localData.unshiftedLogVolume := by
  rw [data.calibrated_logVolume_eq, data.global_exponent_eq_zero]
  simp

theorem calibratedLogVolume_ne_shifted_of_local_nonzero
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration)
    (hExponent : data.localData.localExponent ≠ 0)
    (hStep : data.localData.localPrimeStepLogVolume ≠ 0) :
    data.calibratedLogVolume ≠ data.localData.shiftedLogVolume := by
  intro h
  have hunshifted_eq_shifted :
      data.localData.unshiftedLogVolume = data.localData.shiftedLogVolume := by
    rw [← data.calibratedLogVolume_eq_unshifted]
    exact h
  exact data.localData.shiftedLogVolume_ne_unshifted hExponent hStep
    hunshifted_eq_shifted.symm

theorem calibratedLogVolume_eq_shifted_iff_shiftTerm_eq_zero
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.calibratedLogVolume = data.localData.shiftedLogVolume ↔
      (data.localData.localExponent : Real) *
        data.localData.localPrimeStepLogVolume = 0 := by
  constructor
  · intro h
    have hunshifted_eq_shifted :
        data.localData.unshiftedLogVolume =
          data.localData.shiftedLogVolume := by
      rw [← data.calibratedLogVolume_eq_unshifted]
      exact h
    exact
      data.localData.shiftedLogVolume_eq_unshifted_iff_shiftTerm_eq_zero.mp
        hunshifted_eq_shifted.symm
  · intro hzero
    rw [data.calibratedLogVolume_eq_unshifted]
    exact
      (data.localData.shiftedLogVolume_eq_unshifted_iff_shiftTerm_eq_zero.mpr
        hzero).symm

theorem calibratedLogVolume_eq_shifted_iff_exponent_zero_or_step_zero
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.calibratedLogVolume = data.localData.shiftedLogVolume ↔
      data.localData.localExponent = 0 ∨
        data.localData.localPrimeStepLogVolume = 0 := by
  rw [data.calibratedLogVolume_eq_shifted_iff_shiftTerm_eq_zero,
    data.localData.shiftTerm_eq_zero_iff_exponent_zero_or_step_zero]

theorem calibratedLogVolume_lt_shifted_iff_shiftTerm_pos
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.calibratedLogVolume < data.localData.shiftedLogVolume ↔
      0 < (data.localData.localExponent : Real) *
        data.localData.localPrimeStepLogVolume := by
  rw [data.calibratedLogVolume_eq_unshifted]
  exact data.localData.unshiftedLogVolume_lt_shifted_iff_shiftTerm_pos

theorem shiftedLogVolume_lt_calibrated_iff_shiftTerm_lt_zero
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.localData.shiftedLogVolume < data.calibratedLogVolume ↔
      (data.localData.localExponent : Real) *
        data.localData.localPrimeStepLogVolume < 0 := by
  rw [data.calibratedLogVolume_eq_unshifted]
  exact data.localData.shiftedLogVolume_lt_unshifted_iff_shiftTerm_lt_zero

end IUTStage1GlobalFrobenioidLogVolumeCalibration

/--
Global-to-local restriction for realified Frobenioid prime log-volumes.

IUT I, Example 3.5 identifies the local realified divisor monoid with
`R_{\ge 0}` and states that the restriction functor sends the global prime
element to `1 / [K_v : (F_mod)_v]` times the corresponding local prime element.
This finite record keeps only the degree-normalized log-volume content of that
statement.
-/
structure IUTStage1GlobalToLocalRealifiedFrobenioidRestriction where
  extensionDegree : Nat
  extensionDegree_pos : 0 < extensionDegree
  localPrimeLogVolume : Real
  restrictedGlobalPrimeLogVolume : Real
  restricted_global_prime_eq :
    restrictedGlobalPrimeLogVolume =
      (extensionDegree : Real)⁻¹ * localPrimeLogVolume

namespace IUTStage1GlobalToLocalRealifiedFrobenioidRestriction

theorem extensionDegree_ne_zero
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    (restriction.extensionDegree : Real) ≠ 0 := by
  exact_mod_cast ne_of_gt restriction.extensionDegree_pos

theorem restrictedGlobalPrimeLogVolume_eq
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    restriction.restrictedGlobalPrimeLogVolume =
      (restriction.extensionDegree : Real)⁻¹ *
        restriction.localPrimeLogVolume :=
  restriction.restricted_global_prime_eq

theorem extensionDegree_mul_restrictedGlobalPrimeLogVolume
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    (restriction.extensionDegree : Real) *
        restriction.restrictedGlobalPrimeLogVolume =
      restriction.localPrimeLogVolume := by
  rw [restriction.restrictedGlobalPrimeLogVolume_eq]
  rw [← mul_assoc, mul_inv_cancel₀ restriction.extensionDegree_ne_zero, one_mul]

theorem restrictedGlobalPrimeLogVolume_eq_local_iff_degree_one
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction)
    (hlocal : restriction.localPrimeLogVolume ≠ 0) :
    restriction.restrictedGlobalPrimeLogVolume =
        restriction.localPrimeLogVolume ↔
      (restriction.extensionDegree : Real) = 1 := by
  constructor
  · intro h
    have hdegree_mul :
        (restriction.extensionDegree : Real) *
            restriction.localPrimeLogVolume =
          restriction.localPrimeLogVolume := by
      calc
        (restriction.extensionDegree : Real) *
            restriction.localPrimeLogVolume =
          (restriction.extensionDegree : Real) *
            restriction.restrictedGlobalPrimeLogVolume := by
          rw [h]
        _ = restriction.localPrimeLogVolume :=
          restriction.extensionDegree_mul_restrictedGlobalPrimeLogVolume
    have hmul :
        restriction.localPrimeLogVolume *
            (restriction.extensionDegree : Real) =
          restriction.localPrimeLogVolume * 1 := by
      rw [mul_comm, hdegree_mul, mul_one]
    exact mul_left_cancel₀ hlocal hmul
  · intro h
    rw [restriction.restrictedGlobalPrimeLogVolume_eq, h]
    simp

theorem restriction_endpoint
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    restriction.restrictedGlobalPrimeLogVolume =
        (restriction.extensionDegree : Real)⁻¹ *
          restriction.localPrimeLogVolume ∧
      (restriction.extensionDegree : Real) *
          restriction.restrictedGlobalPrimeLogVolume =
        restriction.localPrimeLogVolume :=
  ⟨restriction.restrictedGlobalPrimeLogVolume_eq,
    restriction.extensionDegree_mul_restrictedGlobalPrimeLogVolume⟩

end IUTStage1GlobalToLocalRealifiedFrobenioidRestriction

/--
Finite local-global realified Frobenioid collection.

IUT III, Remark 3.9.5(ix), describes local-global collections consisting of a
local object at each `v`, a global object in the global realified Frobenioid,
and localization isomorphisms relating the local realifications to the
localized global object.  This record keeps the degree/log-volume shadow of
that structure: each local object is identified with the restricted global
prime log-volume, and the extension degree rescales it back to the global
realified log-volume.
-/
structure IUTStage1LocalGlobalRealifiedFrobenioidCollection
    (V : Type u) [Fintype V] where
  globalObject : IUTStage1RealifiedFrobenioidDegreeObject
  localObject : V -> IUTStage1RealifiedFrobenioidDegreeObject
  localization : V -> IUTStage1GlobalToLocalRealifiedFrobenioidRestriction
  local_realified_eq_restricted :
    ∀ v : V,
      (localObject v).realifiedLogVolume =
        (localization v).restrictedGlobalPrimeLogVolume
  global_realified_eq_localPrime :
    ∀ v : V,
      globalObject.realifiedLogVolume =
        (localization v).localPrimeLogVolume

namespace IUTStage1LocalGlobalRealifiedFrobenioidCollection

variable {V : Type u} [Fintype V]

theorem localRealifiedLogVolume_eq_restricted
    (collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V)
    (v : V) :
    (collection.localObject v).realifiedLogVolume =
      (collection.localization v).restrictedGlobalPrimeLogVolume :=
  collection.local_realified_eq_restricted v

theorem globalRealifiedLogVolume_eq_localPrime
    (collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V)
    (v : V) :
    collection.globalObject.realifiedLogVolume =
      (collection.localization v).localPrimeLogVolume :=
  collection.global_realified_eq_localPrime v

theorem extensionDegree_mul_localRealifiedLogVolume
    (collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V)
    (v : V) :
    ((collection.localization v).extensionDegree : Real) *
        (collection.localObject v).realifiedLogVolume =
      collection.globalObject.realifiedLogVolume := by
  rw [collection.localRealifiedLogVolume_eq_restricted v]
  rw [(collection.localization v).extensionDegree_mul_restrictedGlobalPrimeLogVolume]
  exact (collection.globalRealifiedLogVolume_eq_localPrime v).symm

theorem totalLocalRealifiedLogVolume_eq_totalRestricted
    (collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V) :
    (∑ v : V, (collection.localObject v).realifiedLogVolume) =
      ∑ v : V, (collection.localization v).restrictedGlobalPrimeLogVolume :=
  Finset.sum_congr rfl
    (fun v _ => collection.localRealifiedLogVolume_eq_restricted v)

theorem localGlobalCollection_endpoint
    (collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V) :
    (∀ v : V,
      (collection.localObject v).realifiedLogVolume =
          (collection.localization v).restrictedGlobalPrimeLogVolume ∧
        ((collection.localization v).extensionDegree : Real) *
            (collection.localObject v).realifiedLogVolume =
          collection.globalObject.realifiedLogVolume) ∧
      (∑ v : V, (collection.localObject v).realifiedLogVolume) =
        ∑ v : V, (collection.localization v).restrictedGlobalPrimeLogVolume :=
  ⟨fun v =>
      ⟨collection.localRealifiedLogVolume_eq_restricted v,
        collection.extensionDegree_mul_localRealifiedLogVolume v⟩,
    collection.totalLocalRealifiedLogVolume_eq_totalRestricted⟩

end IUTStage1LocalGlobalRealifiedFrobenioidCollection

/--
Finite local compatibility for the environment/Gaussian evaluation.

IUT II, Corollary 4.6(v), and the subsequent prime-strip formulation identify
the environment and Gaussian global realified Frobenioids by an evaluation
isomorphism compatible with the local monoid isomorphisms at every `v`.  This
finite package connects the divisor-source evaluation above with the
local-global restriction layer: the global objects are the degree projections
of the ordinary environment/Gaussian divisor sources, and the local
restrictions agree pointwise.
-/
structure IUTStage1EnvironmentGaussianLocalEvaluation
    (V : Type u) [Fintype V] where
  evaluation :
    IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation V
  environmentLocal :
    IUTStage1LocalGlobalRealifiedFrobenioidCollection V
  gaussianLocal :
    IUTStage1LocalGlobalRealifiedFrobenioidCollection V
  environment_global_eq :
    environmentLocal.globalObject =
      evaluation.environment.ordinary.toDegreeObject
  gaussian_global_eq :
    gaussianLocal.globalObject =
      evaluation.gaussian.ordinary.toDegreeObject
  local_restriction_eq :
    ∀ v : V,
      gaussianLocal.localization v = environmentLocal.localization v

namespace IUTStage1EnvironmentGaussianLocalEvaluation

variable {V : Type u} [Fintype V]

theorem environmentGlobalLogVolume_eq_ordinary
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V) :
    comparison.environmentLocal.globalObject.realifiedLogVolume =
      comparison.evaluation.environment.ordinary.realifiedLogVolume := by
  rw [comparison.environment_global_eq]
  rfl

theorem gaussianGlobalLogVolume_eq_ordinary
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V) :
    comparison.gaussianLocal.globalObject.realifiedLogVolume =
      comparison.evaluation.gaussian.ordinary.realifiedLogVolume := by
  rw [comparison.gaussian_global_eq]
  rfl

theorem gaussianGlobalLogVolume_eq_environment
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V) :
    comparison.gaussianLocal.globalObject.realifiedLogVolume =
      comparison.environmentLocal.globalObject.realifiedLogVolume := by
  rw [comparison.gaussianGlobalLogVolume_eq_ordinary,
    comparison.environmentGlobalLogVolume_eq_ordinary,
    comparison.evaluation.gaussianOrdinaryLogVolume_eq_environment]

theorem localRestrictedLogVolume_eq_environment
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V)
    (v : V) :
    (comparison.gaussianLocal.localization v).restrictedGlobalPrimeLogVolume =
      (comparison.environmentLocal.localization v).restrictedGlobalPrimeLogVolume := by
  rw [comparison.local_restriction_eq v]

theorem localExtensionDegree_eq_environment
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V)
    (v : V) :
    (comparison.gaussianLocal.localization v).extensionDegree =
      (comparison.environmentLocal.localization v).extensionDegree := by
  rw [comparison.local_restriction_eq v]

theorem gaussianLocalLogVolume_eq_environment
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V)
    (v : V) :
    (comparison.gaussianLocal.localObject v).realifiedLogVolume =
      (comparison.environmentLocal.localObject v).realifiedLogVolume := by
  rw [comparison.gaussianLocal.localRealifiedLogVolume_eq_restricted v,
    comparison.environmentLocal.localRealifiedLogVolume_eq_restricted v,
    comparison.local_restriction_eq v]

theorem endpoint
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V) :
    comparison.gaussianLocal.globalObject.realifiedLogVolume =
        comparison.environmentLocal.globalObject.realifiedLogVolume ∧
      ∀ v : V,
        (comparison.gaussianLocal.localization v).restrictedGlobalPrimeLogVolume =
            (comparison.environmentLocal.localization v).restrictedGlobalPrimeLogVolume ∧
          (comparison.gaussianLocal.localization v).extensionDegree =
            (comparison.environmentLocal.localization v).extensionDegree ∧
          (comparison.gaussianLocal.localObject v).realifiedLogVolume =
            (comparison.environmentLocal.localObject v).realifiedLogVolume :=
  ⟨comparison.gaussianGlobalLogVolume_eq_environment,
    fun v =>
      ⟨comparison.localRestrictedLogVolume_eq_environment v,
        comparison.localExtensionDegree_eq_environment v,
        comparison.gaussianLocalLogVolume_eq_environment v⟩⟩

end IUTStage1EnvironmentGaussianLocalEvaluation

/--
Finite `F`-prime-strip evaluation for the environment/Gaussian comparison.

In the prime-strip formulation following IUT II, Corollary 4.6(v), the
environment and Gaussian realified Frobenioids give rise to `F`-prime-strips
equipped with bijections `Prime(Cenv) ≃ V` and `Prime(Cgau) ≃ V`; the
evaluation isomorphism between the prime-strips is compatible with these
bijections.  This finite record keeps that prime-index skeleton and connects it
to the local log-volume compatibility already proved for the corresponding
environment/Gaussian local evaluation.
-/
structure IUTStage1EnvironmentGaussianFPrimeStripEvaluation
    (Penv Pgau V : Type u) [Fintype Penv] [Fintype Pgau] [Fintype V] where
  localEvaluation : IUTStage1EnvironmentGaussianLocalEvaluation V
  environmentPrimeToPlace : Penv ≃ V
  gaussianPrimeToPlace : Pgau ≃ V
  primeEvaluation : Penv ≃ Pgau
  prime_place_compatible :
    ∀ p : Penv,
      gaussianPrimeToPlace (primeEvaluation p) = environmentPrimeToPlace p

namespace IUTStage1EnvironmentGaussianFPrimeStripEvaluation

variable {Penv Pgau V : Type u} [Fintype Penv] [Fintype Pgau] [Fintype V]

theorem gaussianPlaceOfEvaluation_eq_environmentPlace
    (strip :
      IUTStage1EnvironmentGaussianFPrimeStripEvaluation Penv Pgau V)
    (p : Penv) :
    strip.gaussianPrimeToPlace (strip.primeEvaluation p) =
      strip.environmentPrimeToPlace p :=
  strip.prime_place_compatible p

theorem gaussianRestrictedLogVolume_at_evaluatedPrime_eq_environment
    (strip :
      IUTStage1EnvironmentGaussianFPrimeStripEvaluation Penv Pgau V)
    (p : Penv) :
    (strip.localEvaluation.gaussianLocal.localization
        (strip.gaussianPrimeToPlace (strip.primeEvaluation p))).restrictedGlobalPrimeLogVolume =
      (strip.localEvaluation.environmentLocal.localization
        (strip.environmentPrimeToPlace p)).restrictedGlobalPrimeLogVolume := by
  rw [strip.gaussianPlaceOfEvaluation_eq_environmentPlace p]
  exact
    strip.localEvaluation.localRestrictedLogVolume_eq_environment
      (strip.environmentPrimeToPlace p)

theorem gaussianExtensionDegree_at_evaluatedPrime_eq_environment
    (strip :
      IUTStage1EnvironmentGaussianFPrimeStripEvaluation Penv Pgau V)
    (p : Penv) :
    (strip.localEvaluation.gaussianLocal.localization
        (strip.gaussianPrimeToPlace (strip.primeEvaluation p))).extensionDegree =
      (strip.localEvaluation.environmentLocal.localization
        (strip.environmentPrimeToPlace p)).extensionDegree := by
  rw [strip.gaussianPlaceOfEvaluation_eq_environmentPlace p]
  exact
    strip.localEvaluation.localExtensionDegree_eq_environment
      (strip.environmentPrimeToPlace p)

theorem gaussianLocalLogVolume_at_evaluatedPrime_eq_environment
    (strip :
      IUTStage1EnvironmentGaussianFPrimeStripEvaluation Penv Pgau V)
    (p : Penv) :
    (strip.localEvaluation.gaussianLocal.localObject
        (strip.gaussianPrimeToPlace (strip.primeEvaluation p))).realifiedLogVolume =
      (strip.localEvaluation.environmentLocal.localObject
        (strip.environmentPrimeToPlace p)).realifiedLogVolume := by
  rw [strip.gaussianPlaceOfEvaluation_eq_environmentPlace p]
  exact
    strip.localEvaluation.gaussianLocalLogVolume_eq_environment
      (strip.environmentPrimeToPlace p)

theorem endpoint
    (strip :
      IUTStage1EnvironmentGaussianFPrimeStripEvaluation Penv Pgau V) :
    strip.localEvaluation.gaussianLocal.globalObject.realifiedLogVolume =
        strip.localEvaluation.environmentLocal.globalObject.realifiedLogVolume ∧
      ∀ p : Penv,
        strip.gaussianPrimeToPlace (strip.primeEvaluation p) =
            strip.environmentPrimeToPlace p ∧
          (strip.localEvaluation.gaussianLocal.localization
              (strip.gaussianPrimeToPlace
                (strip.primeEvaluation p))).restrictedGlobalPrimeLogVolume =
            (strip.localEvaluation.environmentLocal.localization
              (strip.environmentPrimeToPlace p)).restrictedGlobalPrimeLogVolume ∧
          (strip.localEvaluation.gaussianLocal.localization
              (strip.gaussianPrimeToPlace
                (strip.primeEvaluation p))).extensionDegree =
            (strip.localEvaluation.environmentLocal.localization
              (strip.environmentPrimeToPlace p)).extensionDegree ∧
          (strip.localEvaluation.gaussianLocal.localObject
              (strip.gaussianPrimeToPlace
                (strip.primeEvaluation p))).realifiedLogVolume =
            (strip.localEvaluation.environmentLocal.localObject
              (strip.environmentPrimeToPlace p)).realifiedLogVolume :=
  ⟨strip.localEvaluation.gaussianGlobalLogVolume_eq_environment,
    fun p =>
      ⟨strip.gaussianPlaceOfEvaluation_eq_environmentPlace p,
        strip.gaussianRestrictedLogVolume_at_evaluatedPrime_eq_environment p,
        strip.gaussianExtensionDegree_at_evaluatedPrime_eq_environment p,
        strip.gaussianLocalLogVolume_at_evaluatedPrime_eq_environment p⟩⟩

end IUTStage1EnvironmentGaussianFPrimeStripEvaluation

/--
Finite `F^{×μ}` lift of the environment/Gaussian prime-strip evaluation.

IUT II, Corollary 4.7(iii), uses the functorial algorithm from
`F`-prime-strips to `F^{×μ}`-prime-strips to obtain the `Θ^{×μ}`- and
Gaussian `Θ^{×μ}`-links.  At the finite level, the new datum is the unit
character attached to prime labels.  The Gaussian unit character is not an
independent field: it is transported from the environment side along the
already encoded prime-strip evaluation equivalence.
-/
structure IUTStage1EnvironmentGaussianThetaMuPrimeStripLift
    (Penv Pgau V : Type u) (μ : Type v)
    [Fintype Penv] [Fintype Pgau] [Fintype V] where
  base : IUTStage1EnvironmentGaussianFPrimeStripEvaluation Penv Pgau V
  environmentUnitCharacter : Penv -> μ

namespace IUTStage1EnvironmentGaussianThetaMuPrimeStripLift

variable {Penv Pgau V : Type u} {μ : Type v}
variable [Fintype Penv] [Fintype Pgau] [Fintype V]

def gaussianUnitCharacter
    (lift :
      IUTStage1EnvironmentGaussianThetaMuPrimeStripLift Penv Pgau V μ) :
    Pgau -> μ :=
  fun q => lift.environmentUnitCharacter (lift.base.primeEvaluation.symm q)

theorem gaussianUnitCharacter_at_evaluatedPrime
    (lift :
      IUTStage1EnvironmentGaussianThetaMuPrimeStripLift Penv Pgau V μ)
    (p : Penv) :
    lift.gaussianUnitCharacter (lift.base.primeEvaluation p) =
      lift.environmentUnitCharacter p := by
  simp [gaussianUnitCharacter]

theorem environmentUnitCharacter_at_inverseEvaluatedPrime
    (lift :
      IUTStage1EnvironmentGaussianThetaMuPrimeStripLift Penv Pgau V μ)
    (q : Pgau) :
    lift.environmentUnitCharacter (lift.base.primeEvaluation.symm q) =
      lift.gaussianUnitCharacter q := by
  rfl

theorem endpoint
    (lift :
      IUTStage1EnvironmentGaussianThetaMuPrimeStripLift Penv Pgau V μ) :
    lift.base.localEvaluation.gaussianLocal.globalObject.realifiedLogVolume =
        lift.base.localEvaluation.environmentLocal.globalObject.realifiedLogVolume ∧
      ∀ p : Penv,
        lift.base.gaussianPrimeToPlace (lift.base.primeEvaluation p) =
            lift.base.environmentPrimeToPlace p ∧
          (lift.base.localEvaluation.gaussianLocal.localObject
              (lift.base.gaussianPrimeToPlace
                (lift.base.primeEvaluation p))).realifiedLogVolume =
            (lift.base.localEvaluation.environmentLocal.localObject
              (lift.base.environmentPrimeToPlace p)).realifiedLogVolume ∧
          lift.gaussianUnitCharacter (lift.base.primeEvaluation p) =
            lift.environmentUnitCharacter p :=
  ⟨lift.base.localEvaluation.gaussianGlobalLogVolume_eq_environment,
    fun p =>
      ⟨lift.base.gaussianPlaceOfEvaluation_eq_environmentPlace p,
        lift.base.gaussianLocalLogVolume_at_evaluatedPrime_eq_environment p,
        lift.gaussianUnitCharacter_at_evaluatedPrime p⟩⟩

end IUTStage1EnvironmentGaussianThetaMuPrimeStripLift

/--
Finite coric invariant for the `F^{⊢×μ}` unit part.

IUT II, Corollary 4.7(iv), states that the coric `F^{⊢×μ}`-prime-strip is an
invariant of both the `Θ^{×μ}`- and Gaussian `Θ^{×μ}`-links.  The finite
shadow records a common unit character indexed by the valuation set `V`.
The environment unit character is required to be the pullback of this coric
character along `Prime(Cenv) ≃ V`; the Gaussian equality is then derived from
transport along the prime-strip evaluation.
-/
structure IUTStage1CoricThetaMuPrimeStripInvariant
    (Penv Pgau V : Type u) (μ : Type v)
    [Fintype Penv] [Fintype Pgau] [Fintype V] where
  lift : IUTStage1EnvironmentGaussianThetaMuPrimeStripLift Penv Pgau V μ
  coricUnitCharacter : V -> μ
  environment_unit_eq_coric :
    ∀ p : Penv,
      lift.environmentUnitCharacter p =
        coricUnitCharacter (lift.base.environmentPrimeToPlace p)

namespace IUTStage1CoricThetaMuPrimeStripInvariant

variable {Penv Pgau V : Type u} {μ : Type v}
variable [Fintype Penv] [Fintype Pgau] [Fintype V]

theorem gaussianUnitCharacter_at_evaluatedPrime_eq_coric
    (invariant :
      IUTStage1CoricThetaMuPrimeStripInvariant Penv Pgau V μ)
    (p : Penv) :
    invariant.lift.gaussianUnitCharacter
        (invariant.lift.base.primeEvaluation p) =
      invariant.coricUnitCharacter
        (invariant.lift.base.gaussianPrimeToPlace
          (invariant.lift.base.primeEvaluation p)) := by
  rw [invariant.lift.gaussianUnitCharacter_at_evaluatedPrime p,
    invariant.environment_unit_eq_coric p,
    invariant.lift.base.gaussianPlaceOfEvaluation_eq_environmentPlace p]

theorem environmentUnitCharacter_eq_gaussianUnitCharacter_at_evaluatedPrime
    (invariant :
      IUTStage1CoricThetaMuPrimeStripInvariant Penv Pgau V μ)
    (p : Penv) :
    invariant.lift.environmentUnitCharacter p =
      invariant.lift.gaussianUnitCharacter
        (invariant.lift.base.primeEvaluation p) := by
  rw [invariant.lift.gaussianUnitCharacter_at_evaluatedPrime p]

theorem endpoint
    (invariant :
      IUTStage1CoricThetaMuPrimeStripInvariant Penv Pgau V μ) :
    ∀ p : Penv,
      invariant.lift.environmentUnitCharacter p =
          invariant.coricUnitCharacter
            (invariant.lift.base.environmentPrimeToPlace p) ∧
        invariant.lift.gaussianUnitCharacter
            (invariant.lift.base.primeEvaluation p) =
          invariant.coricUnitCharacter
            (invariant.lift.base.gaussianPrimeToPlace
              (invariant.lift.base.primeEvaluation p)) ∧
        invariant.lift.environmentUnitCharacter p =
          invariant.lift.gaussianUnitCharacter
            (invariant.lift.base.primeEvaluation p) :=
  fun p =>
    ⟨invariant.environment_unit_eq_coric p,
      invariant.gaussianUnitCharacter_at_evaluatedPrime_eq_coric p,
      invariant.environmentUnitCharacter_eq_gaussianUnitCharacter_at_evaluatedPrime p⟩

end IUTStage1CoricThetaMuPrimeStripInvariant

/--
Finite coric global realified Frobenioid compatibility.

IUT II, Corollary 4.7(v), passes from the coric `D^{⊢}`-link to an
isomorphism of global realified Frobenioid data, compatible with the
`R_{>0}`-orbits obtained by multiplying arithmetic degrees.  Since the present
finite layer records only realified degree/log-volume data, the orbit relation
is represented by a positive real scale.  The target local restrictions are
required to be the scaled source restrictions; the local object and local-prime
equalities are then derived from the existing local-global collection laws.
-/
structure IUTStage1CoricGlobalRealifiedFrobenioidCompatibility
    (V : Type u) [Fintype V] where
  source : IUTStage1LocalGlobalRealifiedFrobenioidCollection V
  target : IUTStage1LocalGlobalRealifiedFrobenioidCollection V
  scale : Real
  scale_pos : 0 < scale
  global_realified_eq_scale :
    target.globalObject.realifiedLogVolume =
      scale * source.globalObject.realifiedLogVolume
  local_restriction_eq_scale :
    ∀ v : V,
      (target.localization v).restrictedGlobalPrimeLogVolume =
        scale * (source.localization v).restrictedGlobalPrimeLogVolume

namespace IUTStage1CoricGlobalRealifiedFrobenioidCompatibility

variable {V : Type u} [Fintype V]

theorem scale_ne_zero
    (compat :
      IUTStage1CoricGlobalRealifiedFrobenioidCompatibility V) :
    compat.scale ≠ 0 :=
  ne_of_gt compat.scale_pos

theorem localObjectLogVolume_eq_scale
    (compat :
      IUTStage1CoricGlobalRealifiedFrobenioidCompatibility V)
    (v : V) :
    (compat.target.localObject v).realifiedLogVolume =
      compat.scale * (compat.source.localObject v).realifiedLogVolume := by
  rw [compat.target.localRealifiedLogVolume_eq_restricted v,
    compat.source.localRealifiedLogVolume_eq_restricted v,
    compat.local_restriction_eq_scale v]

theorem localPrimeLogVolume_eq_scale
    (compat :
      IUTStage1CoricGlobalRealifiedFrobenioidCompatibility V)
    (v : V) :
    (compat.target.localization v).localPrimeLogVolume =
      compat.scale * (compat.source.localization v).localPrimeLogVolume := by
  rw [← compat.target.globalRealifiedLogVolume_eq_localPrime v,
    ← compat.source.globalRealifiedLogVolume_eq_localPrime v,
    compat.global_realified_eq_scale]

theorem extensionDegree_rescaled_localObject
    (compat :
      IUTStage1CoricGlobalRealifiedFrobenioidCompatibility V)
    (v : V) :
    ((compat.target.localization v).extensionDegree : Real) *
        (compat.scale * (compat.source.localObject v).realifiedLogVolume) =
      compat.scale * compat.source.globalObject.realifiedLogVolume := by
  rw [← compat.localObjectLogVolume_eq_scale v,
    compat.target.extensionDegree_mul_localRealifiedLogVolume v,
    compat.global_realified_eq_scale]

theorem endpoint
    (compat :
      IUTStage1CoricGlobalRealifiedFrobenioidCompatibility V) :
    0 < compat.scale ∧
      compat.target.globalObject.realifiedLogVolume =
        compat.scale * compat.source.globalObject.realifiedLogVolume ∧
      ∀ v : V,
        (compat.target.localization v).restrictedGlobalPrimeLogVolume =
            compat.scale *
              (compat.source.localization v).restrictedGlobalPrimeLogVolume ∧
          (compat.target.localObject v).realifiedLogVolume =
            compat.scale * (compat.source.localObject v).realifiedLogVolume ∧
          (compat.target.localization v).localPrimeLogVolume =
            compat.scale * (compat.source.localization v).localPrimeLogVolume ∧
          ((compat.target.localization v).extensionDegree : Real) *
              (compat.scale * (compat.source.localObject v).realifiedLogVolume) =
            compat.scale * compat.source.globalObject.realifiedLogVolume :=
  ⟨compat.scale_pos,
    compat.global_realified_eq_scale,
    fun v =>
      ⟨compat.local_restriction_eq_scale v,
        compat.localObjectLogVolume_eq_scale v,
        compat.localPrimeLogVolume_eq_scale v,
        compat.extensionDegree_rescaled_localObject v⟩⟩

end IUTStage1CoricGlobalRealifiedFrobenioidCompatibility

namespace IUTStage1FrobeniusPictureChain

/-!
Finite graph shadow of the Frobenius-pictures of IUT II, Corollary 4.7(vi).

The source paper represents the infinite chain of linked Hodge theaters by the
oriented graph `... → • → • → • → ...`, indexed by `ℤ`.  The graph has the
translation action of `ℤ`, but not arbitrary permutation symmetries; in
particular, an adjacent transposition is not an automorphism of the oriented
graph.  This finite formalization keeps exactly that order-theoretic content.
-/

def edge (source target : Int) : Prop :=
  target = source + 1

def translate (shift : Int) (vertex : Int) : Int :=
  vertex + shift

theorem translate_edge_iff
    (shift source target : Int) :
    edge source target ↔
      edge (translate shift source) (translate shift target) := by
  unfold edge translate
  constructor <;> intro h <;> omega

theorem translate_preserves_edge
    (shift source target : Int)
    (h : edge source target) :
    edge (translate shift source) (translate shift target) :=
  (translate_edge_iff shift source target).mp h

theorem adjacent_swap_not_edge_preserving
    (map : Int -> Int)
    (hzero : map 0 = 1)
    (hone : map 1 = 0) :
    ¬ ∀ source target : Int, edge source target -> edge (map source) (map target) := by
  intro hpreserves
  have h01 : edge 0 1 := by
    unfold edge
    norm_num
  have hbad := hpreserves 0 1 h01
  unfold edge at hbad
  rw [hzero, hone] at hbad
  omega

theorem adjacent_swap_not_automorphism
    (equiv : Int ≃ Int)
    (hzero : equiv 0 = 1)
    (hone : equiv 1 = 0) :
    ¬ ∀ source target : Int,
      edge source target ↔ edge (equiv source) (equiv target) := by
  intro hauto
  exact adjacent_swap_not_edge_preserving
    (fun n => equiv n) hzero hone
    (fun source target hedge => (hauto source target).mp hedge)

theorem endpoint
    (shift : Int) :
    (∀ source target : Int,
        edge source target ↔
          edge (translate shift source) (translate shift target)) ∧
      (∀ map : Int -> Int,
        map 0 = 1 ->
          map 1 = 0 ->
            ¬ ∀ source target : Int,
              edge source target -> edge (map source) (map target)) :=
  ⟨fun source target => translate_edge_iff shift source target,
    fun map hzero hone =>
      adjacent_swap_not_edge_preserving map hzero hone⟩

end IUTStage1FrobeniusPictureChain

/--
Finite `D^{⊢}` core of the etale-picture of IUT II, Corollary 4.11.

Corollary 4.11(i) says that the associated `D^{⊢}`-prime-strip is a constant
mono-analytic core of the infinite chain.  Corollary 4.11(ii) then regards the
various integer-labelled theaters as spokes emanating from this common core,
with arbitrary permutation symmetries among the spokes.  This record separates
the spoke data from its mono-analytic `D`-core projection and requires every
projection to be the same common core.
-/
structure IUTStage1EtalePictureDCore
    (Core Spoke : Type u) where
  core : Core
  spoke : Int -> Spoke
  spokeCore : Int -> Core
  spoke_core_eq : ∀ n : Int, spokeCore n = core

namespace IUTStage1EtalePictureDCore

variable {Core Spoke : Type u}

theorem successor_spokeCore_eq
    (picture : IUTStage1EtalePictureDCore Core Spoke)
    (n : Int) :
    picture.spokeCore (n + 1) = picture.spokeCore n := by
  rw [picture.spoke_core_eq (n + 1), picture.spoke_core_eq n]

theorem permuted_spokeCore_eq_core
    (picture : IUTStage1EtalePictureDCore Core Spoke)
    (perm : Int ≃ Int)
    (n : Int) :
    picture.spokeCore (perm n) = picture.core :=
  picture.spoke_core_eq (perm n)

theorem permuted_spokeCore_eq_original
    (picture : IUTStage1EtalePictureDCore Core Spoke)
    (perm : Int ≃ Int)
    (n : Int) :
    picture.spokeCore (perm n) = picture.spokeCore n := by
  rw [picture.permuted_spokeCore_eq_core perm n, picture.spoke_core_eq n]

theorem endpoint
    (picture : IUTStage1EtalePictureDCore Core Spoke) :
    (∀ n : Int, picture.spokeCore (n + 1) = picture.spokeCore n) ∧
      ∀ perm : Int ≃ Int,
        ∀ n : Int,
          picture.spokeCore (perm n) = picture.core ∧
            picture.spokeCore (perm n) = picture.spokeCore n :=
  ⟨fun n => picture.successor_spokeCore_eq n,
    fun perm n =>
      ⟨picture.permuted_spokeCore_eq_core perm n,
        picture.permuted_spokeCore_eq_original perm n⟩⟩

end IUTStage1EtalePictureDCore

/--
Local-global collection equipped with structure morphisms to the global object.

Remark 3.9.5(ix), (cQ3), describes local Frobenioid objects equipped with
structure poly-morphisms to the determinant object arising from the hull.  This
finite version attaches, for every local index `v`, a degree/log-volume
morphism from the local object to the global object of the local-global
collection.
-/
structure IUTStage1LocalGlobalFrobenioidStructureMorphismCollection
    (V : Type u) [Fintype V] where
  collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V
  structureMorphism :
    ∀ v : V,
      IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism
        (collection.localObject v) collection.globalObject

namespace IUTStage1LocalGlobalFrobenioidStructureMorphismCollection

variable {V : Type u} [Fintype V]

theorem structureMorphism_realifiedLogVolume
    (source :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V)
    (v : V) :
    source.collection.globalObject.realifiedLogVolume =
      (source.collection.localObject v).realifiedLogVolume +
        (((source.structureMorphism v).divisorDegreeShift : Int) : Real) +
        (source.structureMorphism v).unitLogVolumeShift :=
  (source.structureMorphism v).target_realifiedLogVolume_eq_source_plus_shifts

theorem structureMorphism_shift_eq_localization_rescaling
    (source :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V)
    (v : V) :
    (((source.structureMorphism v).divisorDegreeShift : Int) : Real) +
        (source.structureMorphism v).unitLogVolumeShift =
      (((source.collection.localization v).extensionDegree : Real) - 1) *
        (source.collection.localObject v).realifiedLogVolume := by
  have h_morphism := source.structureMorphism_realifiedLogVolume v
  have h_localization :=
    source.collection.extensionDegree_mul_localRealifiedLogVolume v
  have h_shift :
      (((source.structureMorphism v).divisorDegreeShift : Int) : Real) +
          (source.structureMorphism v).unitLogVolumeShift =
        source.collection.globalObject.realifiedLogVolume -
          (source.collection.localObject v).realifiedLogVolume := by
    linarith
  have h_rescale :
      (((source.collection.localization v).extensionDegree : Real) - 1) *
          (source.collection.localObject v).realifiedLogVolume =
        source.collection.globalObject.realifiedLogVolume -
          (source.collection.localObject v).realifiedLogVolume := by
    rw [sub_mul, one_mul, h_localization]
  exact h_shift.trans h_rescale.symm

theorem structureMorphism_endpoint
    (source :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V) :
    ∀ v : V,
      source.collection.globalObject.realifiedLogVolume =
          (source.collection.localObject v).realifiedLogVolume +
            (((source.structureMorphism v).divisorDegreeShift : Int) : Real) +
            (source.structureMorphism v).unitLogVolumeShift ∧
        (((source.structureMorphism v).divisorDegreeShift : Int) : Real) +
            (source.structureMorphism v).unitLogVolumeShift =
          (((source.collection.localization v).extensionDegree : Real) - 1) *
            (source.collection.localObject v).realifiedLogVolume :=
  fun v =>
    ⟨source.structureMorphism_realifiedLogVolume v,
      source.structureMorphism_shift_eq_localization_rescaling v⟩

end IUTStage1LocalGlobalFrobenioidStructureMorphismCollection

/--
Finite morphism between local-global structure-morphism collections.

This is the degree/log-volume shadow of Remark 3.9.5(ix), (cQ3), item (lc2):
morphisms between local Frobenioid objects are compatible with the structure
poly-morphisms to the determinant object.  Compatibility is expressed by
equality of the composed local-then-structure morphism and
structure-then-global morphism shifts.
-/
structure IUTStage1LocalGlobalFrobenioidCompatibleMorphism
    {V : Type u} [Fintype V]
    (source target :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V) where
  globalMorphism :
    IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism
      source.collection.globalObject target.collection.globalObject
  localMorphism :
    ∀ v : V,
      IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism
        (source.collection.localObject v) (target.collection.localObject v)
  compatible_divisorShift :
    ∀ v : V,
      ((localMorphism v).comp (target.structureMorphism v)).divisorDegreeShift =
        ((source.structureMorphism v).comp globalMorphism).divisorDegreeShift
  compatible_unitShift :
    ∀ v : V,
      ((localMorphism v).comp (target.structureMorphism v)).unitLogVolumeShift =
        ((source.structureMorphism v).comp globalMorphism).unitLogVolumeShift

namespace IUTStage1LocalGlobalFrobenioidCompatibleMorphism

variable {V : Type u} [Fintype V]
variable
  {source target :
    IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V}

theorem local_then_structure_realifiedLogVolume
    (morphism :
      IUTStage1LocalGlobalFrobenioidCompatibleMorphism source target)
    (v : V) :
    target.collection.globalObject.realifiedLogVolume =
      (source.collection.localObject v).realifiedLogVolume +
        ((((morphism.localMorphism v).comp
          (target.structureMorphism v)).divisorDegreeShift : Int) : Real) +
        ((morphism.localMorphism v).comp
          (target.structureMorphism v)).unitLogVolumeShift :=
  ((morphism.localMorphism v).comp
    (target.structureMorphism v)).target_realifiedLogVolume_eq_source_plus_shifts

theorem structure_then_global_realifiedLogVolume
    (morphism :
      IUTStage1LocalGlobalFrobenioidCompatibleMorphism source target)
    (v : V) :
    target.collection.globalObject.realifiedLogVolume =
      (source.collection.localObject v).realifiedLogVolume +
        ((((source.structureMorphism v).comp
          morphism.globalMorphism).divisorDegreeShift : Int) : Real) +
        ((source.structureMorphism v).comp
          morphism.globalMorphism).unitLogVolumeShift :=
  ((source.structureMorphism v).comp
    morphism.globalMorphism).target_realifiedLogVolume_eq_source_plus_shifts

theorem compatible_totalShift
    (morphism :
      IUTStage1LocalGlobalFrobenioidCompatibleMorphism source target)
    (v : V) :
    ((((morphism.localMorphism v).comp
          (target.structureMorphism v)).divisorDegreeShift : Int) : Real) +
        ((morphism.localMorphism v).comp
          (target.structureMorphism v)).unitLogVolumeShift =
      ((((source.structureMorphism v).comp
          morphism.globalMorphism).divisorDegreeShift : Int) : Real) +
        ((source.structureMorphism v).comp
          morphism.globalMorphism).unitLogVolumeShift := by
  rw [morphism.compatible_divisorShift v, morphism.compatible_unitShift v]

theorem compatibleMorphism_endpoint
    (morphism :
      IUTStage1LocalGlobalFrobenioidCompatibleMorphism source target) :
    ∀ v : V,
      target.collection.globalObject.realifiedLogVolume =
          (source.collection.localObject v).realifiedLogVolume +
            ((((morphism.localMorphism v).comp
              (target.structureMorphism v)).divisorDegreeShift : Int) : Real) +
            ((morphism.localMorphism v).comp
              (target.structureMorphism v)).unitLogVolumeShift ∧
        target.collection.globalObject.realifiedLogVolume =
          (source.collection.localObject v).realifiedLogVolume +
            ((((source.structureMorphism v).comp
              morphism.globalMorphism).divisorDegreeShift : Int) : Real) +
            ((source.structureMorphism v).comp
              morphism.globalMorphism).unitLogVolumeShift ∧
        ((((morphism.localMorphism v).comp
              (target.structureMorphism v)).divisorDegreeShift : Int) : Real) +
            ((morphism.localMorphism v).comp
              (target.structureMorphism v)).unitLogVolumeShift =
          ((((source.structureMorphism v).comp
              morphism.globalMorphism).divisorDegreeShift : Int) : Real) +
            ((source.structureMorphism v).comp
              morphism.globalMorphism).unitLogVolumeShift :=
  fun v =>
    ⟨morphism.local_then_structure_realifiedLogVolume v,
      morphism.structure_then_global_realifiedLogVolume v,
      morphism.compatible_totalShift v⟩

end IUTStage1LocalGlobalFrobenioidCompatibleMorphism

/--
Local `p_v^N` Frobenioid source normalized by the global realified restriction.

This connects the Step (xii) local shift model to the source-backed restriction
factor of Example 3.5: the local prime step used in the shift is not an
unrelated real number, but the restricted global prime log-volume.
-/
structure IUTStage1RestrictionNormalizedLocalFrobenioidSource where
  localSource : IUTStage1LocalFrobenioidPVPowerLogVolumeSource
  restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction
  localPrimeStep_eq_restricted :
    localSource.localPrimeStepLogVolume =
      restriction.restrictedGlobalPrimeLogVolume

namespace IUTStage1RestrictionNormalizedLocalFrobenioidSource

theorem shiftedLogVolume_eq_restricted
    (source : IUTStage1RestrictionNormalizedLocalFrobenioidSource) :
    source.localSource.shiftedLogVolume =
      source.localSource.baseSubmodule.logVolume +
        (source.localSource.localExponent : Real) *
          source.restriction.restrictedGlobalPrimeLogVolume := by
  rw [source.localSource.shiftedLogVolume_eq,
    source.localPrimeStep_eq_restricted]

theorem extensionDegree_mul_localPrimeStep
    (source : IUTStage1RestrictionNormalizedLocalFrobenioidSource) :
    (source.restriction.extensionDegree : Real) *
        source.localSource.localPrimeStepLogVolume =
      source.restriction.localPrimeLogVolume := by
  rw [source.localPrimeStep_eq_restricted]
  exact source.restriction.extensionDegree_mul_restrictedGlobalPrimeLogVolume

theorem shiftedLogVolume_eq_base_iff_automorphism_or_restricted_zero
    (source : IUTStage1RestrictionNormalizedLocalFrobenioidSource) :
    source.localSource.shiftedLogVolume =
        source.localSource.baseSubmodule.logVolume ↔
      source.localSource.pPowerEndomorphismIsAutomorphism ∨
        source.restriction.restrictedGlobalPrimeLogVolume = 0 := by
  rw [source.localSource.shiftedLogVolume_eq_base_iff_automorphism_or_zero_step,
    source.localPrimeStep_eq_restricted]

theorem restrictionNormalizedLocalSource_endpoint
    (source : IUTStage1RestrictionNormalizedLocalFrobenioidSource) :
    source.localSource.shiftedLogVolume =
        source.localSource.baseSubmodule.logVolume +
          (source.localSource.localExponent : Real) *
            source.restriction.restrictedGlobalPrimeLogVolume ∧
      (source.restriction.extensionDegree : Real) *
          source.localSource.localPrimeStepLogVolume =
        source.restriction.localPrimeLogVolume ∧
      (source.localSource.shiftedLogVolume =
          source.localSource.baseSubmodule.logVolume ↔
        source.localSource.pPowerEndomorphismIsAutomorphism ∨
          source.restriction.restrictedGlobalPrimeLogVolume = 0) :=
  ⟨source.shiftedLogVolume_eq_restricted,
    source.extensionDegree_mul_localPrimeStep,
    source.shiftedLogVolume_eq_base_iff_automorphism_or_restricted_zero⟩

end IUTStage1RestrictionNormalizedLocalFrobenioidSource

/--
Finite realified Frobenioid distribution over a label/index set.

IUT I, Example 5.1 and Remark 5.1.1 distinguish the diagonal Frobenioid
`F_{\langle J\rangle}` from the product of underlying categories `F_J`: the
former corresponds to divisors whose dependence on `j ∈ J` is constant, while
the latter allows arbitrary distributions.  This finite record keeps the
realified log-volume component of that distinction.
-/
structure IUTStage1RealifiedFrobenioidIndexDistribution
    (J : Type u) [Fintype J] where
  logVolume : J -> Real

namespace IUTStage1RealifiedFrobenioidIndexDistribution

variable {J : Type u} [Fintype J]

def constant (value : Real) :
    IUTStage1RealifiedFrobenioidIndexDistribution J :=
  { logVolume := fun _ => value }

def isConstantWith
    (distribution : IUTStage1RealifiedFrobenioidIndexDistribution J)
    (value : Real) : Prop :=
  ∀ j : J, distribution.logVolume j = value

def fromRestriction
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    IUTStage1RealifiedFrobenioidIndexDistribution J :=
  constant restriction.restrictedGlobalPrimeLogVolume

theorem constant_isConstantWith
    (value : Real) :
    (constant (J := J) value).isConstantWith value :=
  fun _ => rfl

theorem fromRestriction_isConstantWith
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    (fromRestriction (J := J) restriction).isConstantWith
      restriction.restrictedGlobalPrimeLogVolume :=
  constant_isConstantWith restriction.restrictedGlobalPrimeLogVolume

def totalLogVolume
    (distribution : IUTStage1RealifiedFrobenioidIndexDistribution J) :
    Real :=
  Finset.univ.sum distribution.logVolume

theorem totalLogVolume_eq_card_mul_of_constant
    (distribution : IUTStage1RealifiedFrobenioidIndexDistribution J)
    {value : Real}
    (hconstant : distribution.isConstantWith value) :
    distribution.totalLogVolume = (Fintype.card J : Real) * value := by
  classical
  unfold totalLogVolume
  calc
    Finset.univ.sum distribution.logVolume =
        Finset.univ.sum (fun _ : J => value) := by
      apply Finset.sum_congr rfl
      intro j _hj
      exact hconstant j
    _ = (Fintype.card J : Real) * value := by
      simp [Finset.sum_const, nsmul_eq_mul]

theorem fromRestriction_totalLogVolume
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    (fromRestriction (J := J) restriction).totalLogVolume =
      (Fintype.card J : Real) *
        restriction.restrictedGlobalPrimeLogVolume :=
  totalLogVolume_eq_card_mul_of_constant
    (fromRestriction (J := J) restriction)
    (fromRestriction_isConstantWith restriction)

theorem extensionDegree_mul_fromRestriction_totalLogVolume
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    (restriction.extensionDegree : Real) *
        (fromRestriction (J := J) restriction).totalLogVolume =
      (Fintype.card J : Real) * restriction.localPrimeLogVolume := by
  rw [fromRestriction_totalLogVolume]
  calc
    (restriction.extensionDegree : Real) *
        ((Fintype.card J : Real) *
          restriction.restrictedGlobalPrimeLogVolume) =
      (Fintype.card J : Real) *
        ((restriction.extensionDegree : Real) *
          restriction.restrictedGlobalPrimeLogVolume) := by
      ring
    _ = (Fintype.card J : Real) * restriction.localPrimeLogVolume := by
      rw [restriction.extensionDegree_mul_restrictedGlobalPrimeLogVolume]

theorem not_constantWith_of_pair_ne
    (distribution : IUTStage1RealifiedFrobenioidIndexDistribution J)
    {left right : J}
    (hneq : distribution.logVolume left ≠ distribution.logVolume right) :
    ¬ ∃ value : Real, distribution.isConstantWith value := by
  rintro ⟨value, hconstant⟩
  exact hneq (by rw [hconstant left, hconstant right])

theorem constant_distribution_endpoint
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    (fromRestriction (J := J) restriction).isConstantWith
        restriction.restrictedGlobalPrimeLogVolume ∧
      (fromRestriction (J := J) restriction).totalLogVolume =
        (Fintype.card J : Real) *
          restriction.restrictedGlobalPrimeLogVolume ∧
      (restriction.extensionDegree : Real) *
          (fromRestriction (J := J) restriction).totalLogVolume =
        (Fintype.card J : Real) * restriction.localPrimeLogVolume :=
  ⟨fromRestriction_isConstantWith restriction,
    fromRestriction_totalLogVolume restriction,
    extensionDegree_mul_fromRestriction_totalLogVolume restriction⟩

end IUTStage1RealifiedFrobenioidIndexDistribution

/--
Finite pivotal realified Frobenioid distribution.

IUT I, Example 5.4(vii) calls the `j = 1` restriction object a pivotal
distribution.  Remark 5.4.2 then distinguishes the averaged interpretation of
log-volumes from the summed interpretation, differing by the cardinality of
the index set.  This finite model records a chosen pivotal index and a
diagonal distribution whose common value is read at that index.
-/
structure IUTStage1PivotalRealifiedFrobenioidDistribution
    (J : Type u) [Fintype J] where
  pivot : J
  distribution : IUTStage1RealifiedFrobenioidIndexDistribution J
  pivotalLogVolume : Real
  pivotal_logVolume_eq : distribution.logVolume pivot = pivotalLogVolume
  diagonal_is_constant : distribution.isConstantWith pivotalLogVolume

namespace IUTStage1PivotalRealifiedFrobenioidDistribution

variable {J : Type u} [Fintype J]

def totalLogVolume
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) : Real :=
  source.distribution.totalLogVolume

noncomputable def averagedLogVolume
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) : Real :=
  (Fintype.card J : Real)⁻¹ * source.totalLogVolume

theorem card_ne_zero
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) :
    (Fintype.card J : Real) ≠ 0 := by
  have hcard_pos : 0 < Fintype.card J :=
    Fintype.card_pos_iff.mpr ⟨source.pivot⟩
  exact_mod_cast ne_of_gt hcard_pos

theorem totalLogVolume_eq_card_mul_pivotal
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) :
    source.totalLogVolume =
      (Fintype.card J : Real) * source.pivotalLogVolume :=
  IUTStage1RealifiedFrobenioidIndexDistribution.totalLogVolume_eq_card_mul_of_constant
      source.distribution source.diagonal_is_constant

theorem averagedLogVolume_eq_pivotal
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) :
    source.averagedLogVolume = source.pivotalLogVolume := by
  rw [averagedLogVolume, source.totalLogVolume_eq_card_mul_pivotal]
  rw [← mul_assoc, inv_mul_cancel₀ source.card_ne_zero, one_mul]

theorem totalLogVolume_eq_card_mul_average
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) :
    source.totalLogVolume =
      (Fintype.card J : Real) * source.averagedLogVolume := by
  rw [source.averagedLogVolume_eq_pivotal,
    source.totalLogVolume_eq_card_mul_pivotal]

theorem pivotalDistribution_endpoint
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) :
    source.distribution.logVolume source.pivot = source.pivotalLogVolume ∧
      source.totalLogVolume =
        (Fintype.card J : Real) * source.pivotalLogVolume ∧
      source.averagedLogVolume = source.pivotalLogVolume ∧
      source.totalLogVolume =
        (Fintype.card J : Real) * source.averagedLogVolume :=
  ⟨source.pivotal_logVolume_eq,
    source.totalLogVolume_eq_card_mul_pivotal,
    source.averagedLogVolume_eq_pivotal,
    source.totalLogVolume_eq_card_mul_average⟩

end IUTStage1PivotalRealifiedFrobenioidDistribution

/-- Log-volume convention for the finite NF-bridge model. -/
inductive IUTStage1NFBridgeLogVolumeMode where
  | summed
  | averaged
deriving DecidableEq, Repr

/--
Finite log-volume shadow of the NF-bridge of IUT I, Definition 5.5.

The actual definition consists of a capsule of F-prime-strips, two global
Frobenioid categories, and a poly-morphism lifting a D-NF-bridge.  At the
present finite realified level we record the capsule distribution and the
choice, emphasized in Remark 5.4.2, between the summed and averaged
log-volume readings.
-/
structure IUTStage1NFBridgeRealifiedLogVolume
    (J : Type u) [Fintype J] where
  indexWitness : J
  capsuleDistribution : IUTStage1RealifiedFrobenioidIndexDistribution J
  mode : IUTStage1NFBridgeLogVolumeMode
  targetLogVolume : Real
  target_logVolume_eq :
    targetLogVolume =
      match mode with
      | IUTStage1NFBridgeLogVolumeMode.summed =>
          capsuleDistribution.totalLogVolume
      | IUTStage1NFBridgeLogVolumeMode.averaged =>
          (Fintype.card J : Real)⁻¹ * capsuleDistribution.totalLogVolume

namespace IUTStage1NFBridgeRealifiedLogVolume

variable {J : Type u} [Fintype J]

noncomputable def expectedTargetLogVolume
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J) : Real :=
  match bridge.mode with
  | IUTStage1NFBridgeLogVolumeMode.summed =>
      bridge.capsuleDistribution.totalLogVolume
  | IUTStage1NFBridgeLogVolumeMode.averaged =>
      (Fintype.card J : Real)⁻¹ * bridge.capsuleDistribution.totalLogVolume

theorem targetLogVolume_eq_expected
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J) :
    bridge.targetLogVolume = bridge.expectedTargetLogVolume := by
  unfold expectedTargetLogVolume
  exact bridge.target_logVolume_eq

theorem card_ne_zero
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J) :
    (Fintype.card J : Real) ≠ 0 := by
  have hcard_pos : 0 < Fintype.card J :=
    Fintype.card_pos_iff.mpr ⟨bridge.indexWitness⟩
  exact_mod_cast ne_of_gt hcard_pos

theorem targetLogVolume_eq_total_of_summed
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (hmode : bridge.mode = IUTStage1NFBridgeLogVolumeMode.summed) :
    bridge.targetLogVolume =
      bridge.capsuleDistribution.totalLogVolume := by
  rw [bridge.targetLogVolume_eq_expected, expectedTargetLogVolume, hmode]

theorem targetLogVolume_eq_average_of_averaged
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (hmode : bridge.mode = IUTStage1NFBridgeLogVolumeMode.averaged) :
    bridge.targetLogVolume =
      (Fintype.card J : Real)⁻¹ *
        bridge.capsuleDistribution.totalLogVolume := by
  rw [bridge.targetLogVolume_eq_expected, expectedTargetLogVolume, hmode]

theorem card_mul_targetLogVolume_eq_total_of_averaged
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (hmode : bridge.mode = IUTStage1NFBridgeLogVolumeMode.averaged) :
    (Fintype.card J : Real) * bridge.targetLogVolume =
      bridge.capsuleDistribution.totalLogVolume := by
  rw [bridge.targetLogVolume_eq_average_of_averaged hmode]
  rw [← mul_assoc, mul_inv_cancel₀ bridge.card_ne_zero, one_mul]

theorem summedTarget_eq_card_mul_averagedTarget
    (summed averaged : IUTStage1NFBridgeRealifiedLogVolume J)
    (hsummed : summed.mode = IUTStage1NFBridgeLogVolumeMode.summed)
    (haveraged : averaged.mode = IUTStage1NFBridgeLogVolumeMode.averaged)
    (hcapsule :
      summed.capsuleDistribution = averaged.capsuleDistribution) :
    summed.targetLogVolume =
      (Fintype.card J : Real) * averaged.targetLogVolume := by
  rw [summed.targetLogVolume_eq_total_of_summed hsummed]
  rw [averaged.card_mul_targetLogVolume_eq_total_of_averaged haveraged]
  rw [hcapsule]

theorem pivotal_summedTarget_eq_card_mul_pivotal
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (pivotal : IUTStage1PivotalRealifiedFrobenioidDistribution J)
    (hmode : bridge.mode = IUTStage1NFBridgeLogVolumeMode.summed)
    (hcapsule : bridge.capsuleDistribution = pivotal.distribution) :
    bridge.targetLogVolume =
      (Fintype.card J : Real) * pivotal.pivotalLogVolume := by
  rw [bridge.targetLogVolume_eq_total_of_summed hmode, hcapsule]
  exact pivotal.totalLogVolume_eq_card_mul_pivotal

theorem pivotal_averagedTarget_eq_pivotal
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (pivotal : IUTStage1PivotalRealifiedFrobenioidDistribution J)
    (hmode : bridge.mode = IUTStage1NFBridgeLogVolumeMode.averaged)
    (hcapsule : bridge.capsuleDistribution = pivotal.distribution) :
    bridge.targetLogVolume = pivotal.pivotalLogVolume := by
  rw [bridge.targetLogVolume_eq_average_of_averaged hmode, hcapsule]
  exact pivotal.averagedLogVolume_eq_pivotal

theorem nfBridgeModeComparison_endpoint
    (summed averaged : IUTStage1NFBridgeRealifiedLogVolume J)
    (hsummed : summed.mode = IUTStage1NFBridgeLogVolumeMode.summed)
    (haveraged : averaged.mode = IUTStage1NFBridgeLogVolumeMode.averaged)
    (hcapsule :
      summed.capsuleDistribution = averaged.capsuleDistribution) :
    summed.targetLogVolume =
        summed.capsuleDistribution.totalLogVolume ∧
      (Fintype.card J : Real) * averaged.targetLogVolume =
        averaged.capsuleDistribution.totalLogVolume ∧
      summed.targetLogVolume =
        (Fintype.card J : Real) * averaged.targetLogVolume :=
  ⟨summed.targetLogVolume_eq_total_of_summed hsummed,
    averaged.card_mul_targetLogVolume_eq_total_of_averaged haveraged,
    summed.summedTarget_eq_card_mul_averagedTarget averaged hsummed
      haveraged hcapsule⟩

end IUTStage1NFBridgeRealifiedLogVolume

/--
Finite log-volume shadow of the Θ-bridge of IUT I, Definition 5.5(ii).

The full object contains a Θ-Hodge theater and a tautologically associated
F-prime-strip.  Here we record only the capsule distribution and the target
log-volume read on the Θ-side F-prime-strip.
-/
structure IUTStage1ThetaBridgeRealifiedLogVolume
    (J : Type u) [Fintype J] where
  indexWitness : J
  theater : QualitativeData.HodgeTheaterId
  capsuleDistribution : IUTStage1RealifiedFrobenioidIndexDistribution J
  thetaTargetLogVolume : Real
  theta_target_eq_total :
    thetaTargetLogVolume = capsuleDistribution.totalLogVolume

namespace IUTStage1ThetaBridgeRealifiedLogVolume

variable {J : Type u} [Fintype J]

theorem thetaTargetLogVolume_eq_total
    (bridge : IUTStage1ThetaBridgeRealifiedLogVolume J) :
    bridge.thetaTargetLogVolume =
      bridge.capsuleDistribution.totalLogVolume :=
  bridge.theta_target_eq_total

theorem card_ne_zero
    (bridge : IUTStage1ThetaBridgeRealifiedLogVolume J) :
    (Fintype.card J : Real) ≠ 0 := by
  have hcard_pos : 0 < Fintype.card J :=
    Fintype.card_pos_iff.mpr ⟨bridge.indexWitness⟩
  exact_mod_cast ne_of_gt hcard_pos

end IUTStage1ThetaBridgeRealifiedLogVolume

/--
Finite index-compatibility shadow for ΘNF-Hodge theater morphisms.

Definition 5.5(iii) requires the NF- and Θ-bridge morphisms to induce the same
bijection between the index sets of their capsules.  This record keeps exactly
that finite datum.
-/
structure IUTStage1ThetaNFBridgeIndexCompatibility
    (J K : Type u) [Fintype J] [Fintype K] where
  nfIndexBijection : J ≃ K
  thetaIndexBijection : J ≃ K
  same_index_bijection : nfIndexBijection = thetaIndexBijection

namespace IUTStage1ThetaNFBridgeIndexCompatibility

variable {J K : Type u} [Fintype J] [Fintype K]

theorem nfIndex_eq_thetaIndex
    (compat : IUTStage1ThetaNFBridgeIndexCompatibility J K) :
    compat.nfIndexBijection = compat.thetaIndexBijection :=
  compat.same_index_bijection

theorem nfIndex_apply_eq_thetaIndex_apply
    (compat : IUTStage1ThetaNFBridgeIndexCompatibility J K)
    (j : J) :
    compat.nfIndexBijection j = compat.thetaIndexBijection j := by
  rw [compat.same_index_bijection]

end IUTStage1ThetaNFBridgeIndexCompatibility

/--
Finite realified log-volume compatibility of the NF- and Θ-bridge halves of a
ΘNF-Hodge theater.

This records the shared capsule condition from Definition 5.5(iii), together
with the common index bijection condition for morphisms.  It does not construct
the Hodge theater; it proves the finite log-volume consequence of gluing the
two bridge halves over the same capsule.
-/
structure IUTStage1ThetaNFBridgeRealifiedCompatibility
    {J : Type u} [Fintype J]
    (nfBridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (thetaBridge : IUTStage1ThetaBridgeRealifiedLogVolume J) where
  indexCompatibility :
    IUTStage1ThetaNFBridgeIndexCompatibility J J
  capsule_eq :
    nfBridge.capsuleDistribution = thetaBridge.capsuleDistribution

namespace IUTStage1ThetaNFBridgeRealifiedCompatibility

variable {J : Type u} [Fintype J]
variable {nfBridge : IUTStage1NFBridgeRealifiedLogVolume J}
variable {thetaBridge : IUTStage1ThetaBridgeRealifiedLogVolume J}

theorem thetaTarget_eq_nfSummedTarget
    (compat :
      IUTStage1ThetaNFBridgeRealifiedCompatibility nfBridge thetaBridge)
    (hmode : nfBridge.mode = IUTStage1NFBridgeLogVolumeMode.summed) :
    thetaBridge.thetaTargetLogVolume = nfBridge.targetLogVolume := by
  calc
    thetaBridge.thetaTargetLogVolume =
        thetaBridge.capsuleDistribution.totalLogVolume :=
      thetaBridge.thetaTargetLogVolume_eq_total
    _ = nfBridge.capsuleDistribution.totalLogVolume := by
      rw [← compat.capsule_eq]
    _ = nfBridge.targetLogVolume :=
      (nfBridge.targetLogVolume_eq_total_of_summed hmode).symm

theorem thetaTarget_eq_card_mul_nfAveragedTarget
    (compat :
      IUTStage1ThetaNFBridgeRealifiedCompatibility nfBridge thetaBridge)
    (hmode : nfBridge.mode = IUTStage1NFBridgeLogVolumeMode.averaged) :
    thetaBridge.thetaTargetLogVolume =
      (Fintype.card J : Real) * nfBridge.targetLogVolume := by
  calc
    thetaBridge.thetaTargetLogVolume =
        thetaBridge.capsuleDistribution.totalLogVolume :=
      thetaBridge.thetaTargetLogVolume_eq_total
    _ = nfBridge.capsuleDistribution.totalLogVolume := by
      rw [← compat.capsule_eq]
    _ = (Fintype.card J : Real) * nfBridge.targetLogVolume :=
      (nfBridge.card_mul_targetLogVolume_eq_total_of_averaged hmode).symm

theorem thetaNFBridgeCompatibility_endpoint
    (compat :
      IUTStage1ThetaNFBridgeRealifiedCompatibility nfBridge thetaBridge) :
    compat.indexCompatibility.nfIndexBijection =
        compat.indexCompatibility.thetaIndexBijection ∧
      nfBridge.capsuleDistribution = thetaBridge.capsuleDistribution :=
  ⟨compat.indexCompatibility.nfIndex_eq_thetaIndex,
    compat.capsule_eq⟩

end IUTStage1ThetaNFBridgeRealifiedCompatibility

/--
Finite `F_l`-torsor of compatible ΘNF bridge gluings.

Corollary 5.6(iii) states that, given an NF-bridge and a Θ-bridge, the
capsule-full poly-isomorphisms that glue them into a ΘNF-Hodge theater form an
`F_l`-torsor.  The current finite layer models the gluing parameter by the
additive torsor on `ZMod l` and keeps the already formalized same-index and
same-capsule compatibility attached to every gluing parameter.
-/
structure IUTStage1ThetaNFBridgeGluingTorsor
    (l : PrimeGeFive) where
  nfBridge : IUTStage1NFBridgeRealifiedLogVolume (ZMod l.value)
  thetaBridge : IUTStage1ThetaBridgeRealifiedLogVolume (ZMod l.value)
  compatibility :
    IUTStage1ThetaNFBridgeRealifiedCompatibility nfBridge thetaBridge

namespace IUTStage1ThetaNFBridgeGluingTorsor

variable {l : PrimeGeFive}

def gluingTranslate
    (_source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (t gluing : ZMod l.value) : ZMod l.value :=
  zmodLabelTranslate l t gluing

theorem gluingTranslate_eq_add
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (t gluing : ZMod l.value) :
    source.gluingTranslate t gluing = t + gluing :=
  rfl

theorem zero_gluingTranslate
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (gluing : ZMod l.value) :
    source.gluingTranslate 0 gluing = gluing :=
  zmodLabelTranslate_zero l gluing

theorem add_gluingTranslate
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (g h gluing : ZMod l.value) :
    source.gluingTranslate (g + h) gluing =
      source.gluingTranslate g (source.gluingTranslate h gluing) :=
  zmodLabelTranslate_add l g h gluing

theorem existsUnique_gluingTranslate_eq
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (gluing₁ gluing₂ : ZMod l.value) :
    ∃! t : ZMod l.value,
      source.gluingTranslate t gluing₁ = gluing₂ :=
  zmodLabelTranslate_existsUnique l gluing₁ gluing₂

theorem gluing_preserves_indexCompatibility
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (_t _gluing : ZMod l.value) :
    source.compatibility.indexCompatibility.nfIndexBijection =
      source.compatibility.indexCompatibility.thetaIndexBijection :=
  source.compatibility.indexCompatibility.nfIndex_eq_thetaIndex

theorem gluing_preserves_capsule
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (_t _gluing : ZMod l.value) :
    source.nfBridge.capsuleDistribution =
      source.thetaBridge.capsuleDistribution :=
  source.compatibility.capsule_eq

theorem gluingTorsor_endpoint
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (t g h gluing gluing₁ gluing₂ : ZMod l.value) :
    source.gluingTranslate t gluing = zmodLabelTranslate l t gluing ∧
      source.gluingTranslate 0 gluing = gluing ∧
      source.gluingTranslate (g + h) gluing =
        source.gluingTranslate g (source.gluingTranslate h gluing) ∧
      (∃! u : ZMod l.value,
        source.gluingTranslate u gluing₁ = gluing₂) ∧
      source.compatibility.indexCompatibility.nfIndexBijection =
        source.compatibility.indexCompatibility.thetaIndexBijection ∧
      source.nfBridge.capsuleDistribution =
        source.thetaBridge.capsuleDistribution :=
  ⟨rfl,
    source.zero_gluingTranslate gluing,
    source.add_gluingTranslate g h gluing,
    source.existsUnique_gluingTranslate_eq gluing₁ gluing₂,
    source.gluing_preserves_indexCompatibility t gluing,
    source.gluing_preserves_capsule t gluing⟩

end IUTStage1ThetaNFBridgeGluingTorsor

/--
Source-facing global realified Frobenioid calibration package.

It consumes the local `p_v^N` source package but fixes the exponent selected by
the global realified Frobenioid to zero.  This is the source-level replacement
for treating the calibrated real value as an unrelated primitive number.
-/
structure IUTStage1GlobalRealifiedFrobenioidCalibrationSource where
  localSource : IUTStage1LocalFrobenioidPVPowerLogVolumeSource
  globalExponent : Int
  global_exponent_eq_zero : globalExponent = 0

namespace IUTStage1GlobalRealifiedFrobenioidCalibrationSource

def calibratedLogVolume
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource) : Real :=
  source.localSource.baseSubmodule.logVolume +
    (source.globalExponent : Real) * source.localSource.localPrimeStepLogVolume

def toGlobalFrobenioidLogVolumeCalibration
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource) :
    IUTStage1GlobalFrobenioidLogVolumeCalibration :=
  { localData := source.localSource.toLocalFrobenioidLogVolumeAmbiguity,
    globalExponent := source.globalExponent,
    global_exponent_eq_zero := source.global_exponent_eq_zero,
    calibratedLogVolume := source.calibratedLogVolume,
    calibrated_logVolume_eq := rfl }

theorem calibratedLogVolume_eq_base
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource) :
    source.calibratedLogVolume =
      source.localSource.baseSubmodule.logVolume := by
  rw [calibratedLogVolume, source.global_exponent_eq_zero]
  simp

theorem toCalibration_calibrated_eq_base
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource) :
    source.toGlobalFrobenioidLogVolumeCalibration.calibratedLogVolume =
      source.localSource.baseSubmodule.logVolume :=
  source.calibratedLogVolume_eq_base

theorem calibrated_ne_local_shifted_of_not_automorphism
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource)
    (hnot : ¬ source.localSource.pPowerEndomorphismIsAutomorphism)
    (hStep : source.localSource.localPrimeStepLogVolume ≠ 0) :
    source.calibratedLogVolume ≠ source.localSource.shiftedLogVolume := by
  rw [source.calibratedLogVolume_eq_base]
  exact
    (source.localSource.shiftedLogVolume_ne_base_of_not_automorphism
      hnot hStep).symm

theorem calibrated_eq_local_shifted_iff_automorphism_or_zero_step
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource) :
    source.calibratedLogVolume = source.localSource.shiftedLogVolume ↔
      source.localSource.pPowerEndomorphismIsAutomorphism ∨
        source.localSource.localPrimeStepLogVolume = 0 := by
  rw [source.calibratedLogVolume_eq_base, eq_comm]
  exact source.localSource.shiftedLogVolume_eq_base_iff_automorphism_or_zero_step

theorem globalRealifiedCalibrationSource_endpoint
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource) :
    source.toGlobalFrobenioidLogVolumeCalibration.calibratedLogVolume =
        source.localSource.baseSubmodule.logVolume ∧
      (source.calibratedLogVolume = source.localSource.shiftedLogVolume ↔
        source.localSource.pPowerEndomorphismIsAutomorphism ∨
          source.localSource.localPrimeStepLogVolume = 0) :=
  ⟨source.toCalibration_calibrated_eq_base,
    source.calibrated_eq_local_shifted_iff_automorphism_or_zero_step⟩

end IUTStage1GlobalRealifiedFrobenioidCalibrationSource

theorem remark3122_ringStructureDimensionSplit_endpoint
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target :
      IUTStage1RealizedTensorPacketProductLogVolume kind j}
    (logShellData : IUTStage1ValuationFiberLogShellDirectSum kind)
    (global :
      IUTStage1GlobalFrobenioidLogVolumeCalibration)
    (transfer : IUTStage1TensorPacketCoricTransfer source target) :
    logShellData.directSumLogVolume =
        Finset.univ.sum logShellData.logShellLogVolume ∧
      global.calibratedLogVolume = global.localData.unshiftedLogVolume ∧
      (global.calibratedLogVolume = global.localData.shiftedLogVolume ↔
        (global.localData.localExponent : Real) *
          global.localData.localPrimeStepLogVolume = 0) ∧
      target.product.productLogVolume = source.product.productLogVolume ∧
      source.theater.side ≠ target.theater.side :=
  ⟨logShellData.direct_sum_eq,
    global.calibratedLogVolume_eq_unshifted,
    global.calibratedLogVolume_eq_shifted_iff_shiftTerm_eq_zero,
    transfer.preserves_productLogVolume,
    transfer.source_history_ne_target_history⟩

/-
Remark 3.12.1(iii) positive rational unit rigidity.

The source text points to the elementary fact `Q_{>0} Z^× = {1}` as a key input
for the cyclotomic rigidity algorithms in the number-field case.  This namespace
records the exact arithmetic shadow used here: a rational number that is
positive and is an integral unit (`±1`) is forced to be `1`.
-/
namespace IUTStage1PositiveRationalUnitRigidity

def IsIntegerUnit (q : Rat) : Prop :=
  q = 1 ∨ q = -1

theorem eq_one_of_pos_of_integerUnit
    {q : Rat} (hpos : 0 < q) (hunit : IsIntegerUnit q) :
    q = 1 := by
  rcases hunit with h | h
  · exact h
  · subst q
    norm_num at hpos

theorem positive_integerUnit_iff_eq_one
    {q : Rat} (hunit : IsIntegerUnit q) :
    0 < q ↔ q = 1 := by
  constructor
  · intro hpos
    exact eq_one_of_pos_of_integerUnit hpos hunit
  · intro h
    rw [h]
    norm_num

end IUTStage1PositiveRationalUnitRigidity

/--
Remark 3.12.1(ii) generalized `Theta^{×μ}` LGP-link bound.

For a positive rational parameter `lambda`, the source text says that the same
argument gives a lower bound `C_Theta ≥ -lambda`; the published theory is the
case `lambda = 1`.  This record keeps only the ordered-real numerical content of
that generalized comparison.
-/
structure IUTStage1GeneralizedThetaLGPLambdaBound where
  lambda : Rat
  lambda_pos : 0 < lambda
  cTheta : Real
  generalized_bound : -((lambda : Real)) <= cTheta

namespace IUTStage1GeneralizedThetaLGPLambdaBound

theorem standard_bound_of_lambda_le_one
    (data : IUTStage1GeneralizedThetaLGPLambdaBound)
    (hlambda : data.lambda <= 1) :
    (-1 : Real) <= data.cTheta := by
  have hcast : (data.lambda : Real) <= 1 := by
    exact_mod_cast hlambda
  have hstandard : (-1 : Real) <= -((data.lambda : Real)) := by
    linarith
  exact le_trans hstandard data.generalized_bound

theorem sharper_boundary_of_lambda_lt_one
    (data : IUTStage1GeneralizedThetaLGPLambdaBound)
    (hlambda : data.lambda < 1) :
    (-1 : Real) < -((data.lambda : Real)) := by
  have hcast : (data.lambda : Real) < 1 := by
    exact_mod_cast hlambda
  linarith

theorem strict_standard_bound_of_lambda_lt_one
    (data : IUTStage1GeneralizedThetaLGPLambdaBound)
    (hlambda : data.lambda < 1) :
    (-1 : Real) < data.cTheta :=
  lt_of_lt_of_le (data.sharper_boundary_of_lambda_lt_one hlambda)
    data.generalized_bound

theorem standard_case_bound
    (data : IUTStage1GeneralizedThetaLGPLambdaBound)
    (hlambda : data.lambda = 1) :
    (-1 : Real) <= data.cTheta := by
  exact data.standard_bound_of_lambda_le_one (by rw [hlambda])

end IUTStage1GeneralizedThetaLGPLambdaBound

/-- Labels for the two arithmetic holomorphic intertwinings in Remark 3.12.2. -/
inductive IUTStage1IntertwiningLabel where
  | qNative
  | thetaNative
deriving DecidableEq, Repr

/--
Remark 3.12.2 distinct-label intertwining transport.

The source text summarizes the Corollary 3.12 proof by the logical display
`q-itw => q-itw ∧ Theta-itw/indets => Theta-itw/indets`, while holding a
single weakened abstract `F^{×μ}`-prime-strip fixed.  This record keeps exactly
that logical content and the label separation between the q-native and
`Theta`-native arithmetic holomorphic structures.
-/
structure IUTStage1DistinctLabelIntertwiningTransport where
  abstractFtimesMuPrimeStrip : QualitativeData.PrimeStripId
  qHolomorphicStructure : QualitativeData.HolomorphicStructure
  thetaHolomorphicStructure : QualitativeData.HolomorphicStructure
  indeterminacyProfile : IndeterminacyProfileId
  qLabel : IUTStage1IntertwiningLabel
  thetaLabel : IUTStage1IntertwiningLabel
  q_label_eq_native : qLabel = IUTStage1IntertwiningLabel.qNative
  theta_label_eq_native :
    thetaLabel = IUTStage1IntertwiningLabel.thetaNative
  weakenedPrimeStripCannotDistinguishPilots : Prop
  weakened_primeStrip_cannot_distinguish_pilots :
    weakenedPrimeStripCannotDistinguishPilots
  qIntertwining : Prop
  thetaIntertwiningUpToIndeterminacy : Prop
  theta_from_q :
    qIntertwining -> thetaIntertwiningUpToIndeterminacy

namespace IUTStage1DistinctLabelIntertwiningTransport

theorem labels_distinct
    (data : IUTStage1DistinctLabelIntertwiningTransport) :
    data.qLabel ≠ data.thetaLabel := by
  intro h
  rw [data.q_label_eq_native, data.theta_label_eq_native] at h
  cases h

theorem weakenedPrimeStripCondition
    (data : IUTStage1DistinctLabelIntertwiningTransport) :
    data.weakenedPrimeStripCannotDistinguishPilots :=
  data.weakened_primeStrip_cannot_distinguish_pilots

theorem simultaneous_intertwining_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy :=
  ⟨hq, data.theta_from_q hq⟩

theorem formal_second_implication
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (h :
      data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy) :
    data.thetaIntertwiningUpToIndeterminacy :=
  h.2

theorem theta_intertwining_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.thetaIntertwiningUpToIndeterminacy :=
  data.formal_second_implication (data.simultaneous_intertwining_of_q hq)

theorem fixed_prime_strip_simultaneous_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.weakenedPrimeStripCannotDistinguishPilots ∧
      data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy :=
  ⟨data.weakenedPrimeStripCondition, data.simultaneous_intertwining_of_q hq⟩

theorem distinct_labels_fixed_prime_strip_simultaneous_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.qLabel ≠ data.thetaLabel ∧
      data.weakenedPrimeStripCannotDistinguishPilots ∧
        data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy :=
  ⟨data.labels_distinct, data.fixed_prime_strip_simultaneous_of_q hq⟩

theorem q_intertwining_not_invalidated
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    (data.simultaneous_intertwining_of_q hq).1 = hq :=
  rfl

theorem unlabeled_collapse_rejected
    (data : IUTStage1DistinctLabelIntertwiningTransport) :
    ¬ data.qLabel = data.thetaLabel :=
  data.labels_distinct

end IUTStage1DistinctLabelIntertwiningTransport

/--
Remark 3.12.2 upper-ray calculation.

In Remark 3.12.2 `(atoy)--(ftoy)`, forgetting the labels on the two real-line
copies makes the concrete assignments `* ↦ -h` and `* ↦ -2h` incompatible for
`h > 0`.  Replacing the second assignment by the indeterminate upper ray
`R_{≤ -2h + epsilon}` makes the final formal step the elementary inequality
`-h ≤ -2h + epsilon`, hence `h ≤ epsilon`.
-/
structure IUTStage1Remark3122IntertwiningUpperRayBound where
  h : Real
  epsilon : Real
  h_pos : 0 < h
  epsilon_pos : 0 < epsilon
  qAssignment : Real
  thetaUpperRayBound : Real
  q_assignment_eq_neg_h : qAssignment = -h
  theta_upperRay_bound_eq :
    thetaUpperRayBound = -2 * h + epsilon
  q_assignment_mem_theta_upperRay :
    qAssignment <= thetaUpperRayBound

namespace IUTStage1Remark3122IntertwiningUpperRayBound

def thetaUpperRay
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) : Set Real :=
  { value | value <= data.thetaUpperRayBound }

theorem qAssignment_mem_thetaUpperRay
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
    data.qAssignment ∈ data.thetaUpperRay :=
  data.q_assignment_mem_theta_upperRay

theorem forgotten_concrete_assignments_incompatible
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
    (-data.h : Real) ≠ -2 * data.h := by
  intro hEq
  linarith [data.h_pos]

theorem neg_h_le_neg_two_h_plus_epsilon
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
    (-data.h : Real) <= -2 * data.h + data.epsilon := by
  rw [← data.q_assignment_eq_neg_h, ← data.theta_upperRay_bound_eq]
  exact data.q_assignment_mem_theta_upperRay

theorem h_le_epsilon
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
    data.h <= data.epsilon := by
  linarith [data.neg_h_le_neg_two_h_plus_epsilon]

theorem ftoy_upper_ray_endpoint
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
    data.qAssignment ∈ data.thetaUpperRay ∧
      (-data.h : Real) <= -2 * data.h + data.epsilon ∧
        data.h <= data.epsilon :=
  ⟨data.qAssignment_mem_thetaUpperRay, data.neg_h_le_neg_two_h_plus_epsilon,
    data.h_le_epsilon⟩

end IUTStage1Remark3122IntertwiningUpperRayBound

/-- The two vertical columns compared in IUT III, Fig. 3.9. -/
inductive IUTStage1LogThetaVerticalColumn where
  | zeroThetaPilot
  | oneQPilot
deriving DecidableEq, Repr

/-- Treatment of vertically coric log-shells in the lower half of Fig. 3.9. -/
inductive IUTStage1LogShellColumnTreatment where
  | monoAnalyticContainers
  | tautologicalLogDocumentation
deriving DecidableEq, Repr

namespace IUTStage1LogThetaVerticalColumn

/-- Fig. 3.9: both columns require Frobenius-like and etale-like roles. -/
def requiresFrobeniusLikeRole :
    IUTStage1LogThetaVerticalColumn -> Bool
  | zeroThetaPilot => true
  | oneQPilot => true

/-- Fig. 3.9: both columns require vertically coric etale-like containers. -/
def requiresEtaleLikeRole :
    IUTStage1LogThetaVerticalColumn -> Bool
  | zeroThetaPilot => true
  | oneQPilot => true

/-- Fig. 3.9: log-volume compatibility is similar in the two columns. -/
def hasLogVolumeCompatibility :
    IUTStage1LogThetaVerticalColumn -> Bool
  | zeroThetaPilot => true
  | oneQPilot => true

/-- Fig. 3.9: log-Kummer non-interference is similar in the two columns. -/
def hasLogKummerNonInterference :
    IUTStage1LogThetaVerticalColumn -> Bool
  | zeroThetaPilot => true
  | oneQPilot => true

/-- Fig. 3.9: Theorem 3.11(iii)(c)-type multiradiality holds only on the theta side. -/
def hasPilotMultiradiality :
    IUTStage1LogThetaVerticalColumn -> Bool
  | zeroThetaPilot => true
  | oneQPilot => false

/-- Fig. 3.9: the two columns use log-shells differently. -/
def logShellTreatment :
    IUTStage1LogThetaVerticalColumn ->
      IUTStage1LogShellColumnTreatment
  | zeroThetaPilot =>
      IUTStage1LogShellColumnTreatment.monoAnalyticContainers
  | oneQPilot =>
      IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation

theorem requiresFrobeniusLikeRole_eq_true
    (column : IUTStage1LogThetaVerticalColumn) :
    column.requiresFrobeniusLikeRole = true := by
  cases column <;> rfl

theorem requiresEtaleLikeRole_eq_true
    (column : IUTStage1LogThetaVerticalColumn) :
    column.requiresEtaleLikeRole = true := by
  cases column <;> rfl

theorem both_roles_essential
    (column : IUTStage1LogThetaVerticalColumn) :
    column.requiresFrobeniusLikeRole = true ∧
      column.requiresEtaleLikeRole = true :=
  ⟨column.requiresFrobeniusLikeRole_eq_true,
    column.requiresEtaleLikeRole_eq_true⟩

theorem logVolumeCompatibility_eq_true
    (column : IUTStage1LogThetaVerticalColumn) :
    column.hasLogVolumeCompatibility = true := by
  cases column <;> rfl

theorem logKummerNonInterference_eq_true
    (column : IUTStage1LogThetaVerticalColumn) :
    column.hasLogKummerNonInterference = true := by
  cases column <;> rfl

theorem upper_table_similarities
    (column : IUTStage1LogThetaVerticalColumn) :
    column.requiresFrobeniusLikeRole = true ∧
      column.requiresEtaleLikeRole = true ∧
        column.hasLogVolumeCompatibility = true ∧
          column.hasLogKummerNonInterference = true :=
  ⟨column.requiresFrobeniusLikeRole_eq_true,
    column.requiresEtaleLikeRole_eq_true,
    column.logVolumeCompatibility_eq_true,
    column.logKummerNonInterference_eq_true⟩

/--
Remark 3.12.2(iv) / Fig. 3.9 upper-table endpoint.

The essential Frobenius-like and etale-like roles, log-link log-volume
compatibility, and log-Kummer non-interference are shared by both the
0-column/theta-pilot side and the 1-column/q-pilot side.
-/
theorem remark3122iv_zero_one_column_similarities_endpoint :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.requiresFrobeniusLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.requiresEtaleLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.requiresFrobeniusLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.requiresEtaleLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasLogVolumeCompatibility =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogVolumeCompatibility =
        true ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasLogKummerNonInterference =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true :=
  ⟨IUTStage1LogThetaVerticalColumn.zeroThetaPilot.requiresFrobeniusLikeRole_eq_true,
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.requiresEtaleLikeRole_eq_true,
    IUTStage1LogThetaVerticalColumn.oneQPilot.requiresFrobeniusLikeRole_eq_true,
    IUTStage1LogThetaVerticalColumn.oneQPilot.requiresEtaleLikeRole_eq_true,
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logVolumeCompatibility_eq_true,
    IUTStage1LogThetaVerticalColumn.oneQPilot.logVolumeCompatibility_eq_true,
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logKummerNonInterference_eq_true,
    IUTStage1LogThetaVerticalColumn.oneQPilot.logKummerNonInterference_eq_true⟩

theorem thetaPilot_hasMultiradiality :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasPilotMultiradiality =
      true :=
  rfl

theorem qPilot_lacksMultiradiality :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality =
      false :=
  rfl

theorem multiradiality_distinguishes_columns :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasPilotMultiradiality ≠
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality := by
  simp [hasPilotMultiradiality]

theorem thetaPilot_logShellTreatment :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment =
      IUTStage1LogShellColumnTreatment.monoAnalyticContainers :=
  rfl

theorem qPilot_logShellTreatment :
    IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment =
      IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation :=
  rfl

theorem logShellTreatment_distinguishes_columns :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment ≠
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment := by
  simp [logShellTreatment]

theorem lower_table_differences :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasPilotMultiradiality =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality =
        false ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.monoAnalyticContainers ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasPilotMultiradiality ≠
        IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment ≠
        IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment :=
  ⟨thetaPilot_hasMultiradiality,
    qPilot_lacksMultiradiality,
    thetaPilot_logShellTreatment,
    qPilot_logShellTreatment,
    multiradiality_distinguishes_columns,
    logShellTreatment_distinguishes_columns⟩

/--
Remark 3.12.2(iv),(v) q-pilot endpoint.

The q-pilot side retains the log-Kummer non-interference similarity from the
upper half of Fig. 3.9, but lacks theta-pilot multiradiality and uses the
tautological log-shell treatment from the lower half.
-/
theorem remark3122v_qPilot_nonInterference_without_multiradiality_endpoint :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality =
        false ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation :=
  ⟨IUTStage1LogThetaVerticalColumn.oneQPilot.logKummerNonInterference_eq_true,
    IUTStage1LogThetaVerticalColumn.qPilot_lacksMultiradiality,
    IUTStage1LogThetaVerticalColumn.qPilot_logShellTreatment⟩

end IUTStage1LogThetaVerticalColumn

end Stage1
end Iut
