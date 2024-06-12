//
//  AlertViewController.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 12/06/2024.
//

import UIKit

class AlertViewController: UIViewController {

    // MARK: - UI Elements

    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Choose a make",
                                                message: "",
                                                preferredStyle: .alert)

        alertController.setValue(self, forKey: "contentViewController")
        alertController.addAction(confirmAlertAction)
        alertController.addAction(cancelAlertAction)
        return alertController
    }()

    private lazy var confirmAlertAction: UIAlertAction = {
        let alertAction = UIAlertAction(title: "Confirm",
                                        style: .default) { _ in
            self.selectedItemCompletionHandler(self.selectedItem)
        }
        return alertAction
    }()

    private lazy var cancelAlertAction: UIAlertAction = {
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        return alertAction
    }()

    // MARK: - Attributes

    private var pickerList: [String] = []
    private var selectedItem: String
    private var selectedItemCompletionHandler: ((String) -> Void)
    private var parentVC: UIViewController

    // MARK: - Init methods

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ parentViewController: UIViewController, itemsList: [String], selectedItem: String, itemWasChanged: @escaping ((String) -> Void)) {
        self.selectedItem = selectedItem
        self.parentVC = parentViewController
        self.selectedItemCompletionHandler = itemWasChanged

        super.init(nibName: nil, bundle: nil)

        preferredContentSize = CGSize(width: 250, height: 250)
        self.pickerList = itemsList
        self.pickerList.insert("None", at: 0)
        setupPickerView()
    }

    // MARK: - Private methods


    private func setupPickerView() {
        pickerView.frame = CGRect(x: .zero, y: .zero, width: preferredContentSize.width, height: preferredContentSize.height - 30)
        view.addSubview(pickerView)

        if let selectedIndex = pickerList.firstIndex(where: { $0 == selectedItem }) {
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }

    // MARK: - Public methods

    func show() {
        parentVC.present(alertController, animated: true)
    }
}

// MARK: - UIPickerViewDelegate

extension AlertViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = pickerList[row]
    }
}

// MARK: - UIPickerViewDataSource

extension AlertViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerList.count
    }
}
