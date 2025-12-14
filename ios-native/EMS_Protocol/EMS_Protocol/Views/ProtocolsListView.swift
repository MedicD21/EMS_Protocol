//
//  ProtocolsListView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct ProtocolsListView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var protocolStore: ProtocolStore
    @State private var selectedCategory: ProtocolCategory?
    @State private var showingAddProtocol = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                SearchBar(text: $protocolStore.searchQuery)
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            title: "All",
                            isSelected: selectedCategory == nil,
                            action: { selectedCategory = nil }
                        )

                        ForEach(ProtocolCategory.allCases, id: \.self) { category in
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

                // Protocols List
                List {
                    ForEach(filteredProtocols) { protocol_ in
                        NavigationLink(destination: ProtocolDetailView(protocol: protocol_)) {
                            ProtocolRowView(protocol: protocol_)
                        }
                    }
                    .onDelete(perform: authManager.currentUser?.role.canEdit == true ? deleteProtocols : nil)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Protocols")
            .navigationBarItems(trailing: HStack {
                if authManager.currentUser?.role.canEdit == true {
                    Button(action: { showingAddProtocol = true }) {
                        Image(systemName: "plus")
                    }
                }
            })
            .sheet(isPresented: $showingAddProtocol) {
                ProtocolEditorView(protocol: nil)
                    .environmentObject(protocolStore)
                    .environmentObject(authManager)
            }
        }
    }

    private var filteredProtocols: [EMSProtocol] {
        protocolStore.getProtocols(
            for: selectedCategory,
            certificationLevel: authManager.currentUser?.certificationLevel
        )
    }

    private func deleteProtocols(at offsets: IndexSet) {
        offsets.forEach { index in
            let protocol_ = filteredProtocols[index]
            protocolStore.deleteProtocol(protocol_)
        }
    }
}

struct ProtocolRowView: View {
    let `protocol`: EMSProtocol

    var body: some View {
        HStack(spacing: 12) {
            // Certification Level Color Indicator
            RoundedRectangle(cornerRadius: 4)
                .fill(`protocol`.certificationLevel.color)
                .frame(width: 6)

            VStack(alignment: .leading, spacing: 4) {
                Text(`protocol`.title)
                    .font(.headline)

                HStack {
                    Text(`protocol`.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(`protocol`.certificationLevel.rawValue)
                        .font(.caption)
                        .foregroundColor(`protocol`.certificationLevel.color)
                        .fontWeight(.semibold)
                }

                if !`protocol`.detailedDescription.isEmpty {
                    Text(`protocol`.detailedDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
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

struct CategoryFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .cornerRadius(20)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)

            TextField("Search protocols...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
