module Common.HTTP (module Common.HTTP) where

import Web.Scotty.Trans
import Network.HTTP.Types.Status
import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))

parseJSONErrorHandler :: (ScottyError e, Monad m) => err -> ActionT e m a
parseJSONErrorHandler _ = do
  status status400
  json $ Aeson.object ["message" .= ("invalid json" :: String)]
  finish
