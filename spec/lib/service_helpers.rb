require 'bundler/setup'
require 'ohai'

$ohai = Ohai::System.new
$ohai.require_plugin('os')
$ohai.require_plugin('platform')

# calls this platform's service manager and attempts to start +service+
# returns Process::Status object (exitcode available as .exitstatus)
def start_service(service)
  case $ohai.platform_family
  when /debian/, /rhel/
    Bundler.with_clean_env do
      system "/etc/init.d/#{service} start"
    end
  else
    raise "not sure how to start services on platform_family '#{platform_family}'"
  end
  return $?
end

# calls this platform's service manager and attempts to stop +service+
# returns Process::Status object (exitcode available as .exitstatus)
def stop_service(service)
  case $ohai.platform_family
  when /debian/, /rhel/
    Bundler.with_clean_env do    
      system "/etc/init.d/#{service} stop"
    end
  else
    raise "not sure how to stop services on platform_family '#{platform_family}'"
  end
  return $?
end

# calls this platform's service manager and attempts to restart +service+
# returns Process::Status object (exitcode available as .exitstatus)
def restart_service(service)
  case $ohai.platform_family
  when /debian/, /rhel/
    Bundler.with_clean_env do    
      system "/etc/init.d/#{service} restart"
    end
  else
    raise "not sure how to restart services on platform_family '#{platform_family}'"
  end
  return $?
end