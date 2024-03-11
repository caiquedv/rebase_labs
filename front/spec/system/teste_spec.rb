require 'spec_helper'

describe 'front', js: true do
  it "should have a title" do
    visit '/'

    expect(page).to have_content "Teste"
  end
end
