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

example (x : ZMod primeFive.value) :
    zmodLabelTranslate primeFive 0 x = x :=
  zmodLabelTranslate_zero primeFive x

example (g h x : ZMod primeFive.value) :
    zmodLabelTranslate primeFive (g + h) x =
      zmodLabelTranslate primeFive g (zmodLabelTranslate primeFive h x) :=
  zmodLabelTranslate_add primeFive g h x

example (x y : ZMod primeFive.value) :
    ∃! t : ZMod primeFive.value, zmodLabelTranslate primeFive t x = y :=
  zmodLabelTranslate_existsUnique primeFive x y

example (x : ZMod primeFive.value) :
    zmodLabelTranslate primeFive (zmodLabelCoordinateFromZero primeFive x) 0 = x :=
  zmodLabelCoordinateFromZero_spec primeFive x

example (x t : ZMod primeFive.value)
    (ht : zmodLabelTranslate primeFive t 0 = x) :
    t = zmodLabelCoordinateFromZero primeFive x :=
  zmodLabelCoordinateFromZero_unique primeFive x t ht

section AbstractConstructor

universe u

variable {Fmod F K : Type u}
variable [Field Fmod] [NumberField Fmod] [Field F] [NumberField F]
variable [Field K] [NumberField K]
variable [Algebra Fmod F] [Algebra F K] [Algebra Fmod K] [IsScalarTower Fmod F K]
variable [FiniteDimensional Fmod F] [IsGalois Fmod F]
variable [FiniteDimensional F K] [IsGalois F K]
variable [DecidableEq F]

/-- A constructor smoke test for EtTh orbicurve type assertions. -/
def abstractOrbicurveTypeData
    (C : HyperbolicOrbicurveModel F) (kind : OrbicurveTypeKind)
    (hasType : Prop) (hType : hasType) :
    OrbicurveTypeData primeFive C kind where
  hasType := hasType
  hasType_holds := hType

example (C : HyperbolicOrbicurveModel F) (kind : OrbicurveTypeKind)
    (hasType : Prop) (hType : hasType) :
    (abstractOrbicurveTypeData C kind hasType hType).hasType :=
  (abstractOrbicurveTypeData C kind hasType hType).holds

/-- A constructor smoke test for a pointed EtTh quotient. -/
def abstractPointedEtaleQuotient (Q : Type u) (zero : Q) :
    PointedEtaleQuotient where
  carrier := Q
  zero := zero

/-- A constructor smoke test for the unit action on a quotient. -/
def abstractQuotientUnitActionData
    (Q : PointedEtaleQuotient)
    (units : Type u) (smul : units -> Q.carrier -> Q.carrier)
    (hNonzero : ∀ a x, x ≠ Q.zero -> smul a x ≠ Q.zero) :
    QuotientUnitActionData Q where
  units := units
  smul := smul
  smul_nonzero := hNonzero

/-- A constructor smoke test for a nonzero quotient element. -/
def abstractNonzeroQuotientElement
    (Q : PointedEtaleQuotient)
    (unitAction : QuotientUnitActionData Q)
    (element : Q.carrier) (hNe : element ≠ Q.zero) :
    NonzeroQuotientElement where
  quotient := Q
  unitAction := unitAction
  element := element
  element_ne_zero := hNe

/-- A constructor smoke test for a cusp arising from a nonzero quotient element. -/
def abstractCuspData
    (C : HyperbolicOrbicurveModel F) (origin : NonzeroQuotientElement) :
    CuspData C where
  label := "abstract-cusp"
  quotientOrigin := origin

example (C : HyperbolicOrbicurveModel F) (origin : NonzeroQuotientElement) :
    (abstractCuspData C origin).arisesFromNonzeroQuotientElement :=
  (abstractCuspData C origin).arisesFromNonzeroQuotientElement_holds

/-- A constructor smoke test for a sign action on a quotient. -/
def abstractQuotientSignAction
    (Q : PointedEtaleQuotient)
    (neg : Q.carrier -> Q.carrier)
    (hZero : neg Q.zero = Q.zero)
    (hInvolutive : ∀ x, neg (neg x) = x) :
    QuotientSignAction Q where
  neg := neg
  neg_zero := hZero
  neg_involutive := hInvolutive

example (Q : PointedEtaleQuotient)
    (signAction : QuotientSignAction Q) (generator : Q.carrier) :
    signAction.InSignOrbit generator generator :=
  signAction.generator_mem_signOrbit generator

