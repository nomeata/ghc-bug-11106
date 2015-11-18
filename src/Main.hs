{-# LANGUAGE DeriveDataTypeable, FlexibleContexts, FlexibleInstances, FunctionalDependencies,
             ImpredicativeTypes, MultiParamTypeClasses, ScopedTypeVariables, TemplateHaskell, TypeFamilies,
             UndecidableInstances #-}
{-# OPTIONS_GHC -Wall #-}
module Main
    ( main
    ) where

import Report ( ReportElemID(ReportElemID))
import ListLens (Report(Report), ReportElem(ReportUndecided), reportBody, ReportMap)
import qualified Data.Map as Map
import Order hiding (order)
import ListLens (listReorder)

-- Main creates a value of type ReportMap with one element, and then
-- tries to reorder a list inside that element using listReorder.
main :: IO ()
main = (`seq` return ()) $ listReorder order reportMap'
    where
      order :: [ReportElemID]
      order = [ReportElemID 1]

      report :: Report
      report =
          Report {reportBody = fst (Order.insert ReportUndecided Order.empty)
                 }

      reportMap' :: ReportMap
      reportMap' = Map.fromList [((), report)]
