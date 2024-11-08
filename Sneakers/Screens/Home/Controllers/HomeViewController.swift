//
//  HomeViewController.swift
//  Sneakers
//
//  Created by Quick tech  on 08/11/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var past: UIView!
    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var upcommingView: UIView!
    
    @IBOutlet weak var pastLbl: UILabel!
    @IBOutlet weak var popularLbl: UILabel!
    @IBOutlet weak var upcommingLbl: UILabel!
    
    private var vm = ProductViewModel()
    var productParameters: Product!
    var productsArray: [ProductData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
}

extension HomeViewController {
    
    private func setUpUI() {
        pastLbl.text = "Past"
        popularLbl.text = "Popular"
        upcommingLbl.text = "Upcomming"
        
        textField.addTarget(self, action: #selector(textFieldTapped), for: .editingChanged)
        self.fetchProducts()
        self.setUpTableView()
    }
}

extension HomeViewController {
    @objc func textFieldTapped() {
        fetchProducts()
    }
}

extension HomeViewController {
    
    func setUpTableView() {
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchProducts() {
        if let searchText = textField.text, !searchText.isEmpty {
            productParameters = Product(key: "search_key", value: searchText, type: "text")
        } else {
            productParameters = Product(key: "len", value: "10", type: "text")
        }
        vm.fetchProducts(parameters: productParameters) { success in
           
            switch success {
            case .success(let products):
                self.productsArray = products as! [ProductData]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let productData = vm.productData[indexPath.row]
        cell.headingLbl.text = productData.title
        cell.priceLbl.text = "from $\(productData.prices.retail_price)"
        cell.dateLbl.text = productData.release_date
        ImageLoader.shared.loadImage(
            from: productData.master_image,
            into: cell.img,
            placeholder: UIImage(named: "placeholder"),
            progress: { receivedSize, totalSize in
                let progress = Float(receivedSize) / Float(totalSize)
                print("Download progress: \(progress * 100)%")
            }
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = vm.productData[indexPath.row]
        if let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Details") as? DetailViewController {
            vc.productResponse = selectedProduct
            self.present(vc, animated: true)
        }
    }
    
    
}
