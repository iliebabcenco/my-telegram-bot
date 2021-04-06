require './lib/ui_tictac'

describe UIgame do
    let(:ui) { UIgame.new }
    let(:board) { Player.choices }
    let(:keyboard) { [[board[0].to_s, board[1].to_s, board[2].to_s], [board[3].to_s, board[4].to_s, board[5].to_s],
    [board[6].to_s, board[7].to_s, board[8].to_s], ['end']] }
    let(:game_logic) { GameLogic.new }
  
    describe '#initialize' do
      it 'checking setters and getters for board' do
        ui.board = Player.choices
        expect(ui.board).to eql(board)
      end
      it 'checking setters and getters for keyboard' do
        ui.keyboard = [[board[0].to_s, board[1].to_s, board[2].to_s], [board[3].to_s, board[4].to_s, board[5].to_s],
        [board[6].to_s, board[7].to_s, board[8].to_s], ['end']]
        expect(ui.keyboard == keyboard).to be true
      end
      it 'checking getters for Game Logic' do
        expect(game_logic).to be_a GameLogic
      end
   
    end
    describe '#key_board' do
        it 'checking returns for key_board method' do
            key_board = [[board[0].to_s, board[1].to_s, board[2].to_s], [board[3].to_s, board[4].to_s, board[5].to_s],
            [board[6].to_s, board[7].to_s, board[8].to_s], ['end']]
            expect(ui.key_board).to eql(key_board)
        end
        it 'return false because no end as the last element' do
            key_board = [[board[0].to_s, board[1].to_s, board[2].to_s], [board[3].to_s, board[4].to_s, board[5].to_s],
            [board[6].to_s, board[7].to_s, board[8].to_s]]
            expect(ui.key_board.eql?(key_board)).to be false
        end
    end
    describe '#draw_board' do
        it 'checking returns for draw_board method' do
            draw_board = "+-----+-----+-----+
 |  #{board[0]}  |  #{board[1]}  |  #{board[2]}  |
+-----+-----+-----+
 |  #{board[3]}  |  #{board[4]}  |  #{board[5]}  |
+-----+-----+-----+
 |  #{board[6]}  |  #{board[7]}  |  #{board[8]}  |
+-----+-----+-----+"
            expect(ui.draw_board).to eql(draw_board)
        end
        it 'return false because no end as the last element' do
            draw_board = "+-----+-----+-----+
 |  #{board[0]}  |  #{board[1]}  |  #{board[2]}  |
+-----+-----+-----+
 |  #{board[3]}  |  #{board[4]}  |  #{board[5]}  |
+-----+-----+-----+
 |  #{board[6]}  |  #{board[7]}  |  #{board[1]}  |
+-----+-----+-----+"
            expect(ui.draw_board.eql?(draw_board)).to be false
        end
    end
    describe '#start_game' do
        it 'checking returns for start_game method' do
            mess = "Ok, let's start the game, there are instructions\n
  1. You were randomly set to play with #{game_logic.player.symbol}\n
  2. Choose an available number from the board and try to win;\n
  3. If you wanna finish the game try: /end, /close, no, end, n\n
  4. Gool luck and have fun!\n"
            expect(ui.start_game).to eql(mess)
        end
        it 'return false because returns difference' do
            mess = "hi"
            expect(ui.start_game.eql?(mess)).to be false
        end
    end
    describe '#finish_game' do
        it 'checking returns for finish_game method' do
            mess = "Game finished, thank you for the game!\nType start if you wanna play again"
            expect(ui.finish_game).to eql(mess)
        end
        it 'return false because returns difference' do
            mess = "hi"
            expect(ui.finish_game.eql?(mess)).to be false
        end
    end
    
    
end

