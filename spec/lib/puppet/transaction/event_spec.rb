require 'spec_helper'
require 'puppet/reportallthethings/helper'

describe Puppet::Transaction::Event do
  subject { YAML.load_file(report_fixture).resource_statuses['Notify[hello]'].events }

  [4,3,2].each do |v|
    context "with report format #{v}" do
      let(:report_fixture) { File.join(@fixture_path, 'reports', "version#{v}.yaml") }

      it 'should contain an array of event objects' do
        expect(subject).to be_a Array
        subject.each do |e|
          expect(e).to be_a Puppet::Transaction::Event
        end
      end

      it 'should have our to_h method' do
        event = subject.first
        expect(event).to respond_to(:to_h)
        expect(event).to be_a Puppet::Transaction::Event
        expect(event.to_h).to be_a Hash
        expect(event.to_h).not_to be_a Puppet::Transaction::Event
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
