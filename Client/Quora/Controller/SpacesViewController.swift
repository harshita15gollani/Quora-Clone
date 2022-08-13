//
//  SpacesViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 06/08/22.
//

import UIKit

class SpacesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,MyAnswerManagerDelegate {
    
    
    
    @IBOutlet weak var questionCollectionView: UICollectionView!
    var answerData: [AnswerModel]? = []
    
    var caller: MyAnswerManager?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answerData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionIdentifier",for: indexPath) as? QuestionCollectionViewCell else {
            print("Failed to create custom cell")
            return UICollectionViewCell()
        }
        cell.question.text = answerData?[indexPath.row].description
        cell.viewAllAnswer = { [weak self] in
            if let continueViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AnswerDescriptionViewController") as? AnswerDescriptionViewController {
                continueViewController.answers = self?.answerData?[indexPath.row].answersList
                continueViewController.questionData = self?.answerData?[indexPath.row].description
                continueViewController.myAnswer = self?.answerData?[indexPath.row].questionId
                self?.navigationController?.pushViewController(continueViewController, animated: true)
            }
//            self?.performSegue(withIdentifier:"allAnswerIdentifier", sender: nil)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:370, height: 100.0)
    }
    func registerCustomViewInCell(){
        let nib = UINib(nibName: "QuestionCollectionViewCell", bundle: nil)
        questionCollectionView.register(nib , forCellWithReuseIdentifier: "QuestionIdentifier")
    }
    func updateData(answerDetail: [AnswerModel]) {
        self.answerData = answerDetail
        DispatchQueue.main.async {
            self.questionCollectionView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        caller?.fetchProductList(searchItem: "")
    }
    override func viewWillAppear(_ animated: Bool) {
        caller?.fetchProductList(searchItem: "")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomViewInCell()
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        caller = MyAnswerManager()
        caller?.delegate = self
        caller?.fetchProductList(searchItem: "")
        // Do any additional setup after loading the view.
    }
    

    

}
