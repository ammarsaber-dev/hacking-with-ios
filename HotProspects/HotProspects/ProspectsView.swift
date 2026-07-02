//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ammar Saber on 02/07/2026.
//

internal import AVFoundation
import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]

    @Environment(\.editMode) private var editMode

    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State private var sortBy = SortDescriptor(\Prospect.name)

    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted"
        case .uncontacted:
            "Uncontacted"
        }
    }

    var body: some View {
        NavigationStack {
            List(prospects.sorted(using: sortBy), selection: $selectedProspects)
            { prospect in
                NavigationLink {
                    EditProspectView(prospect: prospect)
                } label: {
                    ProspectRowView(filter: filter, prospect: prospect)
                        .swipeActions {
                            Button(
                                "Delete",
                                systemImage: "trash",
                                role: .destructive
                            ) {
                                modelContext.delete(prospect)
                            }
                            .tint(.red)

                            if prospect.isContacted {
                                Button(
                                    "Mark Uncontacted",
                                    systemImage:
                                        "person.crop.circle.badge.xmark"
                                ) {
                                    prospect.isContacted.toggle()
                                }
                                .tint(.blue)
                            } else {
                                Button(
                                    "Mark Contacted",
                                    systemImage:
                                        "person.crop.circle.fill.badge.checkmark"
                                ) {
                                    prospect.isContacted.toggle()
                                }
                                .tint(.green)
                            }

                            Button("Remind Me", systemImage: "bell") {
                                addNotification(for: prospect)
                            }
                            .tint(.orange)
                        }
                }
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }

                ToolbarSpacer(placement: .topBarTrailing)

                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Sort", selection: $sortBy.animation()) {
                            Text("By Name")
                                .tag(SortDescriptor(\Prospect.name))

                            Text("By Date Added")
                                .tag(
                                    SortDescriptor(
                                        \Prospect.dateAdded,
                                        order: .reverse
                                    )
                                )
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                if selectedProspects.isEmpty == false {
                    ToolbarSpacer()
                    ToolbarItem(placement: .topBarLeading) {
                        Button(
                            "Delete Selected",
                            systemImage: "trash",
                            role: .destructive,
                            action: delete
                        )
                        .tint(.red)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "Ammar Saber\nammarsaber.dev@icloud.com",
                    completion: handleScan
                )
            }
        }
    }

    init(filter: FilterType) {
        self.filter = filter

        if filter != .none {
            let showContactedOnly =
                filter == .contacted

            _prospects = Query(
                filter: #Predicate<Prospect> {
                    $0.isContacted == showContactedOnly
                },
                sort: [SortDescriptor(\Prospect.name)]
            )
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect(
                name: details[0],
                emailAddress: details[1],
                isContacted: false
            )
            modelContext.insert(person)

        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }

    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 9

            // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            // for testing
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 5,
                repeats: false
            )

            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )

            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.badge, .alert, .sound]) {
                    success,
                    error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