example (Q : PointedEtaleQuotient)
    (signAction : QuotientSignAction Q) (generator : Q.carrier) :
    signAction.InSignOrbit (signAction.neg generator) generator :=
  signAction.neg_generator_mem_signOrbit generator

example (Q : PointedEtaleQuotient)
    (signAction : QuotientSignAction Q) (x : Q.NonzeroCarrier) :
    signAction.toSignLabelQuotient (signAction.negNonzero x) =
      signAction.toSignLabelQuotient x :=
  signAction.toSignLabelQuotient_neg_eq x

/-- A constructor smoke test for compatibility between sign and unit actions. -/
def abstractQuotientSignUnitCompatibility
    (Q : PointedEtaleQuotient)
    (unitAction : QuotientUnitActionData Q)
    (signAction : QuotientSignAction Q)
    (signUnit : unitAction.units)
    (hSign : ∀ x, unitAction.smul signUnit x = signAction.neg x) :
    QuotientSignUnitCompatibility Q unitAction signAction where
  signUnit := signUnit
  signUnit_smul_eq_neg := hSign

example (Q : PointedEtaleQuotient)
    (unitAction : QuotientUnitActionData Q)
    (signAction : QuotientSignAction Q)
    (signUnit : unitAction.units)
    (hSign : ∀ x, unitAction.smul signUnit x = signAction.neg x)
    (x : Q.carrier) :
    unitAction.smul
        (abstractQuotientSignUnitCompatibility Q unitAction signAction
          signUnit hSign).signUnit x =
      signAction.neg x :=
  (abstractQuotientSignUnitCompatibility Q unitAction signAction
    signUnit hSign).signUnit_smul_eq_neg x

/-- A constructor smoke test for a canonical-generator-up-to-sign witness. -/
def abstractCanonicalGeneratorUpToSignElement
    (Z : PointedEtaleQuotient)
    (signAction : QuotientSignAction Z)
    (canonicalGenerator element : Z.carrier)
    (hOrbit : signAction.InSignOrbit element canonicalGenerator) :
    CanonicalGeneratorUpToSignElement where
  quotient := Z
  signAction := signAction
  canonicalGenerator := canonicalGenerator
  element := element
  element_in_signOrbit := hOrbit

example (Z : PointedEtaleQuotient)
    (signAction : QuotientSignAction Z)
    (canonicalGenerator element : Z.carrier)
    (hOrbit : signAction.InSignOrbit element canonicalGenerator) :
    (abstractCanonicalGeneratorUpToSignElement Z signAction
      canonicalGenerator element hOrbit).canonicalGeneratorUpToSign :=
  (abstractCanonicalGeneratorUpToSignElement Z signAction
    canonicalGenerator element hOrbit).canonicalGeneratorUpToSign_holds

example :
    (zmodOneNonzeroQuotientElement primeFive).element ≠
      (zmodPointedQuotient primeFive).zero :=
  (zmodOneNonzeroQuotientElement primeFive).element_ne_zero

example (a : (ZMod primeFive.value)ˣ) (x : ZMod primeFive.value) (hx : x ≠ 0) :
    (zmodUnitActionData primeFive).smul a x ≠ (zmodPointedQuotient primeFive).zero :=
  (zmodUnitActionData primeFive).smul_nonzero a x hx

example :
    (zmodSignAction primeFive).InSignOrbit
      (-(1 : ZMod primeFive.value)) (1 : ZMod primeFive.value) :=
  (zmodSignAction primeFive).neg_generator_mem_signOrbit (1 : ZMod primeFive.value)

example (x : ZMod primeFive.value) :
    (zmodUnitActionData primeFive).smul
        (zmodSignUnitCompatibility primeFive).signUnit x =
      (zmodSignAction primeFive).neg x :=
  (zmodSignUnitCompatibility primeFive).signUnit_smul_eq_neg x

example :
    (-1 : (ZMod primeFive.value)ˣ) ∈ zmodSignUnitSubgroup primeFive :=
  neg_one_mem_zmodSignUnitSubgroup primeFive

example (a : (ZMod primeFive.value)ˣ) (x : ZMod primeFive.value)
    (ha : a ∈ zmodSignUnitSubgroup primeFive) :
    (zmodUnitActionData primeFive).smul a x = x ∨
      (zmodUnitActionData primeFive).smul a x =
        (zmodSignAction primeFive).neg x :=
  zmodSignUnitSubgroup_smul_eq_self_or_neg primeFive ha x

