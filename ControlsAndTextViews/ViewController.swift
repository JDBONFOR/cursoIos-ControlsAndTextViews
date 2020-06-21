//
//  ViewController.swift
//  ControlsAndTextViews
//
//  Created by Juan Bonforti on 21/06/2020.
//  Copyright © 2020 Juan Bonforti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    
    
    
    // MARK: Variables
    private let myPickerViewValues:[String] = ["Uno","Dos","Tres","Cuatro","Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Edit button UI
        myButton.setTitle("Mi botón", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
        // Edit PickerView
        myPickerView.backgroundColor = .lightGray
        myPickerView.dataSource = self // Implementamos protocolo que este viewController, se encarga de cargarlo.
        myPickerView.delegate = self // Le indicamos que, este viewController se encarga de atrapar las acciones.
        myPickerView.isHidden = true
        
        // Edit PageControl
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .blue
        myPageControl.pageIndicatorTintColor = .lightGray
        
        
        // Edit SegmentedControl
        mySegmentedControl.removeAllSegments();
        for (index, value) in myPickerViewValues.enumerated() {
        mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // Edit Slider
        mySlider.minimumTrackTintColor = .red
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count) // No acepta solo INT
        mySlider.value = 1
        
        // Steppers
        myStepper.minimumValue = 1
        myStepper.maximumValue = Double(myPickerViewValues.count)
        
        // Switch
        mySwitch.onTintColor = .purple
        mySwitch.isOn = false
        
        // Progress Indicator
        myProgressView.progress = 0
        
        // Activity Indicator
        myActivityIndicator.color = .orange
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true; // Le dejamos el flag q oculte si se deja de mostrar.
        
        // Labels
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 36)
        myStepperLabel.text = "1"
        
        mySwitchLabel.text = "Está apagado"
        
        // TextField
        myTextField.textColor = .brown
        myTextField.placeholder = "Escribe algo"
        myTextField.delegate = self
        
        // TextView
        myTextView.textColor = .brown
        myTextView.delegate = self
        //myTextView.isEditable = false
    }

    // MARK: IBActions
    // Button
    @IBAction func myButtonAction(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
        } else {
            myButton.backgroundColor = .blue
        }
        
        myTextView.resignFirstResponder()
        
    }
    // PageControl ( selector de pagina )
    @IBAction func myPageControlAction(_ sender: Any) {
        myPickerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        let myString = myPickerViewValues[myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
        mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
    }
    // Segmented Control
    @IBAction func mySegmentControlAction(_ sender: Any) {
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
    }
    // Slider
    @IBAction func mySliderAction(_ sender: Any) {
        var progress: Float = 0
        
        switch mySlider.value {
        case 1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
            progress = 0.2
        case 2..<3:
        mySegmentedControl.selectedSegmentIndex = 1
        progress = 0.3
        case 3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
            progress = 0.6
        case 4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
            progress = 0.8
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            progress = 1
        }
        
        // El progress es 0 y 1, 0 o 100%
        
        myProgressView.progress = progress
        
        // ToDo, cambiar los demas elementos.
        
    }
    // Steppers
    @IBAction func myStepperAction(_ sender: Any) {
        let value = myStepper.value
        mySlider.value = Float(value)
        myStepperLabel.text = "\(mySlider.value)"
    }
    @IBAction func mySwitchAction(_ sender: Any) {
        if mySwitch.isOn {
            myPickerView.isHidden = false
            myActivityIndicator.stopAnimating()
            
            mySwitchLabel.text = "Está encendido"
        } else {
            myPickerView.isHidden = true
            myActivityIndicator.startAnimating()
            
            mySwitchLabel.text = "Está apagado"
        }
    }
    
    
}

// MARK: Extensiones de PickerView
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // Numero de componentes que vamos a tener, columnas del PickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Cantidad de elementos en el listado
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
    // Elemento que se mostará
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    // Accion de seleccionar un elemento del picker.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = row
        mySegmentedControl.selectedSegmentIndex = row
        
    }
    
}

// MARK: Extensiones de TextField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(textField.text, for: .normal)
    }
}
extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextField.isHidden = true;
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false
    }
}
