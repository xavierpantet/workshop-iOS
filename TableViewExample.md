# UITableViews - fonctions utiles

``` swift
let exampleTab = ["A", "B", "C"]

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return exampleTab.count
}
```


```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
    cell.textLabel?.text = exampleTab[indexPath.row]
    return cell
}
```
