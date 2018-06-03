//
//  EditAddressBookTableViewCell.swift
//  addressBook
//
//  Created by user on 2018/6/1.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit


struct NotificationObjectKey {
    static let addressBook = "addressBook"
}
extension Notification.Name{
    static let addressBookDidChange = Notification.Name("addressBookDidChange")
}

class EditAddressBookTableViewCell: UITableViewController {
    
    
    var addressBooks: addressBook?
    var imageName = "ironMan"
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func changImage(_ sender: Any) {
        let alertController = UIAlertController(title: "選擇圖片", message: nil , preferredStyle: .actionSheet)
        let ironManImage = UIAlertAction(title: "鋼鐵人", style: .default){ (UIAlertAction)->() in
            self.photoImageView.image = UIImage(named: "ironMan")
            self.imageName  = "ironMan"
        }
        alertController.addAction(ironManImage)
        let backPantherImage = UIAlertAction(title: "黑豹", style: .default){ (UIAlertAction)->() in
            self.photoImageView.image = UIImage(named: "backPanther")
            self.imageName  = "backPanther"
        }
        alertController.addAction(backPantherImage)
        let captainImage = UIAlertAction(title: "美國隊長", style: .default){ (UIAlertAction)->() in
            self.photoImageView.image = UIImage(named: "captain")
            self.imageName  = "captain"
        }
        alertController.addAction(captainImage)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text, name.count > 0 else{
            return
        }
        guard let phone = phoneTextField.text, phone.count > 0 else{
            return
        }
        if addressBooks == nil{
            addressBooks = addressBook(name: name, phone: phone, photo: imageName)
            view.endEditing(true)
            dismiss(animated: true) {
                NotificationCenter.default.post(name: .addressBookDidChange, object: nil, userInfo: [NotificationObjectKey.addressBook : self.addressBooks!])
            }
        }else{
            addressBooks?.name = name
            addressBooks?.phone = phone
            addressBooks?.photo = imageName
            performSegue(withIdentifier: "goBack", sender: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let addressBook = addressBooks{
            nameTextField.text = addressBook.name
            phoneTextField.text = addressBook.phone
            photoImageView.image = UIImage(named: addressBook.photo)
            imageName = addressBook.photo
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
