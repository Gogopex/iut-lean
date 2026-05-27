/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.AlgorithmicOutput
import Iut.Foundations.QualitativeData
import Iut.Stage1.ToyAPTTransport

/-!
Toy qualitative algorithmic output.

The toy output records IPL/SHE/APT as structured but inert data so that the
formal interface can be tested. The numerical bound still requires the explicit
common-target bound data from the previous milestones.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

def thetaToyDomainTheater : QualitativeData.HodgeTheaterId :=
  { side := QualitativeData.HodgeTheaterSide.domain,
    label := "theta-domain" }

def thetaToyCodomainTheater : QualitativeData.HodgeTheaterId :=
  { side := QualitativeData.HodgeTheaterSide.codomain,
    label := "q-codomain" }

def thetaToyInputPrimeStrip (datumLabel : String) : QualitativeData.PrimeStripId :=
  { label := datumLabel }

def thetaToyOutputPrimeStrip : QualitativeData.PrimeStripId :=
  { label := "theta-upper-ray-output" }

def thetaToyPrimeStripLink (datumLabel : String) : QualitativeData.PrimeStripLink :=
  { source := thetaToyInputPrimeStrip datumLabel,
    target := thetaToyOutputPrimeStrip,
    linkLabel := "toy-prime-strip-link" }

def thetaToyDomainStructure : QualitativeData.HolomorphicStructure :=
  { theater := thetaToyDomainTheater,
    structureLabel := "theta-holomorphic-structure" }

def thetaToyCodomainStructure : QualitativeData.HolomorphicStructure :=
  { theater := thetaToyCodomainTheater,
    structureLabel := "q-holomorphic-structure" }

def thetaToySharedHolomorphicContext :
    QualitativeData.SharedHolomorphicContext :=
  { domainStructure := thetaToyDomainStructure,
    codomainStructure := thetaToyCodomainStructure,
    commonLanguage := { label := "toy-common-real-line" } }

def thetaToyIPLD (datumLabel : String) (epsilon : index -> Real)
    (f : Transport qLine thetaLine) (h : Real) :
    QualitativeData.IPLDatum (thetaAPTOutput f h epsilon) :=
  { inputPrimeStrip := thetaToyInputPrimeStrip datumLabel,
    outputPrimeStrip := thetaToyOutputPrimeStrip,
    choicePrimeStrip := fun _ => { label := "epsilon-choice" },
    link := thetaToyPrimeStripLink datumLabel }

