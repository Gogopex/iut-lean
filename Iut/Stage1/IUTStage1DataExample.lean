/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Stage1.IUTStage1Data
import Iut.Stage1.ToySourceObligations

/-!
Regression examples for promoting pre-ledger data to the public Stage 1 API.

The toy model supplies sample data. The examples exercise the controlled
promotion path from `IUTStage1PreLedgerData` to `SourceObligationLedger` and
then to `IUTSourceObligationProvider`.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

def unitThetaToyStage1Input : Stage1InputId :=
  { label := "toy-stage1-input" }

def unitThetaToyMultiradialOutput : MultiradialOutputId :=
  { label := "toy-theta-upper-ray-output" }

def unitThetaToyLogVolumeComparison : LogVolumeComparisonId :=
  { label := "toy-log-volume-comparison" }

def unitThetaToyPreLedgerData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (_hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1PreLedgerData qLine thetaLine index :=
  { input := unitThetaToyStage1Input,
    multiradialOutput := unitThetaToyMultiradialOutput,
    logVolumeComparison := unitThetaToyLogVolumeComparison,
    output := thetaToyAlgorithmOutput unitQToTheta h epsilon,
    measure := measure,
    thetaSigned := -(2 * h) + epsilonBound,
    qSigned := (Transport.map unitQToTheta (qAssignment h)).coord,
    normalization := RegionMeasure.NormalizesUpperRays measure,
    certificate := thetaToyStructuredCertificate unitQToTheta h epsilon,
    chartedContainer :=
      thetaToyChartedCommonContainerData measure hnormalized unitQToTheta h hbound,
    qValue := { qPoint := qAssignment h, qSigned_eq := rfl },
    thetaBound :=
      { thetaPoint := point thetaLine (-(2 * h) + epsilonBound),
        thetaSigned_eq := by
          simp [thetaToyChartedCommonContainerData,
            thetaToyRealComparisonChartData] },
    chosenOutput :=
      { choice := choice,
        comparison := (thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice,
        comparison_eq := rfl },
    targetVolume :=
      { targetSigned :=
          RegionMeasure.targetVolume measure
            ((thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice),
        targetSigned_eq := rfl },
    membership :=
      { holds := by
          simpa [AlgorithmicOutput.Holds, TransportedRegionFamily.Holds]
            using hholds,
        q_le_target :=
          unitThetaToy_qSigned_le_choiceTargetVolume
            measure hnormalized h epsilon choice hholds } }

def unitThetaToyPromotionObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyPreLedgerData
      measure hnormalized hh hbound hholds).LedgerPromotionObligations :=
  { certified := thetaToyAlgorithmOutput_certified unitQToTheta h epsilon,
    she_matches_certificate := rfl,
    q_positive := by
      change 0 < - (Transport.map unitQToTheta (qAssignment h)).coord
      unfold qAssignment unitQToTheta Transport.map point PositiveScale.one
      linarith,
    normalization_proof := hnormalized }

def unitThetaToyComparisonPayloadInputs
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyPreLedgerData
      measure hnormalized hh hbound hholds).ComparisonPayloadInputs :=
  (unitThetaToyPreLedgerData
    measure hnormalized hh hbound hholds).comparisonPayloadInputs

theorem unitThetaToy_comparisonPayloadInputs_thetaChartTrivial_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Transport.TrivialMonodromy
      ((unitThetaToyPreLedgerData
        measure hnormalized hh hbound hholds).chartedContainer.chart.thetaToTarget) :=
  (unitThetaToyComparisonPayloadInputs
    measure hnormalized hh hbound hholds).thetaChartTrivial

theorem unitThetaToy_comparisonPayloadInputs_qCharted_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map
      (unitThetaToyPreLedgerData
        measure hnormalized hh hbound hholds).chartedContainer.chart.qToTarget
      (unitThetaToyPreLedgerData
        measure hnormalized hh hbound hholds).qValue.qPoint).coord =
      (Transport.map unitQToTheta (qAssignment h)).coord :=
  (unitThetaToyComparisonPayloadInputs
    measure hnormalized hh hbound hholds).qCharted

theorem unitThetaToy_comparisonPayloadInputs_chosenHolds_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyPreLedgerData
      measure hnormalized hh hbound hholds).chosenOutput.comparison.Holds
      (unitThetaToyPreLedgerData
        measure hnormalized hh hbound hholds).qValue.qPoint :=
  (unitThetaToyComparisonPayloadInputs
    measure hnormalized hh hbound hholds).chosenHolds

