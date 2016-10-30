//
//  DataSource.swift
//

import UIKit
import RxSwift
import RxCocoa

public final class DataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {

    // MARK: - Alias

    public typealias Element = [Track]

    // MARK: - Property

    private var tracks = [Track]()

    // MARK: - RxTableView DataSourceType

    public func tableView(tableView: UITableView, observedEvent: Event<Element>) {
        switch observedEvent {
        case .Next(let value):
            self.tracks = value
            tableView.reloadData()
        case .Error(_):
            ()
        case .Completed:
            ()
        }
    }

    // MARK: - UITableView DataSource

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tracks[indexPath.row].trackName
        
        print("\(tracks[indexPath.row].trackName)")
        
        return cell
    }

}
