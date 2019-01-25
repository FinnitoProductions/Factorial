/* 
* Finn Frankis
* January 24, 2019
*
* Includes several useful functions for finding the factorial of a typecasted number using user input.
*
* fact - determines the factorial of a number
*/

(batch util/utilities.clp)

(bind ?FACTORIAL_OF_ZERO 1)

/*
* Determines the factorial of a given nonnegative integer.
*/
(deffunction fact (?n)
   (bind ?returnVal ?FACTORIAL_OF_ZERO)

   (if (not (isPositiveInteger ?n)) then (bind ?returnVal "The factorial function must take in a positive integer.")
    else (if (not (= ?n 0)) then (bind ?returnVal (* ?n (fact (- ?n 1))))
         )
   )

   (return ?returnVal)
)

/*
* Determines whether a number is a positive integer.
*/
(deffunction isPositiveInteger (?n)
   (return (and (numberp (+ ?n 0)) (> ?n 0) (= integer(?n) ?n)))
)

(printline (fact (askline "Enter the number of which you'd like to determine the factorial: ")))