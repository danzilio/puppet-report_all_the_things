require 'spec_helper'
require 'puppet/reportallthethings/helper'

describe Puppet::Util::Metric do
  subject { YAML.load_file(report_fixture).metrics }

  [4,3,2].each do |v|
    context "with report format #{v}" do
      let(:report_fixture) { File.join(@fixture_path, 'reports', "version#{v}.yaml") }

      it 'should contain an hash of metric objects' do
        expect(subject).to be_a Hash
        subject.each do |k,m|
          expect(m).to be_a Puppet::Util::Metric
        end
      end

      it 'should have our report_all_the_things method' do
        metric = subject['time']
        expect(metric).to respond_to(:report_all_the_things)
        expect(metric).to be_a Puppet::Util::Metric
        subject.each do |k,m|
          expect(m.report_all_the_things).to be_a Hash
          m.report_all_the_things.keys.each do |key|
            expect(key).to be_a Symbol
          end
        end
      end
    end
  end
end
