//
//  RegisterPickerView.swift
//  Saaedny
//
//  Created by tarek ali on 2/17/19.
//  Copyright © 2019 Onnety. All rights reserved.
//

import Foundation

protocol PickerViewDelegate: class {
    func didSelectItem(item: Int)
    func didSelectItem(for item: Any)
}
extension PickerViewDelegate {
    func didSelectItem(item: Int) {
        
    }
    func didSelectItem(for item: Any) {
        
    }
}

typealias PickerTitleHandler = (Int) -> String?
typealias PickerDidSelectPath = (Int) -> Void
typealias PickerDidSelectItem = (Any) -> Void

class PickerViewHelper: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!  {
        didSet {
            pickerView.delegate = self
            pickerView.dataSource = self
        }
    }
    
    weak var delegate: PickerViewDelegate?
    var source: [Any] = []
    var titleClosure: PickerTitleHandler?
    var didSelectClosure: PickerDidSelectPath?
    var didSelectItemClosure: PickerDidSelectItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func okBtn(_ sender: Any) {
        self.dismiss(animated: true) {
            if self.source.count > 0 {
                let id = self.pickerView.selectedRow(inComponent: 0)
                self.delegate?.didSelectItem(item: id)
                self.delegate?.didSelectItem(for: self.source[id])
                self.didSelectClosure?(id)
                self.didSelectItemClosure?(id)
            }
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PickerViewHelper: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return source.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleClosure?(row)
    }
    
}
