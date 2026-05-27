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

def thetaToyIPLD (datumLabel : String) (epsilon : index -> Real)
    (f : Transport qLine thetaLine) (h : Real) :
    QualitativeData.IPLDatum (thetaAPTOutput f h epsilon) :=
  { inputLabel := datumLabel,
    outputLabel := "theta-upper-ray-output",
    choiceLabel := fun _ => "epsilon-choice" }

def thetaToySHED (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    QualitativeData.SHEDatum (thetaAPTOutput f h epsilon) :=
  { domainStructure := { label := "theta-domain" },
    codomainStructure := { label := "q-codomain" },
    commonLanguage := "toy-common-real-line" }

def thetaToyAPTD (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    QualitativeData.APTDatum (thetaAPTOutput f h epsilon) :=
  { mechanismLabel := "toy-explicit-transport",
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
