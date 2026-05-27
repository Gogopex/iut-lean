/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Stage1.IUTStage1Source
import Iut.Stage1.IUTStage1DataExample

/-!
Regression examples for the source-facing Stage 1 package.

These examples route the existing toy pre-ledger data through the non-toy
source-facing API. They do not assert that the toy data is genuine IUT data; the
purpose is only to verify that the source-facing package remains usable once
explicit source obligations are supplied.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

def unitThetaToyIUTStage1SourceLabels : IUTStage1SourceLabels :=
  { theorem311ToCorollary312Labels with
    input := unitThetaToyStage1Input,
    multiradialOutput := unitThetaToyMultiradialOutput,
    logVolumeComparison := unitThetaToyLogVolumeComparison }

def unitThetaToyIUTStage1SourcePackage
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourcePackage qLine thetaLine index :=
  { labels := unitThetaToyIUTStage1SourceLabels,
    preLedger := unitThetaToyPreLedgerData measure hnormalized hh hbound hholds,
    input_eq := rfl,
    multiradialOutput_eq := rfl,
    logVolumeComparison_eq := rfl }

theorem unitThetaToy_source_thetaPilot_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      theorem311ToCorollary312Labels.thetaPilot :=
  rfl

theorem unitThetaToy_source_qPilot_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      theorem311ToCorollary312Labels.qPilot :=
  rfl

theorem unitThetaToy_source_logKummer_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).logKummer =
      theorem311ToCorollary312Labels.logKummer :=
  rfl

theorem unitThetaToy_source_indeterminacies_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).indeterminacies =
      theorem311ToCorollary312Labels.indeterminacies :=
  rfl

theorem unitThetaToy_source_qPilotLogVolume_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilotLogVolume =
      theorem311ToCorollary312Labels.qPilotLogVolume :=
  rfl

theorem unitThetaToy_source_sourceNormalization_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).sourceNormalizationLabel =
      theorem311ToCorollary312Labels.sourceNormalization :=
  rfl

def unitThetaToyIUTStage1SourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  let obligations :=
    unitThetaToyPromotionObligations measure hnormalized hh hbound hholds
  { algorithm_certified := obligations.certified,
    she_arrow_matches_certificate := obligations.she_matches_certificate,
    q_pilot_positive := obligations.q_positive,
    normalization := obligations.normalization_proof }

def unitThetaToyIUTStage1SourceObligationGap
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligationGap
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  let obligations :=
    unitThetaToyPromotionObligations measure hnormalized hh hbound hholds
  { theorem311_algorithm_certified := obligations.certified,
    she_alignment := obligations.she_matches_certificate,
    q_pilot_positive := obligations.q_positive,
    source_normalization := obligations.normalization_proof }

theorem unitThetaToy_source_gap_to_obligations_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourceObligationGap
      measure hnormalized hh hbound hholds).toSourceObligations =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds :=
  rfl

theorem unitThetaToy_source_gap_algorithm_certified_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).theorem311AlgorithmCertified

theorem unitThetaToy_source_gap_she_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sheAlignment

theorem unitThetaToy_source_theorem311_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).theorem311Subclaims

theorem unitThetaToy_source_theorem311_algorithmic_output_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311AlgorithmicOutput
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).algorithmicOutput

theorem unitThetaToy_source_theorem311_algorithmic_output_component_certified_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToy_source_theorem311_algorithmic_output_component_example
    measure hnormalized hh hbound hholds).algorithmOutputCertified

theorem unitThetaToy_source_theorem311_algorithmic_output_certified_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    subclaims.algorithmicOutput.algorithmOutputCertified =
      subclaims.algorithmOutputCertified :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).algorithmicOutput_certified_eq

theorem unitThetaToy_source_theorem311_subclaims_from_algorithmic_output_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_subclaims_from_algorithmic_output_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let algorithmicOutput :=
      unitThetaToy_source_theorem311_algorithmic_output_component_example
        measure hnormalized hh hbound hholds
    (IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment
      algorithmicOutput
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment).algorithmicOutput =
      algorithmicOutput :=
  IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment_algorithmicOutput_eq
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_she_alignment_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311SHEAlignment
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).sheAlignment

theorem unitThetaToy_source_theorem311_she_alignment_component_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_theorem311_she_alignment_component_example
    measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_she_alignment_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    subclaims.sheAlignment.hodgeTheaterSHEAlignment =
      subclaims.hodgeTheaterSHEAlignment :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).sheAlignment_hodgeTheaterSHEAlignment_eq

