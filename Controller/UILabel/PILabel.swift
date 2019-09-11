import UIKit

class PILable: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitUI()
    }
    override func awakeFromNib() {
        commitUI()
    }
    
    func commitUI() {
        self.font = UIFont.regulerFont(ofSize: self.font.pointSize)
    }
    
}
