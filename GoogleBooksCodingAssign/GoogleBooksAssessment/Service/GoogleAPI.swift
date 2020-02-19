
import Foundation

struct GoogleAPI {
    
    var bookName: String!
    var bookID: Int!
    
    let base = "https://www.googleapis.com/books/v1/volumes?q="
    
    init(_ name: String? = nil, _ id: Int? = nil){
        self.bookName = name
        self.bookID = id
    }
    
    var bookUrl: URL? {
        guard let name = bookName else {return nil}
        return URL(string: base + name)
    }
}
