require 'spec_helper'
require 'puppet/reportallthethings/helper'

describe Puppet::ReportAllTheThings::Helper do
  subject { Puppet::ReportAllTheThings::Helper }

  it 'should symbolize a string' do
    expect(subject.symbolize('string')).to eq :string
  end

  it 'should strip the @ sign from an instance variable name and symbolize the string' do
    expect(subject.symbolize('@instance_variable')).to eq :instance_variable
  end

  it 'should raise an error when passed something other than a string' do
    expect { subject.symbolize(1.2) }.to raise_error StandardError
  end
end
