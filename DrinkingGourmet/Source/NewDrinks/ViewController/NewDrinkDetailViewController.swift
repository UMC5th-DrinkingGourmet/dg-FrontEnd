////
////  NewDrinkDetailViewController.swift
////  DrinkingGourmet
////
////  Created by hee on 2/21/24.
////
//
//import UIKit
//
//class NewDrinkDetailViewController: UIViewController {
//
//    private let newDrinkDetailView = NewDrinkDetailView()
//    
//    // MARK: - View 설정
//    override func loadView() {
//        view = newDrinkDetailView
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationSet()
//        prepare()
//    }
//    
//    func navigationSet() {
//        title = "새로 출시된 주류"
//                
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.baseColor.base01]
//        navigationController?.navigationBar.tintColor = UIColor.baseColor.base01
//        navigationController?.navigationBar.isTranslucent = true
//        
//        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
//        navigationItem.leftBarButtonItem = backButton
//    }
//    func prepare() {
//        view.backgroundColor = UIColor.baseColor.base10
//        newDrinkDetailView.scrollView.delegate = self
// 
//    }
//    // MARK: - Navigation
//    @objc func backButtonPressed() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//extension NewDrinkDetailViewController: UIScrollViewDelegate {
//
//}
