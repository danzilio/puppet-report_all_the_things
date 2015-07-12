module Puppet
  module ReportAllTheThings
    module Helper
      def self.symbolize(string)
        string = String(string) if string.is_a?(Symbol)
        raise StandardError, "Recieved a #{string.class} but expected a String!" unless string.is_a?(String)
        String(string).sub(/^@/, '').to_sym
      end

      def self.report_all_the_things(things)
        case things
        when Hash
          things.inject({}){ |hash, (k,v)| hash.merge( k => report_all_the_things(v)) }
        when Array
          things.map { |v| report_all_the_things(v) }
        else
          things.respond_to?(:to_data_hash) ? report_all_the_things(things.to_data_hash) : things
        end
      end
    end

    module MetricMixin
      def to_data_hash
        {
          'name' => @name,
          'label' => @label,
          'values' => @values
        }
      end
    end

    module LogMixin
      def to_data_hash
        {
          'level' => @level,
          'message' => to_s,
          'source' => @source,
          'tags' => @tags.to_a,
          'time' => @time.iso8601(9),
          'file' => @file,
          'line' => @line,
        }
      end
    end

    module TagSetMixin
      def to_data_hash
        to_a
      end
    end

    module ReportMixin
      def to_data_hash
        {
          'host' => @host,
          'time' => @time.iso8601(9),
          'configuration_version' => @configuration_version,
          'transaction_uuid' => @transaction_uuid,
          'report_format' => @report_format,
          'puppet_version' => @puppet_version,
          'kind' => @kind,
          'status' => @status,
          'environment' => @environment,
          'logs' => @logs,
          'metrics' => @metrics,
          'resource_statuses' => @resource_statuses,
        }
      end
    end

    module EventMixin
      def to_data_hash
        {
          'audited' => @audited,
          'property' => @property,
          'previous_value' => @previous_value,
          'desired_value' => @desired_value,
          'historical_value' => @historical_value,
          'message' => @message,
          'name' => @name,
          'status' => @status,
          'time' => @time.iso8601(9),
        }
      end
    end

    module ResourceStatusMixin
      def to_data_hash
        {
          'title' => @title,
          'file' => @file,
          'line' => @line,
          'resource' => @resource,
          'resource_type' => @resource_type,
          'containment_path' => @containment_path,
          'evaluation_time' => @evaluation_time,
          'tags' => @tags,
          'time' => @time.iso8601(9),
          'failed' => @failed,
          'changed' => @changed,
          'out_of_sync' => @out_of_sync,
          'skipped' => @skipped,
          'change_count' => @change_count,
          'out_of_sync_count' => @out_of_sync_count,
          'events' => @events,
        }
      end
    end
  end
end

class Puppet::Util::Metric
  include Puppet::ReportAllTheThings::MetricMixin unless self.respond_to?(:to_data_hash)
end

class Puppet::Util::Log
  include Puppet::ReportAllTheThings::LogMixin unless self.respond_to?(:to_data_hash)
end

class Puppet::Util::TagSet
  include Puppet::ReportAllTheThings::TagSetMixin unless self.respond_to?(:to_data_hash)
end

class Puppet::Transaction::Report
  include Puppet::ReportAllTheThings::ReportMixin unless self.respond_to?(:to_data_hash)
end

class Puppet::Transaction::Event
  include Puppet::ReportAllTheThings::EventMixin unless self.respond_to?(:to_data_hash)
end

class Puppet::Resource::Status
  include Puppet::ReportAllTheThings::ResourceStatusMixin unless self.respond_to?(:to_data_hash)
end
