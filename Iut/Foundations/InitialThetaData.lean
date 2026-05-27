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

namespace PointedEtaleQuotient

/-- The nonzero part of a pointed quotient. -/
def NonzeroCarrier (Q : PointedEtaleQuotient.{u}) : Type u :=
  {x : Q.carrier // x ≠ Q.zero}

end PointedEtaleQuotient

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

theorem neg_ne_zero {x : Q.carrier} (hx : x ≠ Q.zero) :
    signAction.neg x ≠ Q.zero := by
  intro hneg
  have hx0 : x = Q.zero := by
    rw [← signAction.neg_involutive x, hneg, signAction.neg_zero]
  exact hx hx0

/-- The sign action restricted to the nonzero part of a pointed quotient. -/
def negNonzero (x : Q.NonzeroCarrier) : Q.NonzeroCarrier where
  val := signAction.neg x.1
  property := signAction.neg_ne_zero x.2

/-- The equivalence relation on nonzero quotient elements generated by sign. -/
def NonzeroSignRel (x y : Q.NonzeroCarrier) : Prop :=
  signAction.InSignOrbit x.1 y.1

theorem nonzeroSignRel_refl (x : Q.NonzeroCarrier) :
    signAction.NonzeroSignRel x x :=
  signAction.generator_mem_signOrbit x.1

theorem nonzeroSignRel_symm {x y : Q.NonzeroCarrier}
    (h : signAction.NonzeroSignRel x y) :
    signAction.NonzeroSignRel y x := by
  rcases h with h | h
  · left
    exact h.symm
  · right
    rw [h, signAction.neg_involutive]

theorem nonzeroSignRel_trans {x y z : Q.NonzeroCarrier}
    (hxy : signAction.NonzeroSignRel x y)
    (hyz : signAction.NonzeroSignRel y z) :
    signAction.NonzeroSignRel x z := by
  rcases hxy with hxy | hxy <;> rcases hyz with hyz | hyz
  · left
    exact hxy.trans hyz
  · right
    exact hxy.trans hyz
  · right
    rw [hxy, hyz]
  · left
    rw [hxy, hyz, signAction.neg_involutive]

/-- The setoid that quotients nonzero elements by the `{±1}` sign ambiguity. -/
def nonzeroSignSetoid : Setoid Q.NonzeroCarrier where
  r := signAction.NonzeroSignRel
  iseqv := by
    constructor
    · exact signAction.nonzeroSignRel_refl
    · intro x y h
      exact signAction.nonzeroSignRel_symm h
    · intro x y z hxy hyz
      exact signAction.nonzeroSignRel_trans hxy hyz

/-- The quotient of nonzero labels by sign, modeling `LabCusp± \ {0} / {±1}`. -/
abbrev SignLabelQuotient : Type u :=
  Quotient signAction.nonzeroSignSetoid

/-- The projection from a nonzero `±`-label to its sign-label quotient. -/
def toSignLabelQuotient (x : Q.NonzeroCarrier) :
    signAction.SignLabelQuotient :=
  Quotient.mk signAction.nonzeroSignSetoid x

theorem toSignLabelQuotient_eq_of_rel {x y : Q.NonzeroCarrier}
    (h : signAction.NonzeroSignRel x y) :
    signAction.toSignLabelQuotient x =
      signAction.toSignLabelQuotient y :=
  Quotient.sound h

theorem toSignLabelQuotient_neg_eq (x : Q.NonzeroCarrier) :
    signAction.toSignLabelQuotient (signAction.negNonzero x) =
      signAction.toSignLabelQuotient x :=
  Quotient.sound (Or.inr rfl)

end QuotientSignAction

/-- Compatibility between a sign action and a distinguished unit action. -/
structure QuotientSignUnitCompatibility
    (Q : PointedEtaleQuotient.{u})
    (unitAction : QuotientUnitActionData Q)
    (signAction : QuotientSignAction Q) where
  signUnit : unitAction.units
  signUnit_smul_eq_neg :
    ∀ x, unitAction.smul signUnit x = signAction.neg x

/-- A lightweight additive torsor interface. -/
structure AdditiveTorsorData (G X : Type u) [AddGroup G] where
  vadd : G -> X -> X
  zero_vadd : ∀ x, vadd 0 x = x
  add_vadd : ∀ g h x, vadd (g + h) x = vadd g (vadd h x)
  exists_unique_vadd_eq : ∀ x y, ∃! g, vadd g x = y

/-- The pointed quotient with carrier `ZMod l`, used as the current `F_l` model. -/
abbrev zmodPointedQuotient (l : PrimeGeFive) : PointedEtaleQuotient where
  carrier := ZMod l.value
  zero := 0

/-- The concrete additive `F_l`-torsor model on `ZMod l` labels. -/
def zmodLabelAdditiveTorsorData (l : PrimeGeFive) :
    AdditiveTorsorData (ZMod l.value) (ZMod l.value) where
  vadd := fun t x => t + x
  zero_vadd := by
    intro x
    simp
  add_vadd := by
    intro g h x
    simp [add_assoc]
  exists_unique_vadd_eq := by
    intro x y
    refine ⟨y - x, ?_, ?_⟩
    · simp
    · intro t ht
      calc
        t = t + x - x := by simp
        _ = y - x := by rw [ht]

/-- Translation in the concrete `ZMod l` label torsor. -/
def zmodLabelTranslate (l : PrimeGeFive)
    (t x : ZMod l.value) : ZMod l.value :=
  (zmodLabelAdditiveTorsorData l).vadd t x

theorem zmodLabelTranslate_eq_add
    (l : PrimeGeFive) (t x : ZMod l.value) :
    zmodLabelTranslate l t x = t + x :=
  rfl

theorem zmodLabelTranslate_zero
    (l : PrimeGeFive) (x : ZMod l.value) :
    zmodLabelTranslate l 0 x = x :=
  (zmodLabelAdditiveTorsorData l).zero_vadd x

theorem zmodLabelTranslate_add
    (l : PrimeGeFive) (g h x : ZMod l.value) :
    zmodLabelTranslate l (g + h) x =
      zmodLabelTranslate l g (zmodLabelTranslate l h x) :=
  (zmodLabelAdditiveTorsorData l).add_vadd g h x

theorem zmodLabelTranslate_existsUnique
    (l : PrimeGeFive) (x y : ZMod l.value) :
    ∃! t : ZMod l.value, zmodLabelTranslate l t x = y :=
  (zmodLabelAdditiveTorsorData l).exists_unique_vadd_eq x y

/-- Coordinate of a `ZMod l` label relative to the zero/canonical base label. -/
def zmodLabelCoordinateFromZero
    (l : PrimeGeFive) (x : ZMod l.value) : ZMod l.value :=
  x

theorem zmodLabelCoordinateFromZero_spec
    (l : PrimeGeFive) (x : ZMod l.value) :
    zmodLabelTranslate l (zmodLabelCoordinateFromZero l x) 0 = x := by
  simp [zmodLabelTranslate, zmodLabelCoordinateFromZero, zmodLabelAdditiveTorsorData]

theorem zmodLabelCoordinateFromZero_unique
    (l : PrimeGeFive) (x t : ZMod l.value)
    (ht : zmodLabelTranslate l t 0 = x) :
    t = zmodLabelCoordinateFromZero l x := by
  simpa [zmodLabelTranslate, zmodLabelCoordinateFromZero, zmodLabelAdditiveTorsorData]
    using ht

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

/-- The subgroup `{1, -1}` of `(ZMod l)^x` controlling the sign ambiguity. -/
def zmodSignUnitSubgroup (l : PrimeGeFive) :
    Subgroup (ZMod l.value)ˣ where
  carrier := {a | a = 1 ∨ a = (-1 : (ZMod l.value)ˣ)}
  one_mem' := Or.inl rfl
  mul_mem' := by
    intro a b ha hb
    rcases ha with rfl | rfl <;> rcases hb with rfl | rfl <;> simp
  inv_mem' := by
    intro a ha
    rcases ha with rfl | rfl <;> simp

@[simp]
theorem mem_zmodSignUnitSubgroup_iff
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ) :
    a ∈ zmodSignUnitSubgroup l ↔
      a = 1 ∨ a = (-1 : (ZMod l.value)ˣ) :=
  Iff.rfl

