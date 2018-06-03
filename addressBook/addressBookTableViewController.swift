//
//  addressBookTableViewController.swift
//  addressBook
//
//  Created by user on 2018/6/1.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class addressBookTableViewController: UITableViewController {
    
    @IBAction func goBack(segue: UIStoryboardSegue){
        if let controller = segue.source as? EditAddressBookTableViewCell, let addressBook = controller.addressBooks, let row = tableView.indexPathForSelectedRow?.row{
            
            addressBooks[row] = addressBook
            updateUserDefaults()
            tableView.reloadData()
        }
        
    }
    func updateUserDefaults()  {
        let userDefaults = UserDefaults.standard
        let addressBookDics = addressBooks.map{(addressBook) -> [String:Any] in
            return ["name" : addressBook.name, "phone" : addressBook.phone, "photo" : addressBook.photo]
        }
        userDefaults.set(addressBookDics, forKey: "addressBooks")
    }

    var addressBooks = [addressBook]()
    @objc func updateAddressBooksNoti(Noti: Notification){
        if let userInfo = Noti.userInfo, let addressBook = userInfo[NotificationObjectKey.addressBook] as? addressBook{
            addressBooks.insert(addressBook, at: 0)
            updateUserDefaults()
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        if let addressBooks = userDefaults.array(forKey: "addressBooks") as? [[String:Any]]{
            self.addressBooks = addressBooks.compactMap({ addressBookDic -> addressBook? in
                if let name = addressBookDic["name"] as? String,
                    let phone = addressBookDic["phone"] as? String,
                    let photo = addressBookDic["photo"] as? String{
                    return addressBook(name: name, phone: phone, photo: photo)
                    
                }else{
                    return nil
                }
            })
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateAddressBooksNoti(Noti:)), name: .addressBookDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addressBooks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressBookCell", for: indexPath) as! addressBookTableViewCell
        
        let addressBook = addressBooks[indexPath.row]
        cell.nameLabel.text = addressBook.name
        cell.photoImageView?.image = UIImage(named: addressBook.photo)
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        addressBooks.remove(at: indexPath.row)
        updateUserDefaults()
        tableView.deleteRows(at: [indexPath], with: .fade)

    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as? EditAddressBookTableViewCell
        if let row = tableView.indexPathForSelectedRow?.row{
            controller?.addressBooks = addressBooks[row]
        }
    }
    

}
