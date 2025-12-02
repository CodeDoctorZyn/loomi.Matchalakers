//
//  ProfileView.swift
//  loomi
//
//  Created by Zayn on 2/12/2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var name: String = "Beck"
    @State private var notificationsEnabled: Bool = true

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Avatar and name
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color(.secondarySystemBackground))
                            .frame(width: 100, height: 100)
                        Image(systemName: "person.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(.secondary)
                    }
                    TextField("Your name", text: $name)
                        .font(.title2.weight(.semibold))
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 24)
                }

                // Settings
                VStack(spacing: 12) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Notifications")
                    }
                    .toggleStyle(.switch)

                    NavigationLink {
                        Text("Account Details")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemBackground))
                    } label: {
                        HStack {
                            Image(systemName: "person.text.rectangle")
                            Text("Account")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                    }

                    NavigationLink {
                        Text("Privacy Settings")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemBackground))
                    } label: {
                        HStack {
                            Image(systemName: "lock.shield")
                            Text("Privacy")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 24)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView()
}
