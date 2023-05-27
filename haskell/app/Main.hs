{-# LANGUAGE DeriveGeneric #-}

module Main (main) where

import Web.Scotty
import Network.HTTP.Types.Status
import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))
import Control.Monad.IO.Class (liftIO)
import Cat.Model

main :: IO ()
main = scotty 8080 routes

routes :: ScottyM ()
routes = do
  get "/api/cat" $ do
    status status200
    cats <- (liftIO getCats)
    json $ Aeson.object ["cats" .= cats]

  notFound $ do
    status status404
    json $ Aeson.object ["message" .= ("API URI not found." :: String)]

-- getCats2 :: ActionM ()
-- getCats2 = do
--   status status200
--   cats <- (liftIO getCats)
--   json $ Aeson.object ["cats" .= cats]
