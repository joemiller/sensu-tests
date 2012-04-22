require 'sys/proctable'

def get_processes(regex)
  Sys::ProcTable.ps.select { |p| p.cmdline =~ regex }
end

def count_processes(regex)
  get_processes(regex).count
end

def is_running?(regex)
  get_processes(regex).count > 0 ? true : false
end

## ------ ##
if __FILE__ == $0
  puts 'get_processes   : ', get_processes( /init/ )
  puts 'count_processes : ', count_processes( /init/ )
  puts 'is_running?     : ', is_running?( /init/ )
end