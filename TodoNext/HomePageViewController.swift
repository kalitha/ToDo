//
//  HomePageViewController.swift
//  TodoNext
//
//  Created by Kalitha H N on 21/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HomePageVCProtocol {
    
    //creating UtilityClass object
    let mUtilityClassObj = Utility()
    //var mArrayOfGetDataModel = [GetDataModel]()
    @IBOutlet weak var mContentTableView: UITableView!
    @IBOutlet weak var mSlideMenu: UIView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mSlideMenuLeadingConstraint: NSLayoutConstraint!
    var mMenuShowing = false
    
    var mTableViewArray : [String] = ["Home","Logout"]
    var mCustomView = UIView()
    var mHomePageViewModelObj : HomePageViewModel?
    var mGetDataModel : GetDataModel?
    var mDescriptionViewController : Descriptionviewcontroller?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mTableView.separatorStyle = .none
        if let list = UserDefaults.standard.value(forKey: "listOfData") as? String{
        }
        else{
            //while installing the app for first time
            let list = ["list":[GetDataModel]()]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: list, options: .prettyPrinted)
            let storeString = String.init(data: jsonData, encoding: .utf8)
            
            UserDefaults.standard.set(storeString, forKey: "listOfData")
        }
        
       // mActivityIndicator.startAnimating()
        mHomePageViewModelObj = HomePageViewModel(pHomePageVCProtocolObj: self)
        
        if( ReachabilityStatus.isInternetAvailable()){
            var _ = mHomePageViewModelObj?.fetchDataFromController()
        }
        else{
        var _ = mHomePageViewModelObj?.offlineTasksDisplay()
        }
        
        let photoNib = UINib.init(nibName: "ProfilePic", bundle: nil)
        mTableView.register(photoNib, forCellReuseIdentifier: "profilecell")
        
        let nib = UINib.init(nibName: "TableViewCellCard", bundle: nil)
        mContentTableView.register(nib, forCellReuseIdentifier: "tableviewcellcard")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //add the gesture recognizer when the menu button is tapped
    func addGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.mCustomView.addGestureRecognizer(tapGesture)
    }
    
    //remove gesture recognizer after opening the slidemenu
    func removeGestureRecognizer(){
        for recognizer in mContentTableView.gestureRecognizers ?? [] {
            mCustomView.removeGestureRecognizer(recognizer)
        }
    }
    
    //called by addGestureRecognizer method
    func tapBlurButton(_ sender: UIButton) {
        self.navigationController?.navigationBar.layer.zPosition = 0
        mSlideMenuLeadingConstraint.constant = -270
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        //to remove custom view after removing slidemenu
        self.mCustomView.removeFromSuperview()
        mMenuShowing = !mMenuShowing
        
        //3rd case of removing  gesture when we click on contentview
        removeGestureRecognizer()
    }
    
    @IBAction func onClickOfMenuButton(_ sender: Any) {
        //self.navigationController?.navigationBar.layer.zPosition = -1
        if(mMenuShowing){
            mSlideMenuLeadingConstraint.constant = -270
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            //to remove custom view after removing slidemenu
            self.mCustomView.removeFromSuperview()
        }
        else{
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.gray
            mSlideMenuLeadingConstraint.constant = 0
            self.view.addSubview(mCustomView)
            mCustomView.alpha = 0.5
            addGestureRecognizer()
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        mMenuShowing = !mMenuShowing
    }
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == mTableView
        {
            return mTableViewArray.count+1
        }
        else{
            print("array count=-=--",(mHomePageViewModelObj?.mArrayOfGetDataModel.count)!)
           print("=-=-=-array content=-=-=-",(mHomePageViewModelObj?.mArrayOfGetDataModel)!)
            return (mHomePageViewModelObj?.mArrayOfGetDataModel.count)!
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        if tableView == mTableView
        {
            if(indexPath.row == 0){
                let cell1 = mTableView.dequeueReusableCell(withIdentifier: "profilecell", for: indexPath) as! ProfilePic
                cell1.clipsToBounds = true
                return cell1
            }
            else{
                let cell = mTableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
                print("index.path.row value",indexPath.row)
                cell.textLabel?.text = mTableViewArray[indexPath.row-1]
                cell.textLabel?.textColor = UIColor.white
                let color = UIColor.init(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
                cell.backgroundColor = color

                return cell
            }
        }
        else {
            let cell = mContentTableView.dequeueReusableCell(withIdentifier: "tableviewcellcard", for: indexPath) as! TableViewCellCard
            let timeStamp = mHomePageViewModelObj?.mArrayOfGetDataModel[indexPath.row].mCreatedTime 
            
            let retunedDate = mUtilityClassObj.date(date:timeStamp!)
            
        print("retunedDate=-=--",retunedDate)
            cell.mTitle.text = mHomePageViewModelObj?.mArrayOfGetDataModel[indexPath.row].mTitle
            cell.mCreatedTime.text = retunedDate
            cell.mDescription.text = mHomePageViewModelObj?.mArrayOfGetDataModel[indexPath.row].mDescription
            return cell
        }
    }
    
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(tableView == mTableView){
            if(indexPath.row == 0){
                return 230
            }else{
                return 50
            }
        }
        else{
            return 80
            
        }
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            self.mHomePageViewModelObj?.mArrayOfGetDataModel.remove(at: indexPath.row)
            self.mContentTableView.reloadData()
            mDescriptionViewController = Descriptionviewcontroller()
           // mDescriptionViewController?.savingInUserDefaults()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if(tableView == mContentTableView)
        {
            mGetDataModel = mHomePageViewModelObj?.mArrayOfGetDataModel[indexPath.row]
            self.performSegue(withIdentifier: "navigateToDescriptionviewcontroller", sender: nil)
            
        }else{
        if(indexPath.row == 2){
            let alert = UIAlertController(title: "Alert", message: "Would you like to logout?", preferredStyle: UIAlertControllerStyle.alert)
            // add the actions (buttons)
            let lContinueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
                UIAlertAction in
                GIDSignIn.sharedInstance().signOut()
                self.performSegue(withIdentifier: "segueFromLogoutCell", sender: nil)
            }
            
            let lCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            alert.addAction(lContinueAction)
            alert.addAction(lCancelAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
            }
        }
        self.navigationController?.navigationBar.layer.zPosition = 0
        mSlideMenuLeadingConstraint.constant = -270
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        
        //2nd case of removing the tap gesture(paper) when we click on table view
        self.mCustomView.removeFromSuperview()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?)
    {
        if segue.destination .isKind(of: Descriptionviewcontroller.self)
        {
            let viewController = segue.destination as! Descriptionviewcontroller
            viewController.mGetDataModel = mGetDataModel
            viewController.mHomePageVC = self
            
            print("title in the model",mGetDataModel?.mTitle)
            print("created time in model",mGetDataModel?.mCreatedTime)

        }
        
    }
    @IBAction func alertView(_ sender: UIBarButtonItem) {
       //mActivityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Title", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textfield) in
        }
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            let textToBewritten = alert.textFields![0] as UITextField
            //print(textToBewritten.text)
           
            let currentDate = Date().timeIntervalSince1970
            
          let convertedTime = String(currentDate)
          let newTitle = GetDataModel(pDescription: "", pUserId: "kalitha.gowda@gmail.com", pTitle: textToBewritten.text!, pCreatedTime: convertedTime)
           self.mHomePageViewModelObj?.mArrayOfGetDataModel.append(newTitle)
            self.mContentTableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableViewReload(){
        DispatchQueue.main.async
            {   //self.mActivityIndicator.isHidden = true
                //self.mActivityIndicator.stopAnimating()
                self.mContentTableView.reloadData()
        }
    }
    
    func makeRestCall(){
        mHomePageViewModelObj?.fetchData()
    }
    
    func addTaskOnOffline(){
     mHomePageViewModelObj?.offlineStoring()
    
    }
}