theorem one_mem_zmodSignUnitSubgroup (l : PrimeGeFive) :
    (1 : (ZMod l.value)ˣ) ∈ zmodSignUnitSubgroup l :=
  Or.inl rfl

theorem neg_one_mem_zmodSignUnitSubgroup (l : PrimeGeFive) :
    (-1 : (ZMod l.value)ˣ) ∈ zmodSignUnitSubgroup l :=
  Or.inr rfl

theorem zmodSignUnitSubgroup_smul_eq_self_or_neg
    (l : PrimeGeFive) {a : (ZMod l.value)ˣ}
    (ha : a ∈ zmodSignUnitSubgroup l) (x : ZMod l.value) :
    (zmodUnitActionData l).smul a x = x ∨
      (zmodUnitActionData l).smul a x = (zmodSignAction l).neg x := by
  rcases ha with rfl | rfl
  · left
    simp [zmodUnitActionData]
  · right
    simp [zmodUnitActionData, zmodSignAction]

theorem zmodSignUnitSubgroup_orbit_iff_signOrbit
    (l : PrimeGeFive) (x generator : ZMod l.value) :
    (∃ a : (ZMod l.value)ˣ,
      a ∈ zmodSignUnitSubgroup l ∧
        (zmodUnitActionData l).smul a generator = x) ↔
      (zmodSignAction l).InSignOrbit x generator := by
  constructor
  · rintro ⟨a, ha, hax⟩
    rcases ha with rfl | rfl
    · left
      simpa [zmodUnitActionData] using hax.symm
    · right
      rw [← hax]
      simp [zmodUnitActionData, zmodSignAction]
  · intro hx
    rcases hx with rfl | rfl
    · exact ⟨1, one_mem_zmodSignUnitSubgroup l, by simp [zmodUnitActionData]⟩
    · exact ⟨-1, neg_one_mem_zmodSignUnitSubgroup l,
        by simp [zmodUnitActionData, zmodSignAction]⟩

/-- The nonzero `ZMod l` label represented by `1`. -/
def zmodOneNonzeroLabel (l : PrimeGeFive) :
    (zmodPointedQuotient l).NonzeroCarrier where
  val := (1 : ZMod l.value)
  property := by
    haveI : Fact (1 < l.value) :=
      ⟨lt_of_lt_of_le (by norm_num) l.ge_five⟩
    exact one_ne_zero

/-- The sign-quotient label class of the canonical generator `1 ∈ ZMod l`. -/
def zmodCanonicalSignLabelQuotient (l : PrimeGeFive) :
    (zmodSignAction l).SignLabelQuotient :=
  (zmodSignAction l).toSignLabelQuotient (zmodOneNonzeroLabel l)

theorem zmodCanonicalSignLabelQuotient_neg_one_eq (l : PrimeGeFive) :
    (zmodSignAction l).toSignLabelQuotient
        ((zmodSignAction l).negNonzero (zmodOneNonzeroLabel l)) =
      zmodCanonicalSignLabelQuotient l :=
  (zmodSignAction l).toSignLabelQuotient_neg_eq (zmodOneNonzeroLabel l)

theorem zmod_neg_ne_zero_of_ne_zero
    (l : PrimeGeFive) {t : ZMod l.value} (ht : t ≠ 0) :
    -t ≠ 0 := by
  intro h
  exact ht (neg_eq_zero.mp h)

/-- The nonzero label obtained by translating the base label by a nonzero coordinate. -/
def zmodNonzeroLabelFromCoordinate (l : PrimeGeFive)
    (t : ZMod l.value) (ht : t ≠ 0) :
    (zmodPointedQuotient l).NonzeroCarrier where
  val := zmodLabelTranslate l t 0
  property := by
    simpa [zmodLabelTranslate, zmodLabelAdditiveTorsorData] using ht

