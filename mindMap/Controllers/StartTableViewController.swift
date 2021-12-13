//
//  StartTableViewController.swift
//  mindMap
//
//  Created by Алина Бондарчук on 08.11.2021.
//

import UIKit

class StartTableViewController: UITableViewController {
    
    var fileName = "\(UUID().uuidString)"
    var filesName = [String]()
    var labelText = "Idea"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createFileName(_ sender: Any) {
        let ac = UIAlertController(title: "Create a filename", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.keyboardType = .default
            textField.clearButtonMode = .whileEditing
            textField.textAlignment = .center
        }
        ac.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let text = ac.textFields?[0].text else { return }
            
            self.labelText = text
            self.filesName.append(text)
            print(self.filesName)
            self.loadVC()
            self.tableView.reloadData()
        }))
        present(ac, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filesName[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MindMapViewController") as! MindMapViewController
        vc.title = filesName[indexPath.row]
        vc.mindIdea = filesName[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Helper methods
    
    func loadVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MindMapViewController") as! MindMapViewController
        vc.mindIdea = labelText
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
