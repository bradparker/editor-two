{-# LANGUAGE OverloadedStrings #-}

module Main where

import Rasa (rasa)
import Rasa.Ext (afterInit, addBuffer)
import Rasa.Ext.Cursors (cursors)
import Rasa.Ext.Slate (slate)
import Rasa.Ext.Views (viewports)
import Rasa.Ext.Vim (vim)

main :: IO ()
main =
  rasa $ do
    viewports
    vim
    cursors
    slate
    afterInit $
      addBuffer
        "This is a buffer to get you started!\nYou can also pass command line args to rasa"
