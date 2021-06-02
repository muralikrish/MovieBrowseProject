//
//  MovieListVC.swift
//  MovieDB
//
//  Created by Teja Bethina on 6/1/21.
//

import UIKit

class MovieListVC: UIViewController {
    
    @IBOutlet var moviesTableView: UITableView!
    @IBOutlet var moviesSearchView: UISearchBar!
    var moviesList = MoviesList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Movie Search"
        setUpTableView()
        setUpSearchbar()
    }
    
    private func setUpSearchbar() {
        moviesSearchView.showsCancelButton = true
        moviesSearchView.delegate = self
    }
    
    private func setUpTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "MovieCellView", bundle: nil), forCellReuseIdentifier: "MovieCell")
        moviesTableView.tableFooterView = UIView()
    }
    
    func fetchMoviesList(keyword: String) {
        let path = Constants.moviesSearchURL + "&query=" + keyword.replacingOccurrences(of: " ", with: "")
        Network().execute(urlString: path, successHandler: { (responseData) in
            if let movies = self.processMoviesResponse(response: responseData) {
                self.moviesList = movies
                DispatchQueue.main.async {
                  self.moviesTableView.reloadData()
                }
            }
        }, errorHandler: { errorMsg in
            
        })
    }
    
    func processMoviesResponse(response: Data) -> MoviesList? {
        let decoder = JSONDecoder()
        
        do {
            let moviesList = try decoder.decode(MoviesList.self, from: response)
            print(moviesList)
            return moviesList
        } catch {
            print(error)
            return nil
        }
    }
    
}

extension MovieListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MovieListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            let movieDetails = moviesList.results[indexPath.row]
            cell.configureData(movie: movieDetails)
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = moviesList.results[indexPath.row]
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsVC")
        (movieDetailsVC as! MovieDetailsVC).movieDetails = movieDetails
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
}

extension MovieListVC: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMoviesList(keyword: searchBar.searchTextField.text ?? "")
        searchBar.resignFirstResponder()
    }
}
