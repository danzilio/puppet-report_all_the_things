require 'puppet'
require 'ostruct'

module Reports
  def log
    Puppet::Util::Log.new(
      :level => :notice,
      :tags  => [
        'notice',
        'notify',
        'hello',
        'class'
      ],
      :message => "defined 'message' as 'hello'",
      :source => '/Stage[main]/Main/Notify[hello]/message',
      :time => '2015-07-10 17:20:07.291723000 -04:00'
    )
  end

  def metrics
    {
      'resources' => {"total"=>8, "skipped"=>0, "failed"=>0, "failed_to_restart"=>0, "restarted"=>0, "changed"=>0, "out_of_sync"=>1, "scheduled"=>0},
      'time' => {'total' => 0.285689, 'filebucket' => 0.000048, 'config_retrieval' => 0.285038, 'notify' => 0.000382, 'schedule' => 0.000221},
      'changes' => {'total' => 1},
      'events' => {'total' => 1, 'failure' => 0, 'success' => 0}
    }
  end

  def tagset
    tags = ['notice', 'notify', 'hello', 'class']
    if Puppet::Util::Package.versioncmp(Puppet.version, '3.4.0') >= 0
      Puppet::Util::TagSet.new(tags)
    else
      tags
    end
  end

  def resource
    Puppet::Type.type(:notify).new :title => 'hello'
  end

  def resourcestatus
    rs = Puppet::Resource::Status.new(resource)
    rs.add_event(event)
    rs
  end

  def event
    Puppet::Transaction::Event.new({"audited"=>false, "property"=>"message", "previous_value"=>:absent, "desired_value"=>"hello", "historical_value"=>nil, "message"=>"defined 'message' as 'hello'", "name"=>:message_changed, "status"=>"success"})
  end

  def report
    Puppet[:node_name_value] = 'agent.example.com'
    report = Puppet::Transaction::Report.new('apply')
    report.add_resource_status(resourcestatus)
    metrics.each do |name,hash|
      report.add_metric(name, hash)
    end
    report << log
    report
  end
end
