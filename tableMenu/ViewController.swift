//
//  ViewController.swift
//  tableMenu
//
//  Created by 山崎健太 on 2019/04/26.
//  Copyright © 2019 山崎健太. All rights reserved.
//

/// tableview 構成
enum sectionType:Int, CaseIterable{
    case section1
    case section2
    case section3
    
    var sectionName:String{
        switch  self{
        case .section1:
            return "section1"
        case .section2:
            return "section2"
        case .section3:
            return "section3"
        }
    }
    
    /// セクション毎のセルの数を返す
    ///
    /// - Returns: セルの数
    func numberOfRows() -> Int{
        switch  self {
        case .section1:
            return 1
        case .section2:
            return 2
        case .section3:
            return 3
        }
    }
    
    func cellsText(indexRow:Int) -> String {
        let cellsValues1 = ["CellRow1"]
        let cellsValues2 = ["CellRow1","CellRow2"]
        let cellsValues3 = ["CellRow1","CellRow2","CellRow3"]
        
        switch  self {
        case .section1:
            return cellsValues1[indexRow]
        case .section2:
            return cellsValues2[indexRow]
        case .section3:
            return cellsValues3[indexRow]
        }
    }
}

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.register(UINib(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
        table.register(ValueCell.nib, forCellReuseIdentifier: ValueCell.name)
        table.sectionHeaderHeight = 50
        //TableVeiwの余計な空セル削除
        table.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource
extension ViewController:UITableViewDataSource{
    /// セクション数の設定
    ///
    /// - Parameter tableView: .
    /// - Returns: セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionType.allCases.count
    }
    /// セクションヘッダーの設定
    ///
    /// - Parameters:
    ///   - tableView: .
    ///   - section: .
    /// - Returns: セクションヘッダー(今回はxibのカスタムビュー).
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = table.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        guard let sectionType = sectionType(rawValue: section) else { return UIView() }
        headerView.textlabel.text = sectionType.sectionName
        return headerView
    }
    //必須のメソッド：セルの数を指定(sectionが複数ある場合はそれぞれの数を返せる)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = sectionType(rawValue: section) else { return 0}
        return sectionType.numberOfRows()
    }
    //必須のメソッド：セル生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return makeValueCell(indexPath: indexPath)
    }
}

// MARK: - private
extension ViewController{
    /// セルの作成
    ///
    /// - Parameter indexPath: .
    /// - Returns: カスタムセル(xibで作成したセル）．
    private func makeValueCell(indexPath: IndexPath)-> UITableViewCell{
        let cell = table.dequeueReusableCell(withIdentifier: ValueCell.name, for: indexPath) as! ValueCell
        guard let sectionType = sectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        cell.setup(text: sectionType.cellsText(indexRow: indexPath.row), delegate: self,
            handler: {print("タップされた行は：\(indexPath.row)です。")})

        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController:UITableViewDelegate{}


// MARK: - タップ通知
extension ViewController:tappedDelegate{
    func tapped(handler: () -> Void) {
        handler()
    }
}