theorem zmodNonzeroLabelFromCoordinate_val
    (l : PrimeGeFive) (t : ZMod l.value) (ht : t ≠ 0) :
    (zmodNonzeroLabelFromCoordinate l t ht).1 = t := by
  simp [zmodNonzeroLabelFromCoordinate, zmodLabelTranslate, zmodLabelAdditiveTorsorData]

/-- The sign-label class represented by a nonzero additive coordinate. -/
def zmodSignLabelFromCoordinate (l : PrimeGeFive)
    (t : ZMod l.value) (ht : t ≠ 0) :
    (zmodSignAction l).SignLabelQuotient :=
  (zmodSignAction l).toSignLabelQuotient
    (zmodNonzeroLabelFromCoordinate l t ht)

theorem zmodSignLabelFromCoordinate_neg_eq
    (l : PrimeGeFive) (t : ZMod l.value) (ht : t ≠ 0) :
    zmodSignLabelFromCoordinate l (-t) (zmod_neg_ne_zero_of_ne_zero l ht) =
      zmodSignLabelFromCoordinate l t ht := by
  apply Quotient.sound
  right
  simp [zmodNonzeroLabelFromCoordinate, zmodLabelTranslate,
    zmodLabelAdditiveTorsorData, zmodSignAction]

theorem zmodSignLabelFromCoordinate_one_eq_canonical
    (l : PrimeGeFive) :
    zmodSignLabelFromCoordinate l (1 : ZMod l.value)
        (zmodOneNonzeroLabel l).2 =
      zmodCanonicalSignLabelQuotient l := by
  apply Quotient.sound
  left
  simp [zmodNonzeroLabelFromCoordinate, zmodOneNonzeroLabel,
    zmodLabelTranslate, zmodLabelAdditiveTorsorData]

/-- Multiplication by a unit sends nonzero `ZMod l` labels to nonzero labels. -/
def zmodUnitSmulNonzeroLabel (l : PrimeGeFive)
    (a : (ZMod l.value)ˣ)
    (x : (zmodPointedQuotient l).NonzeroCarrier) :
    (zmodPointedQuotient l).NonzeroCarrier where
  val := (zmodUnitActionData l).smul a x.1
  property := (zmodUnitActionData l).smul_nonzero a x.1 x.2

theorem zmodUnitSmulNonzeroLabel_respects_sign
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    {x y : (zmodPointedQuotient l).NonzeroCarrier}
    (h : (zmodSignAction l).NonzeroSignRel x y) :
    (zmodSignAction l).NonzeroSignRel
      (zmodUnitSmulNonzeroLabel l a x)
      (zmodUnitSmulNonzeroLabel l a y) := by
  rcases h with h | h
  · left
    simp [zmodUnitSmulNonzeroLabel, zmodUnitActionData, h]
  · right
    simp [zmodUnitSmulNonzeroLabel, zmodUnitActionData, zmodSignAction, h, mul_neg]

/-- The descended `(ZMod l)^x` action on nonzero labels modulo sign. -/
def zmodUnitActionOnSignLabelQuotient (l : PrimeGeFive)
    (a : (ZMod l.value)ˣ) :
    (zmodSignAction l).SignLabelQuotient ->
      (zmodSignAction l).SignLabelQuotient :=
  Quotient.map (zmodUnitSmulNonzeroLabel l a) (by
    intro x y h
    exact zmodUnitSmulNonzeroLabel_respects_sign l a h)

theorem zmodUnitActionOnSignLabelQuotient_apply
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    (x : (zmodPointedQuotient l).NonzeroCarrier) :
    zmodUnitActionOnSignLabelQuotient l a
        ((zmodSignAction l).toSignLabelQuotient x) =
      (zmodSignAction l).toSignLabelQuotient
        (zmodUnitSmulNonzeroLabel l a x) :=
  rfl

