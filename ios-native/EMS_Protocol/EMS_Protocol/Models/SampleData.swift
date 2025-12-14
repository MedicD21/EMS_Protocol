//
//  SampleData.swift
//  EMS Protocol
//
//  Created by Claude Code
//  Sample data based on National Model EMS Clinical Guidelines
//

import Foundation

struct SampleData {
    // MARK: - Sample Protocols

    static let sampleProtocols: [EMSProtocol] = [
        // Cardiac Arrest Protocol
        EMSProtocol(
            title: "Cardiac Arrest - Adult",
            category: .cardiac,
            certificationLevel: .emt,
            flowchartSteps: [
                FlowchartStep(
                    order: 1,
                    stepType: .assessment,
                    content: "Verify cardiac arrest: Check for unresponsiveness and absence of normal breathing",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 2,
                    stepType: .intervention,
                    content: "Begin high-quality CPR: 30 compressions to 2 ventilations, minimize interruptions",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 3,
                    stepType: .intervention,
                    content: "Apply AED/Monitor as soon as available. Analyze rhythm.",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 4,
                    stepType: .decision,
                    content: "Is rhythm shockable (VF/pVT)?",
                    certificationLevel: .emr,
                    isConditional: true,
                    conditions: [
                        StepCondition(condition: "Shockable", targetStepId: "shock"),
                        StepCondition(condition: "Non-shockable", targetStepId: "continue_cpr")
                    ]
                ),
                FlowchartStep(
                    order: 5,
                    stepType: .intervention,
                    content: "If shockable: Deliver shock, immediately resume CPR for 2 minutes",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 6,
                    stepType: .intervention,
                    content: "Establish IV/IO access",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 7,
                    stepType: .medication,
                    content: "Epinephrine 1 mg IV/IO every 3-5 minutes",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 8,
                    stepType: .intervention,
                    content: "Consider advanced airway if trained (supraglottic airway or endotracheal intubation)",
                    certificationLevel: .paramedic
                ),
                FlowchartStep(
                    order: 9,
                    stepType: .medication,
                    content: "For VF/pVT: Consider Amiodarone 300 mg IV/IO after 3rd shock",
                    certificationLevel: .paramedic
                ),
                FlowchartStep(
                    order: 10,
                    stepType: .assessment,
                    content: "Treat reversible causes (H's and T's): Hypovolemia, Hypoxia, Hydrogen ion (acidosis), Hypo/hyperkalemia, Hypothermia, Tension pneumothorax, Tamponade, Toxins, Thrombosis",
                    certificationLevel: .paramedic
                )
            ],
            detailedDescription: "Adult cardiac arrest protocol following current AHA/ERC guidelines with emphasis on high-quality CPR and early defibrillation.",
            educationalPoints: [
                EducationalPoint(
                    title: "High-Quality CPR",
                    content: "Compression rate: 100-120/min, Depth: At least 2 inches (5 cm), Allow full chest recoil, Minimize interruptions (<10 seconds)",
                    references: ["AHA Guidelines 2020", "National Model EMS Clinical Guidelines"]
                ),
                EducationalPoint(
                    title: "Reversible Causes",
                    content: "Remember H's and T's to systematically identify and treat reversible causes of cardiac arrest",
                    references: ["ACLS Provider Manual"]
                )
            ],
            relatedProcedures: [],
            relatedMedications: []
        ),

        // Chest Pain Protocol
        EMSProtocol(
            title: "Acute Coronary Syndrome / Chest Pain",
            category: .cardiac,
            certificationLevel: .emt,
            flowchartSteps: [
                FlowchartStep(
                    order: 1,
                    stepType: .assessment,
                    content: "Assess chest pain using OPQRST, obtain vital signs, 12-lead ECG within 10 minutes",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 2,
                    stepType: .intervention,
                    content: "Place patient in position of comfort, administer oxygen if SpO2 < 94%",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 3,
                    stepType: .medication,
                    content: "Aspirin 324 mg PO (chewed) if no allergy or contraindications",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 4,
                    stepType: .medication,
                    content: "Nitroglycerin 0.4 mg SL every 5 minutes (max 3 doses) if SBP > 100 mmHg",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 5,
                    stepType: .intervention,
                    content: "Establish IV access, cardiac monitoring",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 6,
                    stepType: .medication,
                    content: "For pain: Morphine 2-4 mg IV/IO if no relief with nitrates",
                    certificationLevel: .paramedic
                ),
                FlowchartStep(
                    order: 7,
                    stepType: .transport,
                    content: "Transport to appropriate facility (STEMI receiving center if ECG shows STEMI)",
                    certificationLevel: .emt
                )
            ],
            detailedDescription: "Management of patients with suspected acute coronary syndrome including STEMI, NSTEMI, and unstable angina.",
            educationalPoints: [
                EducationalPoint(
                    title: "STEMI Criteria",
                    content: "ST elevation >1mm in 2 contiguous limb leads or >2mm in 2 contiguous chest leads",
                    references: ["AHA STEMI Guidelines"]
                ),
                EducationalPoint(
                    title: "Time is Muscle",
                    content: "Door-to-balloon time goal is 90 minutes. EMS plays critical role in early ECG and destination selection",
                    references: ["National Model EMS Clinical Guidelines"]
                )
            ]
        ),

        // Respiratory Distress Protocol
        EMSProtocol(
            title: "Respiratory Distress / Asthma / COPD",
            category: .respiratory,
            certificationLevel: .emr,
            flowchartSteps: [
                FlowchartStep(
                    order: 1,
                    stepType: .assessment,
                    content: "Assess airway, breathing, circulation. Obtain vital signs, SpO2, lung sounds",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 2,
                    stepType: .intervention,
                    content: "Position patient upright, administer oxygen to maintain SpO2 94-98%",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 3,
                    stepType: .medication,
                    content: "Albuterol 2.5-5 mg via nebulizer or MDI with spacer",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 4,
                    stepType: .medication,
                    content: "Ipratropium 0.5 mg via nebulizer (can combine with albuterol)",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 5,
                    stepType: .medication,
                    content: "Consider CPAP if patient is tiring or inadequate response to medications",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 6,
                    stepType: .medication,
                    content: "For severe bronchospasm: Epinephrine 0.3 mg IM",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 7,
                    stepType: .intervention,
                    content: "If respiratory failure imminent: Prepare for advanced airway management",
                    certificationLevel: .paramedic
                )
            ],
            detailedDescription: "Management of respiratory distress including asthma, COPD exacerbation, and other causes of difficulty breathing.",
            educationalPoints: [
                EducationalPoint(
                    title: "CPAP Indications",
                    content: "CPAP can be beneficial in CHF, COPD, and asthma. Contraindications include inability to protect airway, facial trauma, hypotension",
                    references: ["National Model EMS Clinical Guidelines"]
                )
            ]
        ),

        // Anaphylaxis Protocol
        EMSProtocol(
            title: "Anaphylaxis / Allergic Reaction",
            category: .medical,
            certificationLevel: .emr,
            flowchartSteps: [
                FlowchartStep(
                    order: 1,
                    stepType: .assessment,
                    content: "Assess for signs of anaphylaxis: respiratory distress, hypotension, urticaria, angioedema",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 2,
                    stepType: .intervention,
                    content: "Remove allergen if possible, ensure airway patency, administer high-flow oxygen",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 3,
                    stepType: .medication,
                    content: "Epinephrine 0.3 mg (0.3 mL of 1:1000) IM lateral thigh - IMMEDIATELY for anaphylaxis",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 4,
                    stepType: .intervention,
                    content: "Place patient supine with legs elevated (if no respiratory distress)",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 5,
                    stepType: .intervention,
                    content: "Establish IV/IO access, fluid resuscitation with NS if hypotensive",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 6,
                    stepType: .medication,
                    content: "Diphenhydramine 25-50 mg IV/IM",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 7,
                    stepType: .medication,
                    content: "Consider: Albuterol for bronchospasm, repeat epinephrine in 5-15 min if needed",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 8,
                    stepType: .medication,
                    content: "Severe cases: Epinephrine infusion 2-10 mcg/min titrated to effect",
                    certificationLevel: .paramedic
                )
            ],
            detailedDescription: "Management of anaphylaxis and severe allergic reactions with emphasis on rapid epinephrine administration.",
            educationalPoints: [
                EducationalPoint(
                    title: "Epinephrine is First-Line",
                    content: "Epinephrine is the ONLY first-line treatment for anaphylaxis. Do not delay for antihistamines or steroids.",
                    references: ["World Allergy Organization Anaphylaxis Guidance"]
                ),
                EducationalPoint(
                    title: "Biphasic Reactions",
                    content: "10-20% of anaphylaxis cases have biphasic reactions occurring 4-8 hours after initial presentation. All patients require hospital evaluation.",
                    references: ["National Model EMS Clinical Guidelines"]
                )
            ]
        ),

        // Stroke Protocol
        EMSProtocol(
            title: "Stroke / CVA",
            category: .medical,
            certificationLevel: .emt,
            flowchartSteps: [
                FlowchartStep(
                    order: 1,
                    stepType: .assessment,
                    content: "Assess using stroke scale (Cincinnati or FAST). Time of symptom onset is CRITICAL",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 2,
                    stepType: .assessment,
                    content: "Obtain blood glucose level to rule out hypoglycemia",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 3,
                    stepType: .intervention,
                    content: "Protect airway, administer oxygen if SpO2 < 94%, position head at 30 degrees",
                    certificationLevel: .emr
                ),
                FlowchartStep(
                    order: 4,
                    stepType: .assessment,
                    content: "Obtain vital signs, 12-lead ECG, detailed neurological exam",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 5,
                    stepType: .intervention,
                    content: "Establish IV access with normal saline at KVO rate. DO NOT lower blood pressure unless extremely elevated (>220/120)",
                    certificationLevel: .aemt
                ),
                FlowchartStep(
                    order: 6,
                    stepType: .transport,
                    content: "Transport rapidly to stroke center. Notify receiving facility with stroke alert",
                    certificationLevel: .emt
                ),
                FlowchartStep(
                    order: 7,
                    stepType: .documentation,
                    content: "Document exact time of symptom onset, baseline neurological status, and any changes during transport",
                    certificationLevel: .emt
                )
            ],
            detailedDescription: "Recognition and management of acute stroke with emphasis on rapid transport to appropriate facility.",
            educationalPoints: [
                EducationalPoint(
                    title: "Time is Brain",
                    content: "Each minute of untreated stroke, 1.9 million neurons die. tPA must be given within 3-4.5 hours of symptom onset.",
                    references: ["AHA Stroke Guidelines"]
                ),
                EducationalPoint(
                    title: "Cincinnati Stroke Scale",
                    content: "Assess: Facial droop, Arm drift, Speech abnormality. Any one positive = 72% probability of stroke",
                    references: ["National Model EMS Clinical Guidelines"]
                )
            ]
        )
    ]

