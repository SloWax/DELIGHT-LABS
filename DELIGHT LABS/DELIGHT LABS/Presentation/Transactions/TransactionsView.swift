//
//  TransactionsView.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//


import UIKit
import SnapKit
import Then


class TransactionsView: BaseView {
    
    private let vTitle = UIView()
    
    private let lblTitle = UILabel().then {
        $0.text = "Activity"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    private let btnBell = UIButton().then {
        let image = UIImage(systemName: "bell")
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    private let svMother = UIScrollView()
    
    private let svStack = UIStackView().then {
        $0.axis = .vertical
    }
    
    let vChart = ChartView()
    
    let vList = ListView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let titleViews = [
            lblTitle, btnBell
        ]
        
        vTitle.addSubviews(titleViews)
        
        let arrangedSubviews = [
            vChart, vList
        ]
        
        svStack.addArrangedSubviews(arrangedSubviews)
        
        svMother.addSubview(svStack)
        
        let views = [
            vTitle, svMother
        ]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        vTitle.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(vTitle).inset(15)
        }
        
        btnBell.snp.makeConstraints { make in
            make.centerY.equalTo(lblTitle)
            make.right.equalTo(vTitle).inset(15)
            make.width.height.equalTo(25)
        }
        
        svMother.snp.makeConstraints { make in
            make.top.equalTo(vTitle.snp.bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        svStack.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.bottom.equalTo(svMother)
        }
    }
    
    func setIndicatorPosition(_ value: (isDay: Bool, data: [TransactionsModel])) {
        let dayColor: UIColor = value.isDay ? .white : .gray
        let monthColor: UIColor = value.isDay ? .gray : .white
        let offset = value.isDay ? 0 : vChart.vIndicator.frame.width
        let fromAtText = value.isDay ? "00" : value.data.first?.time.toString(dateFormat: "MMM dd")
        let untilAtText = value.isDay ? "24" : value.data.last?.time.toString(dateFormat: "MMM dd")
        
        vChart.btnDay.setTitleColor(dayColor, for: .normal)
        vChart.btnMonth.setTitleColor(monthColor, for: .normal)
        vChart.vIndicatorConstraint?.update(offset: offset)
        vChart.lblfromAt.text = fromAtText
        vChart.lblUntilAt.text = untilAtText
        
        let chartMother = vChart.vChartMother
        chartMother.subviews.forEach { $0.removeFromSuperview() }
        
        let incomeData = value.data.filter{ $0.isPositive }
        let expenseData = value.data.filter{ !$0.isPositive }
        
        let incomeChart = CurveChartView(
            data: incomeData,
            isDay: value.isDay,
            isPositive: true
        )
        let expenseChart = CurveChartView(
            data: expenseData,
            isDay: value.isDay,
            isPositive: false
        )
        
        chartMother.addSubview(incomeChart)
        chartMother.addSubview(expenseChart)
        
        incomeChart.snp.makeConstraints { make in
            make.top.left.right.equalTo(chartMother)
            make.bottom.equalTo(chartMother.snp.centerY)
        }
        
        expenseChart.snp.makeConstraints { make in
            make.top.equalTo(chartMother.snp.centerY)
            make.left.right.bottom.equalTo(chartMother)
        }
    }
    
    func setListBtnColor(_ selected: TransactionsVM.Selected) {
        vList.btns.forEach {
            $0.setTitleColor(.systemGray4, for: .normal)
        }
        
        switch selected {
        case .all    : vList.btnAll.setTitleColor(.black, for: .normal)
        case .expense: vList.btnExpense.setTitleColor(.black, for: .normal)
        case .income : vList.btnIncome.setTitleColor(.black, for: .normal)
        }
    }
    
    func setListHeight(_ count: Int) {
        let tvVisibleCells = vList.tvList.visibleCells
        guard tvVisibleCells.count > 0 else { return }
        
        if let cell = tvVisibleCells.first as? TransactionsCell {
            let height = CGFloat(count) * cell.frame.height
            vList.tvList.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
}
