//
//  Extensions.swift
//  Vehicles
//
//  Created by Alexandre Carvalho on 11/06/2024.
//

import Foundation
import UIKit

extension UIView {
    func applyDefaultShadow() {
        layer.shadowColor = UIColor.themeColor(.black).cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
    func applyDefaultCornerRadius() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}

extension Array {
    init(repeatingExpression expression: @autoclosure (() -> Element), count: Int) {
        var temp = [Element]()
        for _ in 0..<count {
            temp.append(expression())
        }
        self = temp
    }
}

extension DispatchQueue {

    enum Tread { case main, background }

    static func executeWithDelay(tread: Tread = .main, delay: Double = 0.5, block: @escaping () -> Void) {
        if tread == .main {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { block() }
        } else {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).asyncAfter(deadline: .now() + delay) { block() } }
    }

    static func executeIn(tread: Tread, block: @escaping () -> Void) {
        if tread == .main {
            executeInMainTread(block)
        } else { executeInBackgroundTread(block) }
    }

    static func executeInMainTread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: { block() })
    }

    static func executeInBackgroundTread(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: { block(); })
    }
}

extension UIColor {
    static func themeColor(_ name: AppColors) -> UIColor {
        return UIColor(named: name.rawValue.firstUppercased) ?? .red
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

extension String {
    func getFormattedDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: self) {
            return date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
        }
        return nil
    }
}

extension Date {
    func getFormattedDate(format: String = "yyyy-MM-dd") -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}

extension String {
    func mapToDate() -> Date? {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateformat.date(from: self)
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
