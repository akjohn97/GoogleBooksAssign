
import Foundation

enum GoogleError: Error {
    case badURL(String)
    case badDataTask(String)
    case badDecoder(String)
}

typealias BookHandler = (Result<[Book], GoogleError>) -> Void

let google = GoogleService.shared

final class GoogleService {
    
    static let shared = GoogleService()
    
    private init() {}
    
    //MARK: Get Book
    func getBook(for bookName: String, completion: @escaping BookHandler){
        guard let url = GoogleAPI(bookName).bookUrl else {
            completion(.failure(.badURL("Couldn't create book URL.")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.failure(.badDataTask("Bad Data Task: \(error.localizedDescription)"))) // pass error description if failed
                return // exit the scope
            }
            
            if let data = dat {
                
                do{
                    
                    let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    let booktype = self.jsonToBook(dict: response!)
                    completion(.success(booktype))
                    
                    
                } catch {
                    completion(.failure(.badDecoder("Bad Decoder: \(error.localizedDescription)")))
                    return
                }
                
            }
            
            
        }.resume()
    }
    
    private func jsonToBook(dict: [String:Any]) -> [Book]{
        
        var jsonBookArray = [Book]()
        
        //Access book index
        guard let bookDict = dict["items"] as? [NSDictionary] else {
            return [Book]()
        }
        
        for index in bookDict {
            let workingDict = index
            let id = workingDict["id"]
            var emptyAuthor = ""
            var emptyImage = ""
            
            //Dictionaries to use
            let volumeInfo = workingDict.value(forKey: "volumeInfo") as! NSDictionary
            if let authorDict = volumeInfo.value(forKey: "authors") as? NSArray{ emptyAuthor = authorDict.firstObject as! String}
            if let imageDict = volumeInfo.value(forKey: "imageLinks") as? NSDictionary { emptyImage = imageDict.value(forKey: "smallThumbnail") as! String
                
            }
            
            //Variables to set
            let title = volumeInfo.value(forKey: "title") ?? "No author specified."
            let description = volumeInfo.value(forKey: "description") ?? "No description specified."
            let pageCount = volumeInfo.value(forKey: "pageCount") ?? 0
            let publisher = volumeInfo.value(forKey: "publisher") ?? "No publisher specified."
            
            jsonBookArray.append(Book(author: emptyAuthor as! String, id: id as! String, title: title as! String, published: publisher as! String, pageCount: pageCount as! Int, description: description as! String, cover: emptyImage as! String))
            
        }
        
        return jsonBookArray
    }
}
