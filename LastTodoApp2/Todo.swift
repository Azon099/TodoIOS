//
//  Todo.swift
//  LastTodoApp2
//
//  Created by vagrant on 10/2/17.
//  Copyright © 2017 vagrant. All rights reserved.
//

import Foundation

public class Todo{
    var id = -1
    var project_id = -1
    var text = ""
    var isComplete = false
    
    init(id: Int, project_id: Int, text: String, isComplete: Bool){
        self.id = id
        self.project_id = project_id
        self.text = text
        self.isComplete = isComplete
    }
}
