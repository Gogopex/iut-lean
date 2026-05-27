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

/-- Inert record for input-prime-strip-link style data. -/
structure IPLDatum (family : TransportedRegionFamily source target index) where
  inputLabel : String
  outputLabel : String
  choiceLabel : index -> String

/-- A named arithmetic holomorphic structure in the toy bookkeeping layer. -/
structure HolomorphicStructure where
  label : String

/-- Inert record for simultaneous-holomorphic-expressibility style data. -/
structure SHEDatum (family : TransportedRegionFamily source target index) where
  domainStructure : HolomorphicStructure
  codomainStructure : HolomorphicStructure
  commonLanguage : String

/-- Inert record for algorithmic-parallel-transport style data. -/
structure APTDatum (family : TransportedRegionFamily source target index) where
  mechanismLabel : String
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