example (x generator : ZMod primeFive.value) :
    (∃ a : (ZMod primeFive.value)ˣ,
      a ∈ zmodSignUnitSubgroup primeFive ∧
        (zmodUnitActionData primeFive).smul a generator = x) ↔
      (zmodSignAction primeFive).InSignOrbit x generator :=
  zmodSignUnitSubgroup_orbit_iff_signOrbit primeFive x generator

example :
    (zmodSignAction primeFive).SignLabelQuotient :=
  zmodCanonicalSignLabelQuotient primeFive

example :
    (zmodSignAction primeFive).toSignLabelQuotient
        ((zmodSignAction primeFive).negNonzero (zmodOneNonzeroLabel primeFive)) =
      zmodCanonicalSignLabelQuotient primeFive :=
  zmodCanonicalSignLabelQuotient_neg_one_eq primeFive

example (a : (ZMod primeFive.value)ˣ)
    (x : (zmodPointedQuotient primeFive).NonzeroCarrier) :
    zmodUnitActionOnSignLabelQuotient primeFive a
        ((zmodSignAction primeFive).toSignLabelQuotient x) =
      (zmodSignAction primeFive).toSignLabelQuotient
        (zmodUnitSmulNonzeroLabel primeFive a x) :=
  zmodUnitActionOnSignLabelQuotient_apply primeFive a x

