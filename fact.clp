/* 
* Finn Frankis
* January 24, 2019
*
* Includes functionality for finding the factorial of a number using user input with input validation.
*
* fact - determines the factorial of a number
* isWholeNumber - determines whether a number is a positive
*/

(batch util/utilities.clp)

(bind ?FACTORIAL_OF_ZERO 1)

/*
* Determines the factorial of a given nonnegative integer.
*/
(deffunction fact (?n)
   (bind ?returnVal ?FACTORIAL_OF_ZERO)

   (if (not (isWholeNumber ?n)) then (bind ?returnVal "The factorial function must take in a positive integer.")
    else (if (not (= ?n 0)) then (bind ?returnVal (* ?n (fact (- ?n 1))))
         )
   )

   (return ?returnVal)
)

/*
* Determines whether a given parameter is a whole number.
*/
(deffunction isWholeNumber (?n)
   (return (and (numberp ?n) (>= ?n 0) (= (integer ?n) ?n)))
)

(printline (fact (ask "Enter the number of which you'd like to determine the factorial: ")))