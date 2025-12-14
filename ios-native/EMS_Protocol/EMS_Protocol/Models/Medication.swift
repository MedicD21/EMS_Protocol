//
//  Medication.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import Foundation

struct Medication: Identifiable, Codable {
    let id: UUID
    var name: String
    var genericName: String
    var brandNames: [String]
    var classification: MedicationClass
    var certificationLevel: CertificationLevel
    var indications: [String]
    var contraindications: [String]
    var precautions: [String]
    var adverseEffects: [String]
    var dosing: [DosingProtocol]
    var routes: [AdministrationRoute]
    var onset: String
    var duration: String
    var mechanismOfAction: String
    var stateSpecificNotes: [String: String]

    init(
        id: UUID = UUID(),
        name: String,
        genericName: String,
        brandNames: [String] = [],
        classification: MedicationClass,
        certificationLevel: CertificationLevel,
        indications: [String],
        contraindications: [String],
        precautions: [String],
        adverseEffects: [String],
        dosing: [DosingProtocol],
        routes: [AdministrationRoute],
        onset: String,
        duration: String,
        mechanismOfAction: String,
        stateSpecificNotes: [String: String] = [:]
    ) {
        self.id = id
        self.name = name
        self.genericName = genericName
        self.brandNames = brandNames
        self.classification = classification
        self.certificationLevel = certificationLevel
        self.indications = indications
        self.contraindications = contraindications
        self.precautions = precautions
        self.adverseEffects = adverseEffects
        self.dosing = dosing
        self.routes = routes
        self.onset = onset
        self.duration = duration
        self.mechanismOfAction = mechanismOfAction
        self.stateSpecificNotes = stateSpecificNotes
    }
}

enum MedicationClass: String, Codable, CaseIterable {
    case analgesic = "Analgesic"
    case antiarrhythmic = "Antiarrhythmic"
    case anticonvulsant = "Anticonvulsant"
    case antiemetic = "Antiemetic"
    case antiplatelet = "Antiplatelet"
    case bronchodilator = "Bronchodilator"
    case cardiovascular = "Cardiovascular"
    case sedative = "Sedative/Hypnotic"
    case paralytic = "Paralytic"
    case vasopressor = "Vasopressor"
    case antidote = "Antidote"
    case electrolyte = "Electrolyte"
    case other = "Other"
}

struct DosingProtocol: Identifiable, Codable {
    let id: UUID
    var indication: String
    var patientAgeGroup: AgeGroup
    var doseType: DoseType
    var amount: Double
    var unit: DoseUnit
    var maxDose: Double?
    var weightBased: Bool
    var instructions: String

    init(
        id: UUID = UUID(),
        indication: String,
        patientAgeGroup: AgeGroup,
        doseType: DoseType,
        amount: Double,
        unit: DoseUnit,
        maxDose: Double? = nil,
        weightBased: Bool = false,
        instructions: String
    ) {
        self.id = id
        self.indication = indication
        self.patientAgeGroup = patientAgeGroup
        self.doseType = doseType
        self.amount = amount
        self.unit = unit
        self.maxDose = maxDose
        self.weightBased = weightBased
        self.instructions = instructions
    }

    func calculateDose(weight: Double) -> Double {
        if weightBased {
            let calculatedDose = amount * weight
            if let max = maxDose {
                return min(calculatedDose, max)
            }
            return calculatedDose
        }
        return amount
    }
}

enum AgeGroup: String, Codable, CaseIterable {
    case neonate = "Neonate"
    case infant = "Infant"
    case child = "Child"
    case adolescent = "Adolescent"
    case adult = "Adult"
    case geriatric = "Geriatric"
}

enum DoseType: String, Codable {
    case initial = "Initial Dose"
    case repeat = "Repeat Dose"
    case maintenance = "Maintenance"
    case loading = "Loading Dose"
}

enum DoseUnit: String, Codable {
    case mg = "mg"
    case mcg = "mcg"
    case g = "g"
    case mgPerKg = "mg/kg"
    case mcgPerKg = "mcg/kg"
    case units = "units"
    case mEq = "mEq"
    case ml = "mL"
}

enum AdministrationRoute: String, Codable {
    case iv = "Intravenous (IV)"
    case io = "Intraosseous (IO)"
    case im = "Intramuscular (IM)"
    case sq = "Subcutaneous (SQ)"
    case po = "Oral (PO)"
    case sl = "Sublingual (SL)"
    case in_ = "Intranasal (IN)"
    case et = "Endotracheal (ET)"
    case nebulized = "Nebulized"
    case topical = "Topical"
}