theorem zmodUnitActionOnSignLabelQuotient_one
    (l : PrimeGeFive) (x : (zmodSignAction l).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient l 1 x = x := by
  refine Quotient.inductionOn x ?_
  intro y
  apply Quotient.sound
  left
  simp [zmodUnitSmulNonzeroLabel, zmodUnitActionData]

theorem zmodUnitActionOnSignLabelQuotient_mul
    (l : PrimeGeFive) (a b : (ZMod l.value)ˣ)
    (x : (zmodSignAction l).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient l (a * b) x =
      zmodUnitActionOnSignLabelQuotient l a
        (zmodUnitActionOnSignLabelQuotient l b x) := by
  refine Quotient.inductionOn x ?_
  intro y
  apply Quotient.sound
  left
  simp [zmodUnitSmulNonzeroLabel, zmodUnitActionData, mul_assoc]

theorem zmodUnitActionOnSignLabelQuotient_neg_one
    (l : PrimeGeFive) (x : (zmodSignAction l).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient l (-1 : (ZMod l.value)ˣ) x = x := by
  refine Quotient.inductionOn x ?_
  intro y
  apply Quotient.sound
  right
  simp [zmodUnitSmulNonzeroLabel, zmodUnitActionData, zmodSignAction]

theorem zmodSignUnitSubgroup_action_trivial_on_signLabelQuotient
    (l : PrimeGeFive) {a : (ZMod l.value)ˣ}
    (ha : a ∈ zmodSignUnitSubgroup l)
    (x : (zmodSignAction l).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient l a x = x := by
  rcases ha with rfl | rfl
  · exact zmodUnitActionOnSignLabelQuotient_one l x
  · exact zmodUnitActionOnSignLabelQuotient_neg_one l x

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
A local model of the label-class data around `LabCusp`.

It packages the pointed quotient, unit action, sign action, additive `F_l`
torsor, and distinguished canonical coordinate into one object.  This is still a
finite-label model, not a reconstruction of cusps from orbicurves.
-/
structure LocalLabCuspModel (l : PrimeGeFive) where
  labelQuotient : PointedEtaleQuotient
  unitAction : QuotientUnitActionData labelQuotient
  signAction : QuotientSignAction labelQuotient
  signUnitCompatibility :
    QuotientSignUnitCompatibility labelQuotient unitAction signAction
  additiveTorsor : AdditiveTorsorData (ZMod l.value) labelQuotient.carrier
  canonicalCoordinate : ZMod l.value
  canonicalCoordinate_ne_zero : canonicalCoordinate ≠ 0
  canonicalNonzeroLabel : labelQuotient.NonzeroCarrier
  canonicalLabel_eq_translate :
    canonicalNonzeroLabel.1 =
      additiveTorsor.vadd canonicalCoordinate labelQuotient.zero
  canonicalSignLabel : signAction.SignLabelQuotient
  canonicalSignLabel_eq :
    canonicalSignLabel = signAction.toSignLabelQuotient canonicalNonzeroLabel

namespace LocalLabCuspModel

variable {l : PrimeGeFive} (model : LocalLabCuspModel l)

def canonicalNonzeroQuotientElement : NonzeroQuotientElement where
  quotient := model.labelQuotient
  unitAction := model.unitAction
  element := model.canonicalNonzeroLabel.1
  element_ne_zero := model.canonicalNonzeroLabel.2

theorem canonicalNonzeroQuotientElement_ne_zero :
    model.canonicalNonzeroQuotientElement.element ≠ model.labelQuotient.zero :=
  model.canonicalNonzeroLabel.2

def canonicalGeneratorUpToSignElement : CanonicalGeneratorUpToSignElement where
  quotient := model.labelQuotient
  signAction := model.signAction
  canonicalGenerator := model.canonicalNonzeroLabel.1
  element := model.canonicalNonzeroLabel.1
  element_in_signOrbit :=
    model.signAction.generator_mem_signOrbit model.canonicalNonzeroLabel.1

theorem canonicalGeneratorUpToSign :
    model.canonicalGeneratorUpToSignElement.canonicalGeneratorUpToSign :=
  model.canonicalGeneratorUpToSignElement.canonicalGeneratorUpToSign_holds

theorem canonicalLabelTranslate :
    model.canonicalNonzeroLabel.1 =
      model.additiveTorsor.vadd model.canonicalCoordinate model.labelQuotient.zero :=
  model.canonicalLabel_eq_translate

theorem canonicalSignLabelEq :
    model.canonicalSignLabel =
      model.signAction.toSignLabelQuotient model.canonicalNonzeroLabel :=
  model.canonicalSignLabel_eq

end LocalLabCuspModel

/-- The concrete `ZMod l` local label model. -/
def zmodLocalLabCuspModel (l : PrimeGeFive) : LocalLabCuspModel l where
  labelQuotient := zmodPointedQuotient l
  unitAction := zmodUnitActionData l
  signAction := zmodSignAction l
  signUnitCompatibility := zmodSignUnitCompatibility l
  additiveTorsor := zmodLabelAdditiveTorsorData l
  canonicalCoordinate := 1
  canonicalCoordinate_ne_zero := (zmodOneNonzeroLabel l).2
  canonicalNonzeroLabel := zmodOneNonzeroLabel l
  canonicalLabel_eq_translate := by
    simp [zmodOneNonzeroLabel, zmodLabelAdditiveTorsorData]
  canonicalSignLabel := zmodCanonicalSignLabelQuotient l
  canonicalSignLabel_eq := rfl

/--
The quotient `Z` package attached to a bad local orbicurve of type
`(1, Z/lZ)^±`.

This is the local quotient/sign/torsor data from which the corresponding
`LabCusp` model is built.  It is still an abstract package, but its fields are
the specific pieces that the later EtTh reconstruction should provide.
-/
structure BadLocalQuotientZData (l : PrimeGeFive) where
  quotientZ : PointedEtaleQuotient
  unitActionZ : QuotientUnitActionData quotientZ
  signActionZ : QuotientSignAction quotientZ
  signUnitCompatibilityZ :
    QuotientSignUnitCompatibility quotientZ unitActionZ signActionZ
  additiveTorsorZ : AdditiveTorsorData (ZMod l.value) quotientZ.carrier
  canonicalCoordinateZ : ZMod l.value
  canonicalCoordinateZ_ne_zero : canonicalCoordinateZ ≠ 0
  canonicalNonzeroLabelZ : quotientZ.NonzeroCarrier
  canonicalLabelZ_eq_translate :
    canonicalNonzeroLabelZ.1 =
      additiveTorsorZ.vadd canonicalCoordinateZ quotientZ.zero
  canonicalSignLabelZ : signActionZ.SignLabelQuotient
  canonicalSignLabelZ_eq :
    canonicalSignLabelZ = signActionZ.toSignLabelQuotient canonicalNonzeroLabelZ

namespace BadLocalQuotientZData

variable {l : PrimeGeFive} (zData : BadLocalQuotientZData l)

def toLocalLabCuspModel : LocalLabCuspModel l where
  labelQuotient := zData.quotientZ
  unitAction := zData.unitActionZ
  signAction := zData.signActionZ
  signUnitCompatibility := zData.signUnitCompatibilityZ
  additiveTorsor := zData.additiveTorsorZ
  canonicalCoordinate := zData.canonicalCoordinateZ
  canonicalCoordinate_ne_zero := zData.canonicalCoordinateZ_ne_zero
  canonicalNonzeroLabel := zData.canonicalNonzeroLabelZ
  canonicalLabel_eq_translate := zData.canonicalLabelZ_eq_translate
  canonicalSignLabel := zData.canonicalSignLabelZ
  canonicalSignLabel_eq := zData.canonicalSignLabelZ_eq

def canonicalGeneratorUpToSignElement : CanonicalGeneratorUpToSignElement :=
  zData.toLocalLabCuspModel.canonicalGeneratorUpToSignElement

theorem canonicalGeneratorUpToSign :
    zData.canonicalGeneratorUpToSignElement.canonicalGeneratorUpToSign :=
  zData.toLocalLabCuspModel.canonicalGeneratorUpToSign

end BadLocalQuotientZData

/-- The concrete `ZMod l` quotient-`Z` package. -/
def zmodBadLocalQuotientZData (l : PrimeGeFive) :
    BadLocalQuotientZData l where
  quotientZ := zmodPointedQuotient l
  unitActionZ := zmodUnitActionData l
  signActionZ := zmodSignAction l
  signUnitCompatibilityZ := zmodSignUnitCompatibility l
  additiveTorsorZ := zmodLabelAdditiveTorsorData l
  canonicalCoordinateZ := 1
  canonicalCoordinateZ_ne_zero := (zmodOneNonzeroLabel l).2
  canonicalNonzeroLabelZ := zmodOneNonzeroLabel l
  canonicalLabelZ_eq_translate := by
    simp [zmodOneNonzeroLabel, zmodLabelAdditiveTorsorData]
  canonicalSignLabelZ := zmodCanonicalSignLabelQuotient l
  canonicalSignLabelZ_eq := rfl

/--
An abstract fundamental group object.

This keeps the local subgroup chain typed as group-like data while postponing
the choice between profinite and tempered group structures.
-/
structure AbstractFundamentalGroup where
  carrier : Type u
  group : Group carrier
  topologyKind : String

namespace AbstractFundamentalGroup

instance (G : AbstractFundamentalGroup) : Group G.carrier :=
  G.group

end AbstractFundamentalGroup

/--
An abstract open embedding of fundamental group objects.

The map is currently a group homomorphism plus injectivity and openness
obligations. Later milestones can replace the `isOpenImage` proposition with a
mathlib topological-group statement.
-/
structure OpenEmbeddingData (source target : AbstractFundamentalGroup) where
  hom : MonoidHom source.carrier target.carrier
  injective : Function.Injective hom
  isOpenImage : Prop
  isOpenImage_holds : isOpenImage

namespace OpenEmbeddingData

variable {source target : AbstractFundamentalGroup}
variable (embedding : OpenEmbeddingData source target)

theorem openImage : embedding.isOpenImage :=
  embedding.isOpenImage_holds

theorem injective_holds : Function.Injective embedding.hom :=
  embedding.injective

end OpenEmbeddingData

/--
The chain of open subgroups produced by the bad local theta-root models.

The actual groups are abstract until the relevant profinite/tempered
fundamental groups are formalized. The open embeddings record the source shape
`Pi_Xbar_v <= Pi_Cbar_v <= Pi_C_v` from IUT I, Definition 3.1(e).
-/
structure BadLocalOpenSubgroupData where
  piXbar : AbstractFundamentalGroup
  piCbar : AbstractFundamentalGroup
  piCv : AbstractFundamentalGroup
  piXbar_to_piCbar : OpenEmbeddingData piXbar piCbar
  piCbar_to_piCv : OpenEmbeddingData piCbar piCv

namespace BadLocalOpenSubgroupData

variable (openData : BadLocalOpenSubgroupData)

def piXbar_to_piCv : MonoidHom openData.piXbar.carrier openData.piCv.carrier :=
  openData.piCbar_to_piCv.hom.comp openData.piXbar_to_piCbar.hom

theorem piXbar_to_piCv_injective :
    Function.Injective openData.piXbar_to_piCv := by
  intro x y hxy
  apply openData.piXbar_to_piCbar.injective_holds
  apply openData.piCbar_to_piCv.injective_holds
  exact hxy

theorem piXbarOpenInPiCbar :
    openData.piXbar_to_piCbar.isOpenImage :=
  openData.piXbar_to_piCbar.openImage

theorem piCbarOpenInPiCv :
    openData.piCbar_to_piCv.isOpenImage :=
  openData.piCbar_to_piCv.openImage

end BadLocalOpenSubgroupData

/--
The theta-root local models at a bad place.

IUT I, Definition 3.1(e), says these models have types
`(1,(Z/lZ)_Theta)` and `(1,(Z/lZ)_Theta)^±`; the quotient-`Z` package is the
piece of this local situation used by Definition 3.1(f).
-/
structure BadLocalThetaRootData
    (l : PrimeGeFive) {F : Type u} [Field F]
    (X C : HyperbolicOrbicurveModel F) where
  thetaRootXType : OrbicurveTypeData l X OrbicurveTypeKind.oneZModLTheta
  thetaRootCType : OrbicurveTypeData l C OrbicurveTypeKind.oneZModLThetaPM
  openSubgroups : BadLocalOpenSubgroupData
  quotientZData : BadLocalQuotientZData l
  quotientZData_constructedFromThetaRoot : Prop
  quotientZData_constructedFromThetaRoot_holds :
    quotientZData_constructedFromThetaRoot

namespace BadLocalThetaRootData

variable {l : PrimeGeFive} {F : Type u} [Field F]
variable {X C : HyperbolicOrbicurveModel F}
variable (thetaRootData : BadLocalThetaRootData l X C)

theorem thetaRootXType_holds :
    thetaRootData.thetaRootXType.hasType :=
  thetaRootData.thetaRootXType.holds

theorem thetaRootCType_holds :
    thetaRootData.thetaRootCType.hasType :=
  thetaRootData.thetaRootCType.holds

theorem piXbarOpenInPiCbar :
    thetaRootData.openSubgroups.piXbar_to_piCbar.isOpenImage :=
  thetaRootData.openSubgroups.piXbarOpenInPiCbar

theorem piCbarOpenInPiCv :
    thetaRootData.openSubgroups.piCbar_to_piCv.isOpenImage :=
  thetaRootData.openSubgroups.piCbarOpenInPiCv

theorem piXbarToPiCvInjective :
    Function.Injective thetaRootData.openSubgroups.piXbar_to_piCv :=
  thetaRootData.openSubgroups.piXbar_to_piCv_injective

theorem quotientZDataSource :
    thetaRootData.quotientZData_constructedFromThetaRoot :=
  thetaRootData.quotientZData_constructedFromThetaRoot_holds

end BadLocalThetaRootData

/--
The bad local orbicurve type witness together with the local `LabCusp` model
extracted from that witness.

The quotient-`Z` data is still supplied abstractly until the EtTh reconstruction
algorithm is formalized, but the local `LabCusp` model and canonical generator
are now derived from this quotient package.
-/
structure BadLocalOrbicurveTypeData
    (l : PrimeGeFive) {F : Type u} [Field F]
    (X C : HyperbolicOrbicurveModel F) where
  typeData : OrbicurveTypeData l C OrbicurveTypeKind.oneZModLPM
  thetaRootData : BadLocalThetaRootData l X C
  canonicalGenerator : CanonicalGeneratorUpToSignElement
  canonicalGenerator_eq_model :
    canonicalGenerator = thetaRootData.quotientZData.canonicalGeneratorUpToSignElement

namespace BadLocalOrbicurveTypeData

variable {l : PrimeGeFive} {F : Type u} [Field F]
variable {X C : HyperbolicOrbicurveModel F}
variable (typeData : BadLocalOrbicurveTypeData l X C)

theorem holds : typeData.typeData.hasType :=
  typeData.typeData.holds

def labCuspModel : LocalLabCuspModel l :=
  typeData.thetaRootData.quotientZData.toLocalLabCuspModel

theorem labCuspModelSource :
    typeData.labCuspModel =
      typeData.thetaRootData.quotientZData.toLocalLabCuspModel :=
  rfl

theorem thetaRootXType_holds :
    typeData.thetaRootData.thetaRootXType.hasType :=
  typeData.thetaRootData.thetaRootXType_holds

theorem thetaRootCType_holds :
    typeData.thetaRootData.thetaRootCType.hasType :=
  typeData.thetaRootData.thetaRootCType_holds

theorem quotientZDataSource :
    typeData.thetaRootData.quotientZData_constructedFromThetaRoot :=
  typeData.thetaRootData.quotientZDataSource

def openSubgroups : BadLocalOpenSubgroupData :=
  typeData.thetaRootData.openSubgroups

theorem piXbarOpenInPiCbar :
    typeData.openSubgroups.piXbar_to_piCbar.isOpenImage :=
  typeData.thetaRootData.piXbarOpenInPiCbar

theorem piCbarOpenInPiCv :
    typeData.openSubgroups.piCbar_to_piCv.isOpenImage :=
  typeData.thetaRootData.piCbarOpenInPiCv

theorem piXbarToPiCvInjective :
    Function.Injective typeData.openSubgroups.piXbar_to_piCv :=
  typeData.thetaRootData.piXbarToPiCvInjective

theorem canonicalGeneratorEqModel :
    typeData.canonicalGenerator =
      typeData.labCuspModel.canonicalGeneratorUpToSignElement :=
  typeData.canonicalGenerator_eq_model

theorem canonicalGeneratorUpToSign :
    typeData.canonicalGenerator.canonicalGeneratorUpToSign :=
  typeData.canonicalGenerator.canonicalGeneratorUpToSign_holds

end BadLocalOrbicurveTypeData

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
      BadLocalOrbicurveTypeData l (localX v hv.1) (localC v hv.1)

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
    (localData.badLocalCType v hv).typeData.hasType :=
  (localData.badLocalCType v hv).holds

noncomputable def badLocalLabCuspModel
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    LocalLabCuspModel l :=
  (localData.badLocalCType v hv).labCuspModel

def badLocalCanonicalGenerator
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    CanonicalGeneratorUpToSignElement :=
  (localData.badLocalCType v hv).canonicalGenerator

theorem badLocalCanonicalGeneratorEqModel
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    localData.badLocalCanonicalGenerator v hv =
      (localData.badLocalLabCuspModel v hv).canonicalGeneratorUpToSignElement :=
  (localData.badLocalCType v hv).canonicalGeneratorEqModel

theorem badLocalCanonicalGeneratorUpToSign
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.badLocalCanonicalGenerator v hv).canonicalGeneratorUpToSign :=
  (localData.badLocalCType v hv).canonicalGeneratorUpToSign

theorem badLocalLabCuspModelSource
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    localData.badLocalLabCuspModel v hv =
      BadLocalQuotientZData.toLocalLabCuspModel
        ((localData.badLocalCType v hv).thetaRootData.quotientZData) :=
  (localData.badLocalCType v hv).labCuspModelSource

def thetaRootLocalXType
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    OrbicurveTypeData l (localData.localX v hv.1) OrbicurveTypeKind.oneZModLTheta :=
  (localData.badLocalCType v hv).thetaRootData.thetaRootXType

def thetaRootLocalCType
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    OrbicurveTypeData l (localData.localC v hv.1) OrbicurveTypeKind.oneZModLThetaPM :=
  (localData.badLocalCType v hv).thetaRootData.thetaRootCType

def thetaRootLocalModels
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) : Prop :=
  (localData.badLocalCType v hv).thetaRootData.quotientZData_constructedFromThetaRoot

theorem thetaRootXType
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.thetaRootLocalXType v hv).hasType :=
  (localData.badLocalCType v hv).thetaRootXType_holds

theorem thetaRootCType
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.thetaRootLocalCType v hv).hasType :=
  (localData.badLocalCType v hv).thetaRootCType_holds

