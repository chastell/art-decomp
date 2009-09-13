# encoding: UTF-8

module ArtDecomp describe Executable do

  before do
    @orig_stderr = $stderr
    $stderr = StringIO.new
    @fsm = 'spec/fixtures/lion'
    @dir = File.join Dir.tmpdir, rand.to_s
    @args = ['-a', '5/1', '-o', @dir, @fsm]
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
    args = ['-a', '5/1', 'a/b', '-o', @dir, @fsm]
    lambda { Executable.new(args) }.should raise_error SystemExit
    stderr.should =~ /archs not in the form of inputs\/outputs/
  end

  it 'should require output directory' do
    lambda { Executable.new(['-a', '5/1', '--', @fsm]) }.should raise_error SystemExit
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
    Executable.new @args
    Dir.exists?(@dir).should be_true
  end

  it 'should validate that the specified UV generator exists' do
    lambda { Executable.new(@args + ['--uv', 'bogus']) }.should raise_error SystemExit
    stderr.should =~ /no such UV generator/
  end

  it 'should validate that the specified Qu generator exists' do
    lambda { Executable.new(@args + ['--qu', 'bogus']) }.should raise_error SystemExit
    stderr.should =~ /no such Qu generator/
  end

  it 'should validate that the specified Qv generator exists' do
    lambda { Executable.new(@args + ['--qv', 'bogus']) }.should raise_error SystemExit
    stderr.should =~ /no such Qv generator/
  end

  it 'should dump the resulting decompositions into a file' do
    fsm = mock FSM
    FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

    decomposer = mock Decomposer
    decomposer.should_receive(:decompositions).and_return [:d1, :d2, :d3].each
    Decomposer.should_receive(:new).with(:fsm => fsm, :archs => an_instance_of(Set), :uv_gens => [UVGenerator::Braindead], :qu_gens => [QuGenerator::BlockTable], :qv_gens => [QvGenerator::GraphColouring]).and_return decomposer

    Executable.new(@args).run false
    decs = Marshal.load(File.read(File.join @dir, 'decompositions'))
    decs.should == [:d1, :d2, :d3]
  end

  it 'should create files holding the resulting Decomposition objects' do
    decomposer = mock Decomposer, :decompositions => [:dec0, :dec1].each
    Decomposer.should_receive(:new).and_return decomposer
    Executable.new(@args).run
    Marshal.load(File.read(File.join @dir, '0.dec')).should == :dec0
    Marshal.load(File.read(File.join @dir, '1.dec')).should == :dec1
  end

  it 'should pass all of the requested generators and architectures to the Decomposer' do
    fsm = mock FSM
    FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

    decomposer = mock Decomposer, :decompositions => [].each
    Decomposer.should_receive(:new).with(:fsm => fsm, :archs => Set[Arch[4,2], Arch[5,1]], :uv_gens => [UVGenerator::Braindead, UVGenerator::Braindead], :qu_gens => [QuGenerator::BlockTable, QuGenerator::EdgeLabels], :qv_gens => [QvGenerator::GraphMerging, QvGenerator::Bipainting]).and_return decomposer

    args = ['-a', '5/1', '4/2', '--uv', 'Braindead', 'Braindead', '--qu', 'BlockTable', 'EdgeLabels', '--qv', 'GraphMerging', 'Bipainting', '-o', @dir, @fsm]
    Executable.new(args).run
  end

  it 'should allow setting any of the generators to ‘all’' do
    fsm = mock FSM
    FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

    decomposer = mock Decomposer, :decompositions => [].each
    Decomposer.should_receive(:new).with(:fsm => fsm, :archs => Set[Arch[5,1]], :uv_gens => [UVGenerator::Braindead], :qu_gens => [QuGenerator::BlockTable, QuGenerator::EdgeLabels], :qv_gens => [QvGenerator::Bipainting, QvGenerator::GraphColouring,QvGenerator::GraphMerging]).and_return decomposer

    args = ['-a', '5/1', '--uv', 'all', '--qu', 'all', '--qv', 'all', '-o', @dir, @fsm]
    Executable.new(args).run
  end

  it 'should decompose iteratively, down to a specified depth' do
    args = ['-a', '3/1', '-d', '2', '-o', @dir, 'spec/fixtures/lion']
    Executable.new(args).run
    File.exists?("#{@dir}/0.dec").should     be_true
    File.exists?("#{@dir}/0/0.dec").should   be_true
    File.exists?("#{@dir}/0/0/0.dec").should be_false
  end

  it 'should allow logging to the specified file/stream' do
    log = Tempfile.new rand
    Decomposer.should_receive(:new).and_return mock(Decomposer, :decompositions => [].each)
    Executable.new(['-a', '5/1', '4/2', '-l', log.path, '-o', @dir, @fsm]).run
    Logging.off
    File.read(log.path).should =~ /FSM 2\/1\/4s → 5\/1\+4\/2 cells/
  end

end end
