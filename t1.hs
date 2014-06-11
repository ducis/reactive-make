{-# LANGUAGE LambdaCase,ViewPatterns #-}
import System.INotify
import Control.Monad
import Control.Concurrent
import GHC.IO.Handle
import GHC.IO.Handle.FD
import Data.List

main = withINotify $ \inot->do
	let a = addWatch inot
	--a [AllEvents] "." $ \(show->x)-> when ("testsbj\"" `isInfixOf` x) (putStrLn x)
	a [AllEvents] "." $ print
	let f = threadDelay 100000000000 >> f
	f

