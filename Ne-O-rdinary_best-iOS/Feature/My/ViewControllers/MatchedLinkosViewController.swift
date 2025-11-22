import SwiftUI
import SnapKit

final class MatchedLinkosViewController: UIViewController {
    
    private let swiftUIView = MatchedLingosView()
    private var hostingController: UIHostingController<MatchedLingosView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupUI() {
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController else { return }
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        guard let hostingController else { return }
        hostingController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
      navigationItem.title = "매칭된 링오"
      navigationController?.navigationBar.prefersLargeTitles = false
      navigationController?.navigationBar.tintColor = .black
    }
}
