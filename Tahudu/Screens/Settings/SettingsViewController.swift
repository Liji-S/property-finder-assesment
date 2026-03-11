//
//  SettingsViewController.swift
//  Tahudu
//

import Foundation
import UIKit

final class SettingsViewController: UITableViewController {
    private lazy var sections: [SettingsSection] = makeSections()

    override func loadView() {
        super.loadView()

        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in _: UITableView) -> Int {
        sections.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        let cell = UITableViewCell(style: row.cellStyle, reuseIdentifier: nil)

        configure(cell, with: row)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].rows[indexPath.row].selection()
    }
}

private extension SettingsViewController {
    func makeSections() -> [SettingsSection] {
        [
            SettingsSection(rows: [
                SettingsRow(
                    title: "Language",
                    detail: currentLanguageDisplayName,
                    systemImageName: "textformat",
                    accessibilityIdentifier: "SettingsCell_language",
                    cellStyle: .value1,
                    selection: openSystemSettings
                ),
                SettingsRow(
                    title: "Country",
                    detail: "United Arab Emirates",
                    systemImageName: "globe",
                    accessibilityIdentifier: "SettingsCell_country",
                    cellStyle: .value1,
                    selection: showCountrySelectionScreen
                ),
                SettingsRow(
                    title: "Notifications",
                    systemImageName: "app.badge",
                    accessibilityIdentifier: "SettingsCell_notifications",
                    selection: showNotificationScreen
                )
            ]),
            SettingsSection(rows: [
                SettingsRow(
                    title: "About",
                    systemImageName: "info.circle",
                    accessibilityIdentifier: "SettingsCell_about",
                    selection: showAboutScreen
                ),
                SettingsRow(
                    title: "Feedback",
                    systemImageName: "text.bubble",
                    accessibilityIdentifier: "SettingsCell_feedback",
                    selection: showFeedbackScreen
                )
            ])
        ]
    }

    var currentLanguageDisplayName: String? {
        guard let languageCode = Bundle.main.preferredLocalizations.first else {
            return nil
        }

        return Locale.current.localizedString(forLanguageCode: languageCode)
    }

    func configure(_ cell: UITableViewCell, with row: SettingsRow) {
        cell.accessibilityIdentifier = row.accessibilityIdentifier
        cell.backgroundColor = .systemBackground
        cell.selectionStyle = .default
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(systemName: row.systemImageName)
        cell.textLabel?.text = row.title
        cell.textLabel?.textColor = .label
        cell.textLabel?.textAlignment = .natural
        cell.detailTextLabel?.text = row.detail
        cell.detailTextLabel?.textColor = .secondaryLabel
    }
}

private struct SettingsSection {
    let rows: [SettingsRow]
}

private struct SettingsRow {
    let title: String
    let detail: String?
    let systemImageName: String
    let accessibilityIdentifier: String
    let cellStyle: UITableViewCell.CellStyle
    let selection: () -> Void

    init(
        title: String,
        detail: String? = nil,
        systemImageName: String,
        accessibilityIdentifier: String,
        cellStyle: UITableViewCell.CellStyle = .default,
        selection: @escaping () -> Void
    ) {
        self.title = title
        self.detail = detail
        self.systemImageName = systemImageName
        self.accessibilityIdentifier = accessibilityIdentifier
        self.cellStyle = cellStyle
        self.selection = selection
    }
}

// ===============================

/// NO NEED TO TUOCH THIS!!!
extension SettingsViewController {
    private func openSystemSettings() {
        print(#function)
    }

    private func showCountrySelectionScreen() {
        print(#function)
    }

    private func showNotificationScreen() {
        print(#function)
    }

    private func showAboutScreen() {
        print(#function)
    }

    private func showFeedbackScreen() {
        print(#function)
    }
}
