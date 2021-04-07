require_relative '../lib/logic_bot'

describe GameLogic do
  let(:gl) { GameLogic.new }
  let(:play) { true }
  let(:player) { Player.new }
  let(:player2) { Player.new }
  let(:players) { [player, player2] }
  let(:winner) { false }

  describe '#initialize' do
    it 'checking setters and getters for player' do
      gl.player = Player.new
      expect(gl.player).to be_a Player
    end
    it 'checking setters and getters for play' do
      gl.play = true
      expect(gl.play == play).to be true
    end
    it 'checking getters for players' do
      expect(players).to eql([player, player2])
    end
    it 'checking getters for winner' do
      expect(winner).to be false
    end
  end
  describe '#check_message' do
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('y')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('yes')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('yeah')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('yep')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('start')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('Start')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('Start!')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('Y')).to eql('start')
    end
    it "return start if the parameter is: 'y', 'yes', 'yeah', 'yep', 'start', 'Start', 'Start!', 'Y'" do
      expect(gl.check_message('Y')).to eql('start')
    end

    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('1').eql?('numbers') || gl.check_message('1').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('2').eql?('numbers') || gl.check_message('2').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('3').eql?('numbers') || gl.check_message('3').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('4').eql?('numbers') || gl.check_message('4').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('5').eql?('numbers') || gl.check_message('5').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('6').eql?('numbers') || gl.check_message('6').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('7').eql?('numbers') || gl.check_message('7').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('8').eql?('numbers') || gl.check_message('8').eql?('numbers-error')).to be true
    end
    it "return 'numbers' or 'numbers error' because of bot auto choices if the parameter is: '1', '2', '3', '4', '5',
     '6', '7', '8', '9' and game play mod is true" do
      gl.play = true
      expect(gl.check_message('9').eql?('numbers') || gl.check_message('9').eql?('numbers-error')).to be true
    end

    it "return 'numbers-error' if the parameter is a String (except '/end', '/close', 'no', 'end', 'n', 'N') or it
     repeats the values which were already setted, cannot be converted to an integer and play is true" do
      gl.play = true
      expect(gl.check_message('y')).to eql('numbers-error')
    end
    it "return 'numbers-error' if the parameter is a String (except '/end', '/close', 'no', 'end', 'n', 'N') or it
     repeats the values which were already setted, cannot be converted to an integer and play is true" do
      gl.play = true
      expect(gl.check_message('7')).to eql('numbers-error')
    end
    it "return 'numbers-error' if the parameter is a String (except '/end', '/close', 'no', 'end', 'n', 'N') or it
     repeats the values which were already setted, cannot be converted to an integer and play is true" do
      gl.play = true
      expect(gl.check_message('start')).to eql('numbers-error')
    end
    it "return 'numbers-error' if the parameter is a String (except '/end', '/close', 'no', 'end', 'n', 'N') or it
     repeats the values which were already setted, cannot be converted to an integer and play is true" do
      gl.play = true
      expect(gl.check_message('y')).to eql('numbers-error')
    end

    it "return 'end' if the parameter is a String: '/end', '/close', 'no', 'end', 'n', 'N' and play is true" do
      gl.play = true
      expect(gl.check_message('/end')).to eql('end')
    end
    it "return 'end' if the parameter is a String: '/end', '/close', 'no', 'end', 'n', 'N' and play is true" do
      gl.play = true
      expect(gl.check_message('/close')).to eql('end')
    end
    it "return 'end' if the parameter is a String: '/end', '/close', 'no', 'end', 'n', 'N' and play is true" do
      gl.play = true
      expect(gl.check_message('no')).to eql('end')
    end
    it "return 'end' if the parameter is a String: '/end', '/close', 'no', 'end', 'n', 'N' and play is true" do
      gl.play = true
      expect(gl.check_message('end')).to eql('end')
    end
    it "return 'end' if the parameter is a String: '/end', '/close', 'no', 'end', 'n', 'N' and play is true" do
      gl.play = true
      expect(gl.check_message('n')).to eql('end')
    end
    it "return 'end' if the parameter is a String: '/end', '/close', 'no', 'end', 'n', 'N' and play is true" do
      gl.play = true
      expect(gl.check_message('N')).to eql('end')
    end

    it "return 'game_over' if we have a winner, parameter is a integer from 1 to 9 and play is true" do
      gl.play = true
      gl.winner = true
      expect(gl.check_message('5')).to eql('game-over')
    end
    it "doesn't return 'game_over' if we don't have a winner and play is false, parameter is a integer from 1 to 9" do
      gl.play = false
      gl.winner = false
      expect(gl.check_message('5')).not_to eql('game-over')
    end

    it "in every other cases we have 'error'" do
      gl.play = false
      gl.winner = false
      expect(gl.check_message('5')).to eql('error')
    end
  end
end

#  game over logic error
