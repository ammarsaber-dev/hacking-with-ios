//
//  ProspectRowView.swift
//  HotProspects
//
//  Created by Ammar Saber on 02/07/2026.
//

import SwiftUI

struct ProspectRowView: View {
    let filter: FilterType
    let prospect: Prospect

    var body: some View {
        HStack {
            if filter == .none {
                Image(
                    systemName: prospect.isContacted
                        ? "person.crop.circle.fill.badge.checkmark"
                        : "person.crop.circle.badge.xmark"
                )
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundStyle(prospect.isContacted ? .green : .red)
            }
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.emailAddress)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ProspectRowView(filter: .none, prospect: .example)
}