theorem thetaRootModels
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    localData.thetaRootLocalModels v hv :=
  (localData.badLocalCType v hv).quotientZDataSource

noncomputable def badLocalOpenSubgroups
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    BadLocalOpenSubgroupData :=
  (localData.badLocalCType v hv).openSubgroups

theorem badLocalPiXbarOpenInPiCbar
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.badLocalOpenSubgroups v hv).piXbar_to_piCbar.isOpenImage :=
  (localData.badLocalCType v hv).piXbarOpenInPiCbar

theorem badLocalPiCbarOpenInPiCv
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (localData.badLocalOpenSubgroups v hv).piCbar_to_piCv.isOpenImage :=
  (localData.badLocalCType v hv).piCbarOpenInPiCv

theorem badLocalPiXbarToPiCvInjective
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    Function.Injective (localData.badLocalOpenSubgroups v hv).piXbar_to_piCv :=
  (localData.badLocalCType v hv).piXbarToPiCvInjective

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

theorem eq_of_quotientOrigin_eq
    {l : PrimeGeFive} (model : LocalLabCuspModel l)
    (h : epsilon.quotientOrigin = model.canonicalNonzeroQuotientElement) :
    epsilon =
      { label := epsilon.label
        quotientOrigin := model.canonicalNonzeroQuotientElement } := by
  cases epsilon
  simp only [mk.injEq, true_and] at h ⊢
  exact h

