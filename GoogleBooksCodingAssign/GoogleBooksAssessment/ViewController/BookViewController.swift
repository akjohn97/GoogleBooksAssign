
import UIKit

class BookViewController: UIViewController {
    
    
    @IBOutlet weak var bookTableView: UITableView!
    
    var viewModel: ViewModel!
    
    var isHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBook()
        if isHidden {
            
        }
        
    }
    
    
    
    private func setupBook(){
        
        bookTableView.tableFooterView = UIView(frame: .zero)
        bookTableView.backgroundColor = UIColor.tableGray
        bookTableView.separatorStyle = .none
    }
    
}

//MARK: Data Source
extension BookViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCellOne.identifier, for: indexPath) as! ListTableCellOne
        let book = viewModel.currentBook
        cell.book = book
        return cell
        
        
    }
}

extension BookViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
