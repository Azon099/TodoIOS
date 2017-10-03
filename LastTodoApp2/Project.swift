//
//  Project.swift
//  LastTodoApp2
//
//  Created by vagrant on 10/2/17.
//  Copyright © 2017 vagrant. All rights reserved.
//

import Foundation

public class Project{
    var id = -1
    var title = ""
    var Todos: [Todo] = []
    
    init(id: Int, title: String){
        self.id = id
        self.title = title
    }
}
