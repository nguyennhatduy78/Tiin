//
//  File.swift
//  TiinClone
//
//  Created by Nguyen Nhat Duy on 01/06/2021.
//

import Foundation
import UIKit

class MenuTableView: UITableViewController {
    
    
    var getCategoryID : ((_ category_id: Int, _ category_title: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
    }
    
    private func viewInit(){
        self.tableView.separatorStyle = .singleLine
        self.tableView.backgroundColor = .lightGray
        self.tableView.isScrollEnabled = false
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Basic")
        self.tableView.register(MenuItemViewCell.self, forCellReuseIdentifier: "MenuCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 1) {
            return 300
        } else {
            return 40
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 1){
            let cell = UITableViewCell()
            let layout = ColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 0, minimumLineSpacing: 0, sectionInset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            let x = NewsCategoryCell(frame: CGRect(x: 0, y: 0, width: 414, height:300),collectionViewLayout: layout)
            x.getCategoryID = { id, title in
                self.getCategoryID!(id, title)
            }
            cell.contentView.addSubview(x)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = MenuItemViewCell()
            if (indexPath.row == 5) {
                cell.swtBtn.isHidden = false
                cell.swtBtn.setOn(true, animated: true)
            }
            cell.icon.image = UIImage(named: CATEGORY.MENU_ITEM[indexPath.row].0)
            cell.title.text = CATEGORY.MENU_ITEM[indexPath.row].1
            return cell
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(indexPath.row == 1) {
//            print("press")
//        }
//    }
}
