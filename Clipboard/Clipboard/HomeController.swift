//
//  HomeController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/3/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var quickBoardView: UIView!
    
    @IBOutlet weak var toDoView: UIView!
    @IBOutlet weak var toDoCountLabel: UILabel!
    @IBOutlet weak var toDoTitleLabel: UILabel!
    
    @IBOutlet weak var inProgressView: UIView!
    @IBOutlet weak var inProgressCountLabel: UILabel!
    @IBOutlet weak var inProgressTitleLabel: UILabel!
    
    @IBOutlet weak var haltedView: UIView!
    @IBOutlet weak var haltedCountLabel: UILabel!
    @IBOutlet weak var haltedTitleLabel: UILabel!
    
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var doneCountLabel: UILabel!
    @IBOutlet weak var doneTitleLabel: UILabel!
    
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        toDoCountLabel.text = String(Constants.currProject.getTeam()?.getToDoTasks().count ?? 0)
        inProgressCountLabel.text = String(Constants.currProject.getTeam()?.getInProgressTasks().count ?? 0)
        haltedCountLabel.text = String(Constants.currProject.getTeam()?.getHaltedTasks().count ?? 0)
        doneCountLabel.text = String(Constants.currProject.getTeam()?.getDoneTasks().count ?? 0)
        
        quickBoardView.createStatusComponent()
        
        toDoCountLabel.textColor = UIColor.purple
        inProgressCountLabel.textColor = UIColor.purple
        haltedCountLabel.textColor = UIColor.purple
        doneCountLabel.textColor = UIColor.purple

        toDoTitleLabel.textColor = UIColor.white
        inProgressTitleLabel.textColor = UIColor.white
        haltedTitleLabel.textColor = UIColor.white
        doneTitleLabel.textColor = UIColor.white

        toDoTitleLabel.backgroundColor = UIColor.purple
        inProgressTitleLabel.backgroundColor = UIColor.purple
        haltedTitleLabel.backgroundColor = UIColor.purple
        doneTitleLabel.backgroundColor = UIColor.purple

        let toDoTap = UITapGestureRecognizer(target: self, action: #selector(handleToDoTapped))
        toDoView.addGestureRecognizer(toDoTap)
        let inProgressTap = UITapGestureRecognizer(target: self, action: #selector(handleInProgressTapped))
        inProgressView.addGestureRecognizer(inProgressTap)
        let haltedTap = UITapGestureRecognizer(target: self, action: #selector(handleHaltedTapped))
        haltedView.addGestureRecognizer(haltedTap)
        let doneTap = UITapGestureRecognizer(target: self, action: #selector(handleDoneTapped))
        doneView.addGestureRecognizer(doneTap)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fake data
        for n in 0...8{
            let rand1 = Int.random(in: 0..<2)
            let rand2 = Int.random(in: 0..<getIcons()!.count-1)
            guard let teamTitle = Constants.currProject.getTeam()?.getTitle() else { return }
            let member = Member(name: "Member "+String(n), role: Constants.roles[rand1], team: teamTitle)
            guard let image = UIImage(named: (h+mid[rand2]+t)) else {return}
            member.setIcon(icon: image)
            Constants.currProject.getTeam()?.addMember(member: member)
        }
        
        for n in 0...20{
            let rand1 = Int.random(in: 0..<4)
            let rand2 = Int.random(in: 0..<4)
            let rand3 = Int.random(in: 0..<4)
            let task = Task(title: "Task "+String(n)+" Test", status: Constants.statuses[rand1], difficulty: Constants.difficulties[rand1])
            task.setDescription(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            if(rand2 != 0){
                guard let members = Constants.currProject.getTeam()?.getMembers() else {return}
                let randMem = Int.random(in: 0..<members.count)
                task.setAssignedTo(member: members[randMem])
            }
            if(rand3 == 0){
                task.setDueDate(date: Date())
            }
            Constants.currProject.getTeam()?.addTask(task: task)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        navigationItem.title = "Welcome, "+Constants.currMember.getName()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.purple
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.white

        addButton.createFloatingAddButton()
        
        toDoView.createStatusComponent()
        inProgressView.createStatusComponent()
        haltedView.createStatusComponent()
        doneView.createStatusComponent()
        
        
    }
    
    @objc func handleToDoTapped(gesture: UITapGestureRecognizer) -> Void {
        print("caught tap gesture")
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CompleteTaskListController")
        self.navigationController?.pushViewController(vc, animated: true)
        CompleteTaskListController.type = Constants.statuses[0]
    }
    
    @objc func handleInProgressTapped(gesture: UITapGestureRecognizer) -> Void {
        print("caught tap gesture")
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CompleteTaskListController")
        self.navigationController?.pushViewController(vc, animated: true)
        CompleteTaskListController.type = Constants.statuses[1]
    }
    
    @objc func handleHaltedTapped(gesture: UITapGestureRecognizer) -> Void {
        print("caught tap gesture")
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CompleteTaskListController")
        self.navigationController?.pushViewController(vc, animated: true)
        CompleteTaskListController.type = Constants.statuses[2]
    }
    
    @objc func handleDoneTapped(gesture: UITapGestureRecognizer) -> Void {
        print("caught tap gesture")
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CompleteTaskListController")
        self.navigationController?.pushViewController(vc, animated: true)
        CompleteTaskListController.type = Constants.statuses[3]
    }
    
    @IBAction func manageBarButtonTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ManageProjectController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func taskListButtonTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TaskListController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func analyticsBarButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Apologies", message: "The Analytics Page is an upcoming feature!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func addTaskTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateTaskController")
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }

    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }

}
