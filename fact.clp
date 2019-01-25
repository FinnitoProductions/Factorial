/* 
* Finn Frankis
* January 24, 2019
*
* Includes functionality for finding the factorial of a number using user input with input validation.
*
* fact - determines the factorial of a number
* isWholeNumber - determines whether a number is a whole number; if so, will cast the number to a long
*/

(batch util/utilities.clp)

(bind ?FACTORIAL_OF_ZERO 1)

/*
* Determines the factorial of a given nonnegative integer; returns a warning string if the input is invalid.
*/
(deffunction fact (?n)
   (bind ?returnVal ?FACTORIAL_OF_ZERO)
   (bind ?castedN (isWholeNumber ?n))

   (if (eq ?castedN FALSE) then (bind ?returnVal "The factorial function must take in a whole number.")
    else (if (not (= ?castedN 0)) then (bind ?returnVal (* ?castedN (fact (- ?n 1))))
         )
   )

   (return ?returnVal)
)

/*
* Determines whether a given parameter is a whole number. If it is not, will return false; otherwise,
* will return the initial number casted to a long.
*/
(deffunction isWholeNumber (?n)
   (bind ?returnVal FALSE)

   (if (and (numberp ?n) (>= ?n 0) (= (integer ?n) ?n)) then (bind ?returnVal (long ?n))
   )

   (return ?returnVal) ; if ?n is not a whole number, false will be returned; if valid, the ?n will be casted to a long and returned
)

(printline (fact (ask "Enter the number of which you'd like to determine the factorial: ")))