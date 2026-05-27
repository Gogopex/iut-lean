/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Mathlib.AlgebraicGeometry.EllipticCurve.ModelsWithJ
import Mathlib.FieldTheory.Galois.Basic
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.NumberTheory.NumberField.Completion.FinitePlace
import Mathlib.NumberTheory.NumberField.InfinitePlace.Basic
import Mathlib.Data.ZMod.Basic
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

universe u

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
The field tower `Fmod ⊆ F ⊆ K` appearing in IUT I, Definition 3.1(b),(c).

The source requires `F/Fmod` to be Galois of degree prime to `l`, and `K/F` to
be a finite Galois extension.  The finite-dimensional and Galois parts are
typeclass hypotheses; the prime-to-`l` degree condition is a field of the
record because it depends on the chosen prime.
-/
structure ThetaFieldTower
    (l : PrimeGeFive) (Fmod F K : Type u)
    [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
    [Field K] [NumberField K]
    [Algebra Fmod F] [Algebra F K] [Algebra Fmod K] [IsScalarTower Fmod F K]
    [FiniteDimensional Fmod F] [IsGalois Fmod F]
    [FiniteDimensional F K] [IsGalois F K] where
  sqrtMinusOne : SqrtMinusOneData F
  degreePrimeToL_holds :
    Nat.Coprime (Module.finrank Fmod F) l.value

namespace ThetaFieldTower

variable {l : PrimeGeFive}
variable {Fmod F K : Type u}
variable [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
variable [Field K] [NumberField K]
variable [Algebra Fmod F] [Algebra F K] [Algebra Fmod K] [IsScalarTower Fmod F K]
variable [FiniteDimensional Fmod F] [IsGalois Fmod F]
variable [FiniteDimensional F K] [IsGalois F K]
variable (tower : ThetaFieldTower l Fmod F K)

theorem sqrtMinusOne_square :
    tower.sqrtMinusOne.element ^ 2 = (-1 : F) :=
  tower.sqrtMinusOne.square_eq_neg_one

theorem degreePrimeToL (tower : ThetaFieldTower l Fmod F K) :
    Nat.Coprime (Module.finrank Fmod F) l.value :=
  ThetaFieldTower.degreePrimeToL_holds tower

omit [NumberField Fmod] [NumberField F] [NumberField K] [Algebra F K] [Algebra Fmod K]
    [IsScalarTower Fmod F K] [IsGalois Fmod F] [FiniteDimensional F K] [IsGalois F K] in
theorem f_over_fmod_is_finiteDimensional : FiniteDimensional Fmod F :=
  inferInstance

omit [NumberField Fmod] [NumberField F] [NumberField K] [Algebra F K] [Algebra Fmod K]
    [IsScalarTower Fmod F K] [FiniteDimensional Fmod F] [FiniteDimensional F K]
    [IsGalois F K] in
theorem f_over_fmod_is_galois : IsGalois Fmod F :=
  inferInstance

omit [NumberField Fmod] [NumberField F] [NumberField K] [Algebra Fmod F] [Algebra Fmod K]
    [IsScalarTower Fmod F K] [FiniteDimensional Fmod F] [IsGalois Fmod F]
    [IsGalois F K] in
theorem k_over_f_is_finiteDimensional : FiniteDimensional F K :=
  inferInstance

omit [NumberField Fmod] [NumberField F] [NumberField K] [Algebra Fmod F] [Algebra Fmod K]
    [IsScalarTower Fmod F K] [FiniteDimensional Fmod F] [IsGalois Fmod F]
    [FiniteDimensional F K] in
theorem k_over_f_is_galois : IsGalois F K :=
  inferInstance

end ThetaFieldTower

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

/-- A finite or infinite place of a number field. -/
inductive ThetaPlace (K : Type u) [Field K] [NumberField K] where
  | finite : NumberField.FinitePlace K -> ThetaPlace K
  | infinite : NumberField.InfinitePlace K -> ThetaPlace K

namespace ThetaPlace

variable {K : Type u} [Field K] [NumberField K]

/-- A place is finite if it comes from `NumberField.FinitePlace`. -/
def IsFinite : ThetaPlace K -> Prop
  | finite _ => True
  | infinite _ => False

/-- A place is infinite if it comes from `NumberField.InfinitePlace`. -/
def IsInfinite : ThetaPlace K -> Prop
  | finite _ => False
  | infinite _ => True

@[simp]
theorem isFinite_finite (v : NumberField.FinitePlace K) :
    IsFinite (finite v) :=
  trivial

@[simp]
theorem not_isFinite_infinite (v : NumberField.InfinitePlace K) :
    ¬ IsFinite (infinite v) :=
  id

@[simp]
theorem isInfinite_infinite (v : NumberField.InfinitePlace K) :
    IsInfinite (infinite v) :=
  trivial

@[simp]
theorem not_isInfinite_finite (v : NumberField.FinitePlace K) :
    ¬ IsInfinite (finite v) :=
  id

end ThetaPlace

/--
The valuation data `V`, `Vbad_mod`, and the section `V -> Vmod` from
Definition 3.1(b),(e).

The finite and infinite place types come from mathlib.  The source's natural
surjection from places of `K` to places of `Fmod`, together with a chosen
section, remains explicit data.
-/
structure ThetaValuationData
    (l : PrimeGeFive) (Fmod K : Type u)
    [Field Fmod] [NumberField Fmod] [Field K] [NumberField K]
    [Algebra Fmod K] where
  toModuli : NumberField.FinitePlace K -> NumberField.FinitePlace Fmod
  chosenLift : NumberField.FinitePlace Fmod -> NumberField.FinitePlace K
  toModuli_chosenLift : ∀ w, toModuli (chosenLift w) = w
  toModuliInfinite : NumberField.InfinitePlace K -> NumberField.InfinitePlace Fmod
  chosenInfiniteLift : NumberField.InfinitePlace Fmod -> NumberField.InfinitePlace K
  toModuliInfinite_chosenLift :
    ∀ w, toModuliInfinite (chosenInfiniteLift w) = w
  residueCharacteristic : NumberField.FinitePlace Fmod -> ℕ
  badMod : Set (NumberField.FinitePlace Fmod)
  badMod_nonempty : ∃ w, w ∈ badMod
  badMod_oddResidueCharacteristic :
    ∀ w, w ∈ badMod -> Odd (residueCharacteristic w)
  badMod_residueCharacteristic_prime :
    ∀ w, w ∈ badMod -> Nat.Prime (residueCharacteristic w)
  badMod_residueCharacteristic_coprime_l :
    ∀ w, w ∈ badMod -> Nat.Coprime (residueCharacteristic w) l.value
  multiplicativeBadReductionAtLift : NumberField.FinitePlace K -> Prop
  bad_lifts_have_multiplicative_reduction :
    ∀ v, v ∈ Set.range chosenLift -> toModuli v ∈ badMod ->
      multiplicativeBadReductionAtLift v

namespace ThetaValuationData

variable {l : PrimeGeFive} {Fmod K : Type u}
variable [Field Fmod] [NumberField Fmod] [Field K] [NumberField K]
variable [Algebra Fmod K]

/-- The selected finite subset of `V(K)` supplied by the section. -/
def selected (data : ThetaValuationData l Fmod K) :
    Set (NumberField.FinitePlace K) :=
  Set.range data.chosenLift

/-- The selected infinite subset of `V(K)` supplied by the section. -/
def selectedInfinite (data : ThetaValuationData l Fmod K) :
    Set (NumberField.InfinitePlace K) :=
  Set.range data.chosenInfiniteLift

/-- The selected finite-or-infinite subset `V ⊆ V(K)`. -/
def selectedPlaces (data : ThetaValuationData l Fmod K) :
    Set (ThetaPlace K)
  | ThetaPlace.finite v => v ∈ data.selected
  | ThetaPlace.infinite v => v ∈ data.selectedInfinite

/-- The good valuations at the moduli level, i.e. the complement of `Vbad_mod`. -/
def goodMod (data : ThetaValuationData l Fmod K) :
    Set (NumberField.FinitePlace Fmod) :=
  data.badModᶜ

/-- The bad valuations in the chosen section `V`. -/
def bad (data : ThetaValuationData l Fmod K) :
    Set (NumberField.FinitePlace K) :=
  {v | v ∈ data.selected ∧ data.toModuli v ∈ data.badMod}

/-- The good valuations in the chosen section `V`. -/
def good (data : ThetaValuationData l Fmod K) :
    Set (NumberField.FinitePlace K) :=
  {v | v ∈ data.selected ∧ data.toModuli v ∈ data.goodMod}

/-- The nonarchimedean part of the selected set `V`. -/
def vnon (data : ThetaValuationData l Fmod K) :
    Set (ThetaPlace K) :=
  {p | ∃ v, v ∈ data.selected ∧ p = ThetaPlace.finite v}

/-- The archimedean part of the selected set `V`. -/
def varc (data : ThetaValuationData l Fmod K) :
    Set (ThetaPlace K) :=
  {p | ∃ v, v ∈ data.selectedInfinite ∧ p = ThetaPlace.infinite v}

/-- The bad part of the selected set `V`. -/
def vbad (data : ThetaValuationData l Fmod K) :
    Set (ThetaPlace K) :=
  {p | ∃ v, v ∈ data.bad ∧ p = ThetaPlace.finite v}

/-- The good finite part of the selected set `V`. -/
def vgood (data : ThetaValuationData l Fmod K) :
    Set (ThetaPlace K) :=
  {p | ∃ v, v ∈ data.good ∧ p = ThetaPlace.finite v}

theorem mem_selected_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.FinitePlace K) :
    v ∈ data.selected ↔ ∃ w, data.chosenLift w = v :=
  Iff.rfl

theorem chosenLift_mem_selected (data : ThetaValuationData l Fmod K)
    (w : NumberField.FinitePlace Fmod) :
    data.chosenLift w ∈ data.selected :=
  ⟨w, rfl⟩

theorem chosenInfiniteLift_mem_selectedInfinite
    (data : ThetaValuationData l Fmod K)
    (w : NumberField.InfinitePlace Fmod) :
    data.chosenInfiniteLift w ∈ data.selectedInfinite :=
  ⟨w, rfl⟩

theorem toModuli_chosenLift_eq (data : ThetaValuationData l Fmod K)
    (w : NumberField.FinitePlace Fmod) :
    data.toModuli (data.chosenLift w) = w :=
  data.toModuli_chosenLift w

theorem toModuliInfinite_chosenLift_eq
    (data : ThetaValuationData l Fmod K)
    (w : NumberField.InfinitePlace Fmod) :
    data.toModuliInfinite (data.chosenInfiniteLift w) = w :=
  data.toModuliInfinite_chosenLift w

theorem mem_bad_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.FinitePlace K) :
    v ∈ data.bad ↔ v ∈ data.selected ∧ data.toModuli v ∈ data.badMod :=
  Iff.rfl

