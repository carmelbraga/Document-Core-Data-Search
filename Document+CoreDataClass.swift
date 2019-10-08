//
//  Document+CoreDataClass.swift
//  Document Core Data
//
//  Created by Carmel Braga on 9/20/19.
//  Copyright © 2019 Carmel Braga. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Document)
public class Document: NSManagedObject {
    
    convenience init?(eventName: String?, eventLocation: String?, date: Date?){
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            guard let managedContext = appDelegate?.persistentContainer.viewContext else{
                return nil
            }
            
            self.init(entity: Document.entity(), insertInto: managedContext
    
            
        }
        
    }