end CuspData

namespace LocalLabCuspModel

variable {l : PrimeGeFive} (model : LocalLabCuspModel l)
variable {F : Type u} [Field F] (C : HyperbolicOrbicurveModel F)

/-- Build a cusp on a specified orbicurve from the local label model. -/
def toCuspData (label : String) : CuspData C where
  label := label
  quotientOrigin := model.canonicalNonzeroQuotientElement

theorem toCuspData_quotientOrigin (label : String) :
    (model.toCuspData C label).quotientOrigin =
      model.canonicalNonzeroQuotientElement :=
  rfl

theorem toCuspData_arisesFromNonzeroQuotientElement (label : String) :
    (model.toCuspData C label).arisesFromNonzeroQuotientElement :=
  (model.toCuspData C label).arisesFromNonzeroQuotientElement_holds

end LocalLabCuspModel

/-- Structured label-class data for a cusp, replacing the bare string as math content. -/
structure CuspLabelClassData (l : PrimeGeFive) where
  model : LocalLabCuspModel l
  labelClass : model.signAction.SignLabelQuotient
  labelClass_eq_canonical : labelClass = model.canonicalSignLabel

namespace CuspLabelClassData

variable {l : PrimeGeFive} (labelData : CuspLabelClassData l)

/-- The canonical label-class data supplied by a local `LabCusp` model. -/
def canonical (model : LocalLabCuspModel l) : CuspLabelClassData l where
  model := model
  labelClass := model.canonicalSignLabel
  labelClass_eq_canonical := rfl

