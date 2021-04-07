require_relative '../lib/player'

describe Player do
  let(:player) { Player.new }
  let(:player2) { Player.new }
  let(:name) { 'ilie' }
  let(:symbol) { 'X' }
  let(:answers) { [1, 2, 3] }
  describe '#initialize' do
    it 'checking setters and getters for name' do
      player.name = 'ilie'
      expect(player.name).to eql(name)
    end
    it 'checking setters and getters for answers' do
      player.answers = [1, 2, 3]
      expect(player.answers).to eql(answers)
    end
    it 'checking setters and getters for symbol' do
      player.symbol = 'X'
      expect(player.symbol).to eql(symbol)
    end
  end
  describe '#to_s' do
    it 'checking to string method' do
      player.name = 'ilie'
      player.answers = [1, 2, 3]
      player.symbol = 'X'
      expect(player.to_s).to eql("Player = #{name} with answers = #{answers} and symbol = #{symbol}")
    end
  end

  describe '#make_choice' do
    it 'changes the chosen number to player symbol in common choices' do
      choice = 5
      player.symbol = 'X'
      player.make_choice(choice)
      expect(Player.choices.include?(5)).to be false
    end
    it "pushes to player's answers array a correct choice" do
      Player.reset_choices
      choice = 5
      player.symbol = 'X'
      player.make_choice(choice)
      expect(player.answers.include?(5)).to be true
    end
    it "does not push to player's answers array if choice is not an integer" do
      Player.reset_choices
      choice = '5'
      player.make_choice(choice)
      expect(player.answers.include?('5')).to be false
    end
    it "set the symbol(X or O) on choices array if it is not already seted on choice's place" do
      Player.reset_choices
      choice = 5
      player.symbol = 'X'
      player.make_choice(choice)
      expect(Player.choices[4] == 'X').to be true
    end
    it "doesn't set the symbol(X or O) on choices array if it is already seted on choice's place" do
      Player.reset_choices
      choice = 5
      player.symbol = 'O'
      player.make_choice(choice)
      player.symbol = 'X'
      player.make_choice(choice)
      expect(Player.choices[4] == 'X').to be false
    end
  end
end
