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

namespace IUTStage1FiniteLocalLogVolumeObject

variable {kind : IUTStage1PlaceKind}

theorem logVolume_eq
    (data : IUTStage1FiniteLocalLogVolumeObject kind) :
    data.localObject.logVolume = data.finiteLogVolume :=
  data.finite_log_volume_eq

def place
    (data : IUTStage1FiniteLocalLogVolumeObject kind) :
    IUTStage1PlaceId kind :=
  data.localObject.object.place

end IUTStage1FiniteLocalLogVolumeObject

namespace IUTStage1ProcessionNormalizedLogVolume

variable {kind : IUTStage1PlaceKind}

theorem normalized_eq
    (data : IUTStage1ProcessionNormalizedLogVolume kind) :
    data.normalizedLogVolume =
      data.totalLogVolume / (data.capsuleCount : Real) :=
  data.normalized_eq_average

theorem capsuleCount_pos
    (data : IUTStage1ProcessionNormalizedLogVolume kind) :
    0 < data.capsuleCount :=
  data.positive_capsule_count

def toFiniteLocalLogVolumeObject
    (data : IUTStage1ProcessionNormalizedLogVolume kind) :
    IUTStage1FiniteLocalLogVolumeObject kind :=
  data.localObject

end IUTStage1ProcessionNormalizedLogVolume

namespace IUTStage1LocalContainerLogVolumeEstimate

variable {targetSigned localLogVolume : Real}

theorem targetSigned_le_localLogVolume
    (estimate :
      IUTStage1LocalContainerLogVolumeEstimate targetSigned localLogVolume) :
    targetSigned <= localLogVolume := by
  rw [estimate.localLogVolume_eq_container]
  exact estimate.targetSigned_le_containerLogVolume

end IUTStage1LocalContainerLogVolumeEstimate

namespace IUTStage1LocalObjectContainerLogVolumeEstimate

variable {kind : IUTStage1PlaceKind}
variable {targetSigned localLogVolume : Real}

def toLocalContainerEstimate
    (estimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume) :
    IUTStage1LocalContainerLogVolumeEstimate
      targetSigned localLogVolume :=
  { containerLogVolume :=
      estimate.object_container_estimate.containerLogVolume,
    localLogVolume_eq_container :=
      estimate.localLogVolume_eq_object.trans
        estimate.object_container_estimate.localLogVolume_eq_container,
    targetSigned_le_containerLogVolume :=
      estimate.object_container_estimate.targetSigned_le_containerLogVolume }

theorem targetSigned_le_localLogVolume
    (estimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume) :
    targetSigned <= localLogVolume :=
  estimate.toLocalContainerEstimate.targetSigned_le_localLogVolume

def transportLocalLogVolume
    {newLocalLogVolume : Real}
    (estimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume)
    (hlog : newLocalLogVolume = localLogVolume) :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned newLocalLogVolume :=
  { localObject := estimate.localObject,
    localLogVolume_eq_object :=
      hlog.trans estimate.localLogVolume_eq_object,
    object_container_estimate := estimate.object_container_estimate }

end IUTStage1LocalObjectContainerLogVolumeEstimate

namespace IUTStage1FLLabelModel

variable {label : Type u}

/-- The canonical `F_l` label model supplied by the foundations layer. -/
def zmod (l : PrimeGeFive) :
    IUTStage1FLLabelModel (ZMod l.value) :=
  { prime := l,
    labelEquiv := Equiv.refl _ }

theorem card_eq_primeValue
    [Fintype label]
    (model : IUTStage1FLLabelModel label) :
    Fintype.card label = model.prime.value := by
  haveI : NeZero model.prime.value := ⟨model.prime.ne_zero⟩
  calc
    Fintype.card label = Fintype.card (ZMod model.prime.value) :=
      Fintype.card_congr model.labelEquiv
    _ = model.prime.value := by
      rw [ZMod.card]

def toZMod
    (model : IUTStage1FLLabelModel label) :
    label -> ZMod model.prime.value :=
  model.labelEquiv

def fromZMod
    (model : IUTStage1FLLabelModel label) :
    ZMod model.prime.value -> label :=
  model.labelEquiv.symm

theorem fromZMod_toZMod
    (model : IUTStage1FLLabelModel label) (j : label) :
    model.fromZMod (model.toZMod j) = j :=
  model.labelEquiv.left_inv j

theorem toZMod_fromZMod
    (model : IUTStage1FLLabelModel label)
    (j : ZMod model.prime.value) :
    model.toZMod (model.fromZMod j) = j :=
  model.labelEquiv.right_inv j

end IUTStage1FLLabelModel

/--
`F_l` label model together with the additive torsor action transported from
the concrete `ZMod l` model.

The universe is kept at `Type` because `AdditiveTorsorData` in the foundations
layer currently takes both the acting group and carrier in the same universe,
and `ZMod l.value` is a small type.
-/
structure IUTStage1FLLabelTorsorModel
    (label : Type) where
  label_model : IUTStage1FLLabelModel label
  torsor : AdditiveTorsorData (ZMod label_model.prime.value) label
  torsor_vadd_eq_zmod :
    ∀ (t : ZMod label_model.prime.value) (j : label),
      torsor.vadd t j =
        label_model.fromZMod (t + label_model.toZMod j)

namespace IUTStage1FLLabelTorsorModel

variable {label : Type}

/-- The canonical additive `F_l` torsor model on `ZMod l`. -/
def zmod (l : PrimeGeFive) :
    IUTStage1FLLabelTorsorModel (ZMod l.value) :=
  { label_model := IUTStage1FLLabelModel.zmod l,
    torsor := zmodLabelAdditiveTorsorData l,
    torsor_vadd_eq_zmod := by
      intro t j
      rfl }

theorem vadd_eq_zmod
    (model : IUTStage1FLLabelTorsorModel label)
    (t : ZMod model.label_model.prime.value) (j : label) :
    model.torsor.vadd t j =
      model.label_model.fromZMod (t + model.label_model.toZMod j) :=
  model.torsor_vadd_eq_zmod t j

theorem zero_vadd
    (model : IUTStage1FLLabelTorsorModel label) (j : label) :
    model.torsor.vadd 0 j = j :=
  model.torsor.zero_vadd j

theorem add_vadd
    (model : IUTStage1FLLabelTorsorModel label)
    (g h : ZMod model.label_model.prime.value) (j : label) :
    model.torsor.vadd (g + h) j =
      model.torsor.vadd g (model.torsor.vadd h j) :=
  model.torsor.add_vadd g h j

theorem exists_unique_vadd_eq
    (model : IUTStage1FLLabelTorsorModel label)
    (j₁ j₂ : label) :
    ∃! t : ZMod model.label_model.prime.value,
      model.torsor.vadd t j₁ = j₂ :=
  model.torsor.exists_unique_vadd_eq j₁ j₂

theorem zmod_vadd_eq_translate
    (l : PrimeGeFive) (t j : ZMod l.value) :
    (zmod l).torsor.vadd t j = zmodLabelTranslate l t j :=
  rfl

end IUTStage1FLLabelTorsorModel

/--
The `ZMod l` label model together with the unit action and sign quotient data
used for label classes.

This records the action of `(ZMod l)^×`, the sign action, their compatibility
via the unit `-1`, and the subgroup `{1,-1}` whose orbits are exactly sign
orbits.
-/
structure IUTStage1FLZModUnitSignLabelModel
    (l : PrimeGeFive) where
  torsor_model : IUTStage1FLLabelTorsorModel (ZMod l.value)
  signUnitCompatibility :
    QuotientSignUnitCompatibility
      (zmodPointedQuotient l) (zmodUnitActionData l) (zmodSignAction l)
  signUnitSubgroup : Subgroup (ZMod l.value)ˣ
  signUnitSubgroup_smul_eq_self_or_neg :
    ∀ {a : (ZMod l.value)ˣ},
      a ∈ signUnitSubgroup ->
        ∀ x : ZMod l.value,
          (zmodUnitActionData l).smul a x = x ∨
            (zmodUnitActionData l).smul a x = (zmodSignAction l).neg x
  signUnitSubgroup_orbit_iff_signOrbit :
    ∀ x generator : ZMod l.value,
      (∃ a : (ZMod l.value)ˣ,
        a ∈ signUnitSubgroup ∧
          (zmodUnitActionData l).smul a generator = x) ↔
        (zmodSignAction l).InSignOrbit x generator

namespace IUTStage1FLZModUnitSignLabelModel

/-- The canonical unit/sign label model supplied by the foundations layer. -/
def zmod (l : PrimeGeFive) :
    IUTStage1FLZModUnitSignLabelModel l :=
  { torsor_model := IUTStage1FLLabelTorsorModel.zmod l,
    signUnitCompatibility := zmodSignUnitCompatibility l,
    signUnitSubgroup := zmodSignUnitSubgroup l,
    signUnitSubgroup_smul_eq_self_or_neg := by
      intro a ha x
      exact zmodSignUnitSubgroup_smul_eq_self_or_neg l ha x,
    signUnitSubgroup_orbit_iff_signOrbit := by
      intro x generator
      exact zmodSignUnitSubgroup_orbit_iff_signOrbit l x generator }

theorem signUnit_smul_eq_neg
    {l : PrimeGeFive}
    (model : IUTStage1FLZModUnitSignLabelModel l)
    (x : ZMod l.value) :
    (zmodUnitActionData l).smul model.signUnitCompatibility.signUnit x =
      (zmodSignAction l).neg x :=
  model.signUnitCompatibility.signUnit_smul_eq_neg x

theorem signUnitSubgroup_smul_eq_self_or_neg'
    {l : PrimeGeFive}
    (model : IUTStage1FLZModUnitSignLabelModel l)
    {a : (ZMod l.value)ˣ}
    (ha : a ∈ model.signUnitSubgroup)
    (x : ZMod l.value) :
    (zmodUnitActionData l).smul a x = x ∨
      (zmodUnitActionData l).smul a x = (zmodSignAction l).neg x :=
  model.signUnitSubgroup_smul_eq_self_or_neg ha x

theorem signUnitSubgroup_orbit_iff_signOrbit'
    {l : PrimeGeFive}
    (model : IUTStage1FLZModUnitSignLabelModel l)
    (x generator : ZMod l.value) :
    (∃ a : (ZMod l.value)ˣ,
      a ∈ model.signUnitSubgroup ∧
        (zmodUnitActionData l).smul a generator = x) ↔
      (zmodSignAction l).InSignOrbit x generator :=
  model.signUnitSubgroup_orbit_iff_signOrbit x generator

theorem zmod_signUnitSubgroup_orbit_iff_signOrbit
    (l : PrimeGeFive) (x generator : ZMod l.value) :
    (∃ a : (ZMod l.value)ˣ,
      a ∈ (zmod l).signUnitSubgroup ∧
        (zmodUnitActionData l).smul a generator = x) ↔
      (zmodSignAction l).InSignOrbit x generator :=
  (zmod l).signUnitSubgroup_orbit_iff_signOrbit' x generator

end IUTStage1FLZModUnitSignLabelModel

/--
The canonical `F_l` label/cusp bridge at the `ZMod l` model.

This packages the Stage 1 unit/sign label bridge with the foundations
`LocalLabCuspModel` and its canonical `CuspLabelClassData`.
-/
structure IUTStage1FLZModCuspLabelClassModel
    (l : PrimeGeFive) where
  unit_sign_model : IUTStage1FLZModUnitSignLabelModel l
  local_lab_cusp_model : LocalLabCuspModel l
  local_lab_cusp_model_eq_zmod :
    local_lab_cusp_model = zmodLocalLabCuspModel l
  cusp_label_class_data : CuspLabelClassData l
  cusp_label_class_data_eq_zmod :
    cusp_label_class_data = zmodCanonicalCuspLabelClassData l

namespace IUTStage1FLZModCuspLabelClassModel

/-- The canonical `ZMod l` cusp-label bridge supplied by the foundations layer. -/
def zmod (l : PrimeGeFive) :
    IUTStage1FLZModCuspLabelClassModel l :=
  { unit_sign_model := IUTStage1FLZModUnitSignLabelModel.zmod l,
    local_lab_cusp_model := zmodLocalLabCuspModel l,
    local_lab_cusp_model_eq_zmod := rfl,
    cusp_label_class_data := zmodCanonicalCuspLabelClassData l,
    cusp_label_class_data_eq_zmod := rfl }

theorem localLabCuspModel_eq_zmod
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.local_lab_cusp_model = zmodLocalLabCuspModel l :=
  model.local_lab_cusp_model_eq_zmod

theorem cuspLabelClassData_eq_zmod
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.cusp_label_class_data = zmodCanonicalCuspLabelClassData l :=
  model.cusp_label_class_data_eq_zmod

theorem canonicalLabelTranslate
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.local_lab_cusp_model.canonicalNonzeroLabel.1 =
      model.local_lab_cusp_model.additiveTorsor.vadd
        model.local_lab_cusp_model.canonicalCoordinate
        model.local_lab_cusp_model.labelQuotient.zero :=
  model.local_lab_cusp_model.canonicalLabelTranslate

theorem canonicalSignLabelEq
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.local_lab_cusp_model.canonicalSignLabel =
      model.local_lab_cusp_model.signAction.toSignLabelQuotient
        model.local_lab_cusp_model.canonicalNonzeroLabel :=
  model.local_lab_cusp_model.canonicalSignLabelEq

theorem labelClass_eq_model_quotient
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.cusp_label_class_data.labelClass =
      model.cusp_label_class_data.model.signAction.toSignLabelQuotient
        model.cusp_label_class_data.model.canonicalNonzeroLabel :=
  model.cusp_label_class_data.labelClass_eq_model_quotient

theorem zmod_canonicalSignLabel_eq
    (l : PrimeGeFive) :
    (zmod l).local_lab_cusp_model.canonicalSignLabel =
      zmodCanonicalSignLabelQuotient l :=
  rfl

theorem zmod_canonicalCoordinate_eq_one
    (l : PrimeGeFive) :
    (zmod l).local_lab_cusp_model.canonicalCoordinate =
      (1 : ZMod l.value) :=
  rfl

theorem zmod_canonicalSignLabel_eq_fromCoordinate_one
    (l : PrimeGeFive) :
    (zmod l).local_lab_cusp_model.canonicalSignLabel =
      zmodSignLabelFromCoordinate l (1 : ZMod l.value)
        (zmodOneNonzeroLabel l).2 := by
  calc
    (zmod l).local_lab_cusp_model.canonicalSignLabel =
        zmodCanonicalSignLabelQuotient l :=
      zmod_canonicalSignLabel_eq l
    _ = zmodSignLabelFromCoordinate l (1 : ZMod l.value)
          (zmodOneNonzeroLabel l).2 :=
      (zmodSignLabelFromCoordinate_one_eq_canonical l).symm

theorem zmod_cuspLabelClass_eq_canonical
    (l : PrimeGeFive) :
    (zmod l).cusp_label_class_data.labelClass =
      (zmod l).cusp_label_class_data.model.canonicalSignLabel :=
  (zmod l).cusp_label_class_data.labelClass_eq_canonical

theorem zmod_cuspLabelClass_eq_fromCoordinate_one
    (l : PrimeGeFive) :
    (zmod l).cusp_label_class_data.labelClass =
      zmodSignLabelFromCoordinate l (1 : ZMod l.value)
        (zmodOneNonzeroLabel l).2 := by
  calc
    (zmod l).cusp_label_class_data.labelClass =
        (zmod l).cusp_label_class_data.model.canonicalSignLabel :=
      zmod_cuspLabelClass_eq_canonical l
    _ = zmodSignLabelFromCoordinate l (1 : ZMod l.value)
          (zmodOneNonzeroLabel l).2 :=
      zmod_canonicalSignLabel_eq_fromCoordinate_one l

end IUTStage1FLZModCuspLabelClassModel

theorem zmod_toSignLabelQuotient_eq_fromCoordinate
    {l : PrimeGeFive}
    (x : (zmodPointedQuotient l).NonzeroCarrier) :
    (zmodSignAction l).toSignLabelQuotient x =
      zmodSignLabelFromCoordinate l x.1 x.2 := by
  apply Quotient.sound
  left
  exact (zmodNonzeroLabelFromCoordinate_val l x.1 x.2).symm

/--
The Stage 1 zero/nonzero cusp-label split for the concrete `F_l = ZMod l`
model.

The zero label is kept as its own constructor.  Nonzero labels enter only through
the sign-label quotient.
-/
inductive IUTStage1ZModCuspFullLabel (l : PrimeGeFive) where
  | zero
  | nonzero : (zmodSignAction l).SignLabelQuotient -> IUTStage1ZModCuspFullLabel l

namespace IUTStage1ZModCuspFullLabel

variable {l : PrimeGeFive}

def fromCoordinate (l : PrimeGeFive) (j : ZMod l.value) :
    IUTStage1ZModCuspFullLabel l :=
  if hj : j = 0 then
    zero
  else
    nonzero (zmodSignLabelFromCoordinate l j hj)

theorem fromCoordinate_zero (l : PrimeGeFive) :
    fromCoordinate l (0 : ZMod l.value) = zero := by
  simp [fromCoordinate]

theorem fromCoordinate_nonzero
    (l : PrimeGeFive) (j : ZMod l.value) (hj : j ≠ 0) :
    fromCoordinate l j = nonzero (zmodSignLabelFromCoordinate l j hj) := by
  simp [fromCoordinate, hj]

theorem fromCoordinate_one (l : PrimeGeFive) :
    fromCoordinate l (1 : ZMod l.value) =
      nonzero (zmodCanonicalSignLabelQuotient l) := by
  rw [fromCoordinate_nonzero l (1 : ZMod l.value) (zmodOneNonzeroLabel l).2]
  rw [zmodSignLabelFromCoordinate_one_eq_canonical]

theorem fromCoordinate_neg
    (l : PrimeGeFive) (j : ZMod l.value) (hj : j ≠ 0) :
    fromCoordinate l (-j) = fromCoordinate l j := by
  rw [fromCoordinate_nonzero l (-j) (zmod_neg_ne_zero_of_ne_zero l hj)]
  rw [fromCoordinate_nonzero l j hj]
  rw [zmodSignLabelFromCoordinate_neg_eq]

def localObject
    {kind : IUTStage1PlaceKind}
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind) :
    IUTStage1ZModCuspFullLabel l ->
      IUTStage1FiniteLocalLogVolumeObject kind
  | zero => zeroObject
  | nonzero label => cuspClassObject label

theorem localObject_zero
    {kind : IUTStage1PlaceKind}
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind) :
    localObject zeroObject cuspClassObject zero = zeroObject :=
  rfl

theorem localObject_nonzero
    {kind : IUTStage1PlaceKind}
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    localObject zeroObject cuspClassObject (nonzero label) =
      cuspClassObject label :=
  rfl

theorem localObject_fromCoordinate_zero
    {kind : IUTStage1PlaceKind}
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind) :
    localObject zeroObject cuspClassObject (fromCoordinate l (0 : ZMod l.value)) =
      zeroObject := by
  rw [fromCoordinate_zero]
  rfl

theorem localObject_fromCoordinate_nonzero
    {kind : IUTStage1PlaceKind}
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    localObject zeroObject cuspClassObject (fromCoordinate l j) =
      cuspClassObject (zmodSignLabelFromCoordinate l j hj) := by
  rw [fromCoordinate_nonzero l j hj]
  rfl

theorem localObject_fromCoordinate_neg_eq
    {kind : IUTStage1PlaceKind}
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    localObject zeroObject cuspClassObject (fromCoordinate l (-j)) =
      localObject zeroObject cuspClassObject (fromCoordinate l j) := by
  rw [fromCoordinate_neg l j hj]

end IUTStage1ZModCuspFullLabel

/--
Compatibility between a `ZMod l`-indexed normalized log-volume family and a
description by nonzero cusp sign-label classes.

The zero label is recorded separately because the sign-label quotient in the
foundations layer is defined on nonzero labels.
-/
structure IUTStage1ZModCuspLabelLogVolumeCompatibility
    (l : PrimeGeFive) where
  normalizedLogVolume : ZMod l.value -> Real
  cuspClassLogVolume :
    (zmodSignAction l).SignLabelQuotient -> Real
  zeroLogVolume : Real
  nonzero_eq_cuspClass :
    ∀ (j : ZMod l.value) (hj : j ≠ 0),
      normalizedLogVolume j =
        cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj)
  zero_eq : normalizedLogVolume 0 = zeroLogVolume

namespace IUTStage1ZModCuspLabelLogVolumeCompatibility

variable {l : PrimeGeFive}

def constant (c : Real) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility l :=
  { normalizedLogVolume := fun _ => c,
    cuspClassLogVolume := fun _ => c,
    zeroLogVolume := c,
    nonzero_eq_cuspClass := by
      intro j hj
      rfl,
    zero_eq := rfl }

theorem nonzero_eq
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    compat.normalizedLogVolume j =
      compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj) :=
  compat.nonzero_eq_cuspClass j hj

theorem zero_eq_zeroLogVolume
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    compat.normalizedLogVolume 0 = compat.zeroLogVolume :=
  compat.zero_eq

theorem neg_nonzero_eq
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    compat.normalizedLogVolume (-j) =
      compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj) := by
  rw [compat.nonzero_eq (-j) (zmod_neg_ne_zero_of_ne_zero l hj)]
  rw [zmodSignLabelFromCoordinate_neg_eq]

def fullLabelLogVolume
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    IUTStage1ZModCuspFullLabel l -> Real
  | IUTStage1ZModCuspFullLabel.zero => compat.zeroLogVolume
  | IUTStage1ZModCuspFullLabel.nonzero label =>
      compat.cuspClassLogVolume label

theorem fullLabelLogVolume_zero
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    compat.fullLabelLogVolume IUTStage1ZModCuspFullLabel.zero =
      compat.zeroLogVolume :=
  rfl

theorem fullLabelLogVolume_nonzero
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (label : (zmodSignAction l).SignLabelQuotient) :
    compat.fullLabelLogVolume (IUTStage1ZModCuspFullLabel.nonzero label) =
      compat.cuspClassLogVolume label :=
  rfl

theorem constant_fullLabelLogVolume
    (c : Real) (label : IUTStage1ZModCuspFullLabel l) :
    (constant (l := l) c).fullLabelLogVolume label = c := by
  cases label <;> rfl

theorem constant_fullLabelLogVolume_fromCoordinate
    (c : Real) (j : ZMod l.value) :
    (constant (l := l) c).fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) = c := by
  rw [constant_fullLabelLogVolume]

theorem normalizedLogVolume_eq_fullLabelLogVolume_fromCoordinate
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) :
    compat.normalizedLogVolume j =
      compat.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  by_cases hj : j = 0
  · subst j
    rw [IUTStage1ZModCuspFullLabel.fromCoordinate_zero]
    exact compat.zero_eq_zeroLogVolume
  · rw [IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero l j hj]
    exact compat.nonzero_eq j hj

theorem fullLabelLogVolume_fromCoordinate_zero
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    compat.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (0 : ZMod l.value)) =
      compat.zeroLogVolume := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_zero]
  rfl

theorem fullLabelLogVolume_fromCoordinate_nonzero
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    compat.fullLabelLogVolume (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj) := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero l j hj]
  rfl

theorem fullLabelLogVolume_fromCoordinate_neg_eq
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    compat.fullLabelLogVolume (IUTStage1ZModCuspFullLabel.fromCoordinate l (-j)) =
      compat.fullLabelLogVolume (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_neg l j hj]

theorem cuspClass_eq_of_normalizedLogVolume_eq
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    {c : Real}
    (hnormalized : ∀ j : ZMod l.value, compat.normalizedLogVolume j = c)
    (label : (zmodSignAction l).SignLabelQuotient) :
    compat.cuspClassLogVolume label = c := by
  refine Quotient.inductionOn label ?_
  intro x
  calc
    compat.cuspClassLogVolume ((zmodSignAction l).toSignLabelQuotient x) =
        compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l x.1 x.2) := by
      rw [zmod_toSignLabelQuotient_eq_fromCoordinate x]
    _ = compat.normalizedLogVolume x.1 :=
      (compat.nonzero_eq x.1 x.2).symm
    _ = c :=
      hnormalized x.1

theorem zeroLogVolume_eq_of_normalizedLogVolume_eq
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    {c : Real}
    (hnormalized : ∀ j : ZMod l.value, compat.normalizedLogVolume j = c) :
    compat.zeroLogVolume = c := by
  calc
    compat.zeroLogVolume = compat.normalizedLogVolume 0 :=
      compat.zero_eq_zeroLogVolume.symm
    _ = c :=
      hnormalized 0

/--
Coordinate-level preservation of the zero/nonzero full-label branch.

This condition is about the label map only: after applying the coordinate
equivalence, the associated full label is the same zero/nonzero/sign-class label.
-/
def FullLabelMapPreserving
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value) : Prop :=
  ∀ j : ZMod l.value,
    IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j) =
      IUTStage1ZModCuspFullLabel.fromCoordinate l j

theorem fullLabelMapPreserving_refl :
    FullLabelMapPreserving (l := l) (Equiv.refl (ZMod l.value)) := by
  intro j
  rfl

theorem fullLabelMapPreserving_neg :
    FullLabelMapPreserving (l := l) (Equiv.neg (ZMod l.value)) := by
  intro j
  by_cases hj : j = 0
  · subst j
    simp [IUTStage1ZModCuspFullLabel.fromCoordinate_zero]
  · exact IUTStage1ZModCuspFullLabel.fromCoordinate_neg l j hj

/--
Labelwise preservation of the full-label log-volume branch.

This is separate from coordinate preservation: it says that once a full label has
been matched, the target and source log-volume functions assign the same real
value to it.
-/
def FullLabelLogVolumeValuePreserving
    (sourceLogVolume targetLogVolume :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l) : Prop :=
  ∀ label : IUTStage1ZModCuspFullLabel l,
    targetLogVolume.fullLabelLogVolume label =
      sourceLogVolume.fullLabelLogVolume label

theorem transportedFullLabelLogVolume_preserved_of_fullLabelMap
    (sourceLogVolume targetLogVolume :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hmap : FullLabelMapPreserving (l := l) coordinateEquiv)
    (hvalue :
      FullLabelLogVolumeValuePreserving
        sourceLogVolume targetLogVolume) :
    ∀ j : ZMod l.value,
      targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j)) =
        sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  intro j
  rw [hmap j]
  exact hvalue (IUTStage1ZModCuspFullLabel.fromCoordinate l j)

theorem fullLabelLogVolumeValuePreserving_refl
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    FullLabelLogVolumeValuePreserving logVolume logVolume := by
  intro label
  rfl

end IUTStage1ZModCuspLabelLogVolumeCompatibility

namespace IUTStage1LabelAveragedProcessionLogVolume

variable {label : Type u} [Fintype label]

def constant [Nonempty label] (c : Real) :
    IUTStage1LabelAveragedProcessionLogVolume label :=
  { normalizedLogVolume := fun _ => c,
    averageLogVolume := c,
    average_eq := by
      have hcard_nat : 0 < Fintype.card label := Fintype.card_pos
      have hcard_ne : (Fintype.card label : Real) ≠ 0 := by
        exact_mod_cast (ne_of_gt hcard_nat)
      calc
        c = ((Fintype.card label : Real) * c) /
            (Fintype.card label : Real) := by
          field_simp [hcard_ne]
        _ = (Finset.univ.sum fun _ : label => c) /
            (Fintype.card label : Real) := by
          rw [Finset.sum_const, nsmul_eq_mul, Finset.card_univ] }

theorem average_eq_formula
    (data : IUTStage1LabelAveragedProcessionLogVolume label) :
    data.averageLogVolume =
      (Finset.univ.sum data.normalizedLogVolume) /
        (Fintype.card label : Real) :=
  data.average_eq

theorem average_eq_of_pointwise
    {data₁ data₂ : IUTStage1LabelAveragedProcessionLogVolume label}
    (hpointwise :
      ∀ j : label,
        data₁.normalizedLogVolume j =
          data₂.normalizedLogVolume j) :
    data₁.averageLogVolume = data₂.averageLogVolume := by
  calc
    data₁.averageLogVolume =
        (Finset.univ.sum data₁.normalizedLogVolume) /
          (Fintype.card label : Real) :=
      data₁.average_eq
    _ =
        (Finset.univ.sum data₂.normalizedLogVolume) /
          (Fintype.card label : Real) := by
      congr 1
      exact Finset.sum_congr rfl (by
        intro j _hj
        exact hpointwise j)
    _ = data₂.averageLogVolume :=
      data₂.average_eq.symm

theorem eq_constant_of_forall_eq
    [Nonempty label]
    (data : IUTStage1LabelAveragedProcessionLogVolume label)
    {c : Real}
    (hpointwise : ∀ j : label, data.normalizedLogVolume j = c) :
    data = constant c := by
  have haverage :
      data.averageLogVolume = (constant (label := label) c).averageLogVolume :=
    average_eq_of_pointwise hpointwise
  cases data with
  | mk normalized average average_eq =>
      simp only [constant] at hpointwise haverage ⊢
      have hnormalized : normalized = fun _ => c :=
        funext hpointwise
      subst normalized
      subst average
      rfl

theorem const_le_average_of_forall_le
    [Nonempty label]
    (data : IUTStage1LabelAveragedProcessionLogVolume label)
    {c : Real}
    (hpointwise : ∀ j : label, c <= data.normalizedLogVolume j) :
    c <= data.averageLogVolume := by
  rw [data.average_eq]
  have hcard_nat : 0 < Fintype.card label := Fintype.card_pos
  have hcard_real : 0 < (Fintype.card label : Real) :=
    Nat.cast_pos.mpr hcard_nat
  rw [le_div_iff₀ hcard_real]
  have hsum :
      (Fintype.card label : Real) * c <=
        Finset.univ.sum data.normalizedLogVolume := by
    simpa [Finset.sum_const, nsmul_eq_mul] using
      (Finset.sum_le_sum (fun j _hj => hpointwise j) :
        Finset.univ.sum (fun _ : label => c) <=
          Finset.univ.sum data.normalizedLogVolume)
  simpa [mul_comm] using hsum

end IUTStage1LabelAveragedProcessionLogVolume

namespace IUTStage1WeightedLabelAveragedProcessionLogVolume

variable {label : Type u} [Fintype label]

theorem weightTotal_eq
    (data : IUTStage1WeightedLabelAveragedProcessionLogVolume label) :
    data.weightTotal = Finset.univ.sum data.weight :=
  data.weightTotal_eq_sum

theorem weightedAverage_eq_formula
    (data : IUTStage1WeightedLabelAveragedProcessionLogVolume label) :
    data.weightedAverageLogVolume =
      (Finset.univ.sum fun j => data.weight j * data.normalizedLogVolume j) /
        data.weightTotal :=
  data.weighted_average_eq

theorem weightedAverage_eq_of_pointwise
    {data₁ data₂ : IUTStage1WeightedLabelAveragedProcessionLogVolume label}
    (hweight : ∀ j : label, data₁.weight j = data₂.weight j)
    (hnormalized :
      ∀ j : label,
        data₁.normalizedLogVolume j =
          data₂.normalizedLogVolume j)
    (htotal : data₁.weightTotal = data₂.weightTotal) :
    data₁.weightedAverageLogVolume =
      data₂.weightedAverageLogVolume := by
  calc
    data₁.weightedAverageLogVolume =
        (Finset.univ.sum fun j =>
            data₁.weight j * data₁.normalizedLogVolume j) /
          data₁.weightTotal :=
      data₁.weighted_average_eq
    _ =
        (Finset.univ.sum fun j =>
            data₂.weight j * data₂.normalizedLogVolume j) /
          data₂.weightTotal := by
      rw [htotal]
      congr 1
      exact Finset.sum_congr rfl (by
        intro j _hj
        rw [hweight j, hnormalized j])
    _ = data₂.weightedAverageLogVolume :=
      data₂.weighted_average_eq.symm

theorem const_le_weightedAverage_of_forall_le
    (data : IUTStage1WeightedLabelAveragedProcessionLogVolume label)
    {c : Real}
    (hweight_nonnegative : ∀ j : label, 0 <= data.weight j)
    (hpointwise : ∀ j : label, c <= data.normalizedLogVolume j) :
    c <= data.weightedAverageLogVolume := by
  rw [data.weighted_average_eq]
  rw [le_div_iff₀ data.positive_weightTotal]
  have hsum :
      Finset.univ.sum (fun j : label => data.weight j * c) <=
        Finset.univ.sum
          (fun j : label => data.weight j * data.normalizedLogVolume j) := by
    exact Finset.sum_le_sum (by
      intro j _hj
      exact mul_le_mul_of_nonneg_left (hpointwise j) (hweight_nonnegative j))
  have hleft :
      c * data.weightTotal =
        Finset.univ.sum (fun j : label => data.weight j * c) := by
    rw [data.weightTotal_eq_sum, mul_comm c, Finset.sum_mul]
  calc
    c * data.weightTotal =
        Finset.univ.sum (fun j : label => data.weight j * c) :=
      hleft
    _ <=
        Finset.univ.sum
          (fun j : label => data.weight j * data.normalizedLogVolume j) :=
      hsum

end IUTStage1WeightedLabelAveragedProcessionLogVolume

namespace IUTStage1LabelAveragedProcessionLogVolume

variable {label : Type u} [Fintype label]

noncomputable def toWeighted
    (data : IUTStage1LabelAveragedProcessionLogVolume label)
    (weight : label -> Real)
    (weightTotal : Real)
    (positive_weightTotal : 0 < weightTotal)
    (weightTotal_eq_sum : weightTotal = Finset.univ.sum weight) :
    IUTStage1WeightedLabelAveragedProcessionLogVolume label :=
  { normalizedLogVolume := data.normalizedLogVolume,
    weight := weight,
    weightTotal := weightTotal,
    positive_weightTotal := positive_weightTotal,
    weightTotal_eq_sum := weightTotal_eq_sum,
    weightedAverageLogVolume :=
      (Finset.univ.sum fun j => weight j * data.normalizedLogVolume j) /
        weightTotal,
    weighted_average_eq := rfl }

theorem toWeighted_normalizedLogVolume_eq
    (data : IUTStage1LabelAveragedProcessionLogVolume label)
    (weight : label -> Real)
    (weightTotal : Real)
    (positive_weightTotal : 0 < weightTotal)
    (weightTotal_eq_sum : weightTotal = Finset.univ.sum weight)
    (j : label) :
    (data.toWeighted weight weightTotal positive_weightTotal
      weightTotal_eq_sum).normalizedLogVolume j =
      data.normalizedLogVolume j :=
  rfl

end IUTStage1LabelAveragedProcessionLogVolume

namespace IUTStage1ZModSquareWeightProfile

variable {l : PrimeGeFive}

def fromSquareWeights
    (l : PrimeGeFive)
    (positive_squareWeightTotal :
      0 < Finset.univ.sum (fun j : ZMod l.value => ((j.val : Real) ^ 2))) :
    IUTStage1ZModSquareWeightProfile l :=
  { weight := fun j => ((j.val : Real) ^ 2),
    weight_eq_square_val := by
      intro j
      rfl,
    weight_nonnegative := by
      intro j
      exact sq_nonneg (j.val : Real),
    weightTotal :=
      Finset.univ.sum (fun j : ZMod l.value => ((j.val : Real) ^ 2)),
    positive_weightTotal := positive_squareWeightTotal,
    weightTotal_eq_sum := rfl }

theorem weightTotal_eq
    (profile : IUTStage1ZModSquareWeightProfile l) :
    profile.weightTotal = Finset.univ.sum profile.weight :=
  profile.weightTotal_eq_sum

theorem profile_weight_eq_square_val
    (profile : IUTStage1ZModSquareWeightProfile l)
    (j : ZMod l.value) :
    profile.weight j = ((j.val : Real) ^ 2) :=
  profile.weight_eq_square_val j

theorem profile_weight_nonnegative
    (profile : IUTStage1ZModSquareWeightProfile l)
    (j : ZMod l.value) :
    0 <= profile.weight j :=
  profile.weight_nonnegative j

noncomputable def toWeighted
    (profile : IUTStage1ZModSquareWeightProfile l)
    (data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value)) :
    IUTStage1WeightedLabelAveragedProcessionLogVolume (ZMod l.value) :=
  data.toWeighted profile.weight profile.weightTotal
    profile.positive_weightTotal profile.weightTotal_eq_sum

theorem toWeighted_weight_eq_square_val
    (profile : IUTStage1ZModSquareWeightProfile l)
    (data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value))
    (j : ZMod l.value) :
    (profile.toWeighted data).weight j = ((j.val : Real) ^ 2) :=
  profile.weight_eq_square_val j

theorem toWeighted_const_le_weightedAverage_of_forall_le
    (profile : IUTStage1ZModSquareWeightProfile l)
    (data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value))
    {c : Real}
    (hpointwise : ∀ j : ZMod l.value, c <= data.normalizedLogVolume j) :
    c <= (profile.toWeighted data).weightedAverageLogVolume :=
  IUTStage1WeightedLabelAveragedProcessionLogVolume.const_le_weightedAverage_of_forall_le
      (profile.toWeighted data)
      (by intro j; exact profile.weight_nonnegative j)
      hpointwise

theorem toWeighted_normalizedLogVolume_eq_fullLabelLogVolume
    (profile : IUTStage1ZModSquareWeightProfile l)
    (data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value))
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (hcompat :
      ∀ j : ZMod l.value,
        data.normalizedLogVolume j = compat.normalizedLogVolume j)
    (j : ZMod l.value) :
    (profile.toWeighted data).normalizedLogVolume j =
      compat.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  calc
    (profile.toWeighted data).normalizedLogVolume j =
        data.normalizedLogVolume j :=
      rfl
    _ = compat.normalizedLogVolume j :=
      hcompat j
    _ =
        compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
      compat.normalizedLogVolume_eq_fullLabelLogVolume_fromCoordinate j

theorem toWeighted_weightedSummand_eq_square_fullLabelLogVolume
    (profile : IUTStage1ZModSquareWeightProfile l)
    (data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value))
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (hcompat :
      ∀ j : ZMod l.value,
        data.normalizedLogVolume j = compat.normalizedLogVolume j)
    (j : ZMod l.value) :
    (profile.toWeighted data).weight j *
        (profile.toWeighted data).normalizedLogVolume j =
      ((j.val : Real) ^ 2) *
        compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  rw [profile.toWeighted_weight_eq_square_val data j,
    profile.toWeighted_normalizedLogVolume_eq_fullLabelLogVolume
      data compat hcompat j]

theorem toWeighted_weightedAverage_eq_square_fullLabelLogVolume_sum
    (profile : IUTStage1ZModSquareWeightProfile l)
    (data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value))
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (hcompat :
      ∀ j : ZMod l.value,
        data.normalizedLogVolume j = compat.normalizedLogVolume j) :
    (profile.toWeighted data).weightedAverageLogVolume =
      (Finset.univ.sum fun j : ZMod l.value =>
        ((j.val : Real) ^ 2) *
          compat.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) /
        profile.weightTotal := by
  rw [(profile.toWeighted data).weightedAverage_eq_formula]
  congr 1
  exact Finset.sum_congr rfl (by
    intro j _hj
    exact profile.toWeighted_weightedSummand_eq_square_fullLabelLogVolume
      data compat hcompat j)

/--
Coordinate-level condition for transporting the square-weight profile.

The profile is not an anonymous weight function: it is tied to the chosen
`ZMod l.value` coordinate representative by `j.val ^ 2`.  Thus a coordinate
equivalence may be used in the square-weight branch only after one records that
it preserves these real square values.
-/
def CoordinateSquarePreserving
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value) : Prop :=
  ∀ j : ZMod l.value,
    (((coordinateEquiv j).val : Real) ^ 2) = ((j.val : Real) ^ 2)

/--
Coordinate-level preservation of the square map inside `ZMod l.value`.

This is weaker than `CoordinateSquarePreserving`: it records equality of the
finite-field square classes, not equality of the real representative squares
used by the current square-weight profile.
-/
def CoordinateModularSquarePreserving
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value) : Prop :=
  ∀ j : ZMod l.value, (coordinateEquiv j) ^ 2 = j ^ 2

/--
Sign-invariant real square profile built from the minimal absolute
representative of a `ZMod` class.

This is not the default Corollary 3.12 audit profile.  It is a separate
candidate profile used to keep track of what can be preserved by sign
symmetries without preserving the chosen nonnegative representative `j.val`.
-/
def balancedSquareWeight (j : ZMod l.value) : Real :=
  ((j.valMinAbs.natAbs : Real) ^ 2)

def CoordinateBalancedSquarePreserving
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value) : Prop :=
  ∀ j : ZMod l.value,
    balancedSquareWeight (l := l) (coordinateEquiv j) =
      balancedSquareWeight (l := l) j

theorem coordinateSquarePreserving_refl :
    CoordinateSquarePreserving (l := l) (Equiv.refl (ZMod l.value)) := by
  intro j
  rfl

theorem coordinateModularSquarePreserving_refl :
    CoordinateModularSquarePreserving
      (l := l) (Equiv.refl (ZMod l.value)) := by
  intro j
  rfl

theorem coordinateModularSquarePreserving_neg :
    CoordinateModularSquarePreserving
      (l := l) (Equiv.neg (ZMod l.value)) := by
  intro j
  change (-j) ^ 2 = j ^ 2
  simp [pow_two]

theorem balancedSquareWeight_neg_eq (j : ZMod l.value) :
    balancedSquareWeight (l := l) (-j) =
      balancedSquareWeight (l := l) j := by
  unfold balancedSquareWeight
  rw [ZMod.natAbs_valMinAbs_neg]

noncomputable def balancedSquareWeightOnSignQuotient
    (label : (zmodSignAction l).SignLabelQuotient) : Real :=
  Quotient.lift
    (fun x : (zmodPointedQuotient l).NonzeroCarrier =>
      balancedSquareWeight (l := l) x.1)
    (by
      intro x y h
      change balancedSquareWeight (l := l) x.1 =
        balancedSquareWeight (l := l) y.1
      rcases h with h | h
      · rw [h]
      · rw [h]
        exact balancedSquareWeight_neg_eq y.1)
    label

theorem balancedSquareWeightOnSignQuotient_fromCoordinate
    (j : ZMod l.value) (hj : j ≠ 0) :
    balancedSquareWeightOnSignQuotient
        (l := l) (zmodSignLabelFromCoordinate l j hj) =
      balancedSquareWeight (l := l) j := by
  unfold balancedSquareWeightOnSignQuotient zmodSignLabelFromCoordinate
  change balancedSquareWeight (l := l)
      (zmodNonzeroLabelFromCoordinate l j hj).1 =
    balancedSquareWeight (l := l) j
  rw [zmodNonzeroLabelFromCoordinate_val]

theorem balancedSquareWeight_zero :
    balancedSquareWeight (l := l) (0 : ZMod l.value) = 0 := by
  unfold balancedSquareWeight
  simp

noncomputable def balancedSquareWeightOnFullLabel :
    IUTStage1ZModCuspFullLabel l -> Real
  | IUTStage1ZModCuspFullLabel.zero => 0
  | IUTStage1ZModCuspFullLabel.nonzero label =>
      balancedSquareWeightOnSignQuotient (l := l) label

theorem balancedSquareWeightOnFullLabel_fromCoordinate
    (j : ZMod l.value) :
    balancedSquareWeightOnFullLabel
        (l := l) (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      balancedSquareWeight (l := l) j := by
  by_cases hj : j = 0
  · subst j
    rw [IUTStage1ZModCuspFullLabel.fromCoordinate_zero]
    exact balancedSquareWeight_zero.symm
  · rw [IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero l j hj]
    exact balancedSquareWeightOnSignQuotient_fromCoordinate j hj

noncomputable def balancedFullLabelWeightedSummand
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (label : IUTStage1ZModCuspFullLabel l) : Real :=
  balancedSquareWeightOnFullLabel (l := l) label *
    compat.fullLabelLogVolume label

theorem balancedFullLabelWeightedSummand_fromCoordinate
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) :
    balancedFullLabelWeightedSummand
        (l := l) compat
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      balancedSquareWeight (l := l) j * compat.normalizedLogVolume j := by
  unfold balancedFullLabelWeightedSummand
  rw [balancedSquareWeightOnFullLabel_fromCoordinate]
  rw [compat.normalizedLogVolume_eq_fullLabelLogVolume_fromCoordinate]

theorem fullLabelSummand_preserved_of_fullLabelMap
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hmap :
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) coordinateEquiv)
    (sourceSummand targetSummand : IUTStage1ZModCuspFullLabel l -> Real)
    (hvalue :
      ∀ label : IUTStage1ZModCuspFullLabel l,
        targetSummand label = sourceSummand label) :
    ∀ j : ZMod l.value,
      targetSummand
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j)) =
        sourceSummand (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  intro j
  rw [hmap j]
  exact hvalue (IUTStage1ZModCuspFullLabel.fromCoordinate l j)

theorem balancedFullLabelWeightedSummand_preserved_of_fullLabelMap
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hmap :
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) coordinateEquiv)
    (sourceLogVolume targetLogVolume :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (hvalue :
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelLogVolumeValuePreserving
        sourceLogVolume targetLogVolume) :
    ∀ j : ZMod l.value,
      balancedFullLabelWeightedSummand (l := l) targetLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j)) =
        balancedFullLabelWeightedSummand (l := l) sourceLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  intro j
  unfold balancedFullLabelWeightedSummand
  rw [hmap j]
  rw [hvalue (IUTStage1ZModCuspFullLabel.fromCoordinate l j)]

theorem balancedSquareWeight_eq_square_val_of_val_le_half
    (j : ZMod l.value) (hhalf : j.val ≤ l.value / 2) :
    balancedSquareWeight (l := l) j = ((j.val : Real) ^ 2) := by
  unfold balancedSquareWeight
  rw [ZMod.valMinAbs_natAbs_eq_min]
  have hcomp : j.val ≤ l.value - j.val := by
    omega
  rw [Nat.min_eq_left hcomp]

theorem coordinateBalancedSquarePreserving_refl :
    CoordinateBalancedSquarePreserving
      (l := l) (Equiv.refl (ZMod l.value)) := by
  intro j
  rfl

theorem coordinateBalancedSquarePreserving_neg :
    CoordinateBalancedSquarePreserving
      (l := l) (Equiv.neg (ZMod l.value)) := by
  intro j
  exact balancedSquareWeight_neg_eq j

/--
Rigidity of the current real representative-square profile.

Since `ZMod.val` takes nonnegative representatives, equality of real squares
forces equality of representatives.
-/
theorem coordinateSquarePreserving_val_eq
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hcoord : CoordinateSquarePreserving (l := l) coordinateEquiv) :
    ∀ j : ZMod l.value, (coordinateEquiv j).val = j.val := by
  intro j
  have hsq := hcoord j
  have heq_or := sq_eq_sq_iff_eq_or_eq_neg.mp hsq
  rcases heq_or with heq | hneg
  · exact_mod_cast heq
  · have hleft_nonneg : (0 : Real) <= ((coordinateEquiv j).val : Real) := by
      exact_mod_cast Nat.zero_le _
    have hright_nonneg : (0 : Real) <= ((j.val) : Real) := by
      exact_mod_cast Nat.zero_le _
    have hleft_zero : (((coordinateEquiv j).val : Real)) = 0 := by
      nlinarith
    have hright_zero : (((j.val) : Real)) = 0 := by
      nlinarith
    exact_mod_cast hleft_zero.trans hright_zero.symm

theorem coordinateSquarePreserving_apply_eq
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hcoord : CoordinateSquarePreserving (l := l) coordinateEquiv) :
    ∀ j : ZMod l.value, coordinateEquiv j = j := by
  intro j
  exact ZMod.val_injective l.value
    (coordinateSquarePreserving_val_eq hcoord j)

theorem coordinateSquarePreserving_eq_refl
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hcoord : CoordinateSquarePreserving (l := l) coordinateEquiv) :
    coordinateEquiv = Equiv.refl (ZMod l.value) := by
  ext j
  exact coordinateSquarePreserving_apply_eq hcoord j

theorem neg_one_ne_one :
    (-(1 : ZMod l.value)) ≠ (1 : ZMod l.value) := by
  intro h
  haveI : Fact (1 < l.value) :=
    ⟨lt_of_lt_of_le (by norm_num) l.ge_five⟩
  have hval := congrArg ZMod.val h
  have hOneNe : (1 : ZMod l.value) ≠ 0 := one_ne_zero
  haveI : NeZero (1 : ZMod l.value) := ⟨hOneNe⟩
  rw [ZMod.val_neg_of_ne_zero, ZMod.val_one] at hval
  have hge : 5 ≤ l.value := l.ge_five
  omega

theorem not_coordinateSquarePreserving_neg :
    ¬ CoordinateSquarePreserving
      (l := l) (Equiv.neg (ZMod l.value)) := by
  intro hcoord
  exact neg_one_ne_one
    (coordinateSquarePreserving_apply_eq hcoord (1 : ZMod l.value))

theorem coordinateModularSquarePreserving_neg_and_not_coordinateSquarePreserving_neg :
    CoordinateModularSquarePreserving
        (l := l) (Equiv.neg (ZMod l.value)) ∧
      ¬ CoordinateSquarePreserving
        (l := l) (Equiv.neg (ZMod l.value)) :=
  ⟨coordinateModularSquarePreserving_neg,
    not_coordinateSquarePreserving_neg⟩

theorem coordinateSquarePreserving_neg_of_representativeSquareWeightOnSignQuotient
    (weightOnQuotient : (zmodSignAction l).SignLabelQuotient -> Real)
    (hweight :
      ∀ (j : ZMod l.value) (hj : j ≠ 0),
        weightOnQuotient (zmodSignLabelFromCoordinate l j hj) =
          ((j.val : Real) ^ 2)) :
    CoordinateSquarePreserving
      (l := l) (Equiv.neg (ZMod l.value)) := by
  intro j
  by_cases hj : j = 0
  · subst j
    simp
  · have hneg : -j ≠ 0 := zmod_neg_ne_zero_of_ne_zero l hj
    change (((-j).val : Real) ^ 2) = ((j.val : Real) ^ 2)
    calc
      (((-j).val : Real) ^ 2) =
          weightOnQuotient (zmodSignLabelFromCoordinate l (-j) hneg) := by
        exact (hweight (-j) hneg).symm
      _ = weightOnQuotient (zmodSignLabelFromCoordinate l j hj) := by
        rw [zmodSignLabelFromCoordinate_neg_eq]
      _ = ((j.val : Real) ^ 2) :=
        hweight j hj

theorem not_exists_representativeSquareWeightOnSignQuotient :
    ¬ ∃ weightOnQuotient : (zmodSignAction l).SignLabelQuotient -> Real,
      ∀ (j : ZMod l.value) (hj : j ≠ 0),
        weightOnQuotient (zmodSignLabelFromCoordinate l j hj) =
          ((j.val : Real) ^ 2) := by
  rintro ⟨weightOnQuotient, hweight⟩
  exact not_coordinateSquarePreserving_neg
    (coordinateSquarePreserving_neg_of_representativeSquareWeightOnSignQuotient
      weightOnQuotient hweight)

theorem not_exists_representativeSquareWeightOnFullLabel :
    ¬ ∃ weightOnFullLabel : IUTStage1ZModCuspFullLabel l -> Real,
      ∀ j : ZMod l.value,
        weightOnFullLabel (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          ((j.val : Real) ^ 2) := by
  rintro ⟨weightOnFullLabel, hweight⟩
  exact not_exists_representativeSquareWeightOnSignQuotient
    ⟨fun label =>
        weightOnFullLabel (IUTStage1ZModCuspFullLabel.nonzero label),
      by
        intro j hj
        change weightOnFullLabel
            (IUTStage1ZModCuspFullLabel.nonzero
              (zmodSignLabelFromCoordinate l j hj)) =
          ((j.val : Real) ^ 2)
        rw [← IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero l j hj]
        exact hweight j⟩

theorem not_exists_representativeSquareUnitSummandOnFullLabel :
    ¬ ∃ summandOnFullLabel : IUTStage1ZModCuspFullLabel l -> Real,
      ∀ j : ZMod l.value,
        summandOnFullLabel (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          ((j.val : Real) ^ 2) *
            (IUTStage1ZModCuspLabelLogVolumeCompatibility.constant
              (l := l) (1 : Real)).fullLabelLogVolume
                (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  rintro ⟨summandOnFullLabel, hsummand⟩
  exact not_exists_representativeSquareWeightOnFullLabel
    ⟨summandOnFullLabel, by
      intro j
      have h := hsummand j
      rw [IUTStage1ZModCuspLabelLogVolumeCompatibility.constant_fullLabelLogVolume_fromCoordinate
        (l := l) (1 : Real) j] at h
      simpa using h⟩

theorem squareWeight_preserved_of_coordinateSquarePreserving
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hcoord : CoordinateSquarePreserving (l := l) coordinateEquiv) :
    ∀ j : ZMod l.value,
      targetProfile.weight (coordinateEquiv j) =
        sourceProfile.weight j := by
  intro j
  rw [targetProfile.weight_eq_square_val, sourceProfile.weight_eq_square_val]
  exact hcoord j

theorem coordinateSquarePreserving_of_squareWeight_preserved
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hweight :
      ∀ j : ZMod l.value,
        targetProfile.weight (coordinateEquiv j) =
          sourceProfile.weight j) :
    CoordinateSquarePreserving (l := l) coordinateEquiv := by
  intro j
  have h := hweight j
  rw [targetProfile.weight_eq_square_val, sourceProfile.weight_eq_square_val] at h
  exact h

theorem squareWeight_preserved_iff_coordinateSquarePreserving
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value) :
    (∀ j : ZMod l.value,
      targetProfile.weight (coordinateEquiv j) =
        sourceProfile.weight j) ↔
      CoordinateSquarePreserving (l := l) coordinateEquiv := by
  constructor
  · exact coordinateSquarePreserving_of_squareWeight_preserved
      sourceProfile targetProfile
  · exact squareWeight_preserved_of_coordinateSquarePreserving
      sourceProfile targetProfile

theorem weightTotal_preserved_of_squareWeight_preserved
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (hweight :
      ∀ j : ZMod l.value,
        targetProfile.weight (coordinateEquiv j) =
          sourceProfile.weight j) :
    targetProfile.weightTotal = sourceProfile.weightTotal := by
  rw [targetProfile.weightTotal_eq_sum, sourceProfile.weightTotal_eq_sum]
  have hsum :
      Finset.univ.sum sourceProfile.weight =
        Finset.univ.sum targetProfile.weight :=
    Fintype.sum_equiv coordinateEquiv
      sourceProfile.weight targetProfile.weight
      (fun j => (hweight j).symm)
  exact hsum.symm

theorem weightTotal_preserved_of_coordinateSquarePreserving
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    {coordinateEquiv : ZMod l.value ≃ ZMod l.value}
    (hcoord : CoordinateSquarePreserving (l := l) coordinateEquiv) :
    targetProfile.weightTotal = sourceProfile.weightTotal :=
  weightTotal_preserved_of_squareWeight_preserved
    sourceProfile targetProfile coordinateEquiv
    (squareWeight_preserved_of_coordinateSquarePreserving
      sourceProfile targetProfile hcoord)

end IUTStage1ZModSquareWeightProfile

/--
Audit that square-weighted full-label summands survive a Hodge-theater/descent
bridge along an explicit coordinate equivalence.

This record does not construct the bridge.  It states exactly what a future
Hodge-theater/log-link argument must supply before one may compare transported
`j^2`-weighted summands: preservation of the full-label log-volume branch,
preservation of the square weight, and preservation of the total weight.
-/
structure IUTStage1ZModSquareWeightedFullLabelTransportAudit
    (l : PrimeGeFive) where
  bridge : IUTStage1HodgeTheaterDescentBridgeData
  coordinateEquiv : ZMod l.value ≃ ZMod l.value
  sourceProfile : IUTStage1ZModSquareWeightProfile l
  targetProfile : IUTStage1ZModSquareWeightProfile l
  sourceLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  targetLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  fullLabelLogVolume_preserved :
    ∀ j : ZMod l.value,
      targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j)) =
        sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
  squareWeight_preserved :
    ∀ j : ZMod l.value,
      targetProfile.weight (coordinateEquiv j) =
        sourceProfile.weight j
  weightTotal_preserved :
    targetProfile.weightTotal = sourceProfile.weightTotal

namespace IUTStage1ZModSquareWeightedFullLabelTransportAudit

variable {l : PrimeGeFive}

def sourceNumerator
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    Real :=
  Finset.univ.sum fun j : ZMod l.value =>
    audit.sourceProfile.weight j *
      audit.sourceLogVolume.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j)

def targetTransportedNumerator
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    Real :=
  Finset.univ.sum fun j : ZMod l.value =>
    audit.targetProfile.weight (audit.coordinateEquiv j) *
      audit.targetLogVolume.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (audit.coordinateEquiv j))

noncomputable def sourceAverage
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    Real :=
  audit.sourceNumerator / audit.sourceProfile.weightTotal

noncomputable def targetTransportedAverage
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    Real :=
  audit.targetTransportedNumerator / audit.targetProfile.weightTotal

theorem histories_not_identified
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    audit.bridge.domainTheater.side ≠ audit.bridge.codomainTheater.side :=
  audit.bridge.histories_not_identified

theorem transportedFullLabelLogVolume_preserved
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l)
    (j : ZMod l.value) :
    audit.targetLogVolume.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (audit.coordinateEquiv j)) =
      audit.sourceLogVolume.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  audit.fullLabelLogVolume_preserved j

theorem transportedSquareWeight_preserved
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l)
    (j : ZMod l.value) :
    audit.targetProfile.weight (audit.coordinateEquiv j) =
      audit.sourceProfile.weight j :=
  audit.squareWeight_preserved j

theorem targetTransportedSummand_eq_sourceSummand
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l)
    (j : ZMod l.value) :
    audit.targetProfile.weight (audit.coordinateEquiv j) *
      audit.targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (audit.coordinateEquiv j)) =
      audit.sourceProfile.weight j *
        audit.sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  rw [audit.transportedSquareWeight_preserved j,
    audit.transportedFullLabelLogVolume_preserved j]

theorem targetTransportedNumerator_eq_sourceNumerator
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    audit.targetTransportedNumerator = audit.sourceNumerator := by
  unfold targetTransportedNumerator sourceNumerator
  exact Finset.sum_congr rfl (by
    intro j _hj
    exact audit.targetTransportedSummand_eq_sourceSummand j)

theorem targetTransportedAverage_eq_sourceAverage
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    audit.targetTransportedAverage = audit.sourceAverage := by
  unfold targetTransportedAverage sourceAverage
  rw [audit.targetTransportedNumerator_eq_sourceNumerator,
    audit.weightTotal_preserved]

end IUTStage1ZModSquareWeightedFullLabelTransportAudit

namespace IUTStage1CapsuleFamilyLogVolume

variable {kind : IUTStage1PlaceKind}

theorem total_eq
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    data.totalLogVolume = Finset.univ.sum data.capsuleLogVolume :=
  data.total_eq_sum

theorem normalized_eq
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    data.normalizedLogVolume =
      data.totalLogVolume / (data.capsuleCount : Real) :=
  data.normalized_eq_average

theorem capsuleCount_pos
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    0 < data.capsuleCount :=
  data.positive_capsule_count

def toProcessionNormalizedLogVolume
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    IUTStage1ProcessionNormalizedLogVolume kind :=
  { localObject := data.localObject,
    capsuleCount := data.capsuleCount,
    positive_capsule_count := data.positive_capsule_count,
    totalLogVolume := data.totalLogVolume,
    normalizedLogVolume := data.normalizedLogVolume,
    normalized_eq_average := data.normalized_eq_average }

theorem toProcession_total_eq
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    data.toProcessionNormalizedLogVolume.totalLogVolume =
      Finset.univ.sum data.capsuleLogVolume :=
  data.total_eq

end IUTStage1CapsuleFamilyLogVolume

namespace IUTStage1CapsuleLogVolumeObject

variable {kind : IUTStage1PlaceKind}

theorem logVolume_eq
    (capsule : IUTStage1CapsuleLogVolumeObject kind) :
    capsule.logVolume = capsule.localObject.finiteLogVolume :=
  capsule.log_volume_eq

end IUTStage1CapsuleLogVolumeObject

/--
Container estimate for one capsule log-volume entry.

The local object used by the estimate must match the local object carried by
the capsule entry.
-/
structure IUTStage1CapsuleEntryContainerEstimate
    {kind : IUTStage1PlaceKind}
    (targetSigned : Real)
    (capsule : IUTStage1CapsuleLogVolumeObject kind) where
  objectEstimate :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned capsule.logVolume
  localObject_eq_capsuleLocalObject :
    objectEstimate.localObject = capsule.localObject

namespace IUTStage1CapsuleEntryContainerEstimate

variable {kind : IUTStage1PlaceKind}
variable {targetSigned : Real}
variable {capsule : IUTStage1CapsuleLogVolumeObject kind}

theorem targetSigned_le_capsuleLogVolume
    (estimate :
      IUTStage1CapsuleEntryContainerEstimate targetSigned capsule) :
    targetSigned <= capsule.logVolume :=
  estimate.objectEstimate.targetSigned_le_localLogVolume

theorem localObject_eq_capsuleLocalObject'
    (estimate :
      IUTStage1CapsuleEntryContainerEstimate targetSigned capsule) :
    estimate.objectEstimate.localObject = capsule.localObject :=
  estimate.localObject_eq_capsuleLocalObject

def transportCapsule
    (estimate :
      IUTStage1CapsuleEntryContainerEstimate targetSigned capsule)
    (newCapsule : IUTStage1CapsuleLogVolumeObject kind)
    (hlog : newCapsule.logVolume = capsule.logVolume)
    (hobject : estimate.objectEstimate.localObject = newCapsule.localObject) :
    IUTStage1CapsuleEntryContainerEstimate targetSigned newCapsule :=
  { objectEstimate := estimate.objectEstimate.transportLocalLogVolume hlog,
    localObject_eq_capsuleLocalObject := hobject }

end IUTStage1CapsuleEntryContainerEstimate

/-- Container estimates for every entry of a typed capsule family. -/
structure IUTStage1TypedCapsuleFamilyContainerEstimate
    {kind : IUTStage1PlaceKind}
    (targetSigned : Real)
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) where
  capsuleEntryEstimate :
    ∀ i : Fin data.capsuleCount,
      IUTStage1CapsuleEntryContainerEstimate targetSigned (data.capsule i)

namespace IUTStage1TypedCapsuleFamilyLogVolume

variable {kind : IUTStage1PlaceKind}

theorem capsuleLocalObject_eq
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind)
    (i : Fin data.capsuleCount) :
    (data.capsule i).localObject = data.localObject :=
  data.capsule_local_object_eq i

theorem total_eq
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    data.totalLogVolume =
      Finset.univ.sum fun i => (data.capsule i).logVolume :=
  data.total_eq_sum

theorem normalized_eq
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    data.normalizedLogVolume =
      data.totalLogVolume / (data.capsuleCount : Real) :=
  data.normalized_eq_average

theorem capsuleCount_pos
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    0 < data.capsuleCount :=
  data.positive_capsule_count

def toCapsuleFamilyLogVolume
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    IUTStage1CapsuleFamilyLogVolume kind :=
  { localObject := data.localObject,
    capsuleCount := data.capsuleCount,
    positive_capsule_count := data.positive_capsule_count,
    capsuleLogVolume := fun i => (data.capsule i).logVolume,
    totalLogVolume := data.totalLogVolume,
    total_eq_sum := data.total_eq_sum,
    normalizedLogVolume := data.normalizedLogVolume,
    normalized_eq_average := data.normalized_eq_average }

theorem toCapsuleFamily_total_eq
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    data.toCapsuleFamilyLogVolume.totalLogVolume =
      Finset.univ.sum data.toCapsuleFamilyLogVolume.capsuleLogVolume :=
  data.toCapsuleFamilyLogVolume.total_eq

def toLabelAveragedCapsuleLogVolume
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    IUTStage1LabelAveragedProcessionLogVolume (Fin data.capsuleCount) :=
  { normalizedLogVolume := fun i => (data.capsule i).logVolume,
    averageLogVolume := data.normalizedLogVolume,
    average_eq := by
      calc
        data.normalizedLogVolume =
            data.totalLogVolume / (data.capsuleCount : Real) :=
          data.normalized_eq
        _ =
            (Finset.univ.sum fun i => (data.capsule i).logVolume) /
              (data.capsuleCount : Real) := by
          rw [data.total_eq]
        _ =
            (Finset.univ.sum fun i => (data.capsule i).logVolume) /
              (Fintype.card (Fin data.capsuleCount) : Real) := by
          simp }

theorem const_le_normalizedLogVolume_of_capsule_le
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind)
    {c : Real}
    (hcapsule : ∀ i : Fin data.capsuleCount, c <= (data.capsule i).logVolume) :
    c <= data.normalizedLogVolume := by
  let averaged := data.toLabelAveragedCapsuleLogVolume
  haveI : Nonempty (Fin data.capsuleCount) :=
    ⟨⟨0, data.capsuleCount_pos⟩⟩
  exact
    IUTStage1LabelAveragedProcessionLogVolume.const_le_average_of_forall_le
      averaged hcapsule

end IUTStage1TypedCapsuleFamilyLogVolume

namespace IUTStage1TypedCapsuleFamilyContainerEstimate

variable {kind : IUTStage1PlaceKind}
variable {targetSigned : Real}
variable {data : IUTStage1TypedCapsuleFamilyLogVolume kind}

theorem targetSigned_le_capsuleLogVolume
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate targetSigned data)
    (i : Fin data.capsuleCount) :
    targetSigned <= (data.capsule i).logVolume :=
  (estimate.capsuleEntryEstimate i).targetSigned_le_capsuleLogVolume

theorem targetSigned_le_normalizedLogVolume
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate targetSigned data) :
    targetSigned <= data.normalizedLogVolume :=
  data.const_le_normalizedLogVolume_of_capsule_le
    estimate.targetSigned_le_capsuleLogVolume

end IUTStage1TypedCapsuleFamilyContainerEstimate

/--
An action on the indexed capsules of a typed capsule family that preserves each
individual capsule log-volume.

This is a conservative proxy for the local tensor-factor symmetries of
Theorem 3.11 `(Ind2)`: the action may replace capsule representatives, but it
does not change the finite index type, local object, or per-capsule log-volume.
-/
structure IUTStage1TypedCapsuleFamilyLogVolumeAction
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) where
  capsule : Fin data.capsuleCount -> IUTStage1CapsuleLogVolumeObject kind
  capsule_local_object_eq :
    ∀ i : Fin data.capsuleCount, (capsule i).localObject = data.localObject
  logVolume_eq :
    ∀ i : Fin data.capsuleCount,
      (capsule i).logVolume = (data.capsule i).logVolume

namespace IUTStage1TypedCapsuleFamilyLogVolumeAction

variable {kind : IUTStage1PlaceKind}
variable {data : IUTStage1TypedCapsuleFamilyLogVolume kind}

def transformedFamily
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    IUTStage1TypedCapsuleFamilyLogVolume kind :=
  { localObject := data.localObject,
    capsuleCount := data.capsuleCount,
    positive_capsule_count := data.positive_capsule_count,
    capsule := action.capsule,
    capsule_local_object_eq := action.capsule_local_object_eq,
    totalLogVolume := data.totalLogVolume,
    total_eq_sum := by
      rw [data.total_eq_sum]
      exact Finset.sum_congr rfl
        (by
          intro i _hi
          exact (action.logVolume_eq i).symm),
    normalizedLogVolume := data.normalizedLogVolume,
    normalized_eq_average := data.normalized_eq_average }

theorem transformedFamily_capsuleCount
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    action.transformedFamily.capsuleCount = data.capsuleCount :=
  rfl

theorem transformedFamily_totalLogVolume
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    action.transformedFamily.totalLogVolume = data.totalLogVolume :=
  rfl

theorem transformedFamily_normalizedLogVolume
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    action.transformedFamily.normalizedLogVolume =
      data.normalizedLogVolume :=
  rfl

theorem transformedFamily_total_eq_sum
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    action.transformedFamily.totalLogVolume =
      Finset.univ.sum fun i =>
        (action.transformedFamily.capsule i).logVolume :=
  action.transformedFamily.total_eq

def transformedContainerEstimate
    {targetSigned : Real}
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate targetSigned data) :
    IUTStage1TypedCapsuleFamilyContainerEstimate
      targetSigned action.transformedFamily :=
  { capsuleEntryEstimate := by
      intro i
      exact
        (estimate.capsuleEntryEstimate i).transportCapsule
          (action.transformedFamily.capsule i)
          (action.logVolume_eq i)
          (by
            calc
              (estimate.capsuleEntryEstimate i).objectEstimate.localObject =
                  (data.capsule i).localObject :=
                (estimate.capsuleEntryEstimate i).localObject_eq_capsuleLocalObject'
              _ = data.localObject :=
                data.capsuleLocalObject_eq i
              _ = (action.transformedFamily.capsule i).localObject :=
                (action.capsule_local_object_eq i).symm) }

theorem transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    {targetSigned : Real}
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate targetSigned data) :
    targetSigned <= action.transformedFamily.normalizedLogVolume :=
  let transformedEstimate := action.transformedContainerEstimate estimate
  transformedEstimate.targetSigned_le_normalizedLogVolume

end IUTStage1TypedCapsuleFamilyLogVolumeAction

/--
The two local tensor symmetry sources singled out in Theorem 3.11 `(Ind2)`.
-/
inductive IUTStage1TensorSummandSymmetryKind where
  | nonarchimedeanIsm
  | archimedeanOrderTwo
deriving DecidableEq, Repr

/-- A direct summand representative tied to a capsule log-volume object. -/
structure IUTStage1TensorDirectSummandObject
    (kind : IUTStage1PlaceKind) where
  summandLabel : String
  localObject : IUTStage1FiniteLocalLogVolumeObject kind
  capsule : IUTStage1CapsuleLogVolumeObject kind
  capsule_local_object_eq : capsule.localObject = localObject

/--
Direct summand data indexed by the same finite type as a typed capsule family.

The shared index type is intentional: it records the current formalization
invariant that local tensor direct summands and capsule entries are counted
together, while avoiding an unsafe identification of independently supplied
finite sets.
-/
structure IUTStage1TensorDirectSummandFamily
    {kind : IUTStage1PlaceKind}
    (capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind) where
  symmetryKind : IUTStage1TensorSummandSymmetryKind
  summand :
    Fin capsuleFamily.capsuleCount ->
      IUTStage1TensorDirectSummandObject kind
  summand_local_object_eq :
    ∀ i : Fin capsuleFamily.capsuleCount,
      (summand i).localObject = capsuleFamily.localObject
  summand_capsule_eq :
    ∀ i : Fin capsuleFamily.capsuleCount,
      (summand i).capsule = capsuleFamily.capsule i

namespace IUTStage1TensorDirectSummandObject

variable {kind : IUTStage1PlaceKind}

theorem capsuleLocalObject_eq
    (summand : IUTStage1TensorDirectSummandObject kind) :
    summand.capsule.localObject = summand.localObject :=
  summand.capsule_local_object_eq

theorem logVolume_eq_capsule
    (summand : IUTStage1TensorDirectSummandObject kind) :
    summand.capsule.logVolume = summand.localObject.finiteLogVolume := by
  calc
    summand.capsule.logVolume =
        summand.capsule.localObject.finiteLogVolume :=
      summand.capsule.logVolume_eq
    _ = summand.localObject.finiteLogVolume := by
      rw [summand.capsuleLocalObject_eq]

end IUTStage1TensorDirectSummandObject

namespace IUTStage1TensorDirectSummandFamily

variable {kind : IUTStage1PlaceKind}
variable {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}

theorem summandLocalObject_eq
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily)
    (i : Fin capsuleFamily.capsuleCount) :
    (family.summand i).localObject = capsuleFamily.localObject :=
  family.summand_local_object_eq i

theorem summandCapsule_eq
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily)
    (i : Fin capsuleFamily.capsuleCount) :
    (family.summand i).capsule = capsuleFamily.capsule i :=
  family.summand_capsule_eq i

theorem summandCapsuleLogVolume_eq
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily)
    (i : Fin capsuleFamily.capsuleCount) :
    (family.summand i).capsule.logVolume =
      (capsuleFamily.capsule i).logVolume := by
  rw [family.summandCapsule_eq i]

end IUTStage1TensorDirectSummandFamily

/--
Action on direct summand representatives that induces an action on capsule
representatives.
-/
structure IUTStage1TensorDirectSummandFamilyAction
    {kind : IUTStage1PlaceKind}
    {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily) where
  transformedSummand :
    Fin capsuleFamily.capsuleCount ->
      IUTStage1TensorDirectSummandObject kind
  transformed_capsule_local_object_eq :
    ∀ i : Fin capsuleFamily.capsuleCount,
      (transformedSummand i).capsule.localObject = capsuleFamily.localObject
  transformed_capsule_logVolume_eq :
    ∀ i : Fin capsuleFamily.capsuleCount,
      (transformedSummand i).capsule.logVolume =
        (capsuleFamily.capsule i).logVolume

namespace IUTStage1TensorDirectSummandFamilyAction

variable {kind : IUTStage1PlaceKind}
variable {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
variable {family : IUTStage1TensorDirectSummandFamily capsuleFamily}

def toCapsuleAction
    (action : IUTStage1TensorDirectSummandFamilyAction family) :
    IUTStage1TypedCapsuleFamilyLogVolumeAction capsuleFamily :=
  { capsule := fun i => (action.transformedSummand i).capsule,
    capsule_local_object_eq :=
      action.transformed_capsule_local_object_eq,
    logVolume_eq :=
      action.transformed_capsule_logVolume_eq }

theorem toCapsuleAction_totalLogVolume
    (action : IUTStage1TensorDirectSummandFamilyAction family) :
    action.toCapsuleAction.transformedFamily.totalLogVolume =
      capsuleFamily.totalLogVolume :=
  action.toCapsuleAction.transformedFamily_totalLogVolume

theorem toCapsuleAction_normalizedLogVolume
    (action : IUTStage1TensorDirectSummandFamilyAction family) :
    action.toCapsuleAction.transformedFamily.normalizedLogVolume =
      capsuleFamily.normalizedLogVolume :=
  action.toCapsuleAction.transformedFamily_normalizedLogVolume

def transformedContainerEstimate
    {targetSigned : Real}
    (action : IUTStage1TensorDirectSummandFamilyAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    IUTStage1TypedCapsuleFamilyContainerEstimate
      targetSigned action.toCapsuleAction.transformedFamily :=
  action.toCapsuleAction.transformedContainerEstimate estimate

theorem transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    {targetSigned : Real}
    (action : IUTStage1TensorDirectSummandFamilyAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    targetSigned <= action.toCapsuleAction.transformedFamily.normalizedLogVolume :=
  let capsuleAction := action.toCapsuleAction
  capsuleAction.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    estimate

end IUTStage1TensorDirectSummandFamilyAction

/--
Nonarchimedean `Ism` action surface for Theorem 3.11 `(Ind2)`.

The actual `Ism` group is not yet constructed; this record isolates the
nonarchimedean case and requires the associated direct-summand action.
-/
structure IUTStage1NonarchimedeanIsmDirectSummandAction
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume
        IUTStage1PlaceKind.nonarchimedean}
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily) where
  place : IUTStage1PlaceId IUTStage1PlaceKind.nonarchimedean
  symmetry_kind_eq :
    family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.nonarchimedeanIsm
  action : IUTStage1TensorDirectSummandFamilyAction family

/--
Archimedean order-two action surface for Theorem 3.11 `(Ind2)`.

The actual order-two automorphism is not yet constructed; this record isolates
the archimedean case and requires the associated direct-summand action.
-/
structure IUTStage1ArchimedeanOrderTwoDirectSummandAction
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume
        IUTStage1PlaceKind.archimedean}
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily) where
  place : IUTStage1PlaceId IUTStage1PlaceKind.archimedean
  symmetry_kind_eq :
    family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.archimedeanOrderTwo
  action : IUTStage1TensorDirectSummandFamilyAction family

namespace IUTStage1NonarchimedeanIsmDirectSummandAction

variable
  {capsuleFamily :
    IUTStage1TypedCapsuleFamilyLogVolume
      IUTStage1PlaceKind.nonarchimedean}
variable {family : IUTStage1TensorDirectSummandFamily capsuleFamily}

def toDirectSummandAction
    (data : IUTStage1NonarchimedeanIsmDirectSummandAction family) :
    IUTStage1TensorDirectSummandFamilyAction family :=
  data.action

theorem symmetryKind_eq
    (data : IUTStage1NonarchimedeanIsmDirectSummandAction family) :
    family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.nonarchimedeanIsm :=
  data.symmetry_kind_eq

theorem capsuleTotalLogVolume_eq
    (data : IUTStage1NonarchimedeanIsmDirectSummandAction family) :
    data.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      capsuleFamily.totalLogVolume :=
  data.toDirectSummandAction.toCapsuleAction_totalLogVolume

theorem transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    {targetSigned : Real}
    (data : IUTStage1NonarchimedeanIsmDirectSummandAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    targetSigned <=
      data.toDirectSummandAction.toCapsuleAction.transformedFamily.normalizedLogVolume :=
  let action := data.toDirectSummandAction
  action.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    estimate

end IUTStage1NonarchimedeanIsmDirectSummandAction

namespace IUTStage1ArchimedeanOrderTwoDirectSummandAction

variable
  {capsuleFamily :
    IUTStage1TypedCapsuleFamilyLogVolume IUTStage1PlaceKind.archimedean}
variable {family : IUTStage1TensorDirectSummandFamily capsuleFamily}

def toDirectSummandAction
    (data : IUTStage1ArchimedeanOrderTwoDirectSummandAction family) :
    IUTStage1TensorDirectSummandFamilyAction family :=
  data.action

theorem symmetryKind_eq
    (data : IUTStage1ArchimedeanOrderTwoDirectSummandAction family) :
    family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.archimedeanOrderTwo :=
  data.symmetry_kind_eq

theorem capsuleTotalLogVolume_eq
    (data : IUTStage1ArchimedeanOrderTwoDirectSummandAction family) :
    data.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      capsuleFamily.totalLogVolume :=
  data.toDirectSummandAction.toCapsuleAction_totalLogVolume

theorem transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    {targetSigned : Real}
    (data : IUTStage1ArchimedeanOrderTwoDirectSummandAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    targetSigned <=
      data.toDirectSummandAction.toCapsuleAction.transformedFamily.normalizedLogVolume :=
  let action := data.toDirectSummandAction
  action.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    estimate

end IUTStage1ArchimedeanOrderTwoDirectSummandAction

/-- A nonarchimedean `Ism` action entry in a place-family collection. -/
structure IUTStage1NonarchimedeanIsmActionEntry where
  capsuleFamily :
    IUTStage1TypedCapsuleFamilyLogVolume
      IUTStage1PlaceKind.nonarchimedean
  family : IUTStage1TensorDirectSummandFamily capsuleFamily
  action : IUTStage1NonarchimedeanIsmDirectSummandAction family

/-- An archimedean order-two action entry in a place-family collection. -/
structure IUTStage1ArchimedeanOrderTwoActionEntry where
  capsuleFamily :
    IUTStage1TypedCapsuleFamilyLogVolume IUTStage1PlaceKind.archimedean
  family : IUTStage1TensorDirectSummandFamily capsuleFamily
  action : IUTStage1ArchimedeanOrderTwoDirectSummandAction family

namespace IUTStage1NonarchimedeanIsmActionEntry

def place
    (entry : IUTStage1NonarchimedeanIsmActionEntry) :
    IUTStage1PlaceId IUTStage1PlaceKind.nonarchimedean :=
  entry.action.place

def toDirectSummandAction
    (entry : IUTStage1NonarchimedeanIsmActionEntry) :
    IUTStage1TensorDirectSummandFamilyAction entry.family :=
  entry.action.toDirectSummandAction

theorem symmetryKind_eq
    (entry : IUTStage1NonarchimedeanIsmActionEntry) :
    entry.family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.nonarchimedeanIsm :=
  entry.action.symmetryKind_eq

theorem capsuleTotalLogVolume_eq
    (entry : IUTStage1NonarchimedeanIsmActionEntry) :
    entry.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      entry.capsuleFamily.totalLogVolume :=
  entry.action.capsuleTotalLogVolume_eq

end IUTStage1NonarchimedeanIsmActionEntry

namespace IUTStage1ArchimedeanOrderTwoActionEntry

def place
    (entry : IUTStage1ArchimedeanOrderTwoActionEntry) :
    IUTStage1PlaceId IUTStage1PlaceKind.archimedean :=
  entry.action.place

def toDirectSummandAction
    (entry : IUTStage1ArchimedeanOrderTwoActionEntry) :
    IUTStage1TensorDirectSummandFamilyAction entry.family :=
  entry.action.toDirectSummandAction

theorem symmetryKind_eq
    (entry : IUTStage1ArchimedeanOrderTwoActionEntry) :
    entry.family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.archimedeanOrderTwo :=
  entry.action.symmetryKind_eq

theorem capsuleTotalLogVolume_eq
    (entry : IUTStage1ArchimedeanOrderTwoActionEntry) :
    entry.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      entry.capsuleFamily.totalLogVolume :=
  entry.action.capsuleTotalLogVolume_eq

end IUTStage1ArchimedeanOrderTwoActionEntry

/--
Collection of `(Ind2)` local tensor-factor action data over the two place
families distinguished in Theorem 3.11.
-/
structure IUTStage1Ind2PlaceFamilyActionData where
  nonarchimedeanActions : List IUTStage1NonarchimedeanIsmActionEntry
  archimedeanActions : List IUTStage1ArchimedeanOrderTwoActionEntry

namespace IUTStage1Ind2PlaceFamilyActionData

def nonarchimedeanCount
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    Nat :=
  data.nonarchimedeanActions.length

def archimedeanCount
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    Nat :=
  data.archimedeanActions.length

def totalActionCount
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    Nat :=
  data.nonarchimedeanCount + data.archimedeanCount

theorem totalActionCount_eq
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    data.totalActionCount =
      data.nonarchimedeanActions.length + data.archimedeanActions.length :=
  rfl

def actionCountForKind
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    IUTStage1PlaceKind -> Nat
  | IUTStage1PlaceKind.nonarchimedean => data.nonarchimedeanCount
  | IUTStage1PlaceKind.archimedean => data.archimedeanCount

theorem actionCountForKind_nonarchimedean
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    data.actionCountForKind IUTStage1PlaceKind.nonarchimedean =
      data.nonarchimedeanActions.length :=
  rfl

theorem actionCountForKind_archimedean
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    data.actionCountForKind IUTStage1PlaceKind.archimedean =
      data.archimedeanActions.length :=
  rfl

def nonarchimedeanPlaces
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    List (IUTStage1PlaceId IUTStage1PlaceKind.nonarchimedean) :=
  data.nonarchimedeanActions.map
    IUTStage1NonarchimedeanIsmActionEntry.place

def archimedeanPlaces
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    List (IUTStage1PlaceId IUTStage1PlaceKind.archimedean) :=
  data.archimedeanActions.map
    IUTStage1ArchimedeanOrderTwoActionEntry.place

end IUTStage1Ind2PlaceFamilyActionData

/--
Audit identifying the nonarchimedean `(Ind2)` action places with an explicit
fiber of places above a base place.
-/
structure IUTStage1NonarchimedeanInd2PlaceFiberAudit
    (data : IUTStage1Ind2PlaceFamilyActionData) where
  fiber : IUTStage1PlaceFiber IUTStage1PlaceKind.nonarchimedean
  places_eq : data.nonarchimedeanPlaces = fiber.places

/--
Audit identifying the archimedean `(Ind2)` action places with an explicit fiber
of places above a base place.
-/
structure IUTStage1ArchimedeanInd2PlaceFiberAudit
    (data : IUTStage1Ind2PlaceFamilyActionData) where
  fiber : IUTStage1PlaceFiber IUTStage1PlaceKind.archimedean
  places_eq : data.archimedeanPlaces = fiber.places

namespace IUTStage1NonarchimedeanInd2PlaceFiberAudit

variable {data : IUTStage1Ind2PlaceFamilyActionData}

theorem actionCount_eq_fiberCardinality
    (audit : IUTStage1NonarchimedeanInd2PlaceFiberAudit data) :
    data.nonarchimedeanCount = audit.fiber.cardinality := by
  rw [IUTStage1Ind2PlaceFamilyActionData.nonarchimedeanCount]
  unfold IUTStage1PlaceFiber.cardinality
  rw [← audit.places_eq]
  simp [IUTStage1Ind2PlaceFamilyActionData.nonarchimedeanPlaces]

end IUTStage1NonarchimedeanInd2PlaceFiberAudit

namespace IUTStage1ArchimedeanInd2PlaceFiberAudit

variable {data : IUTStage1Ind2PlaceFamilyActionData}

theorem actionCount_eq_fiberCardinality
    (audit : IUTStage1ArchimedeanInd2PlaceFiberAudit data) :
    data.archimedeanCount = audit.fiber.cardinality := by
  rw [IUTStage1Ind2PlaceFamilyActionData.archimedeanCount]
  unfold IUTStage1PlaceFiber.cardinality
  rw [← audit.places_eq]
  simp [IUTStage1Ind2PlaceFamilyActionData.archimedeanPlaces]

end IUTStage1ArchimedeanInd2PlaceFiberAudit

/-- Local nonarchimedean inclusion datum from the upper-semi-compatibility step. -/
structure IUTStage1NonarchimedeanInclusionData where
  place : IUTStage1PlaceId IUTStage1PlaceKind.nonarchimedean
  sourceObject : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean
  targetObject : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean
  sourceLogVolume :
    IUTStage1FiniteLocalLogVolumeObject IUTStage1PlaceKind.nonarchimedean
  targetLogVolume :
    IUTStage1FiniteLocalLogVolumeObject IUTStage1PlaceKind.nonarchimedean
  placeLabel : String
  sourceLabel : String
  targetLabel : String
  source_place_eq : sourceObject.place = place
  target_place_eq : targetObject.place = place
  source_log_volume_object_eq : sourceLogVolume.localObject.object = sourceObject
  target_log_volume_object_eq : targetLogVolume.localObject.object = targetObject
  source_logVolume_le_target_logVolume :
    sourceLogVolume.finiteLogVolume <= targetLogVolume.finiteLogVolume
  inclusionValid : Prop
  inclusion_valid : inclusionValid

/-- Local archimedean surjection datum from the upper-semi-compatibility step. -/
structure IUTStage1ArchimedeanSurjectionData where
  place : IUTStage1PlaceId IUTStage1PlaceKind.archimedean
  sourceObject : IUTStage1LocalObjectId IUTStage1PlaceKind.archimedean
  targetObject : IUTStage1LocalObjectId IUTStage1PlaceKind.archimedean
  sourceLogVolume :
    IUTStage1FiniteLocalLogVolumeObject IUTStage1PlaceKind.archimedean
  targetLogVolume :
    IUTStage1FiniteLocalLogVolumeObject IUTStage1PlaceKind.archimedean
  placeLabel : String
  sourceLabel : String
  targetLabel : String
  source_place_eq : sourceObject.place = place
  target_place_eq : targetObject.place = place
  source_log_volume_object_eq : sourceLogVolume.localObject.object = sourceObject
  target_log_volume_object_eq : targetLogVolume.localObject.object = targetObject
  target_logVolume_le_source_logVolume :
    targetLogVolume.finiteLogVolume <= sourceLogVolume.finiteLogVolume
  surjectionValid : Prop
  surjection_valid : surjectionValid

/--
One-sided log-volume compatibility datum for the upper-semi step.

The relation is intentionally an inequality, not definitional equality, because
the source discussion of upper semi-compatibility is precisely one-sided.
-/
structure IUTStage1LogVolumeCompatibilityData where
  sourceLogVolume : Real
  targetLogVolume : Real
  source_le_target : sourceLogVolume <= targetLogVolume

/--
Procession state used by the Theorem 3.11 `(Ind1)` model.

Automorphisms of the procession may change representative data, but the
procession label and column are the invariants retained by the current
formalization layer.
-/
structure IUTStage1ProcessionState where
  procession : ProcessionPrimeStripId
  column : Int
  representative : String

/--
Local tensor-packet state used by the Theorem 3.11 `(Ind2)` model.

The current layer records the symmetry orbit and the number of direct summands
without formalizing the local tensor packet itself.
-/
structure IUTStage1LocalTensorState where
  symmetry : LocalTensorSymmetryId
  directSummandCount : Nat
  representative : String

/--
Local tensor-packet state equipped with typed capsule log-volume data.

This is the first source-facing connection between the `(Ind2)` local
tensor-factor coordinate and the Proposition 3.9 capsule/log-volume
normalization.  The equality of direct summands and capsule count is recorded
as data because the underlying tensor-packet construction is not yet
formalized.
-/
structure IUTStage1LocalTensorPacketLogVolumeState
    (kind : IUTStage1PlaceKind) where
  tensorState : IUTStage1LocalTensorState
  localObject : IUTStage1FiniteLocalLogVolumeObject kind
  capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind
  direct_summand_count_eq_capsuleCount :
    tensorState.directSummandCount = capsuleFamily.capsuleCount
  capsule_family_localObject_eq :
    capsuleFamily.localObject = localObject

/--
Local tensor-packet state that also carries the direct summand family
responsible for the packet's capsule action surface.
-/
structure IUTStage1LocalTensorDirectSummandPacketState
    (kind : IUTStage1PlaceKind) where
  packetState : IUTStage1LocalTensorPacketLogVolumeState kind
  summandFamily :
    IUTStage1TensorDirectSummandFamily packetState.capsuleFamily

/--
Compatibility asserting that the normalized capsule-family log-volume of a
local tensor packet is the finite log-volume of its local object.

This is kept separate from `IUTStage1LocalTensorPacketLogVolumeState`: the base
state records that the capsule family is attached to the same local object,
while this certificate records the stronger real-line/log-volume
identification needed by packet-normalized container estimates.
-/
structure IUTStage1LocalTensorPacketNormalizedCompatibility
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) where
  normalizedLogVolume_eq_localObject :
    state.capsuleFamily.normalizedLogVolume =
      state.localObject.finiteLogVolume

/-- Source classification for packet-normalized real-line identifications. -/
inductive IUTStage1PacketNormalizedIdentificationSource where
  | directPacketNormalization
  | ind2TransportedPacketNormalization
  | separateRealLineIdentification
deriving DecidableEq

/-- Source classification for identifying cusp/zero log-volumes with the
packet local object's finite log-volume. -/
inductive IUTStage1LocalObjectLogVolumeIdentificationSource where
  | directLocalObjectConstruction
  | packetNormalizationAndLocalObjectCompatibility
  | separateRealLineIdentification
deriving DecidableEq

/-- Source classification for packet-local-object cusp/zero estimates. -/
inductive IUTStage1PacketLocalObjectEstimateSource where
  | directLocalCuspConstruction
  | ind2TransportedLocalCuspConstruction
  | separateLocalObjectEstimate
deriving DecidableEq

/-- Source classification for the bridge from the `ZMod l` averaged normalized
log-volume family to packet-normalized capsule-family values. -/
inductive IUTStage1ZModPacketNormalizedBridgeSource where
  | directLabelPacketNormalization
  | ind12TransportedLabelPacketNormalization
  | separateAveragingIdentification
deriving DecidableEq

/-- Source classification for identifying the `ZMod l` label family with the
packet local object's finite log-volume. -/
inductive IUTStage1ZModPacketLocalObjectBridgeSource where
  | directLocalLabelObjectConstruction
  | ind12TransportedLocalLabelObjectConstruction
  | hodgeTheaterDescentPacketTransport
  | separateLocalObjectIdentification
deriving DecidableEq

/--
Higher-level source classification for a bridge from the insulated cusp/zero
route to a packet-comparison route.

This distinguishes a merely constant `ZMod` comparison from a future
Hodge-theater/descent/indeterminacy bridge.
-/
inductive IUTStage1InsulatedCuspZeroBridgeSource where
  | directPacketNormalization
  | labelwiseZModPacketEquality
  | constantZModPacketFamily
  | hodgeTheaterDescentIndeterminacy
  | separateRealLineIdentification
deriving DecidableEq

/--
Per-audited local-object transport data for a Hodge-descent packet bridge.

The record keeps the zero-column checkpoint and history guard next to the local
object equalities that transport the insulated zero and nonzero cusp-class
objects to the packet local object.
-/
structure IUTStage1HodgeDescentLocalObjectTransportData
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  checkpoint_eq_fourth_triangle :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint
  histories_not_identified :
    hodgeData.domainTheater.side ≠ hodgeData.codomainTheater.side
  zero_transports_to_packet : zeroObject = packetObject
  cuspClass_transports_to_packet :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      cuspClassObject label = packetObject

/--
One local object operation in the Hodge-descent route.

This record names the descent operation from the Hodge-descent bridge data and
connects one source local object to one packet-side target local object.
-/
structure IUTStage1HodgeDescentLocalObjectOperationData
    {kind : IUTStage1PlaceKind}
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (sourceObject packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  descent : AlgorithmicOutput.DescentOperationId
  descent_eq_hodgeData : descent = hodgeData.descent
  checkpoint_eq_fourth_triangle :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint
  histories_not_identified :
    hodgeData.domainTheater.side ≠ hodgeData.codomainTheater.side
  source_transports_to_packet : sourceObject = packetObject

/--
Zero/cusp-class family of local object operations for a Hodge-descent packet
transport.
-/
structure IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  zeroOperation :
    IUTStage1HodgeDescentLocalObjectOperationData
      hodgeData zeroObject packetObject
  cuspClassOperation :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      IUTStage1HodgeDescentLocalObjectOperationData
        hodgeData (cuspClassObject label) packetObject

/--
Source/target roles for local objects in the Hodge-descent packet transport.
-/
inductive IUTStage1HodgeDescentLocalObjectRole where
  | zeroColumnSHEInput
  | cuspClassHodgeArakelovEvaluation
  | packetDescentTarget
deriving DecidableEq, Repr

/--
Local descent operation with the source and target object roles made explicit.
-/
structure IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
    {kind : IUTStage1PlaceKind}
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (sourceObject packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  operation :
    IUTStage1HodgeDescentLocalObjectOperationData
      hodgeData sourceObject packetObject
  sourceRole : IUTStage1HodgeDescentLocalObjectRole
  targetRole : IUTStage1HodgeDescentLocalObjectRole
  target_role_eq_packet :
    targetRole = IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget

/--
Role-marked zero/cusp local descent-operation family.
-/
structure IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  zeroOperation :
    IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
      hodgeData zeroObject packetObject
  zero_source_role :
    zeroOperation.sourceRole =
      IUTStage1HodgeDescentLocalObjectRole.zeroColumnSHEInput
  cuspClassOperation :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
        hodgeData (cuspClassObject label) packetObject
  cuspClass_source_role :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      (cuspClassOperation label).sourceRole =
        IUTStage1HodgeDescentLocalObjectRole.cuspClassHodgeArakelovEvaluation

/--
Source object for the zero-column/SHE input side of a Hodge-descent local
transport.
-/
structure IUTStage1ZeroColumnSHELocalObjectData
    {kind : IUTStage1PlaceKind}
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (object : IUTStage1FiniteLocalLogVolumeObject kind) where
  checkpoint_eq_fourth_triangle :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint
  histories_not_identified :
    hodgeData.domainTheater.side ≠ hodgeData.codomainTheater.side

/--
Source object for a nonzero cusp-class local Hodge-Arakelov evaluation input.
-/
structure IUTStage1CuspClassHodgeArakelovLocalObjectData
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (label : (zmodSignAction l).SignLabelQuotient)
    (object : IUTStage1FiniteLocalLogVolumeObject kind) where
  checkpoint_eq_fourth_triangle :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint
  histories_not_identified :
    hodgeData.domainTheater.side ≠ hodgeData.codomainTheater.side

/--
Target object on the packet side after Hodge descent.
-/
structure IUTStage1PacketDescentTargetLocalObjectData
    {kind : IUTStage1PlaceKind}
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (object : IUTStage1FiniteLocalLogVolumeObject kind) where
  descent : AlgorithmicOutput.DescentOperationId
  descent_eq_hodgeData : descent = hodgeData.descent
  checkpoint_eq_fourth_triangle :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint
  histories_not_identified :
    hodgeData.domainTheater.side ≠ hodgeData.codomainTheater.side

/--
Role-marked zero/cusp local descent-operation family whose source and target
objects are identified with source-specific 0-column, Hodge-Arakelov, and packet
descent target data.
-/
structure IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  zeroSource :
    IUTStage1ZeroColumnSHELocalObjectData hodgeData zeroObject
  cuspClassSource :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      IUTStage1CuspClassHodgeArakelovLocalObjectData
        l hodgeData label (cuspClassObject label)
  packetTarget :
    IUTStage1PacketDescentTargetLocalObjectData hodgeData packetObject
  zeroOperation :
    IUTStage1HodgeDescentLocalObjectOperationData
      hodgeData zeroObject packetObject
  cuspClassOperation :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      IUTStage1HodgeDescentLocalObjectOperationData
        hodgeData (cuspClassObject label) packetObject

/--
Hodge-Arakelov cusp-class source object with explicit `ZMod l` label
provenance.

The coordinate is required to be nonzero because the cusp-class label lives in
the sign quotient of nonzero labels.
-/
structure IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (label : (zmodSignAction l).SignLabelQuotient)
    (object : IUTStage1FiniteLocalLogVolumeObject kind) where
  source :
    IUTStage1CuspClassHodgeArakelovLocalObjectData
      l hodgeData label object
  cuspLabelModel : IUTStage1FLZModCuspLabelClassModel l
  coordinate : ZMod l.value
  coordinate_ne_zero : coordinate ≠ 0
  label_eq_coordinate :
    label = zmodSignLabelFromCoordinate l coordinate coordinate_ne_zero

/--
Source-marked zero/cusp local operation data whose cusp-class sources are
tracked by explicit `ZMod l` sign-label coordinates.
-/
structure IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  zeroSource :
    IUTStage1ZeroColumnSHELocalObjectData hodgeData zeroObject
  cuspClassSource :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
        l hodgeData label (cuspClassObject label)
  packetTarget :
    IUTStage1PacketDescentTargetLocalObjectData hodgeData packetObject
  zeroOperation :
    IUTStage1HodgeDescentLocalObjectOperationData
      hodgeData zeroObject packetObject
  cuspClassOperation :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      IUTStage1HodgeDescentLocalObjectOperationData
        hodgeData (cuspClassObject label) packetObject

/--
Square-weight transport data that are not supplied by local-object Hodge descent
alone.

The local-object packet transport records zero/cusp local objects and their
descent to a packet object.  It does not by itself contain the coordinate and
weight-preservation data required by
`IUTStage1StructuredSHESquareWeightTransportObligations`.
-/
inductive IUTStage1SquareWeightTransportMissingDatum where
  | coordinateEquiv
  | sourceProfile
  | targetProfile
  | sourceLogVolume
  | targetLogVolume
  | fullLabelLogVolumePreservation
  | squareWeightPreservation
  | weightTotalPreservation
deriving DecidableEq, Repr, Fintype

namespace IUTStage1SquareWeightTransportMissingDatum

def all : Finset IUTStage1SquareWeightTransportMissingDatum :=
  Finset.univ

theorem coordinateEquiv_mem_all :
    coordinateEquiv ∈ all := by
  simp [all]

theorem sourceProfile_mem_all :
    sourceProfile ∈ all := by
  simp [all]

theorem targetProfile_mem_all :
    targetProfile ∈ all := by
  simp [all]

theorem sourceLogVolume_mem_all :
    sourceLogVolume ∈ all := by
  simp [all]

theorem targetLogVolume_mem_all :
    targetLogVolume ∈ all := by
  simp [all]

theorem fullLabelLogVolumePreservation_mem_all :
    fullLabelLogVolumePreservation ∈ all := by
  simp [all]

theorem squareWeightPreservation_mem_all :
    squareWeightPreservation ∈ all := by
  simp [all]

theorem weightTotalPreservation_mem_all :
    weightTotalPreservation ∈ all := by
  simp [all]

end IUTStage1SquareWeightTransportMissingDatum

/--
Primitive preservation data required by the fully factored structured-SHE
square/full-label obligation record, but not supplied by local-object Hodge
descent alone.
-/
inductive IUTStage1FactoredSquareFullLabelMissingDatum where
  | coordinateSquarePreservation
  | fullLabelMapPreservation
  | fullLabelValuePreservation
deriving DecidableEq, Repr, Fintype

namespace IUTStage1FactoredSquareFullLabelMissingDatum

def all : Finset IUTStage1FactoredSquareFullLabelMissingDatum :=
  Finset.univ

theorem coordinateSquarePreservation_mem_all :
    coordinateSquarePreservation ∈ all := by
  simp [all]

theorem fullLabelMapPreservation_mem_all :
    fullLabelMapPreservation ∈ all := by
  simp [all]

theorem fullLabelValuePreservation_mem_all :
    fullLabelValuePreservation ∈ all := by
  simp [all]

end IUTStage1FactoredSquareFullLabelMissingDatum

/--
Transport data that preserves only the zero/nonzero/sign-quotient full-label
map.

This is intentionally weaker than the factored square/full-label preservation
interface: it carries no coordinate-square preservation and no log-volume value
preservation.
-/
structure IUTStage1FullLabelMapOnlyTransport
    (l : PrimeGeFive) where
  coordinateEquiv : ZMod l.value ≃ ZMod l.value
  fullLabelMap_preserved :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
      (l := l) coordinateEquiv

namespace IUTStage1FullLabelMapOnlyTransport

variable {l : PrimeGeFive}

def neg (l : PrimeGeFive) :
    IUTStage1FullLabelMapOnlyTransport l :=
  { coordinateEquiv := Equiv.neg (ZMod l.value),
    fullLabelMap_preserved :=
      IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelMapPreserving_neg }

def missingFactoredSquareFullLabelData
    (_transport : IUTStage1FullLabelMapOnlyTransport l) :
    Finset IUTStage1FactoredSquareFullLabelMissingDatum :=
  { IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation,
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation }

theorem fullLabelMapPreserved
    (transport : IUTStage1FullLabelMapOnlyTransport l) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
      (l := l) transport.coordinateEquiv :=
  transport.fullLabelMap_preserved

theorem coordinateSquarePreservation_missing
    (transport : IUTStage1FullLabelMapOnlyTransport l) :
    IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation ∈
      transport.missingFactoredSquareFullLabelData := by
  simp [missingFactoredSquareFullLabelData]

theorem fullLabelValuePreservation_missing
    (transport : IUTStage1FullLabelMapOnlyTransport l) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation ∈
      transport.missingFactoredSquareFullLabelData := by
  simp [missingFactoredSquareFullLabelData]

end IUTStage1FullLabelMapOnlyTransport

/--
Transport data that preserves the sign-quotient full-label map and the square
map inside `ZMod l.value`, but not the real representative square profile.

This records the distinction between finite-field square compatibility and the
real `j.val ^ 2` weights used in the current Corollary 3.12 audit target.
-/
structure IUTStage1FullLabelModularSquareOnlyTransport
    (l : PrimeGeFive) where
  coordinateEquiv : ZMod l.value ≃ ZMod l.value
  fullLabelMap_preserved :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
      (l := l) coordinateEquiv
  coordinateModularSquare_preserved :
    IUTStage1ZModSquareWeightProfile.CoordinateModularSquarePreserving
      (l := l) coordinateEquiv

namespace IUTStage1FullLabelModularSquareOnlyTransport

variable {l : PrimeGeFive}

def neg (l : PrimeGeFive) :
    IUTStage1FullLabelModularSquareOnlyTransport l :=
  { coordinateEquiv := Equiv.neg (ZMod l.value),
    fullLabelMap_preserved :=
      IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelMapPreserving_neg,
    coordinateModularSquare_preserved :=
      IUTStage1ZModSquareWeightProfile.coordinateModularSquarePreserving_neg }

def missingFactoredSquareFullLabelData
    (_transport : IUTStage1FullLabelModularSquareOnlyTransport l) :
    Finset IUTStage1FactoredSquareFullLabelMissingDatum :=
  { IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation,
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation }

theorem fullLabelMapPreserved
    (transport : IUTStage1FullLabelModularSquareOnlyTransport l) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
      (l := l) transport.coordinateEquiv :=
  transport.fullLabelMap_preserved

theorem coordinateModularSquarePreserved
    (transport : IUTStage1FullLabelModularSquareOnlyTransport l) :
    IUTStage1ZModSquareWeightProfile.CoordinateModularSquarePreserving
      (l := l) transport.coordinateEquiv :=
  transport.coordinateModularSquare_preserved

theorem coordinateSquarePreservation_missing
    (transport : IUTStage1FullLabelModularSquareOnlyTransport l) :
    IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation ∈
      transport.missingFactoredSquareFullLabelData := by
  simp [missingFactoredSquareFullLabelData]

theorem fullLabelValuePreservation_missing
    (transport : IUTStage1FullLabelModularSquareOnlyTransport l) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation ∈
      transport.missingFactoredSquareFullLabelData := by
  simp [missingFactoredSquareFullLabelData]

end IUTStage1FullLabelModularSquareOnlyTransport

/--
Balanced-square/full-label transport data.

This is an alternate sign-compatible branch: it uses the balanced square profile
`valMinAbs.natAbs ^ 2`, not the representative-valued Corollary 3.12 audit
profile `j.val ^ 2`.
-/
structure IUTStage1BalancedSquareFullLabelTransport
    (l : PrimeGeFive) where
  coordinateEquiv : ZMod l.value ≃ ZMod l.value
  sourceLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  targetLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  coordinateBalancedSquare_preserved :
    IUTStage1ZModSquareWeightProfile.CoordinateBalancedSquarePreserving
      (l := l) coordinateEquiv
  fullLabelMap_preserved :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
      (l := l) coordinateEquiv
  fullLabelValue_preserved :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelLogVolumeValuePreserving
      sourceLogVolume targetLogVolume

namespace IUTStage1BalancedSquareFullLabelTransport

variable {l : PrimeGeFive}

def negSelf
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    IUTStage1BalancedSquareFullLabelTransport l :=
  { coordinateEquiv := Equiv.neg (ZMod l.value),
    sourceLogVolume := logVolume,
    targetLogVolume := logVolume,
    coordinateBalancedSquare_preserved :=
      IUTStage1ZModSquareWeightProfile.coordinateBalancedSquarePreserving_neg,
    fullLabelMap_preserved :=
      IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelMapPreserving_neg,
    fullLabelValue_preserved :=
      IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelLogVolumeValuePreserving_refl
        logVolume }

theorem balancedSquareWeight_preserved
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    ∀ j : ZMod l.value,
      IUTStage1ZModSquareWeightProfile.balancedSquareWeight
          (l := l) (transport.coordinateEquiv j) =
        IUTStage1ZModSquareWeightProfile.balancedSquareWeight
          (l := l) j :=
  transport.coordinateBalancedSquare_preserved

theorem fullLabelLogVolume_preserved
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    ∀ j : ZMod l.value,
      transport.targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (transport.coordinateEquiv j)) =
        transport.sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  by
    intro j
    rw [transport.fullLabelMap_preserved j]
    exact transport.fullLabelValue_preserved
      (IUTStage1ZModCuspFullLabel.fromCoordinate l j)

theorem balancedSummand_preserved
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    ∀ j : ZMod l.value,
      IUTStage1ZModSquareWeightProfile.balancedSquareWeight
          (l := l) (transport.coordinateEquiv j) *
        transport.targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (transport.coordinateEquiv j)) =
      IUTStage1ZModSquareWeightProfile.balancedSquareWeight
          (l := l) j *
        transport.sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  intro j
  rw [transport.balancedSquareWeight_preserved j,
    transport.fullLabelLogVolume_preserved j]

theorem balancedFullLabelWeightedSummand_preserved
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    ∀ j : ZMod l.value,
      IUTStage1ZModSquareWeightProfile.balancedFullLabelWeightedSummand
          (l := l) transport.targetLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (transport.coordinateEquiv j)) =
        IUTStage1ZModSquareWeightProfile.balancedFullLabelWeightedSummand
          (l := l) transport.sourceLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  IUTStage1ZModSquareWeightProfile.balancedFullLabelWeightedSummand_preserved_of_fullLabelMap
      transport.fullLabelMap_preserved
      transport.sourceLogVolume
      transport.targetLogVolume
      transport.fullLabelValue_preserved

def balancedWeightTotal
    (_transport : IUTStage1BalancedSquareFullLabelTransport l) :
    Real :=
  Finset.univ.sum fun j : ZMod l.value =>
    IUTStage1ZModSquareWeightProfile.balancedSquareWeight (l := l) j

def sourceBalancedNumerator
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    Real :=
  Finset.univ.sum fun j : ZMod l.value =>
    IUTStage1ZModSquareWeightProfile.balancedSquareWeight (l := l) j *
      transport.sourceLogVolume.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j)

def targetTransportedBalancedNumerator
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    Real :=
  Finset.univ.sum fun j : ZMod l.value =>
    IUTStage1ZModSquareWeightProfile.balancedSquareWeight
        (l := l) (transport.coordinateEquiv j) *
      transport.targetLogVolume.fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (transport.coordinateEquiv j))

noncomputable def sourceBalancedAverage
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    Real :=
  transport.sourceBalancedNumerator / transport.balancedWeightTotal

noncomputable def targetTransportedBalancedAverage
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    Real :=
  transport.targetTransportedBalancedNumerator /
    transport.balancedWeightTotal

theorem targetTransportedBalancedNumerator_eq_sourceBalancedNumerator
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    transport.targetTransportedBalancedNumerator =
      transport.sourceBalancedNumerator := by
  unfold targetTransportedBalancedNumerator sourceBalancedNumerator
  exact Finset.sum_congr rfl (by
    intro j _hj
    exact transport.balancedSummand_preserved j)

theorem targetTransportedBalancedAverage_eq_sourceBalancedAverage
    (transport : IUTStage1BalancedSquareFullLabelTransport l) :
    transport.targetTransportedBalancedAverage =
      transport.sourceBalancedAverage := by
  unfold targetTransportedBalancedAverage sourceBalancedAverage
  rw [transport.targetTransportedBalancedNumerator_eq_sourceBalancedNumerator]

end IUTStage1BalancedSquareFullLabelTransport

/--
Boundary object showing what the local-object Hodge-descent packet layer supplies
before square-weight preservation data are added.

It carries the existing local-object transport data and exposes the packet
equalities, while the `missingSquareWeightData` checklist records the extra
coordinate/profile/preservation data still needed to construct the
structured-SHE square-weight transport obligations.
-/
structure IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
    {kind : IUTStage1PlaceKind}
    (l : PrimeGeFive)
    (hodgeData : IUTStage1HodgeTheaterDescentBridgeData)
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (packetObject : IUTStage1FiniteLocalLogVolumeObject kind) where
  localObjectTransport :
    IUTStage1HodgeDescentLocalObjectTransportData
      l hodgeData zeroObject cuspClassObject packetObject

namespace IUTStage1LocalObjectHodgeDescentSquareWeightBoundary

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {zeroObject : IUTStage1FiniteLocalLogVolumeObject kind}
variable
  {cuspClassObject :
    (zmodSignAction l).SignLabelQuotient ->
      IUTStage1FiniteLocalLogVolumeObject kind}
variable {packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

def missingSquareWeightData
    (_boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    Finset IUTStage1SquareWeightTransportMissingDatum :=
  IUTStage1SquareWeightTransportMissingDatum.all

def missingFactoredSquareFullLabelData
    (_boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    Finset IUTStage1FactoredSquareFullLabelMissingDatum :=
  IUTStage1FactoredSquareFullLabelMissingDatum.all

theorem zero_transports_to_packet
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    zeroObject = packetObject :=
  boundary.localObjectTransport.zero_transports_to_packet

theorem cuspClass_transports_to_packet
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    cuspClassObject label = packetObject :=
  boundary.localObjectTransport.cuspClass_transports_to_packet label

theorem histories_not_identified
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    hodgeData.domainTheater.side ≠ hodgeData.codomainTheater.side :=
  boundary.localObjectTransport.histories_not_identified

theorem coordinateEquiv_missing
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1SquareWeightTransportMissingDatum.coordinateEquiv ∈
      boundary.missingSquareWeightData :=
  IUTStage1SquareWeightTransportMissingDatum.coordinateEquiv_mem_all

theorem fullLabelLogVolumePreservation_missing
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1SquareWeightTransportMissingDatum.fullLabelLogVolumePreservation ∈
      boundary.missingSquareWeightData :=
  IUTStage1SquareWeightTransportMissingDatum.fullLabelLogVolumePreservation_mem_all

theorem squareWeightPreservation_missing
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1SquareWeightTransportMissingDatum.squareWeightPreservation ∈
      boundary.missingSquareWeightData :=
  IUTStage1SquareWeightTransportMissingDatum.squareWeightPreservation_mem_all

theorem weightTotalPreservation_missing
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1SquareWeightTransportMissingDatum.weightTotalPreservation ∈
      boundary.missingSquareWeightData :=
  IUTStage1SquareWeightTransportMissingDatum.weightTotalPreservation_mem_all

theorem coordinateSquarePreservation_missing
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation ∈
      boundary.missingFactoredSquareFullLabelData :=
  IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation_mem_all

theorem fullLabelMapPreservation_missing
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelMapPreservation ∈
      boundary.missingFactoredSquareFullLabelData :=
  IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelMapPreservation_mem_all

theorem fullLabelValuePreservation_missing
    (boundary :
      IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation ∈
      boundary.missingFactoredSquareFullLabelData :=
  IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation_mem_all

end IUTStage1LocalObjectHodgeDescentSquareWeightBoundary

namespace IUTStage1HodgeDescentLocalObjectTransportData

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {zeroObject : IUTStage1FiniteLocalLogVolumeObject kind}
variable
  {cuspClassObject :
    (zmodSignAction l).SignLabelQuotient ->
      IUTStage1FiniteLocalLogVolumeObject kind}
variable {packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

theorem zero_transports_to_packet'
    (data :
      IUTStage1HodgeDescentLocalObjectTransportData
        l hodgeData zeroObject cuspClassObject packetObject) :
    zeroObject = packetObject :=
  data.zero_transports_to_packet

theorem cuspClass_transports_to_packet'
    (data :
      IUTStage1HodgeDescentLocalObjectTransportData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    cuspClassObject label = packetObject :=
  data.cuspClass_transports_to_packet label

theorem zero_eq_cuspClass
    (data :
      IUTStage1HodgeDescentLocalObjectTransportData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    zeroObject = cuspClassObject label :=
  data.zero_transports_to_packet.trans
    (data.cuspClass_transports_to_packet label).symm

theorem checkpoint_eq_fourthTriangle
    (data :
      IUTStage1HodgeDescentLocalObjectTransportData
        l hodgeData zeroObject cuspClassObject packetObject) :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint :=
  data.checkpoint_eq_fourth_triangle

end IUTStage1HodgeDescentLocalObjectTransportData

namespace IUTStage1HodgeDescentLocalObjectOperationData

variable {kind : IUTStage1PlaceKind}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {sourceObject packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

theorem descent_eq
    (data :
      IUTStage1HodgeDescentLocalObjectOperationData
        hodgeData sourceObject packetObject) :
    data.descent = hodgeData.descent :=
  data.descent_eq_hodgeData

theorem checkpoint_eq_fourthTriangle
    (data :
      IUTStage1HodgeDescentLocalObjectOperationData
        hodgeData sourceObject packetObject) :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint :=
  data.checkpoint_eq_fourth_triangle

theorem source_transports_to_packet'
    (data :
      IUTStage1HodgeDescentLocalObjectOperationData
        hodgeData sourceObject packetObject) :
    sourceObject = packetObject :=
  data.source_transports_to_packet

end IUTStage1HodgeDescentLocalObjectOperationData

namespace IUTStage1HodgeDescentCuspZeroLocalObjectOperationData

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {zeroObject : IUTStage1FiniteLocalLogVolumeObject kind}
variable
  {cuspClassObject :
    (zmodSignAction l).SignLabelQuotient ->
      IUTStage1FiniteLocalLogVolumeObject kind}
variable {packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

def toLocalObjectTransportData
    (data :
      IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1HodgeDescentLocalObjectTransportData
      l hodgeData zeroObject cuspClassObject packetObject :=
  { checkpoint_eq_fourth_triangle :=
      data.zeroOperation.checkpoint_eq_fourthTriangle,
    histories_not_identified :=
      data.zeroOperation.histories_not_identified,
    zero_transports_to_packet :=
      data.zeroOperation.source_transports_to_packet',
    cuspClass_transports_to_packet := fun label =>
      (data.cuspClassOperation label).source_transports_to_packet' }

theorem zero_transports_to_packet
    (data :
      IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    zeroObject = packetObject :=
  data.zeroOperation.source_transports_to_packet'

theorem cuspClass_transports_to_packet
    (data :
      IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    cuspClassObject label = packetObject :=
  (data.cuspClassOperation label).source_transports_to_packet'

theorem zero_eq_cuspClass
    (data :
      IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    zeroObject = cuspClassObject label :=
  data.toLocalObjectTransportData.zero_eq_cuspClass label

theorem zeroOperation_descent_eq_hodgeData
    (data :
      IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    data.zeroOperation.descent = hodgeData.descent :=
  data.zeroOperation.descent_eq

theorem cuspClassOperation_descent_eq_hodgeData
    (data :
      IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (data.cuspClassOperation label).descent = hodgeData.descent :=
  (data.cuspClassOperation label).descent_eq

end IUTStage1HodgeDescentCuspZeroLocalObjectOperationData

namespace IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData

variable {kind : IUTStage1PlaceKind}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {sourceObject packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

def toLocalObjectOperationData
    (data :
      IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
        hodgeData sourceObject packetObject) :
    IUTStage1HodgeDescentLocalObjectOperationData
      hodgeData sourceObject packetObject :=
  data.operation

theorem source_transports_to_packet
    (data :
      IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
        hodgeData sourceObject packetObject) :
    sourceObject = packetObject :=
  data.operation.source_transports_to_packet'

theorem targetRole_eq_packet
    (data :
      IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
        hodgeData sourceObject packetObject) :
    data.targetRole =
      IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget :=
  data.target_role_eq_packet

theorem descent_eq_hodgeData
    (data :
      IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData
        hodgeData sourceObject packetObject) :
    data.operation.descent = hodgeData.descent :=
  data.operation.descent_eq

end IUTStage1RoleMarkedHodgeDescentLocalObjectOperationData

namespace IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {zeroObject : IUTStage1FiniteLocalLogVolumeObject kind}
variable
  {cuspClassObject :
    (zmodSignAction l).SignLabelQuotient ->
      IUTStage1FiniteLocalLogVolumeObject kind}
variable {packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

def toCuspZeroLocalObjectOperationData
    (data :
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
      l hodgeData zeroObject cuspClassObject packetObject :=
  { zeroOperation := data.zeroOperation.toLocalObjectOperationData,
    cuspClassOperation := fun label =>
      (data.cuspClassOperation label).toLocalObjectOperationData }

def toLocalObjectTransportData
    (data :
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1HodgeDescentLocalObjectTransportData
      l hodgeData zeroObject cuspClassObject packetObject :=
  data.toCuspZeroLocalObjectOperationData.toLocalObjectTransportData

theorem zeroSourceRole_eq
    (data :
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    data.zeroOperation.sourceRole =
      IUTStage1HodgeDescentLocalObjectRole.zeroColumnSHEInput :=
  data.zero_source_role

theorem cuspClassSourceRole_eq
    (data :
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (data.cuspClassOperation label).sourceRole =
      IUTStage1HodgeDescentLocalObjectRole.cuspClassHodgeArakelovEvaluation :=
  data.cuspClass_source_role label

theorem zeroTargetRole_eq_packet
    (data :
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    data.zeroOperation.targetRole =
      IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget :=
  data.zeroOperation.targetRole_eq_packet

theorem cuspClassTargetRole_eq_packet
    (data :
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (data.cuspClassOperation label).targetRole =
      IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget :=
  (data.cuspClassOperation label).targetRole_eq_packet

theorem zero_eq_cuspClass
    (data :
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    zeroObject = cuspClassObject label :=
  data.toCuspZeroLocalObjectOperationData.zero_eq_cuspClass label

end IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData

namespace IUTStage1ZeroColumnSHELocalObjectData

variable {kind : IUTStage1PlaceKind}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {object : IUTStage1FiniteLocalLogVolumeObject kind}

theorem checkpoint_eq_fourthTriangle
    (data : IUTStage1ZeroColumnSHELocalObjectData hodgeData object) :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint :=
  data.checkpoint_eq_fourth_triangle

end IUTStage1ZeroColumnSHELocalObjectData

namespace IUTStage1CuspClassHodgeArakelovLocalObjectData

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {label : (zmodSignAction l).SignLabelQuotient}
variable {object : IUTStage1FiniteLocalLogVolumeObject kind}

theorem checkpoint_eq_fourthTriangle
    (data :
      IUTStage1CuspClassHodgeArakelovLocalObjectData
        l hodgeData label object) :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint :=
  data.checkpoint_eq_fourth_triangle

end IUTStage1CuspClassHodgeArakelovLocalObjectData

namespace IUTStage1PacketDescentTargetLocalObjectData

variable {kind : IUTStage1PlaceKind}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {object : IUTStage1FiniteLocalLogVolumeObject kind}

theorem descent_eq
    (data : IUTStage1PacketDescentTargetLocalObjectData hodgeData object) :
    data.descent = hodgeData.descent :=
  data.descent_eq_hodgeData

theorem checkpoint_eq_fourthTriangle
    (data : IUTStage1PacketDescentTargetLocalObjectData hodgeData object) :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint :=
  data.checkpoint_eq_fourth_triangle

end IUTStage1PacketDescentTargetLocalObjectData

namespace IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {zeroObject : IUTStage1FiniteLocalLogVolumeObject kind}
variable
  {cuspClassObject :
    (zmodSignAction l).SignLabelQuotient ->
      IUTStage1FiniteLocalLogVolumeObject kind}
variable {packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

def toRoleMarkedCuspZeroLocalObjectOperationData
    (data :
      IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
      l hodgeData zeroObject cuspClassObject packetObject :=
  { zeroOperation :=
      { operation := data.zeroOperation,
        sourceRole :=
          IUTStage1HodgeDescentLocalObjectRole.zeroColumnSHEInput,
        targetRole :=
          IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget,
        target_role_eq_packet := rfl },
    zero_source_role := rfl,
    cuspClassOperation := fun label =>
      { operation := data.cuspClassOperation label,
        sourceRole :=
          IUTStage1HodgeDescentLocalObjectRole.cuspClassHodgeArakelovEvaluation,
        targetRole :=
          IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget,
        target_role_eq_packet := rfl },
    cuspClass_source_role := fun _label => rfl }

def toCuspZeroLocalObjectOperationData
    (data :
      IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1HodgeDescentCuspZeroLocalObjectOperationData
      l hodgeData zeroObject cuspClassObject packetObject :=
  { zeroOperation := data.zeroOperation,
    cuspClassOperation := data.cuspClassOperation }

theorem zeroSource_checkpoint_eq_fourthTriangle
    (data :
      IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint :=
  data.zeroSource.checkpoint_eq_fourthTriangle

theorem packetTarget_descent_eq_hodgeData
    (data :
      IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    data.packetTarget.descent = hodgeData.descent :=
  data.packetTarget.descent_eq

theorem cuspClassSource_checkpoint_eq_fourthTriangle
    (data :
      IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    hodgeData.zeroColumnCheckpoint = fourthTriangleHDDSHECheckpoint :=
  (data.cuspClassSource label).checkpoint_eq_fourthTriangle

theorem zero_eq_cuspClass
    (data :
      IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    zeroObject = cuspClassObject label :=
  data.toCuspZeroLocalObjectOperationData.zero_eq_cuspClass label

end IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData

namespace IUTStage1ZModCuspClassHodgeArakelovLocalObjectData

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {label : (zmodSignAction l).SignLabelQuotient}
variable {object : IUTStage1FiniteLocalLogVolumeObject kind}

def toCuspClassHodgeArakelovLocalObjectData
    (data :
      IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
        l hodgeData label object) :
    IUTStage1CuspClassHodgeArakelovLocalObjectData
      l hodgeData label object :=
  data.source

theorem label_eq_zmodCoordinate
    (data :
      IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
        l hodgeData label object) :
    label = zmodSignLabelFromCoordinate l data.coordinate data.coordinate_ne_zero :=
  data.label_eq_coordinate

theorem label_eq_negCoordinate
    (data :
      IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
        l hodgeData label object) :
    label =
      zmodSignLabelFromCoordinate l (-data.coordinate)
        (zmod_neg_ne_zero_of_ne_zero l data.coordinate_ne_zero) := by
  calc
    label = zmodSignLabelFromCoordinate l data.coordinate data.coordinate_ne_zero :=
      data.label_eq_zmodCoordinate
    _ = zmodSignLabelFromCoordinate l (-data.coordinate)
          (zmod_neg_ne_zero_of_ne_zero l data.coordinate_ne_zero) :=
      (zmodSignLabelFromCoordinate_neg_eq l data.coordinate data.coordinate_ne_zero).symm

theorem label_eq_canonical_of_coordinate_eq_one
    (data :
      IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
        l hodgeData label object)
    (hcoord : data.coordinate = (1 : ZMod l.value)) :
    label = zmodCanonicalSignLabelQuotient l := by
  have hnonzero_one : (1 : ZMod l.value) ≠ 0 := by
    simpa [hcoord] using data.coordinate_ne_zero
  have hnonzero_one_eq :
      hnonzero_one = (zmodOneNonzeroLabel l).2 := by
    apply Subsingleton.elim
  calc
    label = zmodSignLabelFromCoordinate l data.coordinate data.coordinate_ne_zero :=
      data.label_eq_zmodCoordinate
    _ = zmodSignLabelFromCoordinate l (1 : ZMod l.value) hnonzero_one := by
      simp [hcoord]
    _ = zmodSignLabelFromCoordinate l (1 : ZMod l.value)
          (zmodOneNonzeroLabel l).2 := by
      rw [hnonzero_one_eq]
    _ = zmodCanonicalSignLabelQuotient l :=
      zmodSignLabelFromCoordinate_one_eq_canonical l

theorem coordinate_ne_zero'
    (data :
      IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
        l hodgeData label object) :
    data.coordinate ≠ 0 :=
  data.coordinate_ne_zero

theorem cuspLabelModel_localLabCuspModel_eq_zmod
    (data :
      IUTStage1ZModCuspClassHodgeArakelovLocalObjectData
        l hodgeData label object) :
    data.cuspLabelModel.local_lab_cusp_model = zmodLocalLabCuspModel l :=
  data.cuspLabelModel.localLabCuspModel_eq_zmod

end IUTStage1ZModCuspClassHodgeArakelovLocalObjectData

namespace IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData

variable {kind : IUTStage1PlaceKind}
variable {l : PrimeGeFive}
variable {hodgeData : IUTStage1HodgeTheaterDescentBridgeData}
variable {zeroObject : IUTStage1FiniteLocalLogVolumeObject kind}
variable
  {cuspClassObject :
    (zmodSignAction l).SignLabelQuotient ->
      IUTStage1FiniteLocalLogVolumeObject kind}
variable {packetObject : IUTStage1FiniteLocalLogVolumeObject kind}

def toSourceMarkedCuspZeroLocalObjectOperationData
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
      l hodgeData zeroObject cuspClassObject packetObject :=
  { zeroSource := data.zeroSource,
    cuspClassSource := fun label =>
      (data.cuspClassSource label).toCuspClassHodgeArakelovLocalObjectData,
    packetTarget := data.packetTarget,
    zeroOperation := data.zeroOperation,
    cuspClassOperation := data.cuspClassOperation }

def toRoleMarkedCuspZeroLocalObjectOperationData
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData
      l hodgeData zeroObject cuspClassObject packetObject :=
  let sourceMarked := data.toSourceMarkedCuspZeroLocalObjectOperationData
  sourceMarked.toRoleMarkedCuspZeroLocalObjectOperationData

theorem cuspClassLabel_eq_zmodCoordinate
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    label =
      zmodSignLabelFromCoordinate l
        (data.cuspClassSource label).coordinate
        (data.cuspClassSource label).coordinate_ne_zero :=
  (data.cuspClassSource label).label_eq_zmodCoordinate

theorem cuspClassLabel_eq_negCoordinate
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    label =
      zmodSignLabelFromCoordinate l
        (-(data.cuspClassSource label).coordinate)
        (zmod_neg_ne_zero_of_ne_zero l
          (data.cuspClassSource label).coordinate_ne_zero) :=
  (data.cuspClassSource label).label_eq_negCoordinate

theorem cuspClassLabel_eq_canonical_of_coordinate_eq_one
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient)
    (hcoord :
      (data.cuspClassSource label).coordinate = (1 : ZMod l.value)) :
    label = zmodCanonicalSignLabelQuotient l :=
  (data.cuspClassSource label).label_eq_canonical_of_coordinate_eq_one hcoord

def fullLabelLocalObject
    (_data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1FiniteLocalLogVolumeObject kind :=
  IUTStage1ZModCuspFullLabel.localObject zeroObject cuspClassObject label

theorem fullLabelLocalObject_zero
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    data.fullLabelLocalObject IUTStage1ZModCuspFullLabel.zero =
      zeroObject :=
  rfl

theorem fullLabelLocalObject_nonzero
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    data.fullLabelLocalObject (IUTStage1ZModCuspFullLabel.nonzero label) =
      cuspClassObject label :=
  rfl

theorem fullLabelLocalObject_transports_to_packet
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : IUTStage1ZModCuspFullLabel l) :
    data.fullLabelLocalObject label = packetObject := by
  cases label with
  | zero =>
      exact data.zeroOperation.source_transports_to_packet'
  | nonzero label =>
      exact (data.cuspClassOperation label).source_transports_to_packet'

theorem fullLabelLocalObject_fromCoordinate_zero
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject) :
    data.fullLabelLocalObject
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (0 : ZMod l.value)) =
      zeroObject := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_zero]
  rfl

theorem fullLabelLocalObject_fromCoordinate_nonzero
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (j : ZMod l.value) (hj : j ≠ 0) :
    data.fullLabelLocalObject (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      cuspClassObject (zmodSignLabelFromCoordinate l j hj) := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero l j hj]
  rfl

theorem cuspClassCoordinate_ne_zero
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (data.cuspClassSource label).coordinate ≠ 0 :=
  (data.cuspClassSource label).coordinate_ne_zero'

theorem zero_eq_cuspClass
    (data :
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData
        l hodgeData zeroObject cuspClassObject packetObject)
    (label : (zmodSignAction l).SignLabelQuotient) :
    zeroObject = cuspClassObject label :=
  data.toSourceMarkedCuspZeroLocalObjectOperationData.zero_eq_cuspClass label

end IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData

/--
Local packet-normalized compatibility together with a source classification.
-/
structure IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) where
  compatibility :
    IUTStage1LocalTensorPacketNormalizedCompatibility state
  identification_source : IUTStage1PacketNormalizedIdentificationSource

/--
Direct packet-normalization data expressed as a finite capsule-sum average.

This is more concrete than a bare equality with the `normalizedLogVolume` field:
it identifies the local object's finite log-volume with the average of the
packet's capsule log-volumes.
-/
structure IUTStage1DirectPacketNormalizationData
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) where
  localObject_finiteLogVolume_eq_capsuleSumAverage :
    state.localObject.finiteLogVolume =
      (Finset.univ.sum fun i =>
          (state.capsuleFamily.capsule i).logVolume) /
        (state.capsuleFamily.capsuleCount : Real)

/--
Upper semi-compatibility state used by the Theorem 3.11 `(Ind3)` model.

The booleans record whether the local comparison is modeled by the two source
features singled out in the statement of Theorem 3.11: natural inclusions at
nonarchimedean places and natural surjections at archimedean places.
-/
structure IUTStage1UpperSemiCompatibilityState where
  logThetaColumn : LogThetaColumnId
  compatibility : UpperSemiCompatibilityId
  nonarchimedeanInclusions : List IUTStage1NonarchimedeanInclusionData
  archimedeanSurjections : List IUTStage1ArchimedeanSurjectionData
  logVolumeCompatibility : IUTStage1LogVolumeCompatibilityData
  hasNonarchimedeanInclusions : Bool
  hasArchimedeanSurjections : Bool
  logVolumeCompatible : Prop
  log_volume_compatible : logVolumeCompatible

/--
Compatibility between `(Ind2)` place-family action data and the `(Ind3)`
upper-semi place-family data.

This record checks that the places carrying nonarchimedean `Ism` actions are
the same places appearing in the nonarchimedean inclusion data, and similarly
for archimedean order-two actions and archimedean surjections.
-/
structure IUTStage1Ind2UpperSemiPlaceFamilyCompatibility where
  ind2Actions : IUTStage1Ind2PlaceFamilyActionData
  upperSemiState : IUTStage1UpperSemiCompatibilityState
  nonarchimedean_places_eq :
    ind2Actions.nonarchimedeanPlaces =
      upperSemiState.nonarchimedeanInclusions.map fun data => data.place
  archimedean_places_eq :
    ind2Actions.archimedeanPlaces =
      upperSemiState.archimedeanSurjections.map fun data => data.place

namespace IUTStage1Ind2UpperSemiPlaceFamilyCompatibility

theorem nonarchimedeanPlaces_eq
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.ind2Actions.nonarchimedeanPlaces =
      data.upperSemiState.nonarchimedeanInclusions.map fun entry =>
        entry.place :=
  data.nonarchimedean_places_eq

theorem archimedeanPlaces_eq
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.ind2Actions.archimedeanPlaces =
      data.upperSemiState.archimedeanSurjections.map fun entry =>
        entry.place :=
  data.archimedean_places_eq

theorem logVolumeCompatible
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.upperSemiState.logVolumeCompatible :=
  data.upperSemiState.log_volume_compatible

theorem logVolumeUpperBound
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.upperSemiState.logVolumeCompatibility.sourceLogVolume <=
      data.upperSemiState.logVolumeCompatibility.targetLogVolume :=
  data.upperSemiState.logVolumeCompatibility.source_le_target

end IUTStage1Ind2UpperSemiPlaceFamilyCompatibility

namespace IUTStage1NonarchimedeanInclusionData

theorem sourcePlaceMatches
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.sourceObject.place = data.place :=
  data.source_place_eq

theorem targetPlaceMatches
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.targetObject.place = data.place :=
  data.target_place_eq

theorem sourceLogVolumeObjectMatches
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.sourceLogVolume.localObject.object = data.sourceObject :=
  data.source_log_volume_object_eq

theorem targetLogVolumeObjectMatches
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.targetLogVolume.localObject.object = data.targetObject :=
  data.target_log_volume_object_eq

theorem logVolume_le
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.sourceLogVolume.finiteLogVolume <=
      data.targetLogVolume.finiteLogVolume :=
  data.source_logVolume_le_target_logVolume

theorem valid (data : IUTStage1NonarchimedeanInclusionData) :
    data.inclusionValid :=
  data.inclusion_valid

end IUTStage1NonarchimedeanInclusionData

namespace IUTStage1ArchimedeanSurjectionData

theorem sourcePlaceMatches
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.sourceObject.place = data.place :=
  data.source_place_eq

theorem targetPlaceMatches
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.targetObject.place = data.place :=
  data.target_place_eq

theorem sourceLogVolumeObjectMatches
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.sourceLogVolume.localObject.object = data.sourceObject :=
  data.source_log_volume_object_eq

theorem targetLogVolumeObjectMatches
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.targetLogVolume.localObject.object = data.targetObject :=
  data.target_log_volume_object_eq

theorem logVolume_le
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.targetLogVolume.finiteLogVolume <=
      data.sourceLogVolume.finiteLogVolume :=
  data.target_logVolume_le_source_logVolume

theorem valid (data : IUTStage1ArchimedeanSurjectionData) :
    data.surjectionValid :=
  data.surjection_valid

end IUTStage1ArchimedeanSurjectionData

namespace IUTStage1LogVolumeCompatibilityData

theorem upperBound (data : IUTStage1LogVolumeCompatibilityData) :
    data.sourceLogVolume <= data.targetLogVolume :=
  data.source_le_target

end IUTStage1LogVolumeCompatibilityData

namespace IUTStage1ProcessionState

theorem same_procession_of_eq
    {state₁ state₂ : IUTStage1ProcessionState}
    (h : state₁ = state₂) :
    state₁.procession = state₂.procession := by
  cases h
  rfl

theorem same_column_of_eq
    {state₁ state₂ : IUTStage1ProcessionState}
    (h : state₁ = state₂) :
    state₁.column = state₂.column := by
  cases h
  rfl

end IUTStage1ProcessionState

namespace IUTStage1LocalTensorState

theorem same_summand_count_of_eq
    {state₁ state₂ : IUTStage1LocalTensorState}
    (h : state₁ = state₂) :
    state₁.directSummandCount = state₂.directSummandCount := by
  cases h
  rfl

end IUTStage1LocalTensorState

namespace IUTStage1LocalTensorPacketLogVolumeState

variable {kind : IUTStage1PlaceKind}

def toLocalTensorState
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    IUTStage1LocalTensorState :=
  state.tensorState

def toTypedCapsuleFamilyLogVolume
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    IUTStage1TypedCapsuleFamilyLogVolume kind :=
  state.capsuleFamily

theorem directSummandCount_eq_capsuleCount
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    state.tensorState.directSummandCount =
      state.capsuleFamily.capsuleCount :=
  state.direct_summand_count_eq_capsuleCount

theorem directSummandCount_pos
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    0 < state.tensorState.directSummandCount := by
  rw [state.direct_summand_count_eq_capsuleCount]
  exact state.capsuleFamily.capsuleCount_pos

theorem capsuleFamilyLocalObject_eq
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    state.capsuleFamily.localObject = state.localObject :=
  state.capsule_family_localObject_eq

theorem capsule_totalLogVolume_eq_sum
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    state.capsuleFamily.totalLogVolume =
      Finset.univ.sum fun i => (state.capsuleFamily.capsule i).logVolume :=
  state.capsuleFamily.total_eq

theorem capsule_normalizedLogVolume_eq
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    state.capsuleFamily.normalizedLogVolume =
      state.capsuleFamily.totalLogVolume /
        (state.capsuleFamily.capsuleCount : Real) :=
  state.capsuleFamily.normalized_eq

end IUTStage1LocalTensorPacketLogVolumeState

namespace IUTStage1LocalTensorPacketNormalizedCompatibility

variable {kind : IUTStage1PlaceKind}
variable {state : IUTStage1LocalTensorPacketLogVolumeState kind}

theorem localObject_finiteLogVolume_eq_normalizedLogVolume
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.normalizedLogVolume :=
  compat.normalizedLogVolume_eq_localObject.symm

theorem normalizedLogVolume_eq_capsuleAverage
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.totalLogVolume /
        (state.capsuleFamily.capsuleCount : Real) := by
  calc
    state.localObject.finiteLogVolume =
        state.capsuleFamily.normalizedLogVolume :=
      compat.localObject_finiteLogVolume_eq_normalizedLogVolume
    _ =
        state.capsuleFamily.totalLogVolume /
          (state.capsuleFamily.capsuleCount : Real) :=
      state.capsule_normalizedLogVolume_eq

end IUTStage1LocalTensorPacketNormalizedCompatibility

namespace IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility

variable {kind : IUTStage1PlaceKind}
variable {state : IUTStage1LocalTensorPacketLogVolumeState kind}

def ofDirectPacketNormalization
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state :=
  { compatibility := compat,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization }

def ofInd2TransportedPacketNormalization
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state :=
  { compatibility := compat,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization }

def ofSeparateRealLineIdentification
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state :=
  { compatibility := compat,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.separateRealLineIdentification }

theorem localObject_finiteLogVolume_eq_normalizedLogVolume
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.normalizedLogVolume :=
  classified.compatibility.localObject_finiteLogVolume_eq_normalizedLogVolume

theorem normalizedLogVolume_eq_capsuleAverage
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.totalLogVolume /
        (state.capsuleFamily.capsuleCount : Real) :=
  classified.compatibility.normalizedLogVolume_eq_capsuleAverage

end IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility

namespace IUTStage1DirectPacketNormalizationData

variable {kind : IUTStage1PlaceKind}
variable {state : IUTStage1LocalTensorPacketLogVolumeState kind}

theorem localObject_finiteLogVolume_eq_capsuleAverage
    (data : IUTStage1DirectPacketNormalizationData state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.totalLogVolume /
        (state.capsuleFamily.capsuleCount : Real) := by
  calc
    state.localObject.finiteLogVolume =
        (Finset.univ.sum fun i =>
            (state.capsuleFamily.capsule i).logVolume) /
          (state.capsuleFamily.capsuleCount : Real) :=
      data.localObject_finiteLogVolume_eq_capsuleSumAverage
    _ =
        state.capsuleFamily.totalLogVolume /
          (state.capsuleFamily.capsuleCount : Real) := by
      rw [state.capsule_totalLogVolume_eq_sum]

def toPacketNormalizedCompatibility
    (data : IUTStage1DirectPacketNormalizationData state) :
    IUTStage1LocalTensorPacketNormalizedCompatibility state :=
  { normalizedLogVolume_eq_localObject := by
      calc
        state.capsuleFamily.normalizedLogVolume =
            state.capsuleFamily.totalLogVolume /
              (state.capsuleFamily.capsuleCount : Real) :=
          state.capsule_normalizedLogVolume_eq
        _ = state.localObject.finiteLogVolume :=
          data.localObject_finiteLogVolume_eq_capsuleAverage.symm }

def toClassifiedPacketNormalizedCompatibility
    (data : IUTStage1DirectPacketNormalizationData state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state :=
  IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility.ofDirectPacketNormalization
    data.toPacketNormalizedCompatibility

theorem targetSigned_le_localObject_of_capsule_le
    (data : IUTStage1DirectPacketNormalizationData state)
    {targetSigned : Real}
    (hcapsule :
      ∀ i : Fin state.capsuleFamily.capsuleCount,
        targetSigned <= (state.capsuleFamily.capsule i).logVolume) :
    targetSigned <= state.localObject.finiteLogVolume := by
  have hnormalized :
      targetSigned <= state.capsuleFamily.normalizedLogVolume :=
    state.capsuleFamily.const_le_normalizedLogVolume_of_capsule_le hcapsule
  rw [data.toPacketNormalizedCompatibility.normalizedLogVolume_eq_localObject]
    at hnormalized
  exact hnormalized

theorem targetSigned_le_localObject_of_capsule_estimates
    (data : IUTStage1DirectPacketNormalizationData state)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned state.capsuleFamily) :
    targetSigned <= state.localObject.finiteLogVolume :=
  data.targetSigned_le_localObject_of_capsule_le
    estimate.targetSigned_le_capsuleLogVolume

def toLocalObjectContainerEstimateOfCapsuleEstimates
    (data : IUTStage1DirectPacketNormalizationData state)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned state.capsuleFamily) :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned state.localObject.finiteLogVolume :=
  { localObject := state.localObject,
    localLogVolume_eq_object := rfl,
    object_container_estimate :=
      { containerLogVolume := state.localObject.finiteLogVolume,
        localLogVolume_eq_container := rfl,
        targetSigned_le_containerLogVolume :=
          data.targetSigned_le_localObject_of_capsule_estimates estimate } }

def toLocalObjectContainerEstimateOfIdentifiedLogVolume
    (data : IUTStage1DirectPacketNormalizationData state)
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned state.capsuleFamily)
    (hlog : localLogVolume = state.localObject.finiteLogVolume) :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned localLogVolume :=
  IUTStage1LocalObjectContainerLogVolumeEstimate.transportLocalLogVolume
    (data.toLocalObjectContainerEstimateOfCapsuleEstimates estimate) hlog

theorem identifiedLogVolumeEstimate_localObject
    (data : IUTStage1DirectPacketNormalizationData state)
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned state.capsuleFamily)
    (hlog : localLogVolume = state.localObject.finiteLogVolume) :
    (data.toLocalObjectContainerEstimateOfIdentifiedLogVolume
      estimate hlog).localObject = state.localObject :=
  rfl

end IUTStage1DirectPacketNormalizationData

namespace IUTStage1LocalTensorDirectSummandPacketState

variable {kind : IUTStage1PlaceKind}

def toLocalTensorPacketLogVolumeState
    (state : IUTStage1LocalTensorDirectSummandPacketState kind) :
    IUTStage1LocalTensorPacketLogVolumeState kind :=
  state.packetState

def toLocalTensorState
    (state : IUTStage1LocalTensorDirectSummandPacketState kind) :
    IUTStage1LocalTensorState :=
  state.packetState.tensorState

theorem directSummandCount_eq_capsuleCount
    (state : IUTStage1LocalTensorDirectSummandPacketState kind) :
    state.packetState.tensorState.directSummandCount =
      state.packetState.capsuleFamily.capsuleCount :=
  state.packetState.directSummandCount_eq_capsuleCount

theorem directSummandCount_pos
    (state : IUTStage1LocalTensorDirectSummandPacketState kind) :
    0 < state.packetState.tensorState.directSummandCount :=
  state.packetState.directSummandCount_pos

theorem summandCapsule_eq
    (state : IUTStage1LocalTensorDirectSummandPacketState kind)
    (i : Fin state.packetState.capsuleFamily.capsuleCount) :
    (state.summandFamily.summand i).capsule =
      state.packetState.capsuleFamily.capsule i :=
  state.summandFamily.summandCapsule_eq i

theorem summandCapsuleLogVolume_eq
    (state : IUTStage1LocalTensorDirectSummandPacketState kind)
    (i : Fin state.packetState.capsuleFamily.capsuleCount) :
    (state.summandFamily.summand i).capsule.logVolume =
      (state.packetState.capsuleFamily.capsule i).logVolume :=
  state.summandFamily.summandCapsuleLogVolume_eq i

end IUTStage1LocalTensorDirectSummandPacketState

/--
Container estimate for a real that is identified with the normalized
capsule-family log-volume of a local tensor packet.
-/
structure IUTStage1PacketNormalizedContainerEstimate
    {kind : IUTStage1PlaceKind}
    (packetState : IUTStage1LocalTensorDirectSummandPacketState kind)
    (targetSigned localLogVolume : Real) where
  objectEstimate :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned localLogVolume
  localObject_eq_packetLocalObject :
    objectEstimate.localObject = packetState.packetState.localObject
  localLogVolume_eq_packetNormalized :
    localLogVolume =
      packetState.packetState.capsuleFamily.normalizedLogVolume

namespace IUTStage1PacketNormalizedContainerEstimate

variable {kind : IUTStage1PlaceKind}
variable {packetState : IUTStage1LocalTensorDirectSummandPacketState kind}
variable {targetSigned localLogVolume : Real}

def toLocalObjectContainerEstimate
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned localLogVolume :=
  estimate.objectEstimate

theorem localObject_eq_packetLocalObject'
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    estimate.objectEstimate.localObject =
      packetState.packetState.localObject :=
  estimate.localObject_eq_packetLocalObject

theorem localLogVolume_eq_packetNormalized'
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    localLogVolume =
      packetState.packetState.capsuleFamily.normalizedLogVolume :=
  estimate.localLogVolume_eq_packetNormalized

def ofLocalObjectCompatibility
    (objectEstimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume)
    (hobject :
      objectEstimate.localObject =
        packetState.packetState.localObject)
    (compat :
      IUTStage1LocalTensorPacketNormalizedCompatibility
        packetState.packetState) :
    IUTStage1PacketNormalizedContainerEstimate
      packetState targetSigned localLogVolume :=
  { objectEstimate := objectEstimate,
    localObject_eq_packetLocalObject := hobject,
    localLogVolume_eq_packetNormalized := by
      calc
        localLogVolume =
            objectEstimate.localObject.finiteLogVolume :=
          objectEstimate.localLogVolume_eq_object
        _ =
            packetState.packetState.localObject.finiteLogVolume := by
          rw [hobject]
        _ =
            packetState.packetState.capsuleFamily.normalizedLogVolume :=
          compat.localObject_finiteLogVolume_eq_normalizedLogVolume }

def ofClassifiedLocalObjectCompatibility
    (objectEstimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume)
    (hobject :
      objectEstimate.localObject =
        packetState.packetState.localObject)
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        packetState.packetState) :
    IUTStage1PacketNormalizedContainerEstimate
      packetState targetSigned localLogVolume :=
  ofLocalObjectCompatibility objectEstimate hobject
    classified.compatibility

theorem targetSigned_le_localLogVolume
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    targetSigned <= localLogVolume :=
  estimate.objectEstimate.targetSigned_le_localLogVolume

theorem localLogVolume_eq_capsuleAverage
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    localLogVolume =
      packetState.packetState.capsuleFamily.totalLogVolume /
        (packetState.packetState.capsuleFamily.capsuleCount : Real) := by
  calc
    localLogVolume =
        packetState.packetState.capsuleFamily.normalizedLogVolume :=
      estimate.localLogVolume_eq_packetNormalized
    _ =
        packetState.packetState.capsuleFamily.totalLogVolume /
          (packetState.packetState.capsuleFamily.capsuleCount : Real) :=
      packetState.packetState.capsule_normalizedLogVolume_eq

theorem localLogVolume_eq_capsuleSumAverage
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    localLogVolume =
      (Finset.univ.sum fun i =>
          (packetState.packetState.capsuleFamily.capsule i).logVolume) /
        (packetState.packetState.capsuleFamily.capsuleCount : Real) := by
  calc
    localLogVolume =
        packetState.packetState.capsuleFamily.totalLogVolume /
          (packetState.packetState.capsuleFamily.capsuleCount : Real) :=
      estimate.localLogVolume_eq_capsuleAverage
    _ =
        (Finset.univ.sum fun i =>
            (packetState.packetState.capsuleFamily.capsule i).logVolume) /
          (packetState.packetState.capsuleFamily.capsuleCount : Real) := by
      rw [packetState.packetState.capsule_totalLogVolume_eq_sum]

theorem targetSigned_le_localLogVolume_of_capsule_le
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume)
    (hcapsule :
      ∀ i : Fin packetState.packetState.capsuleFamily.capsuleCount,
        targetSigned <=
          (packetState.packetState.capsuleFamily.capsule i).logVolume) :
    targetSigned <= localLogVolume := by
  rw [estimate.localLogVolume_eq_packetNormalized]
  exact
    packetState.packetState.capsuleFamily.const_le_normalizedLogVolume_of_capsule_le
      hcapsule

theorem targetSigned_le_localLogVolume_of_capsule_estimates
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume)
    (capsuleEstimates :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned packetState.packetState.capsuleFamily) :
    targetSigned <= localLogVolume :=
  estimate.targetSigned_le_localLogVolume_of_capsule_le
    capsuleEstimates.targetSigned_le_capsuleLogVolume

end IUTStage1PacketNormalizedContainerEstimate

namespace IUTStage1UpperSemiCompatibilityState

theorem logVolumeCompatibleProof
    (state : IUTStage1UpperSemiCompatibilityState) :
    state.logVolumeCompatible :=
  state.log_volume_compatible

theorem same_logThetaColumn_of_eq
    {state₁ state₂ : IUTStage1UpperSemiCompatibilityState}
    (h : state₁ = state₂) :
    state₁.logThetaColumn = state₂.logThetaColumn := by
  cases h
  rfl

theorem same_compatibility_of_eq
    {state₁ state₂ : IUTStage1UpperSemiCompatibilityState}
    (h : state₁ = state₂) :
    state₁.compatibility = state₂.compatibility := by
  cases h
  rfl

theorem logVolumeUpperBound
    (state : IUTStage1UpperSemiCompatibilityState) :
    state.logVolumeCompatibility.sourceLogVolume <=
      state.logVolumeCompatibility.targetLogVolume :=
  state.logVolumeCompatibility.upperBound

end IUTStage1UpperSemiCompatibilityState

/--
Source-shaped choice data for Theorem 3.11.

The integer coordinates model the log-theta-lattice column `n` and row `m`.
The remaining coordinates separate the coric data from the representative data
affected by `(Ind1)`, `(Ind2)`, `(Ind3)`.
-/
structure IUTStage1Theorem311Choice
    (coric : Type u) (processionState : Type v)
    (localTensorState : Type w) (upperSemiState : Type x) where
  column : Int
  row : Int
  coric : coric
  procession_state : processionState
  local_tensor_state : localTensorState
  upper_semi_state : upperSemiState

namespace IUTStage1Theorem311Choice

variable {coric : Type u} {processionState : Type v}
variable {localTensorState : Type w} {upperSemiState : Type x}

abbrev Choice :=
  IUTStage1Theorem311Choice
    coric processionState localTensorState upperSemiState

/-- `(Ind1)` changes procession representatives and preserves the other coordinates. -/
structure ProcessionAutomorphismStep
    (choice₁ choice₂ : Choice
      (coric := coric) (processionState := processionState)
      (localTensorState := localTensorState)
      (upperSemiState := upperSemiState)) : Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  local_tensor_eq : choice₁.local_tensor_state = choice₂.local_tensor_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state

/-- `(Ind2)` changes local tensor representatives and preserves the other coordinates. -/
structure LocalTensorSymmetryStep
    (choice₁ choice₂ : Choice
      (coric := coric) (processionState := processionState)
      (localTensorState := localTensorState)
      (upperSemiState := upperSemiState)) : Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state

/--
`(Ind3)` records upper semi-compatibility as the row `m` varies. It preserves
the column and coric data but may change the row and upper-semi representative.
-/
structure UpperSemiCompatibilityStep
    (choice₁ choice₂ : Choice
      (coric := coric) (processionState := processionState)
      (localTensorState := localTensorState)
      (upperSemiState := upperSemiState)) : Prop where
  column_eq : choice₁.column = choice₂.column
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  local_tensor_eq : choice₁.local_tensor_state = choice₂.local_tensor_state

def indeterminacySourceData :
    IUTStage1Theorem311IndeterminacySourceData
      (Choice
        (coric := coric) (processionState := processionState)
        (localTensorState := localTensorState)
        (upperSemiState := upperSemiState)) :=
  { procession_automorphism_step := ProcessionAutomorphismStep,
    local_tensor_symmetry_step := LocalTensorSymmetryStep,
    upper_semi_compatibility_step := UpperSemiCompatibilityStep }

theorem generated_coric_eq
    {choice₁ choice₂ :
      Choice
        (coric := coric) (processionState := processionState)
        (localTensorState := localTensorState)
        (upperSemiState := upperSemiState)}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        indeterminacySourceData.generators choice₁ choice₂) :
    choice₁.coric = choice₂.coric := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.coric_eq
  | ind2 hstep =>
      exact hstep.coric_eq
  | ind3 hstep =>
      exact hstep.coric_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem generated_column_eq
    {choice₁ choice₂ :
      Choice
        (coric := coric) (processionState := processionState)
        (localTensorState := localTensorState)
        (upperSemiState := upperSemiState)}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        indeterminacySourceData.generators choice₁ choice₂) :
    choice₁.column = choice₂.column := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.column_eq
  | ind2 hstep =>
      exact hstep.column_eq
  | ind3 hstep =>
      exact hstep.column_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (Choice
          (coric := coric) (processionState := processionState)
          (localTensorState := localTensorState)
          (upperSemiState := upperSemiState)))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂) :
    ∀ {choice₁ choice₂ :
      Choice
        (coric := coric) (processionState := processionState)
        (localTensorState := localTensorState)
        (upperSemiState := upperSemiState)},
      IUTStage1GeneratedIndeterminacyRelation
        indeterminacySourceData.generators choice₁ choice₂ ->
        images.region choice₁ = images.region choice₂ := by
  intro choice₁ choice₂ hrel
  exact hcoric choice₁ choice₂ (generated_coric_eq hrel)

end IUTStage1Theorem311Choice

/--
Theorem 3.11 choice specialized to the state records currently modeled in this
file.
-/
abbrev IUTStage1StructuredTheorem311Choice (coric : Type u) :=
  IUTStage1Theorem311Choice
    coric
    IUTStage1ProcessionState
    IUTStage1LocalTensorState
    IUTStage1UpperSemiCompatibilityState

namespace IUTStage1StructuredTheorem311Choice

variable {coric : Type u}

/-- Structured `(Ind1)` step: procession representative may change. -/
structure ProcessionAutomorphismStep
    (choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric) : Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq :
    choice₁.procession_state.procession =
      choice₂.procession_state.procession
  procession_column_eq :
    choice₁.procession_state.column = choice₂.procession_state.column
  local_tensor_eq : choice₁.local_tensor_state = choice₂.local_tensor_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state

/-- Structured `(Ind2)` step: local tensor representative may change. -/
structure LocalTensorSymmetryStep
    (choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric) : Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  direct_summand_count_eq :
    choice₁.local_tensor_state.directSummandCount =
      choice₂.local_tensor_state.directSummandCount
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state

/--
Structured `(Ind3)` step: row and upper-semi representative may vary, but the
log-theta column and the local comparison shape are preserved.
-/
structure UpperSemiCompatibilityStep
    (choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric) : Prop where
  column_eq : choice₁.column = choice₂.column
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  local_tensor_eq : choice₁.local_tensor_state = choice₂.local_tensor_state
  logThetaColumn_eq :
    choice₁.upper_semi_state.logThetaColumn =
      choice₂.upper_semi_state.logThetaColumn
  nonarchimedean_inclusions_eq :
    choice₁.upper_semi_state.nonarchimedeanInclusions =
      choice₂.upper_semi_state.nonarchimedeanInclusions
  archimedean_surjections_eq :
    choice₁.upper_semi_state.archimedeanSurjections =
      choice₂.upper_semi_state.archimedeanSurjections
  log_volume_compatibility_eq :
    choice₁.upper_semi_state.logVolumeCompatibility =
      choice₂.upper_semi_state.logVolumeCompatibility
  has_nonarchimedean_inclusions_eq :
    choice₁.upper_semi_state.hasNonarchimedeanInclusions =
      choice₂.upper_semi_state.hasNonarchimedeanInclusions
  has_archimedean_surjections_eq :
    choice₁.upper_semi_state.hasArchimedeanSurjections =
      choice₂.upper_semi_state.hasArchimedeanSurjections

def indeterminacySourceData :
    IUTStage1Theorem311IndeterminacySourceData
      (IUTStage1StructuredTheorem311Choice coric) :=
  { procession_automorphism_step := ProcessionAutomorphismStep,
    local_tensor_symmetry_step := LocalTensorSymmetryStep,
    upper_semi_compatibility_step := UpperSemiCompatibilityStep }

theorem ind1_preserves_procession_column
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      ProcessionAutomorphismStep choice₁ choice₂) :
    choice₁.procession_state.column = choice₂.procession_state.column := by
  exact hstep.procession_column_eq

theorem ind2_preserves_directSummandCount
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      LocalTensorSymmetryStep choice₁ choice₂) :
    choice₁.local_tensor_state.directSummandCount =
      choice₂.local_tensor_state.directSummandCount := by
  exact hstep.direct_summand_count_eq

theorem ind3_preserves_logThetaColumn
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      UpperSemiCompatibilityStep choice₁ choice₂) :
    choice₁.upper_semi_state.logThetaColumn =
      choice₂.upper_semi_state.logThetaColumn := by
  exact hstep.logThetaColumn_eq

theorem ind3_preserves_nonarchimedeanInclusions
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      UpperSemiCompatibilityStep choice₁ choice₂) :
    choice₁.upper_semi_state.nonarchimedeanInclusions =
      choice₂.upper_semi_state.nonarchimedeanInclusions := by
  exact hstep.nonarchimedean_inclusions_eq

theorem ind3_preserves_archimedeanSurjections
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      UpperSemiCompatibilityStep choice₁ choice₂) :
    choice₁.upper_semi_state.archimedeanSurjections =
      choice₂.upper_semi_state.archimedeanSurjections := by
  exact hstep.archimedean_surjections_eq

theorem ind3_preserves_logVolumeCompatibility
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      UpperSemiCompatibilityStep choice₁ choice₂) :
    choice₁.upper_semi_state.logVolumeCompatibility =
      choice₂.upper_semi_state.logVolumeCompatibility := by
  exact hstep.log_volume_compatibility_eq

theorem ind3_target_logVolumeCompatible
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (_hstep :
      UpperSemiCompatibilityStep choice₁ choice₂) :
    choice₂.upper_semi_state.logVolumeCompatible := by
  exact choice₂.upper_semi_state.logVolumeCompatibleProof

theorem ind3_target_logVolumeUpperBound
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (_hstep :
      UpperSemiCompatibilityStep choice₁ choice₂) :
    choice₂.upper_semi_state.logVolumeCompatibility.sourceLogVolume <=
      choice₂.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  choice₂.upper_semi_state.logVolumeUpperBound

theorem generated_preserves_coric
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.coric_eq
  | ind2 hstep =>
      exact hstep.coric_eq
  | ind3 hstep =>
      exact hstep.coric_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem generated_preserves_column
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.column = choice₂.column := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.column_eq
  | ind2 hstep =>
      exact hstep.column_eq
  | ind3 hstep =>
      exact hstep.column_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

end IUTStage1StructuredTheorem311Choice

/--
Theorem 3.11 choice whose local tensor coordinate already carries typed
capsule/log-volume data.
-/
abbrev IUTStage1TensorPacketTheorem311Choice
    (coric : Type u) (kind : IUTStage1PlaceKind) :=
  IUTStage1Theorem311Choice
    coric
    IUTStage1ProcessionState
    (IUTStage1LocalTensorPacketLogVolumeState kind)
    IUTStage1UpperSemiCompatibilityState

namespace IUTStage1TensorPacketTheorem311Choice

variable {coric : Type u} {kind : IUTStage1PlaceKind}

/--
Forget the typed capsule/log-volume refinement of the local tensor coordinate.

This is deliberately one-way: later refined steps must prove that the extra
packet/log-volume fields are preserved or transformed correctly before they can
descend to the older structured interface.
-/
def forgetPacket
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    IUTStage1StructuredTheorem311Choice coric :=
  { column := choice.column,
    row := choice.row,
    coric := choice.coric,
    procession_state := choice.procession_state,
    local_tensor_state := choice.local_tensor_state.toLocalTensorState,
    upper_semi_state := choice.upper_semi_state }

theorem forgetPacket_column
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    choice.forgetPacket.column = choice.column :=
  rfl

theorem forgetPacket_row
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    choice.forgetPacket.row = choice.row :=
  rfl

theorem localTensor_directSummandCount_eq_capsuleCount
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    choice.local_tensor_state.tensorState.directSummandCount =
      choice.local_tensor_state.capsuleFamily.capsuleCount :=
  choice.local_tensor_state.directSummandCount_eq_capsuleCount

theorem localTensor_directSummandCount_pos
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    0 < choice.local_tensor_state.tensorState.directSummandCount :=
  choice.local_tensor_state.directSummandCount_pos

theorem localTensor_capsule_totalLogVolume_eq_sum
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    choice.local_tensor_state.capsuleFamily.totalLogVolume =
      Finset.univ.sum fun i =>
        (choice.local_tensor_state.capsuleFamily.capsule i).logVolume :=
  choice.local_tensor_state.capsule_totalLogVolume_eq_sum

/--
Packet-aware `(Ind2)` step.

The local tensor representative may change, but the procession, coric data,
upper-semi data, and packet-level log-volume quantities are preserved.
-/
structure LocalTensorPacketSymmetryStep
    (choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind) :
    Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state
  local_object_eq :
    choice₁.local_tensor_state.localObject =
      choice₂.local_tensor_state.localObject
  capsule_count_eq :
    choice₁.local_tensor_state.capsuleFamily.capsuleCount =
      choice₂.local_tensor_state.capsuleFamily.capsuleCount
  capsule_totalLogVolume_eq :
    choice₁.local_tensor_state.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.capsuleFamily.totalLogVolume
  capsule_normalizedLogVolume_eq :
    choice₁.local_tensor_state.capsuleFamily.normalizedLogVolume =
      choice₂.local_tensor_state.capsuleFamily.normalizedLogVolume

theorem ind2_preserves_directSummandCount
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketSymmetryStep choice₁ choice₂) :
    choice₁.local_tensor_state.tensorState.directSummandCount =
      choice₂.local_tensor_state.tensorState.directSummandCount := by
  calc
    choice₁.local_tensor_state.tensorState.directSummandCount =
        choice₁.local_tensor_state.capsuleFamily.capsuleCount :=
      choice₁.local_tensor_state.directSummandCount_eq_capsuleCount
    _ = choice₂.local_tensor_state.capsuleFamily.capsuleCount :=
      hstep.capsule_count_eq
    _ = choice₂.local_tensor_state.tensorState.directSummandCount :=
      (choice₂.local_tensor_state.directSummandCount_eq_capsuleCount).symm

theorem ind2_preserves_localObject
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketSymmetryStep choice₁ choice₂) :
    choice₁.local_tensor_state.localObject =
      choice₂.local_tensor_state.localObject :=
  hstep.local_object_eq

theorem ind2_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketSymmetryStep choice₁ choice₂) :
    choice₁.local_tensor_state.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.capsuleFamily.totalLogVolume :=
  hstep.capsule_totalLogVolume_eq

theorem ind2_preserves_capsuleNormalizedLogVolume
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketSymmetryStep choice₁ choice₂) :
    choice₁.local_tensor_state.capsuleFamily.normalizedLogVolume =
      choice₂.local_tensor_state.capsuleFamily.normalizedLogVolume :=
  hstep.capsule_normalizedLogVolume_eq

def ind2_transports_packetNormalizedCompatibility
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketSymmetryStep choice₁ choice₂)
    (compat :
      IUTStage1LocalTensorPacketNormalizedCompatibility
        choice₁.local_tensor_state) :
    IUTStage1LocalTensorPacketNormalizedCompatibility
      choice₂.local_tensor_state :=
  { normalizedLogVolume_eq_localObject := by
      calc
        choice₂.local_tensor_state.capsuleFamily.normalizedLogVolume =
            choice₁.local_tensor_state.capsuleFamily.normalizedLogVolume :=
          hstep.capsule_normalizedLogVolume_eq.symm
        _ = choice₁.local_tensor_state.localObject.finiteLogVolume :=
          compat.normalizedLogVolume_eq_localObject
        _ = choice₂.local_tensor_state.localObject.finiteLogVolume := by
          rw [hstep.local_object_eq] }

def ind2_transports_classifiedPacketNormalizedCompatibility
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketSymmetryStep choice₁ choice₂)
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        choice₁.local_tensor_state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      choice₂.local_tensor_state :=
  IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility.ofInd2TransportedPacketNormalization
    (ind2_transports_packetNormalizedCompatibility hstep
      classified.compatibility)

def toStructuredLocalTensorSymmetryStep
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketSymmetryStep choice₁ choice₂) :
    IUTStage1StructuredTheorem311Choice.LocalTensorSymmetryStep
      choice₁.forgetPacket choice₂.forgetPacket :=
  { column_eq := hstep.column_eq,
    row_eq := hstep.row_eq,
    coric_eq := hstep.coric_eq,
    procession_eq := hstep.procession_eq,
    direct_summand_count_eq :=
      ind2_preserves_directSummandCount hstep,
    upper_semi_eq := hstep.upper_semi_eq }

/--
Packet-aware `(Ind2)` step generated by an action on the indexed capsule
family.

This is stronger than `LocalTensorPacketSymmetryStep`: total and normalized
log-volume preservation are consequences of pointwise capsule log-volume
preservation.
-/
structure LocalTensorPacketActionStep
    (choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind) :
    Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state
  local_object_eq :
    choice₁.local_tensor_state.localObject =
      choice₂.local_tensor_state.localObject
  capsule_action_exists :
    ∃ action :
      IUTStage1TypedCapsuleFamilyLogVolumeAction
        choice₁.local_tensor_state.capsuleFamily,
      choice₂.local_tensor_state.capsuleFamily =
        action.transformedFamily

theorem actionStep_preserves_capsuleCount
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketActionStep choice₁ choice₂) :
    choice₁.local_tensor_state.capsuleFamily.capsuleCount =
      choice₂.local_tensor_state.capsuleFamily.capsuleCount := by
  rcases hstep.capsule_action_exists with ⟨action, htarget⟩
  rw [htarget]
  exact action.transformedFamily_capsuleCount.symm

theorem actionStep_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketActionStep choice₁ choice₂) :
    choice₁.local_tensor_state.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.capsuleFamily.totalLogVolume := by
  rcases hstep.capsule_action_exists with ⟨action, htarget⟩
  rw [htarget]
  exact action.transformedFamily_totalLogVolume.symm

theorem actionStep_preserves_capsuleNormalizedLogVolume
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketActionStep choice₁ choice₂) :
    choice₁.local_tensor_state.capsuleFamily.normalizedLogVolume =
      choice₂.local_tensor_state.capsuleFamily.normalizedLogVolume := by
  rcases hstep.capsule_action_exists with ⟨action, htarget⟩
  rw [htarget]
  exact action.transformedFamily_normalizedLogVolume.symm

def actionStep_toPacketSymmetryStep
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketActionStep choice₁ choice₂) :
    LocalTensorPacketSymmetryStep choice₁ choice₂ :=
  { column_eq := hstep.column_eq,
    row_eq := hstep.row_eq,
    coric_eq := hstep.coric_eq,
    procession_eq := hstep.procession_eq,
    upper_semi_eq := hstep.upper_semi_eq,
    local_object_eq := hstep.local_object_eq,
    capsule_count_eq := actionStep_preserves_capsuleCount hstep,
    capsule_totalLogVolume_eq :=
      actionStep_preserves_capsuleTotalLogVolume hstep,
    capsule_normalizedLogVolume_eq :=
      actionStep_preserves_capsuleNormalizedLogVolume hstep }

theorem actionStep_preserves_directSummandCount
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep : LocalTensorPacketActionStep choice₁ choice₂) :
    choice₁.local_tensor_state.tensorState.directSummandCount =
      choice₂.local_tensor_state.tensorState.directSummandCount :=
  ind2_preserves_directSummandCount
    (actionStep_toPacketSymmetryStep hstep)

end IUTStage1TensorPacketTheorem311Choice

/--
Theorem 3.11 choice whose local tensor coordinate carries both typed capsule
log-volume data and the direct summand family that induces capsule actions.
-/
abbrev IUTStage1DirectSummandPacketTheorem311Choice
    (coric : Type u) (kind : IUTStage1PlaceKind) :=
  IUTStage1Theorem311Choice
    coric
    IUTStage1ProcessionState
    (IUTStage1LocalTensorDirectSummandPacketState kind)
    IUTStage1UpperSemiCompatibilityState

namespace IUTStage1DirectSummandPacketTheorem311Choice

variable {coric : Type u} {kind : IUTStage1PlaceKind}

def forgetDirectSummands
    (choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind) :
    IUTStage1TensorPacketTheorem311Choice coric kind :=
  { column := choice.column,
    row := choice.row,
    coric := choice.coric,
    procession_state := choice.procession_state,
    local_tensor_state :=
      choice.local_tensor_state.toLocalTensorPacketLogVolumeState,
    upper_semi_state := choice.upper_semi_state }

def forgetPacket
    (choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind) :
    IUTStage1StructuredTheorem311Choice coric :=
  choice.forgetDirectSummands.forgetPacket

theorem localTensor_directSummandCount_eq_capsuleCount
    (choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind) :
    choice.local_tensor_state.packetState.tensorState.directSummandCount =
      choice.local_tensor_state.packetState.capsuleFamily.capsuleCount :=
  choice.local_tensor_state.directSummandCount_eq_capsuleCount

theorem localTensor_summandCapsuleLogVolume_eq
    (choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind)
    (i : Fin choice.local_tensor_state.packetState.capsuleFamily.capsuleCount) :
    (choice.local_tensor_state.summandFamily.summand i).capsule.logVolume =
      (choice.local_tensor_state.packetState.capsuleFamily.capsule i).logVolume :=
  choice.local_tensor_state.summandCapsuleLogVolume_eq i

/--
Direct-summand-level `(Ind2)` step for the refined packet choice.

The step records an action on the source direct summand family whose induced
capsule action gives the target capsule family.
-/
structure LocalTensorDirectSummandActionStep
    (choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind) :
    Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state
  local_object_eq :
    choice₁.local_tensor_state.packetState.localObject =
      choice₂.local_tensor_state.packetState.localObject
  summand_action_exists :
    ∃ action :
      IUTStage1TensorDirectSummandFamilyAction
        choice₁.local_tensor_state.summandFamily,
      choice₂.local_tensor_state.packetState.capsuleFamily =
        action.toCapsuleAction.transformedFamily

def toTensorPacketActionStep
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : LocalTensorDirectSummandActionStep choice₁ choice₂) :
    IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketActionStep
      choice₁.forgetDirectSummands choice₂.forgetDirectSummands :=
  { column_eq := hstep.column_eq,
    row_eq := hstep.row_eq,
    coric_eq := hstep.coric_eq,
    procession_eq := hstep.procession_eq,
    upper_semi_eq := hstep.upper_semi_eq,
    local_object_eq := hstep.local_object_eq,
    capsule_action_exists := by
      rcases hstep.summand_action_exists with ⟨action, htarget⟩
      exact ⟨action.toCapsuleAction, htarget⟩ }

theorem ind2_preserves_directSummandCount
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : LocalTensorDirectSummandActionStep choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.tensorState.directSummandCount =
      choice₂.local_tensor_state.packetState.tensorState.directSummandCount :=
  IUTStage1TensorPacketTheorem311Choice.actionStep_preserves_directSummandCount
    (toTensorPacketActionStep hstep)

theorem ind2_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : LocalTensorDirectSummandActionStep choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1TensorPacketTheorem311Choice.actionStep_preserves_capsuleTotalLogVolume
    (toTensorPacketActionStep hstep)

theorem ind2_preserves_capsuleNormalizedLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : LocalTensorDirectSummandActionStep choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1TensorPacketTheorem311Choice.actionStep_preserves_capsuleNormalizedLogVolume
    (toTensorPacketActionStep hstep)

def ind2_transports_packetNormalizedCompatibility
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : LocalTensorDirectSummandActionStep choice₁ choice₂)
    (compat :
      IUTStage1LocalTensorPacketNormalizedCompatibility
        choice₁.local_tensor_state.packetState) :
    IUTStage1LocalTensorPacketNormalizedCompatibility
      choice₂.local_tensor_state.packetState :=
  IUTStage1TensorPacketTheorem311Choice.ind2_transports_packetNormalizedCompatibility
    (IUTStage1TensorPacketTheorem311Choice.actionStep_toPacketSymmetryStep
      (toTensorPacketActionStep hstep))
    compat

def ind2_transports_classifiedPacketNormalizedCompatibility
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : LocalTensorDirectSummandActionStep choice₁ choice₂)
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        choice₁.local_tensor_state.packetState) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      choice₂.local_tensor_state.packetState :=
  IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility.ofInd2TransportedPacketNormalization
    (ind2_transports_packetNormalizedCompatibility hstep
      classified.compatibility)

theorem ind2_transports_capsuleContainerBound
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : LocalTensorDirectSummandActionStep choice₁ choice₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned choice₁.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      choice₂.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  rcases hstep.summand_action_exists with ⟨action, htarget⟩
  rw [htarget]
  exact
    action.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
      estimate

/-- Nonarchimedean `Ism` instance of the direct-summand `(Ind2)` step. -/
structure NonarchimedeanIsmInd2Step
    (choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean) :
    Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state
  local_object_eq :
    choice₁.local_tensor_state.packetState.localObject =
      choice₂.local_tensor_state.packetState.localObject
  ism_action_exists :
    ∃ action :
      IUTStage1NonarchimedeanIsmDirectSummandAction
        choice₁.local_tensor_state.summandFamily,
      choice₂.local_tensor_state.packetState.capsuleFamily =
        action.toDirectSummandAction.toCapsuleAction.transformedFamily

/-- Archimedean order-two instance of the direct-summand `(Ind2)` step. -/
structure ArchimedeanOrderTwoInd2Step
    (choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean) :
    Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state
  local_object_eq :
    choice₁.local_tensor_state.packetState.localObject =
      choice₂.local_tensor_state.packetState.localObject
  order_two_action_exists :
    ∃ action :
      IUTStage1ArchimedeanOrderTwoDirectSummandAction
        choice₁.local_tensor_state.summandFamily,
      choice₂.local_tensor_state.packetState.capsuleFamily =
        action.toDirectSummandAction.toCapsuleAction.transformedFamily

def nonarchimedeanIsm_toDirectSummandActionStep
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step choice₁ choice₂) :
    LocalTensorDirectSummandActionStep choice₁ choice₂ :=
  { column_eq := hstep.column_eq,
    row_eq := hstep.row_eq,
    coric_eq := hstep.coric_eq,
    procession_eq := hstep.procession_eq,
    upper_semi_eq := hstep.upper_semi_eq,
    local_object_eq := hstep.local_object_eq,
    summand_action_exists := by
      rcases hstep.ism_action_exists with ⟨action, htarget⟩
      exact ⟨action.toDirectSummandAction, htarget⟩ }

def archimedeanOrderTwo_toDirectSummandActionStep
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step choice₁ choice₂) :
    LocalTensorDirectSummandActionStep choice₁ choice₂ :=
  { column_eq := hstep.column_eq,
    row_eq := hstep.row_eq,
    coric_eq := hstep.coric_eq,
    procession_eq := hstep.procession_eq,
    upper_semi_eq := hstep.upper_semi_eq,
    local_object_eq := hstep.local_object_eq,
    summand_action_exists := by
      rcases hstep.order_two_action_exists with ⟨action, htarget⟩
      exact ⟨action.toDirectSummandAction, htarget⟩ }

theorem nonarchimedeanIsm_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  ind2_preserves_capsuleTotalLogVolume
    (nonarchimedeanIsm_toDirectSummandActionStep hstep)

theorem archimedeanOrderTwo_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  ind2_preserves_capsuleTotalLogVolume
    (archimedeanOrderTwo_toDirectSummandActionStep hstep)

theorem nonarchimedeanIsm_transports_capsuleContainerBound
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step choice₁ choice₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned choice₁.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      choice₂.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ind2_transports_capsuleContainerBound
    (nonarchimedeanIsm_toDirectSummandActionStep hstep) estimate

theorem archimedeanOrderTwo_transports_capsuleContainerBound
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step choice₁ choice₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned choice₁.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      choice₂.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ind2_transports_capsuleContainerBound
    (archimedeanOrderTwo_toDirectSummandActionStep hstep) estimate

/-- Refined `(Ind1)` step for direct-summand packet choices. -/
structure ProcessionAutomorphismStep
    (choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind) :
    Prop where
  column_eq : choice₁.column = choice₂.column
  row_eq : choice₁.row = choice₂.row
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq :
    choice₁.procession_state.procession =
      choice₂.procession_state.procession
  procession_column_eq :
    choice₁.procession_state.column = choice₂.procession_state.column
  local_tensor_eq : choice₁.local_tensor_state = choice₂.local_tensor_state
  upper_semi_eq : choice₁.upper_semi_state = choice₂.upper_semi_state

/-- Refined `(Ind3)` step for direct-summand packet choices. -/
structure UpperSemiCompatibilityStep
    (choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind) :
    Prop where
  column_eq : choice₁.column = choice₂.column
  coric_eq : choice₁.coric = choice₂.coric
  procession_eq : choice₁.procession_state = choice₂.procession_state
  local_tensor_eq : choice₁.local_tensor_state = choice₂.local_tensor_state
  logThetaColumn_eq :
    choice₁.upper_semi_state.logThetaColumn =
      choice₂.upper_semi_state.logThetaColumn
  nonarchimedean_inclusions_eq :
    choice₁.upper_semi_state.nonarchimedeanInclusions =
      choice₂.upper_semi_state.nonarchimedeanInclusions
  archimedean_surjections_eq :
    choice₁.upper_semi_state.archimedeanSurjections =
      choice₂.upper_semi_state.archimedeanSurjections
  log_volume_compatibility_eq :
    choice₁.upper_semi_state.logVolumeCompatibility =
      choice₂.upper_semi_state.logVolumeCompatibility
  has_nonarchimedean_inclusions_eq :
    choice₁.upper_semi_state.hasNonarchimedeanInclusions =
      choice₂.upper_semi_state.hasNonarchimedeanInclusions
  has_archimedean_surjections_eq :
    choice₁.upper_semi_state.hasArchimedeanSurjections =
      choice₂.upper_semi_state.hasArchimedeanSurjections

def indeterminacySourceData :
    IUTStage1Theorem311IndeterminacySourceData
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind) :=
  { procession_automorphism_step := ProcessionAutomorphismStep,
    local_tensor_symmetry_step := LocalTensorDirectSummandActionStep,
    upper_semi_compatibility_step := UpperSemiCompatibilityStep }

theorem ind1_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : ProcessionAutomorphismStep choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  congrArg
    (fun state =>
      state.packetState.capsuleFamily.totalLogVolume)
    hstep.local_tensor_eq

theorem ind3_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep : UpperSemiCompatibilityStep choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  congrArg
    (fun state =>
      state.packetState.capsuleFamily.totalLogVolume)
    hstep.local_tensor_eq

def nonarchimedeanIsmIndeterminacySourceData :
    IUTStage1Theorem311IndeterminacySourceData
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean) :=
  { procession_automorphism_step := ProcessionAutomorphismStep,
    local_tensor_symmetry_step := NonarchimedeanIsmInd2Step,
    upper_semi_compatibility_step := UpperSemiCompatibilityStep }

def archimedeanOrderTwoIndeterminacySourceData :
    IUTStage1Theorem311IndeterminacySourceData
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean) :=
  { procession_automorphism_step := ProcessionAutomorphismStep,
    local_tensor_symmetry_step := ArchimedeanOrderTwoInd2Step,
    upper_semi_compatibility_step := UpperSemiCompatibilityStep }

theorem nonarchimedeanIsm_generated_preserves_coric
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (nonarchimedeanIsmIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.coric_eq
  | ind2 hstep =>
      exact hstep.coric_eq
  | ind3 hstep =>
      exact hstep.coric_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem archimedeanOrderTwo_generated_preserves_coric
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (archimedeanOrderTwoIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.coric_eq
  | ind2 hstep =>
      exact hstep.coric_eq
  | ind3 hstep =>
      exact hstep.coric_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem nonarchimedeanIsm_generated_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (nonarchimedeanIsmIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact ind1_preserves_capsuleTotalLogVolume hstep
  | ind2 hstep =>
      exact nonarchimedeanIsm_preserves_capsuleTotalLogVolume hstep
  | ind3 hstep =>
      exact ind3_preserves_capsuleTotalLogVolume hstep
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem archimedeanOrderTwo_generated_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (archimedeanOrderTwoIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact ind1_preserves_capsuleTotalLogVolume hstep
  | ind2 hstep =>
      exact archimedeanOrderTwo_preserves_capsuleTotalLogVolume hstep
  | ind3 hstep =>
      exact ind3_preserves_capsuleTotalLogVolume hstep
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem generated_preserves_coric
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.coric_eq
  | ind2 hstep =>
      exact hstep.coric_eq
  | ind3 hstep =>
      exact hstep.coric_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem generated_preserves_column
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        choice₁ choice₂) :
    choice₁.column = choice₂.column := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact hstep.column_eq
  | ind2 hstep =>
      exact hstep.column_eq
  | ind3 hstep =>
      exact hstep.column_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem generated_preserves_capsuleTotalLogVolume
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume := by
  induction hrel with
  | refl choice =>
      rfl
  | ind1 hstep =>
      exact ind1_preserves_capsuleTotalLogVolume hstep
  | ind2 hstep =>
      exact ind2_preserves_capsuleTotalLogVolume hstep
  | ind3 hstep =>
      exact ind3_preserves_capsuleTotalLogVolume hstep
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂) :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind},
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        choice₁ choice₂ ->
        images.region choice₁ = images.region choice₂ := by
  intro choice₁ choice₂ hrel
  exact hcoric choice₁ choice₂ (generated_preserves_coric hrel)

end IUTStage1DirectSummandPacketTheorem311Choice

/--
Multiradial possible images indexed by refined direct-summand packet
Theorem 3.11 choices.
-/
structure IUTStage1DirectSummandPacketMultiradialImages
    {target : Copy}
    (coric : Type u) (kind : IUTStage1PlaceKind) where
  possibleImages :
    RegionFamily target
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind)
  quotient :
    IUTStage1IndeterminacyQuotient
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind)
  quotient_eq_generated :
    quotient =
      (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
        (coric := coric) (kind := kind)).quotient
  image_invariant :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind},
      quotient.relation choice₁ choice₂ ->
        possibleImages.region choice₁ = possibleImages.region choice₂

namespace IUTStage1DirectSummandPacketMultiradialImages

variable {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}

def ofCoricInvariant
    (images :
      RegionFamily target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂) :
    IUTStage1DirectSummandPacketMultiradialImages
      (target := target) coric kind :=
  { possibleImages := images,
    quotient :=
      (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
        (coric := coric) (kind := kind)).quotient,
    quotient_eq_generated := rfl,
    image_invariant := by
      intro choice₁ choice₂ hrel
      exact
        IUTStage1DirectSummandPacketTheorem311Choice.image_invariant_of_coric
          images hcoric hrel }

theorem region_eq_of_related
    (data :
      IUTStage1DirectSummandPacketMultiradialImages
        (target := target) coric kind)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel : data.quotient.relation choice₁ choice₂) :
    data.possibleImages.region choice₁ = data.possibleImages.region choice₂ :=
  data.image_invariant hrel

theorem quotient_profile
    (data :
      IUTStage1DirectSummandPacketMultiradialImages
        (target := target) coric kind) :
    data.quotient.profile = theorem311IndeterminacyProfile := by
  rw [data.quotient_eq_generated]
  exact
    IUTStage1Theorem311IndeterminacySourceData.quotient_profile
      (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
        (coric := coric) (kind := kind))

end IUTStage1DirectSummandPacketMultiradialImages

/--
Source-package version of refined direct-summand packet multiradial theta
images.
-/
structure IUTStage1RefinedDirectSummandPacketMultiradialThetaImages
    {source target : Copy} {coric : Type u}
    {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)) where
  multiradialOutput : MultiradialOutputId
  possibleImages : IUTStage1ThetaPilotPossibleImages package
  refinedImages :
    IUTStage1DirectSummandPacketMultiradialImages
      (target := target) coric kind
  multiradial_output_eq : multiradialOutput = package.multiradialOutput
  refined_possibleImages_eq :
    refinedImages.possibleImages = possibleImages.images

namespace IUTStage1RefinedDirectSummandPacketMultiradialThetaImages

variable {source target : Copy} {coric : Type u}
variable {kind : IUTStage1PlaceKind}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}

def ofPackageWithCoricInvariant
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  { multiradialOutput := package.multiradialOutput,
    possibleImages := IUTStage1ThetaPilotPossibleImages.ofPackage package,
    refinedImages :=
      IUTStage1DirectSummandPacketMultiradialImages.ofCoricInvariant
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images
        hcoric,
    multiradial_output_eq := rfl,
    refined_possibleImages_eq := rfl }

theorem region_eq_of_related
    (data :
      IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel : data.refinedImages.quotient.relation choice₁ choice₂) :
    data.possibleImages.images.region choice₁ =
      data.possibleImages.images.region choice₂ := by
  rw [← data.refined_possibleImages_eq]
  exact data.refinedImages.region_eq_of_related hrel

theorem quotient_profile
    (data :
      IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package) :
    data.refinedImages.quotient.profile = theorem311IndeterminacyProfile :=
  data.refinedImages.quotient_profile

theorem union_eq_targetUnion
    (data :
      IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package) :
    data.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  data.possibleImages.union_eq_targetUnion

end IUTStage1RefinedDirectSummandPacketMultiradialThetaImages

/--
Refined direct-summand packet choice together with a place-family compatibility
audit linking its upper-semi state to `(Ind2)` action-family data.
-/
structure IUTStage1PlaceAuditedDirectSummandPacketChoice
    (coric : Type u) (kind : IUTStage1PlaceKind) where
  choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind
  placeFamilyCompatibility :
    IUTStage1Ind2UpperSemiPlaceFamilyCompatibility
  upper_semi_state_eq :
    placeFamilyCompatibility.upperSemiState = choice.upper_semi_state

namespace IUTStage1PlaceAuditedDirectSummandPacketChoice

variable {coric : Type u} {kind : IUTStage1PlaceKind}

def toDirectSummandPacketTheorem311Choice
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1DirectSummandPacketTheorem311Choice coric kind :=
  audited.choice

theorem upperSemiState_eq
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.placeFamilyCompatibility.upperSemiState =
      audited.choice.upper_semi_state :=
  audited.upper_semi_state_eq

theorem upperSemi_logVolumeCompatible
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.choice.upper_semi_state.logVolumeCompatible := by
  rw [← audited.upperSemiState_eq]
  exact audited.placeFamilyCompatibility.logVolumeCompatible

theorem upperSemi_logVolumeUpperBound
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume <=
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume := by
  rw [← audited.upperSemiState_eq]
  exact audited.placeFamilyCompatibility.logVolumeUpperBound

theorem nonarchimedeanPlaces_eq
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.placeFamilyCompatibility.ind2Actions.nonarchimedeanPlaces =
      audited.choice.upper_semi_state.nonarchimedeanInclusions.map fun entry =>
        entry.place := by
  rw [← audited.upperSemiState_eq]
  exact audited.placeFamilyCompatibility.nonarchimedeanPlaces_eq

theorem archimedeanPlaces_eq
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.placeFamilyCompatibility.ind2Actions.archimedeanPlaces =
      audited.choice.upper_semi_state.archimedeanSurjections.map fun entry =>
        entry.place := by
  rw [← audited.upperSemiState_eq]
  exact audited.placeFamilyCompatibility.archimedeanPlaces_eq

/--
Audit that the direct-summand count of a place-audited Theorem 3.11 choice
matches the number of `(Ind2)` action entries of the corresponding place kind.
-/
structure DirectSummandPlaceCountAudit
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) where
  direct_summand_count_eq_actionCount :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      audited.placeFamilyCompatibility.ind2Actions.actionCountForKind kind

namespace DirectSummandPlaceCountAudit

variable
  {audited :
    IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}

theorem capsuleCount_eq_actionCount
    (audit : DirectSummandPlaceCountAudit audited) :
    audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount =
      audited.placeFamilyCompatibility.ind2Actions.actionCountForKind kind := by
  rw [← audited.choice.local_tensor_state.packetState.direct_summand_count_eq_capsuleCount]
  exact audit.direct_summand_count_eq_actionCount

theorem nonarchimedean_directSummandCount_eq
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (audit : DirectSummandPlaceCountAudit audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      audited.placeFamilyCompatibility.ind2Actions.nonarchimedeanActions.length := by
  rw [audit.direct_summand_count_eq_actionCount]
  exact
    audited.placeFamilyCompatibility.ind2Actions.actionCountForKind_nonarchimedean

theorem archimedean_directSummandCount_eq
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (audit : DirectSummandPlaceCountAudit audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      audited.placeFamilyCompatibility.ind2Actions.archimedeanActions.length := by
  rw [audit.direct_summand_count_eq_actionCount]
  exact
    audited.placeFamilyCompatibility.ind2Actions.actionCountForKind_archimedean

theorem nonarchimedean_directSummandCount_eq_fiberCardinality
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (countAudit : DirectSummandPlaceCountAudit audited)
    (fiberAudit :
      IUTStage1NonarchimedeanInd2PlaceFiberAudit
        audited.placeFamilyCompatibility.ind2Actions) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      fiberAudit.fiber.cardinality :=
  (countAudit.nonarchimedean_directSummandCount_eq).trans
    fiberAudit.actionCount_eq_fiberCardinality

theorem archimedean_directSummandCount_eq_fiberCardinality
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (countAudit : DirectSummandPlaceCountAudit audited)
    (fiberAudit :
      IUTStage1ArchimedeanInd2PlaceFiberAudit
        audited.placeFamilyCompatibility.ind2Actions) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      fiberAudit.fiber.cardinality :=
  (countAudit.archimedean_directSummandCount_eq).trans
    fiberAudit.actionCount_eq_fiberCardinality

end DirectSummandPlaceCountAudit

/--
Source-facing nonarchimedean `(Ind2)` fiber package for an audited choice.
-/
structure NonarchimedeanInd2FiberPackage
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean) where
  countAudit : DirectSummandPlaceCountAudit audited
  fiberAudit :
    IUTStage1NonarchimedeanInd2PlaceFiberAudit
      audited.placeFamilyCompatibility.ind2Actions

/--
Source-facing archimedean `(Ind2)` fiber package for an audited choice.
-/
structure ArchimedeanInd2FiberPackage
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean) where
  countAudit : DirectSummandPlaceCountAudit audited
  fiberAudit :
    IUTStage1ArchimedeanInd2PlaceFiberAudit
      audited.placeFamilyCompatibility.ind2Actions

namespace NonarchimedeanInd2FiberPackage

variable
  {audited :
    IUTStage1PlaceAuditedDirectSummandPacketChoice
      coric IUTStage1PlaceKind.nonarchimedean}

theorem directSummandCount_eq_fiberCardinality
    (package : NonarchimedeanInd2FiberPackage audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      package.fiberAudit.fiber.cardinality :=
  package.countAudit.nonarchimedean_directSummandCount_eq_fiberCardinality
    package.fiberAudit

theorem capsuleCount_eq_fiberCardinality
    (package : NonarchimedeanInd2FiberPackage audited) :
    audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount =
      package.fiberAudit.fiber.cardinality := by
  rw [← audited.choice.local_tensor_state.packetState.direct_summand_count_eq_capsuleCount]
  exact package.directSummandCount_eq_fiberCardinality

end NonarchimedeanInd2FiberPackage

namespace ArchimedeanInd2FiberPackage

variable
  {audited :
    IUTStage1PlaceAuditedDirectSummandPacketChoice
      coric IUTStage1PlaceKind.archimedean}

theorem directSummandCount_eq_fiberCardinality
    (package : ArchimedeanInd2FiberPackage audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      package.fiberAudit.fiber.cardinality :=
  package.countAudit.archimedean_directSummandCount_eq_fiberCardinality
    package.fiberAudit

theorem capsuleCount_eq_fiberCardinality
    (package : ArchimedeanInd2FiberPackage audited) :
    audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount =
      package.fiberAudit.fiber.cardinality := by
  rw [← audited.choice.local_tensor_state.packetState.direct_summand_count_eq_capsuleCount]
  exact package.directSummandCount_eq_fiberCardinality

end ArchimedeanInd2FiberPackage

/-- Audited `(Ind1)` step preserving the place-family compatibility audit. -/
structure ProcessionAutomorphismStep
    (audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    Prop where
  choice_step :
    IUTStage1DirectSummandPacketTheorem311Choice.ProcessionAutomorphismStep
      audited₁.choice audited₂.choice
  place_family_compatibility_eq :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility

/-- Audited `(Ind2)` step preserving the place-family compatibility audit. -/
structure LocalTensorDirectSummandActionStep
    (audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    Prop where
  choice_step :
    IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
      audited₁.choice audited₂.choice
  place_family_compatibility_eq :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility

/-- Audited `(Ind3)` step preserving the place-family compatibility audit. -/
structure UpperSemiCompatibilityStep
    (audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    Prop where
  choice_step :
    IUTStage1DirectSummandPacketTheorem311Choice.UpperSemiCompatibilityStep
      audited₁.choice audited₂.choice
  place_family_compatibility_eq :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility

theorem ind1_preserves_placeFamilyCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : ProcessionAutomorphismStep audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  hstep.place_family_compatibility_eq

theorem ind2_preserves_placeFamilyCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : LocalTensorDirectSummandActionStep audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  hstep.place_family_compatibility_eq

theorem ind3_preserves_placeFamilyCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : UpperSemiCompatibilityStep audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  hstep.place_family_compatibility_eq

theorem ind2_preserves_capsuleTotalLogVolume
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : LocalTensorDirectSummandActionStep audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_preserves_capsuleTotalLogVolume
    hstep.choice_step

theorem ind1_preserves_capsuleNormalizedLogVolume
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : ProcessionAutomorphismStep audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  rw [hstep.choice_step.local_tensor_eq]

theorem ind2_preserves_capsuleNormalizedLogVolume
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : LocalTensorDirectSummandActionStep audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_preserves_capsuleNormalizedLogVolume
    hstep.choice_step

def ind2_transports_packetNormalizedCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : LocalTensorDirectSummandActionStep audited₁ audited₂)
    (compat :
      IUTStage1LocalTensorPacketNormalizedCompatibility
        audited₁.choice.local_tensor_state.packetState) :
    IUTStage1LocalTensorPacketNormalizedCompatibility
      audited₂.choice.local_tensor_state.packetState :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_transports_packetNormalizedCompatibility
    hstep.choice_step compat

def ind2_transports_classifiedPacketNormalizedCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : LocalTensorDirectSummandActionStep audited₁ audited₂)
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        audited₁.choice.local_tensor_state.packetState) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      audited₂.choice.local_tensor_state.packetState :=
  IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility.ofInd2TransportedPacketNormalization
    (ind2_transports_packetNormalizedCompatibility hstep
      classified.compatibility)

theorem ind2_transports_capsuleContainerBound
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : LocalTensorDirectSummandActionStep audited₁ audited₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_transports_capsuleContainerBound
    hstep.choice_step estimate

/--
Audited nonarchimedean `Ism` instance of the direct-summand `(Ind2)` step.
-/
structure NonarchimedeanIsmInd2Step
    (audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean) :
    Prop where
  choice_step :
    IUTStage1DirectSummandPacketTheorem311Choice.NonarchimedeanIsmInd2Step
      audited₁.choice audited₂.choice
  place_family_compatibility_eq :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility

/--
Audited archimedean order-two instance of the direct-summand `(Ind2)` step.
-/
structure ArchimedeanOrderTwoInd2Step
    (audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean) :
    Prop where
  choice_step :
    IUTStage1DirectSummandPacketTheorem311Choice.ArchimedeanOrderTwoInd2Step
      audited₁.choice audited₂.choice
  place_family_compatibility_eq :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility

def nonarchimedeanIsm_toDirectSummandActionStep
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step audited₁ audited₂) :
    LocalTensorDirectSummandActionStep audited₁ audited₂ :=
  { choice_step := by
      exact
        IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsm_toDirectSummandActionStep
          hstep.choice_step,
    place_family_compatibility_eq :=
      hstep.place_family_compatibility_eq }

def archimedeanOrderTwo_toDirectSummandActionStep
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step audited₁ audited₂) :
    LocalTensorDirectSummandActionStep audited₁ audited₂ :=
  { choice_step := by
      exact
        IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwo_toDirectSummandActionStep
          hstep.choice_step,
    place_family_compatibility_eq :=
      hstep.place_family_compatibility_eq }

theorem nonarchimedeanIsm_preserves_placeFamilyCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  hstep.place_family_compatibility_eq

theorem archimedeanOrderTwo_preserves_placeFamilyCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  hstep.place_family_compatibility_eq

theorem nonarchimedeanIsm_preserves_capsuleTotalLogVolume
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  ind2_preserves_capsuleTotalLogVolume
    (nonarchimedeanIsm_toDirectSummandActionStep hstep)

theorem archimedeanOrderTwo_preserves_capsuleTotalLogVolume
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  ind2_preserves_capsuleTotalLogVolume
    (archimedeanOrderTwo_toDirectSummandActionStep hstep)

theorem nonarchimedeanIsm_transports_capsuleContainerBound
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step audited₁ audited₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ind2_transports_capsuleContainerBound
    (nonarchimedeanIsm_toDirectSummandActionStep hstep) estimate

theorem archimedeanOrderTwo_transports_capsuleContainerBound
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step audited₁ audited₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ind2_transports_capsuleContainerBound
    (archimedeanOrderTwo_toDirectSummandActionStep hstep) estimate

/--
Audited nonarchimedean `Ism` step tied to an entry in the `(Ind2)`
place-family action data.
-/
structure NonarchimedeanIsmActionEntryStep
    (audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean) where
  action_entry : IUTStage1NonarchimedeanIsmActionEntry
  action_entry_mem :
    action_entry ∈
      audited₁.placeFamilyCompatibility.ind2Actions.nonarchimedeanActions
  source_step : NonarchimedeanIsmInd2Step audited₁ audited₂
  matching_action_exists :
    ∃ action :
      IUTStage1NonarchimedeanIsmDirectSummandAction
        audited₁.choice.local_tensor_state.summandFamily,
      action.place = action_entry.place ∧
        action.toDirectSummandAction.toCapsuleAction.transformedFamily =
          action_entry.toDirectSummandAction.toCapsuleAction.transformedFamily ∧
        audited₂.choice.local_tensor_state.packetState.capsuleFamily =
          action.toDirectSummandAction.toCapsuleAction.transformedFamily

/--
Audited archimedean order-two step tied to an entry in the `(Ind2)`
place-family action data.
-/
structure ArchimedeanOrderTwoActionEntryStep
    (audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean) where
  action_entry : IUTStage1ArchimedeanOrderTwoActionEntry
  action_entry_mem :
    action_entry ∈
      audited₁.placeFamilyCompatibility.ind2Actions.archimedeanActions
  source_step : ArchimedeanOrderTwoInd2Step audited₁ audited₂
  matching_action_exists :
    ∃ action :
      IUTStage1ArchimedeanOrderTwoDirectSummandAction
        audited₁.choice.local_tensor_state.summandFamily,
      action.place = action_entry.place ∧
        action.toDirectSummandAction.toCapsuleAction.transformedFamily =
          action_entry.toDirectSummandAction.toCapsuleAction.transformedFamily ∧
        audited₂.choice.local_tensor_state.packetState.capsuleFamily =
          action.toDirectSummandAction.toCapsuleAction.transformedFamily

def nonarchimedeanEntry_toNonarchimedeanIsmStep
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmActionEntryStep audited₁ audited₂) :
    NonarchimedeanIsmInd2Step audited₁ audited₂ :=
  hstep.source_step

def archimedeanEntry_toArchimedeanOrderTwoStep
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoActionEntryStep audited₁ audited₂) :
    ArchimedeanOrderTwoInd2Step audited₁ audited₂ :=
  hstep.source_step

def nonarchimedeanEntry_toDirectSummandActionStep
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmActionEntryStep audited₁ audited₂) :
    LocalTensorDirectSummandActionStep audited₁ audited₂ :=
  nonarchimedeanIsm_toDirectSummandActionStep
    (nonarchimedeanEntry_toNonarchimedeanIsmStep hstep)

def archimedeanEntry_toDirectSummandActionStep
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoActionEntryStep audited₁ audited₂) :
    LocalTensorDirectSummandActionStep audited₁ audited₂ :=
  archimedeanOrderTwo_toDirectSummandActionStep
    (archimedeanEntry_toArchimedeanOrderTwoStep hstep)

theorem nonarchimedeanEntry_place_mem_ind2Actions
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmActionEntryStep audited₁ audited₂) :
    hstep.action_entry.place ∈
      audited₁.placeFamilyCompatibility.ind2Actions.nonarchimedeanPlaces := by
  exact List.mem_map.mpr ⟨hstep.action_entry, hstep.action_entry_mem, rfl⟩

theorem archimedeanEntry_place_mem_ind2Actions
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoActionEntryStep audited₁ audited₂) :
    hstep.action_entry.place ∈
      audited₁.placeFamilyCompatibility.ind2Actions.archimedeanPlaces := by
  exact List.mem_map.mpr ⟨hstep.action_entry, hstep.action_entry_mem, rfl⟩

theorem nonarchimedeanEntry_place_mem_upperSemi
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmActionEntryStep audited₁ audited₂) :
    hstep.action_entry.place ∈
      audited₁.choice.upper_semi_state.nonarchimedeanInclusions.map
        fun entry => entry.place := by
  rw [← audited₁.nonarchimedeanPlaces_eq]
  exact nonarchimedeanEntry_place_mem_ind2Actions hstep

theorem archimedeanEntry_place_mem_upperSemi
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoActionEntryStep audited₁ audited₂) :
    hstep.action_entry.place ∈
      audited₁.choice.upper_semi_state.archimedeanSurjections.map
        fun entry => entry.place := by
  rw [← audited₁.archimedeanPlaces_eq]
  exact archimedeanEntry_place_mem_ind2Actions hstep

theorem nonarchimedeanEntry_place_mem_fiber
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmActionEntryStep audited₁ audited₂)
    (fiberAudit :
      IUTStage1NonarchimedeanInd2PlaceFiberAudit
        audited₁.placeFamilyCompatibility.ind2Actions) :
    hstep.action_entry.place ∈ fiberAudit.fiber.places := by
  rw [← fiberAudit.places_eq]
  exact nonarchimedeanEntry_place_mem_ind2Actions hstep

theorem archimedeanEntry_place_mem_fiber
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoActionEntryStep audited₁ audited₂)
    (fiberAudit :
      IUTStage1ArchimedeanInd2PlaceFiberAudit
        audited₁.placeFamilyCompatibility.ind2Actions) :
    hstep.action_entry.place ∈ fiberAudit.fiber.places := by
  rw [← fiberAudit.places_eq]
  exact archimedeanEntry_place_mem_ind2Actions hstep

namespace NonarchimedeanInd2FiberPackage

theorem entry_place_mem_fiber
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (package : NonarchimedeanInd2FiberPackage audited₁)
    (hstep : NonarchimedeanIsmActionEntryStep audited₁ audited₂) :
    hstep.action_entry.place ∈ package.fiberAudit.fiber.places :=
  nonarchimedeanEntry_place_mem_fiber hstep package.fiberAudit

end NonarchimedeanInd2FiberPackage

namespace ArchimedeanInd2FiberPackage

theorem entry_place_mem_fiber
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (package : ArchimedeanInd2FiberPackage audited₁)
    (hstep : ArchimedeanOrderTwoActionEntryStep audited₁ audited₂) :
    hstep.action_entry.place ∈ package.fiberAudit.fiber.places :=
  archimedeanEntry_place_mem_fiber hstep package.fiberAudit

end ArchimedeanInd2FiberPackage

theorem nonarchimedeanEntry_preserves_capsuleTotalLogVolume
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmActionEntryStep audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  ind2_preserves_capsuleTotalLogVolume
    (nonarchimedeanEntry_toDirectSummandActionStep hstep)

theorem archimedeanEntry_preserves_capsuleTotalLogVolume
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoActionEntryStep audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  ind2_preserves_capsuleTotalLogVolume
    (archimedeanEntry_toDirectSummandActionStep hstep)

def indeterminacySourceData :
    IUTStage1Theorem311IndeterminacySourceData
      (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :=
  { procession_automorphism_step := ProcessionAutomorphismStep,
    local_tensor_symmetry_step := LocalTensorDirectSummandActionStep,
    upper_semi_compatibility_step := UpperSemiCompatibilityStep }

theorem generated_preserves_placeFamilyCompatibility
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility := by
  induction hrel with
  | refl audited =>
      rfl
  | ind1 hstep =>
      exact ind1_preserves_placeFamilyCompatibility hstep
  | ind2 hstep =>
      exact ind2_preserves_placeFamilyCompatibility hstep
  | ind3 hstep =>
      exact ind3_preserves_placeFamilyCompatibility hstep
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem generated_preserves_coric
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        audited₁ audited₂) :
    audited₁.choice.coric = audited₂.choice.coric := by
  induction hrel with
  | refl audited =>
      rfl
  | ind1 hstep =>
      exact hstep.choice_step.coric_eq
  | ind2 hstep =>
      exact hstep.choice_step.coric_eq
  | ind3 hstep =>
      exact hstep.choice_step.coric_eq
  | symm _ ih =>
      exact ih.symm
  | trans _ _ ih₁₂ ih₂₃ =>
      exact ih₁₂.trans ih₂₃

theorem generated_preserves_upperSemiLogVolumeCompatible
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (_hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        audited₁ audited₂) :
    audited₂.choice.upper_semi_state.logVolumeCompatible :=
  audited₂.upperSemi_logVolumeCompatible

theorem image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂) :
    ∀ {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind},
      IUTStage1GeneratedIndeterminacyRelation
        (indeterminacySourceData (coric := coric) (kind := kind)).generators
        audited₁ audited₂ ->
        images.region audited₁ = images.region audited₂ := by
  intro audited₁ audited₂ hrel
  exact hcoric audited₁ audited₂ (generated_preserves_coric hrel)

theorem ind1_image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : ProcessionAutomorphismStep audited₁ audited₂) :
    images.region audited₁ = images.region audited₂ :=
  hcoric audited₁ audited₂ hstep.choice_step.coric_eq

theorem ind2_image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : LocalTensorDirectSummandActionStep audited₁ audited₂) :
    images.region audited₁ = images.region audited₂ :=
  hcoric audited₁ audited₂ hstep.choice_step.coric_eq

theorem nonarchimedeanIsm_image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep : NonarchimedeanIsmInd2Step audited₁ audited₂) :
    images.region audited₁ = images.region audited₂ :=
  ind2_image_invariant_of_coric images hcoric
    (nonarchimedeanIsm_toDirectSummandActionStep hstep)

theorem archimedeanOrderTwo_image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep : ArchimedeanOrderTwoInd2Step audited₁ audited₂) :
    images.region audited₁ = images.region audited₂ :=
  ind2_image_invariant_of_coric images hcoric
    (archimedeanOrderTwo_toDirectSummandActionStep hstep)

theorem ind3_image_invariant_of_coric
    {target : Copy}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep : UpperSemiCompatibilityStep audited₁ audited₂) :
    images.region audited₁ = images.region audited₂ :=
  hcoric audited₁ audited₂ hstep.choice_step.coric_eq

end IUTStage1PlaceAuditedDirectSummandPacketChoice

/--
Multiradial possible images indexed by place-audited refined Theorem 3.11
choices.
-/
structure IUTStage1PlaceAuditedMultiradialImages
    {target : Copy}
    (coric : Type u) (kind : IUTStage1PlaceKind) where
  possibleImages :
    RegionFamily target
      (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
  quotient :
    IUTStage1IndeterminacyQuotient
      (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
  quotient_eq_generated :
    quotient =
      (IUTStage1PlaceAuditedDirectSummandPacketChoice.indeterminacySourceData
        (coric := coric) (kind := kind)).quotient
  image_invariant :
    ∀ {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind},
      quotient.relation audited₁ audited₂ ->
        possibleImages.region audited₁ = possibleImages.region audited₂

namespace IUTStage1PlaceAuditedMultiradialImages

variable {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}

def ofCoricInvariant
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂) :
    IUTStage1PlaceAuditedMultiradialImages
      (target := target) coric kind :=
  { possibleImages := images,
    quotient :=
      (IUTStage1PlaceAuditedDirectSummandPacketChoice.indeterminacySourceData
        (coric := coric) (kind := kind)).quotient,
    quotient_eq_generated := rfl,
    image_invariant := by
      intro audited₁ audited₂ hrel
      exact
        IUTStage1PlaceAuditedDirectSummandPacketChoice.image_invariant_of_coric
          images hcoric hrel }

theorem region_eq_of_related
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel : data.quotient.relation audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.image_invariant hrel

theorem region_eq_of_ind1_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.region_eq_of_related (by
    rw [data.quotient_eq_generated]
    exact IUTStage1GeneratedIndeterminacyRelation.ind1 hstep)

theorem region_eq_of_ind2_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.region_eq_of_related (by
    rw [data.quotient_eq_generated]
    exact IUTStage1GeneratedIndeterminacyRelation.ind2 hstep)

theorem region_eq_of_nonarchimedeanIsm_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.nonarchimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.region_eq_of_ind2_step
    (IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanIsm_toDirectSummandActionStep
      hstep)

theorem region_eq_of_nonarchimedeanEntry_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.nonarchimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.region_eq_of_nonarchimedeanIsm_step
    (IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanEntry_toNonarchimedeanIsmStep
      hstep)

theorem region_eq_and_fiber_mem_of_nonarchimedeanEntry_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.nonarchimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  ⟨data.region_eq_of_nonarchimedeanEntry_step hstep,
    fiberPackage.entry_place_mem_fiber hstep⟩

theorem region_eq_of_archimedeanOrderTwo_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.archimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.region_eq_of_ind2_step
    (IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanOrderTwo_toDirectSummandActionStep
      hstep)

theorem region_eq_of_archimedeanEntry_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.archimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.region_eq_of_archimedeanOrderTwo_step
    (IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanEntry_toArchimedeanOrderTwoStep
      hstep)

theorem region_eq_and_fiber_mem_of_archimedeanEntry_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.archimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  ⟨data.region_eq_of_archimedeanEntry_step hstep,
    fiberPackage.entry_place_mem_fiber hstep⟩

theorem region_eq_of_ind3_step
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.UpperSemiCompatibilityStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ :=
  data.region_eq_of_related (by
    rw [data.quotient_eq_generated]
    exact IUTStage1GeneratedIndeterminacyRelation.ind3 hstep)

theorem quotient_profile
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind) :
    data.quotient.profile = theorem311IndeterminacyProfile := by
  rw [data.quotient_eq_generated]
  exact
    IUTStage1Theorem311IndeterminacySourceData.quotient_profile
      (IUTStage1PlaceAuditedDirectSummandPacketChoice.indeterminacySourceData
        (coric := coric) (kind := kind))

end IUTStage1PlaceAuditedMultiradialImages

/--
Source-package version of place-audited refined multiradial theta images.
-/
structure IUTStage1PlaceAuditedMultiradialThetaImages
    {source target : Copy} {coric : Type u}
    {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)) where
  multiradialOutput : MultiradialOutputId
  possibleImages : IUTStage1ThetaPilotPossibleImages package
  auditedImages :
    IUTStage1PlaceAuditedMultiradialImages
      (target := target) coric kind
  multiradial_output_eq : multiradialOutput = package.multiradialOutput
  audited_possibleImages_eq :
    auditedImages.possibleImages = possibleImages.images

namespace IUTStage1PlaceAuditedMultiradialThetaImages

variable {source target : Copy} {coric : Type u}
variable {kind : IUTStage1PlaceKind}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}

def ofPackageWithCoricInvariant
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            audited₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            audited₂) :
    IUTStage1PlaceAuditedMultiradialThetaImages package :=
  { multiradialOutput := package.multiradialOutput,
    possibleImages := IUTStage1ThetaPilotPossibleImages.ofPackage package,
    auditedImages :=
      IUTStage1PlaceAuditedMultiradialImages.ofCoricInvariant
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images
        hcoric,
    multiradial_output_eq := rfl,
    audited_possibleImages_eq := rfl }

theorem region_eq_of_related
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel : data.auditedImages.quotient.relation audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_related hrel

theorem region_eq_of_ind1_step
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_ind1_step hstep

theorem region_eq_of_ind2_step
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_ind2_step hstep

theorem region_eq_of_nonarchimedeanIsm_step
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_nonarchimedeanIsm_step hstep

theorem region_eq_of_nonarchimedeanEntry_step
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_nonarchimedeanEntry_step hstep

theorem region_eq_and_fiber_mem_of_nonarchimedeanEntry_step
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
        data.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  ⟨data.region_eq_of_nonarchimedeanEntry_step hstep,
    fiberPackage.entry_place_mem_fiber hstep⟩

theorem region_eq_of_archimedeanOrderTwo_step
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_archimedeanOrderTwo_step hstep

theorem region_eq_of_archimedeanEntry_step
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_archimedeanEntry_step hstep

theorem region_eq_and_fiber_mem_of_archimedeanEntry_step
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
        data.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  ⟨data.region_eq_of_archimedeanEntry_step hstep,
    fiberPackage.entry_place_mem_fiber hstep⟩

theorem region_eq_of_ind3_step
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.UpperSemiCompatibilityStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ := by
  rw [← data.audited_possibleImages_eq]
  exact data.auditedImages.region_eq_of_ind3_step hstep

theorem quotient_profile
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package) :
    data.auditedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  data.auditedImages.quotient_profile

theorem union_eq_targetUnion
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package) :
    data.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  data.possibleImages.union_eq_targetUnion

end IUTStage1PlaceAuditedMultiradialThetaImages

/--
Refined obligation that source-package Theta-pilot possible images depend only
on the coric coordinate of direct-summand packet choices.

This is the refined Theorem 3.11 multiradiality obligation: it is stated for the
choice type whose `(Ind2)` coordinate carries direct summands, capsules, and
log-volume data.
-/
structure IUTStage1RefinedThetaImagesDependOnlyOnCoric
    {source target : Copy} {coric : Type u}
    {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)) :
    Prop where
  region_eq_of_coric_eq :
    ∀ choice₁ choice₂,
      choice₁.coric = choice₂.coric ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂

namespace IUTStage1RefinedThetaImagesDependOnlyOnCoric

variable {source target : Copy} {coric : Type u}
variable {kind : IUTStage1PlaceKind}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}

def toRefinedMultiradialThetaImages
    (dependence : IUTStage1RefinedThetaImagesDependOnlyOnCoric package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  IUTStage1RefinedDirectSummandPacketMultiradialThetaImages.ofPackageWithCoricInvariant
    package dependence.region_eq_of_coric_eq

theorem imageInvariant
    (dependence : IUTStage1RefinedThetaImagesDependOnlyOnCoric package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      dependence.toRefinedMultiradialThetaImages.refinedImages.quotient.relation
        choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  dependence.toRefinedMultiradialThetaImages.region_eq_of_related hrel

theorem quotientProfile
    (dependence : IUTStage1RefinedThetaImagesDependOnlyOnCoric package) :
    dependence.toRefinedMultiradialThetaImages.refinedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  dependence.toRefinedMultiradialThetaImages.quotient_profile

theorem union_eq_targetUnion
    (dependence : IUTStage1RefinedThetaImagesDependOnlyOnCoric package) :
    dependence.toRefinedMultiradialThetaImages.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  dependence.toRefinedMultiradialThetaImages.union_eq_targetUnion

end IUTStage1RefinedThetaImagesDependOnlyOnCoric

/--
Named source subclaim for the refined Theorem 3.11 multiradial representation.

The field is intentionally just the refined coric-dependence obligation.  It
does not assert the Corollary 3.12 inequality or collapse the refined
indeterminacy relation into equality of all representatives.
-/
structure IUTStage1Theorem311RefinedMultiradialSubclaim
    {source target : Copy} {coric : Type u}
    {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)) :
    Prop where
  theta_images_depend_only_on_coric :
    IUTStage1RefinedThetaImagesDependOnlyOnCoric package

namespace IUTStage1Theorem311RefinedMultiradialSubclaim

variable {source target : Copy} {coric : Type u}
variable {kind : IUTStage1PlaceKind}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}

def toRefinedThetaImagesDependOnlyOnCoric
    (subclaim : IUTStage1Theorem311RefinedMultiradialSubclaim package) :
    IUTStage1RefinedThetaImagesDependOnlyOnCoric package :=
  subclaim.theta_images_depend_only_on_coric

def toRefinedMultiradialThetaImages
    (subclaim : IUTStage1Theorem311RefinedMultiradialSubclaim package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  subclaim.toRefinedThetaImagesDependOnlyOnCoric.toRefinedMultiradialThetaImages

theorem imageInvariant
    (subclaim : IUTStage1Theorem311RefinedMultiradialSubclaim package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel : subclaim.toRefinedMultiradialThetaImages.refinedImages.quotient.relation
      choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  subclaim.toRefinedMultiradialThetaImages.region_eq_of_related hrel

theorem quotientProfile
    (subclaim : IUTStage1Theorem311RefinedMultiradialSubclaim package) :
    subclaim.toRefinedMultiradialThetaImages.refinedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  subclaim.toRefinedMultiradialThetaImages.quotient_profile

theorem union_eq_targetUnion
    (subclaim : IUTStage1Theorem311RefinedMultiradialSubclaim package) :
    subclaim.toRefinedMultiradialThetaImages.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  subclaim.toRefinedMultiradialThetaImages.union_eq_targetUnion

end IUTStage1Theorem311RefinedMultiradialSubclaim

/--
Generator-wise refined multiradial invariance for direct-summand packet
Theorem 3.11 choices.

This decomposes refined image invariance into the three source generators
`(Ind1)`, `(Ind2)`, and `(Ind3)`.
-/
structure IUTStage1RefinedThetaImageGeneratorInvariance
    {source target : Copy} {coric : Type u}
    {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)) :
    Prop where
  ind1_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind},
      IUTStage1DirectSummandPacketTheorem311Choice.ProcessionAutomorphismStep
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂
  ind2_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind},
      IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂
  ind3_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind},
      IUTStage1DirectSummandPacketTheorem311Choice.UpperSemiCompatibilityStep
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂

namespace IUTStage1RefinedThetaImageGeneratorInvariance

variable {source target : Copy} {coric : Type u}
variable {kind : IUTStage1PlaceKind}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}

theorem generatedImageInvariant
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  IUTStage1GeneratedIndeterminacyRelation.image_invariant
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images
    invariance.ind1_region_eq
    invariance.ind2_region_eq
    invariance.ind3_region_eq
    hrel

def toRefinedMultiradialThetaImages
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  { multiradialOutput := package.multiradialOutput,
    possibleImages := IUTStage1ThetaPilotPossibleImages.ofPackage package,
    refinedImages :=
      { possibleImages :=
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images,
        quotient :=
          (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
            (coric := coric) (kind := kind)).quotient,
        quotient_eq_generated := rfl,
        image_invariant := by
          intro choice₁ choice₂ hrel
          exact invariance.generatedImageInvariant hrel },
    multiradial_output_eq := rfl,
    refined_possibleImages_eq := rfl }

theorem imageInvariant
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      invariance.toRefinedMultiradialThetaImages.refinedImages.quotient.relation
        choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  invariance.toRefinedMultiradialThetaImages.region_eq_of_related hrel

theorem quotientProfile
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package) :
    invariance.toRefinedMultiradialThetaImages.refinedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  invariance.toRefinedMultiradialThetaImages.quotient_profile

theorem union_eq_targetUnion
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package) :
    invariance.toRefinedMultiradialThetaImages.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  invariance.toRefinedMultiradialThetaImages.union_eq_targetUnion

end IUTStage1RefinedThetaImageGeneratorInvariance

/--
Named source subclaim that proves refined multiradiality generator by
generator.
-/
structure IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim
    {source target : Copy} {coric : Type u}
    {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)) :
    Prop where
  generator_invariance :
    IUTStage1RefinedThetaImageGeneratorInvariance package

namespace IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim

variable {source target : Copy} {coric : Type u}
variable {kind : IUTStage1PlaceKind}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}

def toRefinedThetaImageGeneratorInvariance
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package) :
    IUTStage1RefinedThetaImageGeneratorInvariance package :=
  subclaim.generator_invariance

def toRefinedMultiradialThetaImages
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  subclaim.toRefinedThetaImageGeneratorInvariance.toRefinedMultiradialThetaImages

theorem imageInvariant
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel : subclaim.toRefinedMultiradialThetaImages.refinedImages.quotient.relation
      choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  subclaim.toRefinedMultiradialThetaImages.region_eq_of_related hrel

theorem quotientProfile
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package) :
    subclaim.toRefinedMultiradialThetaImages.refinedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  subclaim.toRefinedMultiradialThetaImages.quotient_profile

theorem union_eq_targetUnion
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package) :
    subclaim.toRefinedMultiradialThetaImages.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  subclaim.toRefinedMultiradialThetaImages.union_eq_targetUnion

end IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim

/--
Generator-wise image invariance for the nonarchimedean `Ism` refined quotient.
-/
structure IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance
    {source target : Copy} {coric : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.nonarchimedean)) :
    Prop where
  ind1_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean},
      IUTStage1DirectSummandPacketTheorem311Choice.ProcessionAutomorphismStep
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂
  ind2_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean},
      IUTStage1DirectSummandPacketTheorem311Choice.NonarchimedeanIsmInd2Step
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂
  ind3_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean},
      IUTStage1DirectSummandPacketTheorem311Choice.UpperSemiCompatibilityStep
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂

/--
Generator-wise image invariance for the archimedean order-two refined quotient.
-/
structure IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance
    {source target : Copy} {coric : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.archimedean)) :
    Prop where
  ind1_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean},
      IUTStage1DirectSummandPacketTheorem311Choice.ProcessionAutomorphismStep
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂
  ind2_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean},
      IUTStage1DirectSummandPacketTheorem311Choice.ArchimedeanOrderTwoInd2Step
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂
  ind3_region_eq :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean},
      IUTStage1DirectSummandPacketTheorem311Choice.UpperSemiCompatibilityStep
        choice₁ choice₂ ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂

namespace IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance

variable {source target : Copy} {coric : Type u}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean)}

theorem generatedImageInvariant
    (invariance :
      IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsmIndeterminacySourceData
          (coric := coric)).generators choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  IUTStage1GeneratedIndeterminacyRelation.image_invariant
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images
    invariance.ind1_region_eq
    invariance.ind2_region_eq
    invariance.ind3_region_eq
    hrel

end IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance

namespace IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance

variable {source target : Copy} {coric : Type u}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean)}

theorem generatedImageInvariant
    (invariance :
      IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwoIndeterminacySourceData
          (coric := coric)).generators choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  IUTStage1GeneratedIndeterminacyRelation.image_invariant
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images
    invariance.ind1_region_eq
    invariance.ind2_region_eq
    invariance.ind3_region_eq
    hrel

end IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance

/-- Source-level multiradial image package for the nonarchimedean `Ism` quotient. -/
structure IUTStage1NonarchimedeanIsmMultiradialThetaImages
    {source target : Copy} {coric : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.nonarchimedean)) where
  multiradialOutput : MultiradialOutputId
  possibleImages : IUTStage1ThetaPilotPossibleImages package
  quotient :
    IUTStage1IndeterminacyQuotient
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean)
  quotient_eq_generated :
    quotient =
      (IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsmIndeterminacySourceData
        (coric := coric)).quotient
  multiradial_output_eq : multiradialOutput = package.multiradialOutput
  image_invariant :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean},
      quotient.relation choice₁ choice₂ ->
        possibleImages.images.region choice₁ =
          possibleImages.images.region choice₂

/-- Source-level multiradial image package for the archimedean order-two quotient. -/
structure IUTStage1ArchimedeanOrderTwoMultiradialThetaImages
    {source target : Copy} {coric : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.archimedean)) where
  multiradialOutput : MultiradialOutputId
  possibleImages : IUTStage1ThetaPilotPossibleImages package
  quotient :
    IUTStage1IndeterminacyQuotient
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean)
  quotient_eq_generated :
    quotient =
      (IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwoIndeterminacySourceData
        (coric := coric)).quotient
  multiradial_output_eq : multiradialOutput = package.multiradialOutput
  image_invariant :
    ∀ {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean},
      quotient.relation choice₁ choice₂ ->
        possibleImages.images.region choice₁ =
          possibleImages.images.region choice₂

namespace IUTStage1NonarchimedeanIsmMultiradialThetaImages

variable {source target : Copy} {coric : Type u}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean)}

def ofGeneratorInvariance
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.nonarchimedean))
    (invariance :
      IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance package) :
    IUTStage1NonarchimedeanIsmMultiradialThetaImages package :=
  { multiradialOutput := package.multiradialOutput,
    possibleImages := IUTStage1ThetaPilotPossibleImages.ofPackage package,
    quotient :=
      (IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsmIndeterminacySourceData
        (coric := coric)).quotient,
    quotient_eq_generated := rfl,
    multiradial_output_eq := rfl,
    image_invariant := by
      intro choice₁ choice₂ hrel
      exact invariance.generatedImageInvariant hrel }

theorem region_eq_of_related
    (data : IUTStage1NonarchimedeanIsmMultiradialThetaImages package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel : data.quotient.relation choice₁ choice₂) :
    data.possibleImages.images.region choice₁ =
      data.possibleImages.images.region choice₂ :=
  data.image_invariant hrel

theorem quotient_profile
    (data : IUTStage1NonarchimedeanIsmMultiradialThetaImages package) :
    data.quotient.profile = theorem311IndeterminacyProfile := by
  rw [data.quotient_eq_generated]
  exact
    IUTStage1Theorem311IndeterminacySourceData.quotient_profile
      (IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsmIndeterminacySourceData
        (coric := coric))

theorem union_eq_targetUnion
    (data : IUTStage1NonarchimedeanIsmMultiradialThetaImages package) :
    data.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  data.possibleImages.union_eq_targetUnion

end IUTStage1NonarchimedeanIsmMultiradialThetaImages

namespace IUTStage1ArchimedeanOrderTwoMultiradialThetaImages

variable {source target : Copy} {coric : Type u}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean)}

def ofGeneratorInvariance
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.archimedean))
    (invariance :
      IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance package) :
    IUTStage1ArchimedeanOrderTwoMultiradialThetaImages package :=
  { multiradialOutput := package.multiradialOutput,
    possibleImages := IUTStage1ThetaPilotPossibleImages.ofPackage package,
    quotient :=
      (IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwoIndeterminacySourceData
        (coric := coric)).quotient,
    quotient_eq_generated := rfl,
    multiradial_output_eq := rfl,
    image_invariant := by
      intro choice₁ choice₂ hrel
      exact invariance.generatedImageInvariant hrel }

theorem region_eq_of_related
    (data : IUTStage1ArchimedeanOrderTwoMultiradialThetaImages package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel : data.quotient.relation choice₁ choice₂) :
    data.possibleImages.images.region choice₁ =
      data.possibleImages.images.region choice₂ :=
  data.image_invariant hrel

theorem quotient_profile
    (data : IUTStage1ArchimedeanOrderTwoMultiradialThetaImages package) :
    data.quotient.profile = theorem311IndeterminacyProfile := by
  rw [data.quotient_eq_generated]
  exact
    IUTStage1Theorem311IndeterminacySourceData.quotient_profile
      (IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwoIndeterminacySourceData
        (coric := coric))

theorem union_eq_targetUnion
    (data : IUTStage1ArchimedeanOrderTwoMultiradialThetaImages package) :
    data.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  data.possibleImages.union_eq_targetUnion

end IUTStage1ArchimedeanOrderTwoMultiradialThetaImages

/--
Multiradial possible images of the Theta-pilot, recorded together with the
indeterminacy quotient on choices.

The key field is `image_invariant`: related choices give the same target
region. This is the first formal place where "quotient by `(Ind1)`, `(Ind2)`,
`(Ind3)`" becomes a Lean obligation instead of prose.
-/
structure IUTStage1MultiradialThetaImages
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) where
  multiradialOutput : MultiradialOutputId
  possibleImages : IUTStage1ThetaPilotPossibleImages package
  quotient : IUTStage1IndeterminacyQuotient index
  multiradial_output_eq : multiradialOutput = package.multiradialOutput
  image_invariant :
    ∀ {choice₁ choice₂ : index},
      quotient.relation choice₁ choice₂ ->
        possibleImages.images.region choice₁ =
          possibleImages.images.region choice₂

namespace IUTStage1MultiradialThetaImages

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

def ofPackageWithQuotient
    (package : IUTStage1SourcePackage source target index)
    (quotient : IUTStage1IndeterminacyQuotient index)
    (hinvariant :
      ∀ {choice₁ choice₂ : index},
        quotient.relation choice₁ choice₂ ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₂) :
    IUTStage1MultiradialThetaImages package :=
  { multiradialOutput := package.multiradialOutput,
    possibleImages := IUTStage1ThetaPilotPossibleImages.ofPackage package,
    quotient := quotient,
    multiradial_output_eq := rfl,
    image_invariant := hinvariant }

def ofPackageWithGeneratedQuotient
    (package : IUTStage1SourcePackage source target index)
    (steps : IUTStage1IndeterminacyGenerators index)
    (hInd1 :
      ∀ {choice₁ choice₂ : index},
        steps.ind1_step choice₁ choice₂ ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₂)
    (hInd2 :
      ∀ {choice₁ choice₂ : index},
        steps.ind2_step choice₁ choice₂ ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₂)
    (hInd3 :
      ∀ {choice₁ choice₂ : index},
        steps.ind3_step choice₁ choice₂ ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₂) :
    IUTStage1MultiradialThetaImages package :=
  ofPackageWithQuotient package
    (IUTStage1IndeterminacyQuotient.generated steps)
    (IUTStage1GeneratedIndeterminacyRelation.image_invariant
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images
      hInd1 hInd2 hInd3)

def ofPackageWithCoordinateQuotient
    {coric ind1State ind2State ind3State : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
              choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
              choice₂) :
    IUTStage1MultiradialThetaImages package :=
  ofPackageWithGeneratedQuotient package
    (IUTStage1IndeterminacyChoice.coordinateGenerators
      (coric := coric) (ind1State := ind1State)
      (ind2State := ind2State) (ind3State := ind3State))
    (by
      intro choice₁ choice₂ hstep
      exact hcoric choice₁ choice₂ hstep.1)
    (by
      intro choice₁ choice₂ hstep
      exact hcoric choice₁ choice₂ hstep.1)
    (by
      intro choice₁ choice₂ hstep
      exact hcoric choice₁ choice₂ hstep.1)

def ofPackageWithTheorem311Indeterminacies
    (package : IUTStage1SourcePackage source target index)
    (indeterminacyData :
      IUTStage1Theorem311IndeterminacySourceData index)
    (hInd1 :
      ∀ {choice₁ choice₂ : index},
        indeterminacyData.procession_automorphism_step choice₁ choice₂ ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₂)
    (hInd2 :
      ∀ {choice₁ choice₂ : index},
        indeterminacyData.local_tensor_symmetry_step choice₁ choice₂ ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₂)
    (hInd3 :
      ∀ {choice₁ choice₂ : index},
        indeterminacyData.upper_semi_compatibility_step choice₁ choice₂ ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₁ =
            (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region choice₂) :
    IUTStage1MultiradialThetaImages package :=
  ofPackageWithGeneratedQuotient package indeterminacyData.generators
    hInd1 hInd2 hInd3

def union (images : IUTStage1MultiradialThetaImages package) :
    Region target :=
  images.possibleImages.union

theorem union_eq_targetUnion
    (images : IUTStage1MultiradialThetaImages package) :
    images.union = package.preLedger.output.comparisons.targetUnion :=
  images.possibleImages.union_eq_targetUnion

theorem region_eq_of_related
    (images : IUTStage1MultiradialThetaImages package)
    {choice₁ choice₂ : index}
    (hrel : images.quotient.relation choice₁ choice₂) :
    images.possibleImages.images.region choice₁ =
      images.possibleImages.images.region choice₂ :=
  images.image_invariant hrel

theorem multiradialOutputMatchesPackage
    (images : IUTStage1MultiradialThetaImages package) :
    images.multiradialOutput = package.multiradialOutput :=
  images.multiradial_output_eq

theorem thetaPilotMatchesPackage
    (images : IUTStage1MultiradialThetaImages package) :
    images.possibleImages.thetaPilot = package.thetaPilot :=
  images.possibleImages.thetaPilotMatchesPackage

theorem indeterminaciesMatchPackage
    (images : IUTStage1MultiradialThetaImages package) :
    images.possibleImages.indeterminacies = package.indeterminacies :=
  images.possibleImages.indeterminaciesMatchPackage

end IUTStage1MultiradialThetaImages

/--
Obligation that Theta-pilot possible images depend only on the coric coordinate
of a coordinate choice.

This is the source-facing form of the multiradiality requirement needed by the
generated Ind1/2/3 quotient interface.
-/
structure IUTStage1ThetaImagesDependOnlyOnCoric
    {source target : Copy}
    {coric ind1State ind2State ind3State : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State)) :
    Prop where
  region_eq_of_coric_eq :
    ∀ choice₁ choice₂,
      choice₁.coric = choice₂.coric ->
        (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂

namespace IUTStage1ThetaImagesDependOnlyOnCoric

variable {source target : Copy}
variable {coric ind1State ind2State ind3State : Type u}
variable {package :
  IUTStage1SourcePackage source target
    (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State)}

def toMultiradialThetaImages
    (dependence : IUTStage1ThetaImagesDependOnlyOnCoric package) :
    IUTStage1MultiradialThetaImages package :=
  IUTStage1MultiradialThetaImages.ofPackageWithCoordinateQuotient
    package dependence.region_eq_of_coric_eq

theorem imageInvariant
    (dependence : IUTStage1ThetaImagesDependOnlyOnCoric package)
    {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1IndeterminacyChoice.coordinateGenerators
          (coric := coric) (ind1State := ind1State)
          (ind2State := ind2State) (ind3State := ind3State))
        choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  (dependence.toMultiradialThetaImages).region_eq_of_related hrel

theorem union_eq_targetUnion
    (dependence : IUTStage1ThetaImagesDependOnlyOnCoric package) :
    dependence.toMultiradialThetaImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  dependence.toMultiradialThetaImages.union_eq_targetUnion

end IUTStage1ThetaImagesDependOnlyOnCoric

/--
Source-facing statement of the obligations still needed to promote an IUT Stage
1 source package to the public Stage 1 endpoint.

This is intentionally a proposition, not a constructor from source labels. A
future source-specific proof must supply these fields.
-/
structure IUTStage1SourceObligations
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  algorithm_certified : package.preLedger.output.Certified
  she_arrow_matches_certificate :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she
  q_pilot_positive : 0 < -package.preLedger.qSigned
  normalization : package.preLedger.normalization

/--
Algorithmic-output component of the Theorem 3.11 source subclaims.

This isolates the opaque certificate for the multiradial algorithm output from
the later SHE-alignment datum.
-/
structure IUTStage1Theorem311AlgorithmicOutput
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  certified : package.preLedger.output.Certified

namespace IUTStage1Theorem311AlgorithmicOutput

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem algorithmOutputCertified
    (algorithmicOutput : IUTStage1Theorem311AlgorithmicOutput package) :
    package.preLedger.output.Certified :=
  algorithmicOutput.certified

end IUTStage1Theorem311AlgorithmicOutput

/--
Hodge-theater/SHE-alignment component of the Theorem 3.11 source subclaims.

This isolates the datum that connects the common-container SHE arrow to the
structured SHE certificate stored in the pre-ledger data.
-/
structure IUTStage1Theorem311SHEAlignment
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  alignment :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she

namespace IUTStage1Theorem311SHEAlignment

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem hodgeTheaterSHEAlignment
    (sheAlignment : IUTStage1Theorem311SHEAlignment package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  sheAlignment.alignment

end IUTStage1Theorem311SHEAlignment

/--
Source-facing split hull+det evidence for a Stage 1 source package.

This records that the hull+det bridge used by the package is backed by a
separate common-hull construction and determinant/log-volume bound.
-/
structure IUTStage1SourceHullDetData
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) where
  sourceData : package.preLedger.HullDetSourceData

namespace IUTStage1SourceHullDetData

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

def stepAudit (data : IUTStage1SourceHullDetData package) :
    data.sourceData.structuredHullDet.StepAudit package.preLedger.certificate :=
  data.sourceData.stepAudit

theorem targetUnion_subset_hull
    (data : IUTStage1SourceHullDetData package) :
    Region.Subset package.preLedger.output.comparisons.targetUnion
      (data.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  data.sourceData.targetUnion_subset_hull

theorem determinantVolumeBound
    (data : IUTStage1SourceHullDetData package) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (data.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  data.sourceData.determinantVolumeBound

theorem hullDetBridge_eq
    (data : IUTStage1SourceHullDetData package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
      data.sourceData.structuredHullDet.toHullDetHullBridgeData.toHullDetBridgeData :=
  data.sourceData.hullDetBridge_eq

theorem choiceTargetVolume_le_thetaSigned
    (data : IUTStage1SourceHullDetData package) (choice : index) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison choice) <=
      package.preLedger.thetaSigned :=
  data.sourceData.choiceTargetVolume_le_thetaSigned choice

theorem allTargetsAtMost
    (data : IUTStage1SourceHullDetData package) :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  data.sourceData.allTargetsAtMost

end IUTStage1SourceHullDetData

/--
Strengthened source obligations that include split hull+det provenance.

The older `IUTStage1SourceObligations` are still enough to build the public
comparison endpoint. This record is the stricter route a source-level IUT proof
should target when it wants the final comparison to remember its
union-of-possible-images hull.
-/
structure IUTStage1SourceHullDetObligations
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) where
  sourceObligations : IUTStage1SourceObligations package
  hullDetData : IUTStage1SourceHullDetData package

namespace IUTStage1SourceHullDetObligations

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

def toSourceObligations
    (obligations : IUTStage1SourceHullDetObligations package) :
    IUTStage1SourceObligations package :=
  obligations.sourceObligations

theorem algorithmCertified
    (obligations : IUTStage1SourceHullDetObligations package) :
    package.preLedger.output.Certified :=
  obligations.sourceObligations.algorithm_certified

theorem sheArrowMatchesCertificate
    (obligations : IUTStage1SourceHullDetObligations package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  obligations.sourceObligations.she_arrow_matches_certificate

theorem qPilotPositive
    (obligations : IUTStage1SourceHullDetObligations package) :
    0 < -package.preLedger.qSigned :=
  obligations.sourceObligations.q_pilot_positive

theorem normalization
    (obligations : IUTStage1SourceHullDetObligations package) :
    package.preLedger.normalization :=
  obligations.sourceObligations.normalization

theorem targetUnion_subset_hull
    (obligations : IUTStage1SourceHullDetObligations package) :
    Region.Subset package.preLedger.output.comparisons.targetUnion
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  obligations.hullDetData.targetUnion_subset_hull

theorem determinantVolumeBound
    (obligations : IUTStage1SourceHullDetObligations package) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  obligations.hullDetData.determinantVolumeBound

theorem choiceTargetVolume_le_thetaSigned
    (obligations : IUTStage1SourceHullDetObligations package) (choice : index) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison choice) <=
      package.preLedger.thetaSigned :=
  obligations.hullDetData.choiceTargetVolume_le_thetaSigned choice

theorem allTargetsAtMost
    (obligations : IUTStage1SourceHullDetObligations package) :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  obligations.hullDetData.allTargetsAtMost

end IUTStage1SourceHullDetObligations

/--
Strengthened source-facing SHE input for the Theorem 3.11 route.

This records a non-inert structured SHE context and only connects it to the
existing certificate/alignment fields. It does not construct a comparison
payload or endpoint.
-/
structure IUTStage1Theorem311StructuredSHE
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) where
  context :
    QualitativeData.StructuredSHEContext package.preLedger.output.family
  she_datum_matches_certificate :
    context.sheDatum = package.preLedger.certificate.she
  she_arrow_matches_context :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      context.sheDatum

namespace IUTStage1Theorem311StructuredSHE

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem hasStructuredSHE
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  structuredSHE.context.hasStructuredSHE

theorem sheDatumMatchesCertificate
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    structuredSHE.context.sheDatum = package.preLedger.certificate.she :=
  structuredSHE.she_datum_matches_certificate

theorem sheArrowMatchesContext
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      structuredSHE.context.sheDatum :=
  structuredSHE.she_arrow_matches_context

theorem hodgeTheaterSHEAlignment
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  structuredSHE.sheArrowMatchesContext.trans
    structuredSHE.sheDatumMatchesCertificate

def sheAlignment
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    IUTStage1Theorem311SHEAlignment package :=
  { alignment := structuredSHE.hodgeTheaterSHEAlignment }

theorem sheAlignment_hodgeTheaterSHEAlignment_eq
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    structuredSHE.sheAlignment.hodgeTheaterSHEAlignment =
      structuredSHE.hodgeTheaterSHEAlignment :=
  rfl

theorem domainHistory_ne_codomainHistory
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    structuredSHE.context.domainStructure.theater.side ≠
      structuredSHE.context.codomainStructure.theater.side :=
  structuredSHE.context.domainHistory_ne_codomainHistory

theorem commonContainerContextMatches
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    package.preLedger.chartedContainer.commonContainer.context =
      structuredSHE.context.sharedContext := by
  have hcontainer :
      package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum.sharedContext =
        package.preLedger.chartedContainer.commonContainer.context :=
    package.preLedger.chartedContainer.commonContainer.she_context_matches
  have harrow :
      package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum.sharedContext =
        structuredSHE.context.sheDatum.sharedContext := by
    exact congrArg
      (fun datum : QualitativeData.SHEDatum package.preLedger.output.family =>
        datum.sharedContext)
      structuredSHE.sheArrowMatchesContext
  exact hcontainer.symm.trans
    (harrow.trans structuredSHE.context.sheDatum_sharedContext)

end IUTStage1Theorem311StructuredSHE

/--
Compatibility checklist between the strengthened SHE context and the common
container used for the final `HDD o SHE` route.

Every field is an equality or history-separation proof already forced by the
structured SHE input and the common-container record. This checklist does not
add a comparison endpoint or identify the two arithmetic histories.
-/
structure IUTStage1Theorem311StructuredSHECommonContainerCompatibility
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) : Prop where
  she_arrow_matches_context :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      structuredSHE.context.sheDatum
  she_datum_matches_certificate :
    structuredSHE.context.sheDatum = package.preLedger.certificate.she
  common_container_context_matches :
    package.preLedger.chartedContainer.commonContainer.context =
      structuredSHE.context.sharedContext
  q_pilot_in_codomain :
    structuredSHE.context.qPilotStructure.theater =
      structuredSHE.context.codomainStructure.theater
  theta_pilot_in_domain :
    structuredSHE.context.thetaPilotStructure.theater =
      structuredSHE.context.domainStructure.theater
  simultaneous_valid : structuredSHE.context.simultaneous_valid
  histories_not_identified :
    structuredSHE.context.domainStructure.theater.side ≠
      structuredSHE.context.codomainStructure.theater.side

namespace IUTStage1Theorem311StructuredSHECommonContainerCompatibility

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {structuredSHE : IUTStage1Theorem311StructuredSHE package}

theorem ofStructuredSHE
    (structuredSHE : IUTStage1Theorem311StructuredSHE package) :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package structuredSHE :=
  { she_arrow_matches_context := structuredSHE.sheArrowMatchesContext,
    she_datum_matches_certificate := structuredSHE.sheDatumMatchesCertificate,
    common_container_context_matches :=
      structuredSHE.commonContainerContextMatches,
    q_pilot_in_codomain := structuredSHE.context.qPilotTheater_eq_codomain,
    theta_pilot_in_domain := structuredSHE.context.thetaPilotTheater_eq_domain,
    simultaneous_valid := structuredSHE.context.simultaneousValid,
    histories_not_identified :=
      structuredSHE.domainHistory_ne_codomainHistory }

theorem sheArrowMatchesContext
    (compatibility :
      IUTStage1Theorem311StructuredSHECommonContainerCompatibility
        package structuredSHE) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      structuredSHE.context.sheDatum :=
  compatibility.she_arrow_matches_context

theorem sheDatumMatchesCertificate
    (compatibility :
      IUTStage1Theorem311StructuredSHECommonContainerCompatibility
        package structuredSHE) :
    structuredSHE.context.sheDatum = package.preLedger.certificate.she :=
  compatibility.she_datum_matches_certificate

theorem commonContainerContextMatches
    (compatibility :
      IUTStage1Theorem311StructuredSHECommonContainerCompatibility
        package structuredSHE) :
    package.preLedger.chartedContainer.commonContainer.context =
      structuredSHE.context.sharedContext :=
  compatibility.common_container_context_matches

theorem qPilotTheater_eq_codomain
    (compatibility :
      IUTStage1Theorem311StructuredSHECommonContainerCompatibility
        package structuredSHE) :
    structuredSHE.context.qPilotStructure.theater =
      structuredSHE.context.codomainStructure.theater :=
  compatibility.q_pilot_in_codomain

theorem thetaPilotTheater_eq_domain
    (compatibility :
      IUTStage1Theorem311StructuredSHECommonContainerCompatibility
        package structuredSHE) :
    structuredSHE.context.thetaPilotStructure.theater =
      structuredSHE.context.domainStructure.theater :=
  compatibility.theta_pilot_in_domain

theorem simultaneousValid
    (compatibility :
      IUTStage1Theorem311StructuredSHECommonContainerCompatibility
        package structuredSHE) :
    structuredSHE.context.simultaneous_valid :=
  compatibility.simultaneous_valid

theorem domainHistory_ne_codomainHistory
    (compatibility :
      IUTStage1Theorem311StructuredSHECommonContainerCompatibility
        package structuredSHE) :
    structuredSHE.context.domainStructure.theater.side ≠
      structuredSHE.context.codomainStructure.theater.side :=
  compatibility.histories_not_identified

end IUTStage1Theorem311StructuredSHECommonContainerCompatibility

/--
Source-facing subclaims for the Theorem 3.11 algorithmic certificate used in
Stage 1.

This record separates the opaque algorithmic output certificate from the
Hodge-theater/SHE alignment datum needed to connect the common-container SHE
arrow to the structured certificate stored in the pre-ledger data.
-/
structure IUTStage1Theorem311Subclaims
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  algorithm_output_certified : package.preLedger.output.Certified
  hodge_theater_she_alignment :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she

namespace IUTStage1Theorem311Subclaims

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem algorithmOutputCertified
    (subclaims : IUTStage1Theorem311Subclaims package) :
    package.preLedger.output.Certified :=
  subclaims.algorithm_output_certified

def algorithmicOutput
    (subclaims : IUTStage1Theorem311Subclaims package) :
    IUTStage1Theorem311AlgorithmicOutput package :=
  { certified := subclaims.algorithmOutputCertified }

theorem hodgeTheaterSHEAlignment
    (subclaims : IUTStage1Theorem311Subclaims package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  subclaims.hodge_theater_she_alignment

def sheAlignment
    (subclaims : IUTStage1Theorem311Subclaims package) :
    IUTStage1Theorem311SHEAlignment package :=
  { alignment := subclaims.hodgeTheaterSHEAlignment }

def ofAlgorithmicOutputAndSHEAlignment
    (algorithmicOutput : IUTStage1Theorem311AlgorithmicOutput package)
    (sheAlignment :
      package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
        package.preLedger.certificate.she) :
    IUTStage1Theorem311Subclaims package :=
  { algorithm_output_certified :=
      algorithmicOutput.algorithmOutputCertified,
    hodge_theater_she_alignment := sheAlignment }

def ofComponents
    (algorithmicOutput : IUTStage1Theorem311AlgorithmicOutput package)
    (sheAlignment : IUTStage1Theorem311SHEAlignment package) :
    IUTStage1Theorem311Subclaims package :=
  ofAlgorithmicOutputAndSHEAlignment
    algorithmicOutput sheAlignment.hodgeTheaterSHEAlignment

theorem algorithmicOutput_certified_eq
    (subclaims : IUTStage1Theorem311Subclaims package) :
    subclaims.algorithmicOutput.algorithmOutputCertified =
      subclaims.algorithmOutputCertified :=
  rfl

theorem sheAlignment_hodgeTheaterSHEAlignment_eq
    (subclaims : IUTStage1Theorem311Subclaims package) :
    subclaims.sheAlignment.hodgeTheaterSHEAlignment =
      subclaims.hodgeTheaterSHEAlignment :=
  rfl

theorem ofAlgorithmicOutputAndSHEAlignment_algorithmicOutput_eq
    (algorithmicOutput : IUTStage1Theorem311AlgorithmicOutput package)
    (sheAlignment :
      package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
        package.preLedger.certificate.she) :
    (ofAlgorithmicOutputAndSHEAlignment
      algorithmicOutput sheAlignment).algorithmicOutput =
      algorithmicOutput :=
  Subsingleton.elim _ _

theorem ofComponents_algorithmicOutput_eq
    (algorithmicOutput : IUTStage1Theorem311AlgorithmicOutput package)
    (sheAlignment : IUTStage1Theorem311SHEAlignment package) :
    (ofComponents algorithmicOutput sheAlignment).algorithmicOutput =
      algorithmicOutput :=
  Subsingleton.elim _ _

theorem ofComponents_sheAlignment_eq
    (algorithmicOutput : IUTStage1Theorem311AlgorithmicOutput package)
    (sheAlignment : IUTStage1Theorem311SHEAlignment package) :
    (ofComponents algorithmicOutput sheAlignment).sheAlignment =
      sheAlignment :=
  Subsingleton.elim _ _

end IUTStage1Theorem311Subclaims

/--
Theorem 3.11 source inputs paired with the local pre-ledger audit.

The pre-ledger audit exposes structured IPL/SHE/APT data and chart/membership
facts. The subclaims record the separate opaque output certificate and SHE
alignment still needed for ledger promotion.
-/
structure IUTStage1Theorem311StructuredInputs
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  preledger_audit : IUTStage1PreLedgerData.Audit package.preLedger
  theorem311_subclaims : IUTStage1Theorem311Subclaims package

namespace IUTStage1Theorem311StructuredInputs

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem theorem311Subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    IUTStage1Theorem311Subclaims package :=
  inputs.theorem311_subclaims

theorem hasStructuredIPL
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    QualitativeData.HasStructuredIPL package.preLedger.output.family :=
  inputs.preledger_audit.has_structured_ipl

theorem hasStructuredSHE
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  inputs.preledger_audit.has_structured_she

theorem hasStructuredAPT
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    QualitativeData.HasStructuredAPT package.preLedger.output.family :=
  inputs.preledger_audit.has_structured_apt

theorem algorithmOutputCertified
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    package.preLedger.output.Certified :=
  inputs.theorem311_subclaims.algorithmOutputCertified

def algorithmicOutput
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    IUTStage1Theorem311AlgorithmicOutput package :=
  inputs.theorem311Subclaims.algorithmicOutput

theorem hodgeTheaterSHEAlignment
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  inputs.theorem311_subclaims.hodgeTheaterSHEAlignment

def sheAlignment
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    IUTStage1Theorem311SHEAlignment package :=
  inputs.theorem311Subclaims.sheAlignment

theorem algorithmOutputCertified_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    inputs.algorithmOutputCertified =
      inputs.theorem311Subclaims.algorithmOutputCertified :=
  rfl

theorem algorithmicOutput_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    inputs.algorithmicOutput =
      inputs.theorem311Subclaims.algorithmicOutput :=
  rfl

theorem hodgeTheaterSHEAlignment_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    inputs.hodgeTheaterSHEAlignment =
      inputs.theorem311Subclaims.hodgeTheaterSHEAlignment :=
  rfl

theorem sheAlignment_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    inputs.sheAlignment =
      inputs.theorem311Subclaims.sheAlignment :=
  rfl

theorem components_rebuild_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    IUTStage1Theorem311Subclaims.ofComponents
      inputs.algorithmicOutput inputs.sheAlignment =
      inputs.theorem311Subclaims :=
  Subsingleton.elim _ _

end IUTStage1Theorem311StructuredInputs

/--
Structured Theorem 3.11 inputs equipped with the strengthened SHE context.

This is a conservative extension of `IUTStage1Theorem311StructuredInputs`; it
does not replace the older route, and it does not produce an endpoint.
-/
structure IUTStage1Theorem311StructuredInputsWithSHE
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) where
  inputs : IUTStage1Theorem311StructuredInputs package
  structured_she : IUTStage1Theorem311StructuredSHE package

namespace IUTStage1Theorem311StructuredInputsWithSHE

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem theorem311StructuredInputs
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311StructuredInputs package :=
  bundle.inputs

def structuredSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311StructuredSHE package :=
  bundle.structured_she

theorem hasStructuredIPL
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    QualitativeData.HasStructuredIPL package.preLedger.output.family :=
  bundle.inputs.hasStructuredIPL

theorem hasStructuredSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  bundle.inputs.hasStructuredSHE

theorem hasStructuredSHE_from_context
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  bundle.structuredSHE.hasStructuredSHE

theorem hasStructuredAPT
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    QualitativeData.HasStructuredAPT package.preLedger.output.family :=
  bundle.inputs.hasStructuredAPT

theorem algorithmOutputCertified
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.output.Certified :=
  bundle.inputs.algorithmOutputCertified

theorem hodgeTheaterSHEAlignment
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  bundle.inputs.hodgeTheaterSHEAlignment

theorem hodgeTheaterSHEAlignment_from_context
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  bundle.structuredSHE.hodgeTheaterSHEAlignment

theorem sheAlignment_eq_context_sheAlignment
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.inputs.sheAlignment =
      bundle.structuredSHE.sheAlignment :=
  Subsingleton.elim _ _

theorem domainHistory_ne_codomainHistory
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  bundle.structuredSHE.domainHistory_ne_codomainHistory

theorem commonContainerCompatibility
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE :=
  IUTStage1Theorem311StructuredSHECommonContainerCompatibility.ofStructuredSHE
    bundle.structuredSHE

theorem commonContainerContextMatches
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext :=
  bundle.structuredSHE.commonContainerContextMatches

def hodgeTheaterDescentBridgeData
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1HodgeTheaterDescentBridgeData :=
  { domainTheater := bundle.structuredSHE.context.domainStructure.theater,
    codomainTheater := bundle.structuredSHE.context.codomainStructure.theater,
    descent := package.preLedger.chartedContainer.commonContainer.hddShe.hdd.descent,
    zeroColumnCheckpoint := fourthTriangleHDDSHECheckpoint,
    indeterminacyProfile := package.indeterminacies,
    histories_not_identified := bundle.domainHistory_ne_codomainHistory }

theorem hodgeTheaterDescentBridgeData_domainTheater_eq
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.hodgeTheaterDescentBridgeData.domainTheater =
      bundle.structuredSHE.context.domainStructure.theater :=
  rfl

theorem hodgeTheaterDescentBridgeData_codomainTheater_eq
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.hodgeTheaterDescentBridgeData.codomainTheater =
      bundle.structuredSHE.context.codomainStructure.theater :=
  rfl

theorem hodgeTheaterDescentBridgeData_descent_eq
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.hodgeTheaterDescentBridgeData.descent =
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.descent :=
  rfl

theorem hodgeTheaterDescentBridgeData_checkpoint_eq
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.hodgeTheaterDescentBridgeData.zeroColumnCheckpoint =
      fourthTriangleHDDSHECheckpoint :=
  rfl

theorem hodgeTheaterDescentBridgeData_indeterminacyProfile_eq
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.hodgeTheaterDescentBridgeData.indeterminacyProfile =
      package.indeterminacies :=
  rfl

theorem hodgeTheaterDescentBridgeData_histories_not_identified
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    bundle.hodgeTheaterDescentBridgeData.domainTheater.side ≠
      bundle.hodgeTheaterDescentBridgeData.codomainTheater.side :=
  bundle.hodgeTheaterDescentBridgeData.histories_not_identified

end IUTStage1Theorem311StructuredInputsWithSHE

/--
Route-level wrapper for square-weighted full-label transport preservation.

The underlying preservation audit from
`IUTStage1ZModSquareWeightedFullLabelTransportAudit` already states the
coordinate, square-weight, and full-label-log-volume preservation obligations.
This wrapper additionally requires that its Hodge-theater/descent bridge is the
one extracted from the structured-SHE Theorem 3.11 route.
-/
structure IUTStage1StructuredSHESquareWeightTransportAudit
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (l : PrimeGeFive) where
  preservation_audit :
    IUTStage1ZModSquareWeightedFullLabelTransportAudit l
  bridge_eq_structured_she :
    preservation_audit.bridge = bundle.hodgeTheaterDescentBridgeData

namespace IUTStage1StructuredSHESquareWeightTransportAudit

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {l : PrimeGeFive}

def preservationAudit
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    IUTStage1ZModSquareWeightedFullLabelTransportAudit l :=
  audit.preservation_audit

theorem bridge_eq_structuredSHE
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    audit.preservationAudit.bridge = bundle.hodgeTheaterDescentBridgeData :=
  audit.bridge_eq_structured_she

theorem bridge_domainTheater_eq
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    audit.preservationAudit.bridge.domainTheater =
      bundle.structuredSHE.context.domainStructure.theater := by
  rw [audit.bridge_eq_structuredSHE]
  rfl

theorem bridge_codomainTheater_eq
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    audit.preservationAudit.bridge.codomainTheater =
      bundle.structuredSHE.context.codomainStructure.theater := by
  rw [audit.bridge_eq_structuredSHE]
  rfl

theorem bridge_descent_eq
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    audit.preservationAudit.bridge.descent =
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.descent := by
  rw [audit.bridge_eq_structuredSHE]
  rfl

theorem targetTransportedSummand_eq_sourceSummand
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l)
    (j : ZMod l.value) :
    audit.preservationAudit.targetProfile.weight
          (audit.preservationAudit.coordinateEquiv j) *
        audit.preservationAudit.targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (audit.preservationAudit.coordinateEquiv j)) =
      audit.preservationAudit.sourceProfile.weight j *
        audit.preservationAudit.sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  audit.preservationAudit.targetTransportedSummand_eq_sourceSummand j

theorem targetTransportedAverage_eq_sourceAverage
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    audit.preservationAudit.targetTransportedAverage =
      audit.preservationAudit.sourceAverage :=
  audit.preservationAudit.targetTransportedAverage_eq_sourceAverage

theorem histories_not_identified
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    audit.preservationAudit.bridge.domainTheater.side ≠
      audit.preservationAudit.bridge.codomainTheater.side :=
  audit.preservationAudit.histories_not_identified

theorem structuredSHE_histories_not_identified
    (_audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  bundle.domainHistory_ne_codomainHistory

end IUTStage1StructuredSHESquareWeightTransportAudit

/--
Explicit open obligations for constructing the structured-SHE square-weight
transport audit.

The structured-SHE bundle supplies the Hodge-theater/descent bridge.  The fields
below are exactly the additional square-weight/full-label data still needed to
turn that bridge into a preservation audit.
-/
structure IUTStage1StructuredSHESquareWeightTransportObligations
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (l : PrimeGeFive) where
  coordinateEquiv : ZMod l.value ≃ ZMod l.value
  sourceProfile : IUTStage1ZModSquareWeightProfile l
  targetProfile : IUTStage1ZModSquareWeightProfile l
  sourceLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  targetLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  fullLabelLogVolume_preserved :
    ∀ j : ZMod l.value,
      targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j)) =
        sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
  squareWeight_preserved :
    ∀ j : ZMod l.value,
      targetProfile.weight (coordinateEquiv j) =
        sourceProfile.weight j
  weightTotal_preserved :
    targetProfile.weightTotal = sourceProfile.weightTotal

namespace IUTStage1StructuredSHESquareWeightTransportObligations

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {l : PrimeGeFive}

def suppliedBridge
    (_obligations :
      IUTStage1StructuredSHESquareWeightTransportObligations package bundle l) :
    IUTStage1HodgeTheaterDescentBridgeData :=
  bundle.hodgeTheaterDescentBridgeData

theorem suppliedBridge_histories_not_identified
    (obligations :
      IUTStage1StructuredSHESquareWeightTransportObligations package bundle l) :
    obligations.suppliedBridge.domainTheater.side ≠
      obligations.suppliedBridge.codomainTheater.side :=
  bundle.hodgeTheaterDescentBridgeData_histories_not_identified

def toPreservationAudit
    (obligations :
      IUTStage1StructuredSHESquareWeightTransportObligations package bundle l) :
    IUTStage1ZModSquareWeightedFullLabelTransportAudit l :=
  { bridge := obligations.suppliedBridge,
    coordinateEquiv := obligations.coordinateEquiv,
    sourceProfile := obligations.sourceProfile,
    targetProfile := obligations.targetProfile,
    sourceLogVolume := obligations.sourceLogVolume,
    targetLogVolume := obligations.targetLogVolume,
    fullLabelLogVolume_preserved := obligations.fullLabelLogVolume_preserved,
    squareWeight_preserved := obligations.squareWeight_preserved,
    weightTotal_preserved := obligations.weightTotal_preserved }

def toStructuredSHESquareWeightTransportAudit
    (obligations :
      IUTStage1StructuredSHESquareWeightTransportObligations package bundle l) :
    IUTStage1StructuredSHESquareWeightTransportAudit package bundle l :=
  { preservation_audit := obligations.toPreservationAudit,
    bridge_eq_structured_she := rfl }

theorem toPreservationAudit_bridge_eq_structuredSHE
    (obligations :
      IUTStage1StructuredSHESquareWeightTransportObligations package bundle l) :
    obligations.toPreservationAudit.bridge =
      bundle.hodgeTheaterDescentBridgeData :=
  rfl

theorem toStructuredSHESquareWeightTransportAudit_average_eq
    (obligations :
      IUTStage1StructuredSHESquareWeightTransportObligations package bundle l) :
    let audit := obligations.toStructuredSHESquareWeightTransportAudit
    audit.preservationAudit.targetTransportedAverage =
      audit.preservationAudit.sourceAverage :=
  (obligations.toStructuredSHESquareWeightTransportAudit).targetTransportedAverage_eq_sourceAverage

theorem toStructuredSHESquareWeightTransportAudit_descent_eq
    (obligations :
      IUTStage1StructuredSHESquareWeightTransportObligations package bundle l) :
    let audit := obligations.toStructuredSHESquareWeightTransportAudit
    audit.preservationAudit.bridge.descent =
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.descent :=
  (obligations.toStructuredSHESquareWeightTransportAudit).bridge_descent_eq

end IUTStage1StructuredSHESquareWeightTransportObligations

/--
Reduced structured-SHE square-weight obligations.

Instead of asking separately for pointwise square-weight preservation and
total-weight preservation, this record asks for the coordinate equivalence to
preserve the canonical real square profile.  The two weight-preservation fields
of `IUTStage1StructuredSHESquareWeightTransportObligations` are then derived by
the `IUTStage1ZModSquareWeightProfile` lemmas.
-/
structure IUTStage1StructuredSHECoordinateSquareWeightObligations
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (l : PrimeGeFive) where
  coordinateEquiv : ZMod l.value ≃ ZMod l.value
  sourceProfile : IUTStage1ZModSquareWeightProfile l
  targetProfile : IUTStage1ZModSquareWeightProfile l
  sourceLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  targetLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  coordinateSquare_preserved :
    IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
      (l := l) coordinateEquiv
  fullLabelLogVolume_preserved :
    ∀ j : ZMod l.value,
      targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j)) =
        sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)

namespace IUTStage1StructuredSHECoordinateSquareWeightObligations

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {l : PrimeGeFive}

theorem squareWeight_preserved
    (obligations :
      IUTStage1StructuredSHECoordinateSquareWeightObligations package bundle l) :
    ∀ j : ZMod l.value,
      obligations.targetProfile.weight (obligations.coordinateEquiv j) =
        obligations.sourceProfile.weight j :=
  IUTStage1ZModSquareWeightProfile.squareWeight_preserved_of_coordinateSquarePreserving
    obligations.sourceProfile obligations.targetProfile
    obligations.coordinateSquare_preserved

theorem weightTotal_preserved
    (obligations :
      IUTStage1StructuredSHECoordinateSquareWeightObligations package bundle l) :
    obligations.targetProfile.weightTotal =
      obligations.sourceProfile.weightTotal :=
  IUTStage1ZModSquareWeightProfile.weightTotal_preserved_of_coordinateSquarePreserving
    obligations.sourceProfile obligations.targetProfile
    obligations.coordinateSquare_preserved

def toStructuredSHESquareWeightTransportObligations
    (obligations :
      IUTStage1StructuredSHECoordinateSquareWeightObligations package bundle l) :
    IUTStage1StructuredSHESquareWeightTransportObligations package bundle l :=
  { coordinateEquiv := obligations.coordinateEquiv,
    sourceProfile := obligations.sourceProfile,
    targetProfile := obligations.targetProfile,
    sourceLogVolume := obligations.sourceLogVolume,
    targetLogVolume := obligations.targetLogVolume,
    fullLabelLogVolume_preserved :=
      obligations.fullLabelLogVolume_preserved,
    squareWeight_preserved := obligations.squareWeight_preserved,
    weightTotal_preserved := obligations.weightTotal_preserved }

theorem toStructuredSHESquareWeightTransportObligations_average_eq
    (obligations :
      IUTStage1StructuredSHECoordinateSquareWeightObligations package bundle l) :
    let transportObligations :=
      obligations.toStructuredSHESquareWeightTransportObligations
    let audit := transportObligations.toStructuredSHESquareWeightTransportAudit
    audit.preservationAudit.targetTransportedAverage =
      audit.preservationAudit.sourceAverage := by
  let full := obligations.toStructuredSHESquareWeightTransportObligations
  change
    full.toStructuredSHESquareWeightTransportAudit.preservationAudit.targetTransportedAverage =
      full.toStructuredSHESquareWeightTransportAudit.preservationAudit.sourceAverage
  exact full.toStructuredSHESquareWeightTransportAudit_average_eq

theorem toStructuredSHESquareWeightTransportObligations_bridge_eq
    (obligations :
      IUTStage1StructuredSHECoordinateSquareWeightObligations package bundle l) :
    let transportObligations :=
      obligations.toStructuredSHESquareWeightTransportObligations
    transportObligations.toPreservationAudit.bridge =
      bundle.hodgeTheaterDescentBridgeData := by
  let full := obligations.toStructuredSHESquareWeightTransportObligations
  change full.toPreservationAudit.bridge = bundle.hodgeTheaterDescentBridgeData
  exact full.toPreservationAudit_bridge_eq_structuredSHE

end IUTStage1StructuredSHECoordinateSquareWeightObligations

/--
Fully factored structured-SHE obligations for the square-weighted full-label
transport corridor.

This record asks for the two primitive preservation branches separately:

* coordinate-square preservation for the `j^2` weights;
* full-label map preservation plus value preservation for the log-volume branch.

The previous structured-SHE square-weight obligation records are derived from
these fields.
-/
structure IUTStage1StructuredSHEFactoredSquareFullLabelObligations
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (l : PrimeGeFive) where
  coordinateEquiv : ZMod l.value ≃ ZMod l.value
  sourceProfile : IUTStage1ZModSquareWeightProfile l
  targetProfile : IUTStage1ZModSquareWeightProfile l
  sourceLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  targetLogVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l
  coordinateSquare_preserved :
    IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
      (l := l) coordinateEquiv
  fullLabelMap_preserved :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
      (l := l) coordinateEquiv
  fullLabelValue_preserved :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelLogVolumeValuePreserving
      sourceLogVolume targetLogVolume

namespace IUTStage1StructuredSHEFactoredSquareFullLabelObligations

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {l : PrimeGeFive}

theorem fullLabelLogVolume_preserved
    (obligations :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package bundle l) :
    ∀ j : ZMod l.value,
      obligations.targetLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (obligations.coordinateEquiv j)) =
        obligations.sourceLogVolume.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  intro j
  rw [obligations.fullLabelMap_preserved j]
  exact obligations.fullLabelValue_preserved
    (IUTStage1ZModCuspFullLabel.fromCoordinate l j)

def toCoordinateSquareWeightObligations
    (obligations :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package bundle l) :
    IUTStage1StructuredSHECoordinateSquareWeightObligations package bundle l :=
  { coordinateEquiv := obligations.coordinateEquiv,
    sourceProfile := obligations.sourceProfile,
    targetProfile := obligations.targetProfile,
    sourceLogVolume := obligations.sourceLogVolume,
    targetLogVolume := obligations.targetLogVolume,
    coordinateSquare_preserved := obligations.coordinateSquare_preserved,
    fullLabelLogVolume_preserved :=
      obligations.fullLabelLogVolume_preserved }

def toStructuredSHESquareWeightTransportObligations
    (obligations :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package bundle l) :
    IUTStage1StructuredSHESquareWeightTransportObligations package bundle l := by
  let reduced := obligations.toCoordinateSquareWeightObligations
  exact reduced.toStructuredSHESquareWeightTransportObligations

def toStructuredSHESquareWeightTransportAudit
    (obligations :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package bundle l) :
    IUTStage1StructuredSHESquareWeightTransportAudit package bundle l := by
  let full := obligations.toStructuredSHESquareWeightTransportObligations
  exact full.toStructuredSHESquareWeightTransportAudit

theorem transportedAverage_eq
    (obligations :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package bundle l) :
    let audit := obligations.toStructuredSHESquareWeightTransportAudit
    audit.preservationAudit.targetTransportedAverage =
      audit.preservationAudit.sourceAverage := by
  let reduced := obligations.toCoordinateSquareWeightObligations
  let full := reduced.toStructuredSHESquareWeightTransportObligations
  let audit := full.toStructuredSHESquareWeightTransportAudit
  change
    audit.preservationAudit.targetTransportedAverage =
      audit.preservationAudit.sourceAverage
  exact reduced.toStructuredSHESquareWeightTransportObligations_average_eq

theorem bridge_eq_structuredSHE
    (obligations :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package bundle l) :
    obligations.toStructuredSHESquareWeightTransportAudit.preservationAudit.bridge =
      bundle.hodgeTheaterDescentBridgeData :=
  obligations.toStructuredSHESquareWeightTransportAudit.bridge_eq_structuredSHE

end IUTStage1StructuredSHEFactoredSquareFullLabelObligations

/--
Boundary comparing the strengthened SHE/common-container route with the factored
square/full-label preservation interface.

The compatibility data records the simultaneous common-container bookkeeping,
but the primitive `j^2` and full-label preservation fields remain separate
obligations.
-/
structure IUTStage1StructuredSHEFactoredPreservationBoundary
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) where
  commonContainerCompatibility :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE

namespace IUTStage1StructuredSHEFactoredPreservationBoundary

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}

def ofBundle
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1StructuredSHEFactoredPreservationBoundary package bundle :=
  { commonContainerCompatibility := bundle.commonContainerCompatibility }

def missingFactoredSquareFullLabelData
    (_boundary :
      IUTStage1StructuredSHEFactoredPreservationBoundary package bundle) :
    Finset IUTStage1FactoredSquareFullLabelMissingDatum :=
  IUTStage1FactoredSquareFullLabelMissingDatum.all

theorem commonContainerContextMatches
    (boundary :
      IUTStage1StructuredSHEFactoredPreservationBoundary package bundle) :
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext :=
  boundary.commonContainerCompatibility.commonContainerContextMatches

theorem simultaneousValid
    (boundary :
      IUTStage1StructuredSHEFactoredPreservationBoundary package bundle) :
    bundle.structuredSHE.context.simultaneous_valid :=
  boundary.commonContainerCompatibility.simultaneousValid

theorem domainHistory_ne_codomainHistory
    (boundary :
      IUTStage1StructuredSHEFactoredPreservationBoundary package bundle) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  boundary.commonContainerCompatibility.domainHistory_ne_codomainHistory

theorem coordinateSquarePreservation_missing
    (boundary :
      IUTStage1StructuredSHEFactoredPreservationBoundary package bundle) :
    IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation ∈
      boundary.missingFactoredSquareFullLabelData :=
  IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation_mem_all

theorem fullLabelMapPreservation_missing
    (boundary :
      IUTStage1StructuredSHEFactoredPreservationBoundary package bundle) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelMapPreservation ∈
      boundary.missingFactoredSquareFullLabelData :=
  IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelMapPreservation_mem_all

theorem fullLabelValuePreservation_missing
    (boundary :
      IUTStage1StructuredSHEFactoredPreservationBoundary package bundle) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation ∈
      boundary.missingFactoredSquareFullLabelData :=
  IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation_mem_all

end IUTStage1StructuredSHEFactoredPreservationBoundary

/--
Audited entry from the strengthened SHE route into the existing `HDD o SHE`
boundedness API.

This record keeps the SHE/common-container compatibility proof next to the
boundedness facts obtained by applying the charted common container to the
pre-ledger certificate. It deliberately stops at target-volume bounds; the
q-side membership step and the final signed Corollary 3.12 packaging remain
separate.
-/
structure IUTStage1Theorem311AuditedHDDSHEBound
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) : Prop where
  compatibility :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE
  common_container_bound_audit :
    package.preLedger.chartedContainer.commonContainer.BoundAudit
      package.preLedger.certificate
  local_expression_valid :
    bundle.structuredSHE.context.simultaneousExpression.AllLocalValid
  chosen_target_volume_le_theta :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned
  all_targets_at_most_theta :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace IUTStage1Theorem311AuditedHDDSHEBound

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  { compatibility := bundle.commonContainerCompatibility,
    common_container_bound_audit :=
      package.preLedger.chartedContainer.commonContainer.boundAudit
        package.preLedger.certificate,
    local_expression_valid :=
      bundle.structuredSHE.context.allLocalExpressionValid,
    chosen_target_volume_le_theta :=
      package.preLedger.chartedContainer.choice_targetVolume_le
        package.preLedger.certificate package.preLedger.chosenOutput.choice,
    all_targets_at_most_theta :=
      package.preLedger.chartedContainer.allTargetsAtMost
        package.preLedger.certificate,
    histories_not_identified := bundle.domainHistory_ne_codomainHistory }

theorem commonContainerCompatibility
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE :=
  audited.compatibility

theorem commonContainerBoundAudit
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    package.preLedger.chartedContainer.commonContainer.BoundAudit
      package.preLedger.certificate :=
  audited.common_container_bound_audit

theorem hddSHEDecompositionAudit
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    package.preLedger.chartedContainer.commonContainer.hddShe.DecompositionAudit
      package.preLedger.certificate :=
  audited.commonContainerBoundAudit.hddSHEDecomposition

theorem hddDecompositionAudit
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    package.preLedger.chartedContainer.commonContainer.hddShe.hdd.DecompositionAudit
      package.preLedger.certificate :=
  audited.hddSHEDecompositionAudit.hddDecomposition

theorem hullDetBoundAudit
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge.BoundAudit
      package.preLedger.certificate :=
  audited.hddDecompositionAudit.hullDetBoundAudit

theorem sheArrowMatchesContext
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      bundle.structuredSHE.context.sheDatum :=
  audited.compatibility.sheArrowMatchesContext

theorem sheDatumMatchesCertificate
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.sheDatum =
      package.preLedger.certificate.she :=
  audited.compatibility.sheDatumMatchesCertificate

theorem sheArrowDatumMatchesCertificate
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  audited.sheArrowMatchesContext.trans audited.sheDatumMatchesCertificate

theorem commonContainerContextMatches
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext :=
  audited.compatibility.commonContainerContextMatches

theorem qPilotTheater_eq_codomain
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.qPilotStructure.theater =
      bundle.structuredSHE.context.codomainStructure.theater :=
  audited.compatibility.qPilotTheater_eq_codomain

theorem thetaPilotTheater_eq_domain
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.thetaPilotStructure.theater =
      bundle.structuredSHE.context.domainStructure.theater :=
  audited.compatibility.thetaPilotTheater_eq_domain

theorem localExpressionValid
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.simultaneousExpression.AllLocalValid :=
  audited.local_expression_valid

theorem qPilotExpressionValid
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.simultaneousExpression.q_pilot_expression_valid :=
  audited.localExpressionValid.2.2.1

theorem thetaPilotExpressionValid
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.simultaneousExpression.theta_pilot_expression_valid :=
  audited.localExpressionValid.2.2.2.1

theorem simultaneousValid
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.simultaneous_valid :=
  audited.localExpressionValid.2.2.2.2

theorem chosenTargetVolume_le_theta
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned :=
  audited.chosen_target_volume_le_theta

theorem allTargetsAtMost_theta
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  audited.all_targets_at_most_theta

theorem domainHistory_ne_codomainHistory
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  audited.histories_not_identified

end IUTStage1Theorem311AuditedHDDSHEBound

namespace IUTStage1Theorem311StructuredInputsWithSHE

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem auditedHDDSHEBound
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  IUTStage1Theorem311AuditedHDDSHEBound.ofStructuredInputsWithSHE bundle

theorem auditedHDDSHE_chosenTargetVolume_le_theta
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned :=
  bundle.auditedHDDSHEBound.chosenTargetVolume_le_theta

theorem auditedHDDSHE_allTargetsAtMost_theta
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  bundle.auditedHDDSHEBound.allTargetsAtMost_theta

end IUTStage1Theorem311StructuredInputsWithSHE

/--
Audited connection from the `HDD o SHE` bound to the charted target-volume
middle term used later in the signed comparison.

This is still not the q-to-Theta comparison. It only states that the named
middle term in the pre-ledger is the chosen target volume bounded by the
audited `HDD o SHE` route.
-/
structure IUTStage1Theorem311AuditedTargetVolumeMiddle
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) : Prop where
  audited_hdd_she_bound :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle
  target_signed_eq_chosen_volume :
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice)
  target_signed_le_theta :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace IUTStage1Theorem311AuditedTargetVolumeMiddle

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}

theorem ofAuditedHDDSHEBound
    (audited : IUTStage1Theorem311AuditedHDDSHEBound package bundle) :
    IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle :=
  { audited_hdd_she_bound := audited,
    target_signed_eq_chosen_volume :=
      package.preLedger.targetSigned_eq_choiceTargetVolume,
    target_signed_le_theta := by
      rw [package.preLedger.targetSigned_eq_choiceTargetVolume]
      exact audited.chosenTargetVolume_le_theta,
    histories_not_identified := audited.domainHistory_ne_codomainHistory }

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle :=
  ofAuditedHDDSHEBound bundle.auditedHDDSHEBound

theorem auditedHDDSHEBound
    (middle :
      IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle) :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  middle.audited_hdd_she_bound

theorem targetSigned_eq_chosenTargetVolume
    (middle :
      IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle) :
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) :=
  middle.target_signed_eq_chosen_volume

theorem chosenTargetVolume_eq_targetSigned
    (middle :
      IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) =
      package.preLedger.targetVolume.targetSigned :=
  middle.targetSigned_eq_chosenTargetVolume.symm

theorem targetSigned_le_theta
    (middle :
      IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  middle.target_signed_le_theta

theorem domainHistory_ne_codomainHistory
    (middle :
      IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  middle.histories_not_identified

end IUTStage1Theorem311AuditedTargetVolumeMiddle

namespace IUTStage1Theorem311StructuredInputsWithSHE

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem auditedTargetVolumeMiddle
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle :=
  IUTStage1Theorem311AuditedTargetVolumeMiddle.ofStructuredInputsWithSHE bundle

theorem auditedTargetSigned_eq_chosenTargetVolume
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) :=
  bundle.auditedTargetVolumeMiddle.targetSigned_eq_chosenTargetVolume

theorem auditedTargetSigned_le_theta
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  bundle.auditedTargetVolumeMiddle.targetSigned_le_theta

end IUTStage1Theorem311StructuredInputsWithSHE

/--
Audited lower-middle bridge from the charted q-side datum to the charted
target-volume middle term.

This records the membership/charting contribution to the eventual inequality
chain. It is intentionally separate from the `HDD o SHE` upper bound and from
the final signed q-to-Theta packaging.
-/
structure IUTStage1Theorem311AuditedMembershipMiddle
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) : Prop where
  target_volume_middle :
    IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle
  q_charted :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned
  chosen_holds :
    package.preLedger.chosenOutput.comparison.Holds
      package.preLedger.qValue.qPoint
  q_signed_le_target :
    package.preLedger.qSigned <=
      package.preLedger.targetVolume.targetSigned
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace IUTStage1Theorem311AuditedMembershipMiddle

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}

theorem ofTargetVolumeMiddle
    (middle : IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle) :
    IUTStage1Theorem311AuditedMembershipMiddle package bundle :=
  { target_volume_middle := middle,
    q_charted := package.preLedger.qSigned_eq_chartedQ,
    chosen_holds := package.preLedger.chosenComparisonHoldsQ,
    q_signed_le_target := package.preLedger.qSigned_le_targetSigned,
    histories_not_identified := middle.domainHistory_ne_codomainHistory }

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedMembershipMiddle package bundle :=
  ofTargetVolumeMiddle bundle.auditedTargetVolumeMiddle

theorem targetVolumeMiddle
    (middle :
      IUTStage1Theorem311AuditedMembershipMiddle package bundle) :
    IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle :=
  middle.target_volume_middle

theorem qCharted
    (middle :
      IUTStage1Theorem311AuditedMembershipMiddle package bundle) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  middle.q_charted

theorem chosenHolds
    (middle :
      IUTStage1Theorem311AuditedMembershipMiddle package bundle) :
    package.preLedger.chosenOutput.comparison.Holds
      package.preLedger.qValue.qPoint :=
  middle.chosen_holds

theorem qSigned_le_targetSigned
    (middle :
      IUTStage1Theorem311AuditedMembershipMiddle package bundle) :
    package.preLedger.qSigned <=
      package.preLedger.targetVolume.targetSigned :=
  middle.q_signed_le_target

theorem domainHistory_ne_codomainHistory
    (middle :
      IUTStage1Theorem311AuditedMembershipMiddle package bundle) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  middle.histories_not_identified

end IUTStage1Theorem311AuditedMembershipMiddle

namespace IUTStage1Theorem311StructuredInputsWithSHE

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem auditedMembershipMiddle
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedMembershipMiddle package bundle :=
  IUTStage1Theorem311AuditedMembershipMiddle.ofStructuredInputsWithSHE bundle

theorem auditedQCharted
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  bundle.auditedMembershipMiddle.qCharted

theorem auditedChosenHolds
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.chosenOutput.comparison.Holds
      package.preLedger.qValue.qPoint :=
  bundle.auditedMembershipMiddle.chosenHolds

theorem auditedQSigned_le_targetSigned
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.qSigned <=
      package.preLedger.targetVolume.targetSigned :=
  bundle.auditedMembershipMiddle.qSigned_le_targetSigned

end IUTStage1Theorem311StructuredInputsWithSHE

/--
Audited composition of the lower and upper middle inequalities.

This produces only the raw real inequality `qSigned <= thetaSigned`. It is not
the Corollary 3.12 endpoint: no q-positivity, source normalization, signed pilot
objects, or public comparison payload are introduced here.
-/
structure IUTStage1Theorem311AuditedRawInequality
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) : Prop where
  membership_middle :
    IUTStage1Theorem311AuditedMembershipMiddle package bundle
  q_signed_le_target :
    package.preLedger.qSigned <=
      package.preLedger.targetVolume.targetSigned
  target_signed_le_theta :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned
  q_signed_le_theta :
    package.preLedger.qSigned <= package.preLedger.thetaSigned
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace IUTStage1Theorem311AuditedRawInequality

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}

theorem ofMembershipMiddle
    (middle : IUTStage1Theorem311AuditedMembershipMiddle package bundle) :
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  { membership_middle := middle,
    q_signed_le_target := middle.qSigned_le_targetSigned,
    target_signed_le_theta := middle.targetVolumeMiddle.targetSigned_le_theta,
    q_signed_le_theta :=
      le_trans middle.qSigned_le_targetSigned
        middle.targetVolumeMiddle.targetSigned_le_theta,
    histories_not_identified := middle.domainHistory_ne_codomainHistory }

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  ofMembershipMiddle bundle.auditedMembershipMiddle

theorem membershipMiddle
    (raw : IUTStage1Theorem311AuditedRawInequality package bundle) :
    IUTStage1Theorem311AuditedMembershipMiddle package bundle :=
  raw.membership_middle

theorem qSigned_le_targetSigned
    (raw : IUTStage1Theorem311AuditedRawInequality package bundle) :
    package.preLedger.qSigned <=
      package.preLedger.targetVolume.targetSigned :=
  raw.q_signed_le_target

theorem targetSigned_le_theta
    (raw : IUTStage1Theorem311AuditedRawInequality package bundle) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  raw.target_signed_le_theta

theorem qSigned_le_thetaSigned
    (raw : IUTStage1Theorem311AuditedRawInequality package bundle) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  raw.q_signed_le_theta

theorem domainHistory_ne_codomainHistory
    (raw : IUTStage1Theorem311AuditedRawInequality package bundle) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  raw.histories_not_identified

end IUTStage1Theorem311AuditedRawInequality

namespace IUTStage1Theorem311StructuredInputsWithSHE

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem auditedRawInequality
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  IUTStage1Theorem311AuditedRawInequality.ofStructuredInputsWithSHE bundle

theorem auditedRaw_qSigned_le_thetaSigned
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  bundle.auditedRawInequality.qSigned_le_thetaSigned

end IUTStage1Theorem311StructuredInputsWithSHE

/--
Source-facing side conditions needed for Stage 1 ledger promotion.

These conditions are intentionally separate from the Theorem 3.11 subclaims:
they record the sign/normalization hypotheses that must accompany the
algorithmic and SHE-alignment data.
-/
structure IUTStage1SourceSideConditions
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  q_pilot_positive : 0 < -package.preLedger.qSigned
  source_normalization : package.preLedger.normalization

namespace IUTStage1SourceSideConditions

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem qPilotPositive
    (sideConditions : IUTStage1SourceSideConditions package) :
    0 < -package.preLedger.qSigned :=
  sideConditions.q_pilot_positive

theorem sourceNormalization
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.preLedger.normalization :=
  sideConditions.source_normalization

end IUTStage1SourceSideConditions

/--
Audited boundary between the raw real inequality and the signed comparison
payload used for Corollary 3.12-style statements.

The raw inequality is still sourced from the audited SHE/HDD/membership route.
The side conditions are supplied explicitly here, so q-positivity and source
normalization are not hidden inside the inequality composition.
-/
structure IUTStage1Theorem311AuditedSignedPayloadBoundary
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  raw_inequality :
    IUTStage1Theorem311AuditedRawInequality package bundle
  q_pilot_positive : 0 < -package.preLedger.qSigned
  source_normalization : package.preLedger.normalization
  theta_chart_trivial :
    Transport.TrivialMonodromy
      package.preLedger.chartedContainer.chart.thetaToTarget
  q_charted :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned
  theta_charted :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned
  q_signed_le_theta :
    package.preLedger.qSigned <= package.preLedger.thetaSigned
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace IUTStage1Theorem311AuditedSignedPayloadBoundary

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofRawInequality
    (raw : IUTStage1Theorem311AuditedRawInequality package bundle)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions :=
  { raw_inequality := raw,
    q_pilot_positive := sideConditions.qPilotPositive,
    source_normalization := sideConditions.sourceNormalization,
    theta_chart_trivial := package.preLedger.thetaChartTrivial,
    q_charted := package.preLedger.qSigned_eq_chartedQ,
    theta_charted := package.preLedger.thetaSigned_eq_chartedTheta,
    q_signed_le_theta := raw.qSigned_le_thetaSigned,
    histories_not_identified := raw.domainHistory_ne_codomainHistory }

theorem ofStructuredInputsWithSideConditions
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions :=
  ofRawInequality bundle.auditedRawInequality sideConditions

theorem rawInequality
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  boundary.raw_inequality

theorem qPilotPositive
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    0 < -package.preLedger.qSigned :=
  boundary.q_pilot_positive

theorem sourceNormalization
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    package.preLedger.normalization :=
  boundary.source_normalization

theorem thetaChartTrivial
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    Transport.TrivialMonodromy
      package.preLedger.chartedContainer.chart.thetaToTarget :=
  boundary.theta_chart_trivial

theorem qCharted
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned :=
  boundary.q_charted

theorem thetaCharted
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  boundary.theta_charted

theorem qSigned_le_thetaSigned
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  boundary.q_signed_le_theta

def comparisonData
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    Corollary312ComparisonData :=
  { thetaSigned := package.preLedger.thetaSigned,
    qSigned := package.preLedger.qSigned,
    q_positive := boundary.qPilotPositive,
    qSigned_le_thetaSigned := boundary.qSigned_le_thetaSigned }

theorem comparisonData_qSigned
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    boundary.comparisonData.qSigned = package.preLedger.qSigned :=
  rfl

theorem comparisonData_thetaSigned
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    boundary.comparisonData.thetaSigned = package.preLedger.thetaSigned :=
  rfl

theorem comparisonData_qSigned_le_thetaSigned
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    boundary.comparisonData.qSigned <= boundary.comparisonData.thetaSigned :=
  boundary.comparisonData.qSigned_le_thetaSigned

theorem comparisonData_corollary312
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    Corollary312Inequality
      boundary.comparisonData.thetaPilot boundary.comparisonData.qPilot :=
  boundary.comparisonData.corollary312

theorem domainHistory_ne_codomainHistory
    (boundary :
      IUTStage1Theorem311AuditedSignedPayloadBoundary
        package bundle sideConditions) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  boundary.histories_not_identified

end IUTStage1Theorem311AuditedSignedPayloadBoundary

namespace IUTStage1Theorem311StructuredInputsWithSHE

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem auditedSignedPayloadBoundary
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions :=
  IUTStage1Theorem311AuditedSignedPayloadBoundary.ofStructuredInputsWithSideConditions
    bundle sideConditions

def auditedComparisonData
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    Corollary312ComparisonData :=
  (bundle.auditedSignedPayloadBoundary sideConditions).comparisonData

theorem auditedComparisonData_qSigned_le_thetaSigned
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    (bundle.auditedComparisonData sideConditions).qSigned <=
      (bundle.auditedComparisonData sideConditions).thetaSigned :=
  (bundle.auditedSignedPayloadBoundary
    sideConditions).comparisonData_qSigned_le_thetaSigned

end IUTStage1Theorem311StructuredInputsWithSHE

/--
Source-facing hypotheses for the side conditions used in Stage 1 promotion.

This record gives source-oriented names to the q-pilot sign and normalization
assumptions before converting them to `IUTStage1SourceSideConditions`.
-/
structure IUTStage1SourceSideConditionHypotheses
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  q_pilot_log_volume_positive : 0 < -package.preLedger.qSigned
  source_normalized : package.preLedger.normalization

namespace IUTStage1SourceSideConditionHypotheses

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem qPilotLogVolumePositive
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    0 < -package.preLedger.qSigned :=
  hypotheses.q_pilot_log_volume_positive

theorem sourceNormalized
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.preLedger.normalization :=
  hypotheses.source_normalized

def toSideConditions
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    IUTStage1SourceSideConditions package :=
  { q_pilot_positive := hypotheses.qPilotLogVolumePositive,
    source_normalization := hypotheses.sourceNormalized }

def ofSideConditions
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1SourceSideConditionHypotheses package :=
  { q_pilot_log_volume_positive := sideConditions.qPilotPositive,
    source_normalized := sideConditions.sourceNormalization }

theorem toSideConditions_ofSideConditions
    (sideConditions : IUTStage1SourceSideConditions package) :
    (ofSideConditions sideConditions).toSideConditions = sideConditions :=
  Subsingleton.elim _ _

/--
Audit record tying side-condition hypotheses to their source-facing labels.

This record still carries no proof beyond the hypotheses themselves; it records
which labeled q-pilot log-volume and normalization data the hypotheses concern.
-/
structure Audit
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) : Prop where
  qPilotLogVolume_matches_labels :
    package.qPilotLogVolume = package.labels.qPilotLogVolume
  sourceNormalization_matches_labels :
    package.sourceNormalizationLabel = package.labels.sourceNormalization
  q_pilot_log_volume_positive : 0 < -package.preLedger.qSigned
  source_normalized : package.preLedger.normalization

theorem audit
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Audit hypotheses :=
  { qPilotLogVolume_matches_labels :=
      package.qPilotLogVolume_matches_labels,
    sourceNormalization_matches_labels :=
      package.sourceNormalization_matches_labels,
    q_pilot_log_volume_positive := hypotheses.qPilotLogVolumePositive,
    source_normalized := hypotheses.sourceNormalized }

namespace Audit

variable {hypotheses : IUTStage1SourceSideConditionHypotheses package}

theorem qPilotLogVolumeMatchesLabels
    (audit : Audit hypotheses) :
    package.qPilotLogVolume = package.labels.qPilotLogVolume :=
  audit.qPilotLogVolume_matches_labels

theorem sourceNormalizationMatchesLabels
    (audit : Audit hypotheses) :
    package.sourceNormalizationLabel = package.labels.sourceNormalization :=
  audit.sourceNormalization_matches_labels

theorem qPilotLogVolumePositive
    (audit : Audit hypotheses) :
    0 < -package.preLedger.qSigned :=
  audit.q_pilot_log_volume_positive

theorem sourceNormalized
    (audit : Audit hypotheses) :
    package.preLedger.normalization :=
  audit.source_normalized

end Audit

end IUTStage1SourceSideConditionHypotheses

namespace IUTStage1SourceObligations

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

def ofSubclaimsAndSideConditions
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1SourceObligations package :=
  { algorithm_certified := subclaims.algorithmOutputCertified,
    she_arrow_matches_certificate := subclaims.hodgeTheaterSHEAlignment,
    q_pilot_positive := sideConditions.qPilotPositive,
    normalization := sideConditions.sourceNormalization }

def ofStructuredInputsAndSideConditions
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1SourceObligations package :=
  { algorithm_certified :=
      inputs.algorithmicOutput.algorithmOutputCertified,
    she_arrow_matches_certificate :=
      inputs.sheAlignment.hodgeTheaterSHEAlignment,
    q_pilot_positive := sideConditions.qPilotPositive,
    normalization := sideConditions.sourceNormalization }

theorem ofStructuredInputsAndSideConditions_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    ofStructuredInputsAndSideConditions inputs sideConditions =
      ofSubclaimsAndSideConditions inputs.theorem311Subclaims sideConditions :=
  rfl

def ofSubclaimsAndSideConditionHypotheses
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    IUTStage1SourceObligations package :=
  ofSubclaimsAndSideConditions subclaims hypotheses.toSideConditions

def ofStructuredInputsAndSideConditionHypotheses
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    IUTStage1SourceObligations package :=
  ofStructuredInputsAndSideConditions inputs hypotheses.toSideConditions

theorem ofStructuredInputsAndSideConditionHypotheses_eq_sideConditions
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ofStructuredInputsAndSideConditionHypotheses inputs hypotheses =
      ofStructuredInputsAndSideConditions inputs hypotheses.toSideConditions :=
  rfl

theorem ofStructuredInputsAndSideConditionHypotheses_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ofStructuredInputsAndSideConditionHypotheses inputs hypotheses =
      ofSubclaimsAndSideConditionHypotheses
        inputs.theorem311Subclaims hypotheses :=
  rfl

theorem ofSubclaimsAndSideConditionHypotheses_eq_sideConditions
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ofSubclaimsAndSideConditionHypotheses subclaims hypotheses =
      ofSubclaimsAndSideConditions subclaims hypotheses.toSideConditions :=
  rfl

end IUTStage1SourceObligations

/--
Named source-level gap below `IUTStage1SourceObligations`.

The fields use source-facing names for the mathematical work still needed to
turn a source package into a promoted source-obligation ledger.
-/
structure IUTStage1SourceObligationGap
    {source target : Copy} {index : Type u}
    (package : IUTStage1SourcePackage source target index) : Prop where
  theorem311_algorithm_certified : package.preLedger.output.Certified
  she_alignment :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she
  q_pilot_positive : 0 < -package.preLedger.qSigned
  source_normalization : package.preLedger.normalization

namespace IUTStage1SourceObligationGap

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem theorem311AlgorithmCertified
    (gap : IUTStage1SourceObligationGap package) :
    package.preLedger.output.Certified :=
  gap.theorem311_algorithm_certified

theorem sheAlignment
    (gap : IUTStage1SourceObligationGap package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  gap.she_alignment

theorem qPilotPositive
    (gap : IUTStage1SourceObligationGap package) :
    0 < -package.preLedger.qSigned :=
  gap.q_pilot_positive

theorem sourceNormalization
    (gap : IUTStage1SourceObligationGap package) :
    package.preLedger.normalization :=
  gap.source_normalization

def theorem311Subclaims
    (gap : IUTStage1SourceObligationGap package) :
    IUTStage1Theorem311Subclaims package :=
  { algorithm_output_certified := gap.theorem311AlgorithmCertified,
    hodge_theater_she_alignment := gap.sheAlignment }

def theorem311StructuredInputs
    (gap : IUTStage1SourceObligationGap package) :
    IUTStage1Theorem311StructuredInputs package :=
  { preledger_audit := package.preLedger.audit,
    theorem311_subclaims := gap.theorem311Subclaims }

theorem theorem311StructuredInputs_subclaims
    (gap : IUTStage1SourceObligationGap package) :
    gap.theorem311StructuredInputs.theorem311Subclaims =
      gap.theorem311Subclaims :=
  rfl

def sideConditions
    (gap : IUTStage1SourceObligationGap package) :
    IUTStage1SourceSideConditions package :=
  { q_pilot_positive := gap.qPilotPositive,
    source_normalization := gap.sourceNormalization }

def sideConditionHypotheses
    (gap : IUTStage1SourceObligationGap package) :
    IUTStage1SourceSideConditionHypotheses package :=
  IUTStage1SourceSideConditionHypotheses.ofSideConditions gap.sideConditions

def toSourceObligations
    (gap : IUTStage1SourceObligationGap package) :
    IUTStage1SourceObligations package :=
  { algorithm_certified := gap.theorem311AlgorithmCertified,
    she_arrow_matches_certificate := gap.sheAlignment,
    q_pilot_positive := gap.qPilotPositive,
    normalization := gap.sourceNormalization }

theorem toSourceObligations_eq_subclaimsAndSideConditions
    (gap : IUTStage1SourceObligationGap package) :
    gap.toSourceObligations =
      IUTStage1SourceObligations.ofSubclaimsAndSideConditions
        gap.theorem311Subclaims gap.sideConditions :=
  rfl

/--
Compact audit checklist for the source-level obligation gap.

This record gathers the four named source-gap projections before they are
promoted to `IUTStage1SourceObligations`.
-/
structure Audit
    (gap : IUTStage1SourceObligationGap package) : Prop where
  theorem311_algorithm_certified : package.preLedger.output.Certified
  she_alignment :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she
  q_pilot_positive : 0 < -package.preLedger.qSigned
  source_normalization : package.preLedger.normalization

theorem audit
    (gap : IUTStage1SourceObligationGap package) :
    Audit gap :=
  { theorem311_algorithm_certified := gap.theorem311AlgorithmCertified,
    she_alignment := gap.sheAlignment,
    q_pilot_positive := gap.qPilotPositive,
    source_normalization := gap.sourceNormalization }

namespace Audit

variable {gap : IUTStage1SourceObligationGap package}

theorem theorem311AlgorithmCertified
    (gapAudit : Audit gap) :
    package.preLedger.output.Certified :=
  gapAudit.theorem311_algorithm_certified

theorem sheAlignment
    (gapAudit : Audit gap) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  gapAudit.she_alignment

theorem qPilotPositive
    (gapAudit : Audit gap) :
    0 < -package.preLedger.qSigned :=
  gapAudit.q_pilot_positive

theorem sourceNormalization
    (gapAudit : Audit gap) :
    package.preLedger.normalization :=
  gapAudit.source_normalization

def theorem311Subclaims
    (gapAudit : Audit gap) :
    IUTStage1Theorem311Subclaims package :=
  { algorithm_output_certified := gapAudit.theorem311AlgorithmCertified,
    hodge_theater_she_alignment := gapAudit.sheAlignment }

def theorem311StructuredInputs
    (gapAudit : Audit gap) :
    IUTStage1Theorem311StructuredInputs package :=
  { preledger_audit := package.preLedger.audit,
    theorem311_subclaims := gapAudit.theorem311Subclaims }

theorem theorem311StructuredInputs_subclaims
    (gapAudit : Audit gap) :
    gapAudit.theorem311StructuredInputs.theorem311Subclaims =
      gapAudit.theorem311Subclaims :=
  rfl

def sideConditions
    (gapAudit : Audit gap) :
    IUTStage1SourceSideConditions package :=
  { q_pilot_positive := gapAudit.qPilotPositive,
    source_normalization := gapAudit.sourceNormalization }

def sideConditionHypotheses
    (gapAudit : Audit gap) :
    IUTStage1SourceSideConditionHypotheses package :=
  IUTStage1SourceSideConditionHypotheses.ofSideConditions
    gapAudit.sideConditions

def toSourceObligations
    (gapAudit : Audit gap) :
    IUTStage1SourceObligations package :=
  { algorithm_certified := gapAudit.theorem311AlgorithmCertified,
    she_arrow_matches_certificate := gapAudit.sheAlignment,
    q_pilot_positive := gapAudit.qPilotPositive,
    normalization := gapAudit.sourceNormalization }

theorem toSourceObligations_eq_subclaimsAndSideConditions
    (gapAudit : Audit gap) :
    gapAudit.toSourceObligations =
      IUTStage1SourceObligations.ofSubclaimsAndSideConditions
        gapAudit.theorem311Subclaims gapAudit.sideConditions :=
  rfl

theorem toSourceObligations_eq_gap
    (gapAudit : Audit gap) :
    gapAudit.toSourceObligations = gap.toSourceObligations :=
  Subsingleton.elim _ _

theorem canonical_toSourceObligations
    (gap : IUTStage1SourceObligationGap package) :
    (gap.audit).toSourceObligations = gap.toSourceObligations :=
  Subsingleton.elim _ _

end Audit

end IUTStage1SourceObligationGap

namespace IUTStage1SourceObligations

variable {source target : Copy} {index : Type u}
variable {package : IUTStage1SourcePackage source target index}

theorem algorithmCertified
    (obligations : IUTStage1SourceObligations package) :
    package.preLedger.output.Certified :=
  obligations.algorithm_certified

theorem sheArrowMatchesCertificate
    (obligations : IUTStage1SourceObligations package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  obligations.she_arrow_matches_certificate

theorem qPilotPositive
    (obligations : IUTStage1SourceObligations package) :
    0 < -package.preLedger.qSigned :=
  obligations.q_pilot_positive

theorem sourceNormalization
    (obligations : IUTStage1SourceObligations package) :
    package.preLedger.normalization :=
  obligations.normalization

def toLedgerPromotionObligations
    (obligations : IUTStage1SourceObligations package) :
    package.preLedger.LedgerPromotionObligations :=
  { certified := obligations.algorithmCertified,
    she_matches_certificate := obligations.sheArrowMatchesCertificate,
    q_positive := obligations.qPilotPositive,
    normalization_proof := obligations.sourceNormalization }

end IUTStage1SourceObligations

namespace IUTStage1SourcePackage

variable {source target : Copy} {index : Type u}

def promotedLedger
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    SourceObligationLedger
      package.preLedger.output
      package.preLedger.measure
      package.preLedger.thetaSigned
      package.preLedger.qSigned
      package.preLedger.normalization :=
  package.preLedger.promotedLedger obligations.toLedgerPromotionObligations

def promotedProvider
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    IUTSourceObligationProvider
      package.preLedger.output
      package.preLedger.measure
      package.preLedger.thetaSigned
      package.preLedger.qSigned
      package.preLedger.normalization :=
  package.preLedger.promotedProvider obligations.toLedgerPromotionObligations

theorem promotedProvider_ledger
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.promotedProvider obligations).ledger =
      package.promotedLedger obligations :=
  package.preLedger.promotedProvider_ledger obligations.toLedgerPromotionObligations

def comparisonPayloadInputs
    (package : IUTStage1SourcePackage source target index) :
    package.preLedger.ComparisonPayloadInputs :=
  package.preLedger.comparisonPayloadInputs

theorem comparisonPayloadInputs_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  package.comparisonPayloadInputs.qSignedLeThetaSigned

theorem comparisonPayloadInputs_thetaChartTrivial
    (package : IUTStage1SourcePackage source target index) :
    Transport.TrivialMonodromy
      package.preLedger.chartedContainer.chart.thetaToTarget :=
  package.comparisonPayloadInputs.thetaChartTrivial

theorem comparisonPayloadInputs_qCharted
    (package : IUTStage1SourcePackage source target index) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  package.comparisonPayloadInputs.qCharted

theorem comparisonPayloadInputs_thetaCharted
    (package : IUTStage1SourcePackage source target index) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  package.comparisonPayloadInputs.thetaCharted

theorem comparisonPayloadInputs_chosenHolds
    (package : IUTStage1SourcePackage source target index) :
    package.preLedger.chosenOutput.comparison.Holds
      package.preLedger.qValue.qPoint :=
  package.comparisonPayloadInputs.chosenHolds

theorem comparisonPayloadInputs_qSigned_le_targetSigned
    (package : IUTStage1SourcePackage source target index) :
    package.preLedger.qSigned <=
      package.preLedger.targetVolume.targetSigned :=
  package.comparisonPayloadInputs.qSignedLeTargetSigned

theorem comparisonPayloadInputs_targetSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  package.comparisonPayloadInputs.targetSignedLeThetaSigned

def comparisonDataFromPayloadInputs
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    Corollary312ComparisonData :=
  package.comparisonPayloadInputs.comparisonData obligations.qPilotPositive

theorem comparisonDataFromPayloadInputs_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonDataFromPayloadInputs obligations).thetaSigned =
      package.preLedger.thetaSigned :=
  rfl

theorem comparisonDataFromPayloadInputs_qSigned
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonDataFromPayloadInputs obligations).qSigned =
      package.preLedger.qSigned :=
  rfl

theorem comparisonDataFromPayloadInputs_corollary312
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  package.comparisonPayloadInputs.comparisonData_corollary312
    obligations.qPilotPositive

def comparisonData
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    Corollary312ComparisonData :=
  (package.promotedProvider obligations).comparisonData

theorem comparisonDataFromPayloadInputs_eq_comparisonData
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    package.comparisonDataFromPayloadInputs obligations =
      package.comparisonData obligations := by
  simp [comparisonDataFromPayloadInputs, comparisonData,
    IUTSourceObligationProvider.comparisonData, SourceObligationLedger.comparisonData,
    IUTStage1PreLedgerData.ComparisonPayloadInputs.comparisonData]

theorem comparisonDataFromPayloadInputs_stage1Comparison_eq
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonDataFromPayloadInputs obligations).stage1Comparison =
      (package.comparisonData obligations).stage1Comparison := by
  rw [package.comparisonDataFromPayloadInputs_eq_comparisonData obligations]

theorem comparisonDataFromPayloadInputs_corollary312_eq
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonDataFromPayloadInputs obligations).corollary312 =
      (package.comparisonData obligations).corollary312 :=
  Subsingleton.elim _ _

def auditedComparisonSourceObligations
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1SourceObligations package :=
  IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
    bundle.inputs sideConditions

theorem auditedComparisonData_eq_payloadInputs
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    bundle.auditedComparisonData sideConditions =
      package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations
          bundle sideConditions) := by
  simp [IUTStage1Theorem311StructuredInputsWithSHE.auditedComparisonData,
    IUTStage1Theorem311AuditedSignedPayloadBoundary.comparisonData,
    IUTStage1SourcePackage.comparisonDataFromPayloadInputs,
    IUTStage1PreLedgerData.ComparisonPayloadInputs.comparisonData]

theorem auditedComparisonData_stage1Comparison_eq_payloadInputs
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    (bundle.auditedComparisonData sideConditions).stage1Comparison =
      (package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations
          bundle sideConditions)).stage1Comparison := by
  rw [package.auditedComparisonData_eq_payloadInputs bundle sideConditions]

/--
Public-audit view exposed through the audited Theorem 3.11 route.

This is a consistency wrapper, not a new endpoint. It keeps the signed payload
boundary and the equality with the existing payload-input route visible while
reusing `Corollary312ComparisonData.publicAudit`.
-/
structure AuditedPublicAudit
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  signed_payload_boundary :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions
  comparison_data_eq_payload_inputs :
    bundle.auditedComparisonData sideConditions =
      package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations bundle sideConditions)
  q_signed_le_theta :
    (bundle.auditedComparisonData sideConditions).qSigned <=
      (bundle.auditedComparisonData sideConditions).thetaSigned
  corollary312 :
    Corollary312Inequality
      (bundle.auditedComparisonData sideConditions).thetaPilot
      (bundle.auditedComparisonData sideConditions).qPilot
  stage_recovers_q_signed_le_theta :
    corollary312_from_stage1_comparison
        (bundle.auditedComparisonData sideConditions).stage1Comparison =
      corollary312_of_signed_le
        (bundle.auditedComparisonData
          sideConditions).qSigned_le_thetaSigned
  stage_comparison_eq_payload_inputs :
    (bundle.auditedComparisonData sideConditions).stage1Comparison =
      (package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations
          bundle sideConditions)).stage1Comparison
  theta_chart_trivial :
    Transport.TrivialMonodromy
      package.preLedger.chartedContainer.chart.thetaToTarget
  q_charted :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned
  theta_charted :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned
  source_normalization : package.preLedger.normalization
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace AuditedPublicAudit

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedPublicAudit package bundle sideConditions :=
  { signed_payload_boundary :=
      bundle.auditedSignedPayloadBoundary sideConditions,
    comparison_data_eq_payload_inputs :=
      package.auditedComparisonData_eq_payloadInputs bundle sideConditions,
    q_signed_le_theta :=
      (bundle.auditedComparisonData sideConditions).publicAudit_qSigned_le_thetaSigned,
    corollary312 :=
      (bundle.auditedComparisonData sideConditions).publicAudit_corollary312,
    stage_recovers_q_signed_le_theta :=
      (bundle.auditedComparisonData
        sideConditions).publicAudit_stage1Comparison_recovers,
    stage_comparison_eq_payload_inputs :=
      package.auditedComparisonData_stage1Comparison_eq_payloadInputs
        bundle sideConditions,
    theta_chart_trivial :=
      (bundle.auditedSignedPayloadBoundary sideConditions).thetaChartTrivial,
    q_charted :=
      (bundle.auditedSignedPayloadBoundary sideConditions).qCharted,
    theta_charted :=
      (bundle.auditedSignedPayloadBoundary sideConditions).thetaCharted,
    source_normalization :=
      (bundle.auditedSignedPayloadBoundary sideConditions).sourceNormalization,
    histories_not_identified :=
      (bundle.auditedSignedPayloadBoundary
        sideConditions).domainHistory_ne_codomainHistory }

theorem qSigned_le_thetaSigned
    (audit : AuditedPublicAudit package bundle sideConditions) :
    (bundle.auditedComparisonData sideConditions).qSigned <=
      (bundle.auditedComparisonData sideConditions).thetaSigned :=
  audit.q_signed_le_theta

theorem corollary312Endpoint
    (audit : AuditedPublicAudit package bundle sideConditions) :
    Corollary312Inequality
      (bundle.auditedComparisonData sideConditions).thetaPilot
      (bundle.auditedComparisonData sideConditions).qPilot :=
  audit.corollary312

theorem publicAudit
    (audit : AuditedPublicAudit package bundle sideConditions) :
    (bundle.auditedComparisonData sideConditions).qSigned <=
        (bundle.auditedComparisonData sideConditions).thetaSigned ∧
      Corollary312Inequality
        (bundle.auditedComparisonData sideConditions).thetaPilot
        (bundle.auditedComparisonData sideConditions).qPilot ∧
      corollary312_from_stage1_comparison
          (bundle.auditedComparisonData sideConditions).stage1Comparison =
        corollary312_of_signed_le
          (bundle.auditedComparisonData
            sideConditions).qSigned_le_thetaSigned :=
  ⟨audit.qSigned_le_thetaSigned, audit.corollary312Endpoint,
    audit.stage_recovers_q_signed_le_theta⟩

theorem comparisonDataEqPayloadInputs
    (audit : AuditedPublicAudit package bundle sideConditions) :
    bundle.auditedComparisonData sideConditions =
      package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations bundle sideConditions) :=
  audit.comparison_data_eq_payload_inputs

theorem sourceNormalization
    (audit : AuditedPublicAudit package bundle sideConditions) :
    package.preLedger.normalization :=
  audit.source_normalization

theorem thetaChartTrivial
    (audit : AuditedPublicAudit package bundle sideConditions) :
    Transport.TrivialMonodromy
      package.preLedger.chartedContainer.chart.thetaToTarget :=
  audit.theta_chart_trivial

theorem qCharted
    (audit : AuditedPublicAudit package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned :=
  audit.q_charted

theorem thetaCharted
    (audit : AuditedPublicAudit package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  audit.theta_charted

theorem domainHistory_ne_codomainHistory
    (audit : AuditedPublicAudit package bundle sideConditions) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  audit.histories_not_identified

end AuditedPublicAudit

theorem auditedPublicAudit
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedPublicAudit package bundle sideConditions :=
  AuditedPublicAudit.ofStructuredInputsWithSHE bundle sideConditions

/--
Audit object pairing the real-line chart readings with the non-identification
of Hodge-theater histories.

This is not a new comparison endpoint. It records the discipline needed around
the final common-target reading: q and Theta are charted into the target real
copy, while the domain and codomain Hodge-theater histories remain distinct.
-/
structure AuditedChartHistoryDiscipline
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  public_audit : AuditedPublicAudit package bundle sideConditions
  theta_chart_trivial :
    Transport.TrivialMonodromy
      package.preLedger.chartedContainer.chart.thetaToTarget
  q_charted :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned
  theta_charted :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned
  common_container_context_matches :
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace AuditedChartHistoryDiscipline

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedChartHistoryDiscipline package bundle sideConditions :=
  { public_audit := package.auditedPublicAudit bundle sideConditions,
    theta_chart_trivial :=
      (package.auditedPublicAudit bundle sideConditions).thetaChartTrivial,
    q_charted := (package.auditedPublicAudit bundle sideConditions).qCharted,
    theta_charted :=
      (package.auditedPublicAudit bundle sideConditions).thetaCharted,
    common_container_context_matches := bundle.commonContainerContextMatches,
    histories_not_identified := bundle.domainHistory_ne_codomainHistory }

theorem publicAudit
    (discipline :
      AuditedChartHistoryDiscipline package bundle sideConditions) :
    AuditedPublicAudit package bundle sideConditions :=
  discipline.public_audit

theorem qCharted
    (discipline :
      AuditedChartHistoryDiscipline package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned :=
  discipline.q_charted

theorem thetaCharted
    (discipline :
      AuditedChartHistoryDiscipline package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  discipline.theta_charted

theorem commonContainerContextMatches
    (discipline :
      AuditedChartHistoryDiscipline package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext :=
  discipline.common_container_context_matches

theorem domainHistory_ne_codomainHistory
    (discipline :
      AuditedChartHistoryDiscipline package bundle sideConditions) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  discipline.histories_not_identified

end AuditedChartHistoryDiscipline

theorem auditedChartHistoryDiscipline
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedChartHistoryDiscipline package bundle sideConditions :=
  AuditedChartHistoryDiscipline.ofStructuredInputsWithSHE bundle sideConditions

/--
Semantic wrapper for the allowed chart readings and the forbidden
Hodge-history identification.

The allowed operations are the q- and Theta-side readings through the named
real-comparison chart. The forbidden operation is identifying the domain and
codomain Hodge-theater histories. This record is derived from
`AuditedChartHistoryDiscipline`; it does not add new assumptions.
-/
structure AuditedAllowedChartTransport
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  chart_history_discipline :
    AuditedChartHistoryDiscipline package bundle sideConditions
  chart_transport_discipline :
    package.preLedger.chartedContainer.chart.TransportDiscipline
  allowed_q_to_target_reading :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned
  allowed_theta_to_target_reading :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned
  theta_target_transport_trivial :
    Transport.TrivialMonodromy
      package.preLedger.chartedContainer.chart.thetaToTarget
  forbidden_history_identification :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace AuditedAllowedChartTransport

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofChartHistoryDiscipline
    (discipline :
      AuditedChartHistoryDiscipline package bundle sideConditions) :
    AuditedAllowedChartTransport package bundle sideConditions :=
  { chart_history_discipline := discipline,
    chart_transport_discipline :=
      package.preLedger.chartedContainer.chart.transportDiscipline,
    allowed_q_to_target_reading := discipline.qCharted,
    allowed_theta_to_target_reading := discipline.thetaCharted,
    theta_target_transport_trivial := discipline.publicAudit.thetaChartTrivial,
    forbidden_history_identification :=
      discipline.domainHistory_ne_codomainHistory }

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedAllowedChartTransport package bundle sideConditions :=
  ofChartHistoryDiscipline
    (package.auditedChartHistoryDiscipline bundle sideConditions)

theorem chartHistoryDiscipline
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    AuditedChartHistoryDiscipline package bundle sideConditions :=
  transport.chart_history_discipline

theorem chartTransportDiscipline
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    package.preLedger.chartedContainer.chart.TransportDiscipline :=
  transport.chart_transport_discipline

theorem qToTargetAllowedAtChart
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    package.preLedger.chartedContainer.chart.QToTargetAllowedReading :=
  transport.chartTransportDiscipline.q_to_target_allowed

theorem thetaToTargetAllowedAtChart
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    package.preLedger.chartedContainer.chart.ThetaToTargetAllowedReading :=
  transport.chartTransportDiscipline.theta_to_target_allowed

theorem allowedQToTargetReading
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned :=
  transport.allowed_q_to_target_reading

theorem allowedThetaToTargetReading
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  transport.allowed_theta_to_target_reading

theorem forbiddenHistoryIdentification
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  transport.forbidden_history_identification

end AuditedAllowedChartTransport

theorem auditedAllowedChartTransport
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedAllowedChartTransport package bundle sideConditions :=
  AuditedAllowedChartTransport.ofStructuredInputsWithSHE bundle sideConditions

/--
Audit object tying the q-pilot sign condition to the charted q-side reading.

The sign condition in the final payload is about `preLedger.qSigned`; this
record keeps the proof that `qSigned` is the real obtained by applying the
q-to-target chart to the q-side point.
-/
structure AuditedQPilotChartSign
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  allowed_chart_transport :
    AuditedAllowedChartTransport package bundle sideConditions
  q_charted :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned
  q_pilot_positive : 0 < -package.preLedger.qSigned
  charted_q_pilot_positive :
    0 < -
      (Transport.map package.preLedger.chartedContainer.chart.qToTarget
        package.preLedger.qValue.qPoint).coord

namespace AuditedQPilotChartSign

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofAllowedChartTransport
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    AuditedQPilotChartSign package bundle sideConditions :=
  { allowed_chart_transport := transport,
    q_charted := transport.allowedQToTargetReading,
    q_pilot_positive := sideConditions.qPilotPositive,
    charted_q_pilot_positive := by
      rw [transport.allowedQToTargetReading]
      exact sideConditions.qPilotPositive }

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedQPilotChartSign package bundle sideConditions :=
  ofAllowedChartTransport
    (package.auditedAllowedChartTransport bundle sideConditions)

theorem allowedChartTransport
    (audit : AuditedQPilotChartSign package bundle sideConditions) :
    AuditedAllowedChartTransport package bundle sideConditions :=
  audit.allowed_chart_transport

theorem qCharted
    (audit : AuditedQPilotChartSign package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned :=
  audit.q_charted

theorem qPilotPositive
    (audit : AuditedQPilotChartSign package bundle sideConditions) :
    0 < -package.preLedger.qSigned :=
  audit.q_pilot_positive

theorem chartedQPilotPositive
    (audit : AuditedQPilotChartSign package bundle sideConditions) :
    0 < -
      (Transport.map package.preLedger.chartedContainer.chart.qToTarget
        package.preLedger.qValue.qPoint).coord :=
  audit.charted_q_pilot_positive

end AuditedQPilotChartSign

theorem auditedQPilotChartSign
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedQPilotChartSign package bundle sideConditions :=
  AuditedQPilotChartSign.ofStructuredInputsWithSHE bundle sideConditions

/--
Audit object tying the Theta-side target bound to the charted Theta reading.

The HDD-after-SHE route bounds the chosen target volume by `thetaSigned`; this
record keeps the proof that `thetaSigned` is the real obtained from the
Theta-side charted point.
-/
structure AuditedThetaChartBound
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  allowed_chart_transport :
    AuditedAllowedChartTransport package bundle sideConditions
  hdd_she_bound :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle
  theta_charted :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned
  chosen_target_volume_le_theta :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned
  chosen_target_volume_le_charted_theta :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord

namespace AuditedThetaChartBound

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofAllowedChartTransport
    (transport :
      AuditedAllowedChartTransport package bundle sideConditions) :
    AuditedThetaChartBound package bundle sideConditions :=
  { allowed_chart_transport := transport,
    hdd_she_bound := bundle.auditedHDDSHEBound,
    theta_charted := transport.allowedThetaToTargetReading,
    chosen_target_volume_le_theta :=
      bundle.auditedHDDSHEBound.chosenTargetVolume_le_theta,
    chosen_target_volume_le_charted_theta := by
      rw [transport.allowedThetaToTargetReading]
      exact bundle.auditedHDDSHEBound.chosenTargetVolume_le_theta }

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedThetaChartBound package bundle sideConditions :=
  ofAllowedChartTransport
    (package.auditedAllowedChartTransport bundle sideConditions)

theorem allowedChartTransport
    (audit : AuditedThetaChartBound package bundle sideConditions) :
    AuditedAllowedChartTransport package bundle sideConditions :=
  audit.allowed_chart_transport

theorem hddSHEBound
    (audit : AuditedThetaChartBound package bundle sideConditions) :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  audit.hdd_she_bound

theorem thetaCharted
    (audit : AuditedThetaChartBound package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  audit.theta_charted

theorem chosenTargetVolume_le_theta
    (audit : AuditedThetaChartBound package bundle sideConditions) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned :=
  audit.chosen_target_volume_le_theta

theorem chosenTargetVolume_le_chartedTheta
    (audit : AuditedThetaChartBound package bundle sideConditions) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  audit.chosen_target_volume_le_charted_theta

end AuditedThetaChartBound

theorem auditedThetaChartBound
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedThetaChartBound package bundle sideConditions :=
  AuditedThetaChartBound.ofStructuredInputsWithSHE bundle sideConditions

/--
Audit object for the final inequality stated directly between charted q and
charted Theta readings.

This is the charted version of the raw `qSigned <= thetaSigned` comparison.
It keeps both chart equations in the proof boundary.
-/
structure AuditedChartedComparisonBoundary
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  q_pilot_chart_sign :
    AuditedQPilotChartSign package bundle sideConditions
  theta_chart_bound :
    AuditedThetaChartBound package bundle sideConditions
  preledger_charted_chain :
    package.preLedger.ChartedComparisonChain
  raw_inequality :
    IUTStage1Theorem311AuditedRawInequality package bundle
  q_signed_le_theta :
    package.preLedger.qSigned <= package.preLedger.thetaSigned
  charted_q_le_charted_theta :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord

namespace AuditedChartedComparisonBoundary

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofChartAudits
    (qAudit : AuditedQPilotChartSign package bundle sideConditions)
    (thetaAudit : AuditedThetaChartBound package bundle sideConditions) :
    AuditedChartedComparisonBoundary package bundle sideConditions :=
  { q_pilot_chart_sign := qAudit,
    theta_chart_bound := thetaAudit,
    preledger_charted_chain := package.preLedger.chartedComparisonChain,
    raw_inequality := bundle.auditedRawInequality,
    q_signed_le_theta := bundle.auditedRawInequality.qSigned_le_thetaSigned,
    charted_q_le_charted_theta :=
      package.preLedger.chartedComparisonChain.chartedQ_le_chartedTheta }

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedChartedComparisonBoundary package bundle sideConditions :=
  ofChartAudits
    (package.auditedQPilotChartSign bundle sideConditions)
    (package.auditedThetaChartBound bundle sideConditions)

theorem qPilotChartSign
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    AuditedQPilotChartSign package bundle sideConditions :=
  boundary.q_pilot_chart_sign

theorem thetaChartBound
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    AuditedThetaChartBound package bundle sideConditions :=
  boundary.theta_chart_bound

theorem hddSHEBound
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  boundary.theta_chart_bound.hddSHEBound

theorem hddSHECommonContainerCompatibility
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE :=
  boundary.hddSHEBound.commonContainerCompatibility

theorem hddSHECommonContainerBoundAudit
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.BoundAudit
      package.preLedger.certificate :=
  boundary.hddSHEBound.commonContainerBoundAudit

theorem hddSHEDecompositionAudit
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.hddShe.DecompositionAudit
      package.preLedger.certificate :=
  boundary.hddSHEBound.hddSHEDecompositionAudit

theorem hddDecompositionAudit
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.hddShe.hdd.DecompositionAudit
      package.preLedger.certificate :=
  boundary.hddSHEBound.hddDecompositionAudit

theorem hullDetBoundAudit
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge.BoundAudit
      package.preLedger.certificate :=
  boundary.hddSHEBound.hullDetBoundAudit

theorem hddSHESHEArrowMatchesContext
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      bundle.structuredSHE.context.sheDatum :=
  boundary.hddSHEBound.sheArrowMatchesContext

theorem hddSHESHEDatumMatchesCertificate
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    bundle.structuredSHE.context.sheDatum =
      package.preLedger.certificate.she :=
  boundary.hddSHEBound.sheDatumMatchesCertificate

theorem hddSHESHEArrowDatumMatchesCertificate
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  boundary.hddSHEBound.sheArrowDatumMatchesCertificate

theorem hddSHECommonContainerContextMatches
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext :=
  boundary.hddSHEBound.commonContainerContextMatches

theorem hddSHEQPilotTheater_eq_codomain
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    bundle.structuredSHE.context.qPilotStructure.theater =
      bundle.structuredSHE.context.codomainStructure.theater :=
  boundary.hddSHEBound.qPilotTheater_eq_codomain

theorem hddSHEThetaPilotTheater_eq_domain
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    bundle.structuredSHE.context.thetaPilotStructure.theater =
      bundle.structuredSHE.context.domainStructure.theater :=
  boundary.hddSHEBound.thetaPilotTheater_eq_domain

theorem hddSHELocalExpressionValid
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    bundle.structuredSHE.context.simultaneousExpression.AllLocalValid :=
  boundary.hddSHEBound.localExpressionValid

theorem hddSHEChosenTargetVolume_le_theta
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned :=
  boundary.hddSHEBound.chosenTargetVolume_le_theta

theorem hddSHEAllTargetsAtMost_theta
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  boundary.hddSHEBound.allTargetsAtMost_theta

theorem hddSHEDomainHistory_ne_codomainHistory
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  boundary.hddSHEBound.domainHistory_ne_codomainHistory

theorem preLedgerChartedChain
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.ChartedComparisonChain :=
  boundary.preledger_charted_chain

theorem qChartTransport_eq_comparisonTransport
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chartedContainer.chart.qToTarget =
      package.preLedger.chosenOutput.comparison.transport :=
  boundary.preledger_charted_chain.qChartTransport_eq_comparisonTransport

theorem membershipVolumeControl
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.chosenOutput.comparison.MembershipControlsTargetVolume
      package.preLedger.measure :=
  boundary.preledger_charted_chain.membershipVolumeControl

theorem targetSigned_eq_choiceTargetVolume
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) :=
  boundary.preledger_charted_chain.targetSigned_eq_choiceTargetVolume

theorem choiceTargetVolume_le_thetaSigned
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned :=
  boundary.preledger_charted_chain.choiceTargetVolume_le_thetaSigned

theorem qSigned_le_thetaSigned
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  boundary.q_signed_le_theta

theorem chartedQ_le_chartedTheta
    (boundary :
      AuditedChartedComparisonBoundary package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  boundary.charted_q_le_charted_theta

end AuditedChartedComparisonBoundary

theorem auditedChartedComparisonBoundary
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedChartedComparisonBoundary package bundle sideConditions :=
  AuditedChartedComparisonBoundary.ofStructuredInputsWithSHE bundle sideConditions

/--
Compact checkpoint summary for the audited structured-SHE route.

The summary is proof-only: it does not create a new endpoint or hide any
construction. It records that the major audited checkpoints are simultaneously
available for the same package, structured-SHE bundle, and side conditions.
-/
structure AuditedStructuredSHERouteSummary
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  has_structured_she :
    QualitativeData.HasStructuredSHE package.preLedger.output.family
  common_container_compatibility :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE
  hdd_she_bound : IUTStage1Theorem311AuditedHDDSHEBound package bundle
  target_volume_middle :
    IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle
  membership_middle :
    IUTStage1Theorem311AuditedMembershipMiddle package bundle
  raw_inequality :
    IUTStage1Theorem311AuditedRawInequality package bundle
  signed_payload_boundary :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions
  charted_comparison_boundary :
    AuditedChartedComparisonBoundary package bundle sideConditions
  public_audit : AuditedPublicAudit package bundle sideConditions
  comparison_data_eq_payload_inputs :
    bundle.auditedComparisonData sideConditions =
      package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations bundle sideConditions)
  q_signed_le_theta :
    (bundle.auditedComparisonData sideConditions).qSigned <=
      (bundle.auditedComparisonData sideConditions).thetaSigned
  source_normalization : package.preLedger.normalization
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace AuditedStructuredSHERouteSummary

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedStructuredSHERouteSummary package bundle sideConditions :=
  { has_structured_she := bundle.hasStructuredSHE_from_context,
    common_container_compatibility := bundle.commonContainerCompatibility,
    hdd_she_bound := bundle.auditedHDDSHEBound,
    target_volume_middle := bundle.auditedTargetVolumeMiddle,
    membership_middle := bundle.auditedMembershipMiddle,
    raw_inequality := bundle.auditedRawInequality,
    signed_payload_boundary :=
      bundle.auditedSignedPayloadBoundary sideConditions,
    charted_comparison_boundary :=
      package.auditedChartedComparisonBoundary bundle sideConditions,
    public_audit := package.auditedPublicAudit bundle sideConditions,
    comparison_data_eq_payload_inputs :=
      package.auditedComparisonData_eq_payloadInputs bundle sideConditions,
    q_signed_le_theta :=
      (package.auditedPublicAudit bundle sideConditions).qSigned_le_thetaSigned,
    source_normalization := sideConditions.sourceNormalization,
    histories_not_identified := bundle.domainHistory_ne_codomainHistory }

theorem publicAudit
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    AuditedPublicAudit package bundle sideConditions :=
  summary.public_audit

theorem signedPayloadBoundary
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions :=
  summary.signed_payload_boundary

theorem rawInequality
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  summary.raw_inequality

theorem chartedComparisonBoundary
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    AuditedChartedComparisonBoundary package bundle sideConditions :=
  summary.charted_comparison_boundary

theorem chartedQ_le_chartedTheta
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  summary.charted_comparison_boundary.chartedQ_le_chartedTheta

theorem comparisonDataEqPayloadInputs
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    bundle.auditedComparisonData sideConditions =
      package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations bundle sideConditions) :=
  summary.comparison_data_eq_payload_inputs

theorem qSigned_le_thetaSigned
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    (bundle.auditedComparisonData sideConditions).qSigned <=
      (bundle.auditedComparisonData sideConditions).thetaSigned :=
  summary.q_signed_le_theta

theorem sourceNormalization
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    package.preLedger.normalization :=
  summary.source_normalization

theorem domainHistory_ne_codomainHistory
    (summary :
      AuditedStructuredSHERouteSummary package bundle sideConditions) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  summary.histories_not_identified

end AuditedStructuredSHERouteSummary

theorem auditedStructuredSHERouteSummary
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedStructuredSHERouteSummary package bundle sideConditions :=
  AuditedStructuredSHERouteSummary.ofStructuredInputsWithSHE
    bundle sideConditions

/--
Named checkpoints for the audited Theorem 3.11 to Corollary 3.12 route.

This record connects the proof-level audit route to the source-facing names used
for the debated transition: the fourth-triangle `HDD o SHE` step, the
simultaneous common-container comparison, and the final signed payload boundary.
-/
structure AuditedTheorem311ToCorollary312Checkpoints
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) : Prop where
  route_summary :
    AuditedStructuredSHERouteSummary package bundle sideConditions
  theorem311_input_label : package.input = package.labels.input
  corollary312_comparison_label :
    package.logVolumeComparison = package.labels.logVolumeComparison
  fourth_triangle_hdd_she :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle
  simultaneous_common_container :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE
  target_volume_chain :
    IUTStage1Theorem311AuditedRawInequality package bundle
  signed_payload_boundary :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions
  charted_comparison_boundary :
    AuditedChartedComparisonBoundary package bundle sideConditions
  public_audit : AuditedPublicAudit package bundle sideConditions
  histories_not_identified :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side

namespace AuditedTheorem311ToCorollary312Checkpoints

variable {package : IUTStage1SourcePackage source target index}
variable {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
variable {sideConditions : IUTStage1SourceSideConditions package}

theorem ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedTheorem311ToCorollary312Checkpoints
      package bundle sideConditions :=
  { route_summary :=
      package.auditedStructuredSHERouteSummary bundle sideConditions,
    theorem311_input_label := package.input_matches_labels,
    corollary312_comparison_label :=
      package.logVolumeComparison_matches_labels,
    fourth_triangle_hdd_she := bundle.auditedHDDSHEBound,
    simultaneous_common_container := bundle.commonContainerCompatibility,
    target_volume_chain := bundle.auditedRawInequality,
    signed_payload_boundary :=
      bundle.auditedSignedPayloadBoundary sideConditions,
    charted_comparison_boundary :=
      package.auditedChartedComparisonBoundary bundle sideConditions,
    public_audit := package.auditedPublicAudit bundle sideConditions,
    histories_not_identified := bundle.domainHistory_ne_codomainHistory }

theorem routeSummary
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    AuditedStructuredSHERouteSummary package bundle sideConditions :=
  checkpoints.route_summary

theorem theorem311InputLabel
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    package.input = package.labels.input :=
  checkpoints.theorem311_input_label

theorem corollary312ComparisonLabel
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    package.logVolumeComparison = package.labels.logVolumeComparison :=
  checkpoints.corollary312_comparison_label

theorem fourthTriangleHDDSHE
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  checkpoints.fourth_triangle_hdd_she

theorem simultaneousCommonContainer
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE :=
  checkpoints.simultaneous_common_container

theorem targetVolumeChain
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  checkpoints.target_volume_chain

theorem signedPayloadBoundary
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions :=
  checkpoints.signed_payload_boundary

theorem chartedComparisonBoundary
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    AuditedChartedComparisonBoundary package bundle sideConditions :=
  checkpoints.charted_comparison_boundary

theorem chartedQ_le_chartedTheta
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  checkpoints.charted_comparison_boundary.chartedQ_le_chartedTheta

theorem publicAudit
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    AuditedPublicAudit package bundle sideConditions :=
  checkpoints.public_audit

theorem domainHistory_ne_codomainHistory
    (checkpoints :
      AuditedTheorem311ToCorollary312Checkpoints
        package bundle sideConditions) :
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  checkpoints.histories_not_identified

end AuditedTheorem311ToCorollary312Checkpoints

theorem auditedTheorem311ToCorollary312Checkpoints
    (package : IUTStage1SourcePackage source target index)
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    AuditedTheorem311ToCorollary312Checkpoints
      package bundle sideConditions :=
  AuditedTheorem311ToCorollary312Checkpoints.ofStructuredInputsWithSHE
    bundle sideConditions

theorem comparisonData_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonData obligations).thetaSigned =
      package.preLedger.thetaSigned :=
  rfl

theorem comparisonData_qSigned
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonData obligations).qSigned =
      package.preLedger.qSigned :=
  rfl

theorem comparisonData_stage1Comparison_eq
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonData obligations).stage1Comparison =
      (package.promotedProvider obligations).stage1Comparison :=
  rfl

theorem comparisonData_corollary312_eq
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    (package.comparisonData obligations).corollary312 =
      (package.promotedProvider obligations).corollary312 :=
  rfl

theorem publicAudit
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
      Corollary312Inequality
        (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
        (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
      (corollary312_from_stage1_comparison
          (package.promotedProvider obligations).stage1Comparison =
        corollary312_of_signed_le
          (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned) :=
  package.preLedger.publicAudit obligations.toLedgerPromotionObligations

theorem publicAudit_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  (package.publicAudit obligations).1

theorem publicAudit_corollary312
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (package.publicAudit obligations).2.1

theorem publicAudit_stage1Comparison_recovers_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    corollary312_from_stage1_comparison
        (package.promotedProvider obligations).stage1Comparison =
      corollary312_of_signed_le
        (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned :=
  (package.publicAudit obligations).2.2

def comparisonDataOfHullDetObligations
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) :
    Corollary312ComparisonData :=
  package.comparisonData obligations.toSourceObligations

theorem comparisonDataOfHullDetObligations_eq
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) :
    package.comparisonDataOfHullDetObligations obligations =
      package.comparisonData obligations.toSourceObligations :=
  rfl

theorem comparisonDataOfHullDetObligations_corollary312
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (package.comparisonDataOfHullDetObligations obligations).corollary312

theorem publicAuditOfHullDetObligations
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
      Corollary312Inequality
        (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
        (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
      (corollary312_from_stage1_comparison
          (package.promotedProvider
            obligations.toSourceObligations).stage1Comparison =
        corollary312_of_signed_le
          (package.promotedProvider
            obligations.toSourceObligations).ledger.qSigned_le_thetaSigned) :=
  package.publicAudit obligations.toSourceObligations

theorem publicAuditOfHullDetObligations_corollary312
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (package.publicAuditOfHullDetObligations obligations).2.1

def obligationsFromParts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1SourceObligations package :=
  IUTStage1SourceObligations.ofSubclaimsAndSideConditions
    subclaims sideConditions

def obligationsFromHypotheses
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    IUTStage1SourceObligations package :=
  package.obligationsFromParts subclaims hypotheses.toSideConditions

theorem obligationsFromHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.obligationsFromHypotheses subclaims hypotheses =
      package.obligationsFromParts subclaims hypotheses.toSideConditions :=
  rfl

theorem obligationsFromHypotheses_eq_ofHypotheses
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.obligationsFromHypotheses subclaims hypotheses =
      IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
        subclaims hypotheses :=
  rfl

def obligationsFromStructuredInputs
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    IUTStage1SourceObligations package :=
  IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
    inputs sideConditions

theorem obligationsFromStructuredInputs_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.obligationsFromStructuredInputs inputs sideConditions =
      package.obligationsFromParts
        inputs.theorem311Subclaims sideConditions :=
  rfl

theorem obligationsFromStructuredInputs_eq_ofStructuredInputs
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.obligationsFromStructuredInputs inputs sideConditions =
      IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
        inputs sideConditions :=
  rfl

def obligationsFromStructuredHypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    IUTStage1SourceObligations package :=
  package.obligationsFromStructuredInputs inputs hypotheses.toSideConditions

theorem obligationsFromStructuredHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      package.obligationsFromStructuredInputs
        inputs hypotheses.toSideConditions :=
  rfl

theorem obligationsFromStructuredHypotheses_eq_hypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      package.obligationsFromHypotheses
        inputs.theorem311Subclaims hypotheses :=
  rfl

theorem obligationsFromStructuredHypotheses_eq_ofStructuredHypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses
        inputs hypotheses :=
  rfl

theorem publicAuditOfParts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
      Corollary312Inequality
        (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
        (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
      (corollary312_from_stage1_comparison
          (package.promotedProvider
            (package.obligationsFromParts
              subclaims sideConditions)).stage1Comparison =
        corollary312_of_signed_le
          (package.promotedProvider
            (package.obligationsFromParts
              subclaims sideConditions)).ledger.qSigned_le_thetaSigned) :=
  package.publicAudit (package.obligationsFromParts subclaims sideConditions)

theorem publicAuditOfParts_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  (package.publicAuditOfParts subclaims sideConditions).1

theorem publicAuditOfParts_corollary312
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (package.publicAuditOfParts subclaims sideConditions).2.1

theorem publicAuditOfParts_stage1Comparison_recovers_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    corollary312_from_stage1_comparison
        (package.promotedProvider
          (package.obligationsFromParts
            subclaims sideConditions)).stage1Comparison =
      corollary312_of_signed_le
      (package.promotedProvider
        (package.obligationsFromParts
          subclaims sideConditions)).ledger.qSigned_le_thetaSigned :=
  (package.publicAuditOfParts subclaims sideConditions).2.2

theorem publicAuditOfHypotheses
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
      Corollary312Inequality
        (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
        (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
      (corollary312_from_stage1_comparison
          (package.promotedProvider
            (package.obligationsFromHypotheses
              subclaims hypotheses)).stage1Comparison =
        corollary312_of_signed_le
          (package.promotedProvider
            (package.obligationsFromHypotheses
              subclaims hypotheses)).ledger.qSigned_le_thetaSigned) :=
  package.publicAudit
    (package.obligationsFromHypotheses subclaims hypotheses)

theorem publicAuditOfHypotheses_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  (package.publicAuditOfHypotheses subclaims hypotheses).1

theorem publicAuditOfHypotheses_corollary312
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (package.publicAuditOfHypotheses subclaims hypotheses).2.1

theorem publicAuditOfHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.publicAuditOfHypotheses subclaims hypotheses =
      package.publicAuditOfParts subclaims hypotheses.toSideConditions :=
  rfl

theorem publicAuditOfStructuredInputs
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
      Corollary312Inequality
        (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
        (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
      (corollary312_from_stage1_comparison
          (package.promotedProvider
            (package.obligationsFromStructuredInputs
              inputs sideConditions)).stage1Comparison =
        corollary312_of_signed_le
          (package.promotedProvider
            (package.obligationsFromStructuredInputs
              inputs sideConditions)).ledger.qSigned_le_thetaSigned) :=
  package.publicAudit
    (package.obligationsFromStructuredInputs inputs sideConditions)

theorem publicAuditOfStructuredInputs_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  (package.publicAuditOfStructuredInputs inputs sideConditions).1

theorem publicAuditOfStructuredInputs_corollary312
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (package.publicAuditOfStructuredInputs inputs sideConditions).2.1

theorem publicAuditOfStructuredInputs_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.publicAuditOfStructuredInputs inputs sideConditions =
      package.publicAuditOfParts
        inputs.theorem311Subclaims sideConditions :=
  rfl

theorem publicAuditOfStructuredHypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
      Corollary312Inequality
        (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
        (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
      (corollary312_from_stage1_comparison
          (package.promotedProvider
            (package.obligationsFromStructuredHypotheses
              inputs hypotheses)).stage1Comparison =
        corollary312_of_signed_le
          (package.promotedProvider
            (package.obligationsFromStructuredHypotheses
              inputs hypotheses)).ledger.qSigned_le_thetaSigned) :=
  package.publicAudit
    (package.obligationsFromStructuredHypotheses inputs hypotheses)

theorem publicAuditOfStructuredHypotheses_qSigned_le_thetaSigned
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  (package.publicAuditOfStructuredHypotheses inputs hypotheses).1

theorem publicAuditOfStructuredHypotheses_corollary312
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (package.publicAuditOfStructuredHypotheses inputs hypotheses).2.1

theorem publicAuditOfStructuredHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.publicAuditOfStructuredHypotheses inputs hypotheses =
      package.publicAuditOfStructuredInputs
        inputs hypotheses.toSideConditions :=
  rfl

theorem publicAuditOfStructuredHypotheses_eq_hypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.publicAuditOfStructuredHypotheses inputs hypotheses =
      package.publicAuditOfHypotheses
        inputs.theorem311Subclaims hypotheses :=
  rfl

theorem stage1Comparison_recovers_corollary312
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    corollary312_from_stage1_comparison
        (package.promotedProvider obligations).stage1Comparison =
      (package.promotedProvider obligations).ledger.corollary312 :=
  (package.promotedProvider obligations).stage1Comparison_recovers_corollary312

/-- Compact audit checklist for a source-facing Stage 1 package. -/
structure Audit
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) : Prop where
  input_matches_labels : package.input = package.labels.input
  multiradialOutput_matches_labels :
    package.multiradialOutput = package.labels.multiradialOutput
  logVolumeComparison_matches_labels :
    package.logVolumeComparison = package.labels.logVolumeComparison
  thetaPilot_matches_labels : package.thetaPilot = package.labels.thetaPilot
  qPilot_matches_labels : package.qPilot = package.labels.qPilot
  logKummer_matches_labels : package.logKummer = package.labels.logKummer
  indeterminacies_matches_labels :
    package.indeterminacies = package.labels.indeterminacies
  qPilotLogVolume_matches_labels :
    package.qPilotLogVolume = package.labels.qPilotLogVolume
  sourceNormalization_matches_labels :
    package.sourceNormalizationLabel = package.labels.sourceNormalization
  algorithm_certified : package.preLedger.output.Certified
  she_arrow_matches_certificate :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she
  q_pilot_positive : 0 < -package.preLedger.qSigned
  normalization : package.preLedger.normalization
  promoted_provider_ledger :
    (package.promotedProvider obligations).ledger =
      package.promotedLedger obligations
  qSigned_le_thetaSigned :
    package.preLedger.qSigned <= package.preLedger.thetaSigned
  corollary312 :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned)
  stage_recovers_qSigned_le_thetaSigned :
    corollary312_from_stage1_comparison
        (package.promotedProvider obligations).stage1Comparison =
      corollary312_of_signed_le
        (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned
  stage_recovers_corollary312 :
    corollary312_from_stage1_comparison
        (package.promotedProvider obligations).stage1Comparison =
      (package.promotedProvider obligations).ledger.corollary312

theorem audit
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    Audit package obligations :=
  { input_matches_labels := package.input_matches_labels,
    multiradialOutput_matches_labels :=
      package.multiradialOutput_matches_labels,
    logVolumeComparison_matches_labels :=
      package.logVolumeComparison_matches_labels,
    thetaPilot_matches_labels := package.thetaPilot_matches_labels,
    qPilot_matches_labels := package.qPilot_matches_labels,
    logKummer_matches_labels := package.logKummer_matches_labels,
    indeterminacies_matches_labels :=
      package.indeterminacies_matches_labels,
    qPilotLogVolume_matches_labels :=
      package.qPilotLogVolume_matches_labels,
    sourceNormalization_matches_labels :=
      package.sourceNormalization_matches_labels,
    algorithm_certified := obligations.algorithmCertified,
    she_arrow_matches_certificate := obligations.sheArrowMatchesCertificate,
    q_pilot_positive := obligations.qPilotPositive,
    normalization := obligations.sourceNormalization,
    promoted_provider_ledger := package.promotedProvider_ledger obligations,
    qSigned_le_thetaSigned :=
      package.publicAudit_qSigned_le_thetaSigned obligations,
    corollary312 := package.publicAudit_corollary312 obligations,
    stage_recovers_qSigned_le_thetaSigned :=
      package.publicAudit_stage1Comparison_recovers_qSigned_le_thetaSigned
        obligations,
    stage_recovers_corollary312 :=
      package.stage1Comparison_recovers_corollary312 obligations }

def ComparisonDataEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) : Prop :=
  ∃ _sourceAudit : Audit package obligations,
    ∃ data : Corollary312ComparisonData,
      data = package.comparisonData obligations ∧
        data.qSigned <= data.thetaSigned ∧
        Corollary312Inequality data.thetaPilot data.qPilot ∧
        corollary312_from_stage1_comparison data.stage1Comparison =
          corollary312_of_signed_le data.qSigned_le_thetaSigned

theorem auditedComparisonDataEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    package.ComparisonDataEndpoint obligations :=
  ⟨package.audit obligations, package.comparisonData obligations, rfl,
    (package.comparisonData obligations).publicAudit⟩

namespace ComparisonDataEndpoint

variable {package : IUTStage1SourcePackage source target index}
variable {obligations : IUTStage1SourceObligations package}

theorem sourceAuditExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ _sourceAudit : Audit package obligations, True := by
  rcases endpoint with ⟨sourceAudit, _data, _hdata, _hle, _hcorollary, _hrecovers⟩
  exact ⟨sourceAudit, trivial⟩

theorem comparisonDataExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ data : Corollary312ComparisonData,
      data = package.comparisonData obligations := by
  rcases endpoint with ⟨_sourceAudit, data, hdata, _hle, _hcorollary, _hrecovers⟩
  exact ⟨data, hdata⟩

theorem qSignedLeThetaSigned
    (endpoint : package.ComparisonDataEndpoint obligations) :
    (package.comparisonData obligations).qSigned <=
      (package.comparisonData obligations).thetaSigned := by
  rcases endpoint with ⟨_sourceAudit, data, hdata, hle, _hcorollary, _hrecovers⟩
  cases hdata
  exact hle

theorem corollary312Endpoint
    (endpoint : package.ComparisonDataEndpoint obligations) :
    Corollary312Inequality
      (package.comparisonData obligations).thetaPilot
      (package.comparisonData obligations).qPilot := by
  rcases endpoint with ⟨_sourceAudit, data, hdata, _hle, hcorollary, _hrecovers⟩
  cases hdata
  exact hcorollary

theorem stageRecoversQSignedLeThetaSigned
    (endpoint : package.ComparisonDataEndpoint obligations) :
    corollary312_from_stage1_comparison
        (package.comparisonData obligations).stage1Comparison =
      corollary312_of_signed_le
        (package.comparisonData obligations).qSigned_le_thetaSigned := by
  rcases endpoint with ⟨_sourceAudit, data, hdata, _hle, _hcorollary, hrecovers⟩
  cases hdata
  exact hrecovers

theorem publicAudit
    (endpoint : package.ComparisonDataEndpoint obligations) :
    (package.comparisonData obligations).qSigned <=
        (package.comparisonData obligations).thetaSigned ∧
      Corollary312Inequality
        (package.comparisonData obligations).thetaPilot
        (package.comparisonData obligations).qPilot ∧
      corollary312_from_stage1_comparison
          (package.comparisonData obligations).stage1Comparison =
        corollary312_of_signed_le
          (package.comparisonData obligations).qSigned_le_thetaSigned :=
  ⟨endpoint.qSignedLeThetaSigned,
    endpoint.corollary312Endpoint,
    endpoint.stageRecoversQSignedLeThetaSigned⟩

theorem publicAudit_eq_comparisonData_publicAudit
    (endpoint : package.ComparisonDataEndpoint obligations) :
    endpoint.publicAudit =
      (package.comparisonData obligations).publicAudit :=
  Subsingleton.elim _ _

theorem publicAudit_eq_package_publicAudit
    (endpoint : package.ComparisonDataEndpoint obligations) :
    endpoint.publicAudit = package.publicAudit obligations :=
  Subsingleton.elim _ _

end ComparisonDataEndpoint

/--
Endpoint audit for the strengthened hull+det obligation route.

This packages the old comparison endpoint together with the source-facing hull
facts, so the public comparison and the union-of-possible-images provenance are
checked at the same boundary.
-/
structure HullDetComparisonEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) : Prop where
  comparison_endpoint :
    package.ComparisonDataEndpoint obligations.toSourceObligations
  public_audit :
    package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
      Corollary312Inequality
        (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
        (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
      (corollary312_from_stage1_comparison
          (package.promotedProvider
            obligations.toSourceObligations).stage1Comparison =
        corollary312_of_signed_le
          (package.promotedProvider
            obligations.toSourceObligations).ledger.qSigned_le_thetaSigned)
  target_union_subset_hull :
    Region.Subset package.preLedger.output.comparisons.targetUnion
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
  determinant_volume_bound :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned
  all_targets_at_most :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned

theorem auditedHullDetComparisonEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) :
    package.HullDetComparisonEndpoint obligations :=
  { comparison_endpoint :=
      package.auditedComparisonDataEndpoint obligations.toSourceObligations,
    public_audit := package.publicAuditOfHullDetObligations obligations,
    target_union_subset_hull := obligations.targetUnion_subset_hull,
    determinant_volume_bound := obligations.determinantVolumeBound,
    all_targets_at_most := obligations.allTargetsAtMost }

namespace HullDetComparisonEndpoint

variable {package : IUTStage1SourcePackage source target index}
variable {obligations : IUTStage1SourceHullDetObligations package}

theorem corollary312Endpoint
    (endpoint : package.HullDetComparisonEndpoint obligations) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  endpoint.public_audit.2.1

theorem qSignedLeThetaSigned
    (endpoint : package.HullDetComparisonEndpoint obligations) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  endpoint.public_audit.1

theorem targetUnion_subset_hull
    (endpoint : package.HullDetComparisonEndpoint obligations) :
    Region.Subset package.preLedger.output.comparisons.targetUnion
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  endpoint.target_union_subset_hull

theorem determinantVolumeBound
    (endpoint : package.HullDetComparisonEndpoint obligations) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  endpoint.determinant_volume_bound

theorem allTargetsAtMost
    (endpoint : package.HullDetComparisonEndpoint obligations) :
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  endpoint.all_targets_at_most

theorem comparisonEndpointCorollary312
    (endpoint : package.HullDetComparisonEndpoint obligations) :
    Corollary312Inequality
      (package.comparisonData obligations.toSourceObligations).thetaPilot
      (package.comparisonData obligations.toSourceObligations).qPilot :=
  endpoint.comparison_endpoint.corollary312Endpoint

end HullDetComparisonEndpoint

/--
Hull+det endpoint stated in terms of source-level Theta-pilot possible images.

This keeps the source interpretation of `targetUnion` attached to the final
audited comparison endpoint.
-/
structure ThetaPilotHullEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) where
  possible_images : IUTStage1ThetaPilotPossibleImages package
  hull_endpoint : package.HullDetComparisonEndpoint obligations
  possible_images_union_subset_hull :
    Region.Subset possible_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
  possible_images_union_eq_targetUnion :
    possible_images.union = package.preLedger.output.comparisons.targetUnion

def auditedThetaPilotHullEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) :
    package.ThetaPilotHullEndpoint obligations :=
  let possibleImages := IUTStage1ThetaPilotPossibleImages.ofPackage package
  { possible_images := possibleImages,
    hull_endpoint := package.auditedHullDetComparisonEndpoint obligations,
    possible_images_union_subset_hull :=
      possibleImages.union_subset_target obligations.targetUnion_subset_hull,
    possible_images_union_eq_targetUnion :=
      possibleImages.union_eq_targetUnion }

namespace ThetaPilotHullEndpoint

variable {package : IUTStage1SourcePackage source target index}
variable {obligations : IUTStage1SourceHullDetObligations package}

theorem corollary312Endpoint
    (endpoint : package.ThetaPilotHullEndpoint obligations) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  endpoint.hull_endpoint.corollary312Endpoint

theorem possibleImagesUnion_subset_hull
    (endpoint : package.ThetaPilotHullEndpoint obligations) :
    Region.Subset endpoint.possible_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  endpoint.possible_images_union_subset_hull

theorem possibleImagesUnion_eq_targetUnion
    (endpoint : package.ThetaPilotHullEndpoint obligations) :
    endpoint.possible_images.union =
      package.preLedger.output.comparisons.targetUnion :=
  endpoint.possible_images_union_eq_targetUnion

theorem determinantVolumeBound
    (endpoint : package.ThetaPilotHullEndpoint obligations) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  endpoint.hull_endpoint.determinantVolumeBound

theorem thetaPilotMatchesPackage
    (endpoint : package.ThetaPilotHullEndpoint obligations) :
    endpoint.possible_images.thetaPilot = package.thetaPilot :=
  endpoint.possible_images.thetaPilotMatchesPackage

theorem indeterminaciesMatchPackage
    (endpoint : package.ThetaPilotHullEndpoint obligations) :
    endpoint.possible_images.indeterminacies = package.indeterminacies :=
  endpoint.possible_images.indeterminaciesMatchPackage

end ThetaPilotHullEndpoint

/--
Hull+det endpoint stated for multiradial Theta-pilot images.

This is the source-facing endpoint that keeps the indeterminacy quotient,
possible-image union, hull containment, determinant bound, and final signed
comparison in one inspectable object.
-/
structure MultiradialThetaHullEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package) where
  multiradial_images : IUTStage1MultiradialThetaImages package
  theta_hull_endpoint : package.ThetaPilotHullEndpoint obligations
  multiradial_union_eq_endpoint_union :
    multiradial_images.union = theta_hull_endpoint.possible_images.union
  multiradial_union_subset_hull :
    Region.Subset multiradial_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull

def auditedMultiradialThetaHullEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceHullDetObligations package)
    (images : IUTStage1MultiradialThetaImages package) :
    package.MultiradialThetaHullEndpoint obligations :=
  let endpoint := package.auditedThetaPilotHullEndpoint obligations
  { multiradial_images := images,
    theta_hull_endpoint := endpoint,
    multiradial_union_eq_endpoint_union := by
      calc
        images.union = package.preLedger.output.comparisons.targetUnion :=
          images.union_eq_targetUnion
        _ = endpoint.possible_images.union :=
          endpoint.possibleImagesUnion_eq_targetUnion.symm,
    multiradial_union_subset_hull := by
      rw [images.union_eq_targetUnion]
      exact obligations.targetUnion_subset_hull }

namespace MultiradialThetaHullEndpoint

variable {package : IUTStage1SourcePackage source target index}
variable {obligations : IUTStage1SourceHullDetObligations package}

theorem corollary312Endpoint
    (endpoint : package.MultiradialThetaHullEndpoint obligations) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  endpoint.theta_hull_endpoint.corollary312Endpoint

theorem multiradialUnion_subset_hull
    (endpoint : package.MultiradialThetaHullEndpoint obligations) :
    Region.Subset endpoint.multiradial_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  endpoint.multiradial_union_subset_hull

theorem multiradialUnion_eq_possibleImagesUnion
    (endpoint : package.MultiradialThetaHullEndpoint obligations) :
    endpoint.multiradial_images.union =
      endpoint.theta_hull_endpoint.possible_images.union :=
  endpoint.multiradial_union_eq_endpoint_union

theorem determinantVolumeBound
    (endpoint : package.MultiradialThetaHullEndpoint obligations) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  endpoint.theta_hull_endpoint.determinantVolumeBound

theorem region_eq_of_related
    (endpoint : package.MultiradialThetaHullEndpoint obligations)
    {choice₁ choice₂ : index}
    (hrel : endpoint.multiradial_images.quotient.relation choice₁ choice₂) :
    endpoint.multiradial_images.possibleImages.images.region choice₁ =
      endpoint.multiradial_images.possibleImages.images.region choice₂ :=
  endpoint.multiradial_images.region_eq_of_related hrel

theorem multiradialOutputMatchesPackage
    (endpoint : package.MultiradialThetaHullEndpoint obligations) :
    endpoint.multiradial_images.multiradialOutput =
      package.multiradialOutput :=
  endpoint.multiradial_images.multiradialOutputMatchesPackage

end MultiradialThetaHullEndpoint

/--
Hull+det endpoint stated for place-audited multiradial Theta-pilot images.

This specializes the hull endpoint to the audited choice type used to track the
Theorem 3.11 `(Ind2)` place-family and fiber data.
-/
structure PlaceAuditedMultiradialThetaHullEndpoint
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (obligations : IUTStage1SourceHullDetObligations package) where
  audited_images : IUTStage1PlaceAuditedMultiradialThetaImages package
  theta_hull_endpoint : package.ThetaPilotHullEndpoint obligations
  audited_union_eq_endpoint_union :
    audited_images.possibleImages.union =
      theta_hull_endpoint.possible_images.union
  audited_union_subset_hull :
    Region.Subset audited_images.possibleImages.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull

def auditedPlaceAuditedMultiradialThetaHullEndpoint
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (obligations : IUTStage1SourceHullDetObligations package)
    (images : IUTStage1PlaceAuditedMultiradialThetaImages package) :
    package.PlaceAuditedMultiradialThetaHullEndpoint obligations :=
  let endpoint := package.auditedThetaPilotHullEndpoint obligations
  { audited_images := images,
    theta_hull_endpoint := endpoint,
    audited_union_eq_endpoint_union := by
      calc
        images.possibleImages.union =
            package.preLedger.output.comparisons.targetUnion :=
          images.union_eq_targetUnion
        _ = endpoint.possible_images.union :=
          endpoint.possibleImagesUnion_eq_targetUnion.symm,
    audited_union_subset_hull := by
      rw [images.union_eq_targetUnion]
      exact obligations.targetUnion_subset_hull }

namespace PlaceAuditedMultiradialThetaHullEndpoint

variable {coric : Type u} {kind : IUTStage1PlaceKind}
variable
  {package :
    IUTStage1SourcePackage source target
      (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
variable {obligations : IUTStage1SourceHullDetObligations package}

theorem corollary312Endpoint
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  endpoint.theta_hull_endpoint.corollary312Endpoint

theorem auditedUnion_subset_hull
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    Region.Subset endpoint.audited_images.possibleImages.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  endpoint.audited_union_subset_hull

theorem auditedUnion_eq_possibleImagesUnion
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    endpoint.audited_images.possibleImages.union =
      endpoint.theta_hull_endpoint.possible_images.union :=
  endpoint.audited_union_eq_endpoint_union

theorem determinantVolumeBound
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  endpoint.theta_hull_endpoint.determinantVolumeBound

theorem region_eq_of_related
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel : endpoint.audited_images.auditedImages.quotient.relation
      audited₁ audited₂) :
    endpoint.audited_images.possibleImages.images.region audited₁ =
      endpoint.audited_images.possibleImages.images.region audited₂ :=
  endpoint.audited_images.region_eq_of_related hrel

theorem nonarchimedeanEntry_region_eq_and_fiber_mem
    {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    endpoint.audited_images.possibleImages.images.region audited₁ =
        endpoint.audited_images.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  endpoint.audited_images.region_eq_and_fiber_mem_of_nonarchimedeanEntry_step
    fiberPackage hstep

theorem archimedeanEntry_region_eq_and_fiber_mem
    {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    endpoint.audited_images.possibleImages.images.region audited₁ =
        endpoint.audited_images.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  endpoint.audited_images.region_eq_and_fiber_mem_of_archimedeanEntry_step
    fiberPackage hstep

theorem multiradialOutputMatchesPackage
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    endpoint.audited_images.multiradialOutput =
      package.multiradialOutput :=
  endpoint.audited_images.multiradial_output_eq

/--
Endpoint audit for the signed real/log-volume chart data used at the
place-audited hull boundary.
-/
structure LogVolumeChartAudit
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    Prop where
  q_charted :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned
  theta_charted :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned
  target_signed_eq_chosen_volume :
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice)
  q_signed_le_target :
    package.preLedger.qSigned <= package.preLedger.targetVolume.targetSigned
  target_signed_le_theta :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned
  q_signed_le_theta :
    package.preLedger.qSigned <= package.preLedger.thetaSigned
  determinant_volume_bound :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned
  corollary312_endpoint :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned)

def logVolumeChartAudit
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    endpoint.LogVolumeChartAudit :=
  { q_charted := package.preLedger.qSigned_eq_chartedQ,
    theta_charted := package.preLedger.thetaSigned_eq_chartedTheta,
    target_signed_eq_chosen_volume :=
      package.preLedger.targetSigned_eq_choiceTargetVolume,
    q_signed_le_target := package.preLedger.qSigned_le_targetSigned,
    target_signed_le_theta := package.preLedger.targetSigned_le_thetaSigned,
    q_signed_le_theta :=
      le_trans package.preLedger.qSigned_le_targetSigned
        package.preLedger.targetSigned_le_thetaSigned,
    determinant_volume_bound := endpoint.determinantVolumeBound,
    corollary312_endpoint := endpoint.corollary312Endpoint }

namespace LogVolumeChartAudit

variable {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}

/-- Equality/identification part of the log-volume chart audit. -/
structure Ind12EqualityPart
    (audit : endpoint.LogVolumeChartAudit) : Prop where
  q_charted :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned
  theta_charted :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned
  target_signed_eq_chosen_volume :
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice)
  q_signed_le_target :
    package.preLedger.qSigned <= package.preLedger.targetVolume.targetSigned

/-- Upper-inequality part of the log-volume chart audit. -/
structure Ind3UpperInequalityPart
    (audit : endpoint.LogVolumeChartAudit) : Prop where
  target_signed_le_theta :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned
  determinant_volume_bound :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned

def ind12EqualityPart
    (audit : endpoint.LogVolumeChartAudit) :
    audit.Ind12EqualityPart :=
  { q_charted := audit.q_charted,
    theta_charted := audit.theta_charted,
    target_signed_eq_chosen_volume :=
      audit.target_signed_eq_chosen_volume,
    q_signed_le_target := audit.q_signed_le_target }

def ind3UpperInequalityPart
    (audit : endpoint.LogVolumeChartAudit) :
    audit.Ind3UpperInequalityPart :=
  { target_signed_le_theta := audit.target_signed_le_theta,
    determinant_volume_bound := audit.determinant_volume_bound }

/--
Audit connecting the `(Ind1)/(Ind2)` equality part to explicit invariance of
procession-normalized local log-volumes.
-/
structure ProcessionNormalizedInd12Audit
    (audit : endpoint.LogVolumeChartAudit) : Prop where
  ind12_equality_part : audit.Ind12EqualityPart
  ind1_normalizedLogVolume_eq :
    ∀ {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind},
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂ ->
        audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
          audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume
  ind2_normalizedLogVolume_eq :
    ∀ {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind},
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂ ->
        audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
          audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume

def processionNormalizedInd12Audit
    (audit : endpoint.LogVolumeChartAudit) :
    audit.ProcessionNormalizedInd12Audit :=
  { ind12_equality_part := audit.ind12EqualityPart,
    ind1_normalizedLogVolume_eq := by
      intro audited₁ audited₂ hstep
      exact
        IUTStage1PlaceAuditedDirectSummandPacketChoice.ind1_preserves_capsuleNormalizedLogVolume
          hstep,
    ind2_normalizedLogVolume_eq := by
      intro audited₁ audited₂ hstep
      exact
        IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_preserves_capsuleNormalizedLogVolume
          hstep }

/--
Label-averaged version of the `(Ind1)/(Ind2)` log-volume audit.

The label-wise log-volume family is source data: later work should instantiate
the label type by the concrete `F_l` model.  This audit proves that pointwise
label-wise invariance descends to the averaged procession log-volume.
-/
structure LabelAveragedInd12Audit
    (audit : endpoint.LogVolumeChartAudit)
    (label : Type v) [Fintype label] where
  normalized_audit : audit.ProcessionNormalizedInd12Audit
  averagedLogVolume :
    IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind ->
      IUTStage1LabelAveragedProcessionLogVolume label
  ind1_labelwise_eq :
    ∀ {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind},
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂ ->
        ∀ j : label,
          (averagedLogVolume audited₁).normalizedLogVolume j =
            (averagedLogVolume audited₂).normalizedLogVolume j
  ind2_labelwise_eq :
    ∀ {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind},
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂ ->
        ∀ j : label,
          (averagedLogVolume audited₁).normalizedLogVolume j =
            (averagedLogVolume audited₂).normalizedLogVolume j

/--
`F_l`-labelled version of the averaged `(Ind1)/(Ind2)` audit.

This packages the averaged log-volume audit together with evidence that the
label set is the current `ZMod l` model of the `F_l` labels.
-/
structure FLLabelAveragedInd12Audit
    (audit : endpoint.LogVolumeChartAudit)
    (label : Type v) [Fintype label] where
  label_model : IUTStage1FLLabelModel label
  averaged_audit : audit.LabelAveragedInd12Audit label

/--
Additive-torsor-refined `F_l`-labelled averaged audit.

This strengthens `FLLabelAveragedInd12Audit` by recording the transported
additive `F_l` action on the label carrier.
-/
structure FLLabelTorsorAveragedInd12Audit
    (audit : endpoint.LogVolumeChartAudit)
    (label : Type) [Fintype label] where
  torsor_model : IUTStage1FLLabelTorsorModel label
  averaged_audit : audit.LabelAveragedInd12Audit label

/--
`ZMod l`-indexed averaged audit carrying the canonical local cusp-label model
for the same prime `l`.

This is the Stage 1 package in which the average over `j ∈ F_l` and the local
cusp-label class data share the same formal `ZMod l` source.
-/
structure FLZModCuspLabelAveragedInd12Audit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  cusp_label_model : IUTStage1FLZModCuspLabelClassModel l
  averaged_audit : audit.LabelAveragedInd12Audit (ZMod l.value)

/--
`ZMod l` cusp-label averaged audit with an explicit compatibility between the
averaged normalized log-volume family and cusp sign-label classes.
-/
structure FLZModCuspLabelCompatibleAveragedInd12Audit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  zmod_cusp_audit : audit.FLZModCuspLabelAveragedInd12Audit l
  cuspLogVolume :
    IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind ->
      IUTStage1ZModCuspLabelLogVolumeCompatibility l
  normalizedLogVolume_eq :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (j : ZMod l.value),
      (zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume j =
        (cuspLogVolume audited).normalizedLogVolume j

/--
Theta-source compatibility for a cusp-compatible `ZMod l` label average.

This records that the averaged label log-volume is the source average attached
to the Theta-pilot side and is bounded by the charted Theta signed value.
-/
structure FLZModCuspLabelThetaSourceAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  compatible_average : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l
  theta_images : IUTStage1ThetaPilotPossibleImages package
  thetaSourceAverage :
    IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind -> Real
  thetaSourceAverage_eq_average :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      thetaSourceAverage audited =
        (compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).averageLogVolume
  thetaSourceAverage_le_thetaSigned :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      thetaSourceAverage audited <= package.preLedger.thetaSigned

/--
q-side comparison audit for a Theta-source label average.

This records the q-pilot log-volume source real and the comparison from the
q-side to the Theta-source average before composing with the final Theta bound.
-/
structure FLZModCuspLabelQThetaComparisonAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  qPilotLogVolume : QPilotLogVolumeId
  qPilotLogVolume_eq_package : qPilotLogVolume = package.qPilotLogVolume
  qSourceLogVolume : Real
  qSourceLogVolume_eq_qSigned :
    qSourceLogVolume = package.preLedger.qSigned
  qSourceLogVolume_le_thetaAverage :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      qSourceLogVolume <= theta_source.thetaSourceAverage audited

/--
Final comparison alignment for the cusp-compatible label-average route.

This packages the q-to-Theta-average comparison together with the existing
`(Ind3)` upper-inequality part of the chart audit.
-/
structure FLZModCuspLabelFinalComparisonAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  q_theta_comparison : audit.FLZModCuspLabelQThetaComparisonAudit l
  ind3_upper_part : audit.Ind3UpperInequalityPart

/--
Reduction of the q-to-average comparison to a target-to-average bound.

The existing `(Ind1)/(Ind2)` equality part supplies `qSigned <= targetSigned`.
Thus a bound `targetSigned <= thetaSourceAverage` is sufficient to build the
q-to-Theta-average comparison audit.
-/
structure FLZModCuspLabelTargetAverageReductionAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  targetSigned_le_thetaAverage :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      package.preLedger.targetVolume.targetSigned <=
        theta_source.thetaSourceAverage audited

/--
Source classification for the target-to-Theta-average bound isolated at the
Corollary 3.12 boundary.

`ind3UpperSemiOnly` is intentionally available as a rejected classification:
the audit below requires evidence that the bound is not being attributed to
`(Ind3)` alone.
-/
inductive IUTStage1TargetAverageBoundSource where
  | ind3UpperSemiOnly
  | thetaPilotHullContainer
  | separateComparisonLemma
deriving DecidableEq

/--
Target-to-average bound packaged with its source classification.

The bound is kept separate from `(Ind3)`: `(Ind3)` supplies the upper-bound
context, while the domination of the target signed volume by the Theta-source
average must come from a hull/container computation or a separate comparison
lemma.
-/
structure FLZModCuspLabelThetaContainerBoundAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  bound_source : IUTStage1TargetAverageBoundSource
  bound_source_not_ind3_only :
    bound_source ≠ IUTStage1TargetAverageBoundSource.ind3UpperSemiOnly
  targetSigned_le_thetaAverage :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      package.preLedger.targetVolume.targetSigned <=
        theta_source.thetaSourceAverage audited

/--
Theta-pilot hull/container source for the target-to-average comparison.

This is the constructive branch of `IUTStage1TargetAverageBoundSource` closest
to the IUT III/IV description: the Theta-source images are identified with the
endpoint's possible Theta-pilot images, hence their union is the endpoint union
bounded by the holomorphic-hull/determinant container.  The final
target-to-average inequality is still recorded explicitly, because it is the
mathematical comparison under dispute rather than a consequence of `(Ind3)`
alone.
-/
structure FLZModCuspLabelThetaPilotHullContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  targetSigned_le_thetaAverage_from_hull_container :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      package.preLedger.targetVolume.targetSigned <=
        theta_source.thetaSourceAverage audited

/--
Labelwise local-container estimate for the Theta-pilot hull/container route.

This is a refinement of `FLZModCuspLabelThetaPilotHullContainerAudit`: instead
of assuming the target-to-average inequality directly, it assumes a labelwise
lower bound over `F_l = ZMod l.value`.  The finite-average lemma then derives
the average bound.
-/
structure FLZModCuspLabelThetaLabelwiseContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  targetSigned_le_normalizedLogVolume :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (j : ZMod l.value),
      package.preLedger.targetVolume.targetSigned <=
        (theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume j

/--
Cusp-class local-container estimate for the Theta-pilot hull/container route.

This is one step closer to the local IUT data than the raw `ZMod l` labelwise
audit: nonzero labels are bounded via their cusp sign-label classes, while the
zero label is bounded by the separately recorded zero log-volume.
-/
structure FLZModCuspLabelThetaCuspClassContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  targetSigned_le_cuspClassLogVolume :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      package.preLedger.targetVolume.targetSigned <=
        (theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label
  targetSigned_le_zeroLogVolume :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      package.preLedger.targetVolume.targetSigned <=
        (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume

/--
Local-container source for the cusp-class container bounds.

This audit replaces the cusp-class inequalities by explicit local container
estimates attached to each audited packet and cusp sign-label class.  It also
keeps a separate local container estimate for the zero label.
-/
structure FLZModCuspLabelThetaLocalContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  cuspClassEstimate :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1LocalContainerLogVolumeEstimate
        package.preLedger.targetVolume.targetSigned
        ((theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label)
  zeroEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalContainerLogVolumeEstimate
        package.preLedger.targetVolume.targetSigned
        (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume

/--
Local-object source for the cusp-class local container estimates.

Each cusp-class and zero-label estimate is now tied to a finite local
log-volume object before being converted to the real-valued local container
audit.
-/
structure FLZModCuspLabelThetaLocalObjectContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  cuspClassObjectEstimate :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        ((theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label)
  zeroObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume

/--
Packet-local-object source for the cusp-class local object estimates.

This refinement requires the local object used by each cusp-class or zero-label
container estimate to be the finite local object carried by the audited local
tensor packet.
-/
structure FLZModCuspLabelThetaPacketLocalObjectContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  cuspClassObjectEstimate :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        ((theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label)
  cuspClassObject_eq_packetLocalObject :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (cuspClassObjectEstimate audited label).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  zeroObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume
  zeroObject_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (zeroObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject

/--
Packet-local-object container audit with an explicit source classification for
the cusp/zero local-object estimates.
-/
structure FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  packet_local_object :
    audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l
  estimate_source : IUTStage1PacketLocalObjectEstimateSource

/--
Packet-local-object estimate audit in which all cusp classes and the zero label
are obtained from one packet local-object estimate per audited packet.
-/
structure FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  cuspClassLogVolume_eq_packetLocalObjectFinite :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label =
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  zeroLogVolume_eq_packetLocalObjectFinite :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume

/--
Shared packet-local-object estimate audit whose cusp/zero log-volume
identifications are derived from a `ZMod l` label-family equality.
-/
structure FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  zmodNormalizedLogVolume_eq_packetLocalObjectFinite :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (j : ZMod l.value),
      (theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume

/--
Shared packet-local-object estimate audit in which the `ZMod l` label family is
the constant family with value the packet local object's finite log-volume.
-/
structure FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  averagedLogVolume_eq_packetLocalObjectConstant :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited) =
        IUTStage1LabelAveragedProcessionLogVolume.constant
          (label := ZMod l.value)
          audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume

/--
Constant `ZMod l` packet-local-object route with an explicit source
classification for the local label/object bridge.
-/
structure FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  constant_route :
    audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l
  bridge_source : IUTStage1ZModPacketLocalObjectBridgeSource

/--
Direct local label/object construction for the `ZMod l` label family.

Each label supplies a finite local object, and every such object is identified
with the packet local object.  The label-family normalized log-volume is then
identified with the finite log-volume of the corresponding local object.
-/
structure FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  labelLocalObject :
    ∀ (_audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (_j : ZMod l.value),
      IUTStage1FiniteLocalLogVolumeObject kind
  labelLocalObject_eq_packetLocalObject :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (j : ZMod l.value),
      labelLocalObject audited j =
        audited.choice.local_tensor_state.packetState.localObject
  normalizedLogVolume_eq_labelLocalObjectFinite :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (j : ZMod l.value),
      (theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
        (labelLocalObject audited j).finiteLogVolume

/--
Insulated direct local label/object construction split into nonzero cusp
sign-label classes and a separate zero-label object.

Unlike `FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit`, this
structure does not identify the zero or cusp-class local objects with the
packet local object.  It records only the label-to-local-object log-volume
data, so zero/nonzero comparison remains unavailable until an explicit bridge is
supplied.
-/
structure FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  cuspClassLocalObject :
    ∀ (_audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (_label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1FiniteLocalLogVolumeObject kind
  cuspClassLogVolume_eq_localObjectFinite :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label =
        (cuspClassLocalObject audited label).finiteLogVolume
  zeroLocalObject :
    ∀ _audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1FiniteLocalLogVolumeObject kind
  zeroLogVolume_eq_localObjectFinite :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        (zeroLocalObject audited).finiteLogVolume

/--
Direct local label/object construction split into nonzero cusp sign-label
classes and a separate zero-label object.
-/
structure FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  cuspClassLocalObject :
    ∀ (_audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (_label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1FiniteLocalLogVolumeObject kind
  cuspClassLocalObject_eq_packetLocalObject :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      cuspClassLocalObject audited label =
        audited.choice.local_tensor_state.packetState.localObject
  cuspClassLogVolume_eq_localObjectFinite :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label =
        (cuspClassLocalObject audited label).finiteLogVolume
  zeroLocalObject :
    ∀ _audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1FiniteLocalLogVolumeObject kind
  zeroLocalObject_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      zeroLocalObject audited =
        audited.choice.local_tensor_state.packetState.localObject
  zeroLogVolume_eq_localObjectFinite :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        (zeroLocalObject audited).finiteLogVolume

/--
Bridge from the insulated cusp/zero local-object route to the comparison route.

The bridge supplies exactly the packet-local-object identifications missing from
the insulated route.  These fields are the source of any subsequent equality
between the zero object and nonzero cusp-class objects.
-/
structure FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  insulated_route :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  cuspClassLocalObject_eq_packetLocalObject :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      insulated_route.cuspClassLocalObject audited label =
        audited.choice.local_tensor_state.packetState.localObject
  zeroLocalObject_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      insulated_route.zeroLocalObject audited =
        audited.choice.local_tensor_state.packetState.localObject

/--
Hodge-descent packet transport audit for the insulated cusp/zero route.

This is the source-facing form of the packet bridge when it is attributed to
the structured SHE/HDD route: it carries the structured SHE bundle together
with the packet-local-object identifications that the insulated route
deliberately omitted.
-/
structure FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  bundle : IUTStage1Theorem311StructuredInputsWithSHE package
  insulated_route :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  cuspClassLocalObject_eq_packetLocalObject :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      insulated_route.cuspClassLocalObject audited label =
        audited.choice.local_tensor_state.packetState.localObject
  zeroLocalObject_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      insulated_route.zeroLocalObject audited =
        audited.choice.local_tensor_state.packetState.localObject

/--
Structured Hodge-descent packet transport audit.

This version does not take the zero/cusp-class packet equalities directly.
Instead it requires one local Hodge-descent transport datum for each audited
packet choice, from which the packet bridge equalities are derived.
-/
structure FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  bundle : IUTStage1Theorem311StructuredInputsWithSHE package
  insulated_route :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  localObjectTransport :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1HodgeDescentLocalObjectTransportData l
        bundle.hodgeTheaterDescentBridgeData
        (insulated_route.zeroLocalObject audited)
        (insulated_route.cuspClassLocalObject audited)
        audited.choice.local_tensor_state.packetState.localObject

/--
Hodge-descent packet transport audit whose local transport data is supplied by
explicit descent-operation records.
-/
structure FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  bundle : IUTStage1Theorem311StructuredInputsWithSHE package
  insulated_route :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  localObjectOperation :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1HodgeDescentCuspZeroLocalObjectOperationData l
        bundle.hodgeTheaterDescentBridgeData
        (insulated_route.zeroLocalObject audited)
        (insulated_route.cuspClassLocalObject audited)
        audited.choice.local_tensor_state.packetState.localObject

/--
Hodge-descent packet transport audit with explicit source/target local-object
roles.
-/
structure FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  bundle : IUTStage1Theorem311StructuredInputsWithSHE package
  insulated_route :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  localObjectOperation :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1RoleMarkedHodgeDescentCuspZeroLocalObjectOperationData l
        bundle.hodgeTheaterDescentBridgeData
        (insulated_route.zeroLocalObject audited)
        (insulated_route.cuspClassLocalObject audited)
        audited.choice.local_tensor_state.packetState.localObject

/--
Hodge-descent packet transport audit with source-specific local objects.

This layer records that the role-marked zero and cusp-class operations are
attached to 0-column/SHE source data, Hodge-Arakelov cusp-class source data,
and packet descent target data.
-/
structure FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  bundle : IUTStage1Theorem311StructuredInputsWithSHE package
  insulated_route :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  localObjectOperation :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1SourceMarkedHodgeDescentCuspZeroLocalObjectOperationData l
        bundle.hodgeTheaterDescentBridgeData
        (insulated_route.zeroLocalObject audited)
        (insulated_route.cuspClassLocalObject audited)
        audited.choice.local_tensor_state.packetState.localObject

/--
Source-marked Hodge-descent packet transport audit whose cusp-class source
objects carry explicit `ZMod l` label coordinates.
-/
structure FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  bundle : IUTStage1Theorem311StructuredInputsWithSHE package
  insulated_route :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l
  packetLocalObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  packetLocalObjectEstimate_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (packetLocalObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  localObjectOperation :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1ZModSourceMarkedHodgeDescentCuspZeroLocalObjectOperationData l
        bundle.hodgeTheaterDescentBridgeData
        (insulated_route.zeroLocalObject audited)
        (insulated_route.cuspClassLocalObject audited)
        audited.choice.local_tensor_state.packetState.localObject

/--
Classified packet bridge from the insulated cusp/zero route to the comparison
route.
-/
structure FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  packet_bridge :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l
  bridge_source : IUTStage1ZModPacketLocalObjectBridgeSource

/--
Insulated cusp/zero packet bridge with both the local packet-object source and
the higher-level comparison source recorded.
-/
structure FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  classified_bridge :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l
  comparison_source : IUTStage1InsulatedCuspZeroBridgeSource

/--
Hodge-theater/descent wrapper for a classified insulated cusp/zero packet
bridge.

The classified packet bridge remains explicit data; this wrapper records the
Hodge-theater/descent explanation that justifies classifying it as
`hodgeTheaterDescentIndeterminacy`.
-/
structure FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  hodge_descent_data : IUTStage1HodgeTheaterDescentBridgeData
  classified_bridge :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l
  classified_bridge_source_eq_hodge :
    classified_bridge.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport

/--
Packet-normalized source for the cusp-class local object estimates.

This refinement requires each cusp-class or zero-label log-volume real to be
identified with the normalized capsule-family log-volume of the audited local
tensor packet.
-/
structure FLZModCuspLabelThetaPacketNormalizedContainerAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  cuspClassPacketEstimate :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1PacketNormalizedContainerEstimate
        audited.choice.local_tensor_state
        package.preLedger.targetVolume.targetSigned
        ((theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label)
  zeroPacketEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1PacketNormalizedContainerEstimate
        audited.choice.local_tensor_state
        package.preLedger.targetVolume.targetSigned
        (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume

/--
Packet-normalized audit with an explicit source classification for the
real-line identification between cusp/zero log-volumes and packet-normalized
capsule-family values.
-/
structure FLZModCuspLabelThetaClassifiedPacketNormalizedAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  packet_normalized : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l
  identification_source : IUTStage1PacketNormalizedIdentificationSource

/--
Packet-normalized audit sourced from classified local compatibility
certificates.

This keeps the local compatibility source labels synchronized with the global
packet-normalized source label reported by the classified route summary.
-/
structure FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  identification_source : IUTStage1PacketNormalizedIdentificationSource
  cuspClassObjectEstimate :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        ((theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label)
  cuspClassObject_eq_packetLocalObject :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (cuspClassObjectEstimate audited label).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  cuspClassCompatibility :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (_label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        audited.choice.local_tensor_state.packetState
  cuspClassCompatibility_source_eq :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (cuspClassCompatibility audited label).identification_source =
        identification_source
  zeroObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume
  zeroObject_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (zeroObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  zeroCompatibility :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        audited.choice.local_tensor_state.packetState
  zeroCompatibility_source_eq :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (zeroCompatibility audited).identification_source =
        identification_source

/--
Classified local packet-normalized audit whose compatibility certificates are
transported from source audited packets along audited `(Ind2)` steps.
-/
structure FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  sourceAudited :
    IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind ->
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind
  ind2_step :
    ∀ targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        (sourceAudited targetAudited) targetAudited
  cuspClassObjectEstimate :
    ∀ (targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        ((theta_source.compatible_average.cuspLogVolume
          targetAudited).cuspClassLogVolume label)
  cuspClassObject_eq_packetLocalObject :
    ∀ (targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (cuspClassObjectEstimate targetAudited label).localObject =
        targetAudited.choice.local_tensor_state.packetState.localObject
  cuspClassSourceCompatibility :
    ∀ (targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (_label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        (sourceAudited targetAudited).choice.local_tensor_state.packetState
  zeroObjectEstimate :
    ∀ targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        (theta_source.compatible_average.cuspLogVolume targetAudited).zeroLogVolume
  zeroObject_eq_packetLocalObject :
    ∀ targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (zeroObjectEstimate targetAudited).localObject =
        targetAudited.choice.local_tensor_state.packetState.localObject
  zeroSourceCompatibility :
    ∀ targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        (sourceAudited targetAudited).choice.local_tensor_state.packetState

/--
Classified local packet-normalized audit whose compatibility certificates come
from direct finite capsule-sum packet normalization on the target packet.
-/
structure FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  cuspClassObjectEstimate :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        ((theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label)
  cuspClassObject_eq_packetLocalObject :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (cuspClassObjectEstimate audited label).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  cuspClassDirectNormalization :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (_label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1DirectPacketNormalizationData
        audited.choice.local_tensor_state.packetState
  zeroObjectEstimate :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectContainerLogVolumeEstimate kind
        package.preLedger.targetVolume.targetSigned
        (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume
  zeroObject_eq_packetLocalObject :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (zeroObjectEstimate audited).localObject =
        audited.choice.local_tensor_state.packetState.localObject
  zeroDirectNormalization :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1DirectPacketNormalizationData
        audited.choice.local_tensor_state.packetState

/--
Transported source for cusp-class container bounds.

For each target audited packet, this audit chooses a source audited packet,
an audited `(Ind2)` direct-summand step from source to target, and capsule-entry
container estimates on the source.  The packet-normalized audit then converts
the transported packet-normalized bound into cusp-class and zero-label bounds
on the target.
-/
structure FLZModCuspLabelThetaInd2TransportedCuspClassAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  packet_normalized : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l
  sourceAudited :
    IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind ->
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind
  ind2_step :
    ∀ targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        (sourceAudited targetAudited) targetAudited
  sourceCapsuleEstimates :
    ∀ targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        (sourceAudited targetAudited).choice.local_tensor_state.packetState.capsuleFamily

/--
Direct capsule-estimate source for cusp-class container bounds.

For each audited packet, this audit supplies capsule-entry container estimates
directly on that packet's capsule family.  The packet-normalized audit converts
the resulting normalized packet bound into cusp-class and zero-label bounds.
-/
structure FLZModCuspLabelThetaDirectCapsuleCuspClassAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  packet_normalized : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l
  targetCapsuleEstimates :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.capsuleFamily

/--
Full-route input for the direct packet-normalization/direct capsule-estimate
route.
-/
structure FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  direct_packet :
    audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l
  targetCapsuleEstimates :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.capsuleFamily

/--
Direct local packet route where cusp/zero local object estimates are derived
from capsule estimates, direct packet normalization, and explicit
log-volume-to-local-object identifications.
-/
structure FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  targetCapsuleEstimates :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.capsuleFamily
  directNormalization :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1DirectPacketNormalizationData
        audited.choice.local_tensor_state.packetState
  cuspClassLogVolume_eq_localObjectFinite :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label =
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
  zeroLogVolume_eq_localObjectFinite :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume

/--
Direct identified local packet route with source classifications for the
cusp/zero-to-local-object log-volume identifications.
-/
structure FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  identified_route :
    audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l
  cuspClass_identification_source :
    ∀ (_audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (_label : (zmodSignAction l).SignLabelQuotient),
      IUTStage1LocalObjectLogVolumeIdentificationSource
  zero_identification_source :
    ∀ _audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1LocalObjectLogVolumeIdentificationSource

/--
Direct local packet route where the cusp/zero-to-local-object identifications
are derived by composing packet-normalized equalities with direct packet
normalization.
-/
structure FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  targetCapsuleEstimates :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.capsuleFamily
  directNormalization :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1DirectPacketNormalizationData
        audited.choice.local_tensor_state.packetState
  cuspClassLogVolume_eq_packetNormalized :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (label : (zmodSignAction l).SignLabelQuotient),
      (theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume
  zeroLogVolume_eq_packetNormalized :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume

/--
Direct route where cusp/zero packet-normalized equalities are derived from the
`ZMod l` averaged normalized log-volume family.
-/
structure FLZModCuspLabelThetaZModPacketNormalizedRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  targetCapsuleEstimates :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.capsuleFamily
  directNormalization :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1DirectPacketNormalizationData
        audited.choice.local_tensor_state.packetState
  zmodNormalizedLogVolume_eq_packetNormalized :
    ∀ (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
      (j : ZMod l.value),
      (theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume

/--
`ZMod l` packet-normalized route with an explicit source classification for
the bridge from averaged labels to packet-normalized capsule-family values.
-/
structure FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  zmod_packet_route :
    audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l
  bridge_source : IUTStage1ZModPacketNormalizedBridgeSource

/--
Direct `ZMod l` packet-normalized route where the averaged label family is the
constant packet-normalized family.
-/
structure FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  theta_source : audit.FLZModCuspLabelThetaSourceAudit l
  ind12_equality_part : audit.Ind12EqualityPart
  ind3_upper_part : audit.Ind3UpperInequalityPart
  theta_images_eq_endpoint :
    theta_source.theta_images = endpoint.theta_hull_endpoint.possible_images
  targetCapsuleEstimates :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited.choice.local_tensor_state.packetState.capsuleFamily
  directNormalization :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1DirectPacketNormalizationData
        audited.choice.local_tensor_state.packetState
  averagedLogVolume_eq_packetConstant :
    ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      (theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited) =
        IUTStage1LabelAveragedProcessionLogVolume.constant
          (label := ZMod l.value)
          audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume

/--
Full-route input for the `(Ind2)`-transported packet-normalization and
transported capsule-estimate route.
-/
structure FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  ind2_packet :
    audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l
  sourceCapsuleEstimates :
    ∀ targetAudited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        (ind2_packet.sourceAudited
          targetAudited).choice.local_tensor_state.packetState.capsuleFamily

/-- Source classification for cusp-class/zero-label bounds. -/
inductive IUTStage1CuspClassBoundSource where
  | directCapsuleEstimates
  | ind2TransportedCapsuleEstimates
  | separateAnalyticComparison
deriving DecidableEq

/--
Cusp-class container audit with an explicit source classification for the
cusp/zero bounds.
-/
structure FLZModCuspLabelThetaClassifiedCuspClassAudit
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  cusp_class_audit : audit.FLZModCuspLabelThetaCuspClassContainerAudit l
  bound_source : IUTStage1CuspClassBoundSource

theorem qCharted (audit : endpoint.LogVolumeChartAudit) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  audit.q_charted

theorem thetaCharted (audit : endpoint.LogVolumeChartAudit) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  audit.theta_charted

theorem targetSigned_eq_chosenVolume
    (audit : endpoint.LogVolumeChartAudit) :
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) :=
  audit.target_signed_eq_chosen_volume

theorem qSigned_le_thetaSigned
    (audit : endpoint.LogVolumeChartAudit) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  audit.q_signed_le_theta

theorem corollary312Endpoint
    (audit : endpoint.LogVolumeChartAudit) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  audit.corollary312_endpoint

namespace Ind12EqualityPart

variable {audit : endpoint.LogVolumeChartAudit}

theorem qCharted (part : audit.Ind12EqualityPart) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  part.q_charted

theorem thetaCharted (part : audit.Ind12EqualityPart) :
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  part.theta_charted

theorem qSigned_le_targetSigned (part : audit.Ind12EqualityPart) :
    package.preLedger.qSigned <= package.preLedger.targetVolume.targetSigned :=
  part.q_signed_le_target

end Ind12EqualityPart

namespace Ind3UpperInequalityPart

variable {audit : endpoint.LogVolumeChartAudit}

theorem targetSigned_le_thetaSigned
    (part : audit.Ind3UpperInequalityPart) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  part.target_signed_le_theta

theorem determinantVolumeBound
    (part : audit.Ind3UpperInequalityPart) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  part.determinant_volume_bound

end Ind3UpperInequalityPart

namespace ProcessionNormalizedInd12Audit

variable {audit : endpoint.LogVolumeChartAudit}

theorem ind12EqualityPart
    (part : audit.ProcessionNormalizedInd12Audit) :
    audit.Ind12EqualityPart :=
  part.ind12_equality_part

theorem ind1NormalizedLogVolumeEq
    (part : audit.ProcessionNormalizedInd12Audit)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.ind1_normalizedLogVolume_eq hstep

theorem ind2NormalizedLogVolumeEq
    (part : audit.ProcessionNormalizedInd12Audit)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.ind2_normalizedLogVolume_eq hstep

end ProcessionNormalizedInd12Audit

namespace LabelAveragedInd12Audit

variable {audit : endpoint.LogVolumeChartAudit}
variable {label : Type v} [Fintype label]

theorem ind1AverageLogVolumeEq
    (part : audit.LabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averagedLogVolume audited₁).averageLogVolume =
      (part.averagedLogVolume audited₂).averageLogVolume :=
  IUTStage1LabelAveragedProcessionLogVolume.average_eq_of_pointwise
    (part.ind1_labelwise_eq hstep)

theorem ind2AverageLogVolumeEq
    (part : audit.LabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averagedLogVolume audited₁).averageLogVolume =
      (part.averagedLogVolume audited₂).averageLogVolume :=
  IUTStage1LabelAveragedProcessionLogVolume.average_eq_of_pointwise
    (part.ind2_labelwise_eq hstep)

theorem localNormalizedAudit
    (part : audit.LabelAveragedInd12Audit label) :
    audit.ProcessionNormalizedInd12Audit :=
  part.normalized_audit

end LabelAveragedInd12Audit

namespace FLLabelAveragedInd12Audit

variable {audit : endpoint.LogVolumeChartAudit}
variable {label : Type v} [Fintype label]

theorem labelCard_eq_primeValue
    (part : audit.FLLabelAveragedInd12Audit label) :
    Fintype.card label = part.label_model.prime.value :=
  part.label_model.card_eq_primeValue

theorem localNormalizedAudit
    (part : audit.FLLabelAveragedInd12Audit label) :
    audit.ProcessionNormalizedInd12Audit :=
  part.averaged_audit.localNormalizedAudit

theorem ind1AverageLogVolumeEq
    (part : audit.FLLabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.averaged_audit.ind1AverageLogVolumeEq hstep

theorem ind2AverageLogVolumeEq
    (part : audit.FLLabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.averaged_audit.ind2AverageLogVolumeEq hstep

end FLLabelAveragedInd12Audit

namespace FLLabelTorsorAveragedInd12Audit

variable {audit : endpoint.LogVolumeChartAudit}
variable {label : Type} [Fintype label]

def toFLLabelAveragedInd12Audit
    (part : audit.FLLabelTorsorAveragedInd12Audit label) :
    audit.FLLabelAveragedInd12Audit label :=
  { label_model := part.torsor_model.label_model,
    averaged_audit := part.averaged_audit }

theorem labelCard_eq_primeValue
    (part : audit.FLLabelTorsorAveragedInd12Audit label) :
    Fintype.card label = part.torsor_model.label_model.prime.value :=
  part.toFLLabelAveragedInd12Audit.labelCard_eq_primeValue

theorem labelTorsorVadd_eq_zmod
    (part : audit.FLLabelTorsorAveragedInd12Audit label)
    (t : ZMod part.torsor_model.label_model.prime.value) (j : label) :
    part.torsor_model.torsor.vadd t j =
      part.torsor_model.label_model.fromZMod
        (t + part.torsor_model.label_model.toZMod j) :=
  part.torsor_model.vadd_eq_zmod t j

theorem localNormalizedAudit
    (part : audit.FLLabelTorsorAveragedInd12Audit label) :
    audit.ProcessionNormalizedInd12Audit :=
  part.averaged_audit.localNormalizedAudit

theorem ind1AverageLogVolumeEq
    (part : audit.FLLabelTorsorAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.averaged_audit.ind1AverageLogVolumeEq hstep

theorem ind2AverageLogVolumeEq
    (part : audit.FLLabelTorsorAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.averaged_audit.ind2AverageLogVolumeEq hstep

end FLLabelTorsorAveragedInd12Audit

namespace FLZModCuspLabelAveragedInd12Audit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem labelCard_eq_primeValue
    (_part : audit.FLZModCuspLabelAveragedInd12Audit l) :
    Fintype.card (ZMod l.value) = l.value := by
  rw [ZMod.card]

theorem localNormalizedAudit
    (part : audit.FLZModCuspLabelAveragedInd12Audit l) :
    audit.ProcessionNormalizedInd12Audit :=
  part.averaged_audit.localNormalizedAudit

theorem canonicalLabelTranslate
    (part : audit.FLZModCuspLabelAveragedInd12Audit l) :
    part.cusp_label_model.local_lab_cusp_model.canonicalNonzeroLabel.1 =
      part.cusp_label_model.local_lab_cusp_model.additiveTorsor.vadd
        part.cusp_label_model.local_lab_cusp_model.canonicalCoordinate
        part.cusp_label_model.local_lab_cusp_model.labelQuotient.zero :=
  part.cusp_label_model.canonicalLabelTranslate

theorem labelClass_eq_model_quotient
    (part : audit.FLZModCuspLabelAveragedInd12Audit l) :
    part.cusp_label_model.cusp_label_class_data.labelClass =
      part.cusp_label_model.cusp_label_class_data.model.signAction.toSignLabelQuotient
        part.cusp_label_model.cusp_label_class_data.model.canonicalNonzeroLabel :=
  part.cusp_label_model.labelClass_eq_model_quotient

theorem ind1AverageLogVolumeEq
    (part : audit.FLZModCuspLabelAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.averaged_audit.ind1AverageLogVolumeEq hstep

theorem ind2AverageLogVolumeEq
    (part : audit.FLZModCuspLabelAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.averaged_audit.ind2AverageLogVolumeEq hstep

end FLZModCuspLabelAveragedInd12Audit

namespace FLZModCuspLabelCompatibleAveragedInd12Audit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem localNormalizedAudit
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l) :
    audit.ProcessionNormalizedInd12Audit :=
  part.zmod_cusp_audit.localNormalizedAudit

theorem normalizedLogVolumeEq
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume j =
      (part.cuspLogVolume audited).normalizedLogVolume j :=
  part.normalizedLogVolume_eq audited j

theorem nonzeroAverageLabel_eq_cuspClass
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume j =
      (part.cuspLogVolume audited).cuspClassLogVolume
        (zmodSignLabelFromCoordinate l j hj) := by
  calc
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume j =
        (part.cuspLogVolume audited).normalizedLogVolume j :=
      part.normalizedLogVolumeEq audited j
    _ =
        (part.cuspLogVolume audited).cuspClassLogVolume
          (zmodSignLabelFromCoordinate l j hj) :=
      (part.cuspLogVolume audited).nonzero_eq j hj

theorem zeroAverageLabel_eq_zeroLogVolume
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume 0 =
      (part.cuspLogVolume audited).zeroLogVolume := by
  calc
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume 0 =
        (part.cuspLogVolume audited).normalizedLogVolume 0 :=
      part.normalizedLogVolumeEq audited 0
    _ = (part.cuspLogVolume audited).zeroLogVolume :=
      (part.cuspLogVolume audited).zero_eq_zeroLogVolume

theorem averageLabel_eq_fullLabelLogVolume_fromCoordinate
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume j =
      (part.cuspLogVolume audited).fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  calc
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume j =
        (part.cuspLogVolume audited).normalizedLogVolume j :=
      part.normalizedLogVolumeEq audited j
    _ =
        (part.cuspLogVolume audited).fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
      (part.cuspLogVolume audited).normalizedLogVolume_eq_fullLabelLogVolume_fromCoordinate j

theorem averageFullLabelLogVolume_fromCoordinate_zero
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.cuspLogVolume audited).fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (0 : ZMod l.value)) =
      (part.cuspLogVolume audited).zeroLogVolume :=
  (part.cuspLogVolume audited).fullLabelLogVolume_fromCoordinate_zero

theorem averageFullLabelLogVolume_fromCoordinate_nonzero
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    (part.cuspLogVolume audited).fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      (part.cuspLogVolume audited).cuspClassLogVolume
        (zmodSignLabelFromCoordinate l j hj) :=
  (part.cuspLogVolume audited).fullLabelLogVolume_fromCoordinate_nonzero j hj

noncomputable def squareWeightedAveragedLogVolume
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1WeightedLabelAveragedProcessionLogVolume (ZMod l.value) :=
  profile.toWeighted
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited)

theorem squareWeighted_normalizedLogVolume_eq_fullLabelLogVolume
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.squareWeightedAveragedLogVolume profile audited).normalizedLogVolume j =
      (part.cuspLogVolume audited).fullLabelLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  profile.toWeighted_normalizedLogVolume_eq_fullLabelLogVolume
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited)
    (part.cuspLogVolume audited)
    (fun j => part.normalizedLogVolumeEq audited j)
    j

theorem squareWeighted_weight_eq_square_val
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.squareWeightedAveragedLogVolume profile audited).weight j =
      ((j.val : Real) ^ 2) :=
  profile.toWeighted_weight_eq_square_val
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited)
    j

theorem squareWeighted_summand_eq_square_fullLabelLogVolume
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.squareWeightedAveragedLogVolume profile audited).weight j *
        (part.squareWeightedAveragedLogVolume profile audited).normalizedLogVolume j =
      ((j.val : Real) ^ 2) *
        (part.cuspLogVolume audited).fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  profile.toWeighted_weightedSummand_eq_square_fullLabelLogVolume
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited)
    (part.cuspLogVolume audited)
    (fun j => part.normalizedLogVolumeEq audited j)
    j

theorem squareWeightedAverage_eq_square_fullLabelLogVolume_sum
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.squareWeightedAveragedLogVolume profile audited).weightedAverageLogVolume =
      (Finset.univ.sum fun j : ZMod l.value =>
        ((j.val : Real) ^ 2) *
          (part.cuspLogVolume audited).fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) /
        profile.weightTotal :=
  profile.toWeighted_weightedAverage_eq_square_fullLabelLogVolume_sum
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited)
    (part.cuspLogVolume audited)
    (fun j => part.normalizedLogVolumeEq audited j)

theorem ind1SquareWeightedAverageLogVolumeEq
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.squareWeightedAveragedLogVolume profile audited₁).weightedAverageLogVolume =
      (part.squareWeightedAveragedLogVolume profile audited₂).weightedAverageLogVolume :=
  IUTStage1WeightedLabelAveragedProcessionLogVolume.weightedAverage_eq_of_pointwise
    (fun _j => rfl)
    (part.zmod_cusp_audit.averaged_audit.ind1_labelwise_eq hstep)
    rfl

theorem ind2SquareWeightedAverageLogVolumeEq
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.squareWeightedAveragedLogVolume profile audited₁).weightedAverageLogVolume =
      (part.squareWeightedAveragedLogVolume profile audited₂).weightedAverageLogVolume :=
  IUTStage1WeightedLabelAveragedProcessionLogVolume.weightedAverage_eq_of_pointwise
    (fun _j => rfl)
    (part.zmod_cusp_audit.averaged_audit.ind2_labelwise_eq hstep)
    rfl

theorem ind1AverageLogVolumeEq
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.zmod_cusp_audit.ind1AverageLogVolumeEq hstep

theorem ind2AverageLogVolumeEq
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.zmod_cusp_audit.ind2AverageLogVolumeEq hstep

end FLZModCuspLabelCompatibleAveragedInd12Audit

namespace FLZModCuspLabelThetaSourceAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem thetaPilotMatchesPackage
    (part : audit.FLZModCuspLabelThetaSourceAudit l) :
    part.theta_images.thetaPilot = package.thetaPilot :=
  part.theta_images.thetaPilotMatchesPackage

theorem indeterminaciesMatchPackage
    (part : audit.FLZModCuspLabelThetaSourceAudit l) :
    part.theta_images.indeterminacies = package.indeterminacies :=
  part.theta_images.indeterminaciesMatchPackage

theorem thetaSourceAverage_eq
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.thetaSourceAverage audited =
      (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume :=
  part.thetaSourceAverage_eq_average audited

theorem averageLogVolume_le_thetaSigned
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume <= package.preLedger.thetaSigned := by
  rw [← part.thetaSourceAverage_eq audited]
  exact part.thetaSourceAverage_le_thetaSigned audited

theorem nonzeroAverageLabel_eq_cuspClass
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      (part.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        (zmodSignLabelFromCoordinate l j hj) :=
  part.compatible_average.nonzeroAverageLabel_eq_cuspClass audited j hj

theorem ind1AverageLogVolumeEq
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited₁).averageLogVolume =
      (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited₂).averageLogVolume :=
  part.compatible_average.ind1AverageLogVolumeEq hstep

theorem ind2AverageLogVolumeEq
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited₁).averageLogVolume =
      (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited₂).averageLogVolume :=
  part.compatible_average.ind2AverageLogVolumeEq hstep

end FLZModCuspLabelThetaSourceAudit

namespace FLZModCuspLabelQThetaComparisonAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem qPilotLogVolumeMatchesPackage
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l) :
    part.qPilotLogVolume = package.qPilotLogVolume :=
  part.qPilotLogVolume_eq_package

theorem qSourceLogVolume_eq
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l) :
    part.qSourceLogVolume = package.preLedger.qSigned :=
  part.qSourceLogVolume_eq_qSigned

theorem qSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= part.theta_source.thetaSourceAverage audited := by
  rw [← part.qSourceLogVolume_eq]
  exact part.qSourceLogVolume_le_thetaAverage audited

theorem qSigned_le_averageLogVolume
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <=
      ((part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit).averagedLogVolume
        audited).averageLogVolume := by
  rw [← part.theta_source.thetaSourceAverage_eq audited]
  exact part.qSigned_le_thetaSourceAverage audited

theorem qSigned_le_thetaSigned_via_average
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  le_trans
    (part.qSigned_le_thetaSourceAverage audited)
    (part.theta_source.thetaSourceAverage_le_thetaSigned audited)

theorem averageLogVolume_le_thetaSigned
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    ((part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit).averagedLogVolume
        audited).averageLogVolume <=
      package.preLedger.thetaSigned :=
  part.theta_source.averageLogVolume_le_thetaSigned audited

theorem ind1AverageLogVolumeEq
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    ((part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit).averagedLogVolume
        audited₁).averageLogVolume =
      ((part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit).averagedLogVolume
        audited₂).averageLogVolume :=
  part.theta_source.ind1AverageLogVolumeEq hstep

theorem ind2AverageLogVolumeEq
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    ((part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit).averagedLogVolume
        audited₁).averageLogVolume =
      ((part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit).averagedLogVolume
        audited₂).averageLogVolume :=
  part.theta_source.ind2AverageLogVolumeEq hstep

end FLZModCuspLabelQThetaComparisonAudit

namespace FLZModCuspLabelFinalComparisonAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem qSigned_le_thetaSigned_from_average
    (part : audit.FLZModCuspLabelFinalComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.q_theta_comparison.qSigned_le_thetaSigned_via_average audited

theorem qSigned_le_thetaSigned_from_chart
    (_part : audit.FLZModCuspLabelFinalComparisonAudit l) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  audit.qSigned_le_thetaSigned

theorem corollary312FromAverage
    (part : audit.FLZModCuspLabelFinalComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  corollary312_of_signed_le
    (part.qSigned_le_thetaSigned_from_average audited)

theorem corollary312FromChart
    (_part : audit.FLZModCuspLabelFinalComparisonAudit l) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  audit.corollary312Endpoint

theorem ind3TargetSigned_le_thetaSigned
    (part : audit.FLZModCuspLabelFinalComparisonAudit l) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  part.ind3_upper_part.targetSigned_le_thetaSigned

theorem determinantVolumeBound
    (part : audit.FLZModCuspLabelFinalComparisonAudit l) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  part.ind3_upper_part.determinantVolumeBound

def averagedAudit
    (part : audit.FLZModCuspLabelFinalComparisonAudit l) :
    audit.LabelAveragedInd12Audit (ZMod l.value) :=
  part.q_theta_comparison.theta_source.compatible_average.zmod_cusp_audit.averaged_audit

theorem averageLogVolume_le_thetaSigned
    (part : audit.FLZModCuspLabelFinalComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    ((part.averagedAudit).averagedLogVolume audited).averageLogVolume <=
      package.preLedger.thetaSigned :=
  part.q_theta_comparison.averageLogVolume_le_thetaSigned audited

end FLZModCuspLabelFinalComparisonAudit

namespace FLZModCuspLabelTargetAverageReductionAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem qSigned_le_targetSigned
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l) :
    package.preLedger.qSigned <= package.preLedger.targetVolume.targetSigned :=
  part.ind12_equality_part.qSigned_le_targetSigned

theorem qSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= part.theta_source.thetaSourceAverage audited :=
  le_trans
    part.qSigned_le_targetSigned
    (part.targetSigned_le_thetaAverage audited)

def toQThetaComparisonAudit
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l) :
    audit.FLZModCuspLabelQThetaComparisonAudit l :=
  { theta_source := part.theta_source,
    qPilotLogVolume := package.qPilotLogVolume,
    qPilotLogVolume_eq_package := rfl,
    qSourceLogVolume := package.preLedger.qSigned,
    qSourceLogVolume_eq_qSigned := rfl,
    qSourceLogVolume_le_thetaAverage := by
      intro audited
      exact part.qSigned_le_thetaSourceAverage audited }

theorem toQThetaComparisonAudit_qSigned_le_thetaSigned
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toQThetaComparisonAudit.qSigned_le_thetaSigned_via_average audited

theorem targetSigned_le_thetaSigned_via_average
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <= package.preLedger.thetaSigned :=
  le_trans
    (part.targetSigned_le_thetaAverage audited)
    (part.theta_source.thetaSourceAverage_le_thetaSigned audited)

end FLZModCuspLabelTargetAverageReductionAudit

namespace FLZModCuspLabelThetaPilotHullContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem thetaSourceUnion_subset_hull
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    Region.Subset part.theta_source.theta_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull := by
  rw [part.theta_images_eq_endpoint]
  exact endpoint.theta_hull_endpoint.possibleImagesUnion_subset_hull

theorem thetaSourceUnion_eq_targetUnion
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    part.theta_source.theta_images.union =
      package.preLedger.output.comparisons.targetUnion := by
  rw [part.theta_images_eq_endpoint]
  exact endpoint.theta_hull_endpoint.possibleImagesUnion_eq_targetUnion

theorem thetaSourceChoiceRegion_eq_targetRegion
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.theta_source.theta_images.images.region audited =
      (package.preLedger.output.comparison audited).targetRegion :=
  part.theta_source.theta_images.choice_region_eq_targetRegion audited

theorem determinantVolumeBound
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  part.ind3_upper_part.determinantVolumeBound

theorem targetSigned_le_thetaAverage
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaAverage_from_hull_container audited

def toThetaContainerBoundAudit
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    audit.FLZModCuspLabelThetaContainerBoundAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    bound_source := IUTStage1TargetAverageBoundSource.thetaPilotHullContainer,
    bound_source_not_ind3_only := (by intro h; cases h),
    targetSigned_le_thetaAverage :=
      part.targetSigned_le_thetaAverage_from_hull_container }

theorem boundSource_eq_thetaPilotHullContainer
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    part.toThetaContainerBoundAudit.bound_source =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  rfl

theorem qSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= part.theta_source.thetaSourceAverage audited :=
  le_trans
    part.ind12_equality_part.qSigned_le_targetSigned
    (part.targetSigned_le_thetaAverage audited)

theorem qSigned_le_thetaSigned_via_hull_container
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  le_trans
    (part.qSigned_le_thetaSourceAverage audited)
    (part.theta_source.thetaSourceAverage_le_thetaSigned audited)

end FLZModCuspLabelThetaPilotHullContainerAudit

namespace FLZModCuspLabelThetaLabelwiseContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_normalizedLogVolume'
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j :=
  part.targetSigned_le_normalizedLogVolume audited j

theorem targetSigned_le_averageLogVolume
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume :=
  IUTStage1LabelAveragedProcessionLogVolume.const_le_average_of_forall_le
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
      audited)
    (part.targetSigned_le_normalizedLogVolume audited)

theorem targetSigned_le_thetaAverage
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited := by
  rw [part.theta_source.thetaSourceAverage_eq audited]
  exact part.targetSigned_le_averageLogVolume audited

def toThetaPilotHullContainerAudit
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetSigned_le_thetaAverage_from_hull_container :=
      part.targetSigned_le_thetaAverage }

theorem thetaSourceUnion_subset_hull
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l) :
    Region.Subset part.theta_source.theta_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  part.toThetaPilotHullContainerAudit.thetaSourceUnion_subset_hull

theorem boundSource_eq_thetaPilotHullContainer
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l) :
    part.toThetaPilotHullContainerAudit.toThetaContainerBoundAudit.bound_source =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  rfl

theorem qSigned_le_thetaSigned_via_labelwise_container
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaPilotHullContainerAudit.qSigned_le_thetaSigned_via_hull_container
    audited

end FLZModCuspLabelThetaLabelwiseContainerAudit

namespace FLZModCuspLabelThetaCuspClassContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_cuspClassLogVolume'
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label :=
  part.targetSigned_le_cuspClassLogVolume audited label

theorem targetSigned_le_zeroLogVolume'
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
  part.targetSigned_le_zeroLogVolume audited

theorem targetSigned_le_normalizedLogVolume
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j := by
  by_cases hj : j = 0
  · subst j
    rw [part.theta_source.compatible_average.zeroAverageLabel_eq_zeroLogVolume
      audited]
    exact part.targetSigned_le_zeroLogVolume audited
  · rw [part.theta_source.compatible_average.nonzeroAverageLabel_eq_cuspClass
      audited j hj]
    exact
      part.targetSigned_le_cuspClassLogVolume audited
        (zmodSignLabelFromCoordinate l j hj)

def toThetaLabelwiseContainerAudit
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l) :
    audit.FLZModCuspLabelThetaLabelwiseContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetSigned_le_normalizedLogVolume :=
      part.targetSigned_le_normalizedLogVolume }

theorem targetSigned_le_averageLogVolume
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume :=
  part.toThetaLabelwiseContainerAudit.targetSigned_le_averageLogVolume audited

theorem targetSigned_le_thetaAverage
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.toThetaLabelwiseContainerAudit.targetSigned_le_thetaAverage audited

def toThetaPilotHullContainerAudit
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.toThetaLabelwiseContainerAudit.toThetaPilotHullContainerAudit

theorem qSigned_le_thetaSigned_via_cusp_container
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaLabelwiseContainerAudit.qSigned_le_thetaSigned_via_labelwise_container
    audited

end FLZModCuspLabelThetaCuspClassContainerAudit

namespace FLZModCuspLabelThetaLocalContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label :=
  (part.cuspClassEstimate audited label).targetSigned_le_localLogVolume

theorem targetSigned_le_zeroLogVolume
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
  (part.zeroEstimate audited).targetSigned_le_localLogVolume

def toThetaCuspClassContainerAudit
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l) :
    audit.FLZModCuspLabelThetaCuspClassContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetSigned_le_cuspClassLogVolume :=
      part.targetSigned_le_cuspClassLogVolume,
    targetSigned_le_zeroLogVolume :=
      part.targetSigned_le_zeroLogVolume }

theorem targetSigned_le_normalizedLogVolume
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j :=
  part.toThetaCuspClassContainerAudit.targetSigned_le_normalizedLogVolume
    audited j

def toThetaPilotHullContainerAudit
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.toThetaCuspClassContainerAudit.toThetaPilotHullContainerAudit

theorem qSigned_le_thetaSigned_via_local_container
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit.qSigned_le_thetaSigned_via_cusp_container
    audited

end FLZModCuspLabelThetaLocalContainerAudit

namespace FLZModCuspLabelThetaLocalObjectContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label :=
  (part.cuspClassObjectEstimate audited label).targetSigned_le_localLogVolume

theorem targetSigned_le_zeroLogVolume
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
  (part.zeroObjectEstimate audited).targetSigned_le_localLogVolume

def toThetaLocalContainerAudit
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaLocalContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    cuspClassEstimate := by
      intro audited label
      exact
        (part.cuspClassObjectEstimate audited label).toLocalContainerEstimate,
    zeroEstimate := by
      intro audited
      exact (part.zeroObjectEstimate audited).toLocalContainerEstimate }

def toThetaPilotHullContainerAudit
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.toThetaLocalContainerAudit.toThetaPilotHullContainerAudit

theorem qSigned_le_thetaSigned_via_local_object_container
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaLocalContainerAudit.qSigned_le_thetaSigned_via_local_container
    audited

end FLZModCuspLabelThetaLocalObjectContainerAudit

namespace FLZModCuspLabelThetaPacketLocalObjectContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem cuspClassObject_eq_packetLocalObject'
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.cuspClassObjectEstimate audited label).localObject =
      audited.choice.local_tensor_state.packetState.localObject :=
  part.cuspClassObject_eq_packetLocalObject audited label

theorem zeroObject_eq_packetLocalObject'
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.zeroObjectEstimate audited).localObject =
      audited.choice.local_tensor_state.packetState.localObject :=
  part.zeroObject_eq_packetLocalObject audited

theorem localLabCuspModel_eq_zmod
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    (part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model).local_lab_cusp_model =
      zmodLocalLabCuspModel l :=
  let model :=
    part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model
  model.localLabCuspModel_eq_zmod

theorem cuspLabelClassData_eq_zmod
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    (part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model).cusp_label_class_data =
      zmodCanonicalCuspLabelClassData l :=
  let model :=
    part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model
  model.cuspLabelClassData_eq_zmod

def toThetaLocalObjectContainerAudit
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaLocalObjectContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    cuspClassObjectEstimate := part.cuspClassObjectEstimate,
    zeroObjectEstimate := part.zeroObjectEstimate }

theorem targetSigned_le_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label :=
  part.toThetaLocalObjectContainerAudit.targetSigned_le_cuspClassLogVolume
    audited label

def toThetaPilotHullContainerAudit
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.toThetaLocalObjectContainerAudit.toThetaPilotHullContainerAudit

theorem qSigned_le_thetaSigned_via_packet_local_object_container
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaLocalObjectContainerAudit.qSigned_le_thetaSigned_via_local_object_container
    audited

def toDirectLocalPacketNormalizedAudit
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState) :
    audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    cuspClassObjectEstimate := part.cuspClassObjectEstimate,
    cuspClassObject_eq_packetLocalObject :=
      part.cuspClassObject_eq_packetLocalObject,
    cuspClassDirectNormalization := by
      intro audited _label
      exact directNormalization audited,
    zeroObjectEstimate := part.zeroObjectEstimate,
    zeroObject_eq_packetLocalObject := part.zeroObject_eq_packetLocalObject,
    zeroDirectNormalization := directNormalization }

def toDirectLocalPacketDirectCapsuleRouteAudit
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState)
    (targetCapsuleEstimates :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1TypedCapsuleFamilyContainerEstimate
          package.preLedger.targetVolume.targetSigned
          audited.choice.local_tensor_state.packetState.capsuleFamily) :
    audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l :=
  { direct_packet := part.toDirectLocalPacketNormalizedAudit directNormalization,
    targetCapsuleEstimates := targetCapsuleEstimates }

end FLZModCuspLabelThetaPacketLocalObjectContainerAudit

namespace FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectLocalCuspConstruction
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  { packet_local_object := part,
    estimate_source :=
      IUTStage1PacketLocalObjectEstimateSource.directLocalCuspConstruction }

def ofInd2TransportedLocalCuspConstruction
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  { packet_local_object := part,
    estimate_source :=
      IUTStage1PacketLocalObjectEstimateSource.ind2TransportedLocalCuspConstruction }

def ofSeparateLocalObjectEstimate
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  { packet_local_object := part,
    estimate_source :=
      IUTStage1PacketLocalObjectEstimateSource.separateLocalObjectEstimate }

def toPacketLocalObjectContainerAudit
    (part : audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l :=
  part.packet_local_object

end FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit

namespace FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def cuspClassObjectEstimate
    (part : audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    IUTStage1LocalObjectContainerLogVolumeEstimate kind
      package.preLedger.targetVolume.targetSigned
      ((part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label) :=
  (part.packetLocalObjectEstimate audited).transportLocalLogVolume
    (part.cuspClassLogVolume_eq_packetLocalObjectFinite audited label)

def zeroObjectEstimate
    (part : audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1LocalObjectContainerLogVolumeEstimate kind
      package.preLedger.targetVolume.targetSigned
      (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
  (part.packetLocalObjectEstimate audited).transportLocalLogVolume
    (part.zeroLogVolume_eq_packetLocalObjectFinite audited)

def toPacketLocalObjectContainerAudit
    (part : audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    cuspClassObjectEstimate := part.cuspClassObjectEstimate,
    cuspClassObject_eq_packetLocalObject := by
      intro audited _label
      exact part.packetLocalObjectEstimate_eq_packetLocalObject audited,
    zeroObjectEstimate := part.zeroObjectEstimate,
    zeroObject_eq_packetLocalObject := by
      intro audited
      exact part.packetLocalObjectEstimate_eq_packetLocalObject audited }

open FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit in
def toClassifiedPacketLocalObjectContainerAudit
    (part : audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  ofDirectLocalCuspConstruction part.toPacketLocalObjectContainerAudit

theorem estimateSource_eq_direct
    (part : audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l) :
    part.toClassifiedPacketLocalObjectContainerAudit.estimate_source =
      IUTStage1PacketLocalObjectEstimateSource.directLocalCuspConstruction :=
  rfl

end FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit

namespace FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem cuspLogVolume_normalized_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume j =
        (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume j :=
      (part.theta_source.compatible_average.normalizedLogVolume_eq audited j).symm
    _ = audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
      part.zmodNormalizedLogVolume_eq_packetLocalObjectFinite audited j

theorem cuspClassLogVolume_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.cuspClass_eq_of_normalizedLogVolume_eq
    (part.theta_source.compatible_average.cuspLogVolume audited)
    (part.cuspLogVolume_normalized_eq_packetLocalObjectFinite audited)
    label

theorem zeroLogVolume_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.zeroLogVolume_eq_of_normalizedLogVolume_eq
    (part.theta_source.compatible_average.cuspLogVolume audited)
    (part.cuspLogVolume_normalized_eq_packetLocalObjectFinite audited)

theorem thetaSourceAverage_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.theta_source.thetaSourceAverage audited =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
  let averaged :=
    part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
      audited
  have haverage :
      averaged.averageLogVolume =
        (IUTStage1LabelAveragedProcessionLogVolume.constant
          (label := ZMod l.value)
          audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
        ).averageLogVolume :=
    IUTStage1LabelAveragedProcessionLogVolume.average_eq_of_pointwise
      (part.zmodNormalizedLogVolume_eq_packetLocalObjectFinite audited)
  calc
    part.theta_source.thetaSourceAverage audited =
        averaged.averageLogVolume :=
      part.theta_source.thetaSourceAverage_eq_average audited
    _ =
        (IUTStage1LabelAveragedProcessionLogVolume.constant
          (label := ZMod l.value)
          audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume
        ).averageLogVolume :=
      haverage
    _ = audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
      rfl

theorem targetSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited := by
  have hpacket :
      package.preLedger.targetVolume.targetSigned <=
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
    (part.packetLocalObjectEstimate audited).targetSigned_le_localLogVolume
  rw [part.thetaSourceAverage_eq_packetLocalObjectFinite audited]
  exact hpacket

def toSharedPacketLocalObjectEstimateAudit
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    cuspClassLogVolume_eq_packetLocalObjectFinite :=
      part.cuspClassLogVolume_eq_packetLocalObjectFinite,
    zeroLogVolume_eq_packetLocalObjectFinite :=
      part.zeroLogVolume_eq_packetLocalObjectFinite }

def toClassifiedPacketLocalObjectContainerAudit
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  part.toSharedPacketLocalObjectEstimateAudit.toClassifiedPacketLocalObjectContainerAudit

theorem estimateSource_eq_direct
    (part : audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l) :
    part.toClassifiedPacketLocalObjectContainerAudit.estimate_source =
      IUTStage1PacketLocalObjectEstimateSource.directLocalCuspConstruction :=
  rfl

end FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit

namespace FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem zmodNormalizedLogVolume_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
  have h :=
    congrArg (fun data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value) =>
      data.normalizedLogVolume j)
      (part.averagedLogVolume_eq_packetLocalObjectConstant audited)
  simpa [IUTStage1LabelAveragedProcessionLogVolume.constant] using h

def toSharedZModPacketLocalObjectEstimateAudit
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    zmodNormalizedLogVolume_eq_packetLocalObjectFinite :=
      part.zmodNormalizedLogVolume_eq_packetLocalObjectFinite }

def toSharedPacketLocalObjectEstimateAudit
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l :=
  part.toSharedZModPacketLocalObjectEstimateAudit.toSharedPacketLocalObjectEstimateAudit

def toClassifiedPacketLocalObjectContainerAudit
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  part.toSharedZModPacketLocalObjectEstimateAudit.toClassifiedPacketLocalObjectContainerAudit

theorem thetaSourceAverage_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.theta_source.thetaSourceAverage audited =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  let sharedZMod := part.toSharedZModPacketLocalObjectEstimateAudit
  sharedZMod.thetaSourceAverage_eq_packetLocalObjectFinite audited

theorem targetSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  let sharedZMod := part.toSharedZModPacketLocalObjectEstimateAudit
  sharedZMod.targetSigned_le_thetaSourceAverage audited

end FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit

namespace FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectLocalLabelObjectConstruction
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l :=
  { constant_route := part,
    bridge_source :=
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction }

def ofInd12TransportedLocalLabelObjectConstruction
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l :=
  { constant_route := part,
    bridge_source :=
      IUTStage1ZModPacketLocalObjectBridgeSource.ind12TransportedLocalLabelObjectConstruction }

def ofSeparateLocalObjectIdentification
    (part : audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l :=
  { constant_route := part,
    bridge_source :=
      IUTStage1ZModPacketLocalObjectBridgeSource.separateLocalObjectIdentification }

def toConstantZModPacketLocalObjectEstimateAudit
    (part :
      audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l :=
  part.constant_route

theorem targetSigned_le_thetaSourceAverage
    (part :
      audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.constant_route.theta_source.thetaSourceAverage audited :=
  part.constant_route.targetSigned_le_thetaSourceAverage audited

end FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit

namespace FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem zmodNormalizedLogVolume_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
        (part.labelLocalObject audited j).finiteLogVolume :=
      part.normalizedLogVolume_eq_labelLocalObjectFinite audited j
    _ = audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
      rw [part.labelLocalObject_eq_packetLocalObject audited j]

theorem localLabCuspModel_eq_zmod
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    (part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model).local_lab_cusp_model =
      zmodLocalLabCuspModel l :=
  let model :=
    part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model
  model.localLabCuspModel_eq_zmod

theorem cuspLabelClassData_eq_zmod
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    (part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model).cusp_label_class_data =
      zmodCanonicalCuspLabelClassData l :=
  let model :=
    part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model
  model.cuspLabelClassData_eq_zmod

def toSharedZModPacketLocalObjectEstimateAudit
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    zmodNormalizedLogVolume_eq_packetLocalObjectFinite :=
      part.zmodNormalizedLogVolume_eq_packetLocalObjectFinite }

theorem cuspClassLogVolume_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  let sharedZMod := part.toSharedZModPacketLocalObjectEstimateAudit
  sharedZMod.cuspClassLogVolume_eq_packetLocalObjectFinite audited label

theorem canonicalCuspClassLogVolume_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        (zmodCanonicalSignLabelQuotient l) =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.cuspClassLogVolume_eq_packetLocalObjectFinite
    audited (zmodCanonicalSignLabelQuotient l)

theorem zeroLogVolume_eq_packetLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  let sharedZMod := part.toSharedZModPacketLocalObjectEstimateAudit
  sharedZMod.zeroLogVolume_eq_packetLocalObjectFinite audited

def toConstantZModPacketLocalObjectEstimateAudit
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    averagedLogVolume_eq_packetLocalObjectConstant := by
      intro audited
      exact
        IUTStage1LabelAveragedProcessionLogVolume.eq_constant_of_forall_eq
          (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
            audited)
          (part.zmodNormalizedLogVolume_eq_packetLocalObjectFinite audited) }

open FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit in
def toClassifiedConstantZModPacketLocalObjectEstimateAudit
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l :=
  ofDirectLocalLabelObjectConstruction part.toConstantZModPacketLocalObjectEstimateAudit

theorem bridgeSource_eq_direct
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    part.toClassifiedConstantZModPacketLocalObjectEstimateAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  rfl

theorem targetSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  let constantRoute := part.toConstantZModPacketLocalObjectEstimateAudit
  constantRoute.targetSigned_le_thetaSourceAverage audited

end FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit

namespace FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

noncomputable def labelLocalObject
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    IUTStage1FiniteLocalLogVolumeObject kind := by
  by_cases hj : j = 0
  · exact part.zeroLocalObject audited
  · exact part.cuspClassLocalObject audited (zmodSignLabelFromCoordinate l j hj)

def fullLabelLocalObject
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1FiniteLocalLogVolumeObject kind :=
  IUTStage1ZModCuspFullLabel.localObject
    (part.zeroLocalObject audited)
    (part.cuspClassLocalObject audited)
    label

theorem fullLabelLocalObject_zero
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.fullLabelLocalObject audited IUTStage1ZModCuspFullLabel.zero =
      part.zeroLocalObject audited :=
  rfl

theorem fullLabelLocalObject_nonzero
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.nonzero label) =
      part.cuspClassLocalObject audited label :=
  rfl

theorem labelLocalObject_eq_fullLabelLocalObject_fromCoordinate
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    part.labelLocalObject audited j =
      part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  classical
  unfold labelLocalObject fullLabelLocalObject
  by_cases hj : j = 0
  · subst j
    simp [IUTStage1ZModCuspFullLabel.fromCoordinate,
      IUTStage1ZModCuspFullLabel.localObject]
  · simp [IUTStage1ZModCuspFullLabel.fromCoordinate,
      IUTStage1ZModCuspFullLabel.localObject, hj]

theorem fullLabelLocalObject_fromCoordinate_zero
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (0 : ZMod l.value)) =
      part.zeroLocalObject audited := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_zero]
  rfl

theorem fullLabelLocalObject_fromCoordinate_nonzero
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj) := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero l j hj]
  rfl

theorem fullLabelLocalObject_fromCoordinate_neg_eq
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (-j)) =
      part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_neg l j hj]

theorem normalizedLogVolume_eq_labelLocalObjectFinite
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      (part.labelLocalObject audited j).finiteLogVolume := by
  classical
  unfold labelLocalObject
  by_cases hj : j = 0
  · subst j
    simp only [↓reduceDIte]
    calc
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume 0 =
          (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume 0 :=
        part.theta_source.compatible_average.normalizedLogVolumeEq audited 0
      _ = (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
        (part.theta_source.compatible_average.cuspLogVolume audited).zero_eq_zeroLogVolume
      _ = (part.zeroLocalObject audited).finiteLogVolume :=
        part.zeroLogVolume_eq_localObjectFinite audited
  · simp only [hj, ↓reduceDIte]
    calc
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume j =
          (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume j :=
        part.theta_source.compatible_average.normalizedLogVolumeEq audited j
      _ =
          (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
            (zmodSignLabelFromCoordinate l j hj) :=
        (part.theta_source.compatible_average.cuspLogVolume audited).nonzero_eq j hj
      _ = (part.cuspClassLocalObject audited
            (zmodSignLabelFromCoordinate l j hj)).finiteLogVolume :=
        part.cuspClassLogVolume_eq_localObjectFinite
          audited (zmodSignLabelFromCoordinate l j hj)

theorem one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (1 : ZMod l.value) =
      (part.cuspClassLocalObject audited
        (zmodCanonicalSignLabelQuotient l)).finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (1 : ZMod l.value) =
        (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume
          (1 : ZMod l.value) :=
      part.theta_source.compatible_average.normalizedLogVolumeEq
        audited (1 : ZMod l.value)
    _ =
        (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          (zmodSignLabelFromCoordinate l (1 : ZMod l.value)
            (zmodOneNonzeroLabel l).2) :=
      (part.theta_source.compatible_average.cuspLogVolume audited).nonzero_eq
        (1 : ZMod l.value) (zmodOneNonzeroLabel l).2
    _ =
        (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          (zmodCanonicalSignLabelQuotient l) := by
      rw [zmodSignLabelFromCoordinate_one_eq_canonical]
    _ = (part.cuspClassLocalObject audited
          (zmodCanonicalSignLabelQuotient l)).finiteLogVolume :=
      part.cuspClassLogVolume_eq_localObjectFinite
        audited (zmodCanonicalSignLabelQuotient l)

theorem neg_normalizedLogVolume_eq_cuspClassLocalObjectFinite
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-j) =
      (part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj)).finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-j) =
        (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume
          (-j) :=
      part.theta_source.compatible_average.normalizedLogVolumeEq audited (-j)
    _ =
        (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          (zmodSignLabelFromCoordinate l j hj) :=
      (part.theta_source.compatible_average.cuspLogVolume audited).neg_nonzero_eq j hj
    _ = (part.cuspClassLocalObject audited
          (zmodSignLabelFromCoordinate l j hj)).finiteLogVolume :=
      part.cuspClassLogVolume_eq_localObjectFinite
        audited (zmodSignLabelFromCoordinate l j hj)

theorem cuspClassLocalObject_negCoordinate_eq
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l (-j)
          (zmod_neg_ne_zero_of_ne_zero l hj)) =
      part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj) := by
  rw [zmodSignLabelFromCoordinate_neg_eq]

end FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit

namespace FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

noncomputable def labelLocalObject
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    IUTStage1FiniteLocalLogVolumeObject kind := by
  by_cases hj : j = 0
  · exact part.zeroLocalObject audited
  · exact part.cuspClassLocalObject audited (zmodSignLabelFromCoordinate l j hj)

theorem labelLocalObject_eq_packetLocalObject
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    part.labelLocalObject audited j =
      audited.choice.local_tensor_state.packetState.localObject := by
  classical
  unfold labelLocalObject
  by_cases hj : j = 0
  · simp [hj, part.zeroLocalObject_eq_packetLocalObject audited]
  · simp [hj, part.cuspClassLocalObject_eq_packetLocalObject
      audited (zmodSignLabelFromCoordinate l j hj)]

theorem normalizedLogVolume_eq_labelLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      (part.labelLocalObject audited j).finiteLogVolume := by
  classical
  unfold labelLocalObject
  by_cases hj : j = 0
  · subst j
    simp only [↓reduceDIte]
    calc
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume 0 =
          (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume 0 :=
        part.theta_source.compatible_average.normalizedLogVolumeEq audited 0
      _ = (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
        (part.theta_source.compatible_average.cuspLogVolume audited).zero_eq_zeroLogVolume
      _ = (part.zeroLocalObject audited).finiteLogVolume :=
        part.zeroLogVolume_eq_localObjectFinite audited
  · simp only [hj, ↓reduceDIte]
    calc
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume j =
          (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume j :=
        part.theta_source.compatible_average.normalizedLogVolumeEq audited j
      _ =
          (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
            (zmodSignLabelFromCoordinate l j hj) :=
        (part.theta_source.compatible_average.cuspLogVolume audited).nonzero_eq j hj
      _ = (part.cuspClassLocalObject audited
            (zmodSignLabelFromCoordinate l j hj)).finiteLogVolume :=
        part.cuspClassLogVolume_eq_localObjectFinite
          audited (zmodSignLabelFromCoordinate l j hj)

noncomputable def toDirectLocalLabelObjectConstructionAudit
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l) :
    audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    labelLocalObject := part.labelLocalObject,
    labelLocalObject_eq_packetLocalObject :=
      part.labelLocalObject_eq_packetLocalObject,
    normalizedLogVolume_eq_labelLocalObjectFinite :=
      part.normalizedLogVolume_eq_labelLocalObjectFinite }

theorem targetSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  let directRoute := part.toDirectLocalLabelObjectConstructionAudit
  directRoute.targetSigned_le_thetaSourceAverage audited

theorem canonicalCuspClassLocalObject_eq_packetLocalObject
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.cuspClassLocalObject audited (zmodCanonicalSignLabelQuotient l) =
      audited.choice.local_tensor_state.packetState.localObject :=
  part.cuspClassLocalObject_eq_packetLocalObject
    audited (zmodCanonicalSignLabelQuotient l)

theorem one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (1 : ZMod l.value) =
      (part.cuspClassLocalObject audited
        (zmodCanonicalSignLabelQuotient l)).finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (1 : ZMod l.value) =
        (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume
          (1 : ZMod l.value) :=
      part.theta_source.compatible_average.normalizedLogVolumeEq
        audited (1 : ZMod l.value)
    _ =
        (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          (zmodSignLabelFromCoordinate l (1 : ZMod l.value)
            (zmodOneNonzeroLabel l).2) :=
      (part.theta_source.compatible_average.cuspLogVolume audited).nonzero_eq
        (1 : ZMod l.value) (zmodOneNonzeroLabel l).2
    _ =
        (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          (zmodCanonicalSignLabelQuotient l) := by
      rw [zmodSignLabelFromCoordinate_one_eq_canonical]
    _ = (part.cuspClassLocalObject audited
          (zmodCanonicalSignLabelQuotient l)).finiteLogVolume :=
      part.cuspClassLogVolume_eq_localObjectFinite
        audited (zmodCanonicalSignLabelQuotient l)

theorem neg_normalizedLogVolume_eq_cuspClassLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-j) =
      (part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj)).finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-j) =
        (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume
          (-j) :=
      part.theta_source.compatible_average.normalizedLogVolumeEq audited (-j)
    _ =
        (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          (zmodSignLabelFromCoordinate l j hj) :=
      (part.theta_source.compatible_average.cuspLogVolume audited).neg_nonzero_eq j hj
    _ = (part.cuspClassLocalObject audited
          (zmodSignLabelFromCoordinate l j hj)).finiteLogVolume :=
      part.cuspClassLogVolume_eq_localObjectFinite
        audited (zmodSignLabelFromCoordinate l j hj)

theorem neg_one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-(1 : ZMod l.value)) =
      (part.cuspClassLocalObject audited
        (zmodCanonicalSignLabelQuotient l)).finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-(1 : ZMod l.value)) =
        (part.cuspClassLocalObject audited
          (zmodSignLabelFromCoordinate l (1 : ZMod l.value)
            (zmodOneNonzeroLabel l).2)).finiteLogVolume :=
      part.neg_normalizedLogVolume_eq_cuspClassLocalObjectFinite
        audited (1 : ZMod l.value) (zmodOneNonzeroLabel l).2
    _ =
        (part.cuspClassLocalObject audited
          (zmodCanonicalSignLabelQuotient l)).finiteLogVolume := by
      rw [zmodSignLabelFromCoordinate_one_eq_canonical]

theorem cuspClassLocalObject_negCoordinate_eq
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l (-j)
          (zmod_neg_ne_zero_of_ne_zero l hj)) =
      part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj) := by
  rw [zmodSignLabelFromCoordinate_neg_eq]

theorem cuspClassLocalObject_neg_one_eq_canonical
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l (-(1 : ZMod l.value))
          (zmod_neg_ne_zero_of_ne_zero l (zmodOneNonzeroLabel l).2)) =
      part.cuspClassLocalObject audited (zmodCanonicalSignLabelQuotient l) := by
  rw [zmodSignLabelFromCoordinate_neg_eq
    l (1 : ZMod l.value) (zmodOneNonzeroLabel l).2]
  rw [zmodSignLabelFromCoordinate_one_eq_canonical]

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.zeroLocalObject audited =
      part.cuspClassLocalObject audited label := by
  calc
    part.zeroLocalObject audited =
        audited.choice.local_tensor_state.packetState.localObject :=
      part.zeroLocalObject_eq_packetLocalObject audited
    _ = part.cuspClassLocalObject audited label :=
      (part.cuspClassLocalObject_eq_packetLocalObject audited label).symm

theorem zeroLocalObject_eq_canonicalCuspClassLocalObject
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.zeroLocalObject audited =
      part.cuspClassLocalObject audited (zmodCanonicalSignLabelQuotient l) :=
  part.zeroLocalObject_eq_cuspClassLocalObject
    audited (zmodCanonicalSignLabelQuotient l)

theorem zeroLogVolume_eq_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label := by
  calc
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        (part.zeroLocalObject audited).finiteLogVolume :=
      part.zeroLogVolume_eq_localObjectFinite audited
    _ = (part.cuspClassLocalObject audited label).finiteLogVolume := by
      rw [part.zeroLocalObject_eq_cuspClassLocalObject audited label]
    _ =
        (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
          label :=
      (part.cuspClassLogVolume_eq_localObjectFinite audited label).symm

theorem zeroLogVolume_eq_canonicalCuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        (zmodCanonicalSignLabelQuotient l) :=
  part.zeroLogVolume_eq_cuspClassLogVolume
    audited (zmodCanonicalSignLabelQuotient l)

end FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit

namespace FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toCuspZeroLocalLabelObjectConstructionAudit
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l :=
  { theta_source := part.insulated_route.theta_source,
    ind12_equality_part := part.insulated_route.ind12_equality_part,
    ind3_upper_part := part.insulated_route.ind3_upper_part,
    theta_images_eq_endpoint := part.insulated_route.theta_images_eq_endpoint,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    cuspClassLocalObject := part.insulated_route.cuspClassLocalObject,
    cuspClassLocalObject_eq_packetLocalObject :=
      part.cuspClassLocalObject_eq_packetLocalObject,
    cuspClassLogVolume_eq_localObjectFinite :=
      part.insulated_route.cuspClassLogVolume_eq_localObjectFinite,
    zeroLocalObject := part.insulated_route.zeroLocalObject,
    zeroLocalObject_eq_packetLocalObject :=
      part.zeroLocalObject_eq_packetLocalObject,
    zeroLogVolume_eq_localObjectFinite :=
      part.insulated_route.zeroLogVolume_eq_localObjectFinite }

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  let comparisonRoute := part.toCuspZeroLocalLabelObjectConstructionAudit
  comparisonRoute.zeroLocalObject_eq_cuspClassLocalObject audited label

theorem zeroLogVolume_eq_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.insulated_route.theta_source.compatible_average.cuspLogVolume
        audited).zeroLogVolume =
      (part.insulated_route.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label :=
  let comparisonRoute := part.toCuspZeroLocalLabelObjectConstructionAudit
  comparisonRoute.zeroLogVolume_eq_cuspClassLogVolume audited label

theorem targetSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.insulated_route.theta_source.thetaSourceAverage audited :=
  let comparisonRoute := part.toCuspZeroLocalLabelObjectConstructionAudit
  comparisonRoute.targetSigned_le_thetaSourceAverage audited

end FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit

namespace FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectLocalLabelObjectConstruction
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  { packet_bridge := part,
    bridge_source :=
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction }

def ofInd12TransportedLocalLabelObjectConstruction
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  { packet_bridge := part,
    bridge_source :=
      IUTStage1ZModPacketLocalObjectBridgeSource.ind12TransportedLocalLabelObjectConstruction }

def ofSeparateLocalObjectIdentification
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  { packet_bridge := part,
    bridge_source :=
      IUTStage1ZModPacketLocalObjectBridgeSource.separateLocalObjectIdentification }

def toInsulatedCuspZeroPacketBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  part.packet_bridge

def toCuspZeroLocalLabelObjectConstructionAudit
    (part :
      audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l :=
  part.packet_bridge.toCuspZeroLocalLabelObjectConstructionAudit

theorem targetSigned_le_thetaSourceAverage
    (part :
      audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.packet_bridge.insulated_route.theta_source.thetaSourceAverage audited :=
  part.packet_bridge.targetSigned_le_thetaSourceAverage audited

theorem bridgeSource_eq_direct
    (part : audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    (ofDirectLocalLabelObjectConstruction part).bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  rfl

end FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit

namespace FLZModCuspLabelThetaPacketNormalizedContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem cuspClassLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  (part.cuspClassPacketEstimate audited label).localLogVolume_eq_packetNormalized

theorem zeroLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  (part.zeroPacketEstimate audited).localLogVolume_eq_packetNormalized

theorem cuspClassLogVolume_eq_capsuleSumAverage
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      (Finset.univ.sum fun i =>
          (audited.choice.local_tensor_state.packetState.capsuleFamily.capsule i).logVolume) /
        (audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount : Real) :=
  (part.cuspClassPacketEstimate audited label).localLogVolume_eq_capsuleSumAverage

theorem zeroLogVolume_eq_capsuleSumAverage
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      (Finset.univ.sum fun i =>
          (audited.choice.local_tensor_state.packetState.capsuleFamily.capsule i).logVolume) /
        (audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount : Real) :=
  (part.zeroPacketEstimate audited).localLogVolume_eq_capsuleSumAverage

theorem targetSigned_le_cuspClassLogVolume_of_ind2_capsuleEstimates
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited₂).cuspClassLogVolume
        label := by
  rw [part.cuspClassLogVolume_eq_packetNormalized audited₂ label]
  exact
    IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_transports_capsuleContainerBound
      hstep estimate

theorem targetSigned_le_zeroLogVolume_of_ind2_capsuleEstimates
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited₂).zeroLogVolume := by
  rw [part.zeroLogVolume_eq_packetNormalized audited₂]
  exact
    IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_transports_capsuleContainerBound
      hstep estimate

def toThetaPacketLocalObjectContainerAudit
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l) :
    audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    cuspClassObjectEstimate := by
      intro audited label
      exact
        (part.cuspClassPacketEstimate audited label).toLocalObjectContainerEstimate,
    cuspClassObject_eq_packetLocalObject := by
      intro audited label
      exact
        (part.cuspClassPacketEstimate audited label).localObject_eq_packetLocalObject,
    zeroObjectEstimate := by
      intro audited
      exact
        (part.zeroPacketEstimate audited).toLocalObjectContainerEstimate,
    zeroObject_eq_packetLocalObject := by
      intro audited
      exact (part.zeroPacketEstimate audited).localObject_eq_packetLocalObject }

theorem targetSigned_le_normalizedLogVolume
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j :=
  let localObjectAudit :=
    part.toThetaPacketLocalObjectContainerAudit.toThetaLocalObjectContainerAudit
  let localAudit := localObjectAudit.toThetaLocalContainerAudit
  let cuspAudit : audit.FLZModCuspLabelThetaCuspClassContainerAudit l :=
    localAudit.toThetaCuspClassContainerAudit
  cuspAudit.targetSigned_le_normalizedLogVolume audited j

def toThetaPilotHullContainerAudit
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.toThetaPacketLocalObjectContainerAudit.toThetaPilotHullContainerAudit

theorem qSigned_le_thetaSigned_via_packet_normalized_container
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  let packetAudit := part.toThetaPacketLocalObjectContainerAudit
  packetAudit.qSigned_le_thetaSigned_via_packet_local_object_container audited

end FLZModCuspLabelThetaPacketNormalizedContainerAudit

namespace FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toPacketNormalizedContainerAudit
    (part : audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    cuspClassPacketEstimate := by
      intro audited label
      exact
        IUTStage1PacketNormalizedContainerEstimate.ofClassifiedLocalObjectCompatibility
            (part.cuspClassObjectEstimate audited label)
            (part.cuspClassObject_eq_packetLocalObject audited label)
            (part.cuspClassCompatibility audited label),
    zeroPacketEstimate := by
      intro audited
      exact
        IUTStage1PacketNormalizedContainerEstimate.ofClassifiedLocalObjectCompatibility
            (part.zeroObjectEstimate audited)
            (part.zeroObject_eq_packetLocalObject audited)
            (part.zeroCompatibility audited) }

def toClassifiedPacketNormalizedAudit
    (part : audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  { packet_normalized := part.toPacketNormalizedContainerAudit,
    identification_source := part.identification_source }

theorem cuspClassCompatibilitySource_eq
    (part : audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.cuspClassCompatibility audited label).identification_source =
      part.identification_source :=
  part.cuspClassCompatibility_source_eq audited label

theorem zeroCompatibilitySource_eq
    (part : audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.zeroCompatibility audited).identification_source =
      part.identification_source :=
  part.zeroCompatibility_source_eq audited

end FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit

namespace FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

open IUTStage1PlaceAuditedDirectSummandPacketChoice in
def targetCuspClassCompatibility
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l)
    (targetAudited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      targetAudited.choice.local_tensor_state.packetState :=
  ind2_transports_classifiedPacketNormalizedCompatibility
    (part.ind2_step targetAudited)
    (part.cuspClassSourceCompatibility targetAudited label)

open IUTStage1PlaceAuditedDirectSummandPacketChoice in
def targetZeroCompatibility
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l)
    (targetAudited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      targetAudited.choice.local_tensor_state.packetState :=
  ind2_transports_classifiedPacketNormalizedCompatibility
    (part.ind2_step targetAudited)
    (part.zeroSourceCompatibility targetAudited)

def toClassifiedLocalPacketNormalizedAudit
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization,
    cuspClassObjectEstimate := part.cuspClassObjectEstimate,
    cuspClassObject_eq_packetLocalObject :=
      part.cuspClassObject_eq_packetLocalObject,
    cuspClassCompatibility := part.targetCuspClassCompatibility,
    cuspClassCompatibility_source_eq := by
      intro targetAudited label
      rfl,
    zeroObjectEstimate := part.zeroObjectEstimate,
    zeroObject_eq_packetLocalObject :=
      part.zeroObject_eq_packetLocalObject,
    zeroCompatibility := part.targetZeroCompatibility,
    zeroCompatibility_source_eq := by
      intro targetAudited
      rfl }

def toClassifiedPacketNormalizedAudit
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  let localAudit := part.toClassifiedLocalPacketNormalizedAudit
  localAudit.toClassifiedPacketNormalizedAudit

theorem targetCuspClassCompatibilitySource_eq
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l)
    (targetAudited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.targetCuspClassCompatibility targetAudited label).identification_source =
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization :=
  rfl

theorem targetZeroCompatibilitySource_eq
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l)
    (targetAudited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.targetZeroCompatibility targetAudited).identification_source =
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization :=
  rfl

end FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit

namespace FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def targetCuspClassCompatibility
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      audited.choice.local_tensor_state.packetState :=
  IUTStage1DirectPacketNormalizationData.toClassifiedPacketNormalizedCompatibility
    (part.cuspClassDirectNormalization audited label)

def targetZeroCompatibility
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      audited.choice.local_tensor_state.packetState :=
  IUTStage1DirectPacketNormalizationData.toClassifiedPacketNormalizedCompatibility
    (part.zeroDirectNormalization audited)

def toClassifiedLocalPacketNormalizedAudit
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization,
    cuspClassObjectEstimate := part.cuspClassObjectEstimate,
    cuspClassObject_eq_packetLocalObject :=
      part.cuspClassObject_eq_packetLocalObject,
    cuspClassCompatibility := part.targetCuspClassCompatibility,
    cuspClassCompatibility_source_eq := by
      intro audited label
      rfl,
    zeroObjectEstimate := part.zeroObjectEstimate,
    zeroObject_eq_packetLocalObject :=
      part.zeroObject_eq_packetLocalObject,
    zeroCompatibility := part.targetZeroCompatibility,
    zeroCompatibility_source_eq := by
      intro audited
      rfl }

def toClassifiedPacketNormalizedAudit
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  let localAudit := part.toClassifiedLocalPacketNormalizedAudit
  localAudit.toClassifiedPacketNormalizedAudit

theorem targetCuspClassCompatibilitySource_eq
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.targetCuspClassCompatibility audited label).identification_source =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  rfl

theorem targetZeroCompatibilitySource_eq
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.targetZeroCompatibility audited).identification_source =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  rfl

end FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit

namespace FLZModCuspLabelThetaClassifiedPacketNormalizedAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectPacketNormalization
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  { packet_normalized := part,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization }

def ofInd2TransportedPacketNormalization
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  { packet_normalized := part,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization }

def ofSeparateRealLineIdentification
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  { packet_normalized := part,
    identification_source :=
      IUTStage1PacketNormalizedIdentificationSource.separateRealLineIdentification }

theorem cuspClassLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.packet_normalized.cuspClassLogVolume_eq_packetNormalized audited label

theorem zeroLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.packet_normalized.zeroLogVolume_eq_packetNormalized audited

end FLZModCuspLabelThetaClassifiedPacketNormalizedAudit

namespace FLZModCuspLabelThetaInd2TransportedCuspClassAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label :=
  part.packet_normalized.targetSigned_le_cuspClassLogVolume_of_ind2_capsuleEstimates
    (part.ind2_step audited) (part.sourceCapsuleEstimates audited) label

theorem targetSigned_le_zeroLogVolume
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).zeroLogVolume :=
  part.packet_normalized.targetSigned_le_zeroLogVolume_of_ind2_capsuleEstimates
    (part.ind2_step audited) (part.sourceCapsuleEstimates audited)

def toThetaCuspClassContainerAudit
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaCuspClassContainerAudit l :=
  { theta_source := part.packet_normalized.theta_source,
    ind12_equality_part := part.packet_normalized.ind12_equality_part,
    ind3_upper_part := part.packet_normalized.ind3_upper_part,
    theta_images_eq_endpoint := part.packet_normalized.theta_images_eq_endpoint,
    targetSigned_le_cuspClassLogVolume :=
      part.targetSigned_le_cuspClassLogVolume,
    targetSigned_le_zeroLogVolume :=
      part.targetSigned_le_zeroLogVolume }

theorem qSigned_le_thetaSigned_via_ind2_transport
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit.qSigned_le_thetaSigned_via_cusp_container
    audited

theorem targetSigned_le_thetaAverage
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.packet_normalized.theta_source.thetaSourceAverage audited :=
  part.toThetaCuspClassContainerAudit.targetSigned_le_thetaAverage audited

end FLZModCuspLabelThetaInd2TransportedCuspClassAudit

namespace FLZModCuspLabelThetaDirectCapsuleCuspClassAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label := by
  rw [part.packet_normalized.cuspClassLogVolume_eq_packetNormalized
    audited label]
  exact (part.targetCapsuleEstimates audited).targetSigned_le_normalizedLogVolume

theorem targetSigned_le_zeroLogVolume
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).zeroLogVolume := by
  rw [part.packet_normalized.zeroLogVolume_eq_packetNormalized audited]
  exact (part.targetCapsuleEstimates audited).targetSigned_le_normalizedLogVolume

def toThetaCuspClassContainerAudit
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l) :
    audit.FLZModCuspLabelThetaCuspClassContainerAudit l :=
  { theta_source := part.packet_normalized.theta_source,
    ind12_equality_part := part.packet_normalized.ind12_equality_part,
    ind3_upper_part := part.packet_normalized.ind3_upper_part,
    theta_images_eq_endpoint := part.packet_normalized.theta_images_eq_endpoint,
    targetSigned_le_cuspClassLogVolume :=
      part.targetSigned_le_cuspClassLogVolume,
    targetSigned_le_zeroLogVolume :=
      part.targetSigned_le_zeroLogVolume }

theorem qSigned_le_thetaSigned_via_direct_capsules
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit.qSigned_le_thetaSigned_via_cusp_container
    audited

end FLZModCuspLabelThetaDirectCapsuleCuspClassAudit

namespace FLZModCuspLabelThetaClassifiedCuspClassAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectCapsule
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l) :
    audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l :=
  { cusp_class_audit := part.toThetaCuspClassContainerAudit,
    bound_source := IUTStage1CuspClassBoundSource.directCapsuleEstimates }

def ofInd2Transport
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l :=
  { cusp_class_audit := part.toThetaCuspClassContainerAudit,
    bound_source := IUTStage1CuspClassBoundSource.ind2TransportedCapsuleEstimates }

def ofSeparateAnalyticComparison
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l :=
  { cusp_class_audit := part,
    bound_source := IUTStage1CuspClassBoundSource.separateAnalyticComparison }

theorem targetSigned_le_cuspClassLogVolume
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.cusp_class_audit.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label :=
  part.cusp_class_audit.targetSigned_le_cuspClassLogVolume audited label

theorem targetSigned_le_zeroLogVolume
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.cusp_class_audit.theta_source.compatible_average.cuspLogVolume
        audited).zeroLogVolume :=
  part.cusp_class_audit.targetSigned_le_zeroLogVolume audited

theorem qSigned_le_thetaSigned_via_classified_cusp
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.cusp_class_audit.qSigned_le_thetaSigned_via_cusp_container audited

def toThetaPilotHullContainerAudit
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.cusp_class_audit.toThetaPilotHullContainerAudit

def toThetaContainerBoundAudit
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaContainerBoundAudit l :=
  part.toThetaPilotHullContainerAudit.toThetaContainerBoundAudit

theorem targetAverageBoundSource_eq_thetaPilotHullContainer
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l) :
    part.toThetaContainerBoundAudit.bound_source =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  rfl

end FLZModCuspLabelThetaClassifiedCuspClassAudit

/-- Compact summary of the classified local and global average route. -/
structure FLZModCuspLabelThetaClassifiedRouteSummary
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  classified_cusp : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l
  cusp_bound_source : IUTStage1CuspClassBoundSource
  cusp_bound_source_eq : cusp_bound_source = classified_cusp.bound_source
  target_average_source : IUTStage1TargetAverageBoundSource
  target_average_source_eq :
    target_average_source =
      classified_cusp.toThetaContainerBoundAudit.bound_source

namespace FLZModCuspLabelThetaClassifiedRouteSummary

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofClassifiedCusp
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaClassifiedRouteSummary l :=
  { classified_cusp := part,
    cusp_bound_source := part.bound_source,
    cusp_bound_source_eq := rfl,
    target_average_source := part.toThetaContainerBoundAudit.bound_source,
    target_average_source_eq := rfl }

theorem targetAverageSource_eq_thetaPilotHullContainer
    (summary : audit.FLZModCuspLabelThetaClassifiedRouteSummary l) :
    summary.target_average_source =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer := by
  rw [summary.target_average_source_eq]
  exact
    summary.classified_cusp.targetAverageBoundSource_eq_thetaPilotHullContainer

theorem qSigned_le_thetaSigned
    (summary : audit.FLZModCuspLabelThetaClassifiedRouteSummary l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  summary.classified_cusp.qSigned_le_thetaSigned_via_classified_cusp audited

end FLZModCuspLabelThetaClassifiedRouteSummary

/--
Full classified route summary, including the packet-normalized real-line
identification source.
-/
structure FLZModCuspLabelThetaFullClassifiedRouteSummary
    (audit : endpoint.LogVolumeChartAudit)
    (l : PrimeGeFive) where
  classified_packet :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l
  classified_route : audit.FLZModCuspLabelThetaClassifiedRouteSummary l
  theta_source_eq :
    classified_packet.packet_normalized.theta_source =
      classified_route.classified_cusp.cusp_class_audit.theta_source

namespace FLZModCuspLabelThetaFullClassifiedRouteSummary

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectCapsule
    (packetSummary :
      audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (direct :
      audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l)
    (hpacket :
      direct.packet_normalized = packetSummary.packet_normalized) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  { classified_packet := packetSummary,
    classified_route :=
      FLZModCuspLabelThetaClassifiedRouteSummary.ofClassifiedCusp
        (FLZModCuspLabelThetaClassifiedCuspClassAudit.ofDirectCapsule direct),
    theta_source_eq := by
      rw [← hpacket]
      change direct.packet_normalized.theta_source =
        direct.packet_normalized.theta_source
      rfl }

def ofInd2Transport
    (packetSummary :
      audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (transported :
      audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (hpacket :
      transported.packet_normalized = packetSummary.packet_normalized) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  { classified_packet := packetSummary,
    classified_route :=
      FLZModCuspLabelThetaClassifiedRouteSummary.ofClassifiedCusp
        (FLZModCuspLabelThetaClassifiedCuspClassAudit.ofInd2Transport
          transported),
    theta_source_eq := by
      rw [← hpacket]
      change transported.packet_normalized.theta_source =
        transported.packet_normalized.theta_source
      rfl }

def packetIdentificationSource
    (summary : audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l) :
    IUTStage1PacketNormalizedIdentificationSource :=
  summary.classified_packet.identification_source

def cuspBoundSource
    (summary : audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l) :
    IUTStage1CuspClassBoundSource :=
  summary.classified_route.cusp_bound_source

def targetAverageSource
    (summary : audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l) :
    IUTStage1TargetAverageBoundSource :=
  summary.classified_route.target_average_source

theorem targetAverageSource_eq_thetaPilotHullContainer
    (summary : audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l) :
    summary.targetAverageSource =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  summary.classified_route.targetAverageSource_eq_thetaPilotHullContainer

theorem qSigned_le_thetaSigned
    (summary : audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  summary.classified_route.qSigned_le_thetaSigned audited

end FLZModCuspLabelThetaFullClassifiedRouteSummary

namespace FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def cuspClassObjectEstimate
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    IUTStage1LocalObjectContainerLogVolumeEstimate kind
      package.preLedger.targetVolume.targetSigned
      ((part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label) :=
  IUTStage1DirectPacketNormalizationData.toLocalObjectContainerEstimateOfIdentifiedLogVolume
    (part.directNormalization audited)
    (part.targetCapsuleEstimates audited)
    (part.cuspClassLogVolume_eq_localObjectFinite audited label)

def zeroObjectEstimate
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1LocalObjectContainerLogVolumeEstimate kind
      package.preLedger.targetVolume.targetSigned
      (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
  IUTStage1DirectPacketNormalizationData.toLocalObjectContainerEstimateOfIdentifiedLogVolume
    (part.directNormalization audited)
    (part.targetCapsuleEstimates audited)
    (part.zeroLogVolume_eq_localObjectFinite audited)

theorem cuspClassLogVolume_eq_packetNormalized
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  calc
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
      part.cuspClassLogVolume_eq_localObjectFinite audited label
    _ = audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
      let compat :=
        (part.directNormalization audited).toPacketNormalizedCompatibility
      compat.normalizedLogVolume_eq_localObject.symm

theorem zeroLogVolume_eq_packetNormalized
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  calc
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
      part.zeroLogVolume_eq_localObjectFinite audited
    _ = audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
      let compat :=
        (part.directNormalization audited).toPacketNormalizedCompatibility
      compat.normalizedLogVolume_eq_localObject.symm

def toDirectPacketNormalizedLocalObjectRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetCapsuleEstimates := part.targetCapsuleEstimates,
    directNormalization := part.directNormalization,
    cuspClassLogVolume_eq_packetNormalized :=
      part.cuspClassLogVolume_eq_packetNormalized,
    zeroLogVolume_eq_packetNormalized :=
      part.zeroLogVolume_eq_packetNormalized }

def toDirectLocalPacketNormalizedAudit
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    cuspClassObjectEstimate := part.cuspClassObjectEstimate,
    cuspClassObject_eq_packetLocalObject := by
      intro audited label
      exact
        IUTStage1DirectPacketNormalizationData.identifiedLogVolumeEstimate_localObject
          (part.directNormalization audited)
          (part.targetCapsuleEstimates audited)
          (part.cuspClassLogVolume_eq_localObjectFinite audited label),
    cuspClassDirectNormalization := by
      intro audited _label
      exact part.directNormalization audited,
    zeroObjectEstimate := part.zeroObjectEstimate,
    zeroObject_eq_packetLocalObject := by
      intro audited
      exact
        IUTStage1DirectPacketNormalizationData.identifiedLogVolumeEstimate_localObject
          (part.directNormalization audited)
          (part.targetCapsuleEstimates audited)
          (part.zeroLogVolume_eq_localObjectFinite audited),
    zeroDirectNormalization := part.directNormalization }

def toDirectLocalPacketDirectCapsuleRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l :=
  { direct_packet := part.toDirectLocalPacketNormalizedAudit,
    targetCapsuleEstimates := part.targetCapsuleEstimates }

def toFullClassifiedRouteSummary
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  let directPacket := part.toDirectLocalPacketNormalizedAudit
  let packetSummary := directPacket.toClassifiedPacketNormalizedAudit
  let direct : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l :=
    { packet_normalized := packetSummary.packet_normalized,
      targetCapsuleEstimates := part.targetCapsuleEstimates }
  FLZModCuspLabelThetaFullClassifiedRouteSummary.ofDirectCapsule
    packetSummary direct rfl

theorem packetIdentificationSource_eq_direct
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  rfl

theorem cuspBoundSource_eq_directCapsule
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.directCapsuleEstimates :=
  rfl

end FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit

namespace FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofSeparateRealLineIdentification
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l :=
  { identified_route := part,
    cuspClass_identification_source := by
      intro _audited _label
      exact IUTStage1LocalObjectLogVolumeIdentificationSource.separateRealLineIdentification,
    zero_identification_source := by
      intro _audited
      exact IUTStage1LocalObjectLogVolumeIdentificationSource.separateRealLineIdentification }

def ofDirectLocalObjectConstruction
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l :=
  { identified_route := part,
    cuspClass_identification_source := by
      intro _audited _label
      exact IUTStage1LocalObjectLogVolumeIdentificationSource.directLocalObjectConstruction,
    zero_identification_source := by
      intro _audited
      exact IUTStage1LocalObjectLogVolumeIdentificationSource.directLocalObjectConstruction }

def ofPacketNormalizationAndLocalObjectCompatibility
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l :=
  { identified_route := part,
    cuspClass_identification_source := by
      intro _audited _label
      exact .packetNormalizationAndLocalObjectCompatibility,
    zero_identification_source := by
      intro _audited
      exact .packetNormalizationAndLocalObjectCompatibility }

def toDirectIdentifiedLocalPacketRouteAudit
    (part :
      audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l :=
  part.identified_route

def toFullClassifiedRouteSummary
    (part :
      audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.identified_route.toFullClassifiedRouteSummary

theorem packetIdentificationSource_eq_direct
    (part :
      audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  part.identified_route.packetIdentificationSource_eq_direct

theorem cuspBoundSource_eq_directCapsule
    (part :
      audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.directCapsuleEstimates :=
  part.identified_route.cuspBoundSource_eq_directCapsule

end FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit

namespace FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem cuspClassLogVolume_eq_localObjectFinite
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
      part.cuspClassLogVolume_eq_packetNormalized audited label
    _ = audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
      let compat :=
        (part.directNormalization audited).toPacketNormalizedCompatibility
      compat.normalizedLogVolume_eq_localObject

theorem zeroLogVolume_eq_localObjectFinite
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
      part.zeroLogVolume_eq_packetNormalized audited
    _ = audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
      let compat :=
        (part.directNormalization audited).toPacketNormalizedCompatibility
      compat.normalizedLogVolume_eq_localObject

theorem zmodNormalizedLogVolume_eq_packetNormalized
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  by_cases hj : j = 0
  · subst j
    calc
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume 0 =
          (part.theta_source.compatible_average.cuspLogVolume
            audited).normalizedLogVolume 0 :=
        part.theta_source.compatible_average.normalizedLogVolumeEq audited 0
      _ = (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
        (part.theta_source.compatible_average.cuspLogVolume audited).zero_eq_zeroLogVolume
      _ = audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
        part.zeroLogVolume_eq_packetNormalized audited
  · calc
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume j =
          (part.theta_source.compatible_average.cuspLogVolume
            audited).normalizedLogVolume j :=
        part.theta_source.compatible_average.normalizedLogVolumeEq audited j
      _ =
          (part.theta_source.compatible_average.cuspLogVolume
            audited).cuspClassLogVolume
            (zmodSignLabelFromCoordinate l j hj) :=
        (part.theta_source.compatible_average.cuspLogVolume audited).nonzero_eq j hj
      _ = audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
        part.cuspClassLogVolume_eq_packetNormalized
          audited (zmodSignLabelFromCoordinate l j hj)

def toZModPacketNormalizedRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetCapsuleEstimates := part.targetCapsuleEstimates,
    directNormalization := part.directNormalization,
    zmodNormalizedLogVolume_eq_packetNormalized :=
      part.zmodNormalizedLogVolume_eq_packetNormalized }

def toDirectIdentifiedLocalPacketRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetCapsuleEstimates := part.targetCapsuleEstimates,
    directNormalization := part.directNormalization,
    cuspClassLogVolume_eq_localObjectFinite :=
      part.cuspClassLogVolume_eq_localObjectFinite,
    zeroLogVolume_eq_localObjectFinite :=
      part.zeroLogVolume_eq_localObjectFinite }

open FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit in
def toClassifiedDirectIdentifiedLocalPacketRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l :=
  ofPacketNormalizationAndLocalObjectCompatibility
    part.toDirectIdentifiedLocalPacketRouteAudit

def toFullClassifiedRouteSummary
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toDirectIdentifiedLocalPacketRouteAudit.toFullClassifiedRouteSummary

theorem packetIdentificationSource_eq_direct
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  rfl

theorem cuspBoundSource_eq_directCapsule
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.directCapsuleEstimates :=
  rfl

def toInsulatedCuspZeroPacketBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  { insulated_route :=
      { theta_source := part.theta_source,
        ind12_equality_part := part.ind12_equality_part,
        ind3_upper_part := part.ind3_upper_part,
        theta_images_eq_endpoint := part.theta_images_eq_endpoint,
        cuspClassLocalObject := by
          intro audited _label
          exact audited.choice.local_tensor_state.packetState.localObject,
        cuspClassLogVolume_eq_localObjectFinite :=
          part.cuspClassLogVolume_eq_localObjectFinite,
        zeroLocalObject := by
          intro audited
          exact audited.choice.local_tensor_state.packetState.localObject,
        zeroLogVolume_eq_localObjectFinite :=
          part.zeroLogVolume_eq_localObjectFinite },
    packetLocalObjectEstimate := by
      intro audited
      exact
        (part.directNormalization audited).toLocalObjectContainerEstimateOfCapsuleEstimates
          (part.targetCapsuleEstimates audited),
    packetLocalObjectEstimate_eq_packetLocalObject := by
      intro _audited
      rfl,
    cuspClassLocalObject_eq_packetLocalObject := by
      intro _audited _label
      rfl,
    zeroLocalObject_eq_packetLocalObject := by
      intro _audited
      rfl }

open FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit in
def toClassifiedInsulatedCuspZeroPacketBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  ofDirectLocalLabelObjectConstruction part.toInsulatedCuspZeroPacketBridgeAudit

theorem insulatedPacketBridgeSource_eq_direct
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    part.toClassifiedInsulatedCuspZeroPacketBridgeAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  rfl

end FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit

namespace FLZModCuspLabelThetaZModPacketNormalizedRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem cuspNormalizedLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.cuspLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  calc
    (part.theta_source.compatible_average.cuspLogVolume
        audited).normalizedLogVolume j =
        (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).normalizedLogVolume j :=
      (part.theta_source.compatible_average.normalizedLogVolume_eq audited j).symm
    _ = audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
      part.zmodNormalizedLogVolume_eq_packetNormalized audited j

theorem cuspClassLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
      label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.cuspClass_eq_of_normalizedLogVolume_eq
    (part.theta_source.compatible_average.cuspLogVolume audited)
    (part.cuspNormalizedLogVolume_eq_packetNormalized audited) label

theorem zeroLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.zeroLogVolume_eq_of_normalizedLogVolume_eq
    (part.theta_source.compatible_average.cuspLogVolume audited)
    (part.cuspNormalizedLogVolume_eq_packetNormalized audited)

def toDirectPacketNormalizedLocalObjectRouteAudit
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetCapsuleEstimates := part.targetCapsuleEstimates,
    directNormalization := part.directNormalization,
    cuspClassLogVolume_eq_packetNormalized :=
      part.cuspClassLogVolume_eq_packetNormalized,
    zeroLogVolume_eq_packetNormalized :=
      part.zeroLogVolume_eq_packetNormalized }

def toFullClassifiedRouteSummary
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toDirectPacketNormalizedLocalObjectRouteAudit.toFullClassifiedRouteSummary

def toInsulatedCuspZeroPacketBridgeAudit
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  let directRoute := part.toDirectPacketNormalizedLocalObjectRouteAudit
  directRoute.toInsulatedCuspZeroPacketBridgeAudit

def toClassifiedInsulatedCuspZeroPacketBridgeAudit
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  let directRoute := part.toDirectPacketNormalizedLocalObjectRouteAudit
  directRoute.toClassifiedInsulatedCuspZeroPacketBridgeAudit

theorem insulatedPacketBridgeSource_eq_direct
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    part.toClassifiedInsulatedCuspZeroPacketBridgeAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  let directRoute := part.toDirectPacketNormalizedLocalObjectRouteAudit
  directRoute.insulatedPacketBridgeSource_eq_direct

theorem packetIdentificationSource_eq_direct
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  rfl

theorem cuspBoundSource_eq_directCapsule
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.directCapsuleEstimates :=
  rfl

def toConstantZModPacketNormalizedRouteAudit
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetCapsuleEstimates := part.targetCapsuleEstimates,
    directNormalization := part.directNormalization,
    averagedLogVolume_eq_packetConstant := by
      intro audited
      let averagedAudit :=
        part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit
      exact
        IUTStage1LabelAveragedProcessionLogVolume.eq_constant_of_forall_eq
          (averagedAudit.averagedLogVolume audited)
          (part.zmodNormalizedLogVolume_eq_packetNormalized audited) }

end FLZModCuspLabelThetaZModPacketNormalizedRouteAudit

namespace FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectLabelPacketNormalization
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l :=
  { zmod_packet_route := part,
    bridge_source :=
      IUTStage1ZModPacketNormalizedBridgeSource.directLabelPacketNormalization }

def ofInd12TransportedLabelPacketNormalization
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l :=
  { zmod_packet_route := part,
    bridge_source :=
      IUTStage1ZModPacketNormalizedBridgeSource.ind12TransportedLabelPacketNormalization }

def ofSeparateAveragingIdentification
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l :=
  { zmod_packet_route := part,
    bridge_source :=
      IUTStage1ZModPacketNormalizedBridgeSource.separateAveragingIdentification }

def toZModPacketNormalizedRouteAudit
    (part : audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l :=
  part.zmod_packet_route

def toFullClassifiedRouteSummary
    (part : audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.zmod_packet_route.toFullClassifiedRouteSummary

theorem packetIdentificationSource_eq_direct
    (part : audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  part.zmod_packet_route.packetIdentificationSource_eq_direct

theorem cuspBoundSource_eq_directCapsule
    (part : audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.directCapsuleEstimates :=
  part.zmod_packet_route.cuspBoundSource_eq_directCapsule

end FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit

namespace FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem zmodNormalizedLogVolume_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  have h :=
    congrArg (fun data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value) =>
      data.normalizedLogVolume j) (part.averagedLogVolume_eq_packetConstant audited)
  simpa [IUTStage1LabelAveragedProcessionLogVolume.constant] using h

theorem thetaSourceAverage_eq_packetNormalized
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.theta_source.thetaSourceAverage audited =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume := by
  calc
    part.theta_source.thetaSourceAverage audited =
        (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
          audited).averageLogVolume :=
      part.theta_source.thetaSourceAverage_eq_average audited
    _ =
        (IUTStage1LabelAveragedProcessionLogVolume.constant
          (label := ZMod l.value)
          audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume
        ).averageLogVolume := by
      rw [part.averagedLogVolume_eq_packetConstant audited]
    _ = audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
      rfl

theorem targetSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited := by
  have hpacket :
      package.preLedger.targetVolume.targetSigned <=
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
    (part.targetCapsuleEstimates audited).targetSigned_le_normalizedLogVolume
  rw [part.thetaSourceAverage_eq_packetNormalized audited]
  exact hpacket

def toZModPacketNormalizedRouteAudit
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    ind3_upper_part := part.ind3_upper_part,
    theta_images_eq_endpoint := part.theta_images_eq_endpoint,
    targetCapsuleEstimates := part.targetCapsuleEstimates,
    directNormalization := part.directNormalization,
    zmodNormalizedLogVolume_eq_packetNormalized :=
      part.zmodNormalizedLogVolume_eq_packetNormalized }

open FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit in
def toClassifiedZModPacketNormalizedRouteAudit
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l :=
  ofDirectLabelPacketNormalization part.toZModPacketNormalizedRouteAudit

def toFullClassifiedRouteSummary
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toZModPacketNormalizedRouteAudit.toFullClassifiedRouteSummary

theorem packetIdentificationSource_eq_direct
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  rfl

theorem cuspBoundSource_eq_directCapsule
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.directCapsuleEstimates :=
  rfl

def toInsulatedCuspZeroPacketBridgeAudit
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  let zmodRoute := part.toZModPacketNormalizedRouteAudit
  zmodRoute.toInsulatedCuspZeroPacketBridgeAudit

def toClassifiedInsulatedCuspZeroPacketBridgeAudit
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  let zmodRoute := part.toZModPacketNormalizedRouteAudit
  zmodRoute.toClassifiedInsulatedCuspZeroPacketBridgeAudit

theorem insulatedPacketBridgeSource_eq_direct
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    part.toClassifiedInsulatedCuspZeroPacketBridgeAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  let zmodRoute := part.toZModPacketNormalizedRouteAudit
  zmodRoute.insulatedPacketBridgeSource_eq_direct

end FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit

namespace FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofDirectPacketNormalization
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l :=
  { classified_bridge := part.toClassifiedInsulatedCuspZeroPacketBridgeAudit,
    comparison_source :=
      IUTStage1InsulatedCuspZeroBridgeSource.directPacketNormalization }

def ofLabelwiseZModPacketEquality
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l :=
  { classified_bridge := part.toClassifiedInsulatedCuspZeroPacketBridgeAudit,
    comparison_source :=
      IUTStage1InsulatedCuspZeroBridgeSource.labelwiseZModPacketEquality }

def ofConstantZModPacketFamily
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l :=
  { classified_bridge := part.toClassifiedInsulatedCuspZeroPacketBridgeAudit,
    comparison_source :=
      IUTStage1InsulatedCuspZeroBridgeSource.constantZModPacketFamily }

def ofHodgeTheaterDescentIndeterminacy
    (part :
      audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l :=
  { classified_bridge := part,
    comparison_source :=
      IUTStage1InsulatedCuspZeroBridgeSource.hodgeTheaterDescentIndeterminacy }

def ofSeparateRealLineIdentification
    (part :
      audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l :=
  { classified_bridge := part,
    comparison_source :=
      IUTStage1InsulatedCuspZeroBridgeSource.separateRealLineIdentification }

def toClassifiedInsulatedCuspZeroPacketBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  part.classified_bridge

theorem targetSigned_le_thetaSourceAverage
    (part :
      audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.classified_bridge.packet_bridge.insulated_route.theta_source.thetaSourceAverage
        audited :=
  part.classified_bridge.targetSigned_le_thetaSourceAverage audited

theorem comparisonSource_eq_constant
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    (ofConstantZModPacketFamily part).comparison_source =
      IUTStage1InsulatedCuspZeroBridgeSource.constantZModPacketFamily :=
  rfl

end FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit

namespace FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def ofStructuredInputsWithSHE
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (packet_bridge :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l :=
  { hodge_descent_data := bundle.hodgeTheaterDescentBridgeData,
    classified_bridge :=
      { packet_bridge := packet_bridge,
        bridge_source :=
          IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport },
    classified_bridge_source_eq_hodge := rfl }

open FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit in
def toSourcedInsulatedCuspZeroPacketBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l) :
    audit.FLZModCuspLabelThetaSourcedInsulatedCuspZeroPacketBridgeAudit l :=
  ofHodgeTheaterDescentIndeterminacy part.classified_bridge

theorem comparisonSource_eq_hodgeTheaterDescent
    (part :
      audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l) :
    part.toSourcedInsulatedCuspZeroPacketBridgeAudit.comparison_source =
      IUTStage1InsulatedCuspZeroBridgeSource.hodgeTheaterDescentIndeterminacy :=
  rfl

theorem histories_not_identified
    (part :
      audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l) :
    part.hodge_descent_data.domainTheater.side ≠
      part.hodge_descent_data.codomainTheater.side :=
  part.hodge_descent_data.histories_not_identified

theorem classifiedBridgeSource_eq_hodgeTheaterDescentPacketTransport
    (part :
      audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l) :
    part.classified_bridge.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport :=
  part.classified_bridge_source_eq_hodge

theorem ofStructuredInputsWithSHE_hodgeData_eq
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (packet_bridge :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    (ofStructuredInputsWithSHE bundle packet_bridge).hodge_descent_data =
      bundle.hodgeTheaterDescentBridgeData :=
  rfl

theorem ofStructuredInputsWithSHE_bridgeSource_eq_hodgeTheaterDescent
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (packet_bridge :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    (ofStructuredInputsWithSHE bundle packet_bridge).classified_bridge.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport :=
  rfl

theorem ofStructuredInputsWithSHE_histories_not_identified
    (bundle : IUTStage1Theorem311StructuredInputsWithSHE package)
    (packet_bridge :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    let part := ofStructuredInputsWithSHE bundle packet_bridge
    part.hodge_descent_data.domainTheater.side ≠
      part.hodge_descent_data.codomainTheater.side :=
  (ofStructuredInputsWithSHE bundle packet_bridge).histories_not_identified

theorem targetSigned_le_thetaSourceAverage
    (part :
      audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.classified_bridge.packet_bridge.insulated_route.theta_source.thetaSourceAverage
        audited :=
  let sourced := part.toSourcedInsulatedCuspZeroPacketBridgeAudit
  sourced.targetSigned_le_thetaSourceAverage audited

end FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit

namespace FLZModCuspLabelThetaHodgeDescentPacketTransportAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def hodgeTheaterDescentBridgeData
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l) :
    IUTStage1HodgeTheaterDescentBridgeData :=
  part.bundle.hodgeTheaterDescentBridgeData

def toInsulatedCuspZeroPacketBridgeAudit
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  { insulated_route := part.insulated_route,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    cuspClassLocalObject_eq_packetLocalObject :=
      part.cuspClassLocalObject_eq_packetLocalObject,
    zeroLocalObject_eq_packetLocalObject :=
      part.zeroLocalObject_eq_packetLocalObject }

open FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit in
def toHodgeDescentInsulatedCuspZeroBridgeAudit
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l :=
  ofStructuredInputsWithSHE part.bundle
    part.toInsulatedCuspZeroPacketBridgeAudit

theorem hodgeTheaterDescentBridgeData_eq_structuredSHE
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l) :
    part.hodgeTheaterDescentBridgeData =
      part.bundle.hodgeTheaterDescentBridgeData :=
  rfl

theorem histories_not_identified
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l) :
    part.hodgeTheaterDescentBridgeData.domainTheater.side ≠
      part.hodgeTheaterDescentBridgeData.codomainTheater.side :=
  part.bundle.hodgeTheaterDescentBridgeData_histories_not_identified

theorem cuspClassLocalObject_eq_packetLocalObject'
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.cuspClassLocalObject audited label =
      audited.choice.local_tensor_state.packetState.localObject :=
  part.cuspClassLocalObject_eq_packetLocalObject audited label

theorem zeroLocalObject_eq_packetLocalObject'
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.insulated_route.zeroLocalObject audited =
      audited.choice.local_tensor_state.packetState.localObject :=
  part.zeroLocalObject_eq_packetLocalObject audited

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  let packetBridge := part.toInsulatedCuspZeroPacketBridgeAudit
  packetBridge.zeroLocalObject_eq_cuspClassLocalObject audited label

theorem bridgeSource_eq_hodgeTheaterDescentPacketTransport
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l) :
    part.toHodgeDescentInsulatedCuspZeroBridgeAudit.classified_bridge.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport :=
  rfl

theorem comparisonSource_eq_hodgeTheaterDescent
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l) :
    let hodgeBridge := part.toHodgeDescentInsulatedCuspZeroBridgeAudit
    hodgeBridge.toSourcedInsulatedCuspZeroPacketBridgeAudit.comparison_source =
      IUTStage1InsulatedCuspZeroBridgeSource.hodgeTheaterDescentIndeterminacy :=
  rfl

end FLZModCuspLabelThetaHodgeDescentPacketTransportAudit

namespace FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l :=
  { bundle := part.bundle,
    insulated_route := part.insulated_route,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    cuspClassLocalObject_eq_packetLocalObject := by
      intro audited label
      exact
        (part.localObjectTransport audited).cuspClass_transports_to_packet'
          label,
    zeroLocalObject_eq_packetLocalObject := by
      intro audited
      exact (part.localObjectTransport audited).zero_transports_to_packet' }

def toHodgeDescentInsulatedCuspZeroBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaHodgeDescentInsulatedCuspZeroBridgeAudit l :=
  let transport := part.toHodgeDescentPacketTransportAudit
  transport.toHodgeDescentInsulatedCuspZeroBridgeAudit

theorem localObjectTransport_checkpoint_eq_fourthTriangle
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.bundle.hodgeTheaterDescentBridgeData.zeroColumnCheckpoint =
      fourthTriangleHDDSHECheckpoint :=
  (part.localObjectTransport audited).checkpoint_eq_fourthTriangle

def localObjectSquareWeightBoundary
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1LocalObjectHodgeDescentSquareWeightBoundary
      l part.bundle.hodgeTheaterDescentBridgeData
      (part.insulated_route.zeroLocalObject audited)
      (part.insulated_route.cuspClassLocalObject audited)
      audited.choice.local_tensor_state.packetState.localObject :=
  { localObjectTransport := part.localObjectTransport audited }

theorem localObjectSquareWeightBoundary_coordinateEquiv_missing
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1SquareWeightTransportMissingDatum.coordinateEquiv ∈
      (part.localObjectSquareWeightBoundary audited).missingSquareWeightData :=
  (part.localObjectSquareWeightBoundary audited).coordinateEquiv_missing

theorem localObjectSquareWeightBoundary_squareWeightPreservation_missing
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1SquareWeightTransportMissingDatum.squareWeightPreservation ∈
      (part.localObjectSquareWeightBoundary audited).missingSquareWeightData :=
  (part.localObjectSquareWeightBoundary audited).squareWeightPreservation_missing

theorem localObjectSquareWeightBoundary_fullLabelPreservation_missing
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1SquareWeightTransportMissingDatum.fullLabelLogVolumePreservation ∈
      (part.localObjectSquareWeightBoundary audited).missingSquareWeightData :=
  (part.localObjectSquareWeightBoundary audited).fullLabelLogVolumePreservation_missing

theorem localObjectSquareWeightBoundary_coordinateSquarePreservation_missing
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1FactoredSquareFullLabelMissingDatum.coordinateSquarePreservation ∈
      (part.localObjectSquareWeightBoundary audited).missingFactoredSquareFullLabelData :=
  (part.localObjectSquareWeightBoundary audited).coordinateSquarePreservation_missing

theorem localObjectSquareWeightBoundary_fullLabelMapPreservation_missing
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelMapPreservation ∈
      (part.localObjectSquareWeightBoundary audited).missingFactoredSquareFullLabelData :=
  (part.localObjectSquareWeightBoundary audited).fullLabelMapPreservation_missing

theorem localObjectSquareWeightBoundary_fullLabelValuePreservation_missing
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1FactoredSquareFullLabelMissingDatum.fullLabelValuePreservation ∈
      (part.localObjectSquareWeightBoundary audited).missingFactoredSquareFullLabelData :=
  (part.localObjectSquareWeightBoundary audited).fullLabelValuePreservation_missing

theorem zeroLocalObject_eq_packetLocalObject
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.insulated_route.zeroLocalObject audited =
      audited.choice.local_tensor_state.packetState.localObject :=
  (part.localObjectTransport audited).zero_transports_to_packet'

theorem cuspClassLocalObject_eq_packetLocalObject
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.cuspClassLocalObject audited label =
      audited.choice.local_tensor_state.packetState.localObject :=
  (part.localObjectTransport audited).cuspClass_transports_to_packet' label

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  (part.localObjectTransport audited).zero_eq_cuspClass label

theorem bridgeSource_eq_hodgeTheaterDescentPacketTransport
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l) :
    let transport := part.toHodgeDescentPacketTransportAudit
    transport.toHodgeDescentInsulatedCuspZeroBridgeAudit.classified_bridge.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport :=
  let transport := part.toHodgeDescentPacketTransportAudit
  transport.bridgeSource_eq_hodgeTheaterDescentPacketTransport

theorem comparisonSource_eq_hodgeTheaterDescent
    (part :
      audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l) :
    let transport := part.toHodgeDescentPacketTransportAudit
    let hodgeBridge := transport.toHodgeDescentInsulatedCuspZeroBridgeAudit
    hodgeBridge.toSourcedInsulatedCuspZeroPacketBridgeAudit.comparison_source =
      IUTStage1InsulatedCuspZeroBridgeSource.hodgeTheaterDescentIndeterminacy :=
  let transport := part.toHodgeDescentPacketTransportAudit
  transport.comparisonSource_eq_hodgeTheaterDescent

end FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit

namespace FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toStructuredHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l :=
  { bundle := part.bundle,
    insulated_route := part.insulated_route,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    localObjectTransport := fun audited =>
      (part.localObjectOperation audited).toLocalObjectTransportData }

def toHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l :=
  let structured := part.toStructuredHodgeDescentPacketTransportAudit
  structured.toHodgeDescentPacketTransportAudit

theorem zeroOperation_descent_eq_hodgeData
    (part :
      audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.localObjectOperation audited).zeroOperation.descent =
      part.bundle.hodgeTheaterDescentBridgeData.descent :=
  (part.localObjectOperation audited).zeroOperation_descent_eq_hodgeData

theorem cuspClassOperation_descent_eq_hodgeData
    (part :
      audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    ((part.localObjectOperation audited).cuspClassOperation label).descent =
      part.bundle.hodgeTheaterDescentBridgeData.descent :=
  (part.localObjectOperation audited).cuspClassOperation_descent_eq_hodgeData
    label

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part :
      audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  (part.localObjectOperation audited).zero_eq_cuspClass label

theorem bridgeSource_eq_hodgeTheaterDescentPacketTransport
    (part :
      audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l) :
    let structured := part.toStructuredHodgeDescentPacketTransportAudit
    let transport := structured.toHodgeDescentPacketTransportAudit
    transport.toHodgeDescentInsulatedCuspZeroBridgeAudit.classified_bridge.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.hodgeTheaterDescentPacketTransport :=
  let structured := part.toStructuredHodgeDescentPacketTransportAudit
  structured.bridgeSource_eq_hodgeTheaterDescentPacketTransport

end FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit

namespace FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toOperatedHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l :=
  { bundle := part.bundle,
    insulated_route := part.insulated_route,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    localObjectOperation := fun audited =>
      (part.localObjectOperation audited).toCuspZeroLocalObjectOperationData }

def toStructuredHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaStructuredHodgeDescentPacketTransportAudit l :=
  let operated := part.toOperatedHodgeDescentPacketTransportAudit
  operated.toStructuredHodgeDescentPacketTransportAudit

theorem zeroSourceRole_eq
    (part :
      audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.localObjectOperation audited).zeroOperation.sourceRole =
      IUTStage1HodgeDescentLocalObjectRole.zeroColumnSHEInput :=
  (part.localObjectOperation audited).zeroSourceRole_eq

theorem cuspClassSourceRole_eq
    (part :
      audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    ((part.localObjectOperation audited).cuspClassOperation label).sourceRole =
      IUTStage1HodgeDescentLocalObjectRole.cuspClassHodgeArakelovEvaluation :=
  (part.localObjectOperation audited).cuspClassSourceRole_eq label

theorem zeroTargetRole_eq_packet
    (part :
      audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.localObjectOperation audited).zeroOperation.targetRole =
      IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget :=
  (part.localObjectOperation audited).zeroTargetRole_eq_packet

theorem cuspClassTargetRole_eq_packet
    (part :
      audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    ((part.localObjectOperation audited).cuspClassOperation label).targetRole =
      IUTStage1HodgeDescentLocalObjectRole.packetDescentTarget :=
  (part.localObjectOperation audited).cuspClassTargetRole_eq_packet label

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part :
      audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  (part.localObjectOperation audited).zero_eq_cuspClass label

end FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit

namespace FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toRoleMarkedHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l :=
  { bundle := part.bundle,
    insulated_route := part.insulated_route,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    localObjectOperation := fun audited =>
      (part.localObjectOperation audited).toRoleMarkedCuspZeroLocalObjectOperationData }

def toOperatedHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaOperatedHodgeDescentPacketTransportAudit l :=
  let roleMarked := part.toRoleMarkedHodgeDescentPacketTransportAudit
  roleMarked.toOperatedHodgeDescentPacketTransportAudit

theorem zeroSource_checkpoint_eq_fourthTriangle
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.bundle.hodgeTheaterDescentBridgeData.zeroColumnCheckpoint =
      fourthTriangleHDDSHECheckpoint :=
  (part.localObjectOperation audited).zeroSource_checkpoint_eq_fourthTriangle

theorem cuspClassSource_checkpoint_eq_fourthTriangle
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.bundle.hodgeTheaterDescentBridgeData.zeroColumnCheckpoint =
      fourthTriangleHDDSHECheckpoint :=
  (part.localObjectOperation audited).cuspClassSource_checkpoint_eq_fourthTriangle
    label

theorem packetTarget_descent_eq_hodgeData
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.localObjectOperation audited).packetTarget.descent =
      part.bundle.hodgeTheaterDescentBridgeData.descent :=
  (part.localObjectOperation audited).packetTarget_descent_eq_hodgeData

theorem zeroSourceRole_eq
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    ((part.toRoleMarkedHodgeDescentPacketTransportAudit).localObjectOperation
        audited).zeroOperation.sourceRole =
      IUTStage1HodgeDescentLocalObjectRole.zeroColumnSHEInput :=
  let roleMarked := part.toRoleMarkedHodgeDescentPacketTransportAudit
  roleMarked.zeroSourceRole_eq audited

theorem cuspClassSourceRole_eq
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    let roleMarked := part.toRoleMarkedHodgeDescentPacketTransportAudit
    ((roleMarked.localObjectOperation audited).cuspClassOperation label).sourceRole =
      IUTStage1HodgeDescentLocalObjectRole.cuspClassHodgeArakelovEvaluation :=
  let roleMarked := part.toRoleMarkedHodgeDescentPacketTransportAudit
  roleMarked.cuspClassSourceRole_eq audited label

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part :
      audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  (part.localObjectOperation audited).zero_eq_cuspClass label

end FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit

namespace FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toSourceMarkedHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaSourceMarkedHodgeDescentPacketTransportAudit l :=
  { bundle := part.bundle,
    insulated_route := part.insulated_route,
    packetLocalObjectEstimate := part.packetLocalObjectEstimate,
    packetLocalObjectEstimate_eq_packetLocalObject :=
      part.packetLocalObjectEstimate_eq_packetLocalObject,
    localObjectOperation := fun audited =>
      let operation := part.localObjectOperation audited
      operation.toSourceMarkedCuspZeroLocalObjectOperationData }

def toRoleMarkedHodgeDescentPacketTransportAudit
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l) :
    audit.FLZModCuspLabelThetaRoleMarkedHodgeDescentPacketTransportAudit l :=
  let sourceMarked := part.toSourceMarkedHodgeDescentPacketTransportAudit
  sourceMarked.toRoleMarkedHodgeDescentPacketTransportAudit

theorem cuspClassLabel_eq_zmodCoordinate
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    label =
      zmodSignLabelFromCoordinate l
        ((part.localObjectOperation audited).cuspClassSource label).coordinate
        ((part.localObjectOperation audited).cuspClassSource label).coordinate_ne_zero :=
  (part.localObjectOperation audited).cuspClassLabel_eq_zmodCoordinate label

theorem cuspClassLabel_eq_negCoordinate
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    label =
      zmodSignLabelFromCoordinate l
        (-((part.localObjectOperation audited).cuspClassSource label).coordinate)
        (zmod_neg_ne_zero_of_ne_zero l
          ((part.localObjectOperation audited).cuspClassSource label).coordinate_ne_zero) :=
  (part.localObjectOperation audited).cuspClassLabel_eq_negCoordinate label

theorem cuspClassLabel_eq_canonical_of_coordinate_eq_one
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient)
    (hcoord :
      ((part.localObjectOperation audited).cuspClassSource label).coordinate =
        (1 : ZMod l.value)) :
    label = zmodCanonicalSignLabelQuotient l :=
  (part.localObjectOperation audited).cuspClassLabel_eq_canonical_of_coordinate_eq_one
    label hcoord

def fullLabelLocalObject
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1FiniteLocalLogVolumeObject kind :=
  (part.localObjectOperation audited).fullLabelLocalObject label

theorem fullLabelLocalObject_zero
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.fullLabelLocalObject audited IUTStage1ZModCuspFullLabel.zero =
      part.insulated_route.zeroLocalObject audited :=
  rfl

theorem fullLabelLocalObject_nonzero
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.nonzero label) =
      part.insulated_route.cuspClassLocalObject audited label :=
  rfl

theorem fullLabelLocalObject_transports_to_packet
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : IUTStage1ZModCuspFullLabel l) :
    part.fullLabelLocalObject audited label =
      audited.choice.local_tensor_state.packetState.localObject :=
  (part.localObjectOperation audited).fullLabelLocalObject_transports_to_packet label

theorem fullLabelLocalObject_fromCoordinate_zero
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (0 : ZMod l.value)) =
      part.insulated_route.zeroLocalObject audited := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_zero]
  rfl

theorem fullLabelLocalObject_fromCoordinate_nonzero
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    part.fullLabelLocalObject audited
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      part.insulated_route.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj) := by
  rw [IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero l j hj]
  rfl

theorem cuspClassCoordinate_ne_zero
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    ((part.localObjectOperation audited).cuspClassSource label).coordinate ≠ 0 :=
  (part.localObjectOperation audited).cuspClassCoordinate_ne_zero label

theorem zeroLocalObject_eq_cuspClassLocalObject
    (part :
      audit.FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  (part.localObjectOperation audited).zero_eq_cuspClass label

end FLZModCuspLabelThetaZModSourceMarkedHodgeDescentPacketTransportAudit

namespace FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toZModPacketNormalizedRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l :=
  part.toDirectPacketNormalizedLocalObjectRouteAudit.toZModPacketNormalizedRouteAudit

def toConstantZModPacketNormalizedRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l :=
  part.toZModPacketNormalizedRouteAudit.toConstantZModPacketNormalizedRouteAudit

theorem thetaSourceAverage_eq_packetNormalized
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.theta_source.thetaSourceAverage audited =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  let constantRoute := part.toConstantZModPacketNormalizedRouteAudit
  constantRoute.thetaSourceAverage_eq_packetNormalized audited

theorem targetSigned_le_thetaSourceAverage
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  let constantRoute := part.toConstantZModPacketNormalizedRouteAudit
  constantRoute.targetSigned_le_thetaSourceAverage audited

def toInsulatedCuspZeroPacketBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  { insulated_route :=
      { theta_source := part.theta_source,
        ind12_equality_part := part.ind12_equality_part,
        ind3_upper_part := part.ind3_upper_part,
        theta_images_eq_endpoint := part.theta_images_eq_endpoint,
        cuspClassLocalObject := by
          intro audited _label
          exact audited.choice.local_tensor_state.packetState.localObject,
        cuspClassLogVolume_eq_localObjectFinite :=
          part.cuspClassLogVolume_eq_localObjectFinite,
        zeroLocalObject := by
          intro audited
          exact audited.choice.local_tensor_state.packetState.localObject,
        zeroLogVolume_eq_localObjectFinite :=
          part.zeroLogVolume_eq_localObjectFinite },
    packetLocalObjectEstimate := by
      intro audited
      exact
        (part.directNormalization audited).toLocalObjectContainerEstimateOfCapsuleEstimates
          (part.targetCapsuleEstimates audited),
    packetLocalObjectEstimate_eq_packetLocalObject := by
      intro _audited
      rfl,
    cuspClassLocalObject_eq_packetLocalObject := by
      intro _audited _label
      rfl,
    zeroLocalObject_eq_packetLocalObject := by
      intro _audited
      rfl }

open FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit in
def toClassifiedInsulatedCuspZeroPacketBridgeAudit
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  ofDirectLocalLabelObjectConstruction
    part.toInsulatedCuspZeroPacketBridgeAudit

theorem insulatedPacketBridgeSource_eq_direct
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    part.toClassifiedInsulatedCuspZeroPacketBridgeAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  rfl

end FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit

namespace FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toDirectIdentifiedLocalPacketRouteAudit
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l :=
  { theta_source := part.direct_packet.theta_source,
    ind12_equality_part := part.direct_packet.ind12_equality_part,
    ind3_upper_part := part.direct_packet.ind3_upper_part,
    theta_images_eq_endpoint := part.direct_packet.theta_images_eq_endpoint,
    targetCapsuleEstimates := part.targetCapsuleEstimates,
    directNormalization := part.direct_packet.zeroDirectNormalization,
    cuspClassLogVolume_eq_localObjectFinite := by
      intro audited label
      let estimate := part.direct_packet.cuspClassObjectEstimate audited label
      calc
        (part.direct_packet.theta_source.compatible_average.cuspLogVolume
          audited).cuspClassLogVolume label =
            estimate.localObject.finiteLogVolume :=
          estimate.localLogVolume_eq_object
        _ =
            audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
          rw [part.direct_packet.cuspClassObject_eq_packetLocalObject audited label],
    zeroLogVolume_eq_localObjectFinite := by
      intro audited
      let estimate := part.direct_packet.zeroObjectEstimate audited
      calc
        (part.direct_packet.theta_source.compatible_average.cuspLogVolume
          audited).zeroLogVolume =
            estimate.localObject.finiteLogVolume :=
          estimate.localLogVolume_eq_object
        _ =
            audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume := by
          rw [part.direct_packet.zeroObject_eq_packetLocalObject audited] }

def toDirectCapsuleCuspClassAudit
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l :=
  { packet_normalized :=
      part.direct_packet.toClassifiedPacketNormalizedAudit.packet_normalized,
    targetCapsuleEstimates := part.targetCapsuleEstimates }

def toFullClassifiedRouteSummary
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  let packetSummary := part.direct_packet.toClassifiedPacketNormalizedAudit
  let direct := part.toDirectCapsuleCuspClassAudit
  FLZModCuspLabelThetaFullClassifiedRouteSummary.ofDirectCapsule
    packetSummary direct rfl

theorem packetIdentificationSource_eq_direct
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  rfl

theorem cuspBoundSource_eq_directCapsule
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.directCapsuleEstimates :=
  rfl

theorem targetSigned_le_thetaSourceAverage
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.direct_packet.theta_source.thetaSourceAverage audited :=
  let identifiedRoute := part.toDirectIdentifiedLocalPacketRouteAudit
  identifiedRoute.targetSigned_le_thetaSourceAverage audited

end FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit

namespace FLZModCuspLabelThetaPacketLocalObjectContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_thetaSourceAverage_of_directPacket
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState)
    (targetCapsuleEstimates :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1TypedCapsuleFamilyContainerEstimate
          package.preLedger.targetVolume.targetSigned
          audited.choice.local_tensor_state.packetState.capsuleFamily)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited := by
  let directRoute :=
    part.toDirectLocalPacketDirectCapsuleRouteAudit
      directNormalization targetCapsuleEstimates
  exact directRoute.targetSigned_le_thetaSourceAverage audited

end FLZModCuspLabelThetaPacketLocalObjectContainerAudit

namespace FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem targetSigned_le_thetaSourceAverage_of_directPacket
    (part : audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState)
    (targetCapsuleEstimates :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1TypedCapsuleFamilyContainerEstimate
          package.preLedger.targetVolume.targetSigned
          audited.choice.local_tensor_state.packetState.capsuleFamily)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.packet_local_object.theta_source.thetaSourceAverage audited :=
  part.packet_local_object.targetSigned_le_thetaSourceAverage_of_directPacket
    directNormalization targetCapsuleEstimates audited

end FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit

namespace FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

def toInd2TransportedCuspClassAudit
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l :=
  { packet_normalized :=
      part.ind2_packet.toClassifiedPacketNormalizedAudit.packet_normalized,
    sourceAudited := part.ind2_packet.sourceAudited,
    ind2_step := part.ind2_packet.ind2_step,
    sourceCapsuleEstimates := part.sourceCapsuleEstimates }

def toFullClassifiedRouteSummary
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  let packetSummary := part.ind2_packet.toClassifiedPacketNormalizedAudit
  let transported := part.toInd2TransportedCuspClassAudit
  FLZModCuspLabelThetaFullClassifiedRouteSummary.ofInd2Transport
    packetSummary transported rfl

theorem packetIdentificationSource_eq_ind2Transported
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization :=
  rfl

theorem cuspBoundSource_eq_ind2Transported
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l) :
    part.toFullClassifiedRouteSummary.cuspBoundSource =
      IUTStage1CuspClassBoundSource.ind2TransportedCapsuleEstimates :=
  rfl

theorem targetSigned_le_thetaSourceAverage
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.ind2_packet.theta_source.thetaSourceAverage audited :=
  let transported := part.toInd2TransportedCuspClassAudit
  transported.targetSigned_le_thetaAverage audited

end FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit

namespace FLZModCuspLabelThetaContainerBoundAudit

variable {audit : endpoint.LogVolumeChartAudit}
variable {l : PrimeGeFive}

theorem boundSource_not_ind3Only
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l) :
    part.bound_source ≠ IUTStage1TargetAverageBoundSource.ind3UpperSemiOnly :=
  part.bound_source_not_ind3_only

theorem targetSigned_le_thetaAverage'
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaAverage audited

theorem ind3TargetSigned_le_thetaSigned
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  part.ind3_upper_part.targetSigned_le_thetaSigned

def toTargetAverageReductionAudit
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l) :
    audit.FLZModCuspLabelTargetAverageReductionAudit l :=
  { theta_source := part.theta_source,
    ind12_equality_part := part.ind12_equality_part,
    targetSigned_le_thetaAverage := part.targetSigned_le_thetaAverage }

theorem qSigned_le_thetaSourceAverage
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= part.theta_source.thetaSourceAverage audited :=
  part.toTargetAverageReductionAudit.qSigned_le_thetaSourceAverage audited

theorem qSigned_le_thetaSigned_via_average
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toTargetAverageReductionAudit.toQThetaComparisonAudit_qSigned_le_thetaSigned
    audited

theorem targetSigned_le_thetaSigned_via_average
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <= package.preLedger.thetaSigned :=
  part.toTargetAverageReductionAudit.targetSigned_le_thetaSigned_via_average
    audited

end FLZModCuspLabelThetaContainerBoundAudit

end LogVolumeChartAudit

end PlaceAuditedMultiradialThetaHullEndpoint

theorem auditOfParts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    Audit package (package.obligationsFromParts subclaims sideConditions) :=
  package.audit (package.obligationsFromParts subclaims sideConditions)

theorem auditOfHypotheses
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Audit package (package.obligationsFromHypotheses subclaims hypotheses) :=
  package.audit (package.obligationsFromHypotheses subclaims hypotheses)

theorem auditOfStructuredInputs
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    Audit package
      (package.obligationsFromStructuredInputs inputs sideConditions) :=
  package.audit
    (package.obligationsFromStructuredInputs inputs sideConditions)

theorem auditOfStructuredHypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  package.audit
    (package.obligationsFromStructuredHypotheses inputs hypotheses)

theorem sideConditionAuditOfHypotheses
    (package : IUTStage1SourcePackage source target index)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    IUTStage1SourceSideConditionHypotheses.Audit hypotheses :=
  hypotheses.audit

/--
Combined audit for the hypothesis-based package route.

The record keeps the side-condition-hypothesis audit separate from the source
package audit while making both available to downstream consumers.
-/
structure HypothesisRouteAudit
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Prop where
  side_condition_audit :
    IUTStage1SourceSideConditionHypotheses.Audit hypotheses
  source_audit :
    Audit package (package.obligationsFromHypotheses subclaims hypotheses)

theorem hypothesisRouteAudit
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    HypothesisRouteAudit package subclaims hypotheses :=
  { side_condition_audit :=
      package.sideConditionAuditOfHypotheses hypotheses,
    source_audit := package.auditOfHypotheses subclaims hypotheses }

namespace HypothesisRouteAudit

variable {package : IUTStage1SourcePackage source target index}
variable {subclaims : IUTStage1Theorem311Subclaims package}
variable {hypotheses : IUTStage1SourceSideConditionHypotheses package}

theorem sideConditionAudit
    (audit : HypothesisRouteAudit package subclaims hypotheses) :
    IUTStage1SourceSideConditionHypotheses.Audit hypotheses :=
  audit.side_condition_audit

theorem sourceAudit
    (audit : HypothesisRouteAudit package subclaims hypotheses) :
    Audit package (package.obligationsFromHypotheses subclaims hypotheses) :=
  audit.source_audit

theorem qPilotLogVolumePositive
    (audit : HypothesisRouteAudit package subclaims hypotheses) :
    0 < -package.preLedger.qSigned :=
  audit.sideConditionAudit.qPilotLogVolumePositive

theorem qSignedLeThetaSigned
    (audit : HypothesisRouteAudit package subclaims hypotheses) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  audit.sourceAudit.qSigned_le_thetaSigned

end HypothesisRouteAudit

/--
Structured-input analogue of `HypothesisRouteAudit`.

The side-condition audit remains separate from the source-package audit; the
only difference is that the Theorem 3.11 data is supplied via structured inputs.
-/
structure StructuredHypothesisRouteAudit
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Prop where
  side_condition_audit :
    IUTStage1SourceSideConditionHypotheses.Audit hypotheses
  source_audit :
    Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses)

theorem structuredHypothesisRouteAudit
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    StructuredHypothesisRouteAudit package inputs hypotheses :=
  { side_condition_audit :=
      package.sideConditionAuditOfHypotheses hypotheses,
    source_audit := package.auditOfStructuredHypotheses inputs hypotheses }

namespace StructuredHypothesisRouteAudit

variable {package : IUTStage1SourcePackage source target index}
variable {inputs : IUTStage1Theorem311StructuredInputs package}
variable {hypotheses : IUTStage1SourceSideConditionHypotheses package}

theorem sideConditionAudit
    (audit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    IUTStage1SourceSideConditionHypotheses.Audit hypotheses :=
  audit.side_condition_audit

theorem sourceAudit
    (audit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  audit.source_audit

theorem qPilotLogVolumePositive
    (audit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    0 < -package.preLedger.qSigned :=
  audit.sideConditionAudit.qPilotLogVolumePositive

theorem qSignedLeThetaSigned
    (audit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  audit.sourceAudit.qSigned_le_thetaSigned

theorem auditedPublicEndpoint
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfStructuredHypotheses inputs hypotheses :=
  ⟨routeAudit.sourceAudit, Subsingleton.elim _ _⟩

end StructuredHypothesisRouteAudit

theorem hypothesisRouteAudit_sideConditionAudit_eq
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.hypothesisRouteAudit subclaims hypotheses).sideConditionAudit =
      package.sideConditionAuditOfHypotheses hypotheses :=
  rfl

theorem hypothesisRouteAudit_sourceAudit_eq
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.hypothesisRouteAudit subclaims hypotheses).sourceAudit =
      package.auditOfHypotheses subclaims hypotheses :=
  rfl

theorem auditOfHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditOfHypotheses subclaims hypotheses =
      package.auditOfParts subclaims hypotheses.toSideConditions :=
  rfl

theorem auditOfStructuredInputs_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.auditOfStructuredInputs inputs sideConditions =
      package.auditOfParts inputs.theorem311Subclaims sideConditions :=
  rfl

theorem auditOfStructuredHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditOfStructuredHypotheses inputs hypotheses =
      package.auditOfStructuredInputs inputs hypotheses.toSideConditions :=
  rfl

theorem auditOfStructuredHypotheses_eq_hypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditOfStructuredHypotheses inputs hypotheses =
      package.auditOfHypotheses inputs.theorem311Subclaims hypotheses :=
  rfl

theorem structuredHypothesisRouteAudit_sideConditionAudit_eq
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.structuredHypothesisRouteAudit
      inputs hypotheses).sideConditionAudit =
      package.sideConditionAuditOfHypotheses hypotheses :=
  rfl

theorem structuredHypothesisRouteAudit_sourceAudit_eq
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit =
      package.auditOfStructuredHypotheses inputs hypotheses :=
  rfl

theorem structuredHypothesisRouteAudit_sourceAudit_eq_hypothesisRoute
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit =
      (package.hypothesisRouteAudit
        inputs.theorem311Subclaims hypotheses).sourceAudit :=
  rfl

theorem auditedPublicEndpoint
    (package : IUTStage1SourcePackage source target index)
    (obligations : IUTStage1SourceObligations package) :
    ∃ sourceAudit : Audit package obligations,
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider obligations).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned)) =
        package.publicAudit obligations :=
  ⟨package.audit obligations, Subsingleton.elim _ _⟩

namespace ComparisonDataEndpoint

variable {package : IUTStage1SourcePackage source target index}
variable {obligations : IUTStage1SourceObligations package}

theorem auditedPublicEndpoint
    (_endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider obligations).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned)) =
        package.publicAudit obligations :=
  package.auditedPublicEndpoint obligations

end ComparisonDataEndpoint

theorem auditedPublicEndpointOfGap
    (package : IUTStage1SourcePackage source target index)
    (gap : IUTStage1SourceObligationGap package) :
    ∃ sourceAudit : Audit package gap.toSourceObligations,
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider gap.toSourceObligations).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                gap.toSourceObligations).ledger.qSigned_le_thetaSigned)) =
        package.publicAudit gap.toSourceObligations :=
  package.auditedPublicEndpoint gap.toSourceObligations

theorem auditedPublicEndpointOfParts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    ∃ sourceAudit :
        Audit package (package.obligationsFromParts subclaims sideConditions),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromParts
                  subclaims sideConditions)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromParts
                  subclaims sideConditions)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfParts subclaims sideConditions :=
  package.auditedPublicEndpoint
    (package.obligationsFromParts subclaims sideConditions)

theorem auditedPublicEndpointOfHypotheses
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package (package.obligationsFromHypotheses subclaims hypotheses),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromHypotheses
                  subclaims hypotheses)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromHypotheses
                  subclaims hypotheses)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfHypotheses subclaims hypotheses :=
  package.auditedPublicEndpoint
    (package.obligationsFromHypotheses subclaims hypotheses)

theorem auditedPublicEndpointOfHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditedPublicEndpointOfHypotheses subclaims hypotheses =
      package.auditedPublicEndpointOfParts
        subclaims hypotheses.toSideConditions :=
  Subsingleton.elim _ _

theorem auditedPublicEndpointOfStructuredInputs
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredInputs inputs sideConditions),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromStructuredInputs
                  inputs sideConditions)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromStructuredInputs
                  inputs sideConditions)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfStructuredInputs inputs sideConditions :=
  package.auditedPublicEndpoint
    (package.obligationsFromStructuredInputs inputs sideConditions)

theorem auditedPublicEndpointOfStructuredHypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfStructuredHypotheses inputs hypotheses :=
  package.auditedPublicEndpoint
    (package.obligationsFromStructuredHypotheses inputs hypotheses)

theorem auditedPublicEndpointOfStructuredInputs_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.auditedPublicEndpointOfStructuredInputs
        inputs sideConditions =
      package.auditedPublicEndpointOfParts
        inputs.theorem311Subclaims sideConditions :=
  Subsingleton.elim _ _

theorem auditedPublicEndpointOfStructuredHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditedPublicEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedPublicEndpointOfStructuredInputs
        inputs hypotheses.toSideConditions :=
  Subsingleton.elim _ _

theorem auditedPublicEndpointOfStructuredHypotheses_eq_hypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditedPublicEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedPublicEndpointOfHypotheses
        inputs.theorem311Subclaims hypotheses :=
  Subsingleton.elim _ _

theorem auditedComparisonDataEndpointOfGap
    (package : IUTStage1SourcePackage source target index)
    (gap : IUTStage1SourceObligationGap package) :
    package.ComparisonDataEndpoint gap.toSourceObligations :=
  package.auditedComparisonDataEndpoint gap.toSourceObligations

theorem auditedComparisonDataEndpointOfParts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.ComparisonDataEndpoint
      (package.obligationsFromParts subclaims sideConditions) :=
  package.auditedComparisonDataEndpoint
    (package.obligationsFromParts subclaims sideConditions)

theorem auditedComparisonDataEndpointOfHypotheses
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.ComparisonDataEndpoint
      (package.obligationsFromHypotheses subclaims hypotheses) :=
  package.auditedComparisonDataEndpoint
    (package.obligationsFromHypotheses subclaims hypotheses)

theorem auditedComparisonDataEndpointOfHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (subclaims : IUTStage1Theorem311Subclaims package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditedComparisonDataEndpointOfHypotheses subclaims hypotheses =
      package.auditedComparisonDataEndpointOfParts
        subclaims hypotheses.toSideConditions :=
  Subsingleton.elim _ _

theorem auditedComparisonDataEndpointOfStructuredInputs
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.ComparisonDataEndpoint
      (package.obligationsFromStructuredInputs inputs sideConditions) :=
  package.auditedComparisonDataEndpoint
    (package.obligationsFromStructuredInputs inputs sideConditions)

theorem auditedComparisonDataEndpointOfStructuredHypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.ComparisonDataEndpoint
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  package.auditedComparisonDataEndpoint
    (package.obligationsFromStructuredHypotheses inputs hypotheses)

theorem auditedComparisonDataEndpointOfStructuredInputs_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (sideConditions : IUTStage1SourceSideConditions package) :
    package.auditedComparisonDataEndpointOfStructuredInputs
        inputs sideConditions =
      package.auditedComparisonDataEndpointOfParts
        inputs.theorem311Subclaims sideConditions :=
  Subsingleton.elim _ _

theorem auditedComparisonDataEndpointOfStructuredHypotheses_eq_parts
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditedComparisonDataEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedComparisonDataEndpointOfStructuredInputs
        inputs hypotheses.toSideConditions :=
  Subsingleton.elim _ _

theorem auditedComparisonDataEndpointOfStructuredHypotheses_eq_hypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    package.auditedComparisonDataEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedComparisonDataEndpointOfHypotheses
        inputs.theorem311Subclaims hypotheses :=
  Subsingleton.elim _ _

namespace Audit

variable {package : IUTStage1SourcePackage source target index}
variable {obligations : IUTStage1SourceObligations package}

theorem inputMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.input = package.labels.input :=
  sourceAudit.input_matches_labels

theorem multiradialOutputMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.multiradialOutput = package.labels.multiradialOutput :=
  sourceAudit.multiradialOutput_matches_labels

theorem logVolumeComparisonMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.logVolumeComparison = package.labels.logVolumeComparison :=
  sourceAudit.logVolumeComparison_matches_labels

theorem thetaPilotMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.thetaPilot = package.labels.thetaPilot :=
  sourceAudit.thetaPilot_matches_labels

theorem qPilotMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.qPilot = package.labels.qPilot :=
  sourceAudit.qPilot_matches_labels

theorem logKummerMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.logKummer = package.labels.logKummer :=
  sourceAudit.logKummer_matches_labels

theorem indeterminaciesMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.indeterminacies = package.labels.indeterminacies :=
  sourceAudit.indeterminacies_matches_labels

theorem qPilotLogVolumeMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.qPilotLogVolume = package.labels.qPilotLogVolume :=
  sourceAudit.qPilotLogVolume_matches_labels

theorem sourceNormalizationMatchesLabels
    (sourceAudit : Audit package obligations) :
    package.sourceNormalizationLabel = package.labels.sourceNormalization :=
  sourceAudit.sourceNormalization_matches_labels

theorem algorithmCertified
    (sourceAudit : Audit package obligations) :
    package.preLedger.output.Certified :=
  sourceAudit.algorithm_certified

theorem sheArrowMatchesCertificate
    (sourceAudit : Audit package obligations) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  sourceAudit.she_arrow_matches_certificate

theorem qPilotPositive
    (sourceAudit : Audit package obligations) :
    0 < -package.preLedger.qSigned :=
  sourceAudit.q_pilot_positive

theorem sourceNormalization
    (sourceAudit : Audit package obligations) :
    package.preLedger.normalization :=
  sourceAudit.normalization

theorem promotedProviderLedger
    (sourceAudit : Audit package obligations) :
    (package.promotedProvider obligations).ledger =
      package.promotedLedger obligations :=
  sourceAudit.promoted_provider_ledger

def comparisonPayloadInputs
    (_sourceAudit : Audit package obligations) :
    package.preLedger.ComparisonPayloadInputs :=
  package.comparisonPayloadInputs

theorem comparisonPayloadInputsEqPackage
    (sourceAudit : Audit package obligations) :
    sourceAudit.comparisonPayloadInputs =
      package.comparisonPayloadInputs :=
  Subsingleton.elim _ _

theorem comparisonPayloadInputsQSignedLeThetaSigned
    (sourceAudit : Audit package obligations) :
    sourceAudit.comparisonPayloadInputs.qSignedLeThetaSigned =
      package.comparisonPayloadInputs.qSignedLeThetaSigned :=
  Subsingleton.elim _ _

theorem comparisonPayloadInputsEqPreLedgerAudit
    (sourceAudit : Audit package obligations) :
    sourceAudit.comparisonPayloadInputs =
      package.preLedger.audit.comparisonPayloadInputs :=
  Subsingleton.elim _ _

def comparisonData
    (_sourceAudit : Audit package obligations) :
    Corollary312ComparisonData :=
  package.comparisonData obligations

theorem comparisonDataEqPackage
    (sourceAudit : Audit package obligations) :
    sourceAudit.comparisonData = package.comparisonData obligations :=
  rfl

theorem comparisonDataFromPayloadInputsEqComparisonData
    (sourceAudit : Audit package obligations) :
    package.comparisonDataFromPayloadInputs obligations =
      sourceAudit.comparisonData :=
  package.comparisonDataFromPayloadInputs_eq_comparisonData obligations

theorem comparisonDataFromPayloadInputsStage1ComparisonEq
    (sourceAudit : Audit package obligations) :
    (package.comparisonDataFromPayloadInputs obligations).stage1Comparison =
      sourceAudit.comparisonData.stage1Comparison :=
  package.comparisonDataFromPayloadInputs_stage1Comparison_eq obligations

theorem comparisonDataStage1Comparison
    (sourceAudit : Audit package obligations) :
    sourceAudit.comparisonData.stage1Comparison =
      (package.promotedProvider obligations).stage1Comparison :=
  package.comparisonData_stage1Comparison_eq obligations

theorem comparisonDataCorollary312
    (sourceAudit : Audit package obligations) :
    sourceAudit.comparisonData.corollary312 =
      (package.promotedProvider obligations).corollary312 :=
  package.comparisonData_corollary312_eq obligations

theorem qSignedLeThetaSigned
    (sourceAudit : Audit package obligations) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  sourceAudit.qSigned_le_thetaSigned

theorem corollary312Endpoint
    (sourceAudit : Audit package obligations) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  sourceAudit.corollary312

theorem stageRecoversQSignedLeThetaSigned
    (sourceAudit : Audit package obligations) :
    corollary312_from_stage1_comparison
        (package.promotedProvider obligations).stage1Comparison =
      corollary312_of_signed_le
        (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned :=
  sourceAudit.stage_recovers_qSigned_le_thetaSigned

theorem stageRecoversCorollary312
    (sourceAudit : Audit package obligations) :
    corollary312_from_stage1_comparison
        (package.promotedProvider obligations).stage1Comparison =
      (package.promotedProvider obligations).ledger.corollary312 :=
  sourceAudit.stage_recovers_corollary312

/-- Compact summary of the audited route from source payload inputs to endpoint data. -/
structure PayloadRouteSummary
    (sourceAudit : Audit package obligations) : Prop where
  payload_inputs_eq_package :
    sourceAudit.comparisonPayloadInputs =
      package.comparisonPayloadInputs
  payload_data_eq_comparison_data :
    package.comparisonDataFromPayloadInputs obligations =
      sourceAudit.comparisonData
  comparison_data_eq_package :
    sourceAudit.comparisonData = package.comparisonData obligations
  stage1Comparison_eq_provider :
    sourceAudit.comparisonData.stage1Comparison =
      (package.promotedProvider obligations).stage1Comparison
  corollary312_eq_provider :
    sourceAudit.comparisonData.corollary312 =
      (package.promotedProvider obligations).corollary312
  comparison_data_recovers :
    corollary312_from_stage1_comparison
        sourceAudit.comparisonData.stage1Comparison =
      corollary312_of_signed_le
        sourceAudit.comparisonData.qSigned_le_thetaSigned

theorem payloadRouteSummary
    (sourceAudit : Audit package obligations) :
    PayloadRouteSummary sourceAudit :=
  { payload_inputs_eq_package :=
      sourceAudit.comparisonPayloadInputsEqPackage,
    payload_data_eq_comparison_data :=
      sourceAudit.comparisonDataFromPayloadInputsEqComparisonData,
    comparison_data_eq_package :=
      sourceAudit.comparisonDataEqPackage,
    stage1Comparison_eq_provider :=
      sourceAudit.comparisonDataStage1Comparison,
    corollary312_eq_provider :=
      sourceAudit.comparisonDataCorollary312,
    comparison_data_recovers :=
      sourceAudit.comparisonData.publicAudit_stage1Comparison_recovers }

theorem publicAuditEq
    (sourceAudit : Audit package obligations) :
    (⟨sourceAudit.qSignedLeThetaSigned,
        sourceAudit.corollary312Endpoint,
        sourceAudit.stageRecoversQSignedLeThetaSigned⟩ :
      package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
        Corollary312Inequality
          (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
          (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
        (corollary312_from_stage1_comparison
            (package.promotedProvider obligations).stage1Comparison =
          corollary312_of_signed_le
            (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned)) =
      package.publicAudit obligations :=
  Subsingleton.elim _ _

end Audit

namespace ComparisonDataEndpoint

variable {package : IUTStage1SourcePackage source target index}
variable {obligations : IUTStage1SourceObligations package}

theorem payloadRouteSummaryExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      Audit.PayloadRouteSummary sourceAudit := by
  rcases endpoint with ⟨sourceAudit, _data, _hdata, _hle, _hcorollary, _hrecovers⟩
  exact ⟨sourceAudit, sourceAudit.payloadRouteSummary⟩

theorem payloadRouteSummaryAndPublicAudit
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      Audit.PayloadRouteSummary sourceAudit ∧
        endpoint.publicAudit = package.publicAudit obligations := by
  rcases endpoint.payloadRouteSummaryExists with ⟨sourceAudit, summary⟩
  exact ⟨sourceAudit, summary, endpoint.publicAudit_eq_package_publicAudit⟩

theorem payloadInputsEqPackageExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      sourceAudit.comparisonPayloadInputs =
        package.comparisonPayloadInputs := by
  rcases endpoint.payloadRouteSummaryExists with ⟨sourceAudit, summary⟩
  exact ⟨sourceAudit, summary.payload_inputs_eq_package⟩

theorem payloadDataEqComparisonDataExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      package.comparisonDataFromPayloadInputs obligations =
        sourceAudit.comparisonData := by
  rcases endpoint.payloadRouteSummaryExists with ⟨sourceAudit, summary⟩
  exact ⟨sourceAudit, summary.payload_data_eq_comparison_data⟩

theorem comparisonDataEqPackageExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      sourceAudit.comparisonData =
        package.comparisonData obligations := by
  rcases endpoint.payloadRouteSummaryExists with ⟨sourceAudit, summary⟩
  exact ⟨sourceAudit, summary.comparison_data_eq_package⟩

theorem stage1ComparisonEqProviderExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      sourceAudit.comparisonData.stage1Comparison =
        (package.promotedProvider obligations).stage1Comparison := by
  rcases endpoint.payloadRouteSummaryExists with ⟨sourceAudit, summary⟩
  exact ⟨sourceAudit, summary.stage1Comparison_eq_provider⟩

theorem corollary312EqProviderExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      sourceAudit.comparisonData.corollary312 =
        (package.promotedProvider obligations).corollary312 := by
  rcases endpoint.payloadRouteSummaryExists with ⟨sourceAudit, summary⟩
  exact ⟨sourceAudit, summary.corollary312_eq_provider⟩

theorem comparisonDataRecoversExists
    (endpoint : package.ComparisonDataEndpoint obligations) :
    ∃ sourceAudit : Audit package obligations,
      corollary312_from_stage1_comparison
          sourceAudit.comparisonData.stage1Comparison =
        corollary312_of_signed_le
          sourceAudit.comparisonData.qSigned_le_thetaSigned := by
  rcases endpoint.payloadRouteSummaryExists with ⟨sourceAudit, summary⟩
  exact ⟨sourceAudit, summary.comparison_data_recovers⟩

end ComparisonDataEndpoint

namespace StructuredHypothesisRouteAudit

variable {package : IUTStage1SourcePackage source target index}
variable {inputs : IUTStage1Theorem311StructuredInputs package}
variable {hypotheses : IUTStage1SourceSideConditionHypotheses package}

theorem payloadRouteSummary
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    Audit.PayloadRouteSummary routeAudit.sourceAudit :=
  routeAudit.sourceAudit.payloadRouteSummary

theorem comparisonDataEndpointPayloadRouteSummary
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      Audit.PayloadRouteSummary sourceAudit ∧
        (package.auditedComparisonDataEndpointOfStructuredHypotheses
          inputs hypotheses).publicAudit =
          package.publicAuditOfStructuredHypotheses inputs hypotheses := by
  let endpoint :=
    package.auditedComparisonDataEndpointOfStructuredHypotheses
      inputs hypotheses
  have hpublic :
      endpoint.publicAudit =
        package.publicAudit
          (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
    endpoint.publicAudit_eq_package_publicAudit
  exact ⟨routeAudit.sourceAudit, routeAudit.payloadRouteSummary, by
    simpa [IUTStage1SourcePackage.publicAuditOfStructuredHypotheses] using
      hpublic⟩

theorem payloadInputsEqPackage
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    routeAudit.sourceAudit.comparisonPayloadInputs =
      package.comparisonPayloadInputs :=
  routeAudit.payloadRouteSummary.payload_inputs_eq_package

theorem payloadDataEqComparisonData
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    package.comparisonDataFromPayloadInputs
        (package.obligationsFromStructuredHypotheses inputs hypotheses) =
      routeAudit.sourceAudit.comparisonData :=
  routeAudit.payloadRouteSummary.payload_data_eq_comparison_data

theorem comparisonDataEqPackage
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    routeAudit.sourceAudit.comparisonData =
      package.comparisonData
        (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  routeAudit.payloadRouteSummary.comparison_data_eq_package

theorem stage1ComparisonEqProvider
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    routeAudit.sourceAudit.comparisonData.stage1Comparison =
      (package.promotedProvider
        (package.obligationsFromStructuredHypotheses
          inputs hypotheses)).stage1Comparison :=
  routeAudit.payloadRouteSummary.stage1Comparison_eq_provider

theorem corollary312EqProvider
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    routeAudit.sourceAudit.comparisonData.corollary312 =
      (package.promotedProvider
        (package.obligationsFromStructuredHypotheses
          inputs hypotheses)).corollary312 :=
  routeAudit.payloadRouteSummary.corollary312_eq_provider

theorem comparisonDataRecovers
    (routeAudit : StructuredHypothesisRouteAudit package inputs hypotheses) :
    corollary312_from_stage1_comparison
        routeAudit.sourceAudit.comparisonData.stage1Comparison =
      corollary312_of_signed_le
        routeAudit.sourceAudit.comparisonData.qSigned_le_thetaSigned :=
  routeAudit.payloadRouteSummary.comparison_data_recovers

end StructuredHypothesisRouteAudit

theorem structuredEndpointPayloadInputsEqPackageExists
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      sourceAudit.comparisonPayloadInputs =
        package.comparisonPayloadInputs :=
  (package.auditedComparisonDataEndpointOfStructuredHypotheses
    inputs hypotheses).payloadInputsEqPackageExists

theorem structuredEndpointPayloadDataEqComparisonDataExists
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      package.comparisonDataFromPayloadInputs
          (package.obligationsFromStructuredHypotheses inputs hypotheses) =
        sourceAudit.comparisonData :=
  (package.auditedComparisonDataEndpointOfStructuredHypotheses
    inputs hypotheses).payloadDataEqComparisonDataExists

theorem structuredEndpointComparisonDataEqPackageExists
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      sourceAudit.comparisonData =
        package.comparisonData
          (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  (package.auditedComparisonDataEndpointOfStructuredHypotheses
    inputs hypotheses).comparisonDataEqPackageExists

theorem structuredEndpointStage1ComparisonEqProviderExists
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      sourceAudit.comparisonData.stage1Comparison =
        (package.promotedProvider
          (package.obligationsFromStructuredHypotheses
            inputs hypotheses)).stage1Comparison :=
  (package.auditedComparisonDataEndpointOfStructuredHypotheses
    inputs hypotheses).stage1ComparisonEqProviderExists

theorem structuredEndpointCorollary312EqProviderExists
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      sourceAudit.comparisonData.corollary312 =
        (package.promotedProvider
          (package.obligationsFromStructuredHypotheses
            inputs hypotheses)).corollary312 :=
  (package.auditedComparisonDataEndpointOfStructuredHypotheses
    inputs hypotheses).corollary312EqProviderExists

theorem structuredEndpointComparisonDataRecoversExists
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    ∃ sourceAudit :
        Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      corollary312_from_stage1_comparison
          sourceAudit.comparisonData.stage1Comparison =
        corollary312_of_signed_le
          sourceAudit.comparisonData.qSigned_le_thetaSigned :=
  (package.auditedComparisonDataEndpointOfStructuredHypotheses
    inputs hypotheses).comparisonDataRecoversExists

/--
Compact audit summary for the structured comparison-data endpoint.

The summary keeps one source audit witness while also recording that the
structured endpoint has the same public audit as the structured-hypothesis
route.
-/
structure StructuredEndpointAuditSummary
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    Prop where
  source_audit :
    Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses)
  payload_route_summary :
    Audit.PayloadRouteSummary source_audit
  endpoint_public_audit_eq :
    (package.auditedComparisonDataEndpointOfStructuredHypotheses
      inputs hypotheses).publicAudit =
      package.publicAuditOfStructuredHypotheses inputs hypotheses

theorem structuredEndpointAuditSummary
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    StructuredEndpointAuditSummary package inputs hypotheses :=
  let routeAudit := package.structuredHypothesisRouteAudit inputs hypotheses
  { source_audit := routeAudit.sourceAudit,
    payload_route_summary := routeAudit.payloadRouteSummary,
    endpoint_public_audit_eq := by
      let endpoint :=
        package.auditedComparisonDataEndpointOfStructuredHypotheses
          inputs hypotheses
      have hpublic :
          endpoint.publicAudit =
            package.publicAudit
              (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
        endpoint.publicAudit_eq_package_publicAudit
      simpa [IUTStage1SourcePackage.publicAuditOfStructuredHypotheses] using
        hpublic }

theorem structuredEndpointAuditSummary_sourceAudit_eq_routeAudit
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.structuredEndpointAuditSummary inputs hypotheses).source_audit =
      (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit :=
  rfl

theorem structuredEndpointAuditSummary_sourceAudit_eq_auditOfStructuredHypotheses
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.structuredEndpointAuditSummary inputs hypotheses).source_audit =
      package.auditOfStructuredHypotheses inputs hypotheses :=
  rfl

theorem structuredEndpointAuditSummary_payloadRouteSummary_eq_routeAudit
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.structuredEndpointAuditSummary
      inputs hypotheses).payload_route_summary =
      (package.structuredHypothesisRouteAudit
        inputs hypotheses).payloadRouteSummary :=
  rfl

theorem structuredEndpointAuditSummary_publicAuditEq_eq_routeAudit
    (package : IUTStage1SourcePackage source target index)
    (inputs : IUTStage1Theorem311StructuredInputs package)
    (hypotheses : IUTStage1SourceSideConditionHypotheses package) :
    (package.structuredEndpointAuditSummary
      inputs hypotheses).endpoint_public_audit_eq =
      (package.structuredHypothesisRouteAudit
        inputs hypotheses).comparisonDataEndpointPayloadRouteSummary.choose_spec.2 :=
  Subsingleton.elim _ _

namespace StructuredEndpointAuditSummary

variable {package : IUTStage1SourcePackage source target index}
variable {inputs : IUTStage1Theorem311StructuredInputs package}
variable {hypotheses : IUTStage1SourceSideConditionHypotheses package}

theorem sourceAudit
    (summary : StructuredEndpointAuditSummary package inputs hypotheses) :
    Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  summary.source_audit

theorem payloadRouteSummary
    (summary : StructuredEndpointAuditSummary package inputs hypotheses) :
    Audit.PayloadRouteSummary summary.sourceAudit :=
  summary.payload_route_summary

theorem endpointPublicAuditEq
    (summary : StructuredEndpointAuditSummary package inputs hypotheses) :
    (package.auditedComparisonDataEndpointOfStructuredHypotheses
      inputs hypotheses).publicAudit =
      package.publicAuditOfStructuredHypotheses inputs hypotheses :=
  summary.endpoint_public_audit_eq

theorem payloadDataEqComparisonData
    (summary : StructuredEndpointAuditSummary package inputs hypotheses) :
    package.comparisonDataFromPayloadInputs
        (package.obligationsFromStructuredHypotheses inputs hypotheses) =
      summary.sourceAudit.comparisonData :=
  summary.payloadRouteSummary.payload_data_eq_comparison_data

theorem comparisonDataEqPackage
    (summary : StructuredEndpointAuditSummary package inputs hypotheses) :
    summary.sourceAudit.comparisonData =
      package.comparisonData
        (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  summary.payloadRouteSummary.comparison_data_eq_package

theorem comparisonDataRecovers
    (summary : StructuredEndpointAuditSummary package inputs hypotheses) :
    corollary312_from_stage1_comparison
        summary.sourceAudit.comparisonData.stage1Comparison =
      corollary312_of_signed_le
        summary.sourceAudit.comparisonData.qSigned_le_thetaSigned :=
  summary.payloadRouteSummary.comparison_data_recovers

end StructuredEndpointAuditSummary

end IUTStage1SourcePackage

end Stage1
end Iut