theorem unitThetaToy_source_theorem311_subclaims_from_components_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1Theorem311Subclaims.ofComponents
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_she_alignment_component_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_subclaims_from_components_algorithmic_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let algorithmicOutput :=
      unitThetaToy_source_theorem311_algorithmic_output_component_example
        measure hnormalized hh hbound hholds
    let sheAlignment :=
      unitThetaToy_source_theorem311_she_alignment_component_example
        measure hnormalized hh hbound hholds
    (IUTStage1Theorem311Subclaims.ofComponents
      algorithmicOutput sheAlignment).algorithmicOutput =
      algorithmicOutput :=
  IUTStage1Theorem311Subclaims.ofComponents_algorithmicOutput_eq
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_she_alignment_component_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_subclaims_from_components_she_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let algorithmicOutput :=
      unitThetaToy_source_theorem311_algorithmic_output_component_example
        measure hnormalized hh hbound hholds
    let sheAlignment :=
      unitThetaToy_source_theorem311_she_alignment_component_example
        measure hnormalized hh hbound hholds
    (IUTStage1Theorem311Subclaims.ofComponents
      algorithmicOutput sheAlignment).sheAlignment =
      sheAlignment :=
  IUTStage1Theorem311Subclaims.ofComponents_sheAlignment_eq
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_she_alignment_component_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_algorithm_output_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).algorithmOutputCertified

theorem unitThetaToy_source_theorem311_she_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311StructuredInputs
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).theorem311StructuredInputs

theorem unitThetaToy_source_theorem311_structured_hasIPL_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredIPL package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hasStructuredIPL

theorem unitThetaToy_source_theorem311_structured_hasSHE_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hasStructuredSHE

theorem unitThetaToy_source_theorem311_structured_hasAPT_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredAPT package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hasStructuredAPT

theorem unitThetaToy_source_theorem311_structured_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds).theorem311Subclaims =
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds :=
  IUTStage1SourceObligationGap.theorem311StructuredInputs_subclaims
    (unitThetaToyIUTStage1SourceObligationGap
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_structured_algorithm_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.algorithmOutputCertified =
      inputs.theorem311Subclaims.algorithmOutputCertified :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).algorithmOutputCertified_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_algorithmic_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311AlgorithmicOutput
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).algorithmicOutput

theorem unitThetaToy_source_theorem311_structured_algorithmic_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.algorithmicOutput =
      inputs.theorem311Subclaims.algorithmicOutput :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).algorithmicOutput_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_she_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.hodgeTheaterSHEAlignment =
      inputs.theorem311Subclaims.hodgeTheaterSHEAlignment :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_she_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311SHEAlignment
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).sheAlignment

theorem unitThetaToy_source_theorem311_structured_she_component_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.sheAlignment =
      inputs.theorem311Subclaims.sheAlignment :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).sheAlignment_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_components_rebuild_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311Subclaims.ofComponents
      inputs.algorithmicOutput inputs.sheAlignment =
      inputs.theorem311Subclaims :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).components_rebuild_subclaims

theorem unitThetaToy_source_gap_qPilot_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).qPilotPositive

theorem unitThetaToy_source_gap_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sourceNormalization

theorem unitThetaToy_source_side_conditions_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditions
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sideConditions

theorem unitThetaToy_source_side_conditions_qPilot_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_side_conditions_example
    measure hnormalized hh hbound hholds).qPilotPositive

theorem unitThetaToy_source_side_conditions_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_side_conditions_example
    measure hnormalized hh hbound hholds).sourceNormalization

theorem unitThetaToy_source_side_condition_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sideConditionHypotheses

theorem unitThetaToy_source_side_condition_hypotheses_qPilot_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_side_condition_hypotheses_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_side_condition_hypotheses_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_side_condition_hypotheses_example
    measure hnormalized hh hbound hholds).sourceNormalized

theorem unitThetaToy_source_side_condition_hypotheses_to_side_conditions_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds).toSideConditions =
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds :=
  IUTStage1SourceSideConditionHypotheses.toSideConditions_ofSideConditions
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_side_condition_hypotheses_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses.Audit
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_side_condition_hypotheses_example
    measure hnormalized hh hbound hholds).audit

theorem unitThetaToy_source_side_condition_hypotheses_audit_q_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilotLogVolume =
      unitThetaToyIUTStage1SourceLabels.qPilotLogVolume :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumeMatchesLabels

