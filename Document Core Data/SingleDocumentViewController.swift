//
//  SingleDocumentViewController.swift
//  Document Core Data
//
//  Created by Carmel Braga on 9/20/19.
//  Copyright © 2019 Carmel Braga. All rights reserved.
//

import UIKit

class SingleDocumentViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextView!
    
    var existingDocument: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        contentTextField.delegate = self as? UITextViewDelegate
        
        nameTextField.text = existingDocument?.documentName
        contentTextField.text = existingDocument?.documentContent
   
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any)
    
    {
        
    let documentName = nameTextField.text
    let documentContent = contentTextField.text
    
    var document: Document?
    
        if let existingDocument = existingDocument{
            existingDocument.documentName = documentName
        existingDocument.documentContent = documentContent
        
        //existingDocument.date = date
        
        document = existingDocument
        
    }else{
    document = Document()
        
    }
    
    if let document = document {
        do {
            let managedContext = document.managedObjectContext
            
            try managedContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch{
            print("Document could not be saved.")
        }
    }
}

}

extension SingleDocumentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

