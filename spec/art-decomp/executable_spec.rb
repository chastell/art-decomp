# encoding: UTF-8

module ArtDecomp describe Executable do

  before do
    @orig_stderr = $stderr
    $stderr = StringIO.new
    @fsm = 'spec/fixtures/fsm'
    @dir = "#{Dir.tmpdir}/#{rand.to_s}"
    @args = ['--archs', '5/1', '--outdir', @dir, @fsm]
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
    stderr.should =~ rex('no FSM given')
  end

  it 'should require that the FSM exists' do
    lambda { Executable.new(['bogus']) }.should raise_error SystemExit
    stderr.should =~ rex('FSM does not exist')
  end

  it 'should require at least one target Arch' do
    lambda { Executable.new([@fsm]) }.should raise_error SystemExit
    stderr.should =~ rex('no architecture given')
  end

  it 'should require that all architectures are parsable' do
    args = ['--archs', '5/1', 'a/b', '--outdir', @dir, @fsm]
    lambda { Executable.new(args) }.should raise_error SystemExit
    stderr.should =~ rex('archs not in the form of inputs/outputs')
  end

  it 'should require output directory' do
    lambda { Executable.new(['--archs', '5/1', '--', @fsm]) }.should raise_error SystemExit
    stderr.should =~ rex('no output directory given')
  end

  it 'should require that the output directory does not exist' do
    lambda { Executable.new(['--archs', '5/1', '--outdir', Dir.tmpdir, @fsm]) }.should raise_error SystemExit
    stderr.should =~ rex('output directory exists')
  end

  it 'should require that the output directory is creatable' do
    Dir.mkdir @dir, 0400
    subdir = "#{@dir}/#{rand.to_s}"
    lambda { Executable.new(['--archs', '5/1', '--outdir', subdir, @fsm]) }.should raise_error SystemExit
    stderr.should =~ rex('output directory cannot be created')
  end

  it 'should create the output directory' do
    Dir.exists?(@dir).should be_false
    Executable.new @args
    Dir.exists?(@dir).should be_true
  end

  it 'should validate that the specified UV generator exists' do
    lambda { Executable.new(@args + ['--uv', 'bogus']) }.should raise_error SystemExit
    stderr.should =~ rex('no such UV generator')
  end

  it 'should validate that the specified Qu generator exists' do
    lambda { Executable.new(@args + ['--qu', 'bogus']) }.should raise_error SystemExit
    stderr.should =~ rex('no such Qu generator')
  end

  it 'should validate that the specified Qv generator exists' do
    lambda { Executable.new(@args + ['--qv', 'bogus']) }.should raise_error SystemExit
    stderr.should =~ rex('no such Qv generator')
  end

  it 'should dump the resulting decompositions into a file' do
    fsm = FSM.from_kiss 'spec/fixtures/fsm'
    dec = Decomposition.new fsm, Set[0], Set[1], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[]

    decomposer = mock Decomposer, :decompositions => [dec, dec].each
    Decomposer.should_receive(:new).with(:fsm => fsm, :archs => an_instance_of(Set), :uv_gens => [UVGenerator::GeneralRelevance], :qu_gens => [QuGenerator::EdgeLabels], :qv_gens => [QvGenerator::GraphColouring]).and_return decomposer

    Executable.new(@args).run false
    Marshal.load(File.read("#{@dir}/decompositions")).should == [dec, dec]
  end

  it 'should create files holding the resulting Decomposition objects and keep track of the best decomposition' do
    dec0 = Decomposition.new FSM.from_kiss('spec/fixtures/fsm'), Set[0], Set[1], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[]
    dec1 = Decomposition.new FSM.from_kiss('spec/fixtures/fsm'), Set[1], Set[0], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[]
    Decomposer.should_receive(:new).and_return mock(Decomposer, :decompositions => [dec0, dec1].each)
    ex = Executable.new @args
    ex.best.should be_nil
    ex.run
    ex.best.should == 4
    Marshal.load(File.read("#{@dir}/0.dec")).should == dec0
    Marshal.load(File.read("#{@dir}/1.dec")).should == dec1
  end

  it 'should pass all of the requested generators and architectures to the Decomposer, and report on what it’s using when asked' do
    fsm = mock FSM, :fsm_cells => nil, :implementable_in? => false, :stats => ''
    FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

    decomposer = mock Decomposer, :decompositions => [].each
    Decomposer.should_receive(:new).with(:fsm => fsm, :archs => Set[Arch[4,2], Arch[5,1]], :uv_gens => [UVGenerator::Braindead, UVGenerator::Braindead], :qu_gens => [QuGenerator::BlockTable, QuGenerator::EdgeLabels], :qv_gens => [QvGenerator::GraphMerging, QvGenerator::Bipainting]).and_return decomposer

    args = ['--archs', '5/1', '4/2', '--uv', 'Braindead', 'Braindead', '--qu', 'BlockTable', 'EdgeLabels', '--qv', 'GraphMerging', 'Bipainting', '--outdir', @dir, @fsm]
    ex = Executable.new args
    ex.gens.should == 'Braindead+Braindead, BlockTable+EdgeLabels, GraphMerging+Bipainting'
    ex.run
  end

  it 'should allow setting any of the generators to ‘all’' do
    fsm = mock FSM, :fsm_cells => nil, :implementable_in? => false, :stats => ''
    FSM.should_receive(:from_kiss).with(@fsm).and_return fsm

    decomposer = mock Decomposer, :decompositions => [].each
    Decomposer.should_receive(:new).with(:fsm => fsm, :archs => Set[Arch[5,1]], :uv_gens => [UVGenerator::Braindead, UVGenerator::GeneralRelevance], :qu_gens => [QuGenerator::BlockTable, QuGenerator::EdgeLabels], :qv_gens => [QvGenerator::Bipainting, QvGenerator::GraphColouring,QvGenerator::GraphMerging]).and_return decomposer

    args = ['--archs', '5/1', '--uv', 'all', '--qu', 'all', '--qv', 'all', '--outdir', @dir, @fsm]
    Executable.new(args).run
  end

  it 'should decompose iteratively according to the number of iterations and expose this number (along with archs and dir)' do
    args = ['--archs', '2/1', '--iters', '2', '--outdir', @dir, 'spec/fixtures/lion']
    dec = Decomposition.new FSM.from_kiss('spec/fixtures/lion'), Set[0], Set[1], Blanket[B[0],B[1],B[2]], Blanket[], Blanket[]
    Decomposer.stub!(:new).and_return mock(Decomposer, :decompositions => [dec].each)
    ex = Executable.new args
    ex.archs.should == Set[Arch[2,1]]
    ex.iters.should == 2
    ex.dir.should   == @dir
    ex.run
    File.exists?("#{@dir}/0.dec").should     be_true
    File.exists?("#{@dir}/0/0.dec").should   be_true
    File.exists?("#{@dir}/0/0/0.dec").should be_false
  end

  it 'should allow logging to the specified file/stream' do
    log = Tempfile.new rand
    Decomposer.should_receive(:new).and_return mock(Decomposer, :decompositions => [].each)
    Executable.new(['--archs', '5/1', '4/2', '--debug', '--log', log.path, '--outdir', @dir, @fsm]).run
    Logging.level.should == Logger::DEBUG
    Logging.off
    File.read(log.path).should =~ rex('FSM 4/2+10s → 5/1+4/2')
  end

  it 'should handle the s8 edge case with grace' do
    log = Tempfile.new rand
    Executable.new(['--archs', '2/1', '--log', log.path, '--outdir', @dir, 'spec/fixtures/s8']).run
    Logging.off
    File.read(log.path).should =~ rex('final best decomposition: 0 cells')
  end

  # FIXME: add specs for --binary, --non-disjoint and --deep-ndj

end end