theorem unitThetaToy_source_side_condition_hypotheses_audit_normalization_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).sourceNormalizationLabel =
      unitThetaToyIUTStage1SourceLabels.sourceNormalization :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).sourceNormalizationMatchesLabels

theorem unitThetaToy_source_side_condition_hypotheses_audit_q_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_side_condition_hypotheses_audit_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).sourceNormalized

theorem unitThetaToy_source_obligations_from_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofSubclaimsAndSideConditions
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofSubclaimsAndSideConditions
        (unitThetaToy_source_theorem311_subclaims_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_conditions_example
          measure hnormalized hh hbound hholds) =
        (unitThetaToyIUTStage1SourceObligationGap
          measure hnormalized hh hbound hholds).toSourceObligations :=
      (IUTStage1SourceObligationGap.toSourceObligations_eq_subclaimsAndSideConditions
          (unitThetaToyIUTStage1SourceObligationGap
            measure hnormalized hh hbound hholds)).symm
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_gap_to_obligations_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_conditions_example
          measure hnormalized hh hbound hholds) =
        IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_structured_inputs_example
            measure hnormalized hh hbound hholds).theorem311Subclaims
          (unitThetaToy_source_side_conditions_example
            measure hnormalized hh hbound hholds) :=
      IUTStage1SourceObligations.ofStructuredInputsAndSideConditions_eq_subclaims
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_conditions_example
          measure hnormalized hh hbound hholds)
    _ = IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_conditions_example
            measure hnormalized hh hbound hholds) := by
      rw [unitThetaToy_source_theorem311_structured_subclaims_example]
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_obligations_from_parts_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
        (unitThetaToy_source_theorem311_subclaims_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_condition_hypotheses_example
          measure hnormalized hh hbound hholds) =
        IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          ((unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds).toSideConditions) :=
      IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses_eq_sideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds)
    _ = IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_conditions_example
            measure hnormalized hh hbound hholds) := by
      rw [unitThetaToy_source_side_condition_hypotheses_to_side_conditions_example]
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_obligations_from_parts_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_structured_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_condition_hypotheses_example
          measure hnormalized hh hbound hholds) =
        IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
          (unitThetaToy_source_theorem311_structured_inputs_example
            measure hnormalized hh hbound hholds).theorem311Subclaims
          (unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds) :=
      IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses_eq_subclaims
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_condition_hypotheses_example
          measure hnormalized hh hbound hholds)
    _ = IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds) := by
      rw [unitThetaToy_source_theorem311_structured_subclaims_example]
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_obligations_from_hypotheses_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromHypotheses subclaims hypotheses =
      package.obligationsFromParts subclaims hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromHypotheses_eq_parts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_package_obligations_from_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredInputs inputs sideConditions =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds :=
  unitThetaToy_source_obligations_from_structured_inputs_example
    measure hnormalized hh hbound hholds

theorem unitThetaToy_source_package_obligations_from_structured_inputs_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredInputs inputs sideConditions =
      package.obligationsFromParts
        inputs.theorem311Subclaims sideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromStructuredInputs_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_package_obligations_from_structured_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds :=
  unitThetaToy_source_obligations_from_structured_hypotheses_example
    measure hnormalized hh hbound hholds

theorem unitThetaToy_source_package_obligations_from_structured_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      package.obligationsFromStructuredInputs
        inputs hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromStructuredHypotheses_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_package_obligations_from_structured_hypotheses_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      package.obligationsFromHypotheses
        inputs.theorem311Subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromStructuredHypotheses_eq_hypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_gap_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligationGap.Audit
      (unitThetaToyIUTStage1SourceObligationGap
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).audit

theorem unitThetaToy_source_gap_audit_algorithm_certified_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).theorem311AlgorithmCertified

theorem unitThetaToy_source_gap_audit_she_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).sheAlignment

theorem unitThetaToy_source_gap_audit_theorem311_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).theorem311Subclaims

theorem unitThetaToy_source_gap_audit_theorem311_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311StructuredInputs
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).theorem311StructuredInputs

theorem unitThetaToy_source_gap_audit_theorem311_structured_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_gap_audit_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds).theorem311Subclaims =
      unitThetaToy_source_gap_audit_theorem311_subclaims_example
        measure hnormalized hh hbound hholds :=
  IUTStage1SourceObligationGap.Audit.theorem311StructuredInputs_subclaims
    (unitThetaToy_source_gap_audit_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_gap_audit_qPilot_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).qPilotPositive

