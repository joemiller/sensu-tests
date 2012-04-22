# test helper. wait up until +time+ +increment+s for the specified &block to
# execute as true. eg:
#   wait 60 do
#     File.exists?('/path').should == true
#   end
def wait(time, increment = 1, elapsed_time = 0, &block)
  begin
    yield
  rescue Exception => e
    if elapsed_time >= time
      raise e
    else
      sleep increment
      wait(time, increment, elapsed_time + increment, &block)
    end
  end
end
