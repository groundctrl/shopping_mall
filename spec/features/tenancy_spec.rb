require 'spec_helper'

feature 'Tenancy', js: true do
  context 'index' do
    background do
      visit 'http://tenant-name.example.dev:3000'
    end

    xscenario 'homepage' do
      expect(page).to have_text 'welcome'
      expect(response).to have_http_status(:ok)
    end
  end
end
