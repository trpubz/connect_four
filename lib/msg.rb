module MSG
  WELCOME_MSG = "Let's play **** CONNECT FOUR ****
  Connect four of your checkers in a row while preventing your opponent from doing the same.\n
  press 'p' to play; 'q' to quit:"

  PLAY_MSG = "#{ENV["USER"]} says we're playing Connect Four!!"

  BYE_MSG = "I hate goodbyes, #{ENV["USER"]}!! I hope you'll play Connect Four with me again soon!"

  P_OR_Q_ERR_MSG = "Sorry, I didn't understand that selection. press 'p' to play; 'q' to quit:"

  PLAYER_TURN_MSG = "Choose where you want to drop your token"

  TIE_GAME_MSG = "The board is full!! It's a draw!"

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
