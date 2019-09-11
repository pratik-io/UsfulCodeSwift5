

import Foundation
import Reachability

class AIReachabilityManager: NSObject {
	
	private let reachability = Reachability()!
	private var isFirstTimeSetupDone:Bool = false
	private var callCounter:Int = 0
	
	// MARK: - SHARED MANAGER
	static let shared: AIReachabilityManager = AIReachabilityManager()

	
	//MARK:- ALL NETWORK CHECK
	func isInternetAvailableForAllNetworks() -> Bool {
		if(!self.isFirstTimeSetupDone){
			self.isFirstTimeSetupDone = true
			doSetupReachability()
		}
        
    return reachability.connection != .none ||  reachability.connection == .wifi || reachability.connection == .cellular
        
//		return reachability.connection || reachability.isReachableViaWiFi || reachability.isReachableViaWWAN
	}
	
	
	//MARK:- SETUP
	private func doSetupReachability() {
	
		reachability.whenReachable = { reachability in
			DispatchQueue.main.async {
				self.postIntenetReachabilityDidChangeNotification(isInternetAvailable: true)
			}
		}
		reachability.whenUnreachable = { reachability in
			DispatchQueue.main.async {
				self.postIntenetReachabilityDidChangeNotification(isInternetAvailable: false)
			}
		}
		do{
			try reachability.startNotifier()
		}catch{
		}
	}
	
	deinit {
		reachability.stopNotifier()
//        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
	}

	
	
	//MARK:- NOTIFICATION
	private func postIntenetReachabilityDidChangeNotification(isInternetAvailable isAvailable:Bool){
//		print("\n\n")
//		print("NET REACHABILITY CHANGED : \(isAvailable)")
		
		DispatchQueue.main.async {
			
			if(isAvailable){
				// TO AVOID INITIAL ALERT
				if(self.callCounter != 0){
                    print("You are now ONLINE")
//                    let dialog = AIDialogueSnackAlert()
//                    dialog.showDialogue(withMessage: "You are now ONLINE", bgColor: Constant.Colors.APP_COLOR_GREEN, topBottomMargin: 12) { (completion) in
//                    }
				}
			}else{
                print("You are now OFFLINE")
//                let dialog = AIDialogueSnackAlert()
//                dialog.showDialogue(withMessage: "You are now OFFLINE", bgColor: Constant.Colors.APP_COLOR_RED, topBottomMargin: 12) { (completion) in
//                }
			}
			self.callCounter += 1
			
//            NotificationCenter.default.post(NSNotification(name: ReachabilityChangedNotification, object: nil) as Notification)

		}
		
	}
}

//MARK:- INTERNET CHECK
func IS_INTERNET_AVAILABLE() -> Bool{
    return AIReachabilityManager.shared.isInternetAvailableForAllNetworks()
}


let INTERNET_MESSAGE:String = "Please check your internet connection and try again."
func SHOW_INTERNET_ALERT(){
    print("Show Alert")
}
