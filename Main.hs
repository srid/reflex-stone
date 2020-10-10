{-# LANGUAGE OverloadedStrings #-}

import Reflex.Dom

main :: IO ()
main = mainWidget $
  el "div" $ do
    t <- inputElement def
    dynText $ _inputElement_value t
