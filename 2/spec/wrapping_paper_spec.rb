require_relative '../wrapping_paper'

RSpec.describe WrappingPaper do
  subject(:wrapper) { WrappingPaper.new(length, width, height) }
  {
    '58': [2, 3, 4],
    '43': [1, 1, 10]
  }.each do |target, len_wid_hei|
    context "with '#{len_wid_hei}'" do
      let(:length) { len_wid_hei[0] }
      let(:width) { len_wid_hei[1] }
      let(:height) { len_wid_hei[2] }
      
      it "results in #{target} square feet of paper" do
        expect(wrapper.call).to eq(target.to_s.to_i)
      end
    end
  end
  
end