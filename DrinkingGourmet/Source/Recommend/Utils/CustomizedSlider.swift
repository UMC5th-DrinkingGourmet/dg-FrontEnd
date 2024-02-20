//
//  UIView+CustomSlider.swift
//  DrinkingGourmet
//
//  Created by 김희은 on 1/22/24.
//

import UIKit
import SnapKit

//MARK: - SliderView.swift
protocol SliderViewDelegate: AnyObject {
    func sliderView(_ sender: SliderView, changedValue value: Int)
}

final class SliderView: UIView {
    
    //MARK: - Properties
    private lazy var trackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.baseColor.base08
        view.clipsToBounds = true
        view.layer.masksToBounds = true // Explicitly set masksToBounds
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var thumbView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.baseColor.base08
        view.backgroundColor = UIColor.customColor.customOrange
        view.isUserInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    private lazy var fillTrackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor.customOrange
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    private var maxValue: Int
    private var touchBeganPosX: CGFloat?
    private var didLayoutSubViews: Bool = false
    
    private let thumbSize: CGFloat = 16
    private let dividerWidth: CGFloat = 1
    
    weak var delegate: SliderViewDelegate?
    
    override var intrinsicContentSize: CGSize {
        return .init(width: .zero, height: thumbSize)
    }
    
    var value: Int = 0 {
        didSet {
            delegate?.sliderView(self, changedValue: value)
        }
    }
    
    //MARK: - LifeCycle
    init(maxValue: Int) {
        if maxValue < 1 {
            self.maxValue = 1
        }
        else if maxValue > 20 {
            self.maxValue = 20
        }
        else{
            self.maxValue = maxValue
        }
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !didLayoutSubViews {
            makeDivider(maxValue) // 5
            makeDegreeLabel(maxValue) // 5
            thumbView.layer.cornerRadius = 8
            
        }
    }
    
    //MARK: - Helpers
    private func layout() {
        [trackView, fillTrackView, thumbView].forEach(addSubview)
        
        trackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(4)
        }
        thumbView.snp.makeConstraints { make in
            make.centerY.equalTo(trackView)
            let leadingCenter = UIScreen.main.bounds.size.width/2 - 20
            make.leading.equalTo(trackView).offset(leadingCenter - (thumbSize/2))
            make.size.equalTo(thumbSize)
        }
        fillTrackView.snp.makeConstraints { make in
            make.leading.equalTo(trackView)
            make.top.bottom.equalTo(trackView)
            make.width.equalTo(0)
        }
        
    }
    
    private func makeDivider(_ numberOfDivider: Int) {
        let slicedPosX = (trackView.frame.width - 28) / CGFloat(numberOfDivider-1)
        
        for i in 0..<numberOfDivider {
            let dividerPosX = slicedPosX * CGFloat(i)
            let divider = makeDivider()
            
            trackView.addSubview(divider)
            
            divider.snp.makeConstraints { make in
                make.centerY.equalTo(trackView)
                make.leading.equalTo(trackView).offset(dividerPosX + 14)
                make.width.equalTo(dividerWidth)
                make.height.equalTo(trackView).offset(2)
            }
            
        }
        
        didLayoutSubViews.toggle()
    }
    
    private func makeDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = UIColor.baseColor.base06
        return divider
    }
    
    
    
    private func makeDegreeLabel(_ numberOfDivider: Int) {
        let slicedPosX = (trackView.frame.width - 28) / CGFloat(numberOfDivider-1)
        
        for i in 0..<numberOfDivider {
            let degreeLabel = makeDegreeLabel()
            
            degreeLabel.text = "\(i + 1)"
            
            self.addSubview(degreeLabel)
            
            degreeLabel.snp.makeConstraints { make in
                make.top.equalTo(trackView.snp.bottom).offset(11)
                make.leading.equalTo(trackView.snp.leading).offset(slicedPosX * CGFloat(i) + 9)
                make.height.equalTo(20)
                make.width.equalTo(10)
            }
            
        }
        
        didLayoutSubViews.toggle()
    }
    
    
    private func makeDegreeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.baseColor.base06
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }
    
    
    
    //MARK: - Actions
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: thumbView)
        thumbView.backgroundColor = UIColor.customColor.customOrange
        
        if recognizer.state == .began {
            touchBeganPosX = thumbView.frame.minX
        }
        if recognizer.state == .changed {
            guard let startX = self.touchBeganPosX else { return }
            
            var offSet = startX + translation.x // 시작지점 + 제스쳐 거리 = 현재 제스쳐 좌표
            if offSet < 0 || offSet > trackView.frame.width { return } // 제스쳐가 trackView의 범위를 벗어나는 경우 무시
            let slicedPosX = (trackView.frame.width-28) / CGFloat(maxValue - 1) // maxValue를 기준으로 trackView를 n등분
            
            
            let newValue = round((offSet-14) / slicedPosX)
            offSet = 14 + slicedPosX * newValue - (thumbSize / 2)
            
            if value != Int(newValue + 1) {
                value = Int(newValue + 1)
            }
            
            // select 전, thumb View가 없어야 함
            // select됐을 때, thumb View가 있어야 함
            if offSet <= trackView.frame.width && offSet >= ((slicedPosX * 3) + 14 ) {
                fillTrackView.snp.updateConstraints { make in
                    make.width.equalTo(trackView.frame.width)
                    trackView.backgroundColor = UIColor.customColor.customOrange
                }
            }
            else {
                fillTrackView.snp.updateConstraints { make in
                    make.width.equalTo(thumbSize).offset(offSet+thumbSize)
                    trackView.backgroundColor = UIColor.baseColor.base08
                }
            }
            
            for i in 0..<maxValue {
                let dividerPosX = slicedPosX * CGFloat(i)
                let divider = makeDivider()
                
                fillTrackView.addSubview(divider)
                
                divider.snp.makeConstraints { make in
                    make.centerY.equalTo(trackView)
                    make.leading.equalTo(trackView).offset(dividerPosX + 14)
                    make.width.equalTo(dividerWidth)
                    make.height.equalTo(trackView).offset(2)
                }
            }
            
            
            thumbView.snp.updateConstraints { make in
                make.leading.equalTo(trackView).offset(offSet)
                
            }
        }
    }
}
