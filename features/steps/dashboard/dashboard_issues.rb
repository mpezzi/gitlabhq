class DashboardIssues < Spinach::FeatureSteps
  include SharedAuthentication
  include SharedPaths

  Then 'I should see issues assigned to me' do
    issues = @user.issues
    issues.each do |issue|
      page.should have_content(issue.title[0..10])
      page.should have_content(issue.project.name)
    end
  end

  And 'I have assigned issues' do
    project = Factory :project
    project.add_access(@user, :read, :write)

    2.times { Factory :issue, :author => @user, :assignee => @user, :project => project }
  end
end
