/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Stage1.CorollarySchema

/-!
Ledger of source obligations for the Stage 1 final comparison.

This file packages the hypotheses that future IUT-specific work must supply
before the signed Corollary 3.12 schema can be applied.
-/

namespace Iut
namespace Stage1

open RealLineCopy

/-- A named three-term real comparison `q <= target <= theta`. -/
structure ThreeTermComparison (qSigned targetSigned thetaSigned : Real) where
  q_le_target : qSigned <= targetSigned
  target_le_theta : targetSigned <= thetaSigned

namespace ThreeTermComparison

variable {qSigned targetSigned thetaSigned : Real}

theorem q_le_theta
    (chain : ThreeTermComparison qSigned targetSigned thetaSigned) :
    qSigned <= thetaSigned :=
  le_trans chain.q_le_target chain.target_le_theta

end ThreeTermComparison

/--
Completed source obligations for a structured Stage 1 comparison.

The `normalization` field is intentionally an arbitrary proposition: different
future source-specific constructions may have different normalization statements.
The final inequality does not use this field directly, but the ledger records
that the normalization/comparability obligation has been discharged.
-/
structure SourceObligationLedger
    {source target : Copy} {index : Type u}
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (thetaSigned qSigned : Real)
    (normalization : Prop) where
  certificate : QualitativeData.StructuredCertificate output.family
  chartedContainer : output.ChartedCommonContainerData measure thetaSigned
  she_matches_certificate :
    chartedContainer.commonContainer.hddShe.sheArrow.datum = certificate.she
  qValue : output.ChartedQValueData measure chartedContainer.chart qSigned
  thetaBound :
    output.ChartedThetaBoundData measure chartedContainer.chart thetaSigned
  theta_commonBound :
    output.CommonTargetBound measure thetaSigned
  chosenOutput : output.ChosenOutputData
  targetVolume :
    output.ChartedTargetVolumeData measure chartedContainer.chart chosenOutput.choice
  membership :
    output.ChartedMembershipData measure chartedContainer.chart
      qValue chosenOutput targetVolume
  q_positive : 0 < -qSigned
  normalization_proof : normalization

namespace SourceObligationLedger

variable {source target : Copy} {index : Type u}
variable {output : AlgorithmicOutput source target index}
variable {measure : RegionMeasure target}
variable {thetaSigned qSigned : Real}
variable {normalization : Prop}

def threeTermComparison (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ThreeTermComparison qSigned ledger.targetVolume.targetSigned thetaSigned :=
  { q_le_target := ledger.membership.q_le_target,
    target_le_theta := by
      rw [ledger.targetVolume.targetSigned_eq]
      exact TransportedRegionFamily.choice_targetVolume_le_of_commonBound
        ledger.theta_commonBound ledger.chosenOutput.choice }

theorem threeTerm_q_le_target_eq_membership (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.threeTermComparison.q_le_target =
      ledger.membership.q_le_target :=
  rfl

theorem threeTerm_target_le_theta_eq_commonBound (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.threeTermComparison.target_le_theta =
      (by
        rw [ledger.targetVolume.targetSigned_eq]
        exact TransportedRegionFamily.choice_targetVolume_le_of_commonBound
          ledger.theta_commonBound ledger.chosenOutput.choice) :=
  rfl

theorem chosenComparisonHoldsQ (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.chosenOutput.comparison.Holds ledger.qValue.qPoint :=
  ledger.membership.holds

theorem qSigned_le_targetSigned (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    qSigned <= ledger.targetVolume.targetSigned :=
  ledger.membership.q_le_target

theorem targetSigned_eq_choiceTargetVolume (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.targetVolume.targetSigned =
      RegionMeasure.targetVolume measure
        (output.comparison ledger.chosenOutput.choice) :=
  ledger.targetVolume.targetSigned_eq

theorem targetSigned_le_thetaSigned (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.targetVolume.targetSigned <= thetaSigned := by
  exact ledger.threeTermComparison.target_le_theta

theorem chosenComparison_eq_outputComparison (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.chosenOutput.comparison =
      output.comparison ledger.chosenOutput.choice :=
  ledger.chosenOutput.comparison_eq

theorem targetSigned_eq_chosenComparisonVolume (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.targetVolume.targetSigned =
      RegionMeasure.targetVolume measure ledger.chosenOutput.comparison := by
  rw [ledger.chosenOutput.comparison_eq]
  exact ledger.targetVolume.targetSigned_eq

theorem qSigned_le_thetaSigned (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    qSigned <= thetaSigned :=
  ledger.threeTermComparison.q_le_theta

theorem qSigned_le_thetaSigned_eq_threeTerm (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.qSigned_le_thetaSigned =
      ledger.threeTermComparison.q_le_theta :=
  rfl

theorem corollary312 (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta thetaSigned)
      (signedPilotLogVolume PilotSide.q qSigned) :=
  corollary312_of_signed_le ledger.qSigned_le_thetaSigned

theorem corollary312_eq_threeTermComparison (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.corollary312 =
      corollary312_of_signed_le ledger.threeTermComparison.q_le_theta :=
  rfl

def stage1Comparison (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    Stage1Comparison :=
  stage1Comparison_of_signed_le ledger.q_positive ledger.qSigned_le_thetaSigned

theorem stage1Comparison_q_positive_eq_ledger (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.stage1Comparison.q_positive = ledger.q_positive :=
  rfl

theorem stage1Comparison_comparison_eq_corollary312 (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.stage1Comparison.comparison = ledger.corollary312 :=
  rfl

theorem stage1Comparison_comparison_eq_threeTermComparison (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.stage1Comparison.comparison =
      corollary312_of_signed_le ledger.threeTermComparison.q_le_theta :=
  rfl

theorem sheMatchesCertificate (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      ledger.certificate.she :=
  ledger.she_matches_certificate

theorem commonContextMatchesCertificate (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    ledger.chartedContainer.commonContainer.context =
      ledger.certificate.she.sharedContext := by
  rw [← ledger.chartedContainer.commonContainer.she_context_matches]
  rw [ledger.she_matches_certificate]

theorem thetaChartTrivial (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    Transport.TrivialMonodromy
      ledger.chartedContainer.chart.thetaToTarget :=
  ledger.chartedContainer.thetaTrivial

theorem qSigned_eq_chartedQ (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    (Transport.map ledger.chartedContainer.chart.qToTarget
      ledger.qValue.qPoint).coord = qSigned :=
  ledger.qValue.qSigned_eq

theorem thetaSigned_eq_chartedTheta (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    (Transport.map ledger.chartedContainer.chart.thetaToTarget
      ledger.thetaBound.thetaPoint).coord = thetaSigned :=
  ledger.thetaBound.thetaSigned_eq

def thetaCommonBound (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    output.CommonTargetBound measure thetaSigned :=
  ledger.theta_commonBound

theorem hasNormalization (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    normalization :=
  ledger.normalization_proof

end SourceObligationLedger

end Stage1
end Iut
