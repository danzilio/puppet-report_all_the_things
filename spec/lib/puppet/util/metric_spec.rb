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

      it 'should have our to_h method' do
        metric = subject['time']
        expect(metric).to respond_to(:to_h)
        expect(metric).to be_a Puppet::Util::Metric
        subject.each do |k,m|
          expect(m.to_h).to be_a Hash
          m.to_h.keys.each do |key|
            expect(key).to be_a Symbol
          end
        end
      end
    end
  end
end
