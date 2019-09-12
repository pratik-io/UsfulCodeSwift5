
import UIKit
import NVActivityIndicatorView

enum backGround: String {
    //case car        = "backgroundCar"
    case plain      = "backgroundPlain"
    case onBoarding = "backgroundOnBoarding"
    //case night      = "backgroundNight"
    case summary    = "backgroundSummary"
}

enum leftButton: String {
    case back  = "back"
    case menu  = "menu"
    case menu2 = "menu2"
    case none  = ""
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
    }
    
    
    
    //MARK:- FUNCTION
    private func setUp() {
        
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(self.backAction(sender:)))
    }
    
    @objc func backAction(sender: AnyObject) {
        //Your Code
    }
    
    func setLeftButton(type: leftButton) {
        
        //var btnLeftback: UIButton = UIButton(frame: CGRect(x: 29, y: 2, width: 40, height: 40)) // x = 16 +... defult
        var btnLeftback: UIButton = UIButton(frame: CGRect(x: 10, y: 0, width: 40, height: 44))
        btnLeftback.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        switch type {
        case .back:
            btnLeftback.setImage(UIImage(named: "back"), for: .normal)
            btnLeftback.addTarget(self, action: #selector(popToViewController), for: .touchUpInside)
            break
        case .menu:
            btnLeftback.setImage(UIImage(named: "menu"), for: .normal)
            btnLeftback.addTarget(self, action: #selector(homeMenu_Clicked), for: .touchUpInside)
            break
        case .menu2:
            btnLeftback = UIButton(frame: CGRect(x: 19, y: 2, width: 40, height: 40))
            btnLeftback.setImage(UIImage(named: "menu2"), for: .normal)
            btnLeftback.addTarget(self, action: #selector(homeMenu_Clicked), for: .touchUpInside)
            break
        case .none:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(self.backAction(sender:)))
            return
        }
        
        
        let custView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        custView.backgroundColor = UIColor.clear
        custView.addSubview(btnLeftback)
        let barButton  = UIBarButtonItem(customView: custView)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func setTitle(_ title: String) {
        print("Title : ",title)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.regulerFrankRuhlFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = title
        
    }
    
    
    
    
    @objc func popToViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func homeMenu_Clicked() {
        print("Home.")
        //logout()
    }
    
    
    
}

extension BaseViewController : NVActivityIndicatorViewable
{
    // MARK: - Show loader
    func showActivityIndicator(withText text: String) {
        let size = CGSize(width: 60, height:60)
        
        startAnimating(size, message: text, type: NVActivityIndicatorType.ballScaleMultiple, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
    }
    
    //MARK: - hideloader
    func hideActivityIndicator() {
        stopAnimating()
    }
}