theorem mem_good_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.FinitePlace K) :
    v ∈ data.good ↔ v ∈ data.selected ∧ data.toModuli v ∉ data.badMod :=
  Iff.rfl

theorem chosenLift_mem_bad_iff (data : ThetaValuationData l Fmod K)
    (w : NumberField.FinitePlace Fmod) :
    data.chosenLift w ∈ data.bad ↔ w ∈ data.badMod := by
  simp [bad, selected, data.toModuli_chosenLift_eq]

theorem finite_mem_selectedPlaces_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ data.selectedPlaces ↔ v ∈ data.selected :=
  Iff.rfl

theorem infinite_mem_selectedPlaces_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.InfinitePlace K) :
    ThetaPlace.infinite v ∈ data.selectedPlaces ↔ v ∈ data.selectedInfinite :=
  Iff.rfl

theorem finite_mem_vnon_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ data.vnon ↔ v ∈ data.selected := by
  constructor
  · rintro ⟨w, hw, h⟩
    cases h
    exact hw
  · intro hv
    exact ⟨v, hv, rfl⟩

theorem infinite_mem_varc_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.InfinitePlace K) :
    ThetaPlace.infinite v ∈ data.varc ↔ v ∈ data.selectedInfinite := by
  constructor
  · rintro ⟨w, hw, h⟩
    cases h
    exact hw
  · intro hv
    exact ⟨v, hv, rfl⟩

