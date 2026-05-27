/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.InitialThetaData

/-!
Examples for the first formal slice of initial theta data.

These examples are intentionally small.  They verify the constructor and the
basic projections without pretending that a complete arithmetic example of IUT
initial data has already been supplied.
-/

namespace Iut

namespace InitialThetaDataExample

/-- The first admissible prime allowed by IUT I, Definition 3.1(c). -/
def primeFive : PrimeGeFive where
  value := 5
  prime := by norm_num
  ge_five := by norm_num

example : Nat.Prime primeFive.value :=
  primeFive.prime

example : 5 ≤ primeFive.value :=
  primeFive.ge_five

/--
A two-point valuation toy model.  This is only an example of the formal shape
`V -> Vmod`; it is not asserted to arise from a number field.
-/
def boolThetaValuationData : ThetaValuationData primeFive Bool Bool where
  toModuli := id
  toModuli_bijective := by
    constructor
    · intro a b h
      simpa using h
    · intro b
      exact ⟨b, rfl⟩
  residueCharacteristic := fun _ => 3
  isNonarchimedean := fun _ => True
  badMod := {w | w = true}
  badMod_nonempty := ⟨true, rfl⟩
  badMod_nonarchimedean := by
    intro _ _
    trivial
  badMod_oddResidueCharacteristic := by
    intro _ _
    norm_num [Odd]
  badMod_residueCharacteristic_prime := by
    intro _ _
    norm_num
  badMod_residueCharacteristic_coprime_l := by
    intro _ _
    norm_num [primeFive]
  multiplicativeBadReductionAtLift := fun v => v = true
  bad_lifts_have_multiplicative_reduction := by
    intro v hv
    simpa using hv

example : ∃ v, v ∈ boolThetaValuationData.bad :=
  boolThetaValuationData.bad_nonempty

example {v : Bool} (hv : v ∈ boolThetaValuationData.bad) :
    boolThetaValuationData.multiplicativeBadReductionAtLift v :=
  boolThetaValuationData.badLift_has_multiplicative_reduction hv

section AbstractConstructor

universe u

variable {F K : Type u} [Field F] [NumberField F] [Field K] [NumberField K]
variable [Algebra F K] [FiniteDimensional F K] [IsGalois F K]
variable [DecidableEq F]

/--
A constructor smoke test for full initial theta data under the exact field
hypotheses required by the record.
-/
noncomputable def abstractInitialThetaData
    (sqrtMinusOne : SqrtMinusOneData F)
    (cK : HyperbolicOrbicurveModel K)
    (epsilon : CuspData cK)
    (stableReductionOverNonarchimedean torsion23RationalOverF
      lTorsionImageContainsSL2 qParameterOrdersPrimeToL : Prop)
    (hStable : stableReductionOverNonarchimedean)
    (hTorsion : torsion23RationalOverF)
    (hImage : lTorsionImageContainsSL2)
    (hQ : qParameterOrdersPrimeToL) :
    InitialThetaData F K Bool Bool where
  sqrtMinusOne := sqrtMinusOne
  xF := PuncturedEllipticCurve.ofJ F (37 : F)
  l := primeFive
  cK := cK
  valuations := boolThetaValuationData
  epsilon := epsilon
  stableReductionOverNonarchimedean := stableReductionOverNonarchimedean
  stableReductionOverNonarchimedean_holds := hStable
  torsion23RationalOverF := torsion23RationalOverF
  torsion23RationalOverF_holds := hTorsion
  lTorsionImageContainsSL2 := lTorsionImageContainsSL2
  lTorsionImageContainsSL2_holds := hImage
  qParameterOrdersPrimeToL := qParameterOrdersPrimeToL
  qParameterOrdersPrimeToL_holds := hQ

variable (theta : InitialThetaData F K Bool Bool)

example : Nat.Prime theta.l.value :=
  theta.prime_is_prime

example : 5 ≤ theta.l.value :=
  theta.prime_ge_five

example : ∃ v, v ∈ theta.valuations.bad :=
  theta.badValuations_nonempty

example :
    theta.sqrtMinusOne.element ^ 2 = (-1 : F) :=
  theta.sqrtMinusOne_square

example (j : F) :
    (PuncturedEllipticCurve.ofJ F j).jInvariant = j :=
  PuncturedEllipticCurve.jInvariant_ofJ F j

end AbstractConstructor

end InitialThetaDataExample

end Iut