theorem labelClass_eq_model_quotient :
    labelData.labelClass =
      labelData.model.signAction.toSignLabelQuotient
        labelData.model.canonicalNonzeroLabel := by
  rw [labelData.labelClass_eq_canonical]
  exact labelData.model.canonicalSignLabelEq

end CuspLabelClassData

/-- The canonical structured cusp-label class in the concrete `ZMod l` model. -/
def zmodCanonicalCuspLabelClassData (l : PrimeGeFive) :
    CuspLabelClassData l :=
  CuspLabelClassData.canonical (zmodLocalLabCuspModel l)

/-- A cusp together with structured label-class data explaining its origin. -/
structure ModeledCuspData {F : Type u} [Field F]
    (C : HyperbolicOrbicurveModel F) (l : PrimeGeFive) where
  labelText : String
  labelClassData : CuspLabelClassData l
  cusp : CuspData C
  cusp_eq_model : cusp = labelClassData.model.toCuspData C labelText

namespace ModeledCuspData

variable {F : Type u} [Field F] {C : HyperbolicOrbicurveModel F} {l : PrimeGeFive}
variable (modeled : ModeledCuspData C l)

theorem cusp_arisesFromNonzeroQuotientElement :
    modeled.cusp.arisesFromNonzeroQuotientElement := by
  rw [modeled.cusp_eq_model]
  exact modeled.labelClassData.model.toCuspData_arisesFromNonzeroQuotientElement
    C modeled.labelText

theorem cusp_quotientOrigin_eq_model :
    modeled.cusp.quotientOrigin =
      modeled.labelClassData.model.canonicalNonzeroQuotientElement := by
  rw [modeled.cusp_eq_model]
  rfl

end ModeledCuspData

/-- A modeled cusp from the concrete `ZMod l` local label model. -/
def zmodModeledCuspData {F : Type u} [Field F]
    (C : HyperbolicOrbicurveModel F) (labelText : String) (l : PrimeGeFive) :
    ModeledCuspData C l where
  labelText := labelText
  labelClassData := zmodCanonicalCuspLabelClassData l
  cusp := (zmodLocalLabCuspModel l).toCuspData C labelText
  cusp_eq_model := rfl

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
  badLocalCusp_quotientOrigin_eq_model :
    ∀ v hv, (localCusp v hv.1).quotientOrigin =
      (badLocalData.badLocalLabCuspModel v hv).canonicalNonzeroQuotientElement

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
    (badLocalData.badLocalCanonicalGenerator v hv).canonicalGeneratorUpToSign :=
  badLocalData.badLocalCanonicalGeneratorUpToSign v hv

noncomputable def badLocalLabelModel
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    LocalLabCuspModel l :=
  badLocalData.badLocalLabCuspModel v hv

theorem badLocalCuspQuotientOriginEqModel
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (cuspLocalData.badLocalCusp v hv).quotientOrigin =
      (badLocalData.badLocalLabCuspModel v hv).canonicalNonzeroQuotientElement :=
  cuspLocalData.badLocalCusp_quotientOrigin_eq_model v hv

theorem badLocalCuspEqModelCusp
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    cuspLocalData.badLocalCusp v hv =
      (badLocalData.badLocalLabCuspModel v hv).toCuspData
        (badLocalData.localC v hv.1) (cuspLocalData.badLocalCusp v hv).label := by
  apply CuspData.eq_of_quotientOrigin_eq
  exact cuspLocalData.badLocalCuspQuotientOriginEqModel v hv

noncomputable def badLocalCuspLabelClassData
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    CuspLabelClassData l :=
  CuspLabelClassData.canonical (badLocalData.badLocalLabCuspModel v hv)

