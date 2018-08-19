//
//  AttributeView.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

protocol AttributeViewDelegate: class {
    func attributeView(_ attributeView: AttributeView, didChange option: ProductViewModel.Attributes.Options?, for attribute: ProductViewModel.Attributes?)
}


class AttributeView: UIView{
    
    private lazy var textField: UITextField = makeTextField()
    private lazy var pickerView: UIPickerView = makePickerView()
    weak var delegate: AttributeViewDelegate?
    var attributes: ProductViewModel.Attributes?{
        didSet{
            setPickerPosition()
            if let selected = attributes?.options.first(where: {$0.isSelected}){
                textField.text = selected.label
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leftAnchor.constraint(equalTo: leftAnchor),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func makeTextField() -> UITextField{
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = UIColor.gray.cgColor
        field.layer.borderWidth = 1.0
        field.inputView = pickerView
        field.inputAccessoryView = makeToolbar()
        field.textAlignment = .center
        field.tintColor = .clear
        field.textColor = .gray
        field.placeholder = "SELECT"
        field.rightViewMode = .always
        field.rightView = makeArrowImageView()
        return field
    }
    
    private func makeArrowImageView() -> UIImageView{
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
        imageView.image = #imageLiteral(resourceName: "arrow_down")
        imageView.contentMode = .left
        return imageView
    }

    private func makePickerView() -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }
    
    private func makeToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action:#selector(AttributeView.didTapDone))

        toolBar.setItems([flexible, doneButton], animated: false)
        return toolBar
    }
    
    @objc private func didTapDone(){
        let index = pickerView.selectedRow(inComponent: 0)
        guard let selectedOption = attributes?.options[index] else { return }
        textField.text = selectedOption.label
        textField.resignFirstResponder()
        delegate?.attributeView(self, didChange: selectedOption, for: attributes)
    }

    private func setPickerPosition(){
        if let row = attributes?.options.index(where: { (option) -> Bool in
            return option.isSelected
        }){
            pickerView.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
}


extension AttributeView: UIPickerViewDelegate{
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let option = attributes?.options[row]
//        textField.text = option?.label
//        delegate?.attributeView(self, didChange: option, for: attributes)
//    }
}

extension AttributeView: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return attributes?.options.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let attribute = attributes else { return nil }
        return attribute.options[row].label
    }
}
