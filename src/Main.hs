{-# LANGUAGE OverloadedStrings #-}

import Reflex.Dom

main :: IO ()
main =
  mainWidget $ do
    el "h1" $ text "reflex-stone"
    el "div" $ do
      t <- inputElement def
      dynText $ _inputElement_value t
