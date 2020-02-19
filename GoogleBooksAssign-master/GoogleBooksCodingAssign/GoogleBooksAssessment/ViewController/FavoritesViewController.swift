

import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    let viewModel = ViewModel()
    
    var books = [Book](){
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavorites()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        books = CoreManager.shared.load()
        
    }
    
    private func setupFavorites(){
        favoritesTableView.register(UINib(nibName: BookTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BookTableCell.identifier)
        
        favoritesTableView.tableFooterView = UIView(frame: .zero)
        favoritesTableView.backgroundColor = UIColor.tableGray
        favoritesTableView.separatorStyle = .none
    }
}

extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableCell.identifier, for: indexPath) as! BookTableCell
        
        let book = books[indexPath.row]
        
        cell.book = book
        return cell
    }
    
    
    
}

extension FavoritesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let book = books[indexPath.row]
        viewModel.currentBook = book
        let bookVC = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        bookVC.viewModel = viewModel // pass view model to album VC
        bookVC.hidesBottomBarWhenPushed = true
        
        
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(bookVC, animated: true)
        
        
    }
    
}
