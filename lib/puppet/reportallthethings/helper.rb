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
  end
end
