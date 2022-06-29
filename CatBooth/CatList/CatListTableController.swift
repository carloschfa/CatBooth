import Foundation
import UIKit

extension CatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedItemCellIdentifier",
                                                                 for: indexPath) as? DetailedItemTableViewCell {
            if let cats = cats {
                cell.delegate = self
                cell.imageService = imageService
                cell.cat = cats[indexPath.row]
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension CatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}