example (x : (zmodSignAction primeFive).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient primeFive 1 x = x :=
  zmodUnitActionOnSignLabelQuotient_one primeFive x

example (a b : (ZMod primeFive.value)ˣ)
    (x : (zmodSignAction primeFive).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient primeFive (a * b) x =
      zmodUnitActionOnSignLabelQuotient primeFive a
        (zmodUnitActionOnSignLabelQuotient primeFive b x) :=
  zmodUnitActionOnSignLabelQuotient_mul primeFive a b x

example (x : (zmodSignAction primeFive).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient primeFive
      (-1 : (ZMod primeFive.value)ˣ) x = x :=
  zmodUnitActionOnSignLabelQuotient_neg_one primeFive x

example {a : (ZMod primeFive.value)ˣ}
    (ha : a ∈ zmodSignUnitSubgroup primeFive)
    (x : (zmodSignAction primeFive).SignLabelQuotient) :
    zmodUnitActionOnSignLabelQuotient primeFive a x = x :=
  zmodSignUnitSubgroup_action_trivial_on_signLabelQuotient primeFive ha x

example :
    (zmodCanonicalGeneratorUpToSignElement primeFive).canonicalGeneratorUpToSign :=
  (zmodCanonicalGeneratorUpToSignElement primeFive).canonicalGeneratorUpToSign_holds

/-- A constructor smoke test for the finite-place valuation section. -/
def abstractThetaValuationData
    (toModuli : NumberField.FinitePlace K -> NumberField.FinitePlace Fmod)
    (chosenLift : NumberField.FinitePlace Fmod -> NumberField.FinitePlace K)
    (hSection : ∀ w, toModuli (chosenLift w) = w)
    (toModuliInfinite : NumberField.InfinitePlace K -> NumberField.InfinitePlace Fmod)
    (chosenInfiniteLift :
      NumberField.InfinitePlace Fmod -> NumberField.InfinitePlace K)
    (hInfiniteSection :
      ∀ w, toModuliInfinite (chosenInfiniteLift w) = w)
    (residueCharacteristic : NumberField.FinitePlace Fmod -> ℕ)
    (badMod : Set (NumberField.FinitePlace Fmod))
    (hBad : ∃ w, w ∈ badMod)
    (hOdd : ∀ w, w ∈ badMod -> Odd (residueCharacteristic w))
    (hPrime : ∀ w, w ∈ badMod -> Nat.Prime (residueCharacteristic w))
    (hCoprime : ∀ w, w ∈ badMod ->
      Nat.Coprime (residueCharacteristic w) primeFive.value)
    (multiplicativeBadReductionAtLift : NumberField.FinitePlace K -> Prop)
    (hMult : ∀ v, v ∈ Set.range chosenLift -> toModuli v ∈ badMod ->
      multiplicativeBadReductionAtLift v) :
    ThetaValuationData primeFive Fmod K where
  toModuli := toModuli
  chosenLift := chosenLift
  toModuli_chosenLift := hSection
  toModuliInfinite := toModuliInfinite
  chosenInfiniteLift := chosenInfiniteLift
  toModuliInfinite_chosenLift := hInfiniteSection
  residueCharacteristic := residueCharacteristic
  badMod := badMod
  badMod_nonempty := hBad
  badMod_oddResidueCharacteristic := hOdd
  badMod_residueCharacteristic_prime := hPrime
  badMod_residueCharacteristic_coprime_l := hCoprime
  multiplicativeBadReductionAtLift := multiplicativeBadReductionAtLift
  bad_lifts_have_multiplicative_reduction := hMult

/-- A constructor smoke test for the field tower part of initial theta data. -/
def abstractThetaFieldTower
    (sqrtMinusOne : SqrtMinusOneData F)
    (hDegree : Nat.Coprime (Module.finrank Fmod F) primeFive.value) :
    ThetaFieldTower primeFive Fmod F K where
  sqrtMinusOne := sqrtMinusOne
  degreePrimeToL_holds := hDegree

/-- A constructor smoke test for the curve/moduli part of initial theta data. -/
noncomputable def abstractThetaCurveModuliData
    (cF : HyperbolicOrbicurveModel F)
    (cF_is_quotient_by_neg_one fmod_is_fieldOfModuli
      stableReductionOverNonarchimedean torsion23RationalOverF : Prop)
    (hQuotient : cF_is_quotient_by_neg_one)
    (hFmod : fmod_is_fieldOfModuli)
    (hStable : stableReductionOverNonarchimedean)
    (hTorsion : torsion23RationalOverF) :
    ThetaCurveModuliData Fmod F where
  xF := PuncturedEllipticCurve.ofJ F (37 : F)
  cF := cF
  cF_is_quotient_by_neg_one := cF_is_quotient_by_neg_one
  cF_is_quotient_by_neg_one_holds := hQuotient
  fmod_is_fieldOfModuli := fmod_is_fieldOfModuli
  fmod_is_fieldOfModuli_holds := hFmod
  stableReductionOverNonarchimedean := stableReductionOverNonarchimedean
  stableReductionOverNonarchimedean_holds := hStable
  torsion23RationalOverF := torsion23RationalOverF
  torsion23RationalOverF_holds := hTorsion

/-- A constructor smoke test for the `C_K`/`X_K` cover data. -/
def abstractThetaOrbicurveCoverData
    (curveModuli : ThetaCurveModuliData Fmod F)
    (cK xK : HyperbolicOrbicurveModel K)
    (cK_type : OrbicurveTypeData primeFive cK OrbicurveTypeKind.oneLTorsPM)
    (xK_type : OrbicurveTypeData primeFive xK OrbicurveTypeKind.oneLTors)
    (cK_core_is_baseChange_cF cK_determined_by_cF finiteEtaleCoveringDiagrams
      profiniteGroupOpenImmersions : Prop)
    (hCore : cK_core_is_baseChange_cF)
    (hDetermined : cK_determined_by_cF)
    (hEtale : finiteEtaleCoveringDiagrams)
    (hOpen : profiniteGroupOpenImmersions) :
    ThetaOrbicurveCoverData primeFive Fmod F K curveModuli where
  cK := cK
  xK := xK
  cK_type := cK_type
  cK_core_is_baseChange_cF := cK_core_is_baseChange_cF
  cK_core_is_baseChange_cF_holds := hCore
  cK_determined_by_cF := cK_determined_by_cF
  cK_determined_by_cF_holds := hDetermined
  xK_type := xK_type
  finiteEtaleCoveringDiagrams := finiteEtaleCoveringDiagrams
  finiteEtaleCoveringDiagrams_holds := hEtale
  profiniteGroupOpenImmersions := profiniteGroupOpenImmersions
  profiniteGroupOpenImmersions_holds := hOpen

/-- A constructor smoke test for bad local finite-place data. -/
def abstractThetaBadLocalData
    (curveModuli : ThetaCurveModuliData Fmod F)
    (coverData : ThetaOrbicurveCoverData primeFive Fmod F K curveModuli)
    (valuations : ThetaValuationData primeFive Fmod K)
    (localX :
      (v : NumberField.FinitePlace K) -> v ∈ valuations.selected ->
        HyperbolicOrbicurveModel (v.maximalIdeal.adicCompletion K))
    (localC :
      (v : NumberField.FinitePlace K) -> v ∈ valuations.selected ->
        HyperbolicOrbicurveModel (v.maximalIdeal.adicCompletion K))
    (localBaseChangeDiagrams
      decompositionGroupOuterSurjection :
      (v : NumberField.FinitePlace K) -> v ∈ valuations.selected -> Prop)
    (badLocalCType :
      (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.bad) ->
        OrbicurveTypeData primeFive (localC v hv.1) OrbicurveTypeKind.oneZModLPM)
    (thetaRootLocalXType :
      (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.bad) ->
        OrbicurveTypeData primeFive (localX v hv.1) OrbicurveTypeKind.oneZModLTheta)
    (thetaRootLocalCType :
      (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.bad) ->
        OrbicurveTypeData primeFive (localC v hv.1) OrbicurveTypeKind.oneZModLThetaPM)
    (thetaRootLocalModels badLocalOpenSubgroups :
      (v : NumberField.FinitePlace K) -> v ∈ valuations.bad -> Prop)
    (hBaseChange : ∀ v hv, localBaseChangeDiagrams v hv)
    (hDecomp : ∀ v hv, decompositionGroupOuterSurjection v hv)
    (hThetaRoot : ∀ v hv, thetaRootLocalModels v hv)
    (hOpen : ∀ v hv, badLocalOpenSubgroups v hv) :
    ThetaBadLocalData primeFive Fmod F K curveModuli coverData valuations where
  localX := localX
  localC := localC
  localBaseChangeDiagrams := localBaseChangeDiagrams
  localBaseChangeDiagrams_holds := hBaseChange
  decompositionGroupOuterSurjection := decompositionGroupOuterSurjection
  decompositionGroupOuterSurjection_holds := hDecomp
  badLocalCType := badLocalCType
  thetaRootLocalXType := thetaRootLocalXType
  thetaRootLocalCType := thetaRootLocalCType
  thetaRootLocalModels := thetaRootLocalModels
  thetaRootLocalModels_holds := hThetaRoot
  badLocalOpenSubgroups := badLocalOpenSubgroups
  badLocalOpenSubgroups_holds := hOpen

/-- A constructor smoke test for the local cusp data of Definition 3.1(f). -/
def abstractThetaCuspLocalData
    (curveModuli : ThetaCurveModuliData Fmod F)
    (coverData : ThetaOrbicurveCoverData primeFive Fmod F K curveModuli)
    (valuations : ThetaValuationData primeFive Fmod K)
    (badLocalData :
      ThetaBadLocalData primeFive Fmod F K curveModuli coverData valuations)
    (epsilon : CuspData coverData.cK)
    (localCusp :
      (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.selected) ->
        CuspData (badLocalData.localC v hv))
    (localCusp_determinedByGlobal :
      (v : NumberField.FinitePlace K) -> (hv : v ∈ valuations.selected) -> Prop)
    (badLocalCanonicalGenerator :
      (v : NumberField.FinitePlace K) -> v ∈ valuations.bad ->
        CanonicalGeneratorUpToSignElement)
    (hDetermined : ∀ v hv, localCusp_determinedByGlobal v hv) :
    ThetaCuspLocalData primeFive Fmod F K curveModuli coverData valuations
      badLocalData epsilon where
  localCusp := localCusp
  localCusp_determinedByGlobal := localCusp_determinedByGlobal
  localCusp_determinedByGlobal_holds := hDetermined
  badLocalCanonicalGenerator := badLocalCanonicalGenerator

/--
A constructor smoke test for full initial theta data under the exact field
hypotheses required by the record.
-/
noncomputable def abstractInitialThetaData
    (fieldTower : ThetaFieldTower primeFive Fmod F K)
    (curveModuli : ThetaCurveModuliData Fmod F)
    (coverData : ThetaOrbicurveCoverData primeFive Fmod F K curveModuli)
    (valuations : ThetaValuationData primeFive Fmod K)
    (badLocalData : ThetaBadLocalData primeFive Fmod F K curveModuli coverData valuations)
    (epsilon : CuspData coverData.cK)
    (cuspLocalData :
      ThetaCuspLocalData primeFive Fmod F K curveModuli coverData valuations
        badLocalData epsilon)
    (k_is_lTorsionKernelField lTorsionImageContainsSL2 qParameterOrdersPrimeToL : Prop)
    (hK : k_is_lTorsionKernelField)
    (hImage : lTorsionImageContainsSL2)
    (hQ : qParameterOrdersPrimeToL) :
    InitialThetaData Fmod F K where
  l := primeFive
  fieldTower := fieldTower
  curveModuli := curveModuli
  coverData := coverData
  k_is_lTorsionKernelField := k_is_lTorsionKernelField
  k_is_lTorsionKernelField_holds := hK
  valuations := valuations
  badLocalData := badLocalData
  epsilon := epsilon
  cuspLocalData := cuspLocalData
  lTorsionImageContainsSL2 := lTorsionImageContainsSL2
  lTorsionImageContainsSL2_holds := hImage
  qParameterOrdersPrimeToL := qParameterOrdersPrimeToL
  qParameterOrdersPrimeToL_holds := hQ

variable (theta : InitialThetaData Fmod F K)

example : Nat.Prime theta.l.value :=
  theta.prime_is_prime

example : 5 ≤ theta.l.value :=
  theta.prime_ge_five

example : ∃ v, v ∈ theta.valuations.bad :=
  theta.badValuations_nonempty

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    theta.badLocalData.localBaseChangeDiagrams v hv :=
  theta.localBaseChangeDiagrams v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    theta.badLocalData.decompositionGroupOuterSurjection v hv :=
  theta.decompositionGroupOuterSurjection v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalData.badLocalCType v hv).hasType :=
  theta.badLocalType v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalData.thetaRootLocalXType v hv).hasType :=
  theta.thetaRootLocalXType v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.badLocalData.thetaRootLocalCType v hv).hasType :=
  theta.thetaRootLocalCType v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    theta.badLocalData.thetaRootLocalModels v hv :=
  theta.thetaRootLocalModels v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    theta.badLocalData.badLocalOpenSubgroups v hv :=
  theta.badLocalOpenSubgroups v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    theta.cuspLocalData.localCusp_determinedByGlobal v hv :=
  theta.localCuspDeterminedByGlobal v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.selected) :
    (theta.localCusp v hv).arisesFromNonzeroQuotientElement :=
  theta.localCusp_arisesFromNonzeroQuotientElement v hv

