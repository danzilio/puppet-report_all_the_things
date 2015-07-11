module Puppet
  module ReportAllTheThings
    module Helper
      def self.symbolize(string)
        string = String(string) if string.is_a?(Symbol)
        raise StandardError, "Recieved a #{string.class} but expected a String!" unless string.is_a?(String)
        String(string).sub(/^@/, '').to_sym
      end

      def report_all_the_things
        hash = {}
        self.instance_variables.each do |iv|
          key = Helper.symbolize(iv)
          val = self.instance_variable_get(iv)
          if val.respond_to?(:report_all_the_things)
            hash[key] = val.report_all_the_things
          else
            hash[key] = val
          end
        end
        hash
      end
    end
  end

  class Transaction::Report
    def report_all_the_things
      hash = {}
      self.instance_variables.each do |iv|
        key = ReportAllTheThings::Helper.symbolize(iv)
        data = self.instance_variable_get(iv)
        case
        when data.is_a?(Hash)
          hash[key] = data.map { |k,v| { k => v.report_all_the_things } }
        when data.is_a?(Array)
          hash[key] = data.map { |v| v.report_all_the_things }
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

  class Util::TagSet
    def report_all_the_things
      self.to_a
    end
  end

  class Transaction::Event
    include ReportAllTheThings::Helper
  end
end
