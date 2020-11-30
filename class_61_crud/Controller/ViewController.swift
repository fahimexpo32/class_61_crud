//
//  ViewController.swift
//  class_61_crud
//
//  Created by Ramjan Hossain on 25/11/20.
//

import UIKit
import DropDown


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableViewUser: UITableView!
    @IBOutlet weak var genderConn: UIButton!
    @IBOutlet weak var fullNameConn: UITextField!
    @IBOutlet weak var descriptionConn: UITextField!
    @IBOutlet weak var imageConn: UIImageView!
    
    
    let dropDown = DropDown()
    var users = [User]()
    var manager = Manager()
    var id = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.delegate = self
        tableViewUser.delegate = self
        tableViewUser.dataSource = self
        
      
        
        dropDown.anchorView = genderConn
        dropDown.dataSource = ["male", "female", "others"]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.genderConn.setTitle(item, for: .normal)
            
        }
        manager.read()
    }
    
    
    
    @IBAction func genderButtonAction(_ sender: UIButton) {
        dropDown.show()
        //dropDown.hide()
        
    }
    
    @IBAction func addButtonAll(_ sender: UIButton) {
        
        guard let fullName = fullNameConn.text,
              let description  = descriptionConn.text,
              let gender = genderConn.titleLabel?.text
        
        else {
            return
        }
        print(fullName)
        print(description)
        print(gender)
        
        let user = User(fullName: fullName, Description: description, gender: gender)
        
        manager.create(addData: user)
        fullNameConn.text = ""
        descriptionConn.text = ""
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 302
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCellIdentyfier", for: indexPath) as! CustomTableViewCell
        let user = users[indexPath.row]
        cell.nameViewCell.text = user.fullName
        cell.descriptionViewCell.text = user.Description
        cell.genderViewCell.setTitle(user.gender, for: .normal)
        
        cell.cellDelegate = self
        
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete  else {
            return
        }
    }
    
    
}

extension ViewController: ManagerProtocol {
    func fetchData(modelData: [User], idHold: [String]) {
        DispatchQueue.main.async {
            
            self.users = modelData
            self.id = idHold
            self.tableViewUser.reloadData()
           
        }
    }
}

extension ViewController: CustomCellDelegate {
    func updateCellButtonAction(cell: CustomTableViewCell, didTabButton button: UIButton?) {
        print("cick Button")
        guard let indexPath = tableViewUser.indexPath(for: cell ) else {
            return
        }
        
        let updateVc = storyboard?.instantiateViewController(identifier: "UpdateViewController") as! UpdateViewController
        
        updateVc.id = id[indexPath.row]
        updateVc.nameUpdate = cell.nameViewCell.text ?? ""
        updateVc.descriptionUpadte = cell.descriptionViewCell.text
        updateVc.genderUpdate = cell.genderViewCell.titleLabel?.text ?? ""
        print("----------->>>>>")
        navigationController?.pushViewController(updateVc, animated: true)
        print(">>>>>>>>>")
    }
    
    func deleteCellButtonAction(cell: CustomTableViewCell, didTabButton button: UIButton?) {
        
        guard let indexPath = tableViewUser.indexPath(for: cell ) else {
            return
           
        }
        manager.delete(deleteId: id[indexPath.row])
        
        
    }
    
    
}