theorem unitThetaToy_source_gap_audit_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).sourceNormalization

theorem unitThetaToy_source_gap_audit_side_conditions_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditions
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).sideConditions

theorem unitThetaToy_source_gap_audit_obligations_from_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofSubclaimsAndSideConditions
      (unitThetaToy_source_gap_audit_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_gap_audit_side_conditions_example
        measure hnormalized hh hbound hholds) =
      (unitThetaToy_source_gap_audit_example
        measure hnormalized hh hbound hholds).toSourceObligations :=
  (IUTStage1SourceObligationGap.Audit.toSourceObligations_eq_subclaimsAndSideConditions
      (unitThetaToy_source_gap_audit_example
        measure hnormalized hh hbound hholds)).symm

theorem unitThetaToy_source_gap_audit_to_obligations_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_gap_audit_example
      measure hnormalized hh hbound hholds).toSourceObligations =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    (unitThetaToy_source_gap_audit_example
        measure hnormalized hh hbound hholds).toSourceObligations =
        (unitThetaToyIUTStage1SourceObligationGap
          measure hnormalized hh hbound hholds).toSourceObligations :=
      IUTStage1SourceObligationGap.Audit.toSourceObligations_eq_gap
        (unitThetaToy_source_gap_audit_example
          measure hnormalized hh hbound hholds)
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_gap_to_obligations_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_publicAudit_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAudit_qSigned_le_thetaSigned
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAudit_corollary312
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_parts_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfParts_qSigned_le_thetaSigned
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_parts_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfParts_corollary312
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_hypotheses_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfHypotheses_qSigned_le_thetaSigned
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_hypotheses_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfHypotheses_corollary312
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfHypotheses subclaims hypotheses =
      package.publicAuditOfParts subclaims hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfHypotheses_eq_parts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_inputs_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  IUTStage1SourcePackage.publicAuditOfStructuredInputs_qSigned_le_thetaSigned
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_inputs_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  IUTStage1SourcePackage.publicAuditOfStructuredInputs_corollary312
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_inputs_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfStructuredInputs inputs sideConditions =
      package.publicAuditOfParts
        inputs.theorem311Subclaims sideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfStructuredInputs_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_qSigned_le_thetaSigned
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_corollary312
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfStructuredHypotheses inputs hypotheses =
      package.publicAuditOfStructuredInputs
        inputs hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfStructuredHypotheses_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfStructuredHypotheses inputs hypotheses =
      package.publicAuditOfHypotheses
        inputs.theorem311Subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfStructuredHypotheses_eq_hypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_parts_recovery_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    corollary312_from_stage1_comparison
        (package.promotedProvider
          (package.obligationsFromParts
            subclaims sideConditions)).stage1Comparison =
      corollary312_of_signed_le
        (package.promotedProvider
          (package.obligationsFromParts
            subclaims sideConditions)).ledger.qSigned_le_thetaSigned :=
  IUTStage1SourcePackage.publicAuditOfParts_stage1Comparison_recovers_qSigned_le_thetaSigned
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_stage_recovers_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).stage1Comparison =
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).ledger.corollary312 :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).stage1Comparison_recovers_corollary312
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourcePackage.Audit
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).audit
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromParts subclaims sideConditions) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfParts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromHypotheses subclaims hypotheses) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfHypotheses
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromStructuredInputs inputs sideConditions) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredInputs
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredHypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hypothesis_route_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.HypothesisRouteAudit
      package subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).hypothesisRouteAudit
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.StructuredHypothesisRouteAudit
      package inputs hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).structuredHypothesisRouteAudit
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_side_condition_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses.Audit
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sideConditionAudit

theorem unitThetaToy_source_structured_hypothesis_route_source_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sourceAudit

theorem unitThetaToy_source_hypothesis_route_side_condition_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses.Audit
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sideConditionAudit

theorem unitThetaToy_source_hypothesis_route_source_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromHypotheses subclaims hypotheses) :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sourceAudit

