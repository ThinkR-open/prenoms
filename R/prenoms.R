#' French Baby Names 1900-2015
#'
#' First name in metropolitan France between 1900 and 2015, detailed by department
#'
#' @format data frame with columns
#' \itemize{
#'   \item{\code{year}: integer, between 1900 and 2015}
#'   \item{\code{sex}: character, either M or F}
#'   \item{\code{name}: character, first name}
#'   \item{\code{n}: integer, birth count within the department for the \code{prenoms_detailed} dataset, or globally for the \code{prenoms} dataset}
#'   \item{\code{dpt}: character, department}
#'   \item{\code{prop}: numeric, proportion in that year in that department or globally }
#' }
#' @name prenoms
#' @source INSEE \url{https://www.insee.fr/fr/statistiques/2540004}
#'
#' @details
#' Data has been modified to take into account changes in France departments, see
#' \url{https://www.insee.fr/fr/statistiques/2540004#documentation} for details.
#'
#' @examples
#' library("tibble")
#' prenoms
"prenoms_detailed"

#' @name prenoms
"prenoms"
