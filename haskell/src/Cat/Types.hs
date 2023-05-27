module Cat.Types (Cat) where

import Data.Aeson
import Database.PostgreSQL.Simple.FromRow
import Data.Text
import GHC.Generics (Generic)

data Cat = Cat
  {
    _id :: Int,
    name  :: Text,
    breed :: Text,
    description :: Text
  } deriving (Generic, Show)

instance ToJSON Cat where
  toJSON (Cat _id name breed description) =
    object
      [
        "id" .= _id,
        "name" .= name,
        "breed" .= breed,
        "description" .= description
      ]

instance FromRow Cat where
  fromRow = Cat
    <$> field
    <*> field
    <*> field
    <*> field
