//
//  Procedure.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import Foundation

struct Procedure: Identifiable, Codable {
    let id: UUID
    var name: String
    var category: ProcedureCategory
    var certificationLevel: CertificationLevel
    var indications: [String]
    var contraindications: [String]
    var equipment: [String]
    var steps: [ProcedureStep]
    var complications: [String]
    var precautions: [String]
    var educationalPoints: [EducationalPoint]
    var videoUrls: [String]
    var imageUrls: [String]
    var stateSpecificNotes: [String: String]

    init(
        id: UUID = UUID(),
        name: String,
        category: ProcedureCategory,
        certificationLevel: CertificationLevel,
        indications: [String],
        contraindications: [String],
        equipment: [String],
        steps: [ProcedureStep],
        complications: [String],
        precautions: [String],
        educationalPoints: [EducationalPoint] = [],
        videoUrls: [String] = [],
        imageUrls: [String] = [],
        stateSpecificNotes: [String: String] = [:]
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.certificationLevel = certificationLevel
        self.indications = indications
        self.contraindications = contraindications
        self.equipment = equipment
        self.steps = steps
        self.complications = complications
        self.precautions = precautions
        self.educationalPoints = educationalPoints
        self.videoUrls = videoUrls
        self.imageUrls = imageUrls
        self.stateSpecificNotes = stateSpecificNotes
    }
}

enum ProcedureCategory: String, Codable, CaseIterable {
    case airway = "Airway Management"
    case breathing = "Breathing Support"
    case circulation = "Circulation Support"
    case ivAccess = "IV/IO Access"
    case assessment = "Assessment"
    case trauma = "Trauma Care"
    case cardiac = "Cardiac Interventions"
    case obstetric = "Obstetric Procedures"
    case other = "Other"
}

struct ProcedureStep: Identifiable, Codable {
    let id: UUID
    var order: Int
    var instruction: String
    var criticalPoint: Bool
    var imageUrl: String?

    init(
        id: UUID = UUID(),
        order: Int,
        instruction: String,
        criticalPoint: Bool = false,
        imageUrl: String? = nil
    ) {
        self.id = id
        self.order = order
        self.instruction = instruction
        self.criticalPoint = criticalPoint
        self.imageUrl = imageUrl
    }
}
