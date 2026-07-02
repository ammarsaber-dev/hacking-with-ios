//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Ammar Saber on 02/07/2026.
//

import SwiftUI

struct EditProspectView: View {
    @Bindable var prospect: Prospect

    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
                .textContentType(.name)

            TextField("Email Address", text: $prospect.emailAddress)
                .textContentType(.emailAddress)
        }
        .navigationTitle("Edit Prospect")
    }
}

#Preview {
    EditProspectView(prospect: .example)
}
