module Main (main) where

import Web.Scotty
import Network.HTTP.Types.Status
import qualified Data.Text as T
import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))
import Control.Monad.IO.Class
import Control.Monad.Except
import Common.HTTP
import Cat.Model
import Cat.Types

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
    result <- liftIO $ runExceptT $ validateCatExists _id
    case result of
      Left err -> do
        catErrorHandler err
      Right _ -> do
        cat <- (liftIO $ getCatById _id)
        status status200
        json $ head cat

  post "/api/cat" $ do
    (CreateCat _name _breed _description) <- jsonData `rescue` parseJSONErrorHandler
    result <- liftIO $ runExceptT $ checkNewCatByName _name
    case result of
      Left err -> do
        catErrorHandler err
      Right _ -> do
        cat <- (liftIO $ insertCat _name _breed _description)
        status status201
        json $ head cat

  put "/api/cat/:id" $ do
    _id <- param "id"
    (UpdateCat _name _breed _description) <- jsonData `rescue` parseJSONErrorHandler
    result <- liftIO $ runExceptT $ do
      (validateCatExists _id)
      (checkExistingCatByName _id _name)
    case result of
      Left err -> do
        catErrorHandler err
      Right _ -> do
        cat <- (liftIO $ updateCat _id _name _breed _description)
        status status200
        json $ head cat

  delete "/api/cat/:id" $ do
    _id <- param "id"
    result <- liftIO $ runExceptT $ validateCatExists _id
    case result of
      Left err -> do
        catErrorHandler err
      Right _ -> do
        liftIO $ deleteCat _id
        status status200
        json $ Aeson.object ["message" .= ("success delete" :: String)]

  notFound $ do
    status status404
    json $ Aeson.object ["message" .= ("API URI not found." :: String)]

catErrorHandler :: CatError -> ActionM ()
catErrorHandler err = case err of
  CatErrorNotFound -> do
    status status404
    json $ Aeson.object ["message" .= ("cat not found." :: String)]
  CatErrorNameDuplicate -> do
    status status400
    json $ Aeson.object ["message" .= ("cat name duplicated." :: String)]

validateCatExists :: Int -> ExceptT CatError IO ()
validateCatExists _id = do
  result <- liftIO $ catExists _id
  unless result $ throwError (CatErrorNotFound)

checkNewCatByName :: T.Text -> ExceptT CatError IO ()
checkNewCatByName _name = do
  result <- liftIO $ getCatByName _name
  case result of
    [] -> return ()  
    _  -> throwError CatErrorNameDuplicate

checkExistingCatByName :: Int -> T.Text -> ExceptT CatError IO ()
checkExistingCatByName _id _name = do
  result <- liftIO $ queryExecParam "SELECT * FROM cats WHERE name = ? AND id != ?" (_name, _id) :: ExceptT CatError IO [Cat]
  case result of
    [] -> return ()
    _  -> throwError CatErrorNameDuplicate