theorem unitThetaToy_source_hypothesis_route_side_condition_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.hypothesisRouteAudit subclaims hypotheses).sideConditionAudit =
      package.sideConditionAuditOfHypotheses hypotheses :=
  IUTStage1SourcePackage.hypothesisRouteAudit_sideConditionAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hypothesis_route_source_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.hypothesisRouteAudit subclaims hypotheses).sourceAudit =
      package.auditOfHypotheses subclaims hypotheses :=
  IUTStage1SourcePackage.hypothesisRouteAudit_sourceAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_side_condition_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredHypothesisRouteAudit
      inputs hypotheses).sideConditionAudit =
      package.sideConditionAuditOfHypotheses hypotheses :=
  IUTStage1SourcePackage.structuredHypothesisRouteAudit_sideConditionAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_source_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit =
      package.auditOfStructuredHypotheses inputs hypotheses :=
  IUTStage1SourcePackage.structuredHypothesisRouteAudit_sourceAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_source_audit_eq_hypothesis_route_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit =
      (package.hypothesisRouteAudit
        inputs.theorem311Subclaims hypotheses).sourceAudit :=
  IUTStage1SourcePackage.structuredHypothesisRouteAudit_sourceAudit_eq_hypothesisRoute
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hypothesis_route_q_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_structured_hypothesis_route_q_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_hypothesis_route_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_structured_hypothesis_route_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_hypotheses_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_structured_inputs_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_structured_inputs_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_structured_hypotheses_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_structured_hypotheses_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditOfHypotheses subclaims hypotheses =
      package.auditOfParts subclaims hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfHypotheses_eq_parts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_inputs_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.auditOfStructuredInputs inputs sideConditions =
      package.auditOfParts
        inputs.theorem311Subclaims sideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredInputs_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditOfStructuredHypotheses inputs hypotheses =
      package.auditOfStructuredInputs inputs hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredHypotheses_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_hypotheses_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditOfStructuredHypotheses inputs hypotheses =
      package.auditOfHypotheses inputs.theorem311Subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredHypotheses_eq_hypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_hypotheses_corollary_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_audit_from_hypotheses_recovery_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    corollary312_from_stage1_comparison
        (package.promotedProvider
          (package.obligationsFromHypotheses
            subclaims hypotheses)).stage1Comparison =
      (package.promotedProvider
        (package.obligationsFromHypotheses
          subclaims hypotheses)).ledger.corollary312 :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).stageRecoversCorollary312

theorem unitThetaToy_source_audit_from_hypotheses_thetaPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      unitThetaToyIUTStage1SourceLabels.thetaPilot :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).thetaPilotMatchesLabels

theorem unitThetaToy_source_audit_from_hypotheses_qPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      unitThetaToyIUTStage1SourceLabels.qPilot :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).qPilotMatchesLabels

theorem unitThetaToy_source_audit_from_parts_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_parts_corollary_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_audit_from_parts_recovery_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    corollary312_from_stage1_comparison
        (package.promotedProvider
          (package.obligationsFromParts
            subclaims sideConditions)).stage1Comparison =
      (package.promotedProvider
        (package.obligationsFromParts
          subclaims sideConditions)).ledger.corollary312 :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).stageRecoversCorollary312

theorem unitThetaToy_source_audit_from_parts_thetaPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      unitThetaToyIUTStage1SourceLabels.thetaPilot :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).thetaPilotMatchesLabels

theorem unitThetaToy_source_audit_from_parts_qPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      unitThetaToyIUTStage1SourceLabels.qPilot :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).qPilotMatchesLabels

theorem unitThetaToy_source_audit_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_corollary_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_audit_recovery_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).stage1Comparison =
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).ledger.corollary312 :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).stageRecoversCorollary312

theorem unitThetaToy_source_audit_thetaPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      unitThetaToyIUTStage1SourceLabels.thetaPilot :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).thetaPilotMatchesLabels

theorem unitThetaToy_source_audit_qPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      unitThetaToyIUTStage1SourceLabels.qPilot :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).qPilotMatchesLabels

theorem unitThetaToy_source_audit_logKummer_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).logKummer =
      unitThetaToyIUTStage1SourceLabels.logKummer :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).logKummerMatchesLabels

theorem unitThetaToy_source_audit_indeterminacies_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).indeterminacies =
      unitThetaToyIUTStage1SourceLabels.indeterminacies :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).indeterminaciesMatchesLabels

theorem unitThetaToy_source_audit_qPilotLogVolume_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilotLogVolume =
      unitThetaToyIUTStage1SourceLabels.qPilotLogVolume :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumeMatchesLabels

theorem unitThetaToy_source_audit_sourceNormalization_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).sourceNormalizationLabel =
      unitThetaToyIUTStage1SourceLabels.sourceNormalization :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).sourceNormalizationMatchesLabels

