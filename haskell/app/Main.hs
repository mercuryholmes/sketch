{-# LANGUAGE DeriveGeneric #-}

module Main (main) where

import Web.Scotty
import Network.HTTP.Types.Status
import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))
import Control.Monad.IO.Class (liftIO)
import Common.Types
import Cat.Model

main :: IO ()
main = scotty 8080 routes

routes :: ScottyM ()
routes = do
  get "/api/cat" $ getCats2
  notFound $ do
    status status404
    json ErrorMessage {message = "API URI not found."}

getCats2 :: ActionM ()
getCats2 = do
  status status200
  cats <- (liftIO getCats)
  json $ Aeson.object ["cats" .= cats]
