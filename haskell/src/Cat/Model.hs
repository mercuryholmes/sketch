module Cat.Model (getCats) where

import Cat.Types
import qualified Config as Config
import Database.PostgreSQL.Simple

getCats :: IO [Cat]
getCats = do
  result <- queryExec "SELECT * FROM cats" :: IO [Cat]
  return result

queryExec :: FromRow a => Query -> IO [a]
queryExec queryString = do
  conn <- connect Config.database
  result <- query_ conn queryString
  close conn
  return result

queryExecParam :: (FromRow a, ToRow q) => Query -> q -> IO[a]
queryExecParam queryString q = do
  conn <- connect Config.database
  result <- query conn queryString q
  close conn
  return result
