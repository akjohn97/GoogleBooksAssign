
import UIKit

class ListTableCellOne: UITableViewCell {
    
    
    @IBOutlet weak var listMainImage: UIImageView!
    @IBOutlet weak var listBookLabel: UILabel!
    @IBOutlet weak var listAuthorLabel: UILabel!
    @IBOutlet weak var listDescriptionLabel: UILabel!
    @IBOutlet weak var listPublishedLabel: UILabel!
    @IBOutlet weak var listPageCountLabel: UILabel!
    @IBOutlet weak var listFavoriteButton: UIButton!
    
    
    static let identifier = "ListTableCellOne"
    
    var book: Book! {
        
        didSet{
            
            listBookLabel.text = book.title
            listAuthorLabel.text = book.author
            listDescriptionLabel.text = book.description
            listPublishedLabel.text = book.published
            listPageCountLabel.text = "\(book.pageCount) pages"
            guard let bookURL = URL(string: book.cover) else {return}
            bookURL.getImage{ [weak self] img in
                self?.listMainImage.image = img
            }
            
        }
    }
    
    
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        CoreManager.shared.save(book)
        
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
        layer.cornerRadius = 15
        addShadow()
    }
    
    
    
}
