#' Calculate Peptide Positions on a Protein Sequence
#'
#' This function identifies the positions of peptide sequences on a given protein sequence.
#' It also assigns unique row numbers for visualization.
#'
#' @param peptide_list A data frame containing a column `Cleaned_Sequence` with peptide sequences.
#' @param sequence A string representing the protein sequence.
#' @param offset A numeric offset for row numbering.
#' @return A data frame with peptide positions and row numbers.
#' @export
calculate_positions <- function(peptide_list, sequence, offset = 0) {
  library(Biostrings)

  positions <- data.frame(
    Sequence = character(),
    Start = integer(),
    End = integer(),
    Row = integer(),
    stringsAsFactors = FALSE
  )

  for (peptide in peptide_list$Cleaned_Sequence) {
    match <- matchPattern(peptide, AAString(sequence))
    if (length(match) > 0) {
      start_pos <- start(match)
      end_pos <- end(match)
      positions <- rbind(positions, data.frame(
        Sequence = peptide,
        Start = start_pos,
        End = end_pos,
        Row = NA  # Row is temporarily empty
      ))
    }
  }

  # Sort by starting and ending sites
  positions <- positions[order(positions$Start, positions$End), ]

  # Assign a unique line number to each peptide segment
  positions$Row <- seq(offset + 1, offset + nrow(positions))

  return(positions)
}
