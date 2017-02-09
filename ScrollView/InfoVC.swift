//
//  InfoVC.swift
//  ScrollView
//
//  Created by Appinventiv on 06/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit


// MARK: infoVC view controller
class InfoVC: UIViewController {
    
    var data: [[String:String]] = [
        
        ["title":"FULL NAME", "data":"Abhishek Singh"],
        ["title":"FATHER NAME", "data":"Ramesh Singh"],
        ["title":"MOBILE", "data":"8285932530"],
        ["title":"EMAIL", "data":"abhishek.singh2@appinventiv.com"],
        ["title":"DATE OF JOINING", "data":"January 16'2017"],
        ["title":"DESIGNATION", "data":"Software developer"],
        ["title":"TRAINER", "data":"Gurdeep Singh"],
        ["title":"ORGANIZATION", "data":"Appinventiv"],
        ["title":"HEIGHT", "data":"5'9\""],
        ["title":"WEIGHT", "data":"70"]
    ]

    
    
    @IBOutlet weak var profileSettingTable: UITableView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    //Mark: view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Fetching data to be displayed from Story Board.
        profileSettingTable.dataSource = self
        
        // Assigning Deligates to the table view
        profileSettingTable.delegate = self
        
        //Automatic adjust scroll of table view.
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Register Nib
        let nib = UINib(nibName:"InfoCell" , bundle: nil)
        profileSettingTable.register(nib, forCellReuseIdentifier: "InfoCellID")
        
        //Applying notification center to adjust height of table view
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: OperationQueue.main, using: {(Notification) in
        
            guard let info = Notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else{return}
            
            let keyboardHeight = info.cgRectValue.size.height
            
            self.bottomConstraint.constant = keyboardHeight
            
        })
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main, using: {(Notification) in
        
            self.bottomConstraint.constant = 0
            
        })
    }
    //Deinitializer to remove observers.
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardDidShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillShow,
                                                  object: nil)
    }
   
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    
    // Function that return the number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ((data.count)+2)
    }
    
    
    
    // Function that returns the Table Cell as per the requirements
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch  indexPath.row {
            
        case indexPath.startIndex:
            // returns the cell of the ProfileCell defined in the class
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCellID" , for: indexPath)
            return cell
            
        case 11:
            // returns the cell of the SaveChangesCell defined in the class
            let cell = tableView.dequeueReusableCell(withIdentifier: "SaveChangesCellID" , for: indexPath)
            return cell
            
        default:
            // returns the cell of the InfoCell defined in the class
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCellID" , for: indexPath) as? InfoCell else{
                fatalError("Cell not found")
            }
            
            cell.configureData(data[indexPath.row - 1])
            return cell
        }
        
        
        
        
    }
    
    
    // Function that returns the height of the Cell in the Table View
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch  indexPath.row {
            
        case indexPath.startIndex:
            // Height of the ProfileCell Cell
            return 210
            
        case 20:
            // Height of the SaveChangesCell Cell
            return 160
            
        default:
            
            // Height of the InfoCell Cell
            return 72
        }
        
    }
    
    // Function that returns the bool value for highlighting the row
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool{
        
        return false
    }
    //MARK: Data Persistance added.
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if(indexPath.row > 0 && indexPath.row <= data.count){
        let dummyCell = cell as! InfoCell
        data[indexPath.row - 1]["data"] = dummyCell.inputTextField.text
        }
        
        
    }
    
    
}



// Mark: Class of the ProfileCell for TableView
class ProfileCell: UITableViewCell{
    
    // Outlet of the imageView in the ProfileCell
    @IBOutlet weak var profileImage: UIImageView!
    
    // Outlet of the changeImage Button
    @IBOutlet weak var changeImage: UIButton!
    
    // Overriding the awakeFromNib to set the outlet of imageView and button to appear in Circular Shape
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        
        self.changeImage.layer.cornerRadius = self.changeImage.frame.width/2
    }
    
    // Action function for the ChangeButton Button
    @IBAction func changeImage(_ sender: UIButton) {
    }
  
    }

//MARK: Class of the SaveChangesCell for TableView
class SaveChangesCell: UITableViewCell{
    
    // Outlet of the SaveChanges Button
    @IBOutlet weak var saveChanges: UIButton!
    
    // Overriding the awakeFromNib to set the outlet of saveChanges Button to appear in Circular Shape
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.saveChanges.layer.cornerRadius = self.saveChanges.frame.width/6.5
    }
    
}
