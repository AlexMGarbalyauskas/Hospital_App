# spec/requests/create_user_spec.rb
require 'rails_helper'

RSpec.describe "User creation and authentication", type: :request do
  describe "POST /users" do
    context "with valid attributes" do
      it "creates a new user" do
        user_params = { 
          user: { 
            name: "Test User", 
            email: "test@example.com", 
            password: "password123", 
            password_confirmation: "password123" 
          } 
        }
        
        post "/users", params: user_params
        expect(response).to have_http_status(:created)
        expect(User.last.name).to eq("Test User")
      end
    end

    context "with invalid attributes" do
      it "does not create a new user without a name" do
        user_params = { 
          user: { 
            name: nil, 
            email: "test@example.com", 
            password: "password123", 
            password_confirmation: "password123" 
          } 
        }
        
        post "/users", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a new user without an email" do
        user_params = { 
          user: { 
            name: "Test User", 
            email: nil, 
            password: "password123", 
            password_confirmation: "password123" 
          } 
        }
        
        post "/users", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a new user with a short password" do
        user_params = { 
          user: { 
            name: "Test User", 
            email: "test@example.com", 
            password: "short", 
            password_confirmation: "short" 
          } 
        }
        
        post "/users", params: user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST /sessions (user login)" do
    before do
      @user = User.create(name: "Test User", email: "test@example.com", password: "password123", password_confirmation: "password123")
    end

    context "with valid credentials" do
      it "logs in the user" do
        login_params = {
          session: {
            email: "test@example.com",
            password: "password123"
          }
        }

        post "/sessions", params: login_params
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Welcome, Test User")
      end
    end

    context "with invalid credentials" do
      it "does not log in the user with incorrect password" do
        login_params = {
          session: {
            email: "test@example.com",
            password: "wrongpassword"
          }
        }

        post "/sessions", params: login_params
        expect(response).to have_http_status(:unauthorized)
      end

      it "does not log in the user with incorrect email" do
        login_params = {
          session: {
            email: "wrongemail@example.com",
            password: "password123"
          }
        }

        post "/sessions", params: login_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
