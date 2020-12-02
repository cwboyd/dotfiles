require 'irb/ext/save-history'
require 'irb/completion'

IRB.conf[:SAVE_HISTORY] = 200

# Workaround for https://github.com/microsoft/terminal/issues/2520
{
  "\000H" => :rl_get_previous_history, # Up
  "\000P" => :rl_get_next_history, # Down
  "\000M" => :rl_forward_char,  # Right
  "\000K" => :rl_backward_char, # Left
  "\000G" => :rl_beg_of_line,   # Home
  "\000O" => :rl_end_of_line,   # End
  "\000s" => :rl_backward_word, # Ctrl-Left
  "\000t" => :rl_forward_word, # Ctrl-Right
  "\000S" => :rl_delete, # Delete
  "\000R" => :rl_overwrite_mode # Insert
}.each do |keyseq, method|
  RbReadline.rl_bind_keyseq_if_unbound(keyseq, method)
end
