//
//  ViewController.swift
//  CoreDataTask
//
//  Created by Rakesh on 17/12/21.
//

import UIKit
import DropDown
import CoreData


class ViewController: UIViewController,dataPass {

    
    @IBOutlet weak var selectDepartmentView:UIView!
    @IBOutlet weak var departmentTV:UITableView!
    
    var departmentArr = [Department]()
    var departmentObjArr = [DepartmentObjects]()
    var departmentObjArr1 = [DepartmentObjects]()
    var departmentObjArr2 = [DepartmentObjects]()
    var dropDownArr = ["Android", "iOS", "Web"]
    
    let dropDown = DropDown()
    var newEmail = UITextField()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
        
    }
    
    @IBAction func selectDepartmentBtnTap(_ sender:UIButton) {
        
        selectDepartmentDropDown()
        
    }
    
    @IBAction func addMoreBtnTap(_ sender:UIButton) {
        
        alert(parentTag: sender.tag)
    }
    
    
    
    //MARK:-DROPDOWN FOR DEPARTMENT
    
    func selectDepartmentDropDown(){
        
      
        dropDown.anchorView = selectDepartmentView
        dropDown.dataSource = dropDownArr
        dropDown.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dropDown.direction = .top
        dropDown.textFont = UIFont(name: "HelveticaNeue-Medium", size: 16)!
        dropDown.show()
            
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
               
            if departmentArr.contains(where: {$0.title == item}) {
                self.showToast(message: "Department Already Added ")
                }else {
                    let department = Department(context: context)
                    department.title = item
                    department.done = false
                    self.departmentArr.append(department)
                    self.saveItems(val: 0)
                }
                dropDown.hide()
        }
    }
    
}
//MARK:- TABLEVIEW DELEGATE METHODS

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return departmentArr.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {
            return departmentObjArr.count + 1
            
        }else if section == 1 {
            
            return departmentObjArr1.count + 1
            
        }else if section == 2{
            
            return departmentObjArr2.count + 1
            
        }else {
            
            return 1
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! DepartmentTVCell
            cell.departmentNameLbl.text = departmentArr[indexPath.section].title
            cell.moreBtn.setTitle(departmentArr[indexPath.section].title, for: .normal)
            cell.moreBtn.tag = indexPath.section
            return cell
            
    }else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! DepartmentTVCell
            
        if indexPath.section == 0 {
                
            cell.email.text = departmentObjArr[indexPath.row - 1].email
            cell.delegate = self
            
            if departmentObjArr[indexPath.row - 1].done == false {
                cell.onOff.setOn(true, animated: true)
                cell.email.isEnabled = true
            }else {
                cell.onOff.setOn(false, animated: true)
                cell.email.isEnabled = false
            }
                
        }else if indexPath.section == 1 {
                
            cell.email.text = departmentObjArr1[indexPath.row - 1].email
            cell.delegate = self
            
            if departmentObjArr1[indexPath.row - 1].done == false {
                cell.onOff.setOn(true, animated: true)
                cell.email.isEnabled = true
            }else {
                cell.onOff.setOn(false, animated: true)
                cell.email.isEnabled = false
            }
                
        }else {
                
            cell.email.text = departmentObjArr2[indexPath.row - 1].email
            cell.delegate = self
            
            if departmentObjArr2[indexPath.row - 1].done == false {
                cell.onOff.setOn(true, animated: true)
                cell.email.isEnabled = true
            }else {
                cell.onOff.setOn(false, animated: true)
                cell.email.isEnabled = false
            }
        }
        
           return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}


//MARK:- EMAIL AND SWITCH AND ALERT FUNCTION

extension ViewController {
    
    
    //REMOVING OBJECTS
    
    func deleteBtnTapped(cell: DepartmentTVCell) {
        
        guard let indexPath = self.departmentTV.indexPath(for: cell) else { return }
        
        if indexPath.section == 0 {

            if departmentObjArr.count == 1 {
                context.delete(departmentObjArr[indexPath.row - 1])
                departmentObjArr.remove(at: indexPath.row - 1)
                context.delete(departmentArr[indexPath.section])
                departmentArr.remove(at: indexPath.section)
            }else {
                context.delete(departmentObjArr[indexPath.row - 1])
                departmentObjArr.remove(at: indexPath.row - 1)
            }


        }else if indexPath.section == 1 {

            if departmentObjArr1.count == 1 {
                context.delete(departmentObjArr1[indexPath.row - 1])
                departmentObjArr1.removeAll()
                context.delete(departmentArr[indexPath.section])
                departmentArr.remove(at: indexPath.section)
            }else {
                context.delete(departmentObjArr1[indexPath.row - 1])
                departmentObjArr1.remove(at: indexPath.row - 1)
            }


        }else {

            if departmentObjArr2.count == 1 {
                context.delete(departmentObjArr2[indexPath.row - 1])
                departmentObjArr2.remove(at: indexPath.row - 1)
                context.delete(departmentArr[indexPath.section])
                departmentArr.remove(at: indexPath.section)
            }else {
                context.delete(departmentObjArr2[indexPath.row - 1])
                departmentObjArr2.remove(at: indexPath.row - 1)
            }

        }

        saveItems(val: 1)
    }
    
    
    //SWITCH FUNCTION
    
