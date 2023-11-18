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
        transactionsView.vChart.btnDay // day
            .rx
            .tap
            .map { true }
            .bind(to: vm.input.tapIsDay)
            .disposed(by: vm.bag)
        
        transactionsView.vChart.btnMonth // month
            .rx
            .tap
            .map { false }
            .bind(to: vm.input.tapIsDay)
            .disposed(by: vm.bag)
        
        transactionsView.vList.btnAll // all
            .rx
            .tap
            .map { .all }
            .bind(to: vm.input.tapList)
            .disposed(by: vm.bag)
        
        transactionsView.vList.btnExpense // expense
            .rx
            .tap
            .map { .expense }
            .bind(to: vm.input.tapList)
            .disposed(by: vm.bag)
        
        transactionsView.vList.btnIncome // income
            .rx
            .tap
            .map { .income }
            .bind(to: vm.input.tapList)
            .disposed(by: vm.bag)
        
        vm.output
            .tapIsDay // chartView data 전달
            .bind { [weak self] data in
                guard let self = self else { return }
                
                self.transactionsView.setIndicatorPosition(data)
            }.disposed(by: vm.bag)
        
        vm.output
            .tapList // 리스트 버튼 색 변경
            .bind { [weak self] selected in
                guard let self = self else { return }
                
                self.transactionsView.setListBtnColor(selected)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindList // 리스트
            .bind(to: transactionsView.vList.tvList
                .rx
                .items(cellIdentifier: TransactionsCell.id,
                       cellType: TransactionsCell.self)
            ) { (row, data, cell) in
                
                cell.setValue(data)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindList // 리스트 높이
            .bind { [weak self] list in
                guard let self = self else { return }
                
                self.transactionsView.setListHeight(list.count)
            }.disposed(by: vm.bag)
    }
}
