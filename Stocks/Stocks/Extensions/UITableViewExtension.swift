//
//  UITableViewExtension.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import UIKit

extension UITableView {
    func register(for aClass: AnyClass) {
        let identifier = String(describing: aClass)
        register(
            UINib(nibName: identifier, bundle: Bundle(for: aClass)),
            forCellReuseIdentifier: identifier
        )
    }
}
