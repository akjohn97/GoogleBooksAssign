

import UIKit

class BookTableCell: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookMainLabel: UILabel!
    @IBOutlet weak var bookSubLabel: UILabel!
    @IBOutlet weak var bookBackView: UIView!
    
    static let identifier = "BookTableCell"
    
    var book: Book! {
        didSet {
            bookMainLabel.text = book.title
            bookSubLabel.text = book.author
            guard let artworkUrl = URL(string: book.cover) else {return}
            artworkUrl.getImage { [weak self] img in
                if let image = img {
                    self?.bookImage.image = image
                }
            }
        }
    }
    
    override func layoutSubviews() {
        
        self.bookBackView.layer.cornerRadius = 15
        self.bookBackView.addShadow()
        self.backgroundColor = UIColor.tableGray
        
    }
}
