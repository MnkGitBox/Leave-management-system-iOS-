//
//  HomeViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-06.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController{
    
    var authHandler: FIRAuthStateDidChangeListenerHandle?
    
    let connectingView = UIView()
    
    
    var viewSize:CGSize{
        return view.frame.size
    }
    
    var isFistAppear:Bool = true
    
    var navBarheight:CGFloat{
        return navigationController?.navigationBar.frame.size.height ?? 0
    }
    
    var selectedHotInfo = HotInfo(){
        didSet{
            runTimer()
        }
    }
    var updateTimer:Timer?
    var hotLeaveMoreDetailTap = UITapGestureRecognizer()
    
    
    //MARK: - Outlet for dashboard
    
    //    @IBOutlet weak var hotLeaveTimeContainerTralingConstrain: NSLayoutConstraint!
    //    @IBOutlet weak var hotLeaveNameContainerLeadingConstrain: NSLayoutConstraint!
    //    @IBOutlet weak var hotLeaveNameContainer: UIVisualEffectView!
    //    @IBOutlet weak var hotLeaveTimeContainer: UIVisualEffectView!
    
    //view, contain the all details
    @IBOutlet weak var detailContainerView: UIView!
    
    @IBOutlet weak var moreDetailLabel: UILabel!
    
    
    
    //leave Type
    //    @IBOutlet weak var leaveTypeIco: UIImageView!
    @IBOutlet weak var leaveTypeName: UILabel!
    
    //leave detail
    @IBOutlet weak var headLabelName: UILabel!
    @IBOutlet weak var headLabelValue: UILabel!
    
    @IBOutlet weak var middleLabelName: UILabel!
    @IBOutlet weak var middleLabelValue: UILabel!
    
    @IBOutlet weak var lastLabelName: UILabel!
    @IBOutlet weak var lastLabelValue: UILabel!
    
    @IBOutlet weak var actionState: UILabel!
    @IBOutlet weak var timeState: UILabel!
    
    
    
    //main background img defend on hotLeave currentState
    @IBOutlet weak var mainBackgroundImg: UIImageView!
    
    //sub container
    @IBOutlet weak var subContainer: UIView!
    //    @IBOutlet weak var subContainerTopLayout: NSLayoutConstraint!
    //table view background view with blur effect
    @IBOutlet weak var subContainerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var subcontainerHeightConstraint: NSLayoutConstraint!
    
    
    var notificationTabBarItem:UITabBarItem?
    var newNotifications:Int = 0{
        didSet{
            
            if newNotifications == 0{
                
                notificationTabBarItem?.badgeValue = nil
            }else{
                
                notificationTabBarItem?.badgeValue = "\(newNotifications)"
                
            }
            
        }
    }
    
    
    
    //MARK: - Outlet for LeaveTV Data
    
    var info:[InfoOb] = []
    var infoObTemp:[InfoOb] = []
    
    var leaveTypeFetchResultController:NSFetchedResultsController<LeaveType>?
    
    var timer:Timer?
    
    var container:NSPersistentContainer? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    @IBOutlet weak var leavesDetailTV: UITableView!
    
    var tvSwiptDownAniStartMargin:CGFloat{
        return -(view.frame.size.height / 6)
    }
    
    //    let bluerEffect = UIBlurEffect(style: .light)
    //MARK: - CustomSearch Cotroller
    var customSearchController:CustomSearchController!
    var isSearChBegan:Bool = false
    var searchString:String = ""
    var isSearchBarHidden:Bool{
        return (subContainer.frame.origin.y < 0) ? true : false
    }
    let searchButton = CustomButton()
    let signOutButton = CustomButton()
    let sortBtn = CustomButton()
    
    var isSwipUp = false
    lazy var swipUpGesture:UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer()
        gesture.maximumNumberOfTouches = 1
        gesture.addTarget(self, action: #selector(performPanOperation(_:)))
        return gesture
    }()
    
    var subContainerTopConstant:CGFloat{
        get{
            return detailContainerView.frame.size.height - (subContainer.frame.size.height / 2)
        }
        set{
            subContainerTopConstraint.constant = newValue
            view.layoutIfNeeded()
        }
    }
    
    var searchBarBGHeight:CGFloat = 40
    
    var currUsr:User?{
        didSet{
            usrDetailCollectionView.reloadData()
            signOutButton.imageView.image(from: currUsr?.imgUrl)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addConnectingView()
        
        checkUserState()
        
        getUserData()
        
        getLeaveData()
        
        subContainer.backgroundColor = CustomColor.darkGreen
        
        leavesDetailTV.addGestureRecognizer(swipUpGesture)
        leavesDetailTV.tableFooterView = UIView()
        leavesDetailTV.backgroundColor = CustomColor.tableBackground
        leavesDetailTV.separatorColor = CustomColor.seperatorColor
        leavesDetailTV.register(LeavesDetailTVCell.self, forCellReuseIdentifier: CellID.leaveDetailTVCell)
        
        setupNavigationBarLocalSetting()
        
        configureTabBarBatch()
        
        configureUserDetailCollectionVIew()
        
        fetchDataAndUpdateUI()
        
        setNotificationBadgeValue()
        
        configCustomSearchBar()
        
        findHotLeave()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leavesDetailTV.estimatedRowHeight = 65
        leavesDetailTV.rowHeight = UITableViewAutomaticDimension
        
        
        guard isFistAppear else{
            checkUserState()
            return
        }
        translateTableViewCellToDefaultPosition()
        animateTableViewCellComesUp()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !isSwipUp else{return}
        searchButton.isEnabled = false
        sortBtn.isEnabled = false
        tabBarController?.makeVisible(true, isAnimated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard isFistAppear else{return}
        subContainerTopConstraint.constant = subContainerTopConstant
        view.layoutIfNeeded()
        isFistAppear = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FIRAuth.auth()?.removeStateDidChangeListener(authHandler!)
    }
    
    fileprivate func addConnectingView(){
        let label:UILabel = {
            let label = UILabel()
            label.text = "Connecting"
            label.textColor = CustomColor.whiteCream
            label.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightSemibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        
        window?.addSubview(connectingView)
        connectingView.frame = UIScreen.main.bounds
        connectingView.backgroundColor = CustomColor.turqueGreen
        connectingView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: connectingView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: connectingView.centerYAnchor).isActive = true
        
    }
    
    
    fileprivate func configCustomSearchBar() {
        let searchBarFrame = CGRect(x: 4, y: -1, width: subContainer.frame.size.width - 8, height: searchBarBGHeight + 2)
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: searchBarFrame, font: UIFont.systemFont(ofSize: 14, weight:UIFontWeightMedium), textColor: CustomColor.darkAsh, tintColor: CustomColor.darkGreen)
        customSearchController.customSearchBar.tintColor = CustomColor.darkAsh
        
        customSearchController.customSearchBar.layer.cornerRadius = 10
        customSearchController.customSearchBar.clipsToBounds = true
        customSearchController.customDeligate = self
        
    }
    
    fileprivate func setupNavigationBarLocalSetting(){
        
        title = "Home"
        
        searchButton.setImageButton(of: #imageLiteral(resourceName: "search_ico"), in: CGSize(width:18, height:18), shapeUsingButtonRadius: 0)
        searchButton.addTarget(target: self, action: #selector(searchIcoTap))
        searchButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        searchButton.isShowShadow = false
        searchButton.isEnabled = false
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        
        
        signOutButton.setImageButton(of: #imageLiteral(resourceName: "Profile_img"), in: CGSize(width:25, height:25), shapeUsingButtonRadius: 12.5)
        signOutButton.addTarget(target: self, action: #selector(performUserDetailsShowHide))
        signOutButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        signOutButton.isShowShadow = false
        let signOutBarButton = UIBarButtonItem(customView: signOutButton)
        
        navigationItem.rightBarButtonItems = [signOutBarButton,searchBarButton]
        
        sortBtn.addTarget(target: self, action: #selector(showSortMenu))
        sortBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        sortBtn.setImageButton(of: #imageLiteral(resourceName: "sort_ico"), in: CGSize(width:18, height:18), shapeUsingButtonRadius: 0)
        sortBtn.isShowShadow = false
        sortBtn.isEnabled = false
        let sortBarBtn = UIBarButtonItem(customView: sortBtn)
        
        navigationItem.leftBarButtonItem = sortBarBtn
        
    }
    
    @objc func showSortMenu(){
        print("sort menu")
    }
    
    fileprivate func configureTabBarBatch(){
        
        guard let tabBarItems = self.tabBarController?.tabBar.items else{return}
        let itemArray = tabBarItems as NSArray
        
        notificationTabBarItem = itemArray[1] as? UITabBarItem
        notificationTabBarItem?.badgeColor = UIColor.appleNews(alpha: 1)
        
    }
    
    fileprivate func configureUserDetailCollectionVIew(){
        
        let mainBounds  = UIScreen.main.bounds
        let mainWindow = UIApplication.shared.delegate?.window
        let cvOrigin = CGPoint(x: 0, y: mainBounds.height)
        let cvSize = CGSize(width: mainBounds.size.width, height: mainBounds.size.height / 3)
        usrDetailCollectionView.frame = CGRect(origin: cvOrigin, size: cvSize)
        usrDetailCollectionView.register(UserDetailCell.self, forCellWithReuseIdentifier: CellID.userDetailsCell)
        
        let blackkviewTapGesture = UITapGestureRecognizer(target: self, action:#selector(performUserDetailsShowHide))
        blackkviewTapGesture.numberOfTapsRequired = 1
        blackView.frame = mainBounds
        blackView.backgroundColor = .black
        blackView.alpha = 0
        blackView.addGestureRecognizer(blackkviewTapGesture)
        
        mainWindow??.addSubview(blackView)
        mainWindow??.addSubview(usrDetailCollectionView)
    }
    
    
    //MARK: - SearchBar Show and Hide
    
    @objc func searchIcoTap(){
        
        if isSearchBarHidden{
            UIView.animate(withDuration: 0.2, animations: {
                self.subContainerTopConstant = 0
                self.view.layoutIfNeeded()
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                self.subContainerTopConstant = -self.subContainer.frame.size.height
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    
    //MARK: - TableView Show and Hidden Animation
    var distanceSubcontainerTopToTochPoint:CGFloat!
    var currTouchPoint:CGFloat!
    
    @objc func performPanOperation(_ sender:UIPanGestureRecognizer){
        
        switch sender.state {
        case .began:
            distanceSubcontainerTopToTochPoint = sender.location(in: self.view).y - subContainerTopConstant
        case .changed:
            currTouchPoint = sender.location(in: self.view).y - distanceSubcontainerTopToTochPoint
            subContainerTopConstant = currTouchPoint
            
            detailContainerView.alpha = currTouchPoint / subContainerTopConstant
            
        case .ended:
            
            if ((detailContainerView.frame.size.height / 4) * 3) > currTouchPoint{
                doTableViewSwiptUpAnimation()
            }else{
                doTableViewSwiptDownAnimation()
            }
        default:break
        }
        
    }
    
    fileprivate func doTableViewSwiptDownAnimation() {
        
        customSearchController.customSearchBar.removeFromSuperview()
        
        customSearchController.customSearchBar.removeFromSuperview()
        
        tabBarController?.makeVisible(true, isAnimated: true)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            self.subContainerTopConstraint.constant = self.subContainerTopConstant
            self.detailContainerView.alpha = 1
            self.subContainer.alpha = 1
            self.moreDetailLabel.alpha = 1
            self.subcontainerHeightConstraint.constant = 30
            self.view.layoutIfNeeded()
            
        }, completion: { (completed) in
            self.searchButton.isEnabled = false
            self.sortBtn.isEnabled = false
            self.title = "Home"
            self.swipUpGesture.isEnabled = true
            self.isSwipUp = false
        })
        
    }
    
    var subContainerTopAnimationHeight:CGFloat{
        
        var navbarHeight:CGFloat = 0
        
        if let navContr = navigationController{
            navbarHeight = navContr.navigationBar.frame.size.height
        }
        
        return viewSize.height - navbarHeight - 5
    }
    
    fileprivate func doTableViewSwiptUpAnimation(){
        
        tabBarController?.makeVisible(false, isAnimated: true)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.subContainerTopConstant = -self.searchBarBGHeight
            self.detailContainerView.alpha = 0
            self.subContainer.alpha = 0.8
            self.moreDetailLabel.alpha = 0
            self.view.layoutIfNeeded()
        }) { (completed) in
            self.subcontainerHeightConstraint.constant = self.searchBarBGHeight
            self.subContainer.addSubview(self.customSearchController.customSearchBar)
            self.searchButton.isEnabled = true
            self.sortBtn.isEnabled = true
            self.title = "Overview"
            
            self.swipUpGesture.isEnabled = false
            self.isSwipUp = true
        }
        
    }
    //MARK: - TableView Cell Comes Up Animation
    fileprivate func translateTableViewCellToDefaultPosition() {
        let visibleCells = leavesDetailTV.visibleCells
        let tableViewHeight = leavesDetailTV.frame.size.height
        
        for cell in visibleCells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
    }
    
    fileprivate func animateTableViewCellComesUp(){
        
        let visibleCell = leavesDetailTV.visibleCells
        var delayConuter:TimeInterval = 0
        for cell in visibleCell{
            
            UIView.animate(withDuration: 1.75, delay: delayConuter * 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            
            delayConuter += 1
        }
    }
    
    
    @IBAction func detailContainerTap(_ sender: UITapGestureRecognizer) {
        
        //        guard let tabBarCtr = tabBarController else{return}
        
        //        if tabBarCtr.isVisible(){
        //            tabBarCtr.makeVisible(false, isAnimated: true)
        //        }else{
        //            tabBarCtr.makeVisible(true, isAnimated: true)
        //        }
        //
        //        subContainerTopConstraint.constant = subContainerTopConstant
        //        print(view.frame, detailContainerView.frame, subContainer.frame, subContainerTopConstant)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        let scrollY = scrollView.contentOffset.y
        guard scrollY > tvSwiptDownAniStartMargin else{
            doTableViewSwiptDownAnimation()
            return
        }
        
    }
    //MARK:- GET USER DATA
    fileprivate func getLeaveData(){
        self.fetchLeaves { (completed) in
            if !self.connectingView.isHidden{
                self.connectingView.isHidden = true
            }
            UserDefaults.standard.set(false, forKey: NSUserDefaultKey().isFreshCome)
            self.getDataFromFireBase()
        }
    }
    
    fileprivate func getUserData(){
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            SigninOutRequest.getCurrentAuthUsrDetails(using:uid , userInfo: { (user) in
                self.currUsr = user
            })
        }
    }
    
    //MARK:- CHECK USER STATE AND PERFORM SIGNOUT
    fileprivate func checkUserState(){
        authHandler = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user == nil{
                self.clearLocalData()
                UserDefaults.standard.removeObject(forKey: NSUserDefaultKey().isFreshCome)
                self.perform(#selector(self.showSignInPage), with: nil, afterDelay: 2)
            }
        })
    }
    
    @objc func signOut(){
        let signoutResult =  SigninOutRequest.signout()
        guard !signoutResult.isSignout else {
            performUserDetailsShowHide()
            return
        }
        let alertView = CustomAlert()
        alertView.pop(with: "Some thing went wrong.", "Signout error", "try again", #imageLiteral(resourceName: "signout_error"))
    }
    
    var isHiddenUsrDetails:Bool = true
    lazy var usrDetailCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    let blackView = UIView()
    
    @objc func performUserDetailsShowHide(){
        
        let mainBounds = UIScreen.main.bounds
        let displayOrigin = CGPoint(x: 0, y: mainBounds.size.height -  usrDetailCollectionView.frame.size.height)
        let hideOrigin = CGPoint(x: 0, y:mainBounds.size.height )
        
        guard isHiddenUsrDetails else {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
                
                self.usrDetailCollectionView.frame.origin = hideOrigin
                self.blackView.alpha = 0
                
            }){(completed) in
                self.isHiddenUsrDetails = true
            }
            return
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0.5
            self.usrDetailCollectionView.frame.origin = displayOrigin
            
        }){(completed) in
            self.isHiddenUsrDetails = false
        }
        
    }
    
    
    
    @objc func showSignInPage(){
        
        guard let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardID.loginViewControllerID) else {
            return
        }
        
        self.present(loginViewController, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Fetch leave types from firebase database
    func fetchLeaves(completion:@escaping (Bool)->Void){
        
        guard UserDefaults.standard.bool(forKey: NSUserDefaultKey().isFreshCome)else{
            completion(true)
            return
        }
        
        FireRequestLeave.requestLeave { [weak self]leaves in
            
            self?.updateOnce(of: Array(leaves))
            completion(true)
        }
        
    }
    
    //MARK: - Set Notification badge Value
    
    func setNotificationBadgeValue(){
        
        newNotifications =  CoreInfoRequest.getInfoIsNotChecked()
        
    }
    
    
    
    //MARK: - Perform Segue
    
    func segueToLeaveInfo(using leaveInfoObs:[String : [InfoOb]],andLeaveType leaveType:LeaveTypeInfo){
        let InfoArray = Array(leaveInfoObs)
        
        guard let singleLeaveDetailsViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.singleLeaveDetailsViewControllerID) as? SingleLeaveDetailsViewController else{return}
        
        singleLeaveDetailsViewController.infoObs = InfoArray
        singleLeaveDetailsViewController.leaveType = leaveType
        navigationController?.pushViewController(singleLeaveDetailsViewController, animated: true)
        
        
    }
    
    @objc func showHotLeaveMoreDetails(){
        
        
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardID.sLDFTableViewController) as? SingleLeaveMoreDetailFormTableViewController else{return}
        guard let detailDic = selectedHotInfo.currHot?.infoOb.subInfoWithCellType()else{return}
        
        viewController.moreDetails = Array(detailDic)
        viewController.leavetypeName = selectedHotInfo.currHot?.typeName ?? ""
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension HomeViewController:CustomSearchControllerDeligate{
    func didStartSearching() {
        isSearChBegan = true
        fetchDataAndUpdateUI()
    }
    
    func didtapOnSearchButton() {
        if !isSearChBegan{
            isSearChBegan = true
            fetchDataAndUpdateUI()
        }
    }
    
    func didTapOnCancelButton() {
        isSearChBegan = false
        fetchDataAndUpdateUI()
    }
    
    func didChangeSearchText(searchtext: String) {
        searchString = searchtext
        fetchDataAndUpdateUI()
    }
    
    
}

struct NSUserDefaultKey{
    let isFreshCome = "isFreshCome"
}


extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height:CGFloat = (UIScreen.main.bounds.size.height / 3) / 5
        
        if indexPath.item == 3{
            return CGSize(width: self.view.frame.size.width, height: height * 2)
        }
        
        return CGSize(width: self.view.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 3{
            signOut()
        }
    }
}
extension HomeViewController:UICollectionViewDataSource{
    @available(iOS 6.0, *)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.userDetailsCell, for: indexPath) as! UserDetailCell
        switch indexPath.item {
        case 0:
            cell.imageview.image = #imageLiteral(resourceName: "user_name_ico")
            cell.info.text = currUsr?.name?.capitalized
        case 1:
            cell.imageview.image = #imageLiteral(resourceName: "job_title_ico")
            cell.info.text = currUsr?.jobTitle?.capitalized
        case 2:
            cell.imageview.image = #imageLiteral(resourceName: "department_ico")
            cell.info.text = currUsr?.defartment?.capitalized
        case 3:
            cell.imageview.image = #imageLiteral(resourceName: "signout_ico")
            cell.info.text = "Signout"
        default:break
        }
        
        return cell
    }
    
}


class UserDetailCell: UICollectionViewCell {
    
    let info:UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.textColor = UserColor(withHexValue: "#60646D")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let imageview:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "default_ico")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageview)
        imageview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 22).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(info)
        info.leftAnchor.constraint(equalTo: imageview.rightAnchor, constant: 24).isActive = true
        info.centerYAnchor.constraint(equalTo: imageview.centerYAnchor).isActive = true
        info.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
