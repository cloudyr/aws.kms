#' @title Generate Random Blob
#' @description Generate a random byte string
#' @param bytes An integer specifying a number of bytes between 1 and 1024.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @return A base64-encoded character string.
#' @details \code{create_kms_alias} creates an alias for KMS key, which can be used in place of the KeyId or ARN. A given key can have multiple aliases. \code{delete_kms_alias} deletes an named alias. \code{update_kms_alias} reassigns an alias to a new key.
#' @examples
#' \dontrun{
#'   b <- generate_blob()
#'   if (require("base64enc")) {
#'      base64enc::base64decode(b)
#'   }
#' }
#' @seealso \code{\link{create_kms_key}}, \code{\link{encrypt}}
#' @export
generate_blob <-
function(
  bytes = 1,
  ...
) {
    stopifnot(bytes > 1 && bytes < 1024)
    bod <- list(NumberOfBytes = bytes)
    out <- kmsHTTP(action = "GenerateRandom", body = bod, ...)
    return(out$Plaintext)
}
