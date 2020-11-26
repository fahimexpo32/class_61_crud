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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewUser.delegate = self
        tableViewUser.dataSource = self
        manager.delegate = self
        
        dropDown.anchorView = genderConn
        dropDown.dataSource = ["male", "female", "others"]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.genderConn.setTitle(item, for: .normal)
            
        }
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
        let user = User(fullName: fullName, Description: description, gender: gender)
        
        manager.create(addData: user)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCellIdentyfier", for: indexPath) as! CustomTableViewCell
        let user = users[indexPath.row]
        cell.nameViewCell.text = user.fullName
        cell.descriptionViewCell.text = user.Description
        cell.genderViewCell.setTitle(user.gender, for: .normal)
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete  else {
            return
        }
    }
    
    
}

extension ViewController: ManagerProtocol {
    func fetchData(modelData: Model) {
        DispatchQueue.main.async {
            self.users = modelData.users
            self.tableViewUser.reloadData()
        }
    }
}

