require 'spec_helper'
require 'puppet/reportallthethings/helper'
require File.join(fixture_path, 'reports.rb')

include Reports

describe Puppet::Transaction::Report do
  subject(:converted) { Puppet::ReportAllTheThings::Helper.report_all_the_things(report) }
  subject { report }

  it 'should contain a Report object' do
    expect(subject).to be_a Puppet::Transaction::Report
  end

  context 'when I call report_all_the_things' do
    subject { Puppet::ReportAllTheThings::Helper.report_all_the_things(report) }

    it 'should serialize the entire report' do
      expect(subject).to be_a Hash
      expect(subject).not_to be_a Puppet::Transaction::Report
    end

    it 'should serialize all of the metrics objects' do
      expect(subject['metrics']).to be_a Hash
      expect(subject['metrics']).not_to be_a Puppet::Util::Metric
      expect(subject['metrics'].first.last).to be_a Hash
    end

    it 'should serialize all of the log objects' do
      expect(subject['logs']).to be_a Array
      expect(subject['logs']).not_to be_a Puppet::Util::Log
      expect(subject['logs'].first).to be_a Hash
    end

    it 'should serialize all of the resource status objects' do
      expect(subject['resource_statuses']).to be_a Hash
      expect(subject['resource_statuses'].first).not_to be_a Puppet::Resource::Status
      expect(subject['resource_statuses'].first).to be_a Array
    end
  end
end
