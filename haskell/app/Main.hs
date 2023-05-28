module Main (main) where

import Web.Scotty
import Network.HTTP.Types.Status
import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))
import Control.Monad.IO.Class
import Cat.Model
import Cat.Types
-- import Control.Monad.Except

main :: IO ()
main = scotty 8080 routes

routes :: ScottyM ()
routes = do

  get "/api/cat" $ do
    status status200
    cats <- (liftIO getCats)
    json $ Aeson.object ["cats" .= cats]

  get "/api/cat/:id" $ do
    _id <- param "id"
    cat <- (liftIO $ getCatById _id)
    case cat of
      [] -> do
        status status404
        json $ Aeson.object ["message" .= ("Cat not found" :: String)]
      _ -> do
        status status200
        json $ head cat

  post "/api/cat" $ do
    (CreateCat _name _breed _description) <- jsonData
    cat <- (liftIO $ insertCat _name _breed _description)
    case cat of
      [] -> do
        status status400
        json $ Aeson.object ["message" .= ("failed to create" :: String)]
      _ -> do
        status status201
        json $ head cat

  put "/api/cat/:id" $ do
    _id <- param "id"
    result <- (liftIO $ catExists _id)
    if not result then do
        status status404
        json $ Aeson.object ["message" .= ("cat not found" :: String)]
    else do
      (UpdateCat _name _breed _description) <- jsonData
      cat <- (liftIO $ updateCat _id _name _breed _description)
      case cat of
        [] -> do
          status status400
          json $ Aeson.object ["message" .= ("failed to update" :: String)]
        _ -> do
          status status200
          json $ head cat

  delete "/api/cat/:id" $ do
    _id <- param "id"
    result <- (liftIO $ catExists _id)
    if not result then do
        status status404
        json $ Aeson.object ["message" .= ("cat not found" :: String)]
    else do
      _ <- liftIO $ deleteCat _id
      status status200
      json $ Aeson.object ["message" .= ("success delete" :: String)]

  notFound $ do
    status status404
    json $ Aeson.object ["message" .= ("API URI not found." :: String)]

-- validateCatExists :: Int -> ExceptT CatError IO ()
-- validateCatExists _id = do
--   result <- liftIO $ catExists _id
--   unless result $ throwError CatErrorNotFound
