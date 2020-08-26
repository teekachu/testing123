//
//  DetailViewController.swift
//  Conso19-21Notes
//
//  Created by Ting Becker on 8/21/20.
//  Copyright © 2020 TeeksCode. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {
    
    @IBOutlet var detailNotes: UITextView!
    
    var notesWritten: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNotes))
        
        navigationController?.isToolbarHidden = false
        var bottomBarItems = [UIBarButtonItem]()
        bottomBarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        bottomBarItems.append(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNotes)))
        toolbarItems = bottomBarItems
        
    }
    // Do any additional setup after loading the view.
    
    @objc func saveNotes(){
        
        // pull texts into notesWritten
        notesWritten = detailNotes.text
        
        // saving into userDefault as "noteswritten" which is a string
        let jsonencoder = JSONEncoder()
        if let savednotes = try? jsonencoder.encode(notesWritten){
            UserDefaults.standard.set(savednotes, forKey: "noteswritten")
        }
        
        
        
        print(notesWritten)
        
    }
    
    
    @objc func shareNotes(){
        //todo: share notes via social media through UIActivityViewController
    }
    
    
}
