{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Web.Scotty

main = scotty 8080 $
  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
