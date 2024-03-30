//
//  SplashVC.swift
//  Maak
//
//  Created by AAIT on 21/12/2023.
//

import AVKit
import UIKit

final class SplashVC: BaseVC {
    // MARK: - Properties -

    private var player: AVPlayer?

    // MARK: - Initializers -

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialDesign()
        checkRoute()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadVideo()
    }

    // MARK: - Design Methods -

    private func configureInitialDesign() {
        view.backgroundColor =  .white
        changeLanguage(lang: UserDefaults.isFirstTime ? "en" : Language.currentLanguage())
    }

    private func changeLanguage(lang: String) {
        Language.setAppLanguage(lang: lang)
    }
}

// MARK: - Load Video Method -

extension SplashVC {
    private func loadVideo() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch { }

        let path = Bundle.main.path(forResource: "IntroVideo", ofType: "mp4")

        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.frame = view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer.zPosition = -1

        view.layer.addSublayer(playerLayer)

        player?.seek(to: CMTime.zero)
        player?.play()
    }
}


// MARK: -Route -
extension SplashVC {
    
    private func checkRoute(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            switch LaunchOptions.configure() {
            case .main:
                AppCoordinator.shared.changeFlow(navigationFlow: .tabBar(selectedIndex: .main))
            case .auth:
                AppCoordinator.shared.changeFlow(navigationFlow: .auth)

            case .onboarding:
                AppCoordinator.shared.changeFlow(navigationFlow: .language)
            }
        }
    }
}
