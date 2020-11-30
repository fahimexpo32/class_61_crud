//
//  UpdateViewController.swift
//  class_61_crud
//
//  Created by Ramjan Hossain on 30/11/20.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var genderUp: UIButton!
    @IBOutlet weak var imageUP: UIImageView!
    @IBOutlet weak var descriptionUp: UITextField!
    @IBOutlet weak var nameUp: UITextField!
    
    
    
    
    var id  = ""
    var nameUpdate = ""
    var descriptionUpadte = ""
    var genderUpdate = ""
    var iamgeUpdate = UIImage()
    
    var manager = Manager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameUp.text = nameUpdate
        descriptionUp.text = descriptionUpadte
        genderUp.setTitle(genderUpdate, for: .normal)
      //  imageUP.image = iamgeUpdate
        
        
        // Do any addit ional setup after loading the view.
    }
    
    @IBAction func updateUpbuttonAction(_ sender: UIButton) {
        
        guard let fullName = nameUp.text,
              let description  = descriptionUp.text,
              let gender = genderUp.titleLabel?.text
        
        else {
            return
        }
        print(fullName)
        print(description)
        print(gender)
        
        let user = User(fullName: fullName, Description: description, gender: gender)
        
        manager.update(addData: user, updateId: id)
        nameUp.text = ""
        descriptionUp.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
