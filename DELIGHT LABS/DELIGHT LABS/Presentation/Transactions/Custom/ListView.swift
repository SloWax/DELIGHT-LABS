//
//  ListView.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//


import UIKit
import SnapKit
import Then


class ListView: UIView {
    
    private let lblRecent = UILabel().then {
        $0.text = "Recent Transactions"
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    let btnAll = UIButton().then {
        $0.setTitle("All", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    let btnExpense = UIButton().then {
        $0.setTitle("Expense", for: .normal)
        $0.setTitleColor(.systemGray4, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    let btnIncome = UIButton().then {
        $0.setTitle("Income", for: .normal)
        $0.setTitleColor(.systemGray4, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    let tvList = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorColor = .clear
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(TransactionsCell.self, forCellReuseIdentifier: TransactionsCell.id)
    }
    
    lazy var btns = [btnAll, btnExpense, btnIncome]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let views = [
            lblRecent,
            btnAll, btnExpense, btnIncome,
            tvList
        ]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        lblRecent.snp.makeConstraints { make in
            make.top.left.equalTo(self).inset(15)
        }
        
        btnAll.snp.makeConstraints { make in
            make.top.equalTo(lblRecent.snp.bottom).offset(15)
            make.left.equalTo(lblRecent).offset(-5)
        }
        
        btnExpense.snp.makeConstraints { make in
            make.centerY.equalTo(btnAll)
            make.left.equalTo(btnAll.snp.right).offset(15)
        }
        
        btnIncome.snp.makeConstraints { make in
            make.centerY.equalTo(btnExpense)
            make.left.equalTo(btnExpense.snp.right).offset(15)
        }
        
        tvList.snp.makeConstraints { make in
            make.top.equalTo(btnAll.snp.bottom).offset(15)
            make.height.equalTo(0)
            make.left.right.bottom.equalTo(self)
        }
    }
}
