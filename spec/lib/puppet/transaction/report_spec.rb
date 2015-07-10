require 'spec_helper'
require 'puppet/reportallthethings/helper'

describe Puppet::Transaction::Report do
  subject { YAML.load_file(report_fixture) }

  [4,3,2].each do |v|
    context "with report format #{v}" do
      let(:report_fixture) { File.join(@fixture_path, 'reports', "version#{v}.yaml") }

      it 'should contain a Report object' do
        expect(subject).to be_a Puppet::Transaction::Report
      end

      it 'should have our to_h method' do
        expect(subject).to respond_to(:to_h)
        expect(subject.to_h).to be_a Hash
        expect(subject.to_h).not_to be_a Puppet::Transaction::Report
      end
    end
  end
end
