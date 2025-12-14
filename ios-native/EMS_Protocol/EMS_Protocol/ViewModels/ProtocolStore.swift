//
//  ProtocolStore.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import Foundation
import Combine

class ProtocolStore: ObservableObject {
    @Published var protocols: [EMSProtocol] = []
    @Published var medications: [Medication] = []
    @Published var procedures: [Procedure] = []
    @Published var selectedState: String = "National"
    @Published var searchQuery: String = ""

    init() {
        loadSampleData()
    }

    // MARK: - Protocol Methods

    func getProtocols(for category: ProtocolCategory? = nil, certificationLevel: CertificationLevel? = nil) -> [EMSProtocol] {
        var filtered = protocols

        if let category = category {
            filtered = filtered.filter { $0.category == category }
        }

        if let level = certificationLevel {
            filtered = filtered.filter { $0.certificationLevel.skillLevel <= level.skillLevel }
        }

        if !searchQuery.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchQuery) ||
                $0.detailedDescription.localizedCaseInsensitiveContains(searchQuery)
            }
        }

        return filtered.sorted { $0.title < $1.title }
    }

    func addProtocol(_ protocol: EMSProtocol) {
        protocols.append(`protocol`)
        saveData()
    }

    func updateProtocol(_ protocol: EMSProtocol) {
        if let index = protocols.firstIndex(where: { $0.id == `protocol`.id }) {
            protocols[index] = `protocol`
            saveData()
        }
    }

    func deleteProtocol(_ protocol: EMSProtocol) {
        protocols.removeAll { $0.id == `protocol`.id }
        saveData()
    }

    // MARK: - Medication Methods

    func getMedications(for certificationLevel: CertificationLevel? = nil) -> [Medication] {
        var filtered = medications

        if let level = certificationLevel {
            filtered = filtered.filter { $0.certificationLevel.skillLevel <= level.skillLevel }
        }

        if !searchQuery.isEmpty {
            filtered = filtered.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery) ||
                $0.genericName.localizedCaseInsensitiveContains(searchQuery) ||
                $0.brandNames.contains { $0.localizedCaseInsensitiveContains(searchQuery) }
            }
        }

        return filtered.sorted { $0.name < $1.name }
    }

    func addMedication(_ medication: Medication) {
        medications.append(medication)
        saveData()
    }

    func updateMedication(_ medication: Medication) {
        if let index = medications.firstIndex(where: { $0.id == medication.id }) {
            medications[index] = medication
            saveData()
        }
    }

    func deleteMedication(_ medication: Medication) {
        medications.removeAll { $0.id == medication.id }
        saveData()
    }

    // MARK: - Procedure Methods

    func getProcedures(for category: ProcedureCategory? = nil, certificationLevel: CertificationLevel? = nil) -> [Procedure] {
        var filtered = procedures

        if let category = category {
            filtered = filtered.filter { $0.category == category }
        }

        if let level = certificationLevel {
            filtered = filtered.filter { $0.certificationLevel.skillLevel <= level.skillLevel }
        }

        if !searchQuery.isEmpty {
            filtered = filtered.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }

        return filtered.sorted { $0.name < $1.name }
    }

    func addProcedure(_ procedure: Procedure) {
        procedures.append(procedure)
        saveData()
    }

    func updateProcedure(_ procedure: Procedure) {
        if let index = procedures.firstIndex(where: { $0.id == procedure.id }) {
            procedures[index] = procedure
            saveData()
        }
    }

    func deleteProcedure(_ procedure: Procedure) {
        procedures.removeAll { $0.id == procedure.id }
        saveData()
    }

    // MARK: - Data Persistence

    private func saveData() {
        // TODO: Implement proper data persistence (CoreData, CloudKit, etc.)
        // For now, this is a placeholder
    }

    private func loadSampleData() {
        // Load sample protocols from SampleData
        protocols = SampleData.sampleProtocols
        medications = SampleData.sampleMedications
        procedures = SampleData.sampleProcedures
    }
}
