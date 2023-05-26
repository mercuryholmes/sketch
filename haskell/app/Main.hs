{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main (main) where

import Web.Scotty
import Network.HTTP.Types.Status
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)
import qualified Data.Text as T

data Error = Error { message :: T.Text } deriving (Generic, Show)
instance ToJSON Error

main :: IO ()
main = scotty 8080 routes

routes :: ScottyM ()
routes = do
  get "/api/users" $ do
    status status200
    html $ mconcat ["<h1>Scotty API</h1>"]
  notFound $ do
    status status404
    json Error {message = "API URI not found."}
