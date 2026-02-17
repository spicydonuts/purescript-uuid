module Data.UUID
  ( UUID
  , emptyUUID
  , maxUUID
  , genUUID
  , genUUIDv7
  , parseUUID
  , uuidVersion
  , genv3UUID
  , genv5UUID
  , toString
  ) where

import Prelude

import Data.Maybe (Maybe(Nothing, Just))
import Effect (Effect)

newtype UUID = UUID String

derive instance Eq UUID
derive instance Ord UUID

instance Show UUID where
  show (UUID uuid) = "(UUID " <> uuid <> ")"

emptyUUID :: UUID
emptyUUID = UUID "00000000-0000-0000-0000-000000000000"

maxUUID :: UUID
maxUUID = UUID "ffffffff-ffff-ffff-ffff-ffffffffffff"

foreign import getUUIDImpl :: Effect String

genUUID :: Effect UUID
genUUID = getUUIDImpl >>= pure <<< UUID

foreign import getUUIDv7Impl :: Effect String

genUUIDv7 :: Effect UUID
genUUIDv7 = getUUIDv7Impl >>= pure <<< UUID

foreign import validateUUID :: String -> Boolean

parseUUID :: String -> Maybe UUID
parseUUID str = case validateUUID str of
  true -> Just (UUID str)
  _ -> Nothing

foreign import uuidVersionImpl :: String -> Int

uuidVersion :: UUID -> Int
uuidVersion (UUID s) = uuidVersionImpl s

foreign import getUUID3Impl :: String -> String -> String

genv3UUID :: String -> UUID -> UUID
genv3UUID s (UUID n) = UUID (getUUID3Impl s n)

foreign import getUUID5Impl :: String -> String -> String

genv5UUID :: String -> UUID -> UUID
genv5UUID s (UUID n) = UUID (getUUID5Impl s n)

toString :: UUID -> String
toString (UUID uuid) = uuid
