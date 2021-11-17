//
//  MindMapViewController.swift
//  mindMap
//
//  Created by Алина Бондарчук on 08.11.2021.
//

import UIKit

class MindMapViewController: UIViewController, UIGestureRecognizerDelegate, CardViewDelegate {

    

    @IBOutlet weak var mainIdeaView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var mainIdeaLabel: UILabel!
    
    var mindIdea: String?
    //var otherIdeaLabels = [UILabel]()
    var selectedCard: CardView?
    var xPos: CGFloat = 20.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let labelToLoad = mindIdea {
            mainIdeaLabel.text = labelToLoad
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: - CardViewDelegate
    
    func didSelect(_ card: CardView) {
        if selectedCard != nil {
            if card == selectedCard {
                
            } else {
                let line = LineView(from: selectedCard!, to: card)
                view!.insertSubview(line, at: 0)
                selectedCard?.lines.append(line)
                card.lines.append(line)
            }
            selectedCard?.deselected()
            selectedCard = nil
        } else {
            selectedCard = card
            selectedCard?.selected()
        }
    }
    
    func didEdit(_ card: CardView) {
        let ac = UIAlertController(title: "Enter new name", message: nil, preferredStyle: .alert)
                ac.addTextField { textField in
                    textField.keyboardType = .default
                    textField.clearButtonMode = .whileEditing
                    textField.textAlignment = .center
                    textField.text = card.cardLabel.text
                }
                ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { (action) in
                    let textField = ac.textFields![0] as UITextField
                    card.cardLabel.text = textField.text
                }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        print("did tap")
        if selectedCard != nil {
            selectedCard?.deselected()
            selectedCard = nil
        } else {
            let tapPoint = gesture.location(in: self.view)
            let card = CardView(tapPoint)
            card.delegate = self
            view!.addSubview(card)
        }
    }
    
    
//    @IBAction func addNewIdea(_ sender: Any) {
//        createL()
//        print("dbcsd")
//    }
    //MARK: Helper Methods
    
    func createL() {
        let cardView = CardView(frame: CGRect(x: xPos, y: mainIdeaLabel.center.y + 70, width: 180, height: 100))
        self.view.addSubview(cardView)
    }
        

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