    // MARK: - Sample Medications

    static let sampleMedications: [Medication] = [
        Medication(
            name: "Epinephrine",
            genericName: "Epinephrine",
            brandNames: ["Adrenalin", "EpiPen"],
            classification: .vasopressor,
            certificationLevel: .emr,
            indications: [
                "Cardiac arrest",
                "Anaphylaxis",
                "Severe bronchospasm",
                "Bradycardia (when pacing unavailable)"
            ],
            contraindications: [
                "None in life-threatening situations"
            ],
            precautions: [
                "May cause hypertension, tachycardia",
                "Use with caution in coronary artery disease",
                "May cause anxiety, tremors"
            ],
            adverseEffects: [
                "Tachycardia",
                "Hypertension",
                "Anxiety",
                "Tremors",
                "Pallor",
                "Headache"
            ],
            dosing: [
                DosingProtocol(
                    indication: "Cardiac Arrest",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 1.0,
                    unit: .mg,
                    weightBased: false,
                    instructions: "1 mg IV/IO every 3-5 minutes"
                ),
                DosingProtocol(
                    indication: "Anaphylaxis",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 0.3,
                    unit: .mg,
                    maxDose: 0.5,
                    weightBased: false,
                    instructions: "0.3 mg (0.3 mL of 1:1000) IM lateral thigh, may repeat in 5-15 minutes"
                ),
                DosingProtocol(
                    indication: "Anaphylaxis",
                    patientAgeGroup: .child,
                    doseType: .initial,
                    amount: 0.01,
                    unit: .mgPerKg,
                    maxDose: 0.3,
                    weightBased: true,
                    instructions: "0.01 mg/kg (0.01 mL/kg of 1:1000) IM lateral thigh, max 0.3 mg"
                )
            ],
            routes: [.iv, .io, .im, .et],
            onset: "IV: Immediate, IM: 3-5 minutes",
            duration: "IV: 5-10 minutes, IM: 10-20 minutes",
            mechanismOfAction: "Alpha and beta adrenergic agonist causing vasoconstriction, bronchodilation, increased cardiac contractility and heart rate"
        ),

        Medication(
            name: "Aspirin",
            genericName: "Acetylsalicylic Acid",
            brandNames: ["ASA", "Bayer"],
            classification: .antiplatelet,
            certificationLevel: .emt,
            indications: [
                "Chest pain suspicious for acute coronary syndrome",
                "Suspected myocardial infarction"
            ],
            contraindications: [
                "Known hypersensitivity to aspirin",
                "Active gastrointestinal bleeding",
                "Recent stroke (within 3 months)"
            ],
            precautions: [
                "Use with caution in patients with asthma",
                "May cause stomach upset"
            ],
            adverseEffects: [
                "Nausea",
                "Gastrointestinal upset",
                "Allergic reaction (rare)",
                "Increased bleeding risk"
            ],
            dosing: [
                DosingProtocol(
                    indication: "Acute Coronary Syndrome",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 324,
                    unit: .mg,
                    weightBased: false,
                    instructions: "324 mg PO (chewed), given once"
                )
            ],
            routes: [.po],
            onset: "30-40 minutes (faster if chewed)",
            duration: "Duration of platelet lifespan (7-10 days)",
            mechanismOfAction: "Irreversibly inhibits cyclooxygenase, preventing platelet aggregation and thrombus formation"
        ),

        Medication(
            name: "Albuterol",
            genericName: "Albuterol Sulfate",
            brandNames: ["Proventil", "Ventolin"],
            classification: .bronchodilator,
            certificationLevel: .emt,
            indications: [
                "Bronchospasm",
                "Asthma",
                "COPD exacerbation",
                "Allergic reaction with wheezing"
            ],
            contraindications: [
                "Known hypersensitivity to albuterol"
            ],
            precautions: [
                "May cause tachycardia",
                "Use with caution in cardiac disease",
                "May cause tremors"
            ],
            adverseEffects: [
                "Tachycardia",
                "Tremors",
                "Nervousness",
                "Headache",
                "Hypokalemia (with repeated doses)"
            ],
            dosing: [
                DosingProtocol(
                    indication: "Bronchospasm",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 2.5,
                    unit: .mg,
                    weightBased: false,
                    instructions: "2.5-5 mg via nebulizer, may repeat every 20 minutes"
                ),
                DosingProtocol(
                    indication: "Bronchospasm",
                    patientAgeGroup: .child,
                    doseType: .initial,
                    amount: 2.5,
                    unit: .mg,
                    weightBased: false,
                    instructions: "2.5 mg via nebulizer, may repeat every 20 minutes"
                )
            ],
            routes: [.nebulized],
            onset: "5-15 minutes",
            duration: "4-6 hours",
            mechanismOfAction: "Beta-2 adrenergic agonist causing bronchodilation through relaxation of bronchial smooth muscle"
        ),

        Medication(
            name: "Nitroglycerin",
            genericName: "Nitroglycerin",
            brandNames: ["Nitrostat", "NitroQuick"],
            classification: .cardiovascular,
            certificationLevel: .emt,
            indications: [
                "Chest pain from suspected angina or MI",
                "Acute pulmonary edema"
            ],
            contraindications: [
                "Systolic BP < 100 mmHg",
                "Recent use of erectile dysfunction medications (within 24-48 hours)",
                "Right ventricular infarction",
                "Severe aortic stenosis"
            ],
            precautions: [
                "May cause hypotension",
                "May cause headache",
                "Monitor blood pressure before each dose"
            ],
            adverseEffects: [
                "Hypotension",
                "Headache",
                "Dizziness",
                "Reflex tachycardia",
                "Flushing"
            ],
            dosing: [
                DosingProtocol(
                    indication: "Chest Pain",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 0.4,
                    unit: .mg,
                    weightBased: false,
                    instructions: "0.4 mg (1 tablet or spray) SL every 5 minutes, max 3 doses if SBP > 100 mmHg"
                )
            ],
            routes: [.sl],
            onset: "1-3 minutes",
            duration: "30-60 minutes",
            mechanismOfAction: "Vasodilator causing venous pooling, decreased preload, and coronary artery dilation"
        ),

        Medication(
            name: "Morphine Sulfate",
            genericName: "Morphine",
            brandNames: ["MS Contin", "Duramorph"],
            classification: .analgesic,
            certificationLevel: .paramedic,
            indications: [
                "Moderate to severe pain",
                "Chest pain from suspected MI",
                "Acute pulmonary edema"
            ],
            contraindications: [
                "Hypersensitivity",
                "Respiratory depression",
                "Hypotension",
                "Head injury with altered mental status"
            ],
            precautions: [
                "May cause respiratory depression",
                "May cause hypotension",
                "Have naloxone available"
            ],
            adverseEffects: [
                "Respiratory depression",
                "Hypotension",
                "Nausea and vomiting",
                "Constipation",
                "Sedation"
            ],
            dosing: [
                DosingProtocol(
                    indication: "Pain or Acute Pulmonary Edema",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 2,
                    unit: .mg,
                    maxDose: 10,
                    weightBased: false,
                    instructions: "2-4 mg IV/IO slowly, may repeat every 5-10 minutes, max 10 mg"
                )
            ],
            routes: [.iv, .io, .im],
            onset: "IV: 1-2 minutes, IM: 10-20 minutes",
            duration: "3-4 hours",
            mechanismOfAction: "Opioid agonist acting on mu receptors to produce analgesia, sedation, and respiratory depression"
        ),

        Medication(
            name: "Amiodarone",
            genericName: "Amiodarone HCl",
            brandNames: ["Cordarone", "Pacerone"],
            classification: .antiarrhythmic,
            certificationLevel: .paramedic,
            indications: [
                "Ventricular fibrillation",
                "Pulseless ventricular tachycardia",
                "Stable wide-complex tachycardia"
            ],
            contraindications: [
                "Known hypersensitivity",
                "Cardiogenic shock",
                "Severe bradycardia"
            ],
            precautions: [
                "May cause hypotension",
                "Monitor for bradycardia",
                "Use with caution in liver disease"
            ],
            adverseEffects: [
                "Hypotension",
                "Bradycardia",
                "Prolonged QT interval",
                "Phlebitis (peripheral IV)"
            ],
            dosing: [
                DosingProtocol(
                    indication: "VF/Pulseless VT",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 300,
                    unit: .mg,
                    weightBased: false,
                    instructions: "300 mg IV/IO rapid push, may give second dose of 150 mg"
                ),
                DosingProtocol(
                    indication: "Stable VT",
                    patientAgeGroup: .adult,
                    doseType: .initial,
                    amount: 150,
                    unit: .mg,
                    weightBased: false,
                    instructions: "150 mg IV over 10 minutes, may repeat once"
                )
            ],
            routes: [.iv, .io],
            onset: "Minutes to hours",
            duration: "Variable (weeks to months)",
            mechanismOfAction: "Class III antiarrhythmic that prolongs action potential duration and refractory period"
        )
    ]

