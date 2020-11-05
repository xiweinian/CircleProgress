//
//  GradientCircleProgressView.swift
//  SwiftDemo
//
//  Created by ZHHL on 2020/11/5.
//

import UIKit

class GradientCircleProgressView: UIView {
    //MARK:- public Property
    /// 起始角度
    public var startAngle: CGFloat = 0.0 {
        didSet { redrawProgress() }
    }
    /// 是否是顺时针
    public var isClockwise: Bool = true {
        didSet { redrawProgress() }
    }
    /// 0-1.0
    public var progress: CGFloat = 0.0 {
        didSet {
            infoLabel.text = "\(Int(progress * 100) % 101)"
            p_drawProgress()
        }
    }
    /// 线宽
    public var lineWidth: CGFloat = 4 {
        didSet {
            bottomLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
            redrawProgress()
        }
    }
    /// 是否以虚线形式展示注意线段间隔太短时会受到lineCap影响可能看不到效果
    public var shouldWithDashPattern: Bool = false {
        didSet {
            if shouldWithDashPattern && !dashPattern.isEmpty {
                progressLayer.lineDashPattern = dashPattern
                bottomLayer.lineDashPattern = dashPattern
            } else {
                progressLayer.lineDashPattern = nil
                bottomLayer.lineDashPattern = nil
            }
            redrawProgress()
        }
    }
    ///虚线长度设置
    public var dashPattern: [NSNumber] = [NSNumber(integerLiteral: 2), NSNumber(integerLiteral: 2)] {
        didSet {
            if shouldWithDashPattern && !dashPattern.isEmpty {
                progressLayer.lineDashPattern = dashPattern
                bottomLayer.lineDashPattern = dashPattern
            } else {
                progressLayer.lineDashPattern = nil
                bottomLayer.lineDashPattern = nil
            }
            redrawProgress()
        }
    }
    ///背景圆环颜色
    public var maxTintColor: UIColor = .gray {
        didSet {
            bottomLayer.strokeColor = maxTintColor.cgColor
            p_drawBottom()
        }
    }
    ///进度条的渐变色
    public var progressColors: [Any] = [UIColor.orange.cgColor, UIColor.red.cgColor] {
        didSet { self.progressGradientLayer.colors = progressColors }
    }
    ///进度条闭合方式
    public var lineCap: CAShapeLayerLineCap = .round {
        didSet {
            progressLayer.lineCap = lineCap
            bottomLayer.lineCap = lineCap
            redrawProgress()
        }
    }
    ///是否显示底部圆环
    public var showBottomCircle: Bool = true {
        didSet { bottomLayer.isHidden = !showBottomCircle }
    }
    /// 是否显示进度值
    public var showInfoLabel: Bool = true {
        didSet { infoLabel.isHidden = !showInfoLabel }
    }
    //MARK:- private Property
    private var kSelfWidth: CGFloat { frame.size.width }
    private var kSelfHeight: CGFloat { frame.size.height }
    
    //MARK:======================== lazy
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "\(Int(progress * 100) % 101)"
        label.textAlignment = .center
        return label
    }()
    private lazy var progressLayer: CAShapeLayer = {
        let progressLayer = CAShapeLayer()
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = lineCap
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1
        progressLayer.strokeColor = UIColor.green.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        return progressLayer
    }()
    private lazy var progressGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.colors = progressColors
        layer.mask = progressLayer
        return layer
    }()
    private lazy var bottomLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = lineWidth
        layer.lineCap = lineCap
        layer.strokeStart = 0
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = maxTintColor.cgColor
        layer.isHidden = !showBottomCircle
        return layer
    }()
    //MARK:- init &layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(bottomLayer)
        layer.addSublayer(progressGradientLayer)
        addSubview(infoLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLayer.frame = bounds
        progressLayer.frame = bounds
        progressGradientLayer.frame = bounds
        infoLabel.frame = bounds
        p_drawBottom()
    }
    //MARK:- public Methods
    /// 设置进度条渐变色的相关属性
    /// ( 直接设置progressGradientLayer，不会直接应用于CircleProgressView的属性 )
    /// @param handle 回调
    func setProgressGradientLayer(_ handle: ((CAGradientLayer) -> Void)?) {
        handle?(progressGradientLayer)
    }
    /// 设置进度条线宽虚线进度等相关属性
    /// ( 直接设置progressGradientLayer，不会直接应用于CircleProgressView的属性 )
    /// @param handle 回调
    func setProgressLayer(_ handle: ((CAShapeLayer) -> Void)?) {
        handle?(progressLayer)
        p_drawProgress()
    }
    /// 设置底部圆环相关属性
    /// ( 直接设置progressGradientLayer，不会直接应用于CircleProgressView的属性 )
    /// @param handle 回调
    func setBottomLayer(_ handle: ((CAShapeLayer) -> Void)?) {
        handle?(bottomLayer)
        p_drawBottom()
    }
    func redrawProgress() {
        p_drawBottom()
        p_drawProgress()
    }
    //MARK:- private Methods
    private func p_drawProgress() {
        let center = CGPoint(x: kSelfWidth / 2.0, y: kSelfHeight / 2.0)
        let radius = kSelfWidth / 2.0 - lineWidth / 2.0
        var endAngle = Double.pi * 2.0 * Double(progress) + Double(startAngle)
        if !isClockwise {
            endAngle = Double(startAngle) - Double.pi * 2 * Double(progress)
        }
        progressLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: CGFloat(endAngle),
            clockwise: isClockwise
        ).cgPath
    }
    private func p_drawBottom() {
        let center = CGPoint(x: kSelfWidth / 2.0, y: kSelfHeight / 2.0)
        let radius = kSelfWidth / 2.0 - lineWidth / 2.0
        var endAngle = Double.pi * 2 + Double(startAngle)
        if !isClockwise {
            endAngle = Double(startAngle) - Double.pi * 2.0
        }
        bottomLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: CGFloat(endAngle),
            clockwise: isClockwise
        ).cgPath
    }

}
