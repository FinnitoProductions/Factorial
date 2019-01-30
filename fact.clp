(batch util/utilities.clp)

/* 
* Finn Frankis
* January 24, 2019
*
* Includes functionality for finding the factorial of a number using user input with input validation.
*
* fact - determines the factorial of a whole number
* isWholeNumber - determines whether an input is a whole number; if so, it will return the number as a long, otherwise FALSE
* askFact - requests for user input and returns the factorial of that input; if invalid, will prompt again
*/

(bind ?FACTORIAL_OF_ZERO 1)
(bind ?FACTORIAL_BASE_INPUT 0)

(bind ?FACTORIAL_METHOD_NAME "fact")
(bind ?INVALID_INPUT_ERROR_MESSAGE "The input must be a whole number >= 0. Please try again.")

(bind ?FACTORIAL_REQUEST_MESSAGE "Enter the number of which you would like to determine the factorial: ")

/*
* Returns the factorial of a given value ?n. For an acceptable output,
* ?n should be a nonnegative integer value.
*/
(deffunction fact (?n)
   (if (not (= ?n ?FACTORIAL_BASE_INPUT)) then (bind ?returnVal (* ?n (fact (-- ?n)))) ; recursive call
    else (bind ?returnVal ?FACTORIAL_OF_ZERO) ; in the base case, the factorial of zero will be returned 
   )

   (return ?returnVal)
) ; fact (?n) 

/*
* Determines whether a given parameter ?n (of any acceptable type) is a whole number. 
* If it is not, it will return FALSE; otherwise, it will return the initial number casted to a long.
*/
(deffunction isWholeNumber (?n)
   (bind ?isValidInput (and (numberp ?n) (>= ?n 0) (= (integer ?n) ?n))) ; must be a positive number without fractional part
   (bind ?isLong (longp ?n))

   (if (and ?isValidInput ?isLong) then (bind ?returnVal ?n)             ; if ?n is valid and already a long, do not cast 
    elif ?isValidInput then (bind ?returnVal (long ?n))                  ; if ?n is not already a long but still valid, cast
    else (bind ?returnVal FALSE)                                         ; if ?n is not a whole number, return false
   )                                                                     

   (return ?returnVal) 
) ; isWholeNumber (?n)

/*
* Asks the user to input a number, returning the factorial of that input.
* The user should input a whole number; otherwise, the user will be prompted for another value.
*/
(deffunction askFact ()
   (bind ?userInput (ask ?FACTORIAL_REQUEST_MESSAGE))
   (bind ?validatedInput (isWholeNumber ?userInput)) ; FALSE if invalid input, ?n casted to a long if valid input

   (if (eq ?validatedInput FALSE) then (printline ?INVALID_INPUT_ERROR_MESSAGE) (bind ?returnVal (askFact))
    else (bind ?returnVal (fact ?validatedInput))
   )

   (return ?returnVal)
) ; askFact () 

(printline (askFact))