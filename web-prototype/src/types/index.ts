// Types matching the iOS Swift models

export enum CertificationLevel {
  EMR = 'EMR',
  EMT = 'EMT',
  AEMT = 'AEMT',
  Paramedic = 'Paramedic'
}

export const certificationLevelInfo = {
  [CertificationLevel.EMR]: {
    displayName: 'Emergency Medical Responder',
    color: '#34C759',
    skillLevel: 1
  },
  [CertificationLevel.EMT]: {
    displayName: 'Emergency Medical Technician',
    color: '#007AFF',
    skillLevel: 2
  },
  [CertificationLevel.AEMT]: {
    displayName: 'Advanced EMT',
    color: '#FFD60A',
    skillLevel: 3
  },
  [CertificationLevel.Paramedic]: {
    displayName: 'Paramedic',
    color: '#FF3B30',
    skillLevel: 4
  }
}

export enum ProtocolCategory {
  Cardiac = 'Cardiac',
  Respiratory = 'Respiratory',
  Trauma = 'Trauma',
  Medical = 'Medical',
  Pediatric = 'Pediatric',
  Obstetric = 'Obstetric',
  Environmental = 'Environmental',
  Toxicological = 'Toxicological',
  Behavioral = 'Behavioral',
  General = 'General Patient Care'
}

export enum StepType {
  Assessment = 'Assessment',
  Intervention = 'Intervention',
  Medication = 'Medication',
  Decision = 'Decision',
  Transport = 'Transport',
  Documentation = 'Documentation'
}

export interface StepCondition {
  condition: string
  targetStepId: string
}

export interface FlowchartStep {
  id: string
  order: number
  stepType: StepType
  content: string
  certificationLevel: CertificationLevel
  nextSteps: string[]
  isConditional: boolean
  conditions: StepCondition[]
}

export interface EducationalPoint {
  id: string
  title: string
  content: string
  references: string[]
  mediaUrls: string[]
}

export interface EMSProtocol {
  id: string
  title: string
  category: ProtocolCategory
  certificationLevel: CertificationLevel
  flowchartSteps: FlowchartStep[]
  detailedDescription: string
  educationalPoints: EducationalPoint[]
  relatedProcedures: string[]
  relatedMedications: string[]
  stateSpecificNotes: Record<string, string>
  lastUpdated: string
  version: string
}

export enum MedicationClass {
  Analgesic = 'Analgesic',
  Antiarrhythmic = 'Antiarrhythmic',
  Anticonvulsant = 'Anticonvulsant',
  Antiemetic = 'Antiemetic',
  Antiplatelet = 'Antiplatelet',
  Bronchodilator = 'Bronchodilator',
  Cardiovascular = 'Cardiovascular',
  Sedative = 'Sedative/Hypnotic',
  Paralytic = 'Paralytic',
  Vasopressor = 'Vasopressor',
  Antidote = 'Antidote',
  Electrolyte = 'Electrolyte',
  Other = 'Other'
}

export enum AgeGroup {
  Neonate = 'Neonate',
  Infant = 'Infant',
  Child = 'Child',
  Adolescent = 'Adolescent',
  Adult = 'Adult',
  Geriatric = 'Geriatric'
}

export enum DoseType {
  Initial = 'Initial Dose',
  Repeat = 'Repeat Dose',
  Maintenance = 'Maintenance',
  Loading = 'Loading Dose'
}

export enum DoseUnit {
  Mg = 'mg',
  Mcg = 'mcg',
  G = 'g',
  MgPerKg = 'mg/kg',
  McgPerKg = 'mcg/kg',
  Units = 'units',
  MEq = 'mEq',
  Ml = 'mL'
}

export enum AdministrationRoute {
  IV = 'Intravenous (IV)',
  IO = 'Intraosseous (IO)',
  IM = 'Intramuscular (IM)',
  SQ = 'Subcutaneous (SQ)',
  PO = 'Oral (PO)',
  SL = 'Sublingual (SL)',
  IN = 'Intranasal (IN)',
  ET = 'Endotracheal (ET)',
  Nebulized = 'Nebulized',
  Topical = 'Topical'
}

export interface DosingProtocol {
  id: string
  indication: string
  patientAgeGroup: AgeGroup
  doseType: DoseType
  amount: number
  unit: DoseUnit
  maxDose?: number
  weightBased: boolean
  instructions: string
}

export interface Medication {
  id: string
  name: string
  genericName: string
  brandNames: string[]
  classification: MedicationClass
  certificationLevel: CertificationLevel
  indications: string[]
  contraindications: string[]
  precautions: string[]
  adverseEffects: string[]
  dosing: DosingProtocol[]
  routes: AdministrationRoute[]
  onset: string
  duration: string
  mechanismOfAction: string
  stateSpecificNotes: Record<string, string>
}

export enum ProcedureCategory {
  Airway = 'Airway Management',
  Breathing = 'Breathing Support',
  Circulation = 'Circulation Support',
  IVAccess = 'IV/IO Access',
  Assessment = 'Assessment',
  Trauma = 'Trauma Care',
  Cardiac = 'Cardiac Interventions',
  Obstetric = 'Obstetric Procedures',
  Other = 'Other'
}

export interface ProcedureStep {
  id: string
  order: number
  instruction: string
  criticalPoint: boolean
  imageUrl?: string
}

export interface Procedure {
  id: string
  name: string
  category: ProcedureCategory
  certificationLevel: CertificationLevel
  indications: string[]
  contraindications: string[]
  equipment: string[]
  steps: ProcedureStep[]
  complications: string[]
  precautions: string[]
  educationalPoints: EducationalPoint[]
  videoUrls: string[]
  imageUrls: string[]
  stateSpecificNotes: Record<string, string>
}

export enum UserRole {
  Editor = 'Editor',
  RegularUser = 'Regular User'
}

export enum WeightUnit {
  Kg = 'kg',
  Lbs = 'lbs'
}

export interface User {
  id: string
  username: string
  email: string
  role: UserRole
  certificationLevel: CertificationLevel
  state: string
  agency: string
  preferredWeightUnit: WeightUnit
  createdAt: string
  lastLogin?: string
}

export interface DoseCalculation {
  id: string
  medication: string
  dose: number
  unit: DoseUnit
  patientWeight: number
  weightUnit: WeightUnit
  instructions: string
  maxDose?: number
  isMaxDoseReached: boolean
}
