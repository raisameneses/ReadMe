//
//  DetailViewController.swift
//  ReadMe
//
//  Created by Raisa Meneses on 3/26/21.
//

import UIKit

class DetailViewController: UITableViewController {
    var book: Book
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = book.title
        self.authorLabel.text = book.author
        self.imageView.image = book.image
        imageView.layer.cornerRadius = 16
        
        if let review = book.review {
            reviewTextView.text = review
        }
        reviewTextView.addDoneButton()
    }
    @IBAction func updateImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ?
            .camera : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should not be called")
    }
    
    init?(coder: NSCoder, book: Book) {
        
        self.book = book
        super.init(coder: coder)
    }
}

extension DetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        Library.saveImage(selectedImage, forBook: book)
        dismiss(animated: true)
    }
}

extension DetailViewController: UITextViewDelegate{
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension UITextView {
    func addDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        toolBar.items = [flexSpace, doneButton]
        
        self.inputAccessoryView = toolBar
    }
}
