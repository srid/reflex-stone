module Main where

import qualified Data.Text as T
import Reflex.Dom

main :: IO ()
main =
  mainWidget $ do
    el "h1" $ text "reflex-stone"
    clicked <- stoneButton
    cnt <- foldDyn (+) (0 :: Int) $ 1 <$ clicked
    elClass "p" "result" $ do
      dyn_ $
        ffor cnt $ \case
          0 -> text "Go ahead and hit the stone."
          n -> do
            text $ T.pack (show n)
            text " heads!"
    divClass "footer" $ do
      elAttr "a" ("href" =: homePage) $
        text "View source on GitHub"
  where
    homePage = "https://github.com/srid/reflex-stone"

stoneButton :: DomBuilder t m => m (Event t ())
stoneButton = do
  let attr = ("style" =: "font-size: 200%;")
  clickEvent $ elAttr' "button" attr stone

stone :: DomBuilder t m => m ()
stone =
  text "🗿"

-- | Get the click event on an element
--
-- Use as:
--   clickEvent $ el' "a" ...
clickEvent ::
  ( DomBuilder t m,
    HasDomEvent t target 'ClickTag
  ) =>
  m (target, a) ->
  m (Event t ())
clickEvent w =
  fmap (fmap (const ()) . domEvent Click . fst) w
