require './lib/logic_bot'


#initialize
#check_message
describe GameLogic do
    let(:gl) {GameLogic.new}
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
        # it 'checking setters and getters for symbol' do
        #     player.symbol = 'X'
        #     expect(player.symbol).to eql(symbol)
        # end
    end
end

# describe '#initialize' do
#     it 'checking setters and getters for name' do
#       player.name = 'ilie'
#       expect(player.name).to eql(name)
#     end
#     it 'checking setters and getters for answers' do
#       player.answers = [1, 2, 3]
#       expect(player.answers).to eql(answers)
#     end
#     it 'checking setters and getters for symbol' do
#       player.symbol = 'X'
#       expect(player.symbol).to eql(symbol)
#     end
#   end