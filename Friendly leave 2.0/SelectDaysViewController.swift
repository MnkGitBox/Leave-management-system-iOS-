//
//  SelectDaysViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-26.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import JTAppleCalendar

class SelectDaysViewController: UIViewController {
    
    var selectedInfo:[String:Any] = [:]
    
    var leaveTypeInfoOb:LeaveTypeInfo{
        
        return selectedInfo[dbAttributename.leaveType] as! LeaveTypeInfo
    }
    
    var leaveBeginDate:Date?
    var workReturnDate:Date?
    
    var calenderStartDate:Date{
        
        return Date().startDayOf(timePeriod: .month)
    }
    var calenderEndDate:Date{
        
        return endDateAcordingToLeaveTypeTimePeriod()
        
    }
    
    var viewSize:CGSize!
    let leftRightMargine:CGFloat = 24
    var topBackgroundHeight:CGFloat{
        return viewSize.height / 6
    }
    var navBarHeight:CGFloat{
        return (navigationController?.navigationBar.frame.height)! + 20
    }
    var calenderCVHeight:CGFloat{
        return (viewSize.height / 2) - navBarHeight
    }
    
    var selectedWeekDays:[Date] = []
    
    var monthYearDic:[String:IndexPath] = [:]
    
    var months:[String]{
        let dateFormatter = DateFormatter()
        let calender = Calendar.current
        var returnArray:[String] = []
        
        dateFormatter.calendar = calender
        dateFormatter.dateFormat = "MMMM yyyy"
        
        guard var start = calender.date(byAdding: .month, value: -1, to: calenderStartDate)else{
            return returnArray
        }
        guard let end = calender.date(byAdding: .month, value: 1, to: calenderEndDate)else{
            return returnArray
        }
        
        var item = 0
        
        while start <= end {
            
            let day = dateFormatter.string(from: start)
            returnArray.append(day)
            monthYearDic[day] = IndexPath(item: item, section: 0)
            
            start = calender.date(byAdding: .month, value: 1, to: start)!
            item += 1
        }
        return returnArray
    }
    
    var oldIndexPath:IndexPath = IndexPath(item: 1, section: 0)
    
