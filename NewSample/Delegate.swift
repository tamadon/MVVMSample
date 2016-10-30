//
//  Delegate.swift
//

import UIKit

public final class Delegate: NSObject, UITableViewDelegate {

    // MARK: - UITableView Delegate

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
