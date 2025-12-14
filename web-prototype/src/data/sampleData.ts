// Sample data based on National Model EMS Clinical Guidelines
// Matches the iOS Swift implementation

import {
  EMSProtocol,
  Medication,
  Procedure,
  ProtocolCategory,
  CertificationLevel,
  StepType,
  MedicationClass,
  DoseType,
  DoseUnit,
  AgeGroup,
  AdministrationRoute,
  ProcedureCategory
} from '../types'

export const sampleProtocols: EMSProtocol[] = [
  // Cardiac Arrest Protocol
  {
    id: 'protocol-cardiac-arrest-adult',
    title: 'Cardiac Arrest - Adult',
    category: ProtocolCategory.Cardiac,
    certificationLevel: CertificationLevel.EMT,
    flowchartSteps: [
      {
        id: 'step-1',
        order: 1,
        stepType: StepType.Assessment,
        content: 'Verify cardiac arrest: Check for unresponsiveness and absence of normal breathing',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['step-2'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-2',
        order: 2,
        stepType: StepType.Intervention,
        content: 'Begin high-quality CPR: 30 compressions to 2 ventilations, minimize interruptions',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['step-3'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-3',
        order: 3,
        stepType: StepType.Intervention,
        content: 'Apply AED/Monitor as soon as available. Analyze rhythm.',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['step-4'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-4',
        order: 4,
        stepType: StepType.Decision,
        content: 'Is rhythm shockable (VF/pVT)?',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['step-5', 'step-6'],
        isConditional: true,
        conditions: [
          { condition: 'Shockable', targetStepId: 'step-5' },
          { condition: 'Non-shockable', targetStepId: 'step-6' }
        ]
      },
      {
        id: 'step-5',
        order: 5,
        stepType: StepType.Intervention,
        content: 'If shockable: Deliver shock, immediately resume CPR for 2 minutes',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['step-6'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-6',
        order: 6,
        stepType: StepType.Intervention,
        content: 'Establish IV/IO access',
        certificationLevel: CertificationLevel.AEMT,
        nextSteps: ['step-7'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-7',
        order: 7,
        stepType: StepType.Medication,
        content: 'Epinephrine 1 mg IV/IO every 3-5 minutes',
        certificationLevel: CertificationLevel.AEMT,
        nextSteps: ['step-8'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-8',
        order: 8,
        stepType: StepType.Intervention,
        content: 'Consider advanced airway if trained (supraglottic airway or endotracheal intubation)',
        certificationLevel: CertificationLevel.Paramedic,
        nextSteps: ['step-9'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-9',
        order: 9,
        stepType: StepType.Medication,
        content: 'For VF/pVT: Consider Amiodarone 300 mg IV/IO after 3rd shock',
        certificationLevel: CertificationLevel.Paramedic,
        nextSteps: ['step-10'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'step-10',
        order: 10,
        stepType: StepType.Assessment,
        content: "Treat reversible causes (H's and T's): Hypovolemia, Hypoxia, Hydrogen ion (acidosis), Hypo/hyperkalemia, Hypothermia, Tension pneumothorax, Tamponade, Toxins, Thrombosis",
        certificationLevel: CertificationLevel.Paramedic,
        nextSteps: [],
        isConditional: false,
        conditions: []
      }
    ],
    detailedDescription: 'Adult cardiac arrest protocol following current AHA/ERC guidelines with emphasis on high-quality CPR and early defibrillation.',
    educationalPoints: [
      {
        id: 'edu-1',
        title: 'High-Quality CPR',
        content: 'Compression rate: 100-120/min, Depth: At least 2 inches (5 cm), Allow full chest recoil, Minimize interruptions (<10 seconds)',
        references: ['AHA Guidelines 2020', 'National Model EMS Clinical Guidelines'],
        mediaUrls: []
      },
      {
        id: 'edu-2',
        title: 'Reversible Causes',
        content: "Remember H's and T's to systematically identify and treat reversible causes of cardiac arrest",
        references: ['ACLS Provider Manual'],
        mediaUrls: []
      }
    ],
    relatedProcedures: [],
    relatedMedications: ['med-epinephrine', 'med-amiodarone'],
    stateSpecificNotes: {},
    lastUpdated: new Date().toISOString(),
    version: '1.0'
  },

  // Chest Pain Protocol
  {
    id: 'protocol-chest-pain',
    title: 'Acute Coronary Syndrome / Chest Pain',
    category: ProtocolCategory.Cardiac,
    certificationLevel: CertificationLevel.EMT,
    flowchartSteps: [
      {
        id: 'cp-step-1',
        order: 1,
        stepType: StepType.Assessment,
        content: 'Assess chest pain using OPQRST, obtain vital signs, 12-lead ECG within 10 minutes',
        certificationLevel: CertificationLevel.EMT,
        nextSteps: ['cp-step-2'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'cp-step-2',
        order: 2,
        stepType: StepType.Intervention,
        content: 'Place patient in position of comfort, administer oxygen if SpO2 < 94%',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['cp-step-3'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'cp-step-3',
        order: 3,
        stepType: StepType.Medication,
        content: 'Aspirin 324 mg PO (chewed) if no allergy or contraindications',
        certificationLevel: CertificationLevel.EMT,
        nextSteps: ['cp-step-4'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'cp-step-4',
        order: 4,
        stepType: StepType.Medication,
        content: 'Nitroglycerin 0.4 mg SL every 5 minutes (max 3 doses) if SBP > 100 mmHg',
        certificationLevel: CertificationLevel.EMT,
        nextSteps: ['cp-step-5'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'cp-step-5',
        order: 5,
        stepType: StepType.Intervention,
        content: 'Establish IV access, cardiac monitoring',
        certificationLevel: CertificationLevel.AEMT,
        nextSteps: ['cp-step-6'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'cp-step-6',
        order: 6,
        stepType: StepType.Medication,
        content: 'For pain: Morphine 2-4 mg IV/IO if no relief with nitrates',
        certificationLevel: CertificationLevel.Paramedic,
        nextSteps: ['cp-step-7'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'cp-step-7',
        order: 7,
        stepType: StepType.Transport,
        content: 'Transport to appropriate facility (STEMI receiving center if ECG shows STEMI)',
        certificationLevel: CertificationLevel.EMT,
        nextSteps: [],
        isConditional: false,
        conditions: []
      }
    ],
    detailedDescription: 'Management of patients with suspected acute coronary syndrome including STEMI, NSTEMI, and unstable angina.',
    educationalPoints: [
      {
        id: 'cp-edu-1',
        title: 'STEMI Criteria',
        content: 'ST elevation >1mm in 2 contiguous limb leads or >2mm in 2 contiguous chest leads',
        references: ['AHA STEMI Guidelines'],
        mediaUrls: []
      },
      {
        id: 'cp-edu-2',
        title: 'Time is Muscle',
        content: 'Door-to-balloon time goal is 90 minutes. EMS plays critical role in early ECG and destination selection',
        references: ['National Model EMS Clinical Guidelines'],
        mediaUrls: []
      }
    ],
    relatedProcedures: [],
    relatedMedications: ['med-aspirin', 'med-nitroglycerin', 'med-morphine'],
    stateSpecificNotes: {},
    lastUpdated: new Date().toISOString(),
    version: '1.0'
  },

  // Respiratory Distress Protocol
  {
    id: 'protocol-respiratory-distress',
    title: 'Respiratory Distress / Asthma / COPD',
    category: ProtocolCategory.Respiratory,
    certificationLevel: CertificationLevel.EMR,
    flowchartSteps: [
      {
        id: 'rd-step-1',
        order: 1,
        stepType: StepType.Assessment,
        content: 'Assess airway, breathing, circulation. Obtain vital signs, SpO2, lung sounds',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['rd-step-2'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'rd-step-2',
        order: 2,
        stepType: StepType.Intervention,
        content: 'Position patient upright, administer oxygen to maintain SpO2 94-98%',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['rd-step-3'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'rd-step-3',
        order: 3,
        stepType: StepType.Medication,
        content: 'Albuterol 2.5-5 mg via nebulizer or MDI with spacer',
        certificationLevel: CertificationLevel.EMT,
        nextSteps: ['rd-step-4'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'rd-step-4',
        order: 4,
        stepType: StepType.Medication,
        content: 'Ipratropium 0.5 mg via nebulizer (can combine with albuterol)',
        certificationLevel: CertificationLevel.EMT,
        nextSteps: ['rd-step-5'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'rd-step-5',
        order: 5,
        stepType: StepType.Medication,
        content: 'Consider CPAP if patient is tiring or inadequate response to medications',
        certificationLevel: CertificationLevel.AEMT,
        nextSteps: ['rd-step-6'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'rd-step-6',
        order: 6,
        stepType: StepType.Medication,
        content: 'For severe bronchospasm: Epinephrine 0.3 mg IM',
        certificationLevel: CertificationLevel.AEMT,
        nextSteps: ['rd-step-7'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'rd-step-7',
        order: 7,
        stepType: StepType.Intervention,
        content: 'If respiratory failure imminent: Prepare for advanced airway management',
        certificationLevel: CertificationLevel.Paramedic,
        nextSteps: [],
        isConditional: false,
        conditions: []
      }
    ],
    detailedDescription: 'Management of respiratory distress including asthma, COPD exacerbation, and other causes of difficulty breathing.',
    educationalPoints: [
      {
        id: 'rd-edu-1',
        title: 'CPAP Indications',
        content: 'CPAP can be beneficial in CHF, COPD, and asthma. Contraindications include inability to protect airway, facial trauma, hypotension',
        references: ['National Model EMS Clinical Guidelines'],
        mediaUrls: []
      }
    ],
    relatedProcedures: [],
    relatedMedications: ['med-albuterol', 'med-epinephrine'],
    stateSpecificNotes: {},
    lastUpdated: new Date().toISOString(),
    version: '1.0'
  },

  // Anaphylaxis Protocol
  {
    id: 'protocol-anaphylaxis',
    title: 'Anaphylaxis / Allergic Reaction',
    category: ProtocolCategory.Medical,
    certificationLevel: CertificationLevel.EMR,
    flowchartSteps: [
      {
        id: 'ana-step-1',
        order: 1,
        stepType: StepType.Assessment,
        content: 'Assess for signs of anaphylaxis: respiratory distress, hypotension, urticaria, angioedema',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['ana-step-2'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'ana-step-2',
        order: 2,
        stepType: StepType.Intervention,
        content: 'Remove allergen if possible, ensure airway patency, administer high-flow oxygen',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['ana-step-3'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'ana-step-3',
        order: 3,
        stepType: StepType.Medication,
        content: 'Epinephrine 0.3 mg (0.3 mL of 1:1000) IM lateral thigh - IMMEDIATELY for anaphylaxis',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['ana-step-4'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'ana-step-4',
        order: 4,
        stepType: StepType.Intervention,
        content: 'Place patient supine with legs elevated (if no respiratory distress)',
        certificationLevel: CertificationLevel.EMR,
        nextSteps: ['ana-step-5'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'ana-step-5',
        order: 5,
        stepType: StepType.Intervention,
        content: 'Establish IV/IO access, fluid resuscitation with NS if hypotensive',
        certificationLevel: CertificationLevel.AEMT,
        nextSteps: ['ana-step-6'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'ana-step-6',
        order: 6,
        stepType: StepType.Medication,
        content: 'Diphenhydramine 25-50 mg IV/IM',
        certificationLevel: CertificationLevel.AEMT,
        nextSteps: ['ana-step-7'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'ana-step-7',
        order: 7,
        stepType: StepType.Medication,
        content: 'Consider: Albuterol for bronchospasm, repeat epinephrine in 5-15 min if needed',
        certificationLevel: CertificationLevel.EMT,
        nextSteps: ['ana-step-8'],
        isConditional: false,
        conditions: []
      },
      {
        id: 'ana-step-8',
        order: 8,
        stepType: StepType.Medication,
        content: 'Severe cases: Epinephrine infusion 2-10 mcg/min titrated to effect',
        certificationLevel: CertificationLevel.Paramedic,
        nextSteps: [],
        isConditional: false,
        conditions: []
      }
    ],
    detailedDescription: 'Management of anaphylaxis and severe allergic reactions with emphasis on rapid epinephrine administration.',
    educationalPoints: [
      {
        id: 'ana-edu-1',
        title: 'Epinephrine is First-Line',
        content: 'Epinephrine is the ONLY first-line treatment for anaphylaxis. Do not delay for antihistamines or steroids.',
        references: ['World Allergy Organization Anaphylaxis Guidance'],
        mediaUrls: []
      },
      {
        id: 'ana-edu-2',
        title: 'Biphasic Reactions',
        content: '10-20% of anaphylaxis cases have biphasic reactions occurring 4-8 hours after initial presentation. All patients require hospital evaluation.',
        references: ['National Model EMS Clinical Guidelines'],
        mediaUrls: []
      }
    ],
    relatedProcedures: [],
    relatedMedications: ['med-epinephrine', 'med-albuterol'],
    stateSpecificNotes: {},
    lastUpdated: new Date().toISOString(),
    version: '1.0'
  }
]

export const sampleMedications: Medication[] = [
  // Epinephrine
  {
    id: 'med-epinephrine',
    name: 'Epinephrine',
    genericName: 'Epinephrine',
    brandNames: ['Adrenalin', 'EpiPen'],
    classification: MedicationClass.Vasopressor,
    certificationLevel: CertificationLevel.EMR,
    indications: [
      'Cardiac arrest',
      'Anaphylaxis',
      'Severe bronchospasm',
      'Bradycardia (when pacing unavailable)'
    ],
    contraindications: ['None in life-threatening situations'],
    precautions: [
      'May cause hypertension, tachycardia',
      'Use with caution in coronary artery disease',
      'May cause anxiety, tremors'
    ],
    adverseEffects: ['Tachycardia', 'Hypertension', 'Anxiety', 'Tremors', 'Pallor', 'Headache'],
    dosing: [
      {
        id: 'epi-dose-1',
        indication: 'Cardiac Arrest',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 1.0,
        unit: DoseUnit.Mg,
        weightBased: false,
        instructions: '1 mg IV/IO every 3-5 minutes'
      },
      {
        id: 'epi-dose-2',
        indication: 'Anaphylaxis',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 0.3,
        unit: DoseUnit.Mg,
        maxDose: 0.5,
        weightBased: false,
        instructions: '0.3 mg (0.3 mL of 1:1000) IM lateral thigh, may repeat in 5-15 minutes'
      },
      {
        id: 'epi-dose-3',
        indication: 'Anaphylaxis',
        patientAgeGroup: AgeGroup.Child,
        doseType: DoseType.Initial,
        amount: 0.01,
        unit: DoseUnit.MgPerKg,
        maxDose: 0.3,
        weightBased: true,
        instructions: '0.01 mg/kg (0.01 mL/kg of 1:1000) IM lateral thigh, max 0.3 mg'
      }
    ],
    routes: [AdministrationRoute.IV, AdministrationRoute.IO, AdministrationRoute.IM, AdministrationRoute.ET],
    onset: 'IV: Immediate, IM: 3-5 minutes',
    duration: 'IV: 5-10 minutes, IM: 10-20 minutes',
    mechanismOfAction: 'Alpha and beta adrenergic agonist causing vasoconstriction, bronchodilation, increased cardiac contractility and heart rate',
    stateSpecificNotes: {}
  },

  // Aspirin
  {
    id: 'med-aspirin',
    name: 'Aspirin',
    genericName: 'Acetylsalicylic Acid',
    brandNames: ['ASA', 'Bayer'],
    classification: MedicationClass.Antiplatelet,
    certificationLevel: CertificationLevel.EMT,
    indications: ['Chest pain suspicious for acute coronary syndrome', 'Suspected myocardial infarction'],
    contraindications: [
      'Known hypersensitivity to aspirin',
      'Active gastrointestinal bleeding',
      'Recent stroke (within 3 months)'
    ],
    precautions: ['Use with caution in patients with asthma', 'May cause stomach upset'],
    adverseEffects: ['Nausea', 'Gastrointestinal upset', 'Allergic reaction (rare)', 'Increased bleeding risk'],
    dosing: [
      {
        id: 'asa-dose-1',
        indication: 'Acute Coronary Syndrome',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 324,
        unit: DoseUnit.Mg,
        weightBased: false,
        instructions: '324 mg PO (chewed), given once'
      }
    ],
    routes: [AdministrationRoute.PO],
    onset: '30-40 minutes (faster if chewed)',
    duration: 'Duration of platelet lifespan (7-10 days)',
    mechanismOfAction: 'Irreversibly inhibits cyclooxygenase, preventing platelet aggregation and thrombus formation',
    stateSpecificNotes: {}
  },

  // Albuterol
  {
    id: 'med-albuterol',
    name: 'Albuterol',
    genericName: 'Albuterol Sulfate',
    brandNames: ['Proventil', 'Ventolin'],
    classification: MedicationClass.Bronchodilator,
    certificationLevel: CertificationLevel.EMT,
    indications: ['Bronchospasm', 'Asthma', 'COPD exacerbation', 'Allergic reaction with wheezing'],
    contraindications: ['Known hypersensitivity to albuterol'],
    precautions: ['May cause tachycardia', 'Use with caution in cardiac disease', 'May cause tremors'],
    adverseEffects: ['Tachycardia', 'Tremors', 'Nervousness', 'Headache', 'Hypokalemia (with repeated doses)'],
    dosing: [
      {
        id: 'alb-dose-1',
        indication: 'Bronchospasm',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 2.5,
        unit: DoseUnit.Mg,
        weightBased: false,
        instructions: '2.5-5 mg via nebulizer, may repeat every 20 minutes'
      },
      {
        id: 'alb-dose-2',
        indication: 'Bronchospasm',
        patientAgeGroup: AgeGroup.Child,
        doseType: DoseType.Initial,
        amount: 2.5,
        unit: DoseUnit.Mg,
        weightBased: false,
        instructions: '2.5 mg via nebulizer, may repeat every 20 minutes'
      }
    ],
    routes: [AdministrationRoute.Nebulized],
    onset: '5-15 minutes',
    duration: '4-6 hours',
    mechanismOfAction: 'Beta-2 adrenergic agonist causing bronchodilation through relaxation of bronchial smooth muscle',
    stateSpecificNotes: {}
  },

  // Nitroglycerin
  {
    id: 'med-nitroglycerin',
    name: 'Nitroglycerin',
    genericName: 'Nitroglycerin',
    brandNames: ['Nitrostat', 'NitroQuick'],
    classification: MedicationClass.Cardiovascular,
    certificationLevel: CertificationLevel.EMT,
    indications: ['Chest pain from suspected angina or MI', 'Acute pulmonary edema'],
    contraindications: [
      'Systolic BP < 100 mmHg',
      'Recent use of erectile dysfunction medications (within 24-48 hours)',
      'Right ventricular infarction',
      'Severe aortic stenosis'
    ],
    precautions: ['May cause hypotension', 'May cause headache', 'Monitor blood pressure before each dose'],
    adverseEffects: ['Hypotension', 'Headache', 'Dizziness', 'Reflex tachycardia', 'Flushing'],
    dosing: [
      {
        id: 'ntg-dose-1',
        indication: 'Chest Pain',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 0.4,
        unit: DoseUnit.Mg,
        weightBased: false,
        instructions: '0.4 mg (1 tablet or spray) SL every 5 minutes, max 3 doses if SBP > 100 mmHg'
      }
    ],
    routes: [AdministrationRoute.SL],
    onset: '1-3 minutes',
    duration: '30-60 minutes',
    mechanismOfAction: 'Vasodilator causing venous pooling, decreased preload, and coronary artery dilation',
    stateSpecificNotes: {}
  },

  // Morphine
  {
    id: 'med-morphine',
    name: 'Morphine Sulfate',
    genericName: 'Morphine',
    brandNames: ['MS Contin', 'Duramorph'],
    classification: MedicationClass.Analgesic,
    certificationLevel: CertificationLevel.Paramedic,
    indications: ['Moderate to severe pain', 'Chest pain from suspected MI', 'Acute pulmonary edema'],
    contraindications: [
      'Hypersensitivity',
      'Respiratory depression',
      'Hypotension',
      'Head injury with altered mental status'
    ],
    precautions: ['May cause respiratory depression', 'May cause hypotension', 'Have naloxone available'],
    adverseEffects: ['Respiratory depression', 'Hypotension', 'Nausea and vomiting', 'Constipation', 'Sedation'],
    dosing: [
      {
        id: 'mor-dose-1',
        indication: 'Pain or Acute Pulmonary Edema',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 2,
        unit: DoseUnit.Mg,
        maxDose: 10,
        weightBased: false,
        instructions: '2-4 mg IV/IO slowly, may repeat every 5-10 minutes, max 10 mg'
      }
    ],
    routes: [AdministrationRoute.IV, AdministrationRoute.IO, AdministrationRoute.IM],
    onset: 'IV: 1-2 minutes, IM: 10-20 minutes',
    duration: '3-4 hours',
    mechanismOfAction: 'Opioid agonist acting on mu receptors to produce analgesia, sedation, and respiratory depression',
    stateSpecificNotes: {}
  },

  // Amiodarone
  {
    id: 'med-amiodarone',
    name: 'Amiodarone',
    genericName: 'Amiodarone HCl',
    brandNames: ['Cordarone', 'Pacerone'],
    classification: MedicationClass.Antiarrhythmic,
    certificationLevel: CertificationLevel.Paramedic,
    indications: [
      'Ventricular fibrillation',
      'Pulseless ventricular tachycardia',
      'Stable wide-complex tachycardia'
    ],
    contraindications: ['Known hypersensitivity', 'Cardiogenic shock', 'Severe bradycardia'],
    precautions: ['May cause hypotension', 'Monitor for bradycardia', 'Use with caution in liver disease'],
    adverseEffects: ['Hypotension', 'Bradycardia', 'Prolonged QT interval', 'Phlebitis (peripheral IV)'],
    dosing: [
      {
        id: 'amio-dose-1',
        indication: 'VF/Pulseless VT',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 300,
        unit: DoseUnit.Mg,
        weightBased: false,
        instructions: '300 mg IV/IO rapid push, may give second dose of 150 mg'
      },
      {
        id: 'amio-dose-2',
        indication: 'Stable VT',
        patientAgeGroup: AgeGroup.Adult,
        doseType: DoseType.Initial,
        amount: 150,
        unit: DoseUnit.Mg,
        weightBased: false,
        instructions: '150 mg IV over 10 minutes, may repeat once'
      }
    ],
    routes: [AdministrationRoute.IV, AdministrationRoute.IO],
    onset: 'Minutes to hours',
    duration: 'Variable (weeks to months)',
    mechanismOfAction: 'Class III antiarrhythmic that prolongs action potential duration and refractory period',
    stateSpecificNotes: {}
  }
]

export const sampleProcedures: Procedure[] = [
  // BVM Ventilation
  {
    id: 'proc-bvm',
    name: 'Bag-Valve-Mask Ventilation',
    category: ProcedureCategory.Airway,
    certificationLevel: CertificationLevel.EMR,
    indications: ['Apnea', 'Inadequate respiratory effort', 'Need for ventilatory support'],
    contraindications: ['None in emergency situations'],
    equipment: [
      'Bag-valve-mask device with reservoir',
      'Oxygen source',
      'Appropriate mask size',
      'Airway adjuncts (OPA/NPA)',
      'Suction'
    ],
    steps: [
      {
        id: 'bvm-step-1',
        order: 1,
        instruction: 'Select appropriate mask size - should seal from bridge of nose to cleft of chin',
        criticalPoint: true
      },
      {
        id: 'bvm-step-2',
        order: 2,
        instruction: 'Position patient - head tilt-chin lift or jaw thrust if trauma suspected',
        criticalPoint: false
      },
      {
        id: 'bvm-step-3',
        order: 3,
        instruction: 'Insert airway adjunct if needed (OPA or NPA)',
        criticalPoint: false
      },
      {
        id: 'bvm-step-4',
        order: 4,
        instruction: "Apply mask using E-C technique: thumb and index finger form 'C' on mask, other fingers form 'E' lifting jaw",
        criticalPoint: true
      },
      {
        id: 'bvm-step-5',
        order: 5,
        instruction: 'Connect to oxygen at 15 L/min with reservoir attached',
        criticalPoint: false
      },
      {
        id: 'bvm-step-6',
        order: 6,
        instruction: 'Squeeze bag delivering adequate tidal volume (watch for chest rise)',
        criticalPoint: true
      },
      {
        id: 'bvm-step-7',
        order: 7,
        instruction: 'Ventilate at appropriate rate: Adults 10-12/min, Children 12-20/min, Infants 20-30/min',
        criticalPoint: false
      },
      {
        id: 'bvm-step-8',
        order: 8,
        instruction: 'Monitor for adequate chest rise, SpO2, and clinical improvement',
        criticalPoint: false
      },
      {
        id: 'bvm-step-9',
        order: 9,
        instruction: 'If unable to ventilate, reposition head, check for foreign body, consider advanced airway',
        criticalPoint: false
      }
    ],
    complications: ['Gastric distension', 'Inadequate ventilation', 'Barotrauma', 'Aspiration'],
    precautions: ['Avoid excessive tidal volumes', 'Ensure adequate seal', 'Monitor for gastric distension'],
    educationalPoints: [
      {
        id: 'bvm-edu-1',
        title: 'Two-Person Technique',
        content:
          'When available, use two-person BVM: one provider maintains mask seal with two hands, second provider squeezes bag. This provides better seal and ventilation.',
        references: ['AHA BLS Guidelines'],
        mediaUrls: []
      }
    ],
    videoUrls: [],
    imageUrls: [],
    stateSpecificNotes: {}
  },

  // IV Access
  {
    id: 'proc-iv',
    name: 'Intravenous Access - Peripheral',
    category: ProcedureCategory.IVAccess,
    certificationLevel: CertificationLevel.AEMT,
    indications: ['Need for fluid resuscitation', 'Need for IV medication administration', 'Blood sampling'],
    contraindications: ['Infection at insertion site', 'AV fistula in extremity', 'Injury to extremity'],
    equipment: [
      'IV catheter (appropriate gauge)',
      'Tourniquet',
      'Antiseptic wipes',
      'IV tubing and fluid',
      'Tape or securement device',
      'Gloves',
      'Sharps container'
    ],
    steps: [
      {
        id: 'iv-step-1',
        order: 1,
        instruction: 'Gather equipment and explain procedure to patient',
        criticalPoint: false
      },
      {
        id: 'iv-step-2',
        order: 2,
        instruction: 'Don gloves and apply PPE as appropriate',
        criticalPoint: false
      },
      {
        id: 'iv-step-3',
        order: 3,
        instruction: 'Apply tourniquet 4-6 inches above intended insertion site',
        criticalPoint: false
      },
      {
        id: 'iv-step-4',
        order: 4,
        instruction: 'Select vein - prefer straight, bouncy veins; avoid joints, areas of injury',
        criticalPoint: false
      },
      {
        id: 'iv-step-5',
        order: 5,
        instruction: 'Prepare site with antiseptic in circular motion from center outward, allow to dry',
        criticalPoint: true
      },
      {
        id: 'iv-step-6',
        order: 6,
        instruction: 'Stabilize vein with non-dominant hand, insert catheter at 15-30 degree angle, bevel up',
        criticalPoint: false
      },
      {
        id: 'iv-step-7',
        order: 7,
        instruction: 'Watch for flash of blood in catheter chamber',
        criticalPoint: false
      },
      {
        id: 'iv-step-8',
        order: 8,
        instruction: 'Advance catheter slightly, then thread catheter off needle into vein',
        criticalPoint: true
      },
      {
        id: 'iv-step-9',
        order: 9,
        instruction: 'Release tourniquet, occlude vein above catheter, remove needle',
        criticalPoint: false
      },
      {
        id: 'iv-step-10',
        order: 10,
        instruction: 'Connect IV tubing and ensure fluid flows freely',
        criticalPoint: false
      },
      {
        id: 'iv-step-11',
        order: 11,
        instruction: 'Secure catheter with tape or commercial device',
        criticalPoint: false
      },
      {
        id: 'iv-step-12',
        order: 12,
        instruction: 'Dispose of needle in sharps container immediately',
        criticalPoint: true
      },
      {
        id: 'iv-step-13',
        order: 13,
        instruction: 'Document site, time, catheter size, and who performed procedure',
        criticalPoint: false
      }
    ],
    complications: ['Hematoma', 'Infiltration/extravasation', 'Phlebitis', 'Infection', 'Nerve injury', 'Arterial puncture'],
    precautions: ['Use aseptic technique', 'Secure catheter well', 'Monitor site regularly'],
    educationalPoints: [],
    videoUrls: [],
    imageUrls: [],
    stateSpecificNotes: {}
  },

  // 12-Lead ECG
  {
    id: 'proc-ecg',
    name: '12-Lead ECG Acquisition',
    category: ProcedureCategory.Assessment,
    certificationLevel: CertificationLevel.EMT,
    indications: ['Chest pain', 'Suspected cardiac event', 'Syncope', 'Dyspnea', 'Palpitations'],
    contraindications: ['None'],
    equipment: ['12-lead ECG machine', 'Electrodes', 'Alcohol wipes or skin prep', 'Razor (if needed for hair removal)'],
    steps: [
      {
        id: 'ecg-step-1',
        order: 1,
        instruction: 'Explain procedure to patient, obtain consent',
        criticalPoint: false
      },
      {
        id: 'ecg-step-2',
        order: 2,
        instruction: 'Position patient supine or semi-Fowler\'s, expose chest',
        criticalPoint: false
      },
      {
        id: 'ecg-step-3',
        order: 3,
        instruction: 'Prepare skin: wipe with alcohol, dry, shave if excessively hairy',
        criticalPoint: false
      },
      {
        id: 'ecg-step-4',
        order: 4,
        instruction: 'Apply limb electrodes: RA, LA, RL, LL on extremities or torso',
        criticalPoint: true
      },
      {
        id: 'ecg-step-5',
        order: 5,
        instruction: 'Apply precordial leads V1-V6:',
        criticalPoint: true
      },
      {
        id: 'ecg-step-6',
        order: 6,
        instruction: 'V1: 4th intercostal space, right of sternum',
        criticalPoint: false
      },
      {
        id: 'ecg-step-7',
        order: 7,
        instruction: 'V2: 4th intercostal space, left of sternum',
        criticalPoint: false
      },
      {
        id: 'ecg-step-8',
        order: 8,
        instruction: 'V3: Between V2 and V4',
        criticalPoint: false
      },
      {
        id: 'ecg-step-9',
        order: 9,
        instruction: 'V4: 5th intercostal space, mid-clavicular line',
        criticalPoint: false
      },
      {
        id: 'ecg-step-10',
        order: 10,
        instruction: 'V5: Same level as V4, anterior axillary line',
        criticalPoint: false
      },
      {
        id: 'ecg-step-11',
        order: 11,
        instruction: 'V6: Same level as V4, mid-axillary line',
        criticalPoint: false
      },
      {
        id: 'ecg-step-12',
        order: 12,
        instruction: 'Ensure patient is still, not talking, arms relaxed',
        criticalPoint: false
      },
      {
        id: 'ecg-step-13',
        order: 13,
        instruction: 'Acquire 12-lead ECG, verify quality before removing electrodes',
        criticalPoint: false
      },
      {
        id: 'ecg-step-14',
        order: 14,
        instruction: 'Document time of acquisition and clinical correlation',
        criticalPoint: false
      }
    ],
    complications: ['Skin irritation from electrodes', 'Motion artifact'],
    precautions: [
      'Accurate electrode placement is critical',
      'Minimize patient movement during acquisition',
      'Female patients: place breast tissue aside, not on top'
    ],
    educationalPoints: [
      {
        id: 'ecg-edu-1',
        title: 'Time is Critical',
        content:
          'Goal is 12-lead ECG within 10 minutes of patient contact for chest pain patients. Early ECG can identify STEMI and guide destination decision.',
        references: ['AHA STEMI Guidelines'],
        mediaUrls: []
      }
    ],
    videoUrls: [],
    imageUrls: [],
    stateSpecificNotes: {}
  }
]
