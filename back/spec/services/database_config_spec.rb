require 'spec_helper'
require_relative '../../services/database'

RSpec.describe DatabaseConfig, type: :service do
  describe '.connect' do
    it 'connects to the database' do
      expect { DatabaseConfig.connect }.not_to raise_error
    end
  end
end