    // MARK: - Sample Procedures

    static let sampleProcedures: [Procedure] = [
        Procedure(
            name: "Bag-Valve-Mask Ventilation",
            category: .airway,
            certificationLevel: .emr,
            indications: [
                "Apnea",
                "Inadequate respiratory effort",
                "Need for ventilatory support"
            ],
            contraindications: [
                "None in emergency situations"
            ],
            equipment: [
                "Bag-valve-mask device with reservoir",
                "Oxygen source",
                "Appropriate mask size",
                "Airway adjuncts (OPA/NPA)",
                "Suction"
            ],
            steps: [
                ProcedureStep(order: 1, instruction: "Select appropriate mask size - should seal from bridge of nose to cleft of chin", criticalPoint: true),
                ProcedureStep(order: 2, instruction: "Position patient - head tilt-chin lift or jaw thrust if trauma suspected"),
                ProcedureStep(order: 3, instruction: "Insert airway adjunct if needed (OPA or NPA)"),
                ProcedureStep(order: 4, instruction: "Apply mask using E-C technique: thumb and index finger form 'C' on mask, other fingers form 'E' lifting jaw", criticalPoint: true),
                ProcedureStep(order: 5, instruction: "Connect to oxygen at 15 L/min with reservoir attached"),
                ProcedureStep(order: 6, instruction: "Squeeze bag delivering adequate tidal volume (watch for chest rise)", criticalPoint: true),
                ProcedureStep(order: 7, instruction: "Ventilate at appropriate rate: Adults 10-12/min, Children 12-20/min, Infants 20-30/min"),
                ProcedureStep(order: 8, instruction: "Monitor for adequate chest rise, SpO2, and clinical improvement"),
                ProcedureStep(order: 9, instruction: "If unable to ventilate, reposition head, check for foreign body, consider advanced airway")
            ],
            complications: [
                "Gastric distension",
                "Inadequate ventilation",
                "Barotrauma",
                "Aspiration"
            ],
            precautions: [
                "Avoid excessive tidal volumes",
                "Ensure adequate seal",
                "Monitor for gastric distension"
            ],
            educationalPoints: [
                EducationalPoint(
                    title: "Two-Person Technique",
                    content: "When available, use two-person BVM: one provider maintains mask seal with two hands, second provider squeezes bag. This provides better seal and ventilation.",
                    references: ["AHA BLS Guidelines"]
                )
            ]
        ),

        Procedure(
            name: "Intravenous Access - Peripheral",
            category: .ivAccess,
            certificationLevel: .aemt,
            indications: [
                "Need for fluid resuscitation",
                "Need for IV medication administration",
                "Blood sampling"
            ],
            contraindications: [
                "Infection at insertion site",
                "AV fistula in extremity",
                "Injury to extremity"
            ],
            equipment: [
                "IV catheter (appropriate gauge)",
                "Tourniquet",
                "Antiseptic wipes",
                "IV tubing and fluid",
                "Tape or securement device",
                "Gloves",
                "Sharps container"
            ],
            steps: [
                ProcedureStep(order: 1, instruction: "Gather equipment and explain procedure to patient"),
                ProcedureStep(order: 2, instruction: "Don gloves and apply PPE as appropriate"),
                ProcedureStep(order: 3, instruction: "Apply tourniquet 4-6 inches above intended insertion site"),
                ProcedureStep(order: 4, instruction: "Select vein - prefer straight, bouncy veins; avoid joints, areas of injury"),
                ProcedureStep(order: 5, instruction: "Prepare site with antiseptic in circular motion from center outward, allow to dry", criticalPoint: true),
                ProcedureStep(order: 6, instruction: "Stabilize vein with non-dominant hand, insert catheter at 15-30 degree angle, bevel up"),
                ProcedureStep(order: 7, instruction: "Watch for flash of blood in catheter chamber"),
                ProcedureStep(order: 8, instruction: "Advance catheter slightly, then thread catheter off needle into vein", criticalPoint: true),
                ProcedureStep(order: 9, instruction: "Release tourniquet, occlude vein above catheter, remove needle"),
                ProcedureStep(order: 10, instruction: "Connect IV tubing and ensure fluid flows freely"),
                ProcedureStep(order: 11, instruction: "Secure catheter with tape or commercial device"),
                ProcedureStep(order: 12, instruction: "Dispose of needle in sharps container immediately", criticalPoint: true),
                ProcedureStep(order: 13, instruction: "Document site, time, catheter size, and who performed procedure")
            ],
            complications: [
                "Hematoma",
                "Infiltration/extravasation",
                "Phlebitis",
                "Infection",
                "Nerve injury",
                "Arterial puncture"
            ],
            precautions: [
                "Use aseptic technique",
                "Secure catheter well",
                "Monitor site regularly"
            ]
        ),

        Procedure(
            name: "12-Lead ECG Acquisition",
            category: .assessment,
            certificationLevel: .emt,
            indications: [
                "Chest pain",
                "Suspected cardiac event",
                "Syncope",
                "Dyspnea",
                "Palpitations"
            ],
            contraindications: [
                "None"
            ],
            equipment: [
                "12-lead ECG machine",
                "Electrodes",
                "Alcohol wipes or skin prep",
                "Razor (if needed for hair removal)"
            ],
            steps: [
                ProcedureStep(order: 1, instruction: "Explain procedure to patient, obtain consent"),
                ProcedureStep(order: 2, instruction: "Position patient supine or semi-Fowler's, expose chest"),
                ProcedureStep(order: 3, instruction: "Prepare skin: wipe with alcohol, dry, shave if excessively hairy"),
                ProcedureStep(order: 4, instruction: "Apply limb electrodes: RA, LA, RL, LL on extremities or torso", criticalPoint: true),
                ProcedureStep(order: 5, instruction: "Apply precordial leads V1-V6:", criticalPoint: true),
                ProcedureStep(order: 6, instruction: "V1: 4th intercostal space, right of sternum"),
                ProcedureStep(order: 7, instruction: "V2: 4th intercostal space, left of sternum"),
                ProcedureStep(order: 8, instruction: "V3: Between V2 and V4"),
                ProcedureStep(order: 9, instruction: "V4: 5th intercostal space, mid-clavicular line"),
                ProcedureStep(order: 10, instruction: "V5: Same level as V4, anterior axillary line"),
                ProcedureStep(order: 11, instruction: "V6: Same level as V4, mid-axillary line"),
                ProcedureStep(order: 12, instruction: "Ensure patient is still, not talking, arms relaxed"),
                ProcedureStep(order: 13, instruction: "Acquire 12-lead ECG, verify quality before removing electrodes"),
                ProcedureStep(order: 14, instruction: "Document time of acquisition and clinical correlation")
            ],
            complications: [
                "Skin irritation from electrodes",
                "Motion artifact"
            ],
            precautions: [
                "Accurate electrode placement is critical",
                "Minimize patient movement during acquisition",
                "Female patients: place breast tissue aside, not on top"
            ],
            educationalPoints: [
                EducationalPoint(
                    title: "Time is Critical",
                    content: "Goal is 12-lead ECG within 10 minutes of patient contact for chest pain patients. Early ECG can identify STEMI and guide destination decision.",
                    references: ["AHA STEMI Guidelines"]
                )
            ]
        )
    ]
}
