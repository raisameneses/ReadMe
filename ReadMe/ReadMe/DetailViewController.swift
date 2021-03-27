//
//  DetailViewController.swift
//  ReadMe
//
//  Created by Raisa Meneses on 3/26/21.
//

import UIKit

class DetailViewController: UIViewController {
    var book: Book
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = book.title
        self.authorLabel.text = book.author
        self.imageView.image = book.image
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
