//
//  FiltersViewController.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import Foundation
import UIKit

class FiltersViewController: UIViewController {

    // MARK: - Properties

    private var makes: [String]
    private var selectedMake: String?
    private var startingBidRange: (min: Float, max: Float) = (0, 10000)
    private var showFavouritesOnly: Bool = false

    private let makePicker = UIPickerView()
    private let minBidSlider = UISlider()
    private let maxBidSlider = UISlider()
    private let favouritesSwitch = UISwitch()
    private let minBidLabel = UILabel()
    private let maxBidLabel = UILabel()

    private var filterAppliedAction: ((_ selectedMake: String?, _ startingBidRange: (min: Float, max: Float), _ showFavouritesOnly: Bool) -> Void)?

    // MARK: - Lifecycle

    init(currentList: [Vehicle], filterAppliedAction: ((_ selectedMake: String?, _ startingBidRange: (min: Float, max: Float), _ showFavouritesOnly: Bool) -> Void)?) {
        self.makes = (currentList.map { $0.make.rawValue }).unique()

        self.filterAppliedAction = filterAppliedAction
        super.init(nibName: nil, bundle: nil)
        
        setupSliders(currentList)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .white

        // Make Picker
        makePicker.dataSource = self
        makePicker.delegate = self
        view.addSubview(makePicker)
        makePicker.topToSuperview(offset: 16, usingSafeArea: true)
        makePicker.leadingToSuperview(offset: 16)
        makePicker.trailingToSuperview(offset: 16)
        makePicker.height(320)

        // Starting Bid Sliders
        view.addSubview(minBidSlider)
        minBidSlider.topToBottom(of: makePicker, offset: 16)
        minBidSlider.leadingToSuperview(offset: 16)
        minBidSlider.trailingToSuperview(offset: 16)

        view.addSubview(maxBidSlider)
        maxBidSlider.topToBottom(of: minBidSlider, offset: 16)
        maxBidSlider.leadingToSuperview(offset: 16)
        maxBidSlider.trailingToSuperview(offset: 16)

        // Min Bid Label
        minBidLabel.text = "Min: \(Int(startingBidRange.min))"
        minBidLabel.textColor = .black
        view.addSubview(minBidLabel)
        minBidLabel.topToBottom(of: minBidSlider, offset: 8)
        minBidLabel.leadingToSuperview(offset: 16)

        // Max Bid Label
        maxBidLabel.text = "Max: \(Int(startingBidRange.max))"
        maxBidLabel.textColor = .black
        view.addSubview(maxBidLabel)
        maxBidLabel.topToBottom(of: maxBidSlider, offset: 8)
        maxBidLabel.leadingToSuperview(offset: 16)

        // Favourites Switch
        view.addSubview(favouritesSwitch)
        favouritesSwitch.topToBottom(of: maxBidSlider, offset: 16)
        favouritesSwitch.centerXToSuperview()

        // Apply Filters Button
        let applyButton = UIButton(type: .system)
        applyButton.setTitle("Apply Filters", for: .normal)
        applyButton.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        applyButton.backgroundColor = .systemBlue
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 8
        applyButton.clipsToBounds = true
        view.addSubview(applyButton)
        applyButton.leadingToSuperview(offset: 16)
        applyButton.trailingToSuperview(offset: 16)
        applyButton.height(50)
        applyButton.bottomToSuperview(offset: -24, usingSafeArea: true)
    }
    
    private func setupSliders(_ currentList: [Vehicle]) {
        let ranges = currentList.map { $0.startingBid }
        
        startingBidRange = (Float(ranges.min()!), Float(ranges.max()!))
        
        minBidSlider.minimumValue = Float(ranges.min()!)
        minBidSlider.maximumValue = Float(ranges.max()!)
        
        maxBidSlider.minimumValue = Float(ranges.min()!)
        maxBidSlider.maximumValue = Float(ranges.max()!)
        
        minBidSlider.value = Float(ranges.min()!)
        minBidSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        maxBidSlider.value = Float(ranges.max()!)
        maxBidSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }

    // MARK: - Actions

    @objc private func applyFilters() {
        filterAppliedAction?(selectedMake, startingBidRange, showFavouritesOnly)
        dismiss(animated: true, completion: nil)
    }

    @objc private func sliderValueChanged(_ sender: UISlider) {
        if sender == minBidSlider {
            startingBidRange.min = sender.value
            maxBidSlider.minimumValue = sender.value
            minBidLabel.text = "Min: \(Int(startingBidRange.min))"
        } else if sender == maxBidSlider {
            startingBidRange.max = sender.value
            minBidSlider.maximumValue = sender.value
            maxBidLabel.text = "Max: \(Int(startingBidRange.max))"
        }
    }

    @objc private func favouritesSwitchChanged(_ sender: UISwitch) {
        showFavouritesOnly = sender.isOn
    }
}

// MARK: - UIPickerViewDataSource and UIPickerViewDelegate

extension FiltersViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return makes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return makes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMake = makes[row]
    }
}


