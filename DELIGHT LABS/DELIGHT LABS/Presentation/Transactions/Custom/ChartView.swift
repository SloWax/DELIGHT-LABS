//
//  ChartView.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//


import UIKit
import SnapKit
import Then


class ChartView: UIView {
    
    private let vDate = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
    }
    
    let vIndicator = UIView().then {
        $0.backgroundColor = .purple
        $0.clipsToBounds = true
    }
    
    let btnDay = UIButton().then {
        $0.setTitle("Day", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    let btnMonth = UIButton().then {
        $0.setTitle("Month", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    private let lblDate = UILabel().then {
        $0.text = Date().toString(dateFormat: "MMM dd, YYYY")
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let vIncome = UIView().then {
        $0.backgroundColor = .purple
    }
    
    private let lblIncome = UILabel().then {
        $0.text = "Income"
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let vExpense = UIView().then {
        $0.backgroundColor = .green
    }
    
    private let lblExpense = UILabel().then {
        $0.text = "InExpense"
        $0.font = .systemFont(ofSize: 12)
    }
    
    let vChartMother = UIView().then {
        $0.clipsToBounds = true
    }
    
    let lblfromAt = UILabel().then {
        $0.text = "00"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    let lblUntilAt = UILabel().then {
        $0.text = "24"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    var vIndicatorConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = vDate.frame.height / 2
        vDate.cornerRadius = radius
        vIndicator.cornerRadius = radius
    }
    
    private func setUP() {
        let dateViews = [
            vIndicator, btnDay, btnMonth
        ]
        
        vDate.addSubviews(dateViews)
        
        let views = [
            vDate, lblDate,
            vIncome, lblIncome, vExpense, lblExpense,
            vChartMother, lblfromAt, lblUntilAt
        ]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        vIndicator.snp.makeConstraints { make in
            make.top.bottom.equalTo(vDate)
            make.width.equalTo(vDate).multipliedBy(0.5)
            vIndicatorConstraint = make.left.equalTo(vDate).constraint
        }
        
        btnDay.snp.makeConstraints { make in
            make.top.bottom.equalTo(vDate)
            make.width.equalTo(vDate).multipliedBy(0.5)
            make.left.equalTo(vDate)
        }
        
        btnMonth.snp.makeConstraints { make in
            make.centerY.width.equalTo(btnDay)
            make.left.equalTo(btnDay.snp.right)
            make.right.equalTo(vDate)
        }
        
        vDate.snp.makeConstraints { make in
            make.top.left.equalTo(self).inset(15)
            make.right.equalTo(self.snp.centerX)
        }
        
        lblDate.snp.makeConstraints { make in
            make.centerY.equalTo(vDate)
            make.right.equalTo(self).inset(15)
        }
        
        vIncome.snp.makeConstraints { make in
            make.top.equalTo(vDate.snp.bottom).offset(15)
            make.left.equalTo(vDate)
            make.width.equalTo(30)
            make.height.equalTo(2.5)
        }
        
        lblIncome.snp.makeConstraints { make in
            make.centerY.equalTo(vIncome)
            make.left.equalTo(vIncome.snp.right).offset(5)
        }
        
        vExpense.snp.makeConstraints { make in
            make.centerY.width.height.equalTo(vIncome)
            make.left.equalTo(lblIncome.snp.right).offset(10)
        }
        
        lblExpense.snp.makeConstraints { make in
            make.centerY.equalTo(vIncome)
            make.left.equalTo(vExpense.snp.right).offset(5)
        }
        
        vChartMother.snp.makeConstraints { make in
            make.top.equalTo(vIncome.snp.bottom).offset(15)
            make.left.right.equalTo(self).inset(15)
            make.height.equalTo(vChartMother.snp.width).multipliedBy(0.75)
        }
        
        lblfromAt.snp.makeConstraints { make in
            make.top.equalTo(vChartMother.snp.bottom).offset(15)
            make.left.equalTo(vChartMother)
            make.bottom.equalTo(self)
        }
        
        lblUntilAt.snp.makeConstraints { make in
            make.centerY.equalTo(lblfromAt)
            make.right.equalTo(vChartMother)
        }
    }
}
