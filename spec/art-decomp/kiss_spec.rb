require_relative '../spec_helper'

module ArtDecomp describe KISS do
  def verify_kiss compact, scenario
    scenario.gsub!(/^#{scenario[/\A\s*/]}/, '')
    lines, formatted = scenario.split("\n\n").map { |e| e.split "\n" }
    formatted = formatted.join("\n") + "\n"
    KISS.new(lines).formatted(compact).must_equal formatted
  end

  describe '#formatted' do
    it 'sorts entries' do
      verify_kiss true, <<-end
        1 1
        0 0

        0 0
        1 1
      end
    end

    it 'drops non-unique entries' do
      verify_kiss true, <<-end
        0 0
        0 0

        0 0
      end
    end

    it 'drops overlapping entries' do
      verify_kiss true, <<-end
        0-0 0
        010 0
        1-1 1
        --1 1

        --1 1
        0-0 0
      end
    end

    it 'preserves overlapping entries differing on subsequent column groups' do
      verify_kiss true, <<-end
        -- 1 0 1
        10 0 0 1

        -- 1 0 1
        10 0 0 1
      end
    end

    it 'combines matching entries' do
      verify_kiss true, <<-end
        00 0 1 1
        01 0 1 1
        10 1 0 0
        11 1 0 0

        0- 0 1 1
        1- 1 0 0
      end
      verify_kiss true, <<-end
        00 0
        11 0
        10 0
        01 0

        -- 0
      end
    end

    it 'supports metadata' do
      KISS.new(['00 0'], ['.v 0 1']).formatted.must_equal ".v 0 1\n00 0\n"
    end

    it 'allows skipping the drop-and-combine steps' do
      verify_kiss false, <<-end
        1 1
        0 0
        0 1

        0 0
        0 1
        1 1
      end
    end
  end
end end