    lazy var calenderCV:JTAppleCalendarView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = JTAppleCalendarView(frame: .zero, collectionViewLayout: layout)
        cv.calendarDataSource = self
        cv.calendarDelegate  = self
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    let monthYear:UILabel = {
        
        let label = UILabel()
        label.text = "Mont Year"
        label.textColor = CustomColor.whiteCream
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold)
        label.textAlignment = .center
        return label
        
    }()
    
    lazy var visibleMonthCV:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = false
        cv.allowsSelection = true
        cv.dataSource = self
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .clear
        return cv
    }()
    
    let sunDayLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Sun"
        label.textColor = CustomColor.whiteCream
        //        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        label.textAlignment = .center
        return label
        
    }()
    
    let monDayLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Mon"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        //        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        
        return label
        
    }()
    let tuesDayLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Tue"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        //        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        return label
        
    }()
    let wenDayLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Wen"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        //        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        return label
        
    }()
    let thuDayLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Thu"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        //        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
        
    }()
    let friDayLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Fri"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        //        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
        
    }()
    let satDayLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Sat"
        label.textColor = CustomColor.whiteCream
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        //        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
        
    }()
    
    let weekDaySV:UIStackView = {
        
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
        
    }()
    
    let topBackground:UIView = {
        
        let v = UIView()
        v.backgroundColor = CustomColor.darkGreen
        return v
    }()
    
    let seperator:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.whiteCream
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let beginDateLabel:UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = CustomColor.darkAsh
        label.text = "10 February"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let returnDateLabel:UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = CustomColor.darkAsh
        label.text = "13 February"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rangeBetweenBeginToReturn:UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.text = "00"
        label.textColor = CustomColor.ash
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let clearButton:CustomButton = {
        
        let btt = CustomButton()
        btt.backgroundColor = CustomColor.calenderRed
        btt.layer.cornerRadius = 3
        btt.titleLabel.textColor = .white
        btt.titleLabel.text = "Clear Calender"
        btt.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        btt.isShowShadow = false
        btt.translatesAutoresizingMaskIntoConstraints = false
        return btt
    }()
    
    
    
    let seperator2:UIView = {
        
        let v = UIView()
        v.backgroundColor = CustomColor.ash
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    let minusLabel:UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = CustomColor.darkAsh
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightSemibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return label
    }()
    
    let selectedDaysSV:UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 4
        return sv
    }()
    
    
    let selectedDaysWithWeekDaysSV:UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .fill
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 8
        return sv
    }()
    
    let selectedDaysWithButtonSV:UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let emptyLabel:UILabel = {
        let label = UILabel()
        label.text = "Select days you want to get leave.Look calender and select start date of leave and return day to office."
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium)
        label.textColor = CustomColor.ash
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label .translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomItemContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let customAlert = CustomAlert()
    
    let nextButton = CustomButton()
    
    //    @IBOutlet var alertContainer: UIView!
    //    @IBOutlet weak var alertButtonContainer: UIView!
    //    @IBOutlet weak var alertButtonLabel: UILabel!
    //    @IBOutlet weak var alertMessage: UILabel!
    //    @IBOutlet var alertBackgroundEffectView: UIVisualEffectView!
    //
    
    //
    //    lazy var alertButtonTapGesture:UITapGestureRecognizer = {
    //        let gesture = UITapGestureRecognizer()
    //        gesture.numberOfTapsRequired = 1
    //        gesture.addTarget(self, action: #selector(perFormAlertHidden(_:)))
    //        return gesture
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Days"
        
        configNavbarBtn()
        
        viewSize = view.frame.size
        
        view.backgroundColor = CustomColor.whiteCream
        
        calenderCV.register(CalenderDateCell.self, forCellWithReuseIdentifier: CellID.calenderDateCell)
        
        setSubViewsLayout()
        
        setupCalenderView()
        
        clearButton.addTarget(target: self, action: #selector(clearSelectedDaysInfo))
        clearButton.isEnabled = false
        
        self.visibleMonthCV.register(UINib(nibName: "VisibleCalenderMonthCell", bundle: nil), forCellWithReuseIdentifier: CellID.calenderMonth)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMonthYear(from: calenderStartDate)
    }
    
    
    fileprivate func setSubViewsLayout(){
        
        //MARK:- Layout Calender View
        view.addSubview(topBackground)
        topBackground.frame = CGRect(x: 0, y: 0, width: viewSize.width, height: topBackgroundHeight)
        
        topBackground.addSubview(visibleMonthCV)
        visibleMonthCV.frame = CGRect(x: -((viewSize.width / 2) / 2), y: ((topBackgroundHeight - 33) / 2) - 12, width: viewSize.width + (viewSize.width / 2), height: 24)
        
        weekDaySV.addArrangedSubview(monDayLabel)
        weekDaySV.addArrangedSubview(tuesDayLabel)
        weekDaySV.addArrangedSubview(wenDayLabel)
        weekDaySV.addArrangedSubview(thuDayLabel)
        weekDaySV.addArrangedSubview(friDayLabel)
        weekDaySV.addArrangedSubview(satDayLabel)
        weekDaySV.addArrangedSubview(sunDayLabel)
        
        topBackground.addSubview(weekDaySV)
        weekDaySV.bottomAnchor.constraint(equalTo: topBackground.bottomAnchor).isActive = true
        weekDaySV.leftAnchor.constraint(equalTo: topBackground.leftAnchor, constant: leftRightMargine / 2).isActive = true
        weekDaySV.rightAnchor.constraint(equalTo: topBackground.rightAnchor, constant: -(leftRightMargine / 2)).isActive = true
        weekDaySV.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        topBackground.addSubview(seperator)
        seperator.bottomAnchor.constraint(equalTo: weekDaySV.topAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperator.leftAnchor.constraint(equalTo: topBackground.leftAnchor).isActive = true
        seperator.rightAnchor.constraint(equalTo: topBackground.rightAnchor).isActive = true
        
        view.addSubview(calenderCV)
        calenderCV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calenderCV.topAnchor.constraint(equalTo: topBackground.bottomAnchor).isActive = true
        calenderCV.widthAnchor.constraint(equalToConstant: viewSize.width - leftRightMargine).isActive = true
        calenderCV.heightAnchor.constraint(equalToConstant: calenderCVHeight).isActive = true
        
        
        
        //MARK: - Layout Selected Begin Date,Return Date,Selected Dates Range Count and Clear Button
        
        view.addSubview(bottomItemContainer)
        bottomItemContainer.topAnchor.constraint(equalTo: calenderCV.bottomAnchor).isActive = true
        bottomItemContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomItemContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomItemContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        selectedDaysSV.addArrangedSubview(beginDateLabel)
        selectedDaysSV.addArrangedSubview(minusLabel)
        selectedDaysSV.addArrangedSubview(returnDateLabel)
        
        selectedDaysSV.heightAnchor.constraint(equalToConstant: 18).isActive = true
        rangeBetweenBeginToReturn.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        selectedDaysWithWeekDaysSV.addArrangedSubview(selectedDaysSV)
        selectedDaysWithWeekDaysSV.addArrangedSubview(rangeBetweenBeginToReturn)
        
        clearButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        selectedDaysWithButtonSV.addArrangedSubview(selectedDaysWithWeekDaysSV)
        selectedDaysWithButtonSV.addArrangedSubview(clearButton)
        
        bottomItemContainer.addSubview(selectedDaysWithButtonSV)
        selectedDaysWithButtonSV.topAnchor.constraint(equalTo: bottomItemContainer.topAnchor, constant: 32).isActive = true
        selectedDaysWithButtonSV.leftAnchor.constraint(equalTo: bottomItemContainer.leftAnchor, constant: 16).isActive = true
        selectedDaysWithButtonSV.rightAnchor.constraint(equalTo: bottomItemContainer.rightAnchor, constant: -16).isActive = true
        selectedDaysWithButtonSV.bottomAnchor.constraint(equalTo: bottomItemContainer.bottomAnchor, constant: -32).isActive = true
        
        bottomItemContainer.addSubview(emptyLabel)
        emptyLabel.topAnchor.constraint(equalTo: bottomItemContainer.topAnchor,  constant: 16).isActive = true
        emptyLabel.leftAnchor.constraint(equalTo: bottomItemContainer.leftAnchor,  constant: leftRightMargine).isActive = true
        emptyLabel.rightAnchor.constraint(equalTo: bottomItemContainer.rightAnchor,  constant: -leftRightMargine).isActive = true
        emptyLabel.bottomAnchor.constraint(equalTo: selectedDaysWithButtonSV.bottomAnchor, constant: -52).isActive = true
        
    }
    
    fileprivate func configNavbarBtn(){
        
        let icoSize = CGSize(width: 22, height: 22)
        nextButton.setImageButton(of: #imageLiteral(resourceName: "next_ico"), in: icoSize, shapeUsingButtonRadius: 0)
        nextButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        nextButton.addTarget(target: self, action: #selector(segueToNextPage))
        nextButton.isEnabled = false
        
        let barBtnItem = UIBarButtonItem(customView: nextButton)
        navigationItem.rightBarButtonItem = barBtnItem
        
    }
    
    
    fileprivate func setupCalenderView(){
        
        calenderCV.showsVerticalScrollIndicator = false
        calenderCV.showsHorizontalScrollIndicator = false
        calenderCV.isPagingEnabled = true
        calenderCV.scrollDirection = .horizontal
        calenderCV.minimumLineSpacing = 0
        calenderCV.minimumInteritemSpacing = 0
        calenderCV.allowsMultipleSelection = true
        
        
    }
    
    func handleIndicatorBackroundColor(of cell:JTAppleCell?, for state:CellState){
        
        guard let cell = cell as? CalenderDateCell else {return}
        
        if state.isSelected{
            
            guard workReturnDate != nil else{
                cell.selectedIndicator.isHidden = false
                return
            }
            guard leaveBeginDate != nil && workReturnDate != nil else{return}
            
            guard state.date != leaveBeginDate else{
                cell.specialStateCell(piority: .right)
                return
            }
            guard state.date != workReturnDate else{
                cell.specialStateCell(piority: .left)
                return
            }
            cell.unSpecialStateCell()
            
        }else{
            
            cell.selectedIndicator.isHidden = true
            cell.rangeIndicator.isHidden = true
        }
        
    }
    
    func handleTextColor(of cell:JTAppleCell?, for state:CellState){
        
        guard let cell =  cell as? CalenderDateCell else {return}
        
        guard !state.isSelected && cell.todayIndicator.isHidden else{
            cell.date.textColor = .white
            return
        }
        
        guard !state.isSelected && cell.selectedIndicator.isHidden else{
            cell.date.textColor = .white
            return
        }
        guard state.dateBelongsTo == .thisMonth else{
            cell.date.textColor = CustomColor.ash
            return
        }
        
        switch state.day {
        case .sunday:
            cell.date.textColor = CustomColor.calenderRed.withAlphaComponent(0.8)
        default:
            cell.date.textColor = CustomColor.darkAsh
        }
        
    }
    
    
    fileprivate func endDateAcordingToLeaveTypeTimePeriod()->Date{
        
        var returnDate = Date()
        
        switch leaveTypeInfoOb.period!{
            
        case LeaveTypePeriod.month:
            returnDate = calenderStartDate.endDateOf(timePeriod: .month)
        case LeaveTypePeriod.year:
            returnDate =  calenderStartDate.endDateOf(timePeriod: .year)
        case LeaveTypePeriod.allTime:
            returnDate = calenderStartDate.endDateOf(timePeriod: .allTime)
        default:returnDate = calenderStartDate.endDateOf(timePeriod: .allTime)
        }
        
        return returnDate
        
    }
    
    
    
    func selectRangeOfDates(of date:Date){
        
        guard let beginDate = leaveBeginDate else {
            leaveBeginDate = date
            setSelectedDateInfoLabelFrom(start: leaveBeginDate , and: workReturnDate)
            return
        }
        
        guard workReturnDate != nil else {
            
            workReturnDate = date
            
            guard let returnDate = workReturnDate  else {return}
            
            guard generateWeekDays(from: beginDate, to: workReturnDate) else{
                calenderCV.deselectDate(of: returnDate)
                workReturnDate = nil
                return
                
            }
            
            calenderCV.deselectAllDates()
            calenderCV.selectDates(selectedWeekDays)
            setSelectedDateInfoLabelFrom(start: beginDate, and: returnDate)
            return
        }
        
        
        //if it is selected day is in current selected array
        let isContain = selectedWeekDays.contains(date)
        
        guard !isContain else {return}
        
        //clear all details if selected date not current days
        clearSelectedDaysInfo()
        
        //set cell state date to first date
        leaveBeginDate = date
        
        //set selected day info to labels
        setSelectedDateInfoLabelFrom(start: leaveBeginDate, and: workReturnDate)
        
        
    }
    
    fileprivate func animateOffEmptyLabel(){
        UIView.animate(withDuration: 0.4) {
            self.emptyLabel.alpha = 0
        }
    }
    fileprivate func animateInEmptyLabel(){
        UIView.animate(withDuration: 0.4) {
            self.emptyLabel.alpha = 1
        }
    }
    
    func generateWeekDays(from start:Date?,to end:Date?)->Bool{
        
        guard let beginDate = start else {return false}
        guard let returnDate = end else {return false}
        
        let selectedDays = calenderCV.generateDateRange(from: beginDate, to: returnDate)
        
        for day in selectedDays{
            
            if day.isWeek(){
                
                selectedWeekDays.append(day)
                guard selectedWeekDays.count <= Int(leaveTypeInfoOb.remain) else{
                    customAlert.pop(with: "Only remain \(leaveTypeInfoOb.remain) day in \(leaveTypeInfoOb.name.lowercased()).", "empty days", "select again", #imageLiteral(resourceName: "empty_buket"))
                    selectedWeekDays.removeAll()
                    return false
                }
            }
            
        }
        return true
    }
    
    @objc func clearSelectedDaysInfo(){
        
        guard let begin = leaveBeginDate else {return}
        calenderCV.deselectDates(from: begin, to: workReturnDate, triggerSelectionDelegate: true)
        leaveBeginDate = nil
        workReturnDate = nil
        selectedWeekDays.removeAll()
        beginDateLabel.text = ""
        returnDateLabel.text = ""
        rangeBetweenBeginToReturn.text = ""
        
        nextButton.isEnabled = false
        clearButton.isEnabled = false
        animateInEmptyLabel()
        
    }
    
    
    func setSelectedDateInfoLabelFrom(start beginDate:Date?,and workReDate:Date?){
        
        guard let beginDate = beginDate?.toString(using: "dd MMMM")else{return}
        beginDateLabel.text = beginDate
        
        guard let returnDate = workReDate?.toString(using: "dd MMMM")else{return}
        
        //if first date select two time automatically get first date and last date are same, to prevent that clear all selected info
        guard returnDate != beginDate else {
            clearSelectedDaysInfo()
            return
            
        }
        //
        returnDateLabel.text = returnDate
        
        let weekDays = String(selectedWeekDays.count - 1) + " week day"
        
        rangeBetweenBeginToReturn.text = weekDays
        
        //set selected info values
        
        selectedInfo[dbAttributename.beginDate] = leaveBeginDate
        selectedInfo[dbAttributename.returnDate] = workReturnDate
        
        //set button and empty label behavior
        nextButton.isEnabled = true
        clearButton.isEnabled = true
        animateOffEmptyLabel()
        
    }
    
    func isValidateSelectedDay(using date:Date)->Bool{
        
        guard date.shortDate() != Date().shortDate() else{
            customAlert.pop(with: "You Can't Select Today.", "wrong selection", "select again", #imageLiteral(resourceName: "wrong_date_selection"))
            return false
        }
        
        guard date > Date() else {
            //            popNotificationAnd(showMessage: "You can't select past day to today")
            customAlert.pop(with: "You can't select past day to today.", "wrong selection", "select again", #imageLiteral(resourceName: "wrong_date_selection"))
            return false
        }
        
        if  (leaveBeginDate != nil) && (workReturnDate == nil){
            
            guard leaveBeginDate! < date else {
                //                popNotificationAnd(showMessage: "Please Select Future Date")
                customAlert.pop(with: "Please Select Future Date.", "wrong selection", "select again", #imageLiteral(resourceName: "wrong_date_selection"))
                return false
            }
            
            guard date.isWeek() else{
                //                popNotificationAnd(showMessage: "Please Select Week Day")
                customAlert.pop(with: "Please Select Week Day.", "wrong selection", "select again", #imageLiteral(resourceName: "wrong_date_selection"))
                return false
            }
            
        }
        
        guard date.isWeek() else{return false}
        
        return true
        
    }
    
    
    // MARK: - Navigation
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //        guard selectedInfo[dbAttributename.beginDate] != nil else{
    //            customAlert.pop(with: "Began date is empty. Please select once again", "empty day", "select again.", #imageLiteral(resourceName: "empty_date_selection"))
    //            return
    //        }
    //        guard selectedInfo[dbAttributename.returnDate] != nil else{
    //            customAlert.pop(with: "Work return day is empty. Please select once again.", "empty day", "select again", #imageLiteral(resourceName: "empty_date_selection"))
    //            return
    //        }
    //
    //        guard segue.identifier == SegueIdentifier.showFillReason else {fatalError()}
    //        guard let viewController = segue.destination as? ReasonViewController else{
    //            fatalError("SelectDaysViewController--prepareForSegue--destinationVC--downCastErr")
    //        }
    //
    //        viewController.selectedInfo = selectedInfo
    //
    //    }
    
    @objc func segueToNextPage(){
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.reasonPage) as? ReasonViewController else{
            customAlert.pop(with: "System error happend.Error code is VC_Null:REA_PAGE.Please connect with softwear provider.", "will concern", "Opps..!", #imageLiteral(resourceName: "system_error"))
            return
        }
        guard selectedInfo[dbAttributename.beginDate] != nil else{
            customAlert.pop(with: "Began date is empty. Please select once again", "empty day", "select again.", #imageLiteral(resourceName: "empty_date_selection"))
            return
        }
        guard selectedInfo[dbAttributename.returnDate] != nil else{
            customAlert.pop(with: "Work return day is empty. Please select once again.", "empty day", "select again", #imageLiteral(resourceName: "empty_date_selection"))
            return
        }
        
        destinationViewController.selectedInfo = selectedInfo
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
}

extension SelectDaysViewController:JTAppleCalendarViewDataSource{
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let parameter = ConfigurationParameters(startDate: calenderStartDate, endDate: calenderEndDate, numberOfRows: 7, calendar: Calendar.current, generateInDates: InDateCellGeneration.forAllMonths, generateOutDates: OutDateCellGeneration.tillEndOfRow, firstDayOfWeek: DaysOfWeek.monday, hasStrictBoundaries: true)
        
        return parameter
    }
    
}

extension SelectDaysViewController:JTAppleCalendarViewDelegate{
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CellID.calenderDateCell, for: indexPath) as! CalenderDateCell
        
        cell.todayIndicator.isHidden = true
        if cellState.date.shortDate() == Date().shortDate(){
            cell.todayIndicator.isHidden = false
            calendar.deselectDate(of: cellState.date)
        }
        
        cell.date.text = cellState.text
        
        handleIndicatorBackroundColor(of: cell, for: cellState)
        handleTextColor(of: cell, for: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        guard isValidateSelectedDay(using: cellState.date) else{
            calendar.deselectDate(of: cellState.date)
            return
        }
        
        selectRangeOfDates(of: cellState.date)
        
        handleIndicatorBackroundColor(of: cell, for: cellState)
        handleTextColor(of: cell, for: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleIndicatorBackroundColor(of: cell, for: cellState)
        handleTextColor(of: cell, for: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        let firstDateOfMonth = visibleDates.monthDates.first
        setupMonthYear(from: firstDateOfMonth?.date)
        
    }
    
}



enum TimePeriod {
    case year
    case month
    case allTime
}


extension JTAppleCalendarView{
    
    func deselectDate(of date:Date){
        
        self.deselectDates(from: date, to: date + 1, triggerSelectionDelegate: false)
        
    }
    
}

//extension SelectDaysViewController{
//
////MARK: - Pop up view animation Stuff..
//
//    func popNotificationAnd(showMessage message:String){
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
//        guard let window = appDelegate.window else{return}
//
//        alertBackgroundEffectView.frame = UIScreen.main.bounds
//        window.addSubview(alertBackgroundEffectView)
//        alertBackgroundEffectView.alpha = 0
//
//
//        alertContainer.translatesAutoresizingMaskIntoConstraints = false
//        alertContainer.layer.borderColor = CustomColor.whiteCream.cgColor
//        alertContainer.layer.borderWidth = 1
//
//        window.addSubview(alertContainer)
//        alertContainer.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
//        alertContainer.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
//        alertContainer.heightAnchor.constraint(equalToConstant: 157).isActive = true
//        alertContainer.widthAnchor.constraint(equalToConstant:241).isActive = true
//
//        alertContainer.alpha = 0
//        alertContainer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//        alertMessage.text = message
//
//        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
//
//            self.alertBackgroundEffectView.alpha = 1
//            self.alertContainer.alpha = 1
//            self.alertContainer.transform = CGAffineTransform.identity
//
//        }, completion: nil)
//
//    }
//
//    @objc func perFormAlertHidden(_ sender: UITapGestureRecognizer) {
//        alertButtonLabel.buttonAnimation()
//        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
//
//            self.alertBackgroundEffectView.alpha = 0
//            self.alertContainer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//            self.alertContainer.alpha = 0
//
//        }) { isCompleted in
//            self.alertContainer.removeFromSuperview()
//            self.alertBackgroundEffectView.removeFromSuperview()
//        }
//
//    }
//
//}

extension SelectDaysViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.calenderMonth, for: indexPath) as! VisibleCalenderMonthCell
        cell.monthAndYear.text = months[indexPath.item]
        return cell
        
    }
    
}
extension SelectDaysViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        return size
    }
}

extension SelectDaysViewController{
    
    
    //MARK: - Set the Calenderview Month Scroll Animation and Month Collection View Setting
    func setupMonthYear(from currentMonthDate:Date?){
        
        guard let date = currentMonthDate else {return}
        
        guard let text = date.toString(using: "MMMM yyyy")else{return}
        monthYear.text = text
        
        guard let currIndexPath = monthYearDic[text] else{return}
        
        if let cell = visibleMonthCV.cellForItem(at: currIndexPath) as? VisibleCalenderMonthCell{
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                
                cell.monthAndYear.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                cell.monthAndYear.alpha = 1
                
            }, completion: nil)
            
        }
        
        visibleMonthCV.scrollToItem(at: currIndexPath, at: .centeredHorizontally, animated: true)
        
        guard currIndexPath != oldIndexPath else{return}
        
        if let cell = visibleMonthCV.cellForItem(at: oldIndexPath) as? VisibleCalenderMonthCell{
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                
                cell.monthAndYear.transform = CGAffineTransform.identity
                cell.monthAndYear.alpha = 0.5
                
            }, completion: nil)
            
        }
        
        oldIndexPath = currIndexPath
        
    }
    
}



