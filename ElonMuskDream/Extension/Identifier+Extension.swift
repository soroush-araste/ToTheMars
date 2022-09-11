//
//  Identifier+Extension.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/8/22.
//

import Foundation

import UIKit

protocol ReuseIdentifiable {
    var identifier: String { get }
    static var identifier : String { get }
}

extension ReuseIdentifiable {
    var identifier: String {
        return String(describing: type(of: self))
    }
    
    static var identifier : String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
