{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main (main) where

import Server (app)

import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.JSON (json)

main :: IO ()
main = hspec spec

spec :: Spec
spec = with (return app) $ do
    describe "GET /users" $ do
        it "responds with 200" $ do
            get "/users" `shouldRespondWith` 200
        it "responds with [User]" $ do
            let users = [json|
  [
    {
      "userId": 1,
      "userFirstName":"Isaac",
      "userLastName":"Newton"
    },
    {
      "userId": 2,
      "userFirstName": "Albert",
      "userLastName": "Einstein"
    },
    {
      "userId": 3,
      "userFirstName": "Fred",
      "userLastName": "Flintstone"
    }
  ]
|]
            get "/users" `shouldRespondWith` users
