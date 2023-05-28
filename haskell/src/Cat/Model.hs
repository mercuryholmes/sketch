module Cat.Model (getCats, getCatById, insertCat, updateCat, deleteCat) where

import Cat.Types
import qualified Config as Config
import Database.PostgreSQL.Simple
import Data.Text
import Data.Int (Int64)

getCats :: IO [Cat]
getCats = do
  result <- queryExec "SELECT * FROM cats" :: IO [Cat]
  return result

getCatById :: Int -> IO [Cat]
getCatById _id = do
  result <- queryExecParam "SELECT * FROM cats WHERE id = ?" (Only _id) :: IO [Cat]
  return result

insertCat :: Text -> Maybe Text -> Maybe Text -> IO [Cat]
insertCat name breed description = do
  result <- queryExecParam "INSERT INTO cats (name, breed, description) VALUES (?, ?, ?) RETURNING *" (name, breed, description) :: IO [Cat]
  return result

updateCat :: Int -> Text -> Maybe Text -> Maybe Text -> IO [Cat]
updateCat _id name breed description = do
  result <- queryExecParam "UPDATE cats SET name = ?, breed = ?, description = ? WHERE id = ? RETURNING *" (name, breed, description, _id) :: IO [Cat]
  return result

deleteCat :: Int -> IO Int64
deleteCat _id = do
  result <- executeQuery "DELETE FROM cats WHERE id = ?" (Only _id)
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

executeQuery :: ToRow q => Query -> q -> IO Int64
executeQuery queryString q = do
  conn <- connect Config.database
  result <- execute conn queryString q
  close conn
  return result
