/* 
* Finn Frankis
* January 24, 2019
*
* Includes functionality for finding the factorial of a number using user input with input validation.
*
* fact - determines the factorial of a whole number
* isWholeNumber - determines whether an input is a whole number; if so, it will return the number as a long, otherwise FALSE
* askFact - requests for user input and returns the factorial of that input
*/

(batch util/utilities.clp)

(import jess.JessException)

(bind ?FACTORIAL_OF_ZERO 1)
(bind ?FACTORIAL_BASE_INPUT 0)

(bind ?FACTORIAL_METHOD_NAME "fact")
(bind ?INVALID_INPUT_ERROR_MESSAGE "The input must be a whole number >=")
(bind ?INVALID_INPUT_EXCEPTION (new JessException ?FACTORIAL_METHOD_NAME ?INVALID_INPUT_ERROR_MESSAGE ?FACTORIAL_BASE_INPUT))

(bind ?FACTORIAL_REQUEST_MESSAGE "Enter the number of which you would like to determine the factorial: ")

/*
* Returns the factorial of a given nonnegative integer ?n;
* throws a JessException if the input does not meet this requirement.
*/
(deffunction fact (?n)
   (bind ?returnVal ?FACTORIAL_OF_ZERO) ; in the base case, the factorial of zero will be returned 
   (bind ?castedN (isWholeNumber ?n))   ; FALSE if invalid input, ?n casted to a long if valid input

   (if (eq ?castedN FALSE) then (throw ?INVALID_INPUT_EXCEPTION)
    elif (not (= ?castedN ?FACTORIAL_BASE_INPUT)) then (bind ?returnVal (* ?castedN (fact (-- ?castedN)))) ; recursive call
   )

   (return ?returnVal)
) ; fact (?n) 

/*
* Determines whether a given parameter ?n (of any acceptable type) is a whole number. 
* If it is not, it will return FALSE; otherwise, it will return the initial number casted to a long.
*/
(deffunction isWholeNumber (?n)
   (bind ?returnVal FALSE)                                               ; if ?n is not a whole number, return false by default
   (bind ?isValidInput (and (numberp ?n) (>= ?n 0) (= (integer ?n) ?n))) ; must be a positive number without fractional part
   (bind ?isLong (longp ?n))

   (if (and ?isValidInput ?isLong) then (bind ?returnVal ?n)             ; if ?n is valid and already a long, do not cast 
    elif ?isValidInput then (bind ?returnVal (long ?n))                  ; if ?n is not already a long but still valid, cast
   )                                                                     

   (return ?returnVal) 
) ; isWholeNumber (?n)

/*
* Asks the user to input a number, returning the factorial of that input.
* The user should input a whole number; otherwise, a JessException will be thrown.
*/
(deffunction askFact ()
   (return (fact (ask ?FACTORIAL_REQUEST_MESSAGE)))
) ; askFact () 

(printline (askFact))