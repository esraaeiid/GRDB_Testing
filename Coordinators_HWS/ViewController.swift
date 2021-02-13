//
//  ViewController.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 12/02/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var friends = [Friend]()
    var selectedFrined: Int? 

    override func viewDidLoad() {
        super.viewDidLoad()
      loadData()
        
        title = "Friend Zone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timeZone
        dateFormatter.timeStyle = .short
        
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configureFriend(friend: friends[indexPath.row], position: indexPath.row)
    }
    
    func loadData(){
        let defaults = UserDefaults.standard
        
        guard let saveData = defaults.data(forKey: "Friends") else
        {
            return
        }
        let decoder = JSONDecoder()
        
        guard let saveFriends = try? decoder.decode([Friend].self, from: saveData) else {
            return
        }
        friends = saveFriends
    }
    
    func saveData(){
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let savedData = try? encoder.encode(friends ) else {
            fatalError("Unable to encode frienda data")
        }
        
        defaults.set(savedData, forKey: "Friends")
    }
    
    
    @objc func addFriend(){
         let friend = Friend()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
        
        configureFriend(friend: friend, position: friends.count - 1)
    }
    
    func configureFriend(friend: Friend, position: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FriendViewController") as? FriendViewController else {
            fatalError("Unable to create FriendViewController. ")
        }
        selectedFrined = position
        vc.delegate = self
        vc.friend = friend
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func update(friend: Friend){
        guard let selectedFriend = selectedFrined else { return }
        
        friends[selectedFriend] = friend
        tableView.reloadData()
        saveData()
    }

}

 
