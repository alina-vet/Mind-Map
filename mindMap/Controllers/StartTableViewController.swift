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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
