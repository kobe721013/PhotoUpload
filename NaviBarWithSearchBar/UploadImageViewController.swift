//
//  UploadImageViewController.swift
//  NaviBarWithSearchBar
//
//  Created by Tom Lee on 29/11/2017.
//  Copyright © 2017 IOI. All rights reserved.
//

import UIKit
import Photos

class UploadImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getPhotos(_ sender: Any) {
    
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                fetchOptions.includeAssetSourceTypes = PHAssetSourceType(rawValue: PHAssetSourceType.typeiTunesSynced.rawValue + PHAssetSourceType.typeUserLibrary.rawValue)
                //fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)

                
                let allPhotos = PHAsset.fetchAssets(with: fetchOptions)
                print("Found \(allPhotos.count) images")
                
                for i in 0 ..< 6 {
                    if(i < 5){
                        continue
                    }
                    
                    
                    let asset = allPhotos[i]
                    
                    print("=====")
                    print("Type:\(asset.mediaType)")
                    print("creationDate:\(asset.creationDate!)")
                    print("localIdentifier:\(asset.localIdentifier)")

                    
                    let requestOptions = PHImageRequestOptions()
                    requestOptions.deliveryMode = .highQualityFormat
                    requestOptions.version = .original
                    requestOptions.isNetworkAccessAllowed = true
                    
                    
                    let phManager = PHImageManager.default()
                        
                    phManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) {
                        (image, _) in
                        print("image size = \(String(describing: image?.size))")
                        
                    }
                    
                    
                    phManager.requestImageData(for: asset, options: requestOptions){
                        (data,_,_,_) in
                        print("data size= \(String(describing: data?.count))")
                        
                    }
                    
 
                    //get imagedata from id
                    let fetchFromIDResult = PHAsset.fetchAssets(withLocalIdentifiers: [asset.localIdentifier], options: fetchOptions)
                    for j in 0 ..< fetchFromIDResult.count
                    {	
                        let asset2 = fetchFromIDResult[j]
                        phManager.requestImageData(for: asset2, options: requestOptions){
                            (data,_,_,_) in
                            print("data2 size= \(String(describing: data?.count))")
                            
                        }
                    }
                    
                    //print("location:\(asset.location!)")
                    //print("duration:\(asset.duration)")
                }
                
                //get albums
                let fetchOptions2 = PHFetchOptions()
                let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions2)
                print("albums=\(albums.count)")
                for i in 0 ..< albums.count {
                    
                    let album = albums[i]
                    print("=====")
                    print("localizedTitle:\(album.localizedTitle!)")
                    let albumImages = PHAsset.fetchAssets(in: album, options: fetchOptions)
                    print("albums count = \(albumImages.count)")
                    
                    
                    //print("creationDate:\(asset.creationDate!)")
                    //print("location:\(asset.location!)")
                    //print("duration:\(asset.duration)")
                }
                
                
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            }
        }
        /*
        let photosOption = PHFetchOptions()
        photosOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending:false)]
        photosOption.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        
        let result = PHAsset.fetchAssets(with: .image, options: photosOption)
        
        print("photos count = \(result.count)")
        if(result.count == 0){
            return
        }
        
        
        for i in 0...(result.count-1) {
            
            let asset = result[i]
            print("=====")
            print("Type:\(asset.mediaType)")
            print("creationDate:\(asset.creationDate!)")
            print("location:\(asset.location!)")
            print("duration:\(asset.duration)")
        }
        */
        /*
        if let imageData = result?[0]
        {
            var phManager = PHImageManager.default()
            phManager.requestImage(for: imageData, targetSize: <#T##CGSize#>, contentMode: <#T##PHImageContentMode#>, options: <#T##PHImageRequestOptions?#>, resultHandler: <#T##(UIImage?, [AnyHashable : Any]?) -> Void#>)
        }
        */
        
    }
    @IBAction func sendTestImage(_ sender: Any) {
        uploadTestImage()
    }
    func uploadTestImage()
    {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.20.199:9900/api/photos")! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let image = UIImage(named: "kobe")
        //let imageReverData = image.data
        if let imageData = UIImagePNGRepresentation(image!) {
            let encodedImageData = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            let json = ["Uuid":"123456789", "Name":"kobetest.png", "DateTime":"2017/11/29", "Data": encodedImageData]
            
            do {
                let jsonData = try	JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)//try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                request.httpBody = jsonData
            }
            catch
            {
                print("error on JSONSerialization")
            }
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription as Any)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        //let code:String = parseJSON["Code"] as! String;
                        //let message:String = parseJSON["Message"] as! String;
                        //print("code: \(code), Message=[\(message)]")
                        print("\(parseJSON)")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }
            
        }
     
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