theorem unitThetaToy_comparisonPayloadInputs_q_le_theta_example
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
  (unitThetaToyComparisonPayloadInputs
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_comparisonPayloadInputs_corollary_example
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
  (unitThetaToyComparisonPayloadInputs
    measure hnormalized hh hbound hholds).comparisonData_corollary312
      (unitThetaToyPromotionObligations
        measure hnormalized hh hbound hholds).q_positive

def unitThetaToyPromotedProvider
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTSourceObligationProvider
      (thetaToyAlgorithmOutput unitQToTheta h epsilon)
      measure
      (-(2 * h) + epsilonBound)
      (Transport.map unitQToTheta (qAssignment h)).coord
      (RegionMeasure.NormalizesUpperRays measure) :=
  (unitThetaToyPreLedgerData measure hnormalized hh hbound hholds).toSourceObligationProvider
    (unitThetaToyPromotionObligations measure hnormalized hh hbound hholds)

theorem unitThetaToy_preLedger_promotedProvider_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyPreLedgerData
      measure hnormalized hh hbound hholds).promotedProvider
        (unitThetaToyPromotionObligations measure hnormalized hh hbound hholds) =
      unitThetaToyPromotedProvider measure hnormalized hh hbound hholds :=
  rfl

theorem unitThetaToy_preLedger_promotedProvider_ledger_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    ((unitThetaToyPreLedgerData
      measure hnormalized hh hbound hholds).promotedProvider
        (unitThetaToyPromotionObligations
          measure hnormalized hh hbound hholds)).ledger =
      (unitThetaToyPreLedgerData
        measure hnormalized hh hbound hholds).promotedLedger
          (unitThetaToyPromotionObligations
            measure hnormalized hh hbound hholds) :=
  (unitThetaToyPreLedgerData
    measure hnormalized hh hbound hholds).promotedProvider_ledger
      (unitThetaToyPromotionObligations measure hnormalized hh hbound hholds)

theorem unitThetaToy_promotedProvider_publicAudit_q_le_theta_example
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
  (unitThetaToyPromotedProvider measure hnormalized hh hbound hholds).publicAudit.1

theorem unitThetaToy_preLedger_publicAudit_q_le_theta_example
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
  (unitThetaToyPreLedgerData
    measure hnormalized hh hbound hholds).publicAudit_qSigned_le_thetaSigned
      (unitThetaToyPromotionObligations measure hnormalized hh hbound hholds)

theorem unitThetaToy_promotedProvider_publicAudit_corollary_example
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
  (unitThetaToyPromotedProvider measure hnormalized hh hbound hholds).publicAudit.2.1

theorem unitThetaToy_preLedger_publicAudit_corollary_example
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
  (unitThetaToyPreLedgerData
    measure hnormalized hh hbound hholds).publicAudit_corollary312
      (unitThetaToyPromotionObligations measure hnormalized hh hbound hholds)

theorem unitThetaToy_promotedProvider_recovers_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      (unitThetaToyPromotedProvider
        measure hnormalized hh hbound hholds).stage1Comparison =
      (unitThetaToyPromotedProvider
        measure hnormalized hh hbound hholds).ledger.corollary312 :=
  (unitThetaToyPromotedProvider
    measure hnormalized hh hbound hholds).stage1Comparison_recovers_corollary312

theorem unitThetaToy_preLedger_stage_recovers_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      ((unitThetaToyPreLedgerData measure hnormalized hh hbound hholds).toSourceObligationProvider
        (unitThetaToyPromotionObligations
          measure hnormalized hh hbound hholds)).stage1Comparison =
      ((unitThetaToyPreLedgerData measure hnormalized hh hbound hholds).toSourceObligationProvider
        (unitThetaToyPromotionObligations
          measure hnormalized hh hbound hholds)).ledger.corollary312 :=
  (unitThetaToyPreLedgerData
    measure hnormalized hh hbound hholds).stage1Comparison_recovers_corollary312
      (unitThetaToyPromotionObligations measure hnormalized hh hbound hholds)

theorem unitThetaToy_preLedger_publicAudit_recovery_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      ((unitThetaToyPreLedgerData measure hnormalized hh hbound hholds).toSourceObligationProvider
        (unitThetaToyPromotionObligations
          measure hnormalized hh hbound hholds)).stage1Comparison =
      corollary312_of_signed_le
        ((unitThetaToyPreLedgerData measure hnormalized hh hbound hholds).toSourceObligationProvider
          (unitThetaToyPromotionObligations
            measure hnormalized hh hbound hholds)).ledger.qSigned_le_thetaSigned :=
  IUTStage1PreLedgerData.publicAudit_stage1Comparison_recovers_qSigned_le_thetaSigned
    (unitThetaToyPreLedgerData measure hnormalized hh hbound hholds)
    (unitThetaToyPromotionObligations measure hnormalized hh hbound hholds)

end ToyModel
end Stage1
end Iut
