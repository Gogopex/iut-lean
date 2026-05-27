/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Mathlib.AlgebraicGeometry.EllipticCurve.ModelsWithJ
import Mathlib.FieldTheory.Galois.Basic
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.Data.Set.Basic
import Mathlib.Tactic

/-!
Initial theta data from IUT I, Definition 3.1.

This is the first math-facing layer of the project.  It deliberately uses
mathlib objects when they are available: number fields, algebraic closures,
finite Galois extensions, natural-number primality, and Weierstrass elliptic
curves.  Objects not yet available in the needed IUT form, such as hyperbolic
orbicurves and the full local reduction theory, are represented by typed
records with named proof obligations.
-/

namespace Iut

universe u v

/-- A prime number `l` satisfying the IUT lower bound `5 <= l`. -/
structure PrimeGeFive where
  value : ℕ
  prime : Nat.Prime value
  ge_five : 5 ≤ value

namespace PrimeGeFive

theorem ne_zero (l : PrimeGeFive) : l.value ≠ 0 :=
  l.prime.ne_zero

theorem ne_one (l : PrimeGeFive) : l.value ≠ 1 :=
  l.prime.ne_one

theorem ne_two (l : PrimeGeFive) : l.value ≠ 2 := by
  intro h
  have hlt : l.value < 5 := by
    omega
  exact (not_lt_of_ge l.ge_five) hlt

end PrimeGeFive

/-- The condition `sqrt(-1) in F` from IUT I, Definition 3.1(a). -/
structure SqrtMinusOneData (F : Type u) [Field F] where
  element : F
  square_eq_neg_one : element ^ 2 = -1

/--
A once-punctured elliptic curve represented by its ambient Weierstrass elliptic
curve and a label for the removed point.

The label is not intended to carry geometry.  It keeps the formal record close
to Definition 3.1 while the later curve/open-subscheme layer is developed.
-/
structure PuncturedEllipticCurve (F : Type u) [Field F] where
  curve : WeierstrassCurve F
  isElliptic : curve.IsElliptic
  punctureLabel : String

namespace PuncturedEllipticCurve

instance {F : Type u} [Field F] (X : PuncturedEllipticCurve F) :
    X.curve.IsElliptic :=
  X.isElliptic

/-- The `j`-invariant of the ambient elliptic curve. -/
noncomputable def jInvariant {F : Type u} [Field F] (X : PuncturedEllipticCurve F) :
    F := by
  letI := X.isElliptic
  exact X.curve.j

/-- A concrete source of punctured elliptic curves from mathlib's `ofJ` model. -/
noncomputable def ofJ (F : Type u) [Field F] [DecidableEq F] (j : F) :
    PuncturedEllipticCurve F where
  curve := WeierstrassCurve.ofJ j
  isElliptic := inferInstance
  punctureLabel := "origin"

theorem jInvariant_ofJ (F : Type u) [Field F] [DecidableEq F] (j : F) :
    (ofJ F j).jInvariant = j := by
  dsimp [jInvariant, ofJ]
  exact WeierstrassCurve.ofJ_j j

end PuncturedEllipticCurve

/--
The valuation data `V`, `Vbad_mod`, and the section `V -> Vmod` from
Definition 3.1(b),(e).

The record separates the moduli-level bad set from its chosen section in `V`.
This matters later because the paper distinguishes valuations of `Fmod`,
valuations above them, and the chosen subset `V` of valuations of `K`.
-/
structure ThetaValuationData
    (l : PrimeGeFive) (Valuation ModValuation : Type v) where
  toModuli : Valuation -> ModValuation
  toModuli_bijective : Function.Bijective toModuli
  residueCharacteristic : ModValuation -> ℕ
  isNonarchimedean : ModValuation -> Prop
  badMod : Set ModValuation
  badMod_nonempty : ∃ w, w ∈ badMod
  badMod_nonarchimedean : ∀ w, w ∈ badMod -> isNonarchimedean w
  badMod_oddResidueCharacteristic :
    ∀ w, w ∈ badMod -> Odd (residueCharacteristic w)
  badMod_residueCharacteristic_prime :
    ∀ w, w ∈ badMod -> Nat.Prime (residueCharacteristic w)
  badMod_residueCharacteristic_coprime_l :
    ∀ w, w ∈ badMod -> Nat.Coprime (residueCharacteristic w) l.value
  multiplicativeBadReductionAtLift : Valuation -> Prop
  bad_lifts_have_multiplicative_reduction :
    ∀ v, toModuli v ∈ badMod -> multiplicativeBadReductionAtLift v

namespace ThetaValuationData

variable {l : PrimeGeFive} {Valuation ModValuation : Type v}

/-- The bad valuations in the chosen section `V`. -/
def bad (data : ThetaValuationData l Valuation ModValuation) :
    Set Valuation :=
  {v | data.toModuli v ∈ data.badMod}

/-- The good valuations at the moduli level, i.e. the complement of `Vbad_mod`. -/
def goodMod (data : ThetaValuationData l Valuation ModValuation) :
    Set ModValuation :=
  data.badModᶜ

/-- The good valuations in the chosen section `V`. -/
def good (data : ThetaValuationData l Valuation ModValuation) :
    Set Valuation :=
  {v | data.toModuli v ∈ data.goodMod}

