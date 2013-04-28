require 'rspec'
require File.expand_path("../../../app/models/settings.rb", __FILE__)

describe Settings do

  before do
    Settings.config_file = File.expand_path("../../support/fixtures/config.yml", __FILE__)
    @settings = Settings.instance
  end

  describe 'Initialize and read settings' do
    it 'should load the Yaml config file' do
      @settings.understate_threshold.should == 2000
      @settings.understate_factor.should == 4
      @settings.per_page.should == 15
      @Settings.instance.default_status == 'aktiv'
      @settings.default_role == 'Kundinnen'
    end
  end

  describe 'get non-existing setting' do
    it 'should throw a KeyNotFoundError' do
      lambda{@settings.not_there}.should raise_error KeyNotFoundError
    end
  end

  describe 'set a setting' do
    before :all do
      @settings = Settings.instance
      @old_value = @settings.per_page
      @original_settings = @settings.settings.clone
    end
    after :each do
      File.open(@settings.config_file, "w") {|f| f.write(@original_settings.to_yaml) }
    end

    context 'value exists' do
      it 'should set the value' do
        @settings.per_page = @old_value + 1
        @settings.per_page.should == @old_value + 1
      end
      it 'should write the updated value to the yaml file' do
        @settings.per_page = @old_value + 1
        yaml = YAML.load_file(@settings.config_file)
        yaml['per_page'].should == @old_value + 1
      end
    end

    context "value doesn't exist" do
      after do
        File.open(@settings.config_file, "w") {|f| f.write(@original_settings.to_yaml) }
      end

      it 'should create a new key with that value' do
        @settings.new_setting = 1
        @settings.new_setting.should == 1
      end
      it 'should write the updated value to the yaml file' do
        @settings.new_setting = 1
        yaml = YAML.load_file(@settings.config_file)
        yaml['new_setting'].should == 1
      end
    end
  end

end