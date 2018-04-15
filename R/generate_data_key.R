#' @rdname data_keys
#' @title Generate data keys
#' @description Generate data keys for local encryption
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param spec A character string specifying the length of the data encryption key, either \dQuote{AES_256} or \dQuote{AES_128}.
#' @param plaintext A logical indicating whether to return the data key in plain text, as well as in encrypted form.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @return \code{encrypt} returns a base64-encoded binary object as a character string.
#' @details This function generates and returns a \dQuote{data key} for use in local encrption. The suggested workflow from AWS is to encrypt, do the following:
#'  
#'  \enumerate{
#'    \item Use this operation (\code{generate_data_key}) to get a data encryption key.
#'    \item Use the plaintext data encryption key (returned in the Plaintext field of the response) to encrypt data locally, then erase the plaintext data key from memory.
#'    \item Store the encrypted data key (returned in the CiphertextBlob field of the response) alongside the locally encrypted data.
#'  }
#' 
#' Then to decrypt locally:
#'   
#'   \enumerate{
#'     \item Use \code{\link{decrypt}} to decrypt the encrypted data key into a plaintext copy of the data key.
#'     \item Use the plaintext data key to decrypt data locally, then erase the plaintext data key from memory.
#'   }
#' 
#' @references
#' \url{https://docs.aws.amazon.com/kms/latest/APIReference/API_GenerateDataKey.html}
#' @examples
#' \dontrun{
#'   # create a (CMK) key
#'   k <- create_kms_key()
#'   
#'   # generate a data key for local encryption
#'   datakey <- generate_data_key(key = k)
#'   
#'   ## encrypt something locally using datakey$Plaintext
#'   ## then delete the plaintext key
#'   datakey$Plaintext <- NULL
#'   
#'   # decrypt the encrypted data key
#'   datakey$Plaintext <- decrypt(datakey$CiphertextBlob, k, encode = FALSE)
#'   ## then use this to decrypt locally
#'   
#'   # cleanup
#'   delete_kms_key(k)
#' }
#' @seealso \code{\link{create_kms_key}}, \code{\link{generate_blob}}
#' @importFrom base64enc base64encode
#' @export
generate_data_key <-
function(
  key,
  spec = c("AES_256", "AES_128"),
  plaintext = TRUE,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key),
                KeySpec = match.arg(spec))
    if (isTRUE(plaintext)) {
        out <- kmsHTTP(action = "GenerateDataKey", body = bod, ...)
    } else {
        out <- kmsHTTP(action = "GenerateDataKeyWithoutPlaintext", body = bod, ...)
    }
    return(out)
}
