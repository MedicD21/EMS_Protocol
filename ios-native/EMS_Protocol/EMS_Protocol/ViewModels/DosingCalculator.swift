//
//  DosingCalculator.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import Foundation
import Combine

class DosingCalculator: ObservableObject {
    @Published var patientWeight: Double = 70.0 // Default 70kg
    @Published var weightUnit: WeightUnit = .kg
    @Published var ageGroup: AgeGroup = .adult

    // Computed property for weight in kg (for calculations)
    var weightInKg: Double {
        weightUnit.convert(patientWeight, to: .kg)
    }

    // Computed property for weight in lbs (for display)
    var weightInLbs: Double {
        weightUnit.convert(patientWeight, to: .lbs)
    }

    func calculateDose(for dosingProtocol: DosingProtocol) -> DoseCalculation {
        let dose = dosingProtocol.calculateDose(weight: weightInKg)

        return DoseCalculation(
            medication: "",
            dose: dose,
            unit: dosingProtocol.unit,
            patientWeight: weightInKg,
            weightUnit: .kg,
            instructions: dosingProtocol.instructions,
            maxDose: dosingProtocol.maxDose,
            isMaxDoseReached: dosingProtocol.maxDose.map { dose >= $0 } ?? false
        )
    }

    func calculateAllDoses(for medication: Medication) -> [DoseCalculation] {
        medication.dosing
            .filter { $0.patientAgeGroup == ageGroup }
            .map { dosingProtocol in
                let dose = dosingProtocol.calculateDose(weight: weightInKg)
                return DoseCalculation(
                    medication: medication.name,
                    dose: dose,
                    unit: dosingProtocol.unit,
                    patientWeight: weightInKg,
                    weightUnit: .kg,
                    instructions: dosingProtocol.instructions,
                    maxDose: dosingProtocol.maxDose,
                    isMaxDoseReached: dosingProtocol.maxDose.map { dose >= $0 } ?? false
                )
            }
    }

    func setWeight(_ weight: Double, unit: WeightUnit) {
        self.patientWeight = weight
        self.weightUnit = unit
    }

    func convertWeight(to targetUnit: WeightUnit) {
        patientWeight = weightUnit.convert(patientWeight, to: targetUnit)
        weightUnit = targetUnit
    }

    // Preset weights for common age groups
    func applyPresetWeight(for ageGroup: AgeGroup) {
        self.ageGroup = ageGroup
        switch ageGroup {
        case .neonate:
            setWeight(3.5, unit: .kg)
        case .infant:
            setWeight(7.0, unit: .kg)
        case .child:
            setWeight(20.0, unit: .kg)
        case .adolescent:
            setWeight(50.0, unit: .kg)
        case .adult:
            setWeight(70.0, unit: .kg)
        case .geriatric:
            setWeight(70.0, unit: .kg)
        }
    }
}

struct DoseCalculation: Identifiable {
    let id = UUID()
    let medication: String
    let dose: Double
    let unit: DoseUnit
    let patientWeight: Double
    let weightUnit: WeightUnit
    let instructions: String
    let maxDose: Double?
    let isMaxDoseReached: Bool

    var formattedDose: String {
        String(format: "%.2f %@", dose, unit.rawValue)
    }

    var warning: String? {
        if isMaxDoseReached {
            return "Maximum dose reached"
        }
        return nil
    }
}