theorem unitThetaToy_source_audit_publicAudit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (⟨(unitThetaToy_source_audit_example
          measure hnormalized hh hbound hholds).qSignedLeThetaSigned,
        (unitThetaToy_source_audit_example
          measure hnormalized hh hbound hholds).corollary312Endpoint,
        (unitThetaToy_source_audit_example
          measure hnormalized hh hbound hholds).stageRecoversQSignedLeThetaSigned⟩ :
      (Transport.map unitQToTheta (qAssignment h)).coord <=
          -(2 * h) + epsilonBound ∧
        Corollary312Inequality
          (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
          (signedPilotLogVolume PilotSide.q
            (Transport.map unitQToTheta (qAssignment h)).coord) ∧
        (corollary312_from_stage1_comparison
            ((unitThetaToyIUTStage1SourcePackage
              measure hnormalized hh hbound hholds).promotedProvider
                (unitThetaToyIUTStage1SourceObligations
                  measure hnormalized hh hbound hholds)).stage1Comparison =
          corollary312_of_signed_le
            ((unitThetaToyIUTStage1SourcePackage
              measure hnormalized hh hbound hholds).promotedProvider
                (unitThetaToyIUTStage1SourceObligations
                  measure hnormalized hh hbound hholds)).ledger.qSigned_le_thetaSigned)) =
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).publicAudit
        (unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).publicAuditEq

theorem unitThetaToy_source_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    ∃ sourceAudit : IUTStage1SourcePackage.Audit
        (unitThetaToyIUTStage1SourcePackage
          measure hnormalized hh hbound hholds)
        (unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds),
      (⟨sourceAudit.qSignedLeThetaSigned,
          sourceAudit.corollary312Endpoint,
          sourceAudit.stageRecoversQSignedLeThetaSigned⟩ :
        (Transport.map unitQToTheta (qAssignment h)).coord <=
            -(2 * h) + epsilonBound ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
            (signedPilotLogVolume PilotSide.q
              (Transport.map unitQToTheta (qAssignment h)).coord) ∧
          (corollary312_from_stage1_comparison
              ((unitThetaToyIUTStage1SourcePackage
                measure hnormalized hh hbound hholds).promotedProvider
                  (unitThetaToyIUTStage1SourceObligations
                    measure hnormalized hh hbound hholds)).stage1Comparison =
            corollary312_of_signed_le
              ((unitThetaToyIUTStage1SourcePackage
                measure hnormalized hh hbound hholds).promotedProvider
                  (unitThetaToyIUTStage1SourceObligations
                    measure hnormalized hh hbound hholds)).ledger.qSigned_le_thetaSigned)) =
        (unitThetaToyIUTStage1SourcePackage
          measure hnormalized hh hbound hholds).publicAudit
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditedPublicEndpoint
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_gap_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let gap :=
      unitThetaToyIUTStage1SourceObligationGap
        measure hnormalized hh hbound hholds
    ∃ sourceAudit : IUTStage1SourcePackage.Audit package gap.toSourceObligations,
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
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let gap :=
    unitThetaToyIUTStage1SourceObligationGap
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfGap gap

theorem unitThetaToy_source_hypotheses_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromHypotheses subclaims hypotheses),
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
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let subclaims :=
    unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfHypotheses subclaims hypotheses

theorem unitThetaToy_source_structured_inputs_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
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
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let sideConditions :=
    unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfStructuredInputs inputs sideConditions

theorem unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
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
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfStructuredHypotheses inputs hypotheses

theorem unitThetaToy_source_structured_route_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
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
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).auditedPublicEndpoint

theorem unitThetaToy_source_hypotheses_auditedPublicEndpoint_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfHypotheses subclaims hypotheses =
      package.auditedPublicEndpointOfParts
        subclaims hypotheses.toSideConditions :=
  IUTStage1SourcePackage.auditedPublicEndpointOfHypotheses_eq_parts
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_inputs_auditedPublicEndpoint_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfStructuredInputs
        inputs sideConditions =
      package.auditedPublicEndpointOfParts
        inputs.theorem311Subclaims sideConditions :=
  IUTStage1SourcePackage.auditedPublicEndpointOfStructuredInputs_eq_parts
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedPublicEndpointOfStructuredInputs
        inputs hypotheses.toSideConditions :=
  IUTStage1SourcePackage.auditedPublicEndpointOfStructuredHypotheses_eq_parts
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedPublicEndpointOfHypotheses
        inputs.theorem311Subclaims hypotheses :=
  IUTStage1SourcePackage.auditedPublicEndpointOfStructuredHypotheses_eq_hypotheses
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

end ToyModel
end Stage1
end Iut
