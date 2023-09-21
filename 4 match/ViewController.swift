//
//  ViewController.swift
//  4 match
//
//  Created by Olzhas Bolatov on 13.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    var isGaming = false
    var state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var images = ["1","2","3","4","5","6","7","8","1","2","3","4","5","6","7","8"]
    var winArray: [[Int]] = []
    
    //  var paraState = [[0, 1], [2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13], [14, 15]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.shuffle()
        for i in 0...15{
            for j in 0...15{
                if images[i] == images[j] && i != j {
                    winArray.append([i,j])
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Click(_ sender: UIButton) {
        if state[sender.tag - 1] != 0 || isGaming {
            return
        }
        print(state) // закрыть картинку если ошибка
        
        state[sender.tag - 1] = 1
        sender.setBackgroundImage(UIImage(named: images[sender.tag-1]), for: .normal)
        var count1 = 0 // сколько картинок открыто
        var count2 = 0 // все ли картинки открыты
        
        for i in 0...15{
            if state[i] == 1{
                count1 += 1
            }
            if state[i] == 2{
                count2 += 1
            }
        }
        
        if count1 == 2{
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                self.clearing()
            }
        }
        
        for wins in winArray {
            if state[wins[0]] == 1 && state[wins[1]] == 1 {
                state[wins[0]] = 2
                state[wins[1]] = 2
                print(state)
            }
        }
        
        if count2 == 15{
            let alert = UIAlertController(title: "You win!", message: "", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in /*alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {*/
               // UIAlertAction in
                self.clearAll()
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func clearAll(){
        isGaming = false
        for i in 0...15{
            let button = view.viewWithTag(i+1) as! UIButton
            button.setBackgroundImage(nil, for: .normal)
            state[i] = 0
        }
    }
    
    func clearing(){
        isGaming = false
        for i in 0...15 {
            if state[i] == 1{
                let button = view.viewWithTag(i+1) as! UIButton
                button.setBackgroundImage(nil, for: .normal)
                state[i] = 0
            }
        }
    }
}



  

