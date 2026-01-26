-- By default, neovim will STEAL FOCUS when an error occurs.
--
-- Generally the folks in the neovim community seem to like this,
--   as your editor tooling having an error *is* something you should fix right away
--   and not procrastinate so that you can maximize productivity.
--
-- We have to enable "extui" which is currentnly experimental (2025-10-11)
--   so that we can display the messages (briefly) and not steal focus.
-- Displaying the messages is enough to let me know that there is an issue that
--   might need addressing (if it's my projects).
-- But when the project is not mine (as in when I'm contributing to someone elses
--   project and don't intend to spend more than a few minutes in the project,
--   it's useful to have the focus not be stolen).
--
-- I can still view the messages via `:messages` if I really need to.
--
-- A caveat though, is that this isn't focusable if I need it to be.
--
-- TODO: figure out a way to toggle this in some ergonomic way.
require('vim._extui').enable({
  msg = {
    target = 'msg',
    timeout = 2500
  }
})
