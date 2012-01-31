require File.expand_path('../../../spec_helper', __FILE__)

# TODO: share with Kernel.abort, abort.
describe "Process.abort" do
  before :each do
    @name = tmp("process_abort.txt")
  end

  after :each do
    rm_r @name
  end

  it "raises a SystemExit with the given message" do
    lambda do
      begin
        abort "message"
      rescue SystemExit => e
        e.message.should == "message"
      end
    end.should complain(/message/)
  end

  platform_is_not :windows do
    it "terminates execution immediately" do
      Process.fork do
        Process.abort
        touch(@name) { |f| f.write 'rubinius' }
      end

      File.exists?(@name).should == false
    end
  end
end
