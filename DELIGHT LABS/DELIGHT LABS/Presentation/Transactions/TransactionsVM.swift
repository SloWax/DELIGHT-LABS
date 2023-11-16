//
//  TransactionsVM.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//
//delightlabs-ios-hometest-mockdata


import Foundation
import RxSwift
import RxCocoa


class TransactionsVM: BaseVM {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
    }
}
