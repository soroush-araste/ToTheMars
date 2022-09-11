//
//  UITableView+Extension.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/10/22.
//

import UIKit

extension UITableView {
    func setEmptyMessage() {
        let emptyListView = EmptyListView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        self.backgroundView = emptyListView
    }

    func restore() {
        self.backgroundView = nil
    }
}
