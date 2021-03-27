//
//  ViewController.swift
//  ReadMe
//
//  Created by Raisa Meneses on 3/24/21.
//

import UIKit

class LibraryViewController: UITableViewController {

    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Nothing is selected!")
        }
        let book = Library.books[indexPath.row]
        return DetailViewController(coder: coder, book: book)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: DATASOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Library.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = Library.books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.imageView?.image = book.image
        
        return cell
    }
}

