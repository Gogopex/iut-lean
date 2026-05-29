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
`(Ind3)`" as an informal phrase.
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
Concrete square-weight profile on the current `F_l = ZMod l.value` model.

The formula records the finite-field coordinate representative `j.val` and
squares it as a real number. Positivity of the total weight is kept as explicit
evidence because later milestones should audit exactly which nonzero coordinate
or Gaussian-monoid argument supplies it.
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

theorem input_le_determinant
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume <=
      data.upperRayData.determinant.determinantLogVolume := by
  rw [data.input_eq_q]
  exact data.upperRayData.qPilotLogVolume_le_determinant

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

end IUTStage1LocalFrobenioidLogVolumeAmbiguity

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

end IUTStage1GlobalFrobenioidLogVolumeCalibration

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
