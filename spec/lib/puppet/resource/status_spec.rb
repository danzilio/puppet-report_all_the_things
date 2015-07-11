require 'spec_helper'
require 'puppet/reportallthethings/helper'

describe Puppet::Resource::Status do
  subject { YAML.load_file(report_fixture).resource_statuses }

  [4,3,2].each do |v|
    context "with report format #{v}" do
      let(:report_fixture) { File.join(@fixture_path, 'reports', "version#{v}.yaml") }

      it 'should contain a hash of status objects' do
        expect(subject).to be_a Hash
      end

      it 'should have our report_all_the_things method' do
        status = subject['Notify[hello]']
        expect(status).to respond_to(:report_all_the_things)
        expect(status).to be_a Puppet::Resource::Status
        expect(status.report_all_the_things).to be_a Hash
        expect(status.report_all_the_things).not_to be_a Puppet::Resource::Status
      end
    end
  end
end
