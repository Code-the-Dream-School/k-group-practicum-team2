require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user1) do
    User.create!(
      email: 'user1@example.com',
      password: 'secret'
    )
  end

  let!(:user2) do
    User.create!(
      email: 'user2@example.com',
      password: 'secret'
    )
  end

  let!(:skill1) do
    Skill.create!(
      name: 'Skill 1'
    )
  end

  let!(:skill2) do
    Skill.create!(
      name: 'Skill 2'
    )
  end

  let!(:skill3) do
    Skill.create!(
      name: 'Skill 3'
    )
  end

  let!(:project1) do
    Project.create!(
      title: 'Test Project 1',
      description: 'Test project description one.',
      status: "mentors",
      skills: [ skill1, skill2 ],
      user: user1,
      url: "https://example.com"
    )
  end

  let!(:project2) do
    Project.create!(
      title: 'Test Project 2',
      description: 'Test project description two.',
      status: "teammates",
      skills: [ skill1 ],
      user: user1
    )
  end

  let!(:project3) do
    Project.create!(
      title: 'New Project 2',
      description: 'New project description three.',
      status: "both",
      skills: [ skill1 ],
      user: user2
    )
  end

  before do
    sign_in user1, scope: :user
  end

  describe "GET /projects" do
    before do
      get '/projects'
    end

    it 'responds with 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing title and descriptions of all the projects' do
      expect(response.body).to include('Test Project 1')
      expect(response.body).to include('Test project description one.')
      expect(response.body).to include('Test Project 2')
      expect(response.body).to include('Test project description two.')
    end

    it 'returns a page containing status of each project' do
      expect(response.body).to include('Looking for mentors.')
      expect(response.body).to include('Looking for teammates.')
    end

    it 'returns a page containing the project_skills of each project' do
      expect(response.body).to include('Skill 1')
      expect(response.body).to include('Skill 2')
    end
    it 'returns a page containing the project url when present' do
      expect(response.body).to include('https://example.com')
    end
  end

  describe 'GET /projects/:id' do
    before do
      get "/projects/#{project1.id}"
    end

    it 'responds with 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the project title' do
      expect(response.body).to include('Test Project 1')
    end

    it 'returns a page containing the project description' do
      expect(response.body).to include('Test project description one.')
    end

    it 'returns a page containing the project status' do
      expect(response.body).to include('Looking for mentors.')
    end

    it 'returns a page containing the project_skills' do
      expect(response.body).to include('Skill 1')
      expect(response.body).to include('Skill 2')
    end
    it 'returns a page containing the project url when present' do
      expect(response.body).to include('https://example.com')
    end
  end

  describe 'GET /projects/new' do
    before do
      get '/projects/new'
    end

    it 'displays title and description labels' do
      expect(response.body).to include('Title')
      expect(response.body).to include('Description')
    end

    it 'displays the status label' do
      expect(response.body).to include('Status')
    end
  end

  describe 'POST /projects' do
    it 'creates a new project associated with the current user when title and status exist' do
      post '/projects', params: {
        project: {
          title: "New Project",
          description: 'Project description.',
          status: 'mentors',
          url: "https://example.com",
          skill_ids: [ skill1.id ]
        }
      }

      expect(response).to redirect_to(projects_path)
      expect(Project.last.url).to eq("https://example.com")

      expect(Project.last.title).to eq('New Project')
      expect(Project.last.description).to eq('Project description.')
      expect(Project.last.status).to eq('mentors')
      expect(Project.last.skills).to include(skill1)

      expect(Project.last.user).to eq(user1)
    end

    it 'does not create a project when no title is provided' do
      expect {
        post '/projects', params: {
          project: {
            title: nil,
            description: 'Project description.',
            status: 'mentors',
            skill_ids: [ skill1.id ]
          }
        }
      }.to_not change(Project, :count)
    end

    it 're-renders the form when no title is provided' do
      post '/projects', params: {
        project: {
          title: nil,
          description: 'Project description.',
          status: 'mentors',
          skill_ids: [ skill1.id ]
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not create a project when no status is provided' do
      expect {
        post '/projects', params: {
          project: {
            title: 'New Project',
            description: 'Project description.',
            status: nil,
            skill_ids: [ skill1.id ]
          }
        }
      }.to_not change(Project, :count)
    end
    it 'does not create a project when url is invalid' do
      expect {
        post '/projects', params: {
          project: {
            title: "Invalid URL Project",
            description: "Description",
            status: "mentors",
            url: "not-url",
            skill_ids: [ skill1.id ]
          }
        }
      }.not_to change(Project, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /projects/:id/edit' do
    context 'user owns project' do
      before do
        get "/projects/#{project1.id}/edit"
      end

      it 'responds with 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'displays the title label' do
        expect(response.body).to include('Title')
      end

      it 'displays the description label' do
        expect(response.body).to include('Description')
      end

      it 'displays the status label' do
        expect(response.body).to include('Status')
      end
    end

    context 'user does not own the project' do
      it "does not allow access to another user's project" do
        get "/projects/#{project3.id}/edit"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /projects/:id' do
    it "updates a project's title, description, status and skills when they are valid and strong params exist" do
      put "/projects/#{project1.id}", params: {
        project: {
          title: 'New Title',
          description: 'New description.',
          status: 'teammates',
          skill_ids: [ skill3.id ]
        }
      }

      expect(response).to redirect_to(project1)
      project1.reload
      expect(project1.title).to eq('New Title')
      expect(project1.description).to eq('New description.')
      expect(project1.status).to eq('teammates')
      expect(project1.skills).to include(skill3)
      expect(project1.skills).to_not include(skill1)
    end

    it 'updates the project url when valid' do
      put "/projects/#{project1.id}", params: {
        project: {
          url: "https://new-url.com"
        }
      }

      expect(response).to redirect_to(project1)
      project1.reload
      expect(project1.url).to eq("https://new-url.com")
    end
    it 'does not update the project url when invalid' do
      original_url = project1.url

      put "/projects/#{project1.id}", params: {
        project: {
          url: "not-a-valid-url"
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)

      project1.reload
      expect(project1.url).to eq(original_url)
    end
    it 'responds with 422 status when title is not provided' do
      put "/projects/#{project1.id}", params: {
        project: {
          title: nil,
          description: 'New description.',
          status: 'teammates',
          skill_ids: [ skill3.id ]
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'responds with 422 status when no status is provided' do
      put "/projects/#{project1.id}", params: {
        project: {
          title: 'New Project',
          description: 'New description',
          status: nil,
          skill_ids: [ skill3.id ]
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not allow access to another user's project" do
      put "/projects/#{project3.id}", params: {
        project: {
          title: 'New Title',
          description: 'New description.',
          status: 'teammates',
          skill_ids: [ skill3.id ]
        }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /projects/:id' do
    it 'deletes the project' do
      expect {
        delete "/projects/#{project1.id}"
      }.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects index page' do
      delete "/projects/#{project1.id}"

      expect(response).to redirect_to(projects_path)
    end

    it "does not allow access to another user's project" do
      delete "/projects/#{project3.id}"

      expect(response).to have_http_status(:not_found)
    end
  end
  describe "bookmark buttons on index" do
    it "renders the POST bookmark button when not bookmarked" do
      get "/projects"

      expect(response.body).to include(project_bookmarked_projects_path(project1))
    end

    it "renders the DELETE unbookmark button when bookmarked" do
      bookmark = BookmarkedProject.create!(
        user: user1,
        project: project1
      )

      get "/projects"

      expect(response.body).to include(project_bookmarked_project_path(project1, bookmark))
    end
  end

end
