class GithubFacade

  def self.authenticate(code)
    GithubService.authenticate(code)
  end

end