//
//  Protocol.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import Foundation

struct EMSProtocol: Identifiable, Codable {
    let id: UUID
    var title: String
    var category: ProtocolCategory
    var certificationLevel: CertificationLevel
    var flowchartSteps: [FlowchartStep]
    var detailedDescription: String
    var educationalPoints: [EducationalPoint]
    var relatedProcedures: [String] // IDs of related procedures
    var relatedMedications: [String] // IDs of related medications
    var stateSpecificNotes: [String: String] // State code: specific notes
    var lastUpdated: Date
    var version: String

    init(
        id: UUID = UUID(),
        title: String,
        category: ProtocolCategory,
        certificationLevel: CertificationLevel,
        flowchartSteps: [FlowchartStep],
        detailedDescription: String,
        educationalPoints: [EducationalPoint],
        relatedProcedures: [String] = [],
        relatedMedications: [String] = [],
        stateSpecificNotes: [String: String] = [:],
        lastUpdated: Date = Date(),
        version: String = "1.0"
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.certificationLevel = certificationLevel
        self.flowchartSteps = flowchartSteps
        self.detailedDescription = detailedDescription
        self.educationalPoints = educationalPoints
        self.relatedProcedures = relatedProcedures
        self.relatedMedications = relatedMedications
        self.stateSpecificNotes = stateSpecificNotes
        self.lastUpdated = lastUpdated
        self.version = version
    }
}

enum ProtocolCategory: String, Codable, CaseIterable {
    case cardiac = "Cardiac"
    case respiratory = "Respiratory"
    case trauma = "Trauma"
    case medical = "Medical"
    case pediatric = "Pediatric"
    case obstetric = "Obstetric"
    case environmental = "Environmental"
    case toxicological = "Toxicological"
    case behavioral = "Behavioral"
    case general = "General Patient Care"
}

struct FlowchartStep: Identifiable, Codable {
    let id: UUID
    var order: Int
    var stepType: StepType
    var content: String
    var certificationLevel: CertificationLevel
    var nextSteps: [String] // IDs of next steps (for conditional branching)
    var isConditional: Bool
    var conditions: [StepCondition]

    init(
        id: UUID = UUID(),
        order: Int,
        stepType: StepType,
        content: String,
        certificationLevel: CertificationLevel,
        nextSteps: [String] = [],
        isConditional: Bool = false,
        conditions: [StepCondition] = []
    ) {
        self.id = id
        self.order = order
        self.stepType = stepType
        self.content = content
        self.certificationLevel = certificationLevel
        self.nextSteps = nextSteps
        self.isConditional = isConditional
        self.conditions = conditions
    }
}

enum StepType: String, Codable {
    case assessment = "Assessment"
    case intervention = "Intervention"
    case medication = "Medication"
    case decision = "Decision"
    case transport = "Transport"
    case documentation = "Documentation"
}

struct StepCondition: Codable {
    var condition: String
    var targetStepId: String
}

struct EducationalPoint: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var references: [String]
    var mediaUrls: [String]

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        references: [String] = [],
        mediaUrls: [String] = []
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.references = references
        self.mediaUrls = mediaUrls
    }
}
