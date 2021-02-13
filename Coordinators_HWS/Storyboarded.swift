//
//  Storyboarded.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 13/02/2021.
//

import UIKit

protocol Storyboarded{
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self{
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: className) as! Self
    }
}
