
import UIKit
import Alamofire


let ServiceManager = PServiceManager.shared

class PServiceManager: NSObject {
    
    static let shared = PServiceManager()
    
    //Usage: POST Api
    func apiCallAny( parameters : [String : Any] , completion : @escaping ( _ isSuccess:Bool,  _ message:String) -> Void)
    {
        
        callPOSTApiWithNetCheck(url: postUrl(""), headersRequired: false, params: parameters) { (response, isInternetAvailable) in
            
            if(isInternetAvailable) {
                
                switch response!.result{
                    
                case .success(let JSON):
                    print("JSON : \(JSON)")
                    
                    let dictJson = JSON as! NSDictionary
                    let status = dictJson.object_forKeyWithValidationForClass_Int(aKey: "success")
                    
                    if(status == 1){
                        
                        completion(true,"")
                    }else{
                        let message = dictJson.object_forKeyWithValidationForClass_String(aKey: "error_code")
                        completion(false,message)
                    }
                    
                case .failure(let error):
                    print("ERR : \(error.localizedDescription)")
                    completion(false,error.localizedDescription)
                }
            }else{
                completion(false,INTERNET_MESSAGE)
            }
        }
    }
    
    
    
    //Usage Upload File
    
    func apiUploadProfile( parameters : [String : Any] , image: UIImage?, completion : @escaping ( _ isSuccess:Bool,  _ message:String) -> Void)
    {
        
        callUPLOADApiWithNetCheck(url: postUrl(""), image: image, headersRequired: false, params: parameters) { (response, isInternetAvailable) in
            
            if(isInternetAvailable) {
                
                switch response!.result{
                    
                case .success(let JSON):
                    print("JSON : \(JSON)")
                    
                    let dictJson = JSON as! NSDictionary
                    let status = dictJson.object_forKeyWithValidationForClass_Int(aKey: "success")
                    
                    if(status == 1){
                        let message = dictJson.object_forKeyWithValidationForClass_String(aKey: "data")
                        completion(true,message)
                    }else{
                        let message = dictJson.object_forKeyWithValidationForClass_String(aKey: "error_code")
                        completion(false,message)
                    }
                    
                case .failure(let error):
                    print("ERR : \(error.localizedDescription)")
                    completion(false,error.localizedDescription)
                }
            }else{
                completion(false,INTERNET_MESSAGE)
            }
        }
    }
    
    
    
    
    
    
    //MARK:- =================== COMMON ===================
    //MARK:- ******** COMMON POST METHOD *********
    
    private func callGETApiWithNetCheck(url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
        callGET_POSTApiWithNetCheck(isGet: true, url: url, headersRequired: headersRequired, params: params, completionHandler: completionHandler)
    }
    
    private func callPOSTApiWithNetCheck(url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
        callGET_POSTApiWithNetCheck(isGet: false, url: url, headersRequired: headersRequired, params: params, completionHandler: completionHandler)
    }
    
    private func callGET_POSTApiWithNetCheck(isGet:Bool, url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
        
        if(!IS_INTERNET_AVAILABLE()){
            //SHOW_INTERNET_ALERT()
            completionHandler(nil,false)
            return
        }
        var headers:[String:String] = [:]
        if headersRequired {
            headers["user-id"] = ""//AIUser.sharedManager.user_id
            headers["access-token"] = ""//AIUser.sharedManager.access_token
        }
        
        var parameter = params
        if IS_FOR_DEVELOP {
            parameter?["developtype"] = "sandbox"
        }
        
        print("\n\nURL : \(url) \nPARAM : \(getStringFromDictionary(dict: parameter!)) \nHEADERS : \(getStringFromDictionary(dict: headers))")
        print("Is Get Api : ",isGet)
        
        
        Alamofire.request(url, method: isGet ? .get : .post, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result{
            case .success(let JSON):
                let dictJson = JSON as! NSDictionary
                //let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "data")
                let status = dictJson.object_forKeyWithValidationForClass_Int(aKey: "success")
                if(status == 1){
                    completionHandler(response,true)
                }else{
                    completionHandler(response,true)
                }
            case .failure( let err):
                print(err)
                //The network connection was lost.
                completionHandler(response,true)
            }
        }
    }
    
    //MARK:- ******** COMMON MULTIPART METHOD *********
    
    
    
    private func callUPLOADApiWithNetCheck(url : String, image:UIImage?, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
        
        if(!IS_INTERNET_AVAILABLE()){
            //SHOW_INTERNET_ALERT()
            completionHandler(nil,false)
            return
        }
        
        var headers:[String:String] = [:]
        if headersRequired {
            headers["user-id"] = ""
            headers["access-token"] = ""
        }
        
        print("\n\n\n\n\nURL : \(url) \nPARAM : \(getStringFromDictionary(dict: params!)) \nHEADERS : \(getStringFromDictionary(dict: headers))")
        
        SHOW_NETWORK_ACTIVITY_INDICATOR()
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            
            if let params = params {
                for eachKey in params.keys {
                    if let value = params[eachKey] as? String {
                        multipartFormData.append(value.data(using: .utf8)!, withName: eachKey)
                    }
                }
            }
            
            if let image = image {
                if let imageData = image.jpegData(compressionQuality: 1) {
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")//profile_picture
                }
            }
        },
                         usingThreshold:UInt64.init(),
                         to:url,
                         method:.post,
                         headers:headers,
                         encodingCompletion: { encodingResult in
                            
                            HIDE_NETWORK_ACTIVITY_INDICATOR()
                            
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    completionHandler(response,true)
                                }
                            case .failure(let encodingError):
                                print("ERR: UPLOAD: \(encodingError.localizedDescription)")
                                completionHandler(nil,true)
                            }
        })
    }
    
}


//MARK:- STRING FROM DICT
func getStringFromDictionary(dict:Any) -> String{
    var strJson = ""
    do {
        let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        strJson = String(data: data, encoding: String.Encoding.utf8)!
    } catch let error as NSError {
        print("json error: \(error.localizedDescription)")
    }
    
    return strJson
}

//MARK:- NETWORK ACTIVITY INDICATOR

func SHOW_NETWORK_ACTIVITY_INDICATOR(){
    UIApplication.shared.isNetworkActivityIndicatorVisible =  true
}

func HIDE_NETWORK_ACTIVITY_INDICATOR(){
    UIApplication.shared.isNetworkActivityIndicatorVisible =  false
}
