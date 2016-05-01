require_relative '../line_parser'

RSpec.describe LineParser do
  let(:each_lineable) { double('File') }
  
  subject(:line_parser) { LineParser.new(each_lineable) }
  
  context 'parsing' do
    it 'calls each_line' do
      expect(each_lineable).to receive(:each_line).and_yield('1x2x3').and_yield('2x3x4').and_yield('3x4x5')
      
      line_parser.each do |length, height, width|
        expect(length).to be_a(Fixnum)
        expect(height).to be_a(Fixnum)
        expect(width).to be_a(Fixnum)
      end
    end
  end
end
