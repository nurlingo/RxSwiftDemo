//
//  AddHabitController.swift
//  RxDemo
//
//  Created by Nursultan on 20/11/2019.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddHabitController: UIViewController {
    
    private let habitTitleBehaviourRelay = BehaviorRelay<String>(value: "")
    var habitTitle: Observable<String> {
        return habitTitleBehaviourRelay.asObservable().filter { (title) -> Bool in
            !title.isEmpty
        }
    }
    
    // MARK: - UI objects
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your habit here..."
        textField.font = UIFont.boldSystemFont(ofSize: 21)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 24.0
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle methods
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    
    // MARK: - UI methods
    
    func setupViews() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            titleTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            titleTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0)
        ])
        
        self.view.addSubview(createButton)
                
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 16.0),
            createButton.centerXAnchor.constraint(equalTo: self.titleTextField.centerXAnchor, constant: 0),
            createButton.heightAnchor.constraint(equalToConstant: 48.0),
            createButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    @objc func createTapped() {
        guard let text = titleTextField.text, !text.isEmpty else { return }
        habitTitleBehaviourRelay.accept(text)
        navigationController?.popViewController(animated: true)
    }
    
}
