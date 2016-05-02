class NicerString
  def initialize(input_string)
    @input_string = input_string
  end

  def call
    contains_repeating_pairs? && contains_repeating_letters_separated_by_another?
  end

  private

  def contains_repeating_pairs?
    slice_pairs = Hash.new

    @input_string.chars.each_with_index.each_cons(2) do |char1_with_index, char2_with_index|
      slice = [char1_with_index[0], char2_with_index[0]]
      index = char1_with_index[1]
      slice_pairs[slice] ||= []
      slice_pairs[slice] << index unless slice_pairs[slice].include?(index-1)
    end

    slice_pairs.values.any? { |slice_indexes| slice_indexes.length >= 2}
  end

  def contains_repeating_letters_separated_by_another?
    @input_string.chars.each_cons(3).to_a.any? { |char_left, char, char_right| char_left == char_right }
  end
end