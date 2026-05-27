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
  hdd : output.HDDCompositeData measure thetaSigned
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
    ledger.hdd.structuredBridge ledger.certificate ledger.choice
    ledger.q_le_choice

def stage1Comparison (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    Stage1Comparison :=
  stage1Comparison_from_structured_bridge
    ledger.hdd.structuredBridge ledger.certificate ledger.choice
    ledger.q_positive ledger.q_le_choice

theorem hasNormalization (ledger :
    SourceObligationLedger output measure thetaSigned qSigned normalization) :
    normalization :=
  ledger.normalization_proof

end SourceObligationLedger

end Stage1
end Iut
