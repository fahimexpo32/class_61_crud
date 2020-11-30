//
//  Manager.swift
//  class_61_crud
//
//  Created by Ramjan Hossain on 26/11/20.
//

import Foundation
import Firebase
import CodableFirebase

protocol ManagerProtocol {
    func fetchData(modelData: [User], idHold: [String])
    
}


struct Manager {
    
    var delegate: ManagerProtocol?
    let dbRefarence = Firestore.firestore().collection("users")
    
    func create(addData: User) {
        
        
        //let user: User // here you will create an instance of Model
        let docData = try! FirestoreEncoder().encode(addData)
        dbRefarence.addDocument(data: docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
        
        read()
        
    }
    
    func read() {
        
        
                dbRefarence.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var users = [User]()
                        var id = [String]()
                        for document in querySnapshot!.documents {
                            let model = try! FirestoreDecoder().decode(User.self, from: document.data())
                            users.append(model)
                            id.append(document.documentID)
                            //print(model)
                           // print( "\(document.documentID) => \(document.data())")
                        }
                        print("jampata")
                        
                        print(users)
                        
                        delegate?.fetchData(modelData: users, idHold: id)
                        
                        print("ampata")
                        print(id)
                    }
        
                    //delegate?.fetchData(modelData: querySnapshot!.documents )
                }
        
        
    }
    
    func update(addData: User, updateId: String) {
        
        
        let docData = try! FirestoreEncoder().encode(addData)
        dbRefarence.document(updateId).setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
        
        read()
        
    }
    
    func delete(deleteId: String) {
        
        dbRefarence.document(deleteId).delete()
        read()
    }
}

