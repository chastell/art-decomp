describe Executable do

  before do
    @orig_stderr = $stderr
    $stderr = StringIO.new
    @fsm = 'spec/fixtures/lion'
    @dir = Dir.tmpdir
    @dir = File.join Dir.tmpdir, rand.to_s while File.exists? @dir
  end

  after do
    $stderr = @orig_stderr
    FileUtils.rmtree @dir if Dir.exists? @dir
  end

  def stderr
    $stderr.rewind
    $stderr.read
  end

  it 'should require an FSM' do
    lambda { Executable.new([]) }.should raise_error SystemExit
    stderr.should =~ /no FSM given/
  end

  it 'should require that the FSM exists' do
    lambda { Executable.new(['bogus']) }.should raise_error SystemExit
    stderr.should =~ /FSM does not exist/
  end

  it 'should require at least one target Arch' do
    lambda { Executable.new([@fsm]) }.should raise_error SystemExit
    stderr.should =~ /no architecture given/
  end

  it 'should require that all architectures are parsable' do
    lambda { Executable.new(['-a', 'a/b', @fsm]) }.should raise_error SystemExit
    stderr.should =~ /arch not in the form of inputs\/outputs/
  end

  it 'should require output directory' do
    lambda { Executable.new(['-a', '5/1', @fsm]) }.should raise_error SystemExit
    stderr.should =~ /no output directory given/
  end

  it 'should require that the output directory does not exist' do
    lambda { Executable.new(['-a', '5/1', '-o', Dir.tmpdir, @fsm]) }.should raise_error SystemExit
    stderr.should =~ /output directory exists/
  end

  it 'should require that the output directory is creatable' do
    Dir.mkdir @dir, 0400
    subdir = File.join @dir, rand.to_s
    lambda { Executable.new(['-a', '5/1', '-o', subdir, @fsm]) }.should raise_error SystemExit
    stderr.should =~ /output directory cannot be created/
  end

  it 'should create the output directory' do
    Dir.exists?(@dir).should be_false
    Executable.new ['-a', '5/1', '-o', @dir, @fsm]
    Dir.exists?(@dir).should be_true
  end

  it 'should validate that the specified UV generator exists' do
    lambda { Executable.new(['-a', '5/1', '-o', @dir, '--uv', 'bogus', @fsm]) }.should raise_error SystemExit
    stderr.should =~ /no such UV generator/
  end

  it 'should validate that the specified Qu generator exists' do
    lambda { Executable.new(['-a', '5/1', '-o', @dir, '--qu', 'bogus', @fsm]) }.should raise_error SystemExit
    stderr.should =~ /no such Qu generator/
  end

  it 'should validate that the specified Qv generator exists' do
    lambda { Executable.new(['-a', '5/1', '-o', @dir, '--qv', 'bogus', @fsm]) }.should raise_error SystemExit
    stderr.should =~ /no such Qv generator/
  end

  it 'should dump the resulting decompositions into a file' do
    fsm = mock FSM
    FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

    decomposer = mock Decomposer
    decomposer.should_receive(:each).and_return [:d1, :d2, :d3].each
    Decomposer.should_receive(:new).with(:fsm => fsm, :archs => an_instance_of(Set), :uv_class => UVGenerator::Braindead, :qu_class => QuGenerator::BlockTable, :qv_class => QvGenerator::GraphColouring).and_return decomposer

    Executable.new(['-a', '5/1', '-o', @dir, @fsm]).run
    decs = Marshal.load(File.read(File.join @dir, 'decompositions'))
    decs.should == [:d1, :d2, :d3]
  end

end
