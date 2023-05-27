{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main (main) where

import Web.Scotty
import Network.HTTP.Types.Status
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Data.Aeson (FromJSON, ToJSON)
import Data.Maybe
import GHC.Generics (Generic)
import qualified Data.Text as T

database :: ConnectInfo
database = defaultConnectInfo
           { connectHost = "postgres"
           , connectDatabase = "sketch"
           , connectUser = "postgres"
           , connectPassword = "postgres"
           }

data Error = Error { message :: T.Text } deriving (Generic, Show)
instance ToJSON Error

data Cat = Cat {
  _id :: Int,
  name  :: T.Text,
  breed :: T.Text,
  description :: T.Text
} deriving (Generic, Show)

instance FromRow Cat where
  fromRow = Cat <$> field <*> field <*> field <*> field

main :: IO ()
main = scotty 8080 routes

routes :: ScottyM ()
routes = do
  get "/api/cat" $ do
    status status200
    html $ mconcat ["<h1>Scotty API</h1>"]
  notFound $ do
    status status404
    json Error {message = "API URI not found."}


queryExec :: FromRow a => Query -> IO [a]
queryExec queryString = do
  conn <- connect database
  result <- query_ conn queryString
  close conn
  return result

queryExecParam :: (FromRow a, ToRow q) => Query -> q -> IO[a]
queryExecParam queryString q = do
  conn <- connect database
  result <- query conn queryString q
  close conn
  return result

getCats :: IO [Cat]
getCats = do
  result <- queryExec "SELECT * FROM cats" :: IO [Cat]
  return result
