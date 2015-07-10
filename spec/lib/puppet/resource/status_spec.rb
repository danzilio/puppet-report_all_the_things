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

      it 'should have our to_h method' do
        status = subject['Notify[hello]']
        expect(status).to respond_to(:to_h)
        expect(status).to be_a Puppet::Resource::Status
        expect(status.to_h).to be_a Hash
        expect(status.to_h).not_to be_a Puppet::Resource::Status
      end
    end
  end
end
