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

/-- Default inert labels for the current non-toy Stage 1 source placeholder. -/
def theorem311ToCorollary312Labels : IUTStage1SourceLabels :=
  { input := { label := "IUT III Theorem 3.11 situation" },
    multiradialOutput := { label := "Theorem 3.11 multiradial output" },
    logVolumeComparison := { label := "Corollary 3.12 log-volume comparison" },
    thetaPilot := { label := "Theta-pilot object" },
    qPilot := { label := "q-pilot object" },
    logKummer := { label := "1-column log-Kummer correspondence" },
    indeterminacies := { label := "Ind1-Ind2-Ind3 profile" } }

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

theorem hodgeTheaterSHEAlignment
    (subclaims : IUTStage1Theorem311Subclaims package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  subclaims.hodge_theater_she_alignment

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

theorem hodgeTheaterSHEAlignment
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  inputs.theorem311_subclaims.hodgeTheaterSHEAlignment

theorem algorithmOutputCertified_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    inputs.algorithmOutputCertified =
      inputs.theorem311Subclaims.algorithmOutputCertified :=
  rfl

theorem hodgeTheaterSHEAlignment_eq_subclaims
    (inputs : IUTStage1Theorem311StructuredInputs package) :
    inputs.hodgeTheaterSHEAlignment =
      inputs.theorem311Subclaims.hodgeTheaterSHEAlignment :=
  rfl

end IUTStage1Theorem311StructuredInputs

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

def toSourceObligations
    (gap : IUTStage1SourceObligationGap package) :
    IUTStage1SourceObligations package :=
  { algorithm_certified := gap.theorem311AlgorithmCertified,
    she_arrow_matches_certificate := gap.sheAlignment,
    q_pilot_positive := gap.qPilotPositive,
    normalization := gap.sourceNormalization }

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

def toSourceObligations
    (gapAudit : Audit gap) :
    IUTStage1SourceObligations package :=
  { algorithm_certified := gapAudit.theorem311AlgorithmCertified,
    she_arrow_matches_certificate := gapAudit.sheAlignment,
    q_pilot_positive := gapAudit.qPilotPositive,
    normalization := gapAudit.sourceNormalization }

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

end IUTStage1SourcePackage

end Stage1
end Iut
