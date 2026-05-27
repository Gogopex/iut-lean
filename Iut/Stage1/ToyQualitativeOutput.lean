/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.AlgorithmicOutput
import Iut.Stage1.ToyAPTTransport

/-!
Toy qualitative algorithmic output.

The toy output records IPL/SHE/APT as trivial named propositions so that the
formal interface can be tested. The numerical bound still requires the explicit
common-target bound data from the previous milestones.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

/--
Toy algorithmic output for the Theta upper-ray family.

The qualitative properties are `True` in this toy model; this keeps the test
focused on dependency plumbing rather than on pretending to formalize real IPL,
SHE, or APT.
-/
def thetaToyAlgorithmOutput (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) : AlgorithmicOutput qLine thetaLine index :=
  { family := thetaAPTOutput f h epsilon,
    ipl := True,
    she := True,
    apt := True }

theorem thetaToyAlgorithmOutput_certified
    (f : Transport qLine thetaLine) (h : Real) (epsilon : index -> Real) :
    (thetaToyAlgorithmOutput f h epsilon).Certified :=
  { ipl := trivial, she := trivial, apt := trivial }

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
