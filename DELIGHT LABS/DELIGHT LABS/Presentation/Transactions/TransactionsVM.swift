//
//  TransactionsVM.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//


import Foundation
import RxSwift
import RxCocoa


class TransactionsVM: BaseVM {
    enum Selected {
        case all
        case expense
        case income
    }
    
    struct Input {
        // Void
        let tapList = BehaviorRelay<Selected>(value: .all)
    }
    
    struct Output {
        // Void
        let tapList = PublishRelay<Selected>()
        
        // Data
        let bindList = BehaviorRelay<[TransactionsModel]>(value: [])
    }
    
    let input: Input
    let output: Output
    
    private var transactionsList: [TransactionsModel] = []
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
        self.input
            .tapList
            .bind { [weak self] selected in
                guard let self = self else { return }
                
                let displayList: [TransactionsModel]
                
                switch selected {
                case .all:
                    displayList = transactionsList
                        .splitRange(20)
                case .expense:
                    displayList = transactionsList
                        .filter{ !$0.isPositive }
                        .splitRange(10)
                case .income:
                    displayList = transactionsList
                        .filter{ $0.isPositive }
                        .splitRange(10)
                }
                
                self.output.tapList.accept(selected)
                self.output.bindList.accept(displayList)
            }.disposed(by: bag)
        
        getTransactions()
    }
    
    private func getTransactions() {
        JsonLoader.shared.loadJson { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.task([TransactionsDto.Response].self, data: data) { res in
                    
                    let convertList = res.map { item in
                        
                        let isPositive = Double(item.amount) ?? 0 > 0
                        let amount = item.amount.toDollar(isPositive)
                        let time = item.timestamp.toDate.toString()
                            
                        let newItem = TransactionsModel(
                            amount: amount,
                            name: item.name,
                            time: time,
                            type: item.type,
                            isPositive: isPositive
                        )
                        
                        return newItem
                    }
                    
                    self.transactionsList = convertList.reversed()
                    self.input.tapList.accept(.all)
                }
            case .failure(let error):
                self.error.accept(error)
            }
        }
    }
}
