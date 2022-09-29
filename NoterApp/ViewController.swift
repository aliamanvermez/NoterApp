//
//  ViewController.swift
//  NoterApp
//
//  Created by NeonApps on 28.09.2022.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    var titleArray = [String]()
    var descArray = [String]()
    var idArray = [UUID]()
    
    var noteTableView = UITableView()
    var rootVC = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSize(view: view)
        view.backgroundColor = .white
        title = "Noter App"
        createUI()
        setUpTableView()
        getData()
    }
    
    func createUI() {
        var addTextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTextButtonClicked))
        navigationItem.rightBarButtonItem = addTextButton
        addTextButton.isEnabled = true
        view.addSubview(noteTableView)
        
        
    }
    func setUpTableView() {
        noteTableView.dataSource = self
        noteTableView.delegate = self
        noteTableView.frame = CGRect(x: 0, y: 0.1 * screenHeight, width: view.frame.size.width, height: view.frame.size.height)
        noteTableView.rowHeight = 100
        noteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Texts")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results =  try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let title = result.value(forKey: "title") as? String {
                    self.titleArray.append(title)
                }
                
                if let description = result.value(forKey: "descriptions") as? String {
                    self.descArray.append(description)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                
                self.noteTableView.reloadData()
                    
                    
            }
        }catch {
            
        }
    }
    
    @objc func addTextButtonClicked() {
        let destVC = AddNoteScreen()
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }
    
    
    
    
}
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    
}

