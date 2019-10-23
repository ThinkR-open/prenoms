#' French Baby Names 1900-2018
#'
#' French baby names between 1900 and 2018, detailed by department
#'
#' @format data frame with columns
#' \itemize{
#'   \item{\code{year}: integer, between 1900 and 2018}
#'   \item{\code{sex}: character, either M or F}
#'   \item{\code{name}: character, first name}
#'   \item{\code{n}: integer, birth count within the department}
#'   \item{\code{dpt}: character, department}
#'   \item{\code{prop}: numeric, proportion in that year in that department}
#' }
#' @name prenoms
#' @source INSEE \url{https://www.insee.fr/fr/statistiques/2540004}
#'
#' @details
#' Data has been modified to take into account changes in France departments, see
#' \url{https://www.insee.fr/fr/statistiques/2540004#documentation} for details.
#'
#' @examples
#' \dontrun{
#'   library("dplyr")
#'   library("ggplot2")
#'
#'   # first names of ThinkR's staff aggregated at country level
#'   thinkrs <- prenoms %>%
#'     filter(
#'         name == "Diane"   & sex == "F" |
#'         name == "Sébastien"  & sex == "M" |
#'         name == "Colin"  & sex == "M" |
#'         name == "Cervan"  & sex == "M" |
#'         name == "Vincent" & sex == "M"
#'     ) %>%
#'     group_by(name, year, sex) %>%
#'     summarise( n = sum(n) ) %>%
#'     arrange( year )
#'
#'   # quick ggplot representation
#'   ggplot( thinkrs, aes(x = year, y = n, color = name) ) +
#'     geom_line() +
#'     scale_x_continuous( breaks = seq(1900, 2020, by = 10) )
#' }
#'
#' @name prenoms
"prenoms"

#' Departements
#'
#' @source https://www.data.gouv.fr/fr/datasets/contours-des-departements-francais-issus-d-openstreetmap/
"departements"


#' French Baby Names 1900-2018
#'
#' French baby names between 1900 and 2018, at national level
#'
#' @format data frame with columns
#' \itemize{
#'   \item{\code{year}: integer, between 1900 and 2018}
#'   \item{\code{sex}: character, either M or F}
#'   \item{\code{name}: character, first name}
#'   \item{\code{n}: integer, birth count within the department}
#'   \item{\code{prop}: numeric, proportion in that year}
#' }
#' @name prenoms_france
#' @source INSEE \url{https://www.insee.fr/fr/statistiques/2540004}
#'
#' @details
#' Data has been modified to take into account changes in France departments, see
#' \url{https://www.insee.fr/fr/statistiques/2540004#documentation} for details.
#'
#' @examples
#' \dontrun{
#'   library("dplyr")
#'   library("ggplot2")
#'
#'   # first names of ThinkR's staff aggregated at country level
#'   thinkrs <- prenoms_france %>%
#'     filter(
#'         name == "Diane"   & sex == "F" |
#'         name == "Sébastien"  & sex == "M" |
#'         name == "Colin"  & sex == "M" |
#'         name == "Cervan"  & sex == "M" |
#'         name == "Vincent" & sex == "M"
#'     ) %>%
#'     group_by(name, year, sex) %>%
#'     summarise( n = sum(n) ) %>%
#'     arrange( year )
#'
#'   # quick ggplot representation
#'   ggplot( thinkrs, aes(x = year, y = n, color = name) ) +
#'     geom_line() +
#'     scale_x_continuous( breaks = seq(1900, 2020, by = 10) )
#' }
#'
#' @name prenoms_france
"prenoms_france"
