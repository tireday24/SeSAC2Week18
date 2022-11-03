//
//  ViewController.swift
//  SeSAC2Week18
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit
import RxSwift

//Index out of range ..런타임 오류..

class ViewController: UIViewController { //프로필
    
    @IBOutlet weak var label: UILabel!
    
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phone = Phone()
        print(phone[2])
        
        viewModel.profile //<Single>, Syntax Sugar
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.label.text = value.user.email
               
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        //subscrive, bind, drive
        
        //dribe vs signal
        
        viewModel.getProfile()

       checkCOW()
        
    }
    
    //값 타입 참조 타입 8회차
    //값 타입이라도 참조를 하는 경우가 있다
    func checkCOW() {
        
        //string은 구조체 값타입 그대로 넣더라도 메모리주소가 바뀌는 구나
        var test = "jack"
        address(&test) // in out 매개변수
        
        print(test[2])
        print(test[200])
        
        var test2 = test
        address(&test2)
        
        test2 = "sesac"
        address(&test)
        address(&test2)
        
        print("===============")
        
        var array = Array(repeating: "A", count: 100) // Array, Dictionary, Set == Collection
        //컬렉션 타입? -> COW 성능을 최적화하고 있다고 말하면 좋다
        
        address(&array)
        
        print(array[safe: 99])
        print(array[safe: 199])
        
        var newArray = array //실제로 복사 안함 원본을 공유하고 있음!
        address(&newArray)
        
        newArray[0] = "B"
        
        address(&array)
        address(&newArray)
        
    }
    
    func address( _ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }


}

