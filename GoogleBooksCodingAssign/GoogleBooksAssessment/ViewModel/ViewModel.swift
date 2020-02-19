

import Foundation

protocol ViewModelDelegate: class {
    func update()
}

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    
    var books = [Book]() {
        didSet {
            delegate?.update()
        }
    }
    
    var currentBook: Book! {
        didSet {
            get(currentBook.id)
        }
    }
    
}

extension ViewModel {
    
    func get(_ bookName: String) {
        
        google.getBook(for: bookName) { [weak self] googleResult in
            switch googleResult {
            case .success(let books):
                self?.books = books
            case .failure(let error):
                print("Google Error: \(error.localizedDescription)")
            }
        }
        
    }
}
