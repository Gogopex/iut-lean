/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Stage1.IUTStage1Data

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

end IUTStage1Theorem311StructuredInputsWithSHE

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
