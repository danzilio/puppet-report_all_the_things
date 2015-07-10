module Puppet
  module ReportAllTheThings
    module Helper
      def self.symbolize(string)
        return string if string.is_a?(Symbol)
        raise StandardError, "Recieved a #{string.class} but expected a String!" unless string.is_a?(String)
        String(string).sub(/^@/, '').to_sym
      end

      def to_h
        hash = {}
        self.instance_variables.each do |iv|
          hash[Helper.symbolize(iv)] = self.instance_variable_get(iv)
        end
        hash
      end
    end
  end

  class Transaction::Report
    def to_h
      hash = {}
      self.instance_variables.each do |iv|
        key = ReportAllTheThings::Helper.symbolize(iv)
        data = self.instance_variable_get(iv)
        case
        when data.is_a?(Hash)
          hash[key] = data.map { |k,v| { k => v.to_h } }
        when data.is_a?(Array)
          hash[key] = data.map { |v| v.to_h }
        else
          hash[key] = data
        end
      end
      hash
    end
  end

  class Resource::Status
    include ReportAllTheThings::Helper
  end

  class Util::Log
    include ReportAllTheThings::Helper
  end

  class Util::Metric
    include ReportAllTheThings::Helper
  end

  class Transaction::Event
    include ReportAllTheThings::Helper
  end
end
