//
//  ViewController.swift
//  ReadMe
//
//  Created by Raisa Meneses on 3/24/21.
//

import UIKit
class LibraryHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(LibraryHeaderView.self)"
    @IBOutlet var titleLabel : UILabel!
}

class LibraryViewController: UITableViewController {
    
    enum Section: String, CaseIterable {
        case addNew
        case readMe = "Read Me!"
        case finished = "Finished"
    }
    var dataSource: UITableViewDiffableDataSource<Section, Book>!
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        
        guard let indexPath = tableView.indexPathForSelectedRow,
              let book = dataSource.itemIdentifier(for: indexPath)
              else {
            fatalError("Nothing is selected!")
        }
        return DetailViewController(coder: coder, book: book)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "\(LibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: LibraryHeaderView.reuseIdentifier)
        
        configureDataSource()
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateDataSource()
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {return nil}
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LibraryHeaderView.reuseIdentifier) as? LibraryHeaderView else { return nil }
        headerView.titleLabel.text = Section.allCases[section].rawValue
        return headerView
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section != 0 ? 60 : 0
    }
    // MARK: Delegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Read me!" : nil
    }
    
    // MARK: DATASOURCE
    
    func configureDataSource(){
        dataSource = UITableViewDiffableDataSource(tableView: tableView){
            tableView, indexPath, book -> UITableViewCell? in
            
            if indexPath == IndexPath(row: 0, section: 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
            else {fatalError("Could not create Book Cell")}
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookThumbNail.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
            cell.bookThumbNail.layer.cornerRadius = 12
            
            if let review = book.review {
                cell.reviewLabel.text = review
                cell.reviewLabel.isHidden = false
            }
            cell.readMeBookMark.isHidden = !book.readMe
            return cell
        }
        
    }
    
    func updateDataSource(){
        var newNapShot = NSDiffableDataSourceSnapshot<Section,Book>()
        newNapShot.appendSections(Section.allCases)
        newNapShot.appendItems(Library.books, toSection: .readMe)
        let booksByReadme: [Bool: [Book]] = Dictionary(grouping: Library.books, by: \.readMe)
        for(readMe, books) in booksByReadme {
            newNapShot.appendItems(books, toSection: readMe ? .readMe : .finished)
        }
        newNapShot.appendItems([Book.mockBook], toSection: .addNew)
        dataSource.apply(newNapShot, animatingDifferences: true)
    }
    
}