noncomputable def badLocalModeledCusp
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    ModeledCuspData (badLocalData.localC v hv.1) l where
  labelText := (cuspLocalData.badLocalCusp v hv).label
  labelClassData :=
    badLocalCuspLabelClassData v hv
  cusp := cuspLocalData.badLocalCusp v hv
  cusp_eq_model := cuspLocalData.badLocalCuspEqModelCusp v hv

theorem badLocalModeledCusp_cusp
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (cuspLocalData.badLocalModeledCusp v hv).cusp =
      cuspLocalData.badLocalCusp v hv :=
  rfl

theorem badLocalModeledCusp_labelClass_eq_model_quotient
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    (cuspLocalData.badLocalModeledCusp v hv).labelClassData.labelClass =
      QuotientSignAction.toSignLabelQuotient
        ((cuspLocalData.badLocalModeledCusp v hv).labelClassData.model.signAction)
        (LocalLabCuspModel.canonicalNonzeroLabel
          ((cuspLocalData.badLocalModeledCusp v hv).labelClassData.model)) :=
  CuspLabelClassData.labelClass_eq_model_quotient
    ((ThetaCuspLocalData.badLocalModeledCusp cuspLocalData v hv).labelClassData)

theorem badLocalCanonicalGeneratorEqModel
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    badLocalData.badLocalCanonicalGenerator v hv =
      (badLocalData.badLocalLabCuspModel v hv).canonicalGeneratorUpToSignElement :=
  badLocalData.badLocalCanonicalGeneratorEqModel v hv

theorem badLocalModelCanonicalGeneratorUpToSign
    (v : NumberField.FinitePlace K) (hv : v ∈ valuations.bad) :
    CanonicalGeneratorUpToSignElement.canonicalGeneratorUpToSign
      ((badLocalData.badLocalLabCuspModel v hv).canonicalGeneratorUpToSignElement) :=
  (badLocalData.badLocalLabCuspModel v hv).canonicalGeneratorUpToSign

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
    (theta.badLocalData.badLocalCType v hv).typeData.hasType :=
  theta.badLocalData.badType v hv

theorem badLocalLabCuspModelSource
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    theta.badLocalData.badLocalLabCuspModel v hv =
      BadLocalQuotientZData.toLocalLabCuspModel
        ((theta.badLocalData.badLocalCType v hv).thetaRootData.quotientZData) :=
  ThetaBadLocalData.badLocalLabCuspModelSource theta.badLocalData v hv

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

noncomputable def badLocalOpenSubgroups
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    BadLocalOpenSubgroupData :=
  theta.badLocalData.badLocalOpenSubgroups v hv

theorem badLocalPiXbarOpenInPiCbar
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalOpenSubgroups v hv).piXbar_to_piCbar.isOpenImage :=
  ThetaBadLocalData.badLocalPiXbarOpenInPiCbar theta.badLocalData v hv

theorem badLocalPiCbarOpenInPiCv
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalOpenSubgroups v hv).piCbar_to_piCv.isOpenImage :=
  ThetaBadLocalData.badLocalPiCbarOpenInPiCv theta.badLocalData v hv

theorem badLocalPiXbarToPiCvInjective
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    Function.Injective (theta.badLocalOpenSubgroups v hv).piXbar_to_piCv :=
  ThetaBadLocalData.badLocalPiXbarToPiCvInjective theta.badLocalData v hv

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
    (theta.badLocalData.badLocalCanonicalGenerator v hv).canonicalGeneratorUpToSign :=
  theta.badLocalData.badLocalCanonicalGeneratorUpToSign v hv

def badLocalCanonicalGenerator
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    CanonicalGeneratorUpToSignElement :=
  theta.badLocalData.badLocalCanonicalGenerator v hv

noncomputable def badLocalLabCuspModel
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    LocalLabCuspModel theta.l :=
  theta.badLocalData.badLocalLabCuspModel v hv

theorem badLocalCusp_quotientOrigin_eq_model
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalCusp v hv).quotientOrigin =
      (theta.badLocalLabCuspModel v hv).canonicalNonzeroQuotientElement :=
  theta.cuspLocalData.badLocalCuspQuotientOriginEqModel v hv

theorem badLocalCusp_eq_modelCusp
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    theta.badLocalCusp v hv =
      (theta.badLocalLabCuspModel v hv).toCuspData
        (theta.badLocalData.localC v hv.1) (theta.badLocalCusp v hv).label :=
  theta.cuspLocalData.badLocalCuspEqModelCusp v hv

noncomputable def badLocalCuspLabelClassData
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    CuspLabelClassData theta.l :=
  CuspLabelClassData.canonical (theta.badLocalLabCuspModel v hv)

noncomputable def badLocalModeledCusp
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    ModeledCuspData (theta.badLocalData.localC v hv.1) theta.l :=
  theta.cuspLocalData.badLocalModeledCusp v hv

theorem badLocalModeledCusp_cusp
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalModeledCusp v hv).cusp = theta.badLocalCusp v hv :=
  theta.cuspLocalData.badLocalModeledCusp_cusp v hv

theorem badLocalModeledCusp_labelClass_eq_model_quotient
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalModeledCusp v hv).labelClassData.labelClass =
      QuotientSignAction.toSignLabelQuotient
        ((theta.badLocalModeledCusp v hv).labelClassData.model.signAction)
        (LocalLabCuspModel.canonicalNonzeroLabel
          ((theta.badLocalModeledCusp v hv).labelClassData.model)) :=
  ThetaCuspLocalData.badLocalModeledCusp_labelClass_eq_model_quotient
    theta.cuspLocalData v hv

theorem badLocalCanonicalGenerator_eq_model
    (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    theta.badLocalCanonicalGenerator v hv =
      (theta.badLocalLabCuspModel v hv).canonicalGeneratorUpToSignElement :=
  theta.badLocalData.badLocalCanonicalGeneratorEqModel v hv

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
