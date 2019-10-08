//
//  DocumentsViewController.swift
//  Document Core Data
//
//  Created by Carmel Braga on 9/20/19.
//  Copyright © 2019 Carmel Braga. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class DocumentsViewController: UIViewController {

    @IBOutlet weak var documentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var documents = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentsTableView.dataSource = self
        documentsTableView.delegate = self
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        
        do{
            documents = try managedContext.fetch(fetchRequest)
    
            documentsTableView.reloadData()
        } catch{
            print("Fetch could not be performed.")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewExpense(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleDocumentViewController,
            let selectedRow = self.documentsTableView.indexPathForSelectedRow?.row else{
                return
        }
        
        destination.existingDocument = documents[selectedRow]
    }
    
    func deleteDocument(at indexPath: IndexPath){
        let document = documents[indexPath.row]
        
        if let managedContext = document.managedObjectContext{
            managedContext.delete(document)
            
            do{
                try managedContext.save()
                
                self.documents.remove(at: indexPath.row)
                
                documentsTableView.deleteRows(at: [indexPath], with: .automatic)
            }catch{
                print("Document could not be deleted.")
                
                documentsTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteDocument(at: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        let document = documents[indexPath.row]
        
        cell.textLabel?.text = document.documentName
        
        return cell
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "existingDocument", sender: self)
    }
}
