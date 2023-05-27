module Common.Types (ErrorMessage(..))where

import Data.Aeson
import Data.Text
import GHC.Generics (Generic)

data ErrorMessage = ErrorMessage
  {
    message :: Text
  } deriving (Generic, Show)

instance ToJSON ErrorMessage
