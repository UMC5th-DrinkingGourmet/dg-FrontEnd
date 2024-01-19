//
//  TodayCombinationDetailViewController.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 1/18/24.
//

import UIKit

class TodayCombinationDetailViewController: UIViewController {
    
    private let todayCombinationDetailView = TodayCombinationDetailView()

    override func loadView() {
        view = todayCombinationDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    
}
