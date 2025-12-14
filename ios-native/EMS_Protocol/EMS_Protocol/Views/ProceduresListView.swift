//
//  ProceduresListView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct ProceduresListView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var protocolStore: ProtocolStore
    @State private var selectedCategory: ProcedureCategory?
    @State private var showingAddProcedure = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $protocolStore.searchQuery)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            title: "All",
                            isSelected: selectedCategory == nil,
                            action: { selectedCategory = nil }
                        )

                        ForEach(ProcedureCategory.allCases, id: \.self) { category in
                            CategoryFilterButton(
                                title: category.rawValue,
                                isSelected: selectedCategory == category,
                                action: { selectedCategory = category }
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(.systemGray6))

                List {
                    ForEach(filteredProcedures) { procedure in
                        NavigationLink(destination: ProcedureDetailView(procedure: procedure)) {
                            ProcedureRowView(procedure: procedure)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Procedures")
            .navigationBarItems(trailing: HStack {
                if authManager.currentUser?.role.canEdit == true {
                    Button(action: { showingAddProcedure = true }) {
                        Image(systemName: "plus")
                    }
                }
            })
        }
    }

    private var filteredProcedures: [Procedure] {
        protocolStore.getProcedures(
            for: selectedCategory,
            certificationLevel: authManager.currentUser?.certificationLevel
        )
    }
}

struct ProcedureRowView: View {
    let procedure: Procedure

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(procedure.certificationLevel.color)
                .frame(width: 6)

            VStack(alignment: .leading, spacing: 4) {
                Text(procedure.name)
                    .font(.headline)

                HStack {
                    Text(procedure.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(procedure.certificationLevel.rawValue)
                        .font(.caption)
                        .foregroundColor(procedure.certificationLevel.color)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 8)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ProcedureDetailView: View {
    let procedure: Procedure
    @EnvironmentObject var authManager: AuthenticationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(procedure.name)
                        .font(.title)
                        .fontWeight(.bold)

                    HStack {
                        CertificationBadge(level: procedure.certificationLevel)

                        Text(procedure.category.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                .padding()

                Divider()

                // Indications
                SectionView(title: "Indications") {
                    ForEach(procedure.indications, id: \.self) { indication in
                        BulletPointView(text: indication)
                    }
                }
                .padding(.horizontal)

                // Contraindications
                if !procedure.contraindications.isEmpty {
                    SectionView(title: "Contraindications") {
                        ForEach(procedure.contraindications, id: \.self) { contraindication in
                            BulletPointView(text: contraindication, color: .red)
                        }
                    }
                    .padding(.horizontal)
                }

                Divider()

                // Equipment
                SectionView(title: "Equipment Required") {
                    ForEach(procedure.equipment, id: \.self) { item in
                        BulletPointView(text: item)
                    }
                }
                .padding(.horizontal)

                Divider()

                // Steps
                SectionView(title: "Procedure Steps") {
                    ForEach(procedure.steps.sorted(by: { $0.order < $1.order })) { step in
                        ProcedureStepView(step: step)
                    }
                }
                .padding(.horizontal)

                // Complications
                if !procedure.complications.isEmpty {
                    Divider()

                    SectionView(title: "Potential Complications") {
                        ForEach(procedure.complications, id: \.self) { complication in
                            BulletPointView(text: complication, color: .orange)
                        }
                    }
                    .padding(.horizontal)
                }

                // Educational Points
                if !procedure.educationalPoints.isEmpty {
                    Divider()

                    SectionView(title: "Educational Points") {
                        ForEach(procedure.educationalPoints) { point in
                            EducationalPointView(point: point)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProcedureStepView: View {
    let step: ProcedureStep

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(step.order)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(step.criticalPoint ? Color.red : Color.blue)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(step.instruction)
                    .font(.body)

                if step.criticalPoint {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                        Text("Critical Step")
                            .font(.caption)
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct BulletPointView: View {
    let text: String
    var color: Color = .primary

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .foregroundColor(color)
            Text(text)
                .foregroundColor(color)
        }
        .padding(.vertical, 2)
    }
}