theorem mem_bad_iff (data : ThetaValuationData l Valuation ModValuation)
    (v : Valuation) :
    v ∈ data.bad ↔ data.toModuli v ∈ data.badMod :=
  Iff.rfl

theorem mem_good_iff (data : ThetaValuationData l Valuation ModValuation)
    (v : Valuation) :
    v ∈ data.good ↔ data.toModuli v ∉ data.badMod :=
  Iff.rfl

theorem bad_nonempty (data : ThetaValuationData l Valuation ModValuation) :
    ∃ v, v ∈ data.bad := by
  rcases data.badMod_nonempty with ⟨w, hw⟩
  rcases data.toModuli_bijective.2 w with ⟨v, hv⟩
  exact ⟨v, by simpa [bad, hv] using hw⟩

theorem badLift_has_multiplicative_reduction
    (data : ThetaValuationData l Valuation ModValuation)
    {v : Valuation} (hv : v ∈ data.bad) :
    data.multiplicativeBadReductionAtLift v :=
  data.bad_lifts_have_multiplicative_reduction v hv

end ThetaValuationData

/-- A typed placeholder for the hyperbolic orbicurves `C_F`, `C_K`, etc. -/
structure HyperbolicOrbicurveModel (F : Type u) [Field F] where
  label : String
  typeLabel : String

/-- The cusp `epsilon` of `C_K` from IUT I, Definition 3.1(f). -/
structure CuspData {F : Type u} [Field F] (C : HyperbolicOrbicurveModel F) where
  label : String
  arisesFromNonzeroQuotientElement : Prop
  arisesFromNonzeroQuotientElement_holds : arisesFromNonzeroQuotientElement

/--
Initial theta data in the sense of IUT I, Definition 3.1.

This record captures the currently formalized core:
* `F` is a number field with a chosen square root of `-1`;
* `Fbar` is mathlib's algebraic closure `AlgebraicClosure F`;
* `X_F` is represented by a punctured Weierstrass elliptic curve over `F`;
* `l` is a prime at least five;
* `K/F` is a finite Galois number-field extension via typeclass hypotheses;
* `V -> Vmod` is a bijective valuation section with a nonempty bad moduli set;
* `C_K` and `epsilon` are explicit typed objects;
* not-yet-expanded source hypotheses remain named proof obligations.
-/
structure InitialThetaData
    (F K : Type u) [Field F] [NumberField F] [Field K] [NumberField K]
    [Algebra F K] [FiniteDimensional F K] [IsGalois F K]
    (Valuation ModValuation : Type v) where
  sqrtMinusOne : SqrtMinusOneData F
  xF : PuncturedEllipticCurve F
  l : PrimeGeFive
  cK : HyperbolicOrbicurveModel K
  valuations : ThetaValuationData l Valuation ModValuation
  epsilon : CuspData cK
  stableReductionOverNonarchimedean : Prop
  stableReductionOverNonarchimedean_holds : stableReductionOverNonarchimedean
  torsion23RationalOverF : Prop
  torsion23RationalOverF_holds : torsion23RationalOverF
  lTorsionImageContainsSL2 : Prop
  lTorsionImageContainsSL2_holds : lTorsionImageContainsSL2
  qParameterOrdersPrimeToL : Prop
  qParameterOrdersPrimeToL_holds : qParameterOrdersPrimeToL

namespace InitialThetaData

variable {F K : Type u} [Field F] [NumberField F] [Field K] [NumberField K]
variable [Algebra F K] [FiniteDimensional F K] [IsGalois F K]
variable {Valuation ModValuation : Type v}
variable (theta : InitialThetaData F K Valuation ModValuation)

/-- The algebraic closure `Fbar` from Definition 3.1(a), using mathlib's construction. -/
abbrev algebraicClosure : Type u :=
  AlgebraicClosure F

omit [NumberField F] in
theorem algebraicClosure_isAlgClosure :
    IsAlgClosure F (AlgebraicClosure F) :=
  inferInstance

theorem base_is_numberField : NumberField F :=
  inferInstance

theorem extension_is_numberField : NumberField K :=
  inferInstance

omit [NumberField F] [NumberField K] [IsGalois F K] in
theorem extension_is_finiteDimensional : FiniteDimensional F K :=
  inferInstance

omit [NumberField F] [NumberField K] [FiniteDimensional F K] in
theorem extension_is_galois : IsGalois F K :=
  inferInstance

theorem prime_is_prime : Nat.Prime theta.l.value :=
  theta.l.prime

theorem prime_ge_five : 5 ≤ theta.l.value :=
  theta.l.ge_five

theorem badValuations_nonempty :
    ∃ v, v ∈ theta.valuations.bad :=
  theta.valuations.bad_nonempty

theorem badValuation_has_multiplicative_reduction
    {v : Valuation} (hv : v ∈ theta.valuations.bad) :
    theta.valuations.multiplicativeBadReductionAtLift v :=
  theta.valuations.badLift_has_multiplicative_reduction hv

theorem sqrtMinusOne_square :
    theta.sqrtMinusOne.element ^ 2 = (-1 : F) :=
  theta.sqrtMinusOne.square_eq_neg_one

theorem cusp_arisesFromNonzeroQuotientElement :
    theta.epsilon.arisesFromNonzeroQuotientElement :=
  theta.epsilon.arisesFromNonzeroQuotientElement_holds

end InitialThetaData

end Iut
