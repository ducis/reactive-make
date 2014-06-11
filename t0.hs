{-# LANGUAGE LambdaCase #-}
import System.INotify
import Control.Monad
import Control.Concurrent
import GHC.IO.Handle
import GHC.IO.Handle.FD
import Data.List

main = withINotify $ \inot->do
	let a = addWatch inot
	--a [Modify] "testsbj" $ \x@(Modified False (Just "testsbj")) -> print x
	--a [AllEvents] "testsbj" $ \x -> print x >> hFlush stdout
	let persistentWatch path f = 
		a [Modify, DeleteSelf, MoveSelf] path $ \x ->
			if x `elem` [DeletedSelf, MovedSelf False] 
			then void $ print 1 >> persistentWatch path f  
			else f x
	persistentWatch "testsbj" print
	let f = threadDelay 1000000 >> f
	f

