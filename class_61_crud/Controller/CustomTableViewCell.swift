//
//  CustomTableViewCell.swift
//  class_61_crud
//
//  Created by Ramjan Hossain on 26/11/20.
//

import UIKit
protocol CustomCellDelegate: class {
    func updateCellButtonAction(cell: CustomTableViewCell, didTabButton button: UIButton?)
    func deleteCellButtonAction(cell: CustomTableViewCell, didTabButton button: UIButton?)
}
class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var nameViewCell: UILabel!
    @IBOutlet weak var descriptionViewCell: UITextView!
    @IBOutlet weak var genderViewCell: UIButton!
    
    weak var cellDelegate: CustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func updateButtonCell(_ sender: UIButton) {
        cellDelegate?.updateCellButtonAction(cell: self, didTabButton: sender)
    }


    @IBAction func DeleteButtonCell(_ sender: UIButton) {
        cellDelegate?.deleteCellButtonAction(cell: self, didTabButton: sender)
    }
    
}
