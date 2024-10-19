//
//  NotificationVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class NotificationVC: UIViewController {

    @IBOutlet weak var tbl_Vw: UITableView!
    
    var arr_Notification: [Res_Notification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_Vw.register(UINib(nibName: "NotifyCell", bundle: nil), forCellReuseIdentifier: "NotifyCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.notification_List()
    }
}

extension NotificationVC {
    
    func notification_List()
    {
        Api.shared.notification_List(self) { responseData in
            let obj = responseData
            if obj.status == "1" {
                self.arr_Notification = obj.result ?? []
                self.tbl_Vw.backgroundView = UIView()
                self.tbl_Vw.reloadData()
            } else {
                self.arr_Notification = []
                self.tbl_Vw.backgroundView = UIView()
                if LanguageManager.shared.currentLanguage == .en {
                    Utility.noDataFound("No Data Available", tableViewOt: self.tbl_Vw, parentViewController: self)
                } else {
                    Utility.noDataFound("لا توجد بيانات متاحة", tableViewOt: self.tbl_Vw, parentViewController: self)
                }
                self.tbl_Vw.reloadData()
            }
        }
    }
}

extension NotificationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_Notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifyCell", for: indexPath) as! NotifyCell
        let obj = self.arr_Notification[indexPath.row]
        cell.lbl_Message.text = obj.message ?? ""
        cell.lbl_DateTime.text = obj.date_time ?? ""
        return cell
    }
}
