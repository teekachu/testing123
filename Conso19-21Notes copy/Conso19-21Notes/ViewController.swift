//
//  ViewController.swift
//  Conso19-21Notes
//
//  Created by Ting Becker on 8/21/20.
//  Copyright © 2020 TeeksCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource {
    
    
    var allnotes = [String]() //holds a bunch of strings where eachNote is a string
    var note = ""
    var isNoteSaved = false
    var items = [UIBarButtonItem]()
    
    @IBOutlet var notesLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetDefaults()
        
        tableview.delegate = self
        tableview.dataSource = self
        //BUTTONS:
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadpage))
        
        //todo: find the eclipsis button?
        
        navigationController?.isToolbarHidden = false
        
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNotes)))
        
        toolbarItems = items
        
        //AUTOLAYOUTS
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.text = "  Notes"
        notesLabel.textAlignment = .left
        notesLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "search"
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            notesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            notesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            notesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            notesLabel.widthAnchor.constraint(equalToConstant: 414),
            notesLabel.heightAnchor.constraint(equalToConstant: 44),
            
            searchBar.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            searchBar.widthAnchor.constraint(equalTo: notesLabel.widthAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            tableview.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        
        //load from allnotes
        let defaults = UserDefaults.standard
        
        if let savednote = defaults.object(forKey: "allNotes") as? Data{
            let jsonDecoder = JSONDecoder()
            
            do{
                allnotes = try jsonDecoder.decode([String].self, from: savednote as Data)
            } catch {
                print("unable to load each note")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableview.reloadData()
    }
    
    @objc func reloadpage(){
        
        let defaults = UserDefaults.standard
        
        if let savedNotes = defaults.object(forKey: "allnotesdvc") as? Data{
            let jsonDecoder = JSONDecoder()
            
            do{
                note = try jsonDecoder.decode(String.self, from: savedNotes as Data)
            } catch {
                print("unable to load each note")
            }
            if isNoteSaved == false{
                allnotes.append(note)
                isNoteSaved = true
            }
            
            tableview.reloadData()
            save()
            
            print(allnotes)
        }
    }
    
    func save (){
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(allnotes){
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "allNotes")
        }else{
            print("unable to save")
        }
        
    }
    
    
    @objc func addNotes(){
        
        isNoteSaved = false
        //when user select addNotes, go into detail view controller
        if let vc = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allnotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allnotes[indexPath.row]
        return cell
        
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        return
    //    }
    
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

