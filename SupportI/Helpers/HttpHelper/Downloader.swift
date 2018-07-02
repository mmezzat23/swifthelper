import Alamofire
protocol DownloaderDelegate {
    func fileCallback(file:URL?)
    func downloadStatus(status:String?)
}

protocol Downloader : class{
    func downloader(file:String?) 
}

fileprivate var delegateFile:DownloaderDelegate?

extension Downloader{
    var downloaderDelegate:DownloaderDelegate?{
        set{
            delegateFile = newValue
        }get{
            return delegateFile
        }
    }

    func downloader(file:String? = nil)  {
        
        guard let _ = file else {return}
        guard let fileUrl = URL(string: file!) else {return}
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("\(randomString()).\(fileUrl.pathExtension)")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        if let url = file{
            
            Alamofire.download(url, to: destination).response { response in
                if response.response?.statusCode == 200 && response.destinationURL != nil{
                    self.downloaderDelegate?.downloadStatus(status: translate("ok"))
                    self.downloaderDelegate?.fileCallback(file: response.destinationURL)
                }else if response.error != nil{
                    self.downloaderDelegate?.downloadStatus(status: response.error?.localizedDescription)
                }
                
                
            }
        }
        
        

    }
}


func download(file:String? = nil){
    guard let url = file else {
        return
    }
    // Create destination URL
    let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
    let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
    //Create URL to the source file you want to download
    let fileURL = URL(string: url)
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    let request = URLRequest(url:fileURL!)
    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
        if let tempLocalUrl = tempLocalUrl, error == nil {
            // Success
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Successfully downloaded. Status code: \(statusCode)")
            }
            
            do {
                try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
            } catch (let writeError) {
                print("Error creating a file \(destinationFileUrl) : \(writeError)")
            }
            
        } else {
            //print("Error took place while downloading a file. Error description: %@", error?.localizedDescription)
        }
    }
    task.resume()
    
}


