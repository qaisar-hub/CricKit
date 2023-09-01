//
//  FirebaseDataService.swift
//  CricKit
//
//  Created by  Ephrim Daniel J on 25/08/23.
//

import Foundation
import FirebaseFirestore

public class FbDataServiceManager {
    
    let collectionPath : String? = nil
    let subCollectionPath : String? = nil
    static let shared = FbDataServiceManager()
    
    func getData(parentCollection: String, complete: @escaping (_ result: QuerySnapshot?)->()) {
        //creating db reference
        let db = Firestore.firestore()
        // accessing firestore collection
        db.collection(parentCollection).getDocuments { snapshot, error in
            if error == nil {
                complete(snapshot)
            } else {
                complete(nil)
            }
        }
    }
    
    func getDataWithDocumentID(parentCollection: String, documentId: String, subCollection: String, complete: @escaping (_ result: QuerySnapshot?)->()){
        //creating db reference
        let db = Firestore.firestore()
        // accessing firestore collection
        db.collection(parentCollection).document(documentId).collection(subCollection).getDocuments { snapshot, error in
            if error == nil {
                complete(snapshot)
            } else {
                complete(nil)
            }
        }
    }
}
