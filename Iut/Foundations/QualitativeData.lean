/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.TransportedRegionFamily

/-!
Structured but inert qualitative data for algorithmic outputs.

These records give more shape to the names IPL, SHE, and APT without assigning
any mathematical consequences to them. They are bookkeeping objects; bridge
theorems must still be supplied separately.
-/

namespace Iut
namespace RealLineCopy

namespace QualitativeData

variable {source target : Copy} {index : Type u}

/-- Inert identifier for a prime strip or prime-strip-like bookkeeping object. -/
structure PrimeStripId where
  label : String

/-- Which side of a Hodge-theater comparison an identifier belongs to. -/
inductive HodgeTheaterSide where
  | domain
  | codomain
  | intermediate
deriving DecidableEq, Repr

/-- Inert identifier for a Hodge theater in the qualitative bookkeeping layer. -/
structure HodgeTheaterId where
  side : HodgeTheaterSide
  label : String

/-- Inert identifier for a language/common-expression context. -/
structure CommonLanguageId where
  label : String

/-- Inert identifier for an APT-style construction mechanism. -/
structure TransportMechanismId where
  label : String

/-- Inert relation record for an IPL-style link between prime strips. -/
structure PrimeStripLink where
  source : PrimeStripId
  target : PrimeStripId
  linkLabel : String

/-- Inert record for input-prime-strip-link style data. -/
structure IPLDatum (family : TransportedRegionFamily source target index) where
  inputPrimeStrip : PrimeStripId
  outputPrimeStrip : PrimeStripId
  choicePrimeStrip : index -> PrimeStripId
  link : PrimeStripLink

/-- A named arithmetic holomorphic structure in the toy bookkeeping layer. -/
structure HolomorphicStructure where
  theater : HodgeTheaterId
  structureLabel : String

/-- Inert relation record for simultaneous expression in a common context. -/
structure SharedHolomorphicContext where
  domainStructure : HolomorphicStructure
  codomainStructure : HolomorphicStructure
  commonLanguage : CommonLanguageId

/-- Inert record for simultaneous-holomorphic-expressibility style data. -/
structure SHEDatum (family : TransportedRegionFamily source target index) where
  sharedContext : SharedHolomorphicContext

/-- Inert record for algorithmic-parallel-transport style data. -/
structure APTDatum (family : TransportedRegionFamily source target index) where
  mechanism : TransportMechanismId
  outputFamily : TransportedRegionFamily source target index
  output_eq_family : outputFamily = family

def HasStructuredIPL (family : TransportedRegionFamily source target index) : Prop :=
  Nonempty (IPLDatum family)

def HasStructuredSHE (family : TransportedRegionFamily source target index) : Prop :=
  Nonempty (SHEDatum family)

def HasStructuredAPT (family : TransportedRegionFamily source target index) : Prop :=
  Nonempty (APTDatum family)

/-- Structured evidence for all three qualitative properties of an output family. -/
structure StructuredCertificate (family : TransportedRegionFamily source target index) where
  ipl : IPLDatum family
  she : SHEDatum family
  apt : APTDatum family

namespace StructuredCertificate

variable {family : TransportedRegionFamily source target index}

theorem hasStructuredIPL (certificate : StructuredCertificate family) :
    HasStructuredIPL family :=
  ⟨certificate.ipl⟩

theorem hasStructuredSHE (certificate : StructuredCertificate family) :
    HasStructuredSHE family :=
  ⟨certificate.she⟩

theorem hasStructuredAPT (certificate : StructuredCertificate family) :
    HasStructuredAPT family :=
  ⟨certificate.apt⟩

end StructuredCertificate

theorem apt_output_eq_family {family : TransportedRegionFamily source target index}
    (hapt : HasStructuredAPT family) :
    ∃ datum : APTDatum family, datum.outputFamily = family := by
  rcases hapt with ⟨datum⟩
  exact ⟨datum, datum.output_eq_family⟩

end QualitativeData

end RealLineCopy
end Iut
