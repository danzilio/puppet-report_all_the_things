require 'spec_helper'
require 'puppet/reportallthethings/helper'

describe Puppet::Util::Log do
  subject { YAML.load_file(report_fixture).logs }

  [4,3,2].each do |v|
    context "with report format #{v}" do
      let(:report_fixture) { File.join(@fixture_path, 'reports', "version#{v}.yaml") }

      it 'should contain an array of log objects' do
        expect(subject).to be_a Array
        subject.each do |l|
          expect(l).to be_a Puppet::Util::Log
        end
      end

      it 'should have our report_all_the_things method' do
        log = subject.first
        expect(log).to respond_to(:report_all_the_things)
        expect(log).to be_a Puppet::Util::Log
        expect(log.report_all_the_things).to be_a Hash

        log.report_all_the_things.keys.each do |key|
          expect(key).to be_a Symbol
        end
      end
    end
  end
end
