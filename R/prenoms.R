#' French Baby Names 1900-2015
#'
#' First name in metropolitan France between 1900 and 2015, detailed by department
#'
#' @format data frame with columns
#' \itemize{
#'   \item{year}{integer, between 1900 and 2015}
#'   \item{sex}{character, either M or F}
#'   \item{name}{character, first name}
#'   \item{n}{integer, birth count within the department}
#'   \item{dpt}{character, department}
#'   \item{prop}{numeric, proportion in that year in that department}
#' }
#' @source INSEE \url{http://www.data.gouv.fr/fr/datasets/fichier-des-prenoms-edition-2016/}
"prenoms_detailed"

#' French Baby Names 1900-2015
#'
#' First name in metropolitan France between 1900 and 2015.
#'
#' @format data frame with columns
#' \itemize{
#'   \item{year}{integer, between 1900 and 2015}
#'   \item{sex}{character, either M or F}
#'   \item{name}{character, first name}
#'   \item{n}{integer, birth count that year}
#'   \item{prop}{numeric, proportion in that year}
#' }
#' @source INSEE \url{http://www.data.gouv.fr/fr/datasets/fichier-des-prenoms-edition-2016/}
"prenoms"
