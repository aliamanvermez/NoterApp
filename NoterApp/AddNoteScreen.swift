//
//  AddNoteScreen.swift
//  NoterApp
//
//  Created by NeonApps on 28.09.2022.
//

import UIKit
import CoreData
class AddNoteScreen: UIViewController {
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var titleTextField = UITextField()
    var noteTextField = UITextView()
    var saveButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDefaultSize(view: view)
        createUI()
    }
    
   func createUI() {
    
       
       titleLabel.frame = CGRect(x: 0.2 * screenWidth, y: 0.1 * screenHeight, width: 0.6 * screenWidth, height: 50)
       titleTextField.frame = CGRect(x: 0.05 * screenWidth, y: 0.15 * screenHeight, width: 0.9 * screenWidth, height: 60)
       descriptionLabel.frame = CGRect(x: 0.2 * screenWidth, y: 0.22 * screenHeight, width: 0.6 * screenWidth, height: 50)
       noteTextField.frame = CGRect(x: 0.05 * screenWidth, y: 0.27 * screenHeight, width: 0.9 * screenWidth, height: 450)
       saveButton.frame = CGRect(x: 0.4 * screenWidth, y: 0.87 * screenHeight, width: 0.2 * screenWidth, height: 50)
       
       noteTextField.backgroundColor = .systemGray4
       titleTextField.backgroundColor = .systemGray4
       saveButton.backgroundColor = .systemPink
       saveButton.setTitle("Save", for: .normal)
       saveButton.layer.cornerRadius = 13
       saveButton.setTitleColor(UIColor.white, for: .normal)
       
       saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)

       
       
       titleTextField.placeholder = "Please enter your text's title..."
       noteTextField.layer.borderColor = CGColor(srgbRed: 255/255, green: 116/255, blue: 177/255, alpha: 1)
       titleTextField.layer.borderColor = CGColor(srgbRed: 255/255, green: 116/255, blue: 177/255, alpha: 1)

       noteTextField.layer.borderWidth = 3
       
       titleLabel.text = "Title"
       titleLabel.textAlignment = .center
       
       descriptionLabel.text = "Description"
       descriptionLabel.textAlignment = .center
       
       view.addSubview(titleLabel)
       view.addSubview(titleTextField)
       view.addSubview(descriptionLabel)
       view.addSubview(noteTextField)
       view.addSubview(saveButton)
}
    @objc func saveButtonClicked() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newText = NSEntityDescription.insertNewObject(forEntityName: "Texts", into: context)
        
        //Attributes
        
        newText.setValue(titleTextField.text, forKey: "title")
        newText.setValue(noteTextField.text, forKey: "descriptions")
        newText.setValue(UUID(), forKey: "id")
        do {
            try  context.save()
            print("success")

        }catch{
            print("error")
        }
        
        self.navigationController?.popViewController(animated: true)
       
    }
    
    
}
