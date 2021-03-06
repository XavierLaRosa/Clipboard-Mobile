//
//  AddMemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/3/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class AddMemberController: UIViewController {
    public static var state = String() // create, login
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var roleToggle: UISegmentedControl!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor.purple
        titleLabel.textColor = UIColor.white
        nameTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "Username")
    roleToggle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    roleToggle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        backButton.createStandardHollowButton(color: UIColor.white, backColor: UIColor.purple)
        nextButton.createStandardFullButton(color: UIColor.white, fontColor: UIColor.purple)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddMemberController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }


    @IBAction func backTapped(_ sender: Any) {
       
        if(AddMemberController.state == "login"){
            dismiss(animated: true, completion: nil)
        } else if (AddMemberController.state == "edit"){
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
            ChooseIconController.member = Constants.currMember
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        if(usernameTextField.hasText){
            guard let name = usernameTextField.text else {return}
            guard let role = roleToggle.titleForSegment(at: roleToggle.selectedSegmentIndex) else {return}
            guard let team = Constants.currProject.getTeam()?.getTitle() else {return}
            Constants.currProject.getTeam()?.addMember(member: Member(name: name, role: role, team: team))
            

            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseIconController")
            guard let count = Constants.currProject.getTeam()?.getMembers().count else {return}
            guard let member = Constants.currProject.getTeam()?.getMembers()[count-1] else {return}
            ChooseIconController.member = member
            if(AddMemberController.state == "login"){
                ChooseIconController.state = "login"
            }
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }
}
