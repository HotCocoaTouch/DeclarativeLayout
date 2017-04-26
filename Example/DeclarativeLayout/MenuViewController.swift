import UIKit
import DeclarativeLayout

class MenuViewController: UITableViewController {
    
    enum Row {
        case registrationWithoutFramework
        
        static var allRows: [Row] {
            return [.registrationWithoutFramework]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu"
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allRows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        switch Row.allRows[indexPath.row] {
        case .registrationWithoutFramework:
            cell.textLabel?.text = "Registration Screen Without Framework"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Row.allRows[indexPath.row] {
        case .registrationWithoutFramework:
            navigationController?.pushViewController(RegistrationWithoutFrameworkViewController(), animated: true)
        }
    }
}