theorem finite_mem_vbad_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ data.vbad ↔ v ∈ data.bad := by
  constructor
  · rintro ⟨w, hw, h⟩
    cases h
    exact hw
  · intro hv
    exact ⟨v, hv, rfl⟩

theorem finite_mem_vgood_iff (data : ThetaValuationData l Fmod K)
    (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ data.vgood ↔ v ∈ data.good := by
  constructor
  · rintro ⟨w, hw, h⟩
    cases h
    exact hw
  · intro hv
    exact ⟨v, hv, rfl⟩

theorem bad_nonempty (data : ThetaValuationData l Fmod K) :
    ∃ v, v ∈ data.bad := by
  rcases data.badMod_nonempty with ⟨w, hw⟩
  exact ⟨data.chosenLift w, (data.chosenLift_mem_bad_iff w).mpr hw⟩

theorem badLift_has_multiplicative_reduction
    (data : ThetaValuationData l Fmod K)
    {v : NumberField.FinitePlace K} (hv : v ∈ data.bad) :
    data.multiplicativeBadReductionAtLift v :=
  data.bad_lifts_have_multiplicative_reduction v hv.1 hv.2

end ThetaValuationData

/-- The orbicurve type labels from the parts of EtTh used in IUT I, Definition 3.1. -/
inductive OrbicurveTypeKind where
  | oneLTors
  | oneLTorsPM
  | oneLTorsTheta
  | oneLTorsThetaPM
  | oneZModLPM
  | oneZModLTheta
  | oneZModLThetaPM
  deriving DecidableEq

/-- A typed placeholder for the hyperbolic orbicurves `C_F`, `C_K`, etc. -/
structure HyperbolicOrbicurveModel (F : Type u) [Field F] where
  label : String

/--
An assertion that a placeholder orbicurve has one of the specific EtTh type
labels used by Definition 3.1.
-/
structure OrbicurveTypeData
    (l : PrimeGeFive) {F : Type u} [Field F]
    (C : HyperbolicOrbicurveModel F) (kind : OrbicurveTypeKind) where
  hasType : Prop
  hasType_holds : hasType

namespace OrbicurveTypeData

variable {l : PrimeGeFive} {F : Type u} [Field F]
variable {C : HyperbolicOrbicurveModel F} {kind : OrbicurveTypeKind}
variable (typeData : OrbicurveTypeData l C kind)

theorem holds : typeData.hasType :=
  typeData.hasType_holds

end OrbicurveTypeData

/-- A pointed quotient such as the EtTh quotients `Q` and `Z`. -/
structure PointedEtaleQuotient where
  carrier : Type u
  zero : carrier

/--
The action on nonzero quotient elements alluded to in IUT I when `LabCusp`
inherits an `F_l`-torsor structure from the `F_l^×`-action on the quotient `Q`.
-/
structure QuotientUnitActionData (Q : PointedEtaleQuotient.{u}) where
  units : Type u
  smul : units -> Q.carrier -> Q.carrier
  smul_nonzero :
    ∀ a x, x ≠ Q.zero -> smul a x ≠ Q.zero

/-- A sign action on a pointed quotient. -/
structure QuotientSignAction (Q : PointedEtaleQuotient.{u}) where
  neg : Q.carrier -> Q.carrier
  neg_zero : neg Q.zero = Q.zero
  neg_involutive : ∀ x, neg (neg x) = x

namespace QuotientSignAction

variable {Q : PointedEtaleQuotient.{u}}
variable (signAction : QuotientSignAction Q)

/-- Membership in the `{±1}`-orbit of a quotient element. -/
def InSignOrbit (x generator : Q.carrier) : Prop :=
  x = generator ∨ x = signAction.neg generator

theorem generator_mem_signOrbit (generator : Q.carrier) :
    signAction.InSignOrbit generator generator :=
  Or.inl rfl

theorem neg_generator_mem_signOrbit (generator : Q.carrier) :
    signAction.InSignOrbit (signAction.neg generator) generator :=
  Or.inr rfl

end QuotientSignAction

/-- Compatibility between a sign action and a distinguished unit action. -/
structure QuotientSignUnitCompatibility
    (Q : PointedEtaleQuotient.{u})
    (unitAction : QuotientUnitActionData Q)
    (signAction : QuotientSignAction Q) where
  signUnit : unitAction.units
  signUnit_smul_eq_neg :
    ∀ x, unitAction.smul signUnit x = signAction.neg x

/-- The pointed quotient with carrier `ZMod l`, used as the current `F_l` model. -/
abbrev zmodPointedQuotient (l : PrimeGeFive) : PointedEtaleQuotient where
  carrier := ZMod l.value
  zero := 0

/-- The action of `(ZMod l)^x` on the pointed quotient `ZMod l` by multiplication. -/
def zmodUnitActionData (l : PrimeGeFive) :
    QuotientUnitActionData (zmodPointedQuotient l) where
  units := (ZMod l.value)ˣ
  smul := fun a x => (a : ZMod l.value) * x
  smul_nonzero := by
    intro a x hx hzero
    have h := congrArg
      (fun y : ZMod l.value => ((a⁻¹ : (ZMod l.value)ˣ) : ZMod l.value) * y)
      hzero
    have hx0 : x = 0 := by
      simpa [mul_assoc] using h
    exact hx hx0

/-- The sign action on `ZMod l` by additive negation. -/
def zmodSignAction (l : PrimeGeFive) :
    QuotientSignAction (zmodPointedQuotient l) where
  neg := fun x => -x
  neg_zero := by simp
  neg_involutive := by
    intro x
    simp

/-- Compatibility of the `ZMod l` sign action with multiplication by the unit `-1`. -/
def zmodSignUnitCompatibility (l : PrimeGeFive) :
    QuotientSignUnitCompatibility
      (zmodPointedQuotient l) (zmodUnitActionData l) (zmodSignAction l) where
  signUnit := (-1 : (ZMod l.value)ˣ)
  signUnit_smul_eq_neg := by
    intro x
    simp [zmodUnitActionData, zmodSignAction]

/-- A witness that a cusp arises from a nonzero element of an EtTh quotient. -/
structure NonzeroQuotientElement where
  quotient : PointedEtaleQuotient.{u}
  unitAction : QuotientUnitActionData quotient
  element : quotient.carrier
  element_ne_zero : element ≠ quotient.zero

/--
A witness for the local condition that a cusp comes from the canonical generator,
up to sign, of the quotient `Z` in the type `(1, Z/lZ)^±` model.
-/
structure CanonicalGeneratorUpToSignElement where
  quotient : PointedEtaleQuotient.{u}
  signAction : QuotientSignAction quotient
  canonicalGenerator : quotient.carrier
  element : quotient.carrier
  element_in_signOrbit : signAction.InSignOrbit element canonicalGenerator

namespace CanonicalGeneratorUpToSignElement

variable (generatorData : CanonicalGeneratorUpToSignElement.{u})

def canonicalGeneratorUpToSign : Prop :=
  generatorData.signAction.InSignOrbit generatorData.element generatorData.canonicalGenerator

theorem canonicalGeneratorUpToSign_holds :
    generatorData.canonicalGeneratorUpToSign :=
  generatorData.element_in_signOrbit

end CanonicalGeneratorUpToSignElement

/-- The nonzero quotient element `1 ∈ ZMod l`, using `l >= 5`. -/
def zmodOneNonzeroQuotientElement (l : PrimeGeFive) :
    NonzeroQuotientElement where
  quotient := zmodPointedQuotient l
  unitAction := zmodUnitActionData l
  element := (1 : ZMod l.value)
  element_ne_zero := by
    haveI : Fact (1 < l.value) :=
      ⟨lt_of_lt_of_le (by norm_num) l.ge_five⟩
    exact one_ne_zero

/-- The canonical generator `1 ∈ ZMod l`, viewed modulo the sign action. -/
def zmodCanonicalGeneratorUpToSignElement (l : PrimeGeFive) :
    CanonicalGeneratorUpToSignElement where
  quotient := zmodPointedQuotient l
  signAction := zmodSignAction l
  canonicalGenerator := (1 : ZMod l.value)
  element := (1 : ZMod l.value)
  element_in_signOrbit :=
    (zmodSignAction l).generator_mem_signOrbit (1 : ZMod l.value)

/--
The curve/moduli portion of IUT I, Definition 3.1(b).

This records the once-punctured elliptic curve `X_F`, the quotient orbicurve
`C_F`, the assertion that `C_F` is obtained by quotienting by the unique
order-two involution `-1`, the field-of-moduli assertion for `Fmod`, stable
reduction over nonarchimedean valuations, and rationality of the `2 * 3`
torsion points of the ambient elliptic curve.
-/
structure ThetaCurveModuliData
    (Fmod F : Type u) [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
    [Algebra Fmod F] where
  xF : PuncturedEllipticCurve F
  cF : HyperbolicOrbicurveModel F
  cF_is_quotient_by_neg_one : Prop
  cF_is_quotient_by_neg_one_holds : cF_is_quotient_by_neg_one
  fmod_is_fieldOfModuli : Prop
  fmod_is_fieldOfModuli_holds : fmod_is_fieldOfModuli
  stableReductionOverNonarchimedean : Prop
  stableReductionOverNonarchimedean_holds : stableReductionOverNonarchimedean
  torsion23RationalOverF : Prop
  torsion23RationalOverF_holds : torsion23RationalOverF

namespace ThetaCurveModuliData

variable {Fmod F : Type u} [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
variable [Algebra Fmod F]
variable (curveData : ThetaCurveModuliData Fmod F)

theorem quotientByNegOne :
    curveData.cF_is_quotient_by_neg_one :=
  curveData.cF_is_quotient_by_neg_one_holds

theorem fmodFieldOfModuli :
    curveData.fmod_is_fieldOfModuli :=
  curveData.fmod_is_fieldOfModuli_holds

theorem stableReduction :
    curveData.stableReductionOverNonarchimedean :=
  curveData.stableReductionOverNonarchimedean_holds

theorem torsion23Rational :
    curveData.torsion23RationalOverF :=
  curveData.torsion23RationalOverF_holds

end ThetaCurveModuliData

/--
The `C_K`/`X_K` covering data from IUT I, Definition 3.1(d).

This bundle ties `C_K` to the previously defined `C_F`: its `K`-core is the
base-change `C_F x_F K`, and it determines the corresponding `X_K` cover and
the finite etale/profinite group diagrams mentioned in the source.
-/
structure ThetaOrbicurveCoverData
    (l : PrimeGeFive) (Fmod F K : Type u)
    [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
    [Field K] [NumberField K] [Algebra Fmod F] [Algebra F K]
    (curveModuli : ThetaCurveModuliData Fmod F) where
  cK : HyperbolicOrbicurveModel K
  xK : HyperbolicOrbicurveModel K
  cK_type : OrbicurveTypeData l cK OrbicurveTypeKind.oneLTorsPM
  cK_core_is_baseChange_cF : Prop
  cK_core_is_baseChange_cF_holds : cK_core_is_baseChange_cF
  cK_determined_by_cF : Prop
  cK_determined_by_cF_holds : cK_determined_by_cF
  xK_type : OrbicurveTypeData l xK OrbicurveTypeKind.oneLTors
  finiteEtaleCoveringDiagrams : Prop
  finiteEtaleCoveringDiagrams_holds : finiteEtaleCoveringDiagrams
  profiniteGroupOpenImmersions : Prop
  profiniteGroupOpenImmersions_holds : profiniteGroupOpenImmersions

namespace ThetaOrbicurveCoverData

variable {l : PrimeGeFive}
variable {Fmod F K : Type u}
variable [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
variable [Field K] [NumberField K] [Algebra Fmod F] [Algebra F K]
variable {curveModuli : ThetaCurveModuliData Fmod F}
variable (coverData : ThetaOrbicurveCoverData l Fmod F K curveModuli)

theorem cKType :
    coverData.cK_type.hasType :=
  coverData.cK_type.holds

theorem cKCoreBaseChange :
    coverData.cK_core_is_baseChange_cF :=
  coverData.cK_core_is_baseChange_cF_holds

theorem cKDeterminedByCF :
    coverData.cK_determined_by_cF :=
  coverData.cK_determined_by_cF_holds

theorem xKType :
    coverData.xK_type.hasType :=
  coverData.xK_type.holds

theorem finiteEtaleDiagrams :
    coverData.finiteEtaleCoveringDiagrams :=
  coverData.finiteEtaleCoveringDiagrams_holds

theorem openImmersions :
    coverData.profiniteGroupOpenImmersions :=
  coverData.profiniteGroupOpenImmersions_holds

end ThetaOrbicurveCoverData

/--
The bad local finite-place data from IUT I, Definition 3.1(e).

For each selected finite place `v` of `K`, the source base-changes the
orbicurves to `K_v`.  At bad places it further requires a local type
`(1, Z/lZ)^±` condition for `C_v`, the theta-root local models, and the
corresponding open subgroup inclusions.  This structure records those local
obligations over mathlib's `v`-adic completion.
-/
structure ThetaBadLocalData
    (l : PrimeGeFive) (Fmod F K : Type u)
    [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
    [Field K] [NumberField K] [Algebra Fmod F] [Algebra F K] [Algebra Fmod K]
    (curveModuli : ThetaCurveModuliData Fmod F)
    (coverData : ThetaOrbicurveCoverData l Fmod F K curveModuli)
    (valuations : ThetaValuationData l Fmod K) where
  localX :
    (v : NumberField.FinitePlace K) -> v ∈ valuations.selected ->
      HyperbolicOrbicurveModel (v.maximalIdeal.adicCompletion K)
  localC :
    (v : NumberField.FinitePlace K) -> v ∈ valuations.selected ->
      HyperbolicOrbicurveModel (v.maximalIdeal.adicCompletion K)
  localBaseChangeDiagrams :
    (v : NumberField.FinitePlace K) -> v ∈ valuations.selected -> Prop
  localBaseChangeDiagrams_holds :
    ∀ v hv, localBaseChangeDiagrams v hv
  decompositionGroupOuterSurjection :
    (v : NumberField.FinitePlace K) -> v ∈ valuations.selected -> Prop
  decompositionGroupOuterSurjection_holds :
    ∀ v hv, decompositionGroupOuterSurjection v hv
  badLocalCType :
    (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.bad) ->
      OrbicurveTypeData l (localC v hv.1) OrbicurveTypeKind.oneZModLPM
  thetaRootLocalXType :
    (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.bad) ->
      OrbicurveTypeData l (localX v hv.1) OrbicurveTypeKind.oneZModLTheta
  thetaRootLocalCType :
    (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.bad) ->
      OrbicurveTypeData l (localC v hv.1) OrbicurveTypeKind.oneZModLThetaPM
  thetaRootLocalModels :
    (v : NumberField.FinitePlace K) -> v ∈ valuations.bad -> Prop
  thetaRootLocalModels_holds :
    ∀ v hv, thetaRootLocalModels v hv
  badLocalOpenSubgroups :
    (v : NumberField.FinitePlace K) -> v ∈ valuations.bad -> Prop
  badLocalOpenSubgroups_holds :
    ∀ v hv, badLocalOpenSubgroups v hv

namespace ThetaBadLocalData

variable {l : PrimeGeFive} {Fmod F K : Type u}
variable [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
variable [Field K] [NumberField K] [Algebra Fmod F] [Algebra F K] [Algebra Fmod K]
variable {curveModuli : ThetaCurveModuliData Fmod F}
variable {coverData : ThetaOrbicurveCoverData l Fmod F K curveModuli}
variable {valuations : ThetaValuationData l Fmod K}
variable (localData : ThetaBadLocalData l Fmod F K curveModuli coverData valuations)

theorem baseChangeDiagrams
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.selected) :
    localData.localBaseChangeDiagrams v hv :=
  localData.localBaseChangeDiagrams_holds v hv

theorem decompositionSurjection
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.selected) :
    localData.decompositionGroupOuterSurjection v hv :=
  localData.decompositionGroupOuterSurjection_holds v hv

theorem badType
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.badLocalCType v hv).hasType :=
  (localData.badLocalCType v hv).holds

theorem thetaRootXType
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.thetaRootLocalXType v hv).hasType :=
  (localData.thetaRootLocalXType v hv).holds

theorem thetaRootCType
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.thetaRootLocalCType v hv).hasType :=
  (localData.thetaRootLocalCType v hv).holds

theorem thetaRootModels
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    localData.thetaRootLocalModels v hv :=
  localData.thetaRootLocalModels_holds v hv

theorem openSubgroups
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    localData.badLocalOpenSubgroups v hv :=
  localData.badLocalOpenSubgroups_holds v hv

end ThetaBadLocalData

/-- A global or local cusp of a hyperbolic orbicurve. -/
structure CuspData {F : Type u} [Field F] (C : HyperbolicOrbicurveModel F) where
  label : String
  quotientOrigin : NonzeroQuotientElement

namespace CuspData

variable {F : Type u} [Field F] {C : HyperbolicOrbicurveModel F}
variable (epsilon : CuspData C)

def arisesFromNonzeroQuotientElement : Prop :=
  epsilon.quotientOrigin.element ≠ epsilon.quotientOrigin.quotient.zero

theorem arisesFromNonzeroQuotientElement_holds :
    epsilon.arisesFromNonzeroQuotientElement :=
  epsilon.quotientOrigin.element_ne_zero

end CuspData

/--
The local cusp data from IUT I, Definition 3.1(f).

For each selected finite place, the global cusp `epsilon` determines a local
cusp of `C_v`.  At bad places, the source imposes the stronger condition that
this local cusp comes from the canonical generator, up to sign, of the local
quotient that appears in the type `(1, Z/lZ)^±` model.
-/
structure ThetaCuspLocalData
    (l : PrimeGeFive) (Fmod F K : Type u)
    [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
    [Field K] [NumberField K] [Algebra Fmod F] [Algebra F K] [Algebra Fmod K]
    (curveModuli : ThetaCurveModuliData Fmod F)
    (coverData : ThetaOrbicurveCoverData l Fmod F K curveModuli)
    (valuations : ThetaValuationData l Fmod K)
    (badLocalData : ThetaBadLocalData l Fmod F K curveModuli coverData valuations)
    (epsilon : CuspData coverData.cK) where
  localCusp :
    (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.selected) ->
      CuspData (badLocalData.localC v hv)
  localCusp_determinedByGlobal :
    (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.selected) -> Prop
  localCusp_determinedByGlobal_holds :
    ∀ v hv, localCusp_determinedByGlobal v hv
  badLocalCanonicalGenerator :
    (v : NumberField.FinitePlace K) -> v ∈ valuations.bad ->
      CanonicalGeneratorUpToSignElement.{u}

namespace ThetaCuspLocalData

variable {l : PrimeGeFive} {Fmod F K : Type u}
variable [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
variable [Field K] [NumberField K] [Algebra Fmod F] [Algebra F K] [Algebra Fmod K]
variable {curveModuli : ThetaCurveModuliData Fmod F}
variable {coverData : ThetaOrbicurveCoverData l Fmod F K curveModuli}
variable {valuations : ThetaValuationData l Fmod K}
variable {badLocalData : ThetaBadLocalData l Fmod F K curveModuli coverData valuations}
variable {epsilon : CuspData coverData.cK}
variable (cuspLocalData :
  ThetaCuspLocalData l Fmod F K curveModuli coverData valuations badLocalData epsilon)

/-- The local bad-place cusp `epsilon_v`, using the selected-place proof from `v ∈ Vbad`. -/
def badLocalCusp (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    CuspData (badLocalData.localC v hv.1) :=
  cuspLocalData.localCusp v hv.1

theorem localCuspDeterminedByGlobal
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.selected) :
    cuspLocalData.localCusp_determinedByGlobal v hv :=
  cuspLocalData.localCusp_determinedByGlobal_holds v hv

theorem localCuspArisesFromNonzeroQuotientElement
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.selected) :
    (cuspLocalData.localCusp v hv).arisesFromNonzeroQuotientElement :=
  (cuspLocalData.localCusp v hv).arisesFromNonzeroQuotientElement_holds

theorem badLocalCuspArisesFromCanonicalGenerator
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (cuspLocalData.badLocalCanonicalGenerator v hv).canonicalGeneratorUpToSign :=
  (cuspLocalData.badLocalCanonicalGenerator v hv).canonicalGeneratorUpToSign_holds

end ThetaCuspLocalData

/--
Initial theta data in the sense of IUT I, Definition 3.1.

This record captures the currently formalized core:
* `F` is a number field with a chosen square root of `-1`;
* `Fbar` is mathlib's algebraic closure `AlgebraicClosure F`;
* `X_F` is represented by a punctured Weierstrass elliptic curve over `F`;
* `l` is a prime at least five;
* `Fmod/F/K` is a number-field tower with the source Galois and degree
  prime-to-`l` conditions;
* `V -> Vmod` is a bijective valuation section with a nonempty bad moduli set;
* `C_K` and `epsilon` are explicit typed objects;
* not-yet-expanded source hypotheses remain named proof obligations.
-/
structure InitialThetaData
    (Fmod F K : Type u)
    [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
    [Field K] [NumberField K]
    [Algebra Fmod F] [Algebra F K] [Algebra Fmod K] [IsScalarTower Fmod F K]
    [FiniteDimensional Fmod F] [IsGalois Fmod F]
    [FiniteDimensional F K] [IsGalois F K] where
  l : PrimeGeFive
  fieldTower : ThetaFieldTower l Fmod F K
  curveModuli : ThetaCurveModuliData Fmod F
  coverData : ThetaOrbicurveCoverData l Fmod F K curveModuli
  k_is_lTorsionKernelField : Prop
  k_is_lTorsionKernelField_holds : k_is_lTorsionKernelField
  valuations : ThetaValuationData l Fmod K
  badLocalData : ThetaBadLocalData l Fmod F K curveModuli coverData valuations
  epsilon : CuspData coverData.cK
  cuspLocalData :
    ThetaCuspLocalData l Fmod F K curveModuli coverData valuations badLocalData epsilon
  lTorsionImageContainsSL2 : Prop
  lTorsionImageContainsSL2_holds : lTorsionImageContainsSL2
  qParameterOrdersPrimeToL : Prop
  qParameterOrdersPrimeToL_holds : qParameterOrdersPrimeToL

namespace InitialThetaData

variable {Fmod F K : Type u}
variable [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
variable [Field K] [NumberField K]
variable [Algebra Fmod F] [Algebra F K] [Algebra Fmod K] [IsScalarTower Fmod F K]
variable [FiniteDimensional Fmod F] [IsGalois Fmod F]
variable [FiniteDimensional F K] [IsGalois F K]
variable (theta : InitialThetaData Fmod F K)

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

omit [NumberField Fmod] [NumberField F] [NumberField K] [Algebra F K] [Algebra Fmod K]
    [IsScalarTower Fmod F K] [IsGalois Fmod F] [FiniteDimensional F K] [IsGalois F K] in
theorem moduli_extension_is_finiteDimensional : FiniteDimensional Fmod F :=
  inferInstance

omit [NumberField Fmod] [NumberField F] [NumberField K] [Algebra F K] [Algebra Fmod K]
    [IsScalarTower Fmod F K] [FiniteDimensional Fmod F] [FiniteDimensional F K]
    [IsGalois F K] in
theorem moduli_extension_is_galois : IsGalois Fmod F :=
  inferInstance

theorem degree_F_over_Fmod_prime_to_l :
    Nat.Coprime (Module.finrank Fmod F) theta.l.value :=
  ThetaFieldTower.degreePrimeToL theta.fieldTower

theorem prime_is_prime : Nat.Prime theta.l.value :=
  theta.l.prime

theorem prime_ge_five : 5 ≤ theta.l.value :=
  theta.l.ge_five

theorem badValuations_nonempty :
    ∃ v, v ∈ theta.valuations.bad :=
  theta.valuations.bad_nonempty

theorem badValuation_has_multiplicative_reduction
    {v : NumberField.FinitePlace K} (hv : v ∈ theta.valuations.bad) :
    theta.valuations.multiplicativeBadReductionAtLift v :=
  theta.valuations.badLift_has_multiplicative_reduction hv

theorem finitePlace_mem_vnon_iff (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ theta.valuations.vnon ↔
      v ∈ theta.valuations.selected :=
  theta.valuations.finite_mem_vnon_iff v

theorem infinitePlace_mem_varc_iff (v : NumberField.InfinitePlace K) :
    ThetaPlace.infinite v ∈ theta.valuations.varc ↔
      v ∈ theta.valuations.selectedInfinite :=
  theta.valuations.infinite_mem_varc_iff v

theorem finitePlace_mem_vbad_iff (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ theta.valuations.vbad ↔
      v ∈ theta.valuations.bad :=
  theta.valuations.finite_mem_vbad_iff v

theorem finitePlace_mem_vgood_iff (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ theta.valuations.vgood ↔
      v ∈ theta.valuations.good :=
  theta.valuations.finite_mem_vgood_iff v

theorem localBaseChangeDiagrams
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    theta.badLocalData.localBaseChangeDiagrams v hv :=
  theta.badLocalData.baseChangeDiagrams v hv

theorem decompositionGroupOuterSurjection
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    theta.badLocalData.decompositionGroupOuterSurjection v hv :=
  theta.badLocalData.decompositionSurjection v hv

theorem badLocalType
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalData.badLocalCType v hv).hasType :=
  theta.badLocalData.badType v hv

theorem thetaRootLocalXType
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalData.thetaRootLocalXType v hv).hasType :=
  theta.badLocalData.thetaRootXType v hv

theorem thetaRootLocalCType
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalData.thetaRootLocalCType v hv).hasType :=
  theta.badLocalData.thetaRootCType v hv

theorem thetaRootLocalModels
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    theta.badLocalData.thetaRootLocalModels v hv :=
  theta.badLocalData.thetaRootModels v hv

theorem badLocalOpenSubgroups
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    theta.badLocalData.badLocalOpenSubgroups v hv :=
  theta.badLocalData.openSubgroups v hv

/-- The local cusp `epsilon_v` attached to a selected finite place. -/
def localCusp
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    CuspData (theta.badLocalData.localC v hv) :=
  theta.cuspLocalData.localCusp v hv

/-- The local cusp `epsilon_v` at a bad finite place. -/
def badLocalCusp
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    CuspData (theta.badLocalData.localC v hv.1) :=
  theta.cuspLocalData.badLocalCusp v hv

theorem localCuspDeterminedByGlobal
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    theta.cuspLocalData.localCusp_determinedByGlobal v hv :=
  theta.cuspLocalData.localCuspDeterminedByGlobal v hv

theorem localCusp_arisesFromNonzeroQuotientElement
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    (theta.localCusp v hv).arisesFromNonzeroQuotientElement :=
  theta.cuspLocalData.localCuspArisesFromNonzeroQuotientElement v hv

theorem badLocalCusp_arisesFromCanonicalGenerator
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.cuspLocalData.badLocalCanonicalGenerator v hv).canonicalGeneratorUpToSign :=
  theta.cuspLocalData.badLocalCuspArisesFromCanonicalGenerator v hv

theorem sqrtMinusOne_square :
    theta.fieldTower.sqrtMinusOne.element ^ 2 = (-1 : F) :=
  theta.fieldTower.sqrtMinusOne_square

theorem fmodFieldOfModuli :
    theta.curveModuli.fmod_is_fieldOfModuli :=
  theta.curveModuli.fmodFieldOfModuli

theorem quotientByNegOne :
    theta.curveModuli.cF_is_quotient_by_neg_one :=
  theta.curveModuli.quotientByNegOne

theorem stableReductionOverNonarchimedean :
    theta.curveModuli.stableReductionOverNonarchimedean :=
  theta.curveModuli.stableReduction

theorem torsion23RationalOverF :
    theta.curveModuli.torsion23RationalOverF :=
  theta.curveModuli.torsion23Rational

theorem cKType :
    theta.coverData.cK_type.hasType :=
  theta.coverData.cKType

theorem cKCoreBaseChange :
    theta.coverData.cK_core_is_baseChange_cF :=
  theta.coverData.cKCoreBaseChange

theorem cKDeterminedByCF :
    theta.coverData.cK_determined_by_cF :=
  theta.coverData.cKDeterminedByCF

theorem xKType :
    theta.coverData.xK_type.hasType :=
  theta.coverData.xKType

theorem finiteEtaleCoveringDiagrams :
    theta.coverData.finiteEtaleCoveringDiagrams :=
  theta.coverData.finiteEtaleDiagrams

theorem profiniteGroupOpenImmersions :
    theta.coverData.profiniteGroupOpenImmersions :=
  theta.coverData.openImmersions

theorem kIsLTorsionKernelField :
    theta.k_is_lTorsionKernelField :=
  theta.k_is_lTorsionKernelField_holds

theorem cusp_arisesFromNonzeroQuotientElement :
    theta.epsilon.arisesFromNonzeroQuotientElement :=
  theta.epsilon.arisesFromNonzeroQuotientElement_holds

end InitialThetaData

end Iut
