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
        let tapIsDay = BehaviorRelay<Bool>(value: true)
        let tapList = BehaviorRelay<Selected>(value: .all)
    }
    
    struct Output {
        // Void
        let tapIsDay = PublishRelay<(isDay: Bool, data: [TransactionsModel])>()
        let tapList = PublishRelay<Selected>()
        
        // Data
        let bindList = BehaviorRelay<[TransactionsModel]>(value: [])
    }
    
    let input: Input
    let output: Output
    
    private var allList: [TransactionsModel] = []
    private var untilList: [TransactionsModel] = []
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
        self.input
            .tapIsDay
            .bind { [weak self] isDay in
                guard let self = self else { return }
                
                let fromDate = isDay ?
                Calendar.current.date(byAdding: .hour, value: -24, to: Date()) :
                Calendar.current.date(byAdding: .month, value: -1, to: Date())
                
                if let fromDate = fromDate {

                    let timeFilterList = self.untilList
                        .filter { fromDate < $0.time }
                    
                    let event = (isDay, timeFilterList)
                    self.output.tapIsDay.accept(event)
                }
            }.disposed(by: bag)
        
        self.input
            .tapList
            .bind { [weak self] selected in
                guard let self = self else { return }
                
                let displayList: [TransactionsModel]
                
                switch selected {
                case .all:
                    displayList = untilList
                        .reversed()
                        .splitRange(20)
                case .expense:
                    displayList = untilList
                        .reversed()
                        .filter{ !$0.isPositive }
                        .splitRange(10)
                case .income:
                    displayList = untilList
                        .reversed()
                        .filter{ $0.isPositive }
                        .splitRange(10)
                }
                
                self.output.tapList.accept(selected)
                self.output.bindList.accept(displayList)
            }.disposed(by: bag)
        
        getTransactions()
    }
    
    private func getTransactions() {
        JsonLoader.shared
            .loadJson()
            .subscribe { [weak self] data in
                guard let self = self else { return }
                
                self.task([TransactionsDto.Response].self, data: data) { res in
                    
                    let convertList = res
                        .map { item in
                            
                            let amount = Double(item.amount) ?? 0
                            let isPositive = amount > 0
                            let time = item.timestamp.toDate
                            
                            let newItem = TransactionsModel(
                                amount: amount,
                                name: item.name,
                                time: time,
                                type: item.type,
                                isPositive: isPositive
                            )
                            
                            return newItem
                        }
                    
                    let untilList = convertList.filter { $0.time < Date() }
                    
                    DispatchQueue.main.async {
                        self.allList = convertList
                        self.untilList = untilList
                        self.input.tapList.accept(.all)
                    }
                }
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.error.accept(error)
            }.disposed(by: bag)
    }
}