    func switchBtnTapped(cell: DepartmentTVCell) {
        
        
        guard let indexPath = self.departmentTV.indexPath(for: cell) else { return }
        
        
        if indexPath.section == 0 {
            
            if departmentObjArr[indexPath.row - 1].done == false {
                departmentObjArr[indexPath.row - 1].done = true
            }else {
                departmentObjArr[indexPath.row - 1].done = false
            }

        }else if indexPath.section == 1 {
            
            if departmentObjArr1[indexPath.row - 1].done == false {
                departmentObjArr1[indexPath.row - 1].done = true
            }else {
                departmentObjArr1[indexPath.row - 1].done = false
            }
            
        }else {
           
            if departmentObjArr2[indexPath.row - 1].done == false {
                departmentObjArr2[indexPath.row - 1].done = true
            }else {
                departmentObjArr2[indexPath.row - 1].done = false
            }
        }
        
        saveItems(val: 0)
        
    }
    
    
    //ALERT METHOD
    
    
    func alert(parentTag:Int){
        
        let alert = UIAlertController(title: "Add New Employee Email", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if self.newEmail.isValidEmail(self.newEmail.text ?? "") == true {
                
                if parentTag == 0 {
                    if self.departmentObjArr.contains(where: {$0.email == self.newEmail.text ?? ""}) {
                        self.showToast(message: "Email already exist in \(self.departmentArr[parentTag].title ?? "")")
                    }else {
                        let departmentObject = DepartmentObjects(context: self.context)
                        departmentObject.email = self.newEmail.text ?? ""
                        departmentObject.done = false
                        departmentObject.parentCategory = self.departmentArr[parentTag]
                        self.departmentObjArr.append(departmentObject)
                        self.saveItems(val: 0)
                          }
                }else if parentTag == 1{
                    if self.departmentObjArr1.contains(where: {$0.email == self.newEmail.text ?? ""}) {
                        self.showToast(message: "Email already exist in \(self.departmentArr[parentTag].title ?? "")")
                    }else {
                        let departmentObject = DepartmentObjects(context: self.context)
                        departmentObject.email = self.newEmail.text ?? ""
                        departmentObject.done = false
                        departmentObject.parentCategory = self.departmentArr[parentTag]
                        self.departmentObjArr1.append(departmentObject)
                        self.saveItems(val: 0)
                          }
                }else {
                    if self.departmentObjArr2.contains(where: {$0.email == self.newEmail.text ?? ""}) {
                        self.showToast(message: "Email already exist in \(self.departmentArr[parentTag].title ?? "")")
                    }else {
                        let departmentObject = DepartmentObjects(context: self.context)
                        departmentObject.email = self.newEmail.text ?? ""
                        departmentObject.done = false
                        departmentObject.parentCategory = self.departmentArr[parentTag]
                        self.departmentObjArr2.append(departmentObject)
                        self.saveItems(val: 0)
                          }
                }
                
                
            }else {
                self.showToast(message: "Invalid Email")
            }
        }
    
        alert.addTextField { (alertTF) in
            
            alertTF.placeholder = "Enter Employee Email"
            self.newEmail = alertTF
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    
    }
    
}


//MARK:- COREDATA METHODS

extension ViewController {
    

   // COREDATA SAVE METHOD

    func saveItems (val:Int){
            
        do {
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
            
        if val == 0 {
                self.departmentTV.reloadData()
        }else {
            departmentObjArr = [DepartmentObjects]()
            departmentObjArr1 = [DepartmentObjects]()
            departmentObjArr2 = [DepartmentObjects]()
            loadItems()
            }
        }
        
     
    //LOADING DEPARTMENT METHOD
    
    
        func loadItems() {
            
            let request:NSFetchRequest<Department> = Department.fetchRequest()
           // let predicate = NSPredicate(format: "title CONTAINS[cd] %@","iOS")
            //let predicate = NSPredicate(format: "done = %d",false)
         //   request.predicate = predicate
            do {
                departmentArr = try context.fetch(request)
            }catch {
                print("Error Fetch context \(error)")
            }
            
            for i in 0..<departmentArr.count {
                
                loadItemsObjects(tag: i)
            }
            departmentTV.reloadData()
            
        }
    
    
    //LOADING DEPARTMENT OBJECT METHOD
        
        func loadItemsObjects(tag:Int){
            
            let request:NSFetchRequest<DepartmentObjects> = DepartmentObjects.fetchRequest()
            let predicate = NSPredicate(format: "parentCategory.title MATCHES %@", departmentArr[tag].title!)
         request.predicate = predicate
            do {
                if tag == 0 {
                    departmentObjArr = try context.fetch(request)
                }else if tag == 1 {
                    departmentObjArr1 = try context.fetch(request)
                }else {
                    departmentObjArr2 = try context.fetch(request)
                }
            }catch {
                print("Error Fetch context \(error)")
            }
        
        }
    
}
