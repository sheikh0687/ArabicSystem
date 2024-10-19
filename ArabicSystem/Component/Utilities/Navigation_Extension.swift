//
//  Navigation_Extension.swift
//  فخدمتكو
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import Foundation

import UIKit
import LanguageManager_iOS
extension UIViewController {
    
    public func setNavigationBarItem(LeftTitle: String, LeftImage: String, CenterTitle: String, CenterImage: String, RightTitle: String, RightImage: String, BackgroundColor: String, BackgroundImage: String, TextColor: String, TintColor: String, Menu: String) {
        
        if LeftTitle != "" {
            addLeftBarButtonWithTitle(LeftTitle, Menu)
        }
        if LeftImage != "" {
            addLeftBarButtonWithImage(LeftImage, Menu)
        }
        if CenterTitle != "" {
            addCenterBarWithTitle(CenterTitle)
        }
        if CenterImage != "" {
            addCenterBarWithImage(CenterImage)
        }
        if RightTitle != "" {
            addRightBarButtonWithTitle(RightTitle)
        }
        if RightImage != "" {
            addRightBarButtonWithImage(RightImage)
        }
        if BackgroundColor != "" {
            setNavigationBarBackgroundColor(BackgroundColor)
        }
        if BackgroundImage != "" {
            setNavigationbarBackgroundImage(BackgroundImage)
        }
        if TextColor != "" {
            setNavigationBarTextColor(color: TextColor)
        }
        if TintColor != "" {
            setNavigationBarTintColor(color: TintColor)
        }
    }
    
    public func addLeftBarButtonWithTitle(_ buttonTitle: String, _ menu: String) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(title: buttonTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.leftClick))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    public func addLeftBarButtonWithImage(_ buttonImage: String, _ menu: String) {
        if LanguageManager.shared.isRightToLeft {
            let image = UIImage(named: buttonImage)
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: image?.flipHorizontally(), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.leftClick))
            navigationItem.leftBarButtonItem = leftButton
        } else {
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: buttonImage)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.leftClick))
            navigationItem.leftBarButtonItem = leftButton
        }
    }
    
    public func addCenterBarWithTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    public func addCenterBarWithImage(_ imageName: String) {
        let image: UIImage = UIImage(named: imageName)!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    public func addRightBarButtonWithTitle(_ buttonTitle: String) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: buttonTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.rightClick))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    public func addRightBarButtonWithImage(_ buttonImage: String) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: buttonImage)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.rightClick))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    public func setNavigationBarBackgroundColor(_ BackgroundColor: String) {
        self.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: BackgroundColor)
    }
    
    public func setNavigationbarBackgroundImage(_ imageName: String) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
    }
    
    public func setNavigationBarTextColor(color: String) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): hexStringToUIColor(hex: color)]
    }
    
    private func setNavigationBarTintColor(color: String) {
        navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: color)
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc public func leftClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc public func rightClick() {
        print("Right Click")
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func showProgressBar() {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        spinnerActivity.label.text = "Loading".localiz();
        spinnerActivity.detailsLabel.text = "Please Wait".localiz();
        spinnerActivity.isUserInteractionEnabled = true;
    }
    
    func hideProgressBar() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func blockUi() {
        MBProgressHUD.hide(for: self.view, animated: true)
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        if spinnerActivity.isUserInteractionEnabled {
            spinnerActivity.bezelView.isHidden = true
            spinnerActivity.bezelView.color = .clear
            spinnerActivity.isUserInteractionEnabled = true;
        }
    }
    
    func unBlockUi() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func alert(alertmessage: String) {
        let alert = UIAlertController(title: k.appName, message: alertmessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok".localiz(), style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }
                                     )
        )
        self.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    func getStringSize(string: String, fontSize: CGFloat) -> CGSize {
        let size: CGSize = string.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        return size
    }
    
    func showToast(message: String) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(toast, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            toast.dismiss(animated: true, completion: nil)
        }
    }
    
    func placeholderText(_ txtField: UITextField,_ color: UIColor,_ textFieldValue: String)
    {
        let placeHolderText = textFieldValue
        let PlaceHolderColor = color
        
        let attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: PlaceHolderColor])
        
        
        txtField.attributedPlaceholder = attributedPlaceholder
    }
 
    func datePickerTapped(strFormat: String, mode: UIDatePicker.Mode, type: String, selectedDate: Date? = nil, completionBlock complete: @escaping (_ dateString: String) -> Void) {
        let currentDate = Date()
        var dateString: String = ""
        var minimumTime: Date? = nil

//        if mode == .time {
//            let calendar = Calendar.current
//            // Calculate 2 hours ahead of the current time
//            minimumTime = calendar.date(byAdding: .hour, value: Int(1.59), to: currentDate)
//        }
        
        if mode == .time {
            let calendar = Calendar.current
            let currentDate = Date() // Make sure you have the current date defined

            // Create date components for 1 hour and 59 minutes
            var dateComponents = DateComponents()
            dateComponents.hour = 1
            dateComponents.minute = 59
            
            // Calculate the new date by adding the date components to the current date
            minimumTime = calendar.date(byAdding: dateComponents, to: currentDate)
        }

        let datePicker = DatePickerDialog(textColor: .darkGray,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)

        var minimumDate: Date?
        var maximumDate: Date?

        // Check if a specific date is passed
        if let selectedDate = selectedDate {
            let calendar = Calendar.current
            let startOfSelectedDate = calendar.startOfDay(for: selectedDate)
            let endOfSelectedDate = calendar.date(byAdding: .day, value: 1, to: startOfSelectedDate)?.addingTimeInterval(-1)

            minimumDate = startOfSelectedDate
            maximumDate = endOfSelectedDate
        }

        let isEnglish = LanguageManager.shared.currentLanguage == .en

        datePicker.show(type,
                        doneButtonTitle: isEnglish ? "Done" : "تم",
                        cancelButtonTitle: isEnglish ? "Cancel" : "إلغاء",
                        minimumDate: minimumDate,
                        maximumDate: maximumDate,
                        datePickerMode: mode) { (date) in

            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = strFormat

                if mode == .date {
                    dateString = formatter.string(from: dt)
                } else {
                    // If today is selected, check if the selected time is less than 2 hours from current time
                    if Calendar.current.isDateInToday(dt) {
                        if let minTime = minimumTime, dt < minTime {
                            print(minTime)
                            // Show alert if selected time is less than 2 hours ahead
                            let message = LanguageManager.shared.currentLanguage == .en ?
                            "If you want to order a maid today, please select the time 2 hours later" :
                            "الرجاء طلب الخدمه قبل الوقت المحدد بساعتين"
                            self.alert(alertmessage: message)
                        } else {
                            
                                
                            // Time is valid
                            dateString = formatter.string(from: dt)
                        }
                    } else {
                        // For other dates, just format the selected time
                        dateString = formatter.string(from: dt)
                    }
                }
                complete(dateString)
            }
        }
    }
}

//                        if let minDate = minimumDate, let maxDate = maximumDate {
//                            if dt >= minDate && dt <= maxDate {
//
//                            } else {
//                                let message = LanguageManager.shared.currentLanguage == .en ?
//                                "Please select a time within the selected date." :
//                                "يرجى تحديد وقت ضمن التاريخ المحدد."
//                                self.alert(alertmessage: message)
//                            }
//                        } else {
//                            dateString = formatter.string(from: dt)
//                        }