def thetaToySHED (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    QualitativeData.SHEDatum (thetaAPTOutput f h epsilon) :=
  { sharedContext := thetaToySharedHolomorphicContext }

def thetaToyStructuredSHEContext (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    QualitativeData.StructuredSHEContext (thetaAPTOutput f h epsilon) :=
  { domainStructure := thetaToyDomainStructure,
    codomainStructure := thetaToyCodomainStructure,
    commonLanguage := thetaToySharedHolomorphicContext.commonLanguage,
    qPilotStructure := thetaToyCodomainStructure,
    thetaPilotStructure := thetaToyDomainStructure,
    q_pilot_in_codomain := rfl,
    theta_pilot_in_domain := rfl,
    simultaneousExpression :=
      { domain_expression_valid := True,
        domain_expression_valid_holds := trivial,
        codomain_expression_valid := True,
        codomain_expression_valid_holds := trivial,
        q_pilot_expression_valid := True,
        q_pilot_expression_valid_holds := trivial,
        theta_pilot_expression_valid := True,
        theta_pilot_expression_valid_holds := trivial,
        simultaneous_valid := True,
        simultaneous_valid_holds := trivial },
    histories_not_identified := by
      intro hside
      cases hside }

theorem thetaToyStructuredSHEContext_sheDatum
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    (thetaToyStructuredSHEContext f h epsilon).sheDatum =
      thetaToySHED f h epsilon :=
  rfl

theorem thetaToyStructuredSHEContext_hasStructuredSHE
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    QualitativeData.HasStructuredSHE (thetaAPTOutput f h epsilon) :=
  (thetaToyStructuredSHEContext f h epsilon).hasStructuredSHE

theorem thetaToyStructuredSHEContext_histories_not_identified
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    (thetaToyStructuredSHEContext f h epsilon).domainStructure.theater.side ≠
      (thetaToyStructuredSHEContext f h epsilon).codomainStructure.theater.side :=
  (thetaToyStructuredSHEContext f h epsilon).domainHistory_ne_codomainHistory

theorem thetaToyStructuredSHEContext_allLocalExpressionValid
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    let context := thetaToyStructuredSHEContext f h epsilon
    context.simultaneousExpression.domain_expression_valid ∧
      context.simultaneousExpression.codomain_expression_valid ∧
      context.simultaneousExpression.q_pilot_expression_valid ∧
      context.simultaneousExpression.theta_pilot_expression_valid ∧
      context.simultaneous_valid :=
  (thetaToyStructuredSHEContext f h epsilon).allLocalExpressionValid_expanded

def thetaToyAPTD (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    QualitativeData.APTDatum (thetaAPTOutput f h epsilon) :=
  { mechanism := { label := "toy-explicit-transport" },
    outputFamily := thetaAPTOutput f h epsilon,
    output_eq_family := rfl }

def thetaToyStructuredCertificate (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    QualitativeData.StructuredCertificate (thetaAPTOutput f h epsilon) :=
  { ipl := thetaToyIPLD "toy-input-link" epsilon f h,
    she := thetaToySHED f h epsilon,
    apt := thetaToyAPTD f h epsilon }

/--
Toy algorithmic output for the Theta upper-ray family.

The qualitative properties are witnessed by inert records in this toy model.
This keeps the test focused on dependency plumbing rather than on pretending to
formalize real IPL, SHE, or APT.
-/
def thetaToyAlgorithmOutput (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) : AlgorithmicOutput qLine thetaLine index :=
  { family := thetaAPTOutput f h epsilon,
    ipl := QualitativeData.HasStructuredIPL (thetaAPTOutput f h epsilon),
    she := QualitativeData.HasStructuredSHE (thetaAPTOutput f h epsilon),
    apt := QualitativeData.HasStructuredAPT (thetaAPTOutput f h epsilon) }

theorem thetaToyAlgorithmOutput_certified
    (f : Transport qLine thetaLine) (h : Real) (epsilon : index -> Real) :
    (thetaToyAlgorithmOutput f h epsilon).Certified :=
  { ipl := (thetaToyStructuredCertificate f h epsilon).hasStructuredIPL,
    she := (thetaToyStructuredCertificate f h epsilon).hasStructuredSHE,
    apt := (thetaToyStructuredCertificate f h epsilon).hasStructuredAPT }

theorem thetaToyAlgorithmOutput_has_structured_apt
    (f : Transport qLine thetaLine) (h : Real) (epsilon : index -> Real) :
    QualitativeData.HasStructuredAPT (thetaAPTOutput f h epsilon) :=
  (thetaToyAlgorithmOutput_certified f h epsilon).apt

@[simp]
theorem thetaToyAlgorithmOutput_comparison
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) (choice : index) :
    (thetaToyAlgorithmOutput f h epsilon).comparison choice =
      thetaIndeterminacyComparison f h (epsilon choice) :=
  rfl

@[simp]
theorem thetaToyAlgorithmOutput_comparisons
    (f : Transport qLine thetaLine) (h : Real) (epsilon : index -> Real) :
    (thetaToyAlgorithmOutput f h epsilon).comparisons =
      thetaIndeterminacyFamily f h epsilon :=
  rfl

def thetaToyCertifiedCommonTargetBound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).CertifiedCommonTargetBound
      measure (-(2 * h) + epsilonBound) :=
  { certified := thetaToyAlgorithmOutput_certified f h epsilon,
    commonBound := thetaAPTOutputCommonTargetBound measure hnormalized f h hbound }

theorem thetaToyAlgorithmOutput_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyCertifiedCommonTargetBound measure hnormalized f h hbound).choice_targetVolume_le
    choice

theorem unitThetaToyAlgorithmOutput_bound_of_choice_holds
    (h : Real) {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    h <= epsilonBound :=
  unitThetaAPTOutput_bound_of_choice_holds h hbound hholds

end ToyModel
end Stage1
end Iut
