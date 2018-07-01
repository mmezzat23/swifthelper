
import Foundation



// swift3:Capturing an inout parameter, including self in a mutating method, becomes an error in an escapable closure literal, unless the capture is made explicit (and thereby immutable):
// Hate this : Forced to have a class :-(
class TestViewModel:ViewModelProtocol {
    
    var model:DynamicType = DynamicType<SelectDropDownModel>()
    
    func fetchData() {
        delegate?.startLoading()
        ApiManager.instance.callGet("test"){ response in
            self.delegate?.stopLoading()
            let data = SelectDropDownModel.convertToModel(response: response)
            //self.paginator(respnod: self.model.value?.data)
            self.model.value = data

        }
    }
    
    

}


