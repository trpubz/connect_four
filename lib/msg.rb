module MSG
  ONEPLAYER_TWOPLAYER = "1P || 2P"
  
  WELCOME_MSG = "Let's play **** CONNECT FOUR ****
  Connect four of your checkers in a row while preventing your opponent from doing the same.\n
  press 'p' to play; 'q' to quit:"

  PLAY_MSG = "#{ENV["USER"]} says we're playing Connect Four!!"

  BYE_MSG = "I hate goodbyes, #{ENV["USER"]}!! I hope you'll play Connect Four with me again soon!"

  MP_BYE_MSG = "If you want to play again, rerun the script. Goodbye!"

  P_OR_Q_ERR_MSG = "Sorry, I didn't understand that selection. press 'p' to play; 'q' to quit:"

  PLAYER_TURN_MSG = "Choose where you want to drop your token"

  TIE_GAME_MSG = "The board is full!! It's a draw!"

  WAITING_MSG = "Waiting for opponent to join"

  OPP_FOUND = "Opponent found...establishing connection"

  def TIMES_UP_MSG(column)
    "Time's up: you randomly chose column #{column}"
  end
  def WAITING_FOR_PLYR_MSG(plyr_name)
    "Waiting for #{plyr_name} to make a move"
  end

  def LOADER_MSG(i)
    i.times do
      sleep 1.6
      print " . "
    end
    puts ""
  end

  def VICTORY_MSG(plyr_name)
    if plyr_name == "HAL"
      "HAL won!! You just lost to an unliving being!! Boom!!"
    else
      "#Hot Dog, we have a Winner! Congratulations #{plyr_name}!!!"
    end
  end

  def INPUT_ERR_MSG(input)
    "#{input} is an invalid selection"
  end

  # X_OR_O_MSG = "Pick your piece! X or O??"
end
