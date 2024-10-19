//
//  HomeVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class HomeVC: UIViewController {
    
    @IBOutlet weak var collection_Service: UICollectionView!
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var service_TblVw: UITableView!
    
    @IBOutlet weak var lbl_Service: UILabel!
    @IBOutlet weak var page_Controller: UIPageControl!
    
    var arr_BannerList: [Res_BannerList] = []
    var arr_ServiceCategory: [Res_ServiceCategory] = []
    
    var count:Int = 0
    var currentIndex:Int = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection_Service.register(UINib(nibName: "CleaningServiceCell", bundle: nil), forCellWithReuseIdentifier: "CleaningServiceCell")
        self.service_TblVw.register(UINib(nibName: "ServiceCategoryCell", bundle: nil), forCellReuseIdentifier: "ServiceCategoryCell")
        self.changeStaticLangauge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        self.profile_Details()
        self.banner_List()
        self.service_Category()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_Service.text = "Service"
        } else {
            self.lbl_Service.text = "الخدمة"
        }
    }
    
    func loadTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(scrollSlider), userInfo: nil, repeats: true)
    }
    
    @objc func scrollSlider() {
        count += 1
        if count == 3 {
            count = 0
            currentIndex += 1
            if currentIndex >= arr_BannerList.count {
                currentIndex = 0
                collection_Service.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: true)
                self.collection_Service.isPagingEnabled = true
            } else {
                collection_Service.scrollToNextItem()
            }
            page_Controller.currentPage = currentIndex
        }
    }
    
    @IBAction func btn_ServicePerHour(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServiceDetailVC") as! ServiceDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_MultiVisit(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServiceDetailVC") as! ServiceDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_GatherService(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServiceDetailVC") as! ServiceDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_WhatsAppCall(_ sender: UIButton) {
        let adminNum = "966559003760"
        
        if let url = URL(string: "https://wa.me/\(adminNum)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("No Whats can be there!!")
        }
    }
}

extension HomeVC {
    
    func profile_Details()
    {
        Api.shared.user_Profile(self) { responseData in
            let obj = responseData
            self.lbl_Name.text = obj.first_name ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", self.img_Profile)
            } else {
                self.img_Profile.image = R.image.profile_ic()
            }
        }
    }
}

extension HomeVC {
    
    func banner_List()
    {
        Api.shared.banner_List(self) { responseData in
            if responseData.count > 0 {
                self.arr_BannerList = responseData
            } else {
                self.arr_BannerList = []
            }
            self.collection_Service.reloadData()
            self.page_Controller.numberOfPages = self.arr_BannerList.count
            self.page_Controller.currentPage = 0  // Reset to the first page
            
            self.loadTimer()
        }
    }
}

extension HomeVC {
    
    func service_Category()
    {
        Api.shared.service_Category(self) { responseData in
            if responseData.count > 0 {
                self.arr_ServiceCategory = responseData
            } else {
                self.arr_ServiceCategory = []
            }
            self.service_TblVw.reloadData()
        }
    }
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_ServiceCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCategoryCell", for: indexPath) as! ServiceCategoryCell
        let obj = arr_ServiceCategory[indexPath.row]
        if LanguageManager.shared.currentLanguage == .en {
            cell.lbl_Category.text = obj.name ?? ""
        } else {
            cell.lbl_Category.text = obj.name_ar ?? ""
        }
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = kStoryboard.instantiateViewController(withIdentifier: "ServiceDetailVC") as! ServiceDetailVC
        vc.category_Id = self.arr_ServiceCategory[indexPath.row].id ?? ""
        vc.category_Name = self.arr_ServiceCategory[indexPath.row].name ?? ""
        vc.categoryNameAR = self.arr_ServiceCategory[indexPath.row].name_ar ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr_BannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CleaningServiceCell", for: indexPath) as! CleaningServiceCell
        let obj = self.arr_BannerList[indexPath.row]
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        } else {
            cell.img.image = R.image.placeholder()
        }
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
