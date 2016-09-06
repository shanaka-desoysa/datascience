## Creates an object which can store a matrix and inverse of the matrix.

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function()
        x
    setsolve <- function(solve)
        m <<- solve
    getsolve <- function()
        m
    list(
        set = set,
        get = get,
        setsolve = setsolve,
        getsolve = getsolve
    )
}


## Get the cached matrix inverse if already computed.
## Otherwise solve the matrix and cache for later retrieval.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getsolve()
    if (!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setsolve(m)
    m
}