example (v : NumberField.FinitePlace K) (hv : v ∈ theta.valuations.bad) :
    (theta.cuspLocalData.badLocalCanonicalGenerator v hv).canonicalGeneratorUpToSign :=
  theta.badLocalCusp_arisesFromCanonicalGenerator v hv

example (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ theta.valuations.vnon ↔
      v ∈ theta.valuations.selected :=
  theta.finitePlace_mem_vnon_iff v

example (v : NumberField.InfinitePlace K) :
    ThetaPlace.infinite v ∈ theta.valuations.varc ↔
      v ∈ theta.valuations.selectedInfinite :=
  theta.infinitePlace_mem_varc_iff v

example (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ theta.valuations.vbad ↔
      v ∈ theta.valuations.bad :=
  theta.finitePlace_mem_vbad_iff v

example (v : NumberField.FinitePlace K) :
    ThetaPlace.finite v ∈ theta.valuations.vgood ↔
      v ∈ theta.valuations.good :=
  theta.finitePlace_mem_vgood_iff v

example : Nat.Coprime (Module.finrank Fmod F) theta.l.value :=
  theta.degree_F_over_Fmod_prime_to_l

example :
    theta.fieldTower.sqrtMinusOne.element ^ 2 = (-1 : F) :=
  theta.sqrtMinusOne_square

example : theta.curveModuli.cF_is_quotient_by_neg_one :=
  theta.quotientByNegOne

example : theta.curveModuli.fmod_is_fieldOfModuli :=
  theta.fmodFieldOfModuli

example : theta.curveModuli.stableReductionOverNonarchimedean :=
  theta.stableReductionOverNonarchimedean

example : theta.curveModuli.torsion23RationalOverF :=
  theta.torsion23RationalOverF

example : theta.coverData.cK_type.hasType :=
  theta.cKType

example : theta.coverData.cK_core_is_baseChange_cF :=
  theta.cKCoreBaseChange

example : theta.coverData.cK_determined_by_cF :=
  theta.cKDeterminedByCF

example : theta.coverData.xK_type.hasType :=
  theta.xKType

example : theta.coverData.finiteEtaleCoveringDiagrams :=
  theta.finiteEtaleCoveringDiagrams

example : theta.coverData.profiniteGroupOpenImmersions :=
  theta.profiniteGroupOpenImmersions

example : theta.k_is_lTorsionKernelField :=
  theta.kIsLTorsionKernelField

example (j : F) :
    (PuncturedEllipticCurve.ofJ F j).jInvariant = j :=
  PuncturedEllipticCurve.jInvariant_ofJ F j

end AbstractConstructor

end InitialThetaDataExample

end Iut
