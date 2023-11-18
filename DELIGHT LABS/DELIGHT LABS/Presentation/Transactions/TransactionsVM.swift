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
        
        /*
         여기부턴 현재시간에 도달한 내역을 mockData로부터
         불러와 알림과 화면 새로고침을 구현하기 위한 코드로
         실제 운영에선 사용되지 않는 방식
         */
        
        Observable<Int>
            .interval(.seconds(60), scheduler: MainScheduler.instance)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe { [weak self] (value: Int) in
                guard let self = self else { return }
                
                let untilList = allList.filter { $0.time < Date() }
                self.untilList = untilList
                
                if let item = untilList.last {
                    let name = item.name
                    let amount = "\(item.amount)".toDollar(item.isPositive)
                    let subtitle = "\(name) \(amount)"
                    let interval = DateInterval(start: Date(), end: Date().addingTimeInterval(1.0))
                    let duration = interval.duration

                    self.addNotification(
                        identifier: "Transactions",
                        title: "새로운 거래내역이 발생했어요",
                        subtitle: subtitle,
                        timeInterval: duration
                    )
                }
                
                DispatchQueue.main.async {
                    let isDayEvent = self.input.tapIsDay.value
                    self.input.tapIsDay.accept(isDayEvent)
                    
                    let listEvent = self.input.tapList.value
                    self.input.tapList.accept(listEvent)
                }
            }.disposed(by: bag)
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
                        
                        let isDayEvent = self.input.tapIsDay.value
                        self.input.tapIsDay.accept(isDayEvent)
                        
                        let listEvent = self.input.tapList.value
                        self.input.tapList.accept(listEvent)
                    }
                }
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.error.accept(error)
            }.disposed(by: bag)
    }
    
    private func addNotification(identifier: String, title: String, subtitle: String = "", badge: NSNumber = 1, timeInterval: TimeInterval, repeats: Bool = false) {
        let push =  UNMutableNotificationContent()
        
        push.title = title
        push.subtitle = subtitle
        push.badge = badge
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        let request = UNNotificationRequest(identifier: identifier, content: push, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
