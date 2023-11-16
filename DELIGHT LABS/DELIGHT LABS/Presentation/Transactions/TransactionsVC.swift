//
//  TransactionsVC.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/16.
//


import UIKit
import RxSwift
import RxCocoa


class TransactionsVC: BaseMainVC {
    private let transactionsView = TransactionsView()
    private let vm = TransactionsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func initialize() {
        view = transactionsView
    }
    
    private func bind() {
        
    }
}
