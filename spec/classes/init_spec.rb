require 'spec_helper'
describe 'tune2fs' do

  context 'with defaults for all parameters' do
    it { should contain_class('tune2fs') }
  end
end
