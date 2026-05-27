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
  choice : index
  q_le_choice :
    qSigned <= RegionMeasure.targetVolume measure (output.comparison choice)
  q_positive : 0 < -qSigned
  normalization_proof : normalization

namespace SourceObligationLedger

variable {source target : Copy} {index : Type u}
variable {output : AlgorithmicOutput source target index}
variable {measure : RegionMeasure target}
variable {thetaSigned qSigned : Real}
variable {normalization : Prop}

theorem corollary312 (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta thetaSigned)
      (signedPilotLogVolume PilotSide.q qSigned) :=
  corollary312_from_structured_bridge
    ledger.chartedContainer.structuredBridge ledger.certificate ledger.choice
    ledger.q_le_choice

def stage1Comparison (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    Stage1Comparison :=
  stage1Comparison_from_structured_bridge
    ledger.chartedContainer.structuredBridge ledger.certificate ledger.choice
    ledger.q_positive ledger.q_le_choice

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
