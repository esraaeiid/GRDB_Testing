//
//  Coordinator.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 13/02/2021.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
