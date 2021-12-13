//
//  MindMapViewController.swift
//  mindMap
//
//  Created by Алина Бондарчук on 08.11.2021.
//

import UIKit

class MindMapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var cards = [CardView]()
    var mindIdea: String?
    var selectedCard: CardView?
    var mindCard: CardView?
    var subCard: CardView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let labelToLoad = mindIdea {
            loadCards(CGPoint(x: view.center.x - 50, y: view.center.y), andText: labelToLoad, withColor: .white, withBackColor: UIColor(named: "mindCardColor")!)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tap)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingToParent {
            let file = "\(UUID().uuidString)"
            
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = dir.appendingPathComponent(file)
        }
    }
    
//MARK: - Helper Methods
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        print("did tap")
        if selectedCard != nil {
            let tapPoint = gesture.location(in: self.contentView)
            loadCards(tapPoint, andText: "New idea", withColor: .systemGray, withBackColor: UIColor(named: "cardColor")!)
            guard let lastLoadCard = cards.last else { return }
            //let lastLoadCard = cards.removeLast()
            let line = LineView(from: selectedCard!, to: lastLoadCard)
            contentView!.insertSubview(line, at: 0)
            selectedCard?.lines.append(line)
            lastLoadCard.lines.append(line)
            selectedCard?.deselected()
            selectedCard = nil
            
        } else {
            self.view.endEditing(true)
            for card in cards {
                card.cardField.isUserInteractionEnabled = false
            }
        }
    }
    
    func loadCards(_ atPoint: CGPoint, andText text: String, withColor textColor: UIColor, withBackColor color: UIColor) {
        let card = CardView(atPoint)
        card.cardField.text = text
        card.cardView.backgroundColor = color
        card.cardField.textColor = textColor
        card.delegate = self
        self.contentView.addSubview(card)
        cards.append(card)
    }
    
}

extension MindMapViewController: CardViewDelegate {
    
    func didSelect(_ card: CardView) {
        if selectedCard != nil {
            selectedCard?.deselected()
            selectedCard = nil
        } else {
            selectedCard = card
            selectedCard?.selected()
        }
    }
    
    func didEdit(_ card: CardView) {
        print("Edit")
        card.cardField.isUserInteractionEnabled = true
        card.cardField.becomeFirstResponder()
//        let ac = UIAlertController(title: "Enter new name", message: nil, preferredStyle: .alert)
//        ac.addTextField { textField in
//            textField.clearButtonMode = .whileEditing
//            textField.textAlignment = .center
//            textField.text = card.cardField.text
//        }
//        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { action in
//            let textField = ac.textFields![0] as UITextField
//            card.cardField.text = textField.text
//        }))
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(ac, animated: true, completion: nil)
    }
}
