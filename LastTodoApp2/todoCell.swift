//
//  todoCell.swift
//  LastTodoApp2
//
//  Created by vagrant on 10/2/17.
//  Copyright © 2017 vagrant. All rights reserved.
//

import UIKit

class todoCell: UITableViewCell {

    @IBOutlet weak var checkbox: VKCheckbox!
    
    @IBOutlet weak var todoText: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.checkbox.line             = .thin
        self.checkbox.bgColorSelected  = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
        self.checkbox.bgColor          = .gray
        self.checkbox.color            = .white
        self.checkbox.borderColor      = .white
        self.checkbox.borderWidth      = 2
        self.checkbox.cornerRadius     = self.checkbox.bounds.size.height / 2
        
    }
    
    func setTitle(_ title: String?)
    {
        self.todoText.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
