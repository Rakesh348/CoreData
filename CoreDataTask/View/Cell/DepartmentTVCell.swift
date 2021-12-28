//
//  DepartmentTVCell.swift
//  CoreDataTask
//
//  Created by Rakesh on 17/12/21.
//

import UIKit

protocol dataPass{
    
    func deleteBtnTapped(cell:DepartmentTVCell)
    func switchBtnTapped(cell:DepartmentTVCell)
}


class DepartmentTVCell: UITableViewCell {

    @IBOutlet weak var departmentNameLbl:UILabel!
    @IBOutlet weak var moreBtn:UIButton!
    @IBOutlet weak var email:UITextField!
    @IBOutlet weak var removeBtn:UIButton!
    @IBOutlet weak var onOff:UISwitch!
    
    var delegate:dataPass?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
    }
    
    @IBAction func switchTapped(_ sender: Any) {
  
        delegate?.switchBtnTapped(cell: self)
    }
    
    @IBAction func btnTapped(_ sender:UIButton){
        
        delegate?.deleteBtnTapped(cell: self)
    }


}
