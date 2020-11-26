//
//  Manager.swift
//  class_61_crud
//
//  Created by Ramjan Hossain on 26/11/20.
//

import Foundation

protocol ManagerProtocol {
    func fetchData(modelData: Model)
}


struct Manager {
    var delegate: ManagerProtocol?
    
    func create(addData: User) {
        let user = User(fullName: addData.fullName, Description: addData.Description, gender: addData.gender)
        
        let userModel = Model(users: [user])
        delegate?.fetchData(modelData: userModel)
    }
    
    func read() {
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
}

