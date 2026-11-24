//
//  ProfileView.swift
//  MusicPreview
//
//  Created by Deanira Fadrinaldi on 07/11/26.
//

import SwiftUI

public struct ProfileView: View {
  @EnvironmentObject var viewModel: ProfileViewModel

  @State private var isEditing = false
  @State private var draftName = ""
  @State private var draftBio = ""

  private var canSave: Bool {
    !draftName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }

  public init() { }

  public var body: some View {
    Group {
      if isEditing {
        editForm
      } else {
        profileInfo
      }
    }
    .navigationTitle("common_title_profile".localized())
    .navigationBarBackButtonHidden(isEditing)
    .toolbar {
      if isEditing {
        ToolbarItem(placement: .topBarLeading) {
          Button("common_action_cancel".localized()) {
            withAnimation(.easeInOut(duration: 0.3)) {
              isEditing = false
            }
          }
        }
      }
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: toolbarTapped) {
          Image(systemName: isEditing ? "checkmark" : "pencil.line")
            .foregroundStyle(.blue)
        }
        .disabled(isEditing && !canSave)
      }
    }
    .onAppear { viewModel.load() }
    .alert(
      "generalError_title".localized(),
      isPresented: Binding(
        get: { viewModel.errorMessage != nil },
        set: { if !$0 { viewModel.errorMessage = nil } }
      )
    ) {
      Button("common_action_ok".localized(), role: .cancel) {}
    } message: {
      Text(viewModel.errorMessage ?? "")
    }
  }

  private var profileInfo: some View {
    VStack(alignment: .leading, spacing: 16) {
      if let avatarFileName = viewModel.profile.avatarFileName {
        Image(avatarFileName, bundle: .module)
          .resizable()
          .scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 12))
          .shadow(radius: 12, y: 6)
          .padding(.horizontal, 32)
      }

      VStack(alignment: .leading, spacing: 4) {
        Text("profile_label_name".localized())
          .font(.caption)
          .foregroundStyle(.secondary)
        Text(viewModel.profile.displayName)
          .font(.title2.bold())
      }
      VStack(alignment: .leading, spacing: 4) {
        Text("profile_label_bio".localized())
          .font(.caption)
          .foregroundStyle(.secondary)
        Text(viewModel.profile.bio.isEmpty ? "-" : viewModel.profile.bio)
      }
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
  }

  private var editForm: some View {
    Form {
      Section("profile_label_name".localized()) {
        TextField("profile_prompt_name".localized(), text: $draftName)
          .textInputAutocapitalization(.words)
      }
      Section("profile_label_bio".localized()) {
        TextField("profile_prompt_bio".localized(), text: $draftBio, axis: .vertical)
          .lineLimit(3...6)
      }
    }
  }

  // MARK: - Actions
  private func toolbarTapped() {
    if isEditing {
      let updated = ProfileModel(
        displayName: draftName.trimmingCharacters(in: .whitespacesAndNewlines),
        bio: draftBio.trimmingCharacters(in: .whitespacesAndNewlines),
        avatarFileName: viewModel.profile.avatarFileName
      )
      viewModel.save(updated) {
        withAnimation(.easeInOut(duration: 0.3)) {
          isEditing = false
        }
      }
    } else {
      draftName = viewModel.profile.displayName
      draftBio = viewModel.profile.bio
      withAnimation(.easeInOut(duration: 0.3)) {
        isEditing = true
      }
    }
  }
}
